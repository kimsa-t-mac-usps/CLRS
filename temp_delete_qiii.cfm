<cfinclude template="MfaCookieCheck.cfm">
<!DOCTYPE html>
<html>
<head><title>Reset CAT to Q II State for Load Test</title></head>
<body style="font-family:arial; font-size:10pt">

<h2>Reset DEV & SIT Database to Q II State (for Load Case Report Test)</h2>
<p><em>This removes Q III (06/30/2026) records so the customer can test "Load Case Report" from Q II.</em></p>

<CFQUERY NAME="CountRecords" DATASOURCE="ContLiab">
SELECT COUNT(*) AS REC_COUNT
FROM CONTINGENT_LIAB_REPORT
WHERE DATE_REPORT = to_date('06/30/2026', 'mm/dd/yyyy')
AND DELETED_FLAG IS NULL
</CFQUERY>

<CFQUERY NAME="CountQ2" DATASOURCE="ContLiab">
SELECT COUNT(*) AS REC_COUNT
FROM CONTINGENT_LIAB_REPORT
WHERE DATE_REPORT = to_date('03/31/2026', 'mm/dd/yyyy')
AND DELETED_FLAG IS NULL
</CFQUERY>

<CFOUTPUT>
<table border="1" cellpadding="5" style="border-collapse:collapse">
<tr><th>Quarter</th><th>Date</th><th>Record Count</th><th>Status</th></tr>
<tr><td>Q II (source)</td><td>03/31/2026</td><td>#CountQ2.REC_COUNT#</td><td style="color:green">Will remain (source for reload)</td></tr>
<tr><td>Q III (target)</td><td>06/30/2026</td><td>#CountRecords.REC_COUNT#</td><td style="color:red">Will be DELETED</td></tr>
</table>
</CFOUTPUT>

<CFIF CountRecords.REC_COUNT EQ 0>

    <!--- Check for soft-deleted records that would confuse Get_PrevReportDate --->
    <CFQUERY NAME="CountSoftDeleted" DATASOURCE="ContLiab">
    SELECT COUNT(*) AS REC_COUNT
    FROM CONTINGENT_LIAB_REPORT
    WHERE DATE_REPORT = to_date('06/30/2026', 'mm/dd/yyyy')
    AND DELETED_FLAG = 'T'
    </CFQUERY>

    <CFIF CountSoftDeleted.REC_COUNT GT 0>
        <CFOUTPUT><p style="color:orange; font-weight:bold">Warning: #CountSoftDeleted.REC_COUNT# soft-deleted Q III records found! These will confuse the Load process.</p></CFOUTPUT>
        <p><a href="temp_delete_qiii.cfm?purge=yes" style="color:red; font-weight:bold">PURGE SOFT-DELETED RECORDS</a></p>
    <CFELSE>
        <p style="color:blue; font-weight:bold">No Q III records exist. The database is already in Q II state. Ready for Load test.</p>
        <p><a href="Admin.full.cfm">Go to Admin page</a> to run "Load Case Records".</p>
    </CFIF>

<CFELSEIF IsDefined("url.confirm") AND url.confirm EQ "yes">

    <!--- Soft-delete Q III records - Get_PrevReportDate now filters by DELETED_FLAG IS NULL --->
    <CFQUERY NAME="SoftDeleteRecords" DATASOURCE="ContLiab">
    UPDATE CONTINGENT_LIAB_REPORT
    SET DELETED_FLAG = 'T'
    WHERE DATE_REPORT = to_date('06/30/2026', 'mm/dd/yyyy')
    AND DELETED_FLAG IS NULL
    </CFQUERY>

    <CFOUTPUT>
    <p style="color:green; font-weight:bold">Done! Q III 2026 records soft-deleted (DELETED_FLAG = 'T').</p>
    <p>#CountRecords.REC_COUNT# records marked as deleted.</p>
    <p><strong>Next step:</strong> Go to <a href="Admin.full.cfm">Admin page</a> and click "Load Case Records" to test Q II &rarr; Q III loading with fixed District carry-over code.</p>
    </CFOUTPUT>

<CFELSEIF IsDefined("url.restore") AND url.restore EQ "yes">

    <!--- Restore soft-deleted Q III records --->
    <CFQUERY NAME="CountSoftDeleted" DATASOURCE="ContLiab">
    SELECT COUNT(*) AS REC_COUNT
    FROM CONTINGENT_LIAB_REPORT
    WHERE DATE_REPORT = to_date('06/30/2026', 'mm/dd/yyyy')
    AND DELETED_FLAG = 'T'
    </CFQUERY>

    <CFQUERY NAME="RestoreRecords" DATASOURCE="ContLiab">
    UPDATE CONTINGENT_LIAB_REPORT
    SET DELETED_FLAG = NULL
    WHERE DATE_REPORT = to_date('06/30/2026', 'mm/dd/yyyy')
    AND DELETED_FLAG = 'T'
    </CFQUERY>

    <CFOUTPUT>
    <p style="color:green; font-weight:bold">Restored! #CountSoftDeleted.REC_COUNT# Q III records un-deleted.</p>
    </CFOUTPUT>

<CFELSEIF IsDefined("url.harddelete") AND url.harddelete EQ "yes">

    <p style="color:green">Not needed — Get_PrevReportDate now filters by DELETED_FLAG IS NULL. Soft-deleted records won't interfere.</p>

<CFELSEIF IsDefined("url.purge") AND url.purge EQ "yes">

    <p style="color:green">Not needed — Get_PrevReportDate now filters by DELETED_FLAG IS NULL. Soft-deleted records won't interfere.</p>
    <p><a href="Admin.full.cfm">Go to Admin page</a> to run "Load Case Records".</p>

<CFELSE>

    <p style="margin-top:15pt"><strong>What this does:</strong></p>
    <ul>
    <li>Permanently deletes Q III (06/30/2026) records from the database</li>
    <li>Get_PrevReportDate will then find Q II (03/31/2026) as the most recent quarter</li>
    <li>"Load Case Records" will copy Q II records into Q III with District carry-over fix</li>
    </ul>

    <p style="margin-top:15pt"><a href="temp_delete_qiii.cfm?confirm=yes" style="color:red; font-weight:bold; font-size:12pt">RESET TO Q II STATE</a></p>

</CFIF>

</body>
</html>
