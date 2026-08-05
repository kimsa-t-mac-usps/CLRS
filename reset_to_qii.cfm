<cfinclude template="MfaCookieCheck.cfm">
<!DOCTYPE html>
<html>
<head><title>Reset to Q II</title></head>
<body style="font-family:arial; font-size:10pt">
<h2>Reset to Q II State</h2>

<CFQUERY NAME="CountQ3Active" DATASOURCE="ContLiab">
SELECT COUNT(*) AS REC_COUNT
FROM CONTINGENT_LIAB_REPORT
WHERE DATE_REPORT = to_date('06/30/2026', 'mm/dd/yyyy')
AND DELETED_FLAG IS NULL
</CFQUERY>

<CFQUERY NAME="CountQ3Deleted" DATASOURCE="ContLiab">
SELECT COUNT(*) AS REC_COUNT
FROM CONTINGENT_LIAB_REPORT
WHERE DATE_REPORT = to_date('06/30/2026', 'mm/dd/yyyy')
AND DELETED_FLAG = 'T'
</CFQUERY>

<CFQUERY NAME="CountQ2" DATASOURCE="ContLiab">
SELECT COUNT(*) AS REC_COUNT
FROM CONTINGENT_LIAB_REPORT
WHERE DATE_REPORT = to_date('03/31/2026', 'mm/dd/yyyy')
AND DELETED_FLAG IS NULL
</CFQUERY>

<CFOUTPUT>
<p><strong>Q II (03/31/2026) active records:</strong> #CountQ2.REC_COUNT# (DO NOT TOUCH - this is the source)</p>
<p><strong>Q III (06/30/2026) active records:</strong> #CountQ3Active.REC_COUNT#</p>
<p><strong>Q III (06/30/2026) soft-deleted records:</strong> #CountQ3Deleted.REC_COUNT#</p>
</CFOUTPUT>

<CFIF IsDefined("url.go") AND url.go EQ "yes">

    <!--- Soft-delete Q IV records (09/30/2026) that were loaded by mistake --->
    <CFQUERY NAME="SoftDeleteQ4" DATASOURCE="ContLiab">
    UPDATE CONTINGENT_LIAB_REPORT
    SET DELETED_FLAG = 'T'
    WHERE DATE_REPORT = to_date('09/30/2026', 'mm/dd/yyyy')
    AND DELETED_FLAG IS NULL
    </CFQUERY>

    <!--- Soft-delete Q III records (06/30/2026) --->
    <CFQUERY NAME="SoftDeleteQ3" DATASOURCE="ContLiab">
    UPDATE CONTINGENT_LIAB_REPORT
    SET DELETED_FLAG = 'T'
    WHERE DATE_REPORT = to_date('06/30/2026', 'mm/dd/yyyy')
    AND DELETED_FLAG IS NULL
    </CFQUERY>

    <CFOUTPUT>
    <p style="color:green; font-weight:bold">Done!</p>
    <p>Q IV (09/30/2026): soft-deleted</p>
    <p>Q III (06/30/2026): soft-deleted</p>
    <p>Q II (03/31/2026): untouched (source for reload)</p>
    </CFOUTPUT>

    <p><strong>Next:</strong> <a href="LoadRecords.NextQuarter.cfm">Run Load Case Records</a> (should target 06/30/2026)</p>

<CFELSE>

    <CFIF CountQ3Active.REC_COUNT GT 0>
        <p><a href="reset_to_qii.cfm?go=yes" style="color:red; font-weight:bold; font-size:14pt">SOFT-DELETE Q III RECORDS</a></p>
        <p><em>This uses UPDATE (not DELETE) - sets DELETED_FLAG = 'T' on 06/30/2026 records only.</em></p>
    <CFELSE>
        <p style="color:blue; font-weight:bold">Already in Q II state. Ready to Load.</p>
        <p><a href="LoadRecords.NextQuarter.cfm">Run Load Case Records</a></p>
    </CFIF>

</CFIF>

</body>
</html>
