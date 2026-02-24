<!---
    MailUndeliverRequeue.cfm

    Purpose:
    - Scan ColdFusion mail Undeliver folder
    - Move stuck mail files back to Spool for resend

    Recommended use:
    - Configure as a scheduled task in ColdFusion Administrator
      URL example:
      http://<server>/ClientService/ContingentLiabilities/V1.0/MailUndeliverRequeue.cfm

    Optional URL parameters:
    - undeliverPath   (default: C:\ColdFusion2021\cfusion\Mail\Undeliver)
    - spoolPath       (default: C:\ColdFusion2021\cfusion\Mail\Spool)
    - filePattern     (default: *.cfmail)
    - minAgeSeconds   (default: 30)  // only process files older than this
    - maxToProcess    (default: 500) // safety cap per run
    - dryRun          (default: false)
--->

<cfsetting requesttimeout="300" showdebugoutput="false">

<cfparam name="url.undeliverPath" default="..\web\cf2\cfusion1\Mail\Undelivr>
<cfparam name="url.spoolPath" default="..\web\cf2\cfusion1\Mail\Spool">
<cfparam name="url.filePattern" default="*.cfmail">
<cfparam name="url.minAgeSeconds" default="30">
<cfparam name="url.maxToProcess" default="500">
<cfparam name="url.dryRun" default="false">

<cfset startedAt = Now()>
<cfset processedCount = 0>
<cfset skippedTooNewCount = 0>
<cfset errorCount = 0>
<cfset stopReason = "Completed">
<cfset logFileName = "mail-undeliver-requeue">

<cfset undeliverPath = Trim(url.undeliverPath)>
<cfset spoolPath = Trim(url.spoolPath)>
<cfset filePattern = Trim(url.filePattern)>
<cfset minAgeSeconds = Val(url.minAgeSeconds)>
<cfset maxToProcess = Val(url.maxToProcess)>
<cfset dryRun = IsBoolean(url.dryRun) AND url.dryRun>

<cfif minAgeSeconds LT 0>
    <cfset minAgeSeconds = 0>
</cfif>

<cfif maxToProcess LTE 0>
    <cfset maxToProcess = 1>
</cfif>

<cfif NOT DirectoryExists(undeliverPath)>
    <cfthrow message="Undeliver path does not exist" detail="#undeliverPath#">
</cfif>

<cfif NOT DirectoryExists(spoolPath)>
    <cfdirectory action="create" directory="#spoolPath#">
</cfif>

<cflock name="MailUndeliverRequeueLock" type="exclusive" timeout="10" throwOnTimeout="false">

    <cfdirectory
        action="list"
        directory="#undeliverPath#"
        filter="#filePattern#"
        name="qUndeliver"
        recurse="false"
        type="file"
        sort="dateLastModified ASC">

    <cfloop query="qUndeliver">

        <cfif processedCount GTE maxToProcess>
            <cfset stopReason = "Reached maxToProcess limit (#maxToProcess#)">
            <cfbreak>
        </cfif>

        <cfset sourceFile = qUndeliver.directory & "\" & qUndeliver.name>
        <cfset targetFile = spoolPath & "\" & qUndeliver.name>
        <cfset ageSeconds = DateDiff("s", qUndeliver.dateLastModified, Now())>

        <cfif ageSeconds LT minAgeSeconds>
            <cfset skippedTooNewCount = skippedTooNewCount + 1>
            <cfcontinue>
        </cfif>

        <cfif FileExists(targetFile)>
            <cfset dotPos = FindLast(".", qUndeliver.name)>
            <cfif dotPos GT 0>
                <cfset baseName = Left(qUndeliver.name, dotPos - 1)>
                <cfset extName = Mid(qUndeliver.name, dotPos, Len(qUndeliver.name) - dotPos + 1)>
            <cfelse>
                <cfset baseName = qUndeliver.name>
                <cfset extName = "">
            </cfif>

            <cfset targetFile = spoolPath & "\" & baseName & "_requeue_" & DateFormat(Now(), "yyyymmdd") & TimeFormat(Now(), "HHmmss") & "_" & Left(CreateUUID(), 8) & extName>
        </cfif>

        <cftry>
            <cfif NOT dryRun>
                <cffile action="move" source="#sourceFile#" destination="#targetFile#">
            </cfif>

            <cfset processedCount = processedCount + 1>

            <cflog
                file="#logFileName#"
                type="information"
                text="Requeued mail file | dryRun=#dryRun# | source=#sourceFile# | destination=#targetFile# | ageSeconds=#ageSeconds#">

            <cfcatch type="any">
                <cfset errorCount = errorCount + 1>
                <cflog
                    file="#logFileName#"
                    type="error"
                    text="Failed to requeue mail file | source=#sourceFile# | destination=#targetFile# | message=#cfcatch.message# | detail=#cfcatch.detail#">
            </cfcatch>
        </cftry>

    </cfloop>

</cflock>

<cfset elapsedMs = DateDiff("s", startedAt, Now())>

<cflog
    file="#logFileName#"
    type="information"
    text="MailUndeliverRequeue run complete | stopReason=#stopReason# | processed=#processedCount# | skippedTooNew=#skippedTooNewCount# | errors=#errorCount# | elapsedSeconds=#elapsedMs# | undeliverPath=#undeliverPath# | spoolPath=#spoolPath# | pattern=#filePattern#">

<cfcontent type="text/plain; charset=utf-8">
<cfoutput>
MailUndeliverRequeue complete
stopReason: #stopReason#
processed: #processedCount#
skippedTooNew: #skippedTooNewCount#
errors: #errorCount#
elapsedSeconds: #elapsedMs#
undeliverPath: #undeliverPath#
spoolPath: #spoolPath#
pattern: #filePattern#
dryRun: #dryRun#
</cfoutput>
