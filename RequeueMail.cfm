<cfinclude template="MfaCookieCheck.cfm">
<!---
    RequeueMail.cfm
    Moves all stuck ColdFusion mail files from the Undeliver folder
    back into the Spool folder so ColdFusion will attempt to resend them.
    Configure as a scheduled task in ColdFusion Administrator
      URL example:
      http://<server>/ClientService/ContingentLiabilities/V1.0/RequeMailUndeliverRequeue.cfm
--->

<cfsetting requesttimeout="300" showdebugoutput="false">

<!--- PATHS TO MAIL FOLDERS --->
<cfset undeliverPath = "X:\web\cf2\cfusion\Mail\Undelivr">
<cfset spoolPath     = "X:\web\cf2\cfusion\Mail\Spool">

<!--- COUNTERS --->
<cfset movedCount = 0>
<cfset errorCount = 0>

<!--- ENSURE PATHS EXIST --->
<cfif NOT DirectoryExists(undeliverPath)>
    <cfthrow message="Undeliver folder does not exist: #undeliverPath#">
</cfif>

<cfif NOT DirectoryExists(spoolPath)>
    <cfdirectory action="create" directory="#spoolPath#">
</cfif>

<!--- GET LIST OF STUCK MAIL FILES --->
<cfdirectory 
    action="list"
    directory="#undeliverPath#"
    filter="*.cfmail"
    name="qMail"
    type="file">

<!--- MOVE EACH FILE BACK INTO SPOOL --->
<cfloop query="qMail">

    <cfset sourceFile = qMail.directory & "\" & qMail.name>
    <cfset targetFile = spoolPath & "\" & qMail.name>

    <!--- Avoid overwriting existing files --->
    <cfif FileExists(targetFile)>
        <cfset targetFile = spoolPath & "\" &
            ListFirst(qMail.name, ".") &
            "_requeue_" &
            DateFormat(Now(), "yyyymmdd") &
            TimeFormat(Now(), "HHmmss") &
            "_" &
            Left(CreateUUID(), 8) &
            ".cfmail">
    </cfif>

    <!--- MOVE FILE --->
    <cftry>
        <cffile action="move" source="#sourceFile#" destination="#targetFile#">
        <cfset movedCount++>

        <cfcatch>
            <cfset errorCount++>
        </cfcatch>
    </cftry>

</cfloop>

<!--- OUTPUT FOR SCHEDULED TASK LOG --->
<cfcontent type="text/plain">
<cfoutput>
Requeue complete.
Moved: #movedCount#
Errors: #errorCount#
</cfoutput>
