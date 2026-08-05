<cfinclude template="MfaCookieCheck.cfm">

<!--- === Q2 -> Q3 CARRY-OVER VERIFICATION (FY 2026) === --->
<CFIF IsDefined("url.verifyq3") AND url.verifyq3 EQ "yes">
<html><head><title>Q2 to Q3 Carry-Over Verification</title></head>
<body style="font-family:arial; font-size:10pt">
<h2>Q2 to Q3 Carry-Over Verification (FY 2026)</h2>

<CFQUERY NAME="VerifySummary" DATASOURCE="ContLiab">
SELECT
    COUNT(*) AS SOURCE_Q2_CASES,
    SUM(CASE WHEN q3.CASE_REC_ID_SEQUENCE IS NOT NULL THEN 1 ELSE 0 END) AS Q3_MATCHED_CASES,
    SUM(CASE WHEN q3.CASE_REC_ID_SEQUENCE IS NULL THEN 1 ELSE 0 END) AS Q3_MISSING_CASES,

    SUM(CASE WHEN q2.DIST_PERF_CLUSTER_CODE IS NOT NULL AND q3.CASE_REC_ID_SEQUENCE IS NOT NULL AND q3.DIST_PERF_CLUSTER_CODE IS NULL THEN 1 ELSE 0 END) AS DISTRICT_MISSING_AFTER_LOAD,
    SUM(CASE WHEN q2.DIVISION_CODE IS NOT NULL AND q3.CASE_REC_ID_SEQUENCE IS NOT NULL AND q3.DIVISION_CODE IS NULL THEN 1 ELSE 0 END) AS DIVISION_MISSING_AFTER_LOAD,
    SUM(CASE WHEN q2.AREA_CODE IS NOT NULL AND q3.CASE_REC_ID_SEQUENCE IS NOT NULL AND q3.AREA_CODE IS NULL THEN 1 ELSE 0 END) AS HQ_MISSING_AFTER_LOAD
FROM CONTINGENT_LIAB_REPORT q2
LEFT JOIN CONTINGENT_LIAB_REPORT q3
    ON q3.CASE_REC_ID_SEQUENCE = q2.CASE_REC_ID_SEQUENCE
    AND q3.DATE_REPORT = to_date('06/30/2026', 'mm/dd/yyyy')
    AND q3.DELETED_FLAG IS NULL
WHERE q2.DATE_REPORT = to_date('03/31/2026', 'mm/dd/yyyy')
AND q2.DELETED_FLAG IS NULL
</CFQUERY>

<CFQUERY NAME="VerifyDetails" DATASOURCE="ContLiab">
SELECT
    q2.CASE_REC_ID_SEQUENCE,
    q2.CASE_NAME,
    q2.CASE_NUMBER,
    q2.DIST_PERF_CLUSTER_CODE AS Q2_DISTRICT,
    q3.DIST_PERF_CLUSTER_CODE AS Q3_DISTRICT,
    q2.DIVISION_CODE AS Q2_DIVISION,
    q3.DIVISION_CODE AS Q3_DIVISION,
    q2.AREA_CODE AS Q2_HQ,
    q3.AREA_CODE AS Q3_HQ,
    CASE WHEN q3.CASE_REC_ID_SEQUENCE IS NULL THEN 'Q3 RECORD MISSING'
         WHEN q2.DIST_PERF_CLUSTER_CODE IS NOT NULL AND q3.DIST_PERF_CLUSTER_CODE IS NULL THEN 'DISTRICT MISSING'
         WHEN q2.DIVISION_CODE IS NOT NULL AND q3.DIVISION_CODE IS NULL THEN 'DIVISION MISSING'
         WHEN q2.AREA_CODE IS NOT NULL AND q3.AREA_CODE IS NULL THEN 'HQ MISSING'
         ELSE 'OK' END AS RESULT
FROM CONTINGENT_LIAB_REPORT q2
LEFT JOIN CONTINGENT_LIAB_REPORT q3
    ON q3.CASE_REC_ID_SEQUENCE = q2.CASE_REC_ID_SEQUENCE
    AND q3.DATE_REPORT = to_date('06/30/2026', 'mm/dd/yyyy')
    AND q3.DELETED_FLAG IS NULL
WHERE q2.DATE_REPORT = to_date('03/31/2026', 'mm/dd/yyyy')
AND q2.DELETED_FLAG IS NULL
AND (
    q3.CASE_REC_ID_SEQUENCE IS NULL
    OR (q2.DIST_PERF_CLUSTER_CODE IS NOT NULL AND q3.DIST_PERF_CLUSTER_CODE IS NULL)
    OR (q2.DIVISION_CODE IS NOT NULL AND q3.DIVISION_CODE IS NULL)
    OR (q2.AREA_CODE IS NOT NULL AND q3.AREA_CODE IS NULL)
)
ORDER BY UPPER(q2.CASE_NAME), q2.CASE_NUMBER
</CFQUERY>

<CFOUTPUT>
<table border="1" cellpadding="6" style="border-collapse:collapse">
<tr><th>Check</th><th>Count</th><th>Status</th></tr>
<tr><td>Q2 source records (03/31/2026)</td><td>#VerifySummary.SOURCE_Q2_CASES#</td><td>Info</td></tr>
<tr><td>Q3 matched records (06/30/2026)</td><td>#VerifySummary.Q3_MATCHED_CASES#</td><td><CFIF VerifySummary.Q3_MISSING_CASES EQ 0><span style="color:green">PASS</span><CFELSE><span style="color:red">FAIL</span></CFIF></td></tr>
<tr><td>Q3 missing records</td><td>#VerifySummary.Q3_MISSING_CASES#</td><td><CFIF VerifySummary.Q3_MISSING_CASES EQ 0><span style="color:green">PASS</span><CFELSE><span style="color:red">FAIL</span></CFIF></td></tr>
<tr><td>District missing after load</td><td>#VerifySummary.DISTRICT_MISSING_AFTER_LOAD#</td><td><CFIF VerifySummary.DISTRICT_MISSING_AFTER_LOAD EQ 0><span style="color:green">PASS</span><CFELSE><span style="color:red">FAIL</span></CFIF></td></tr>
<tr><td>Division missing after load</td><td>#VerifySummary.DIVISION_MISSING_AFTER_LOAD#</td><td><CFIF VerifySummary.DIVISION_MISSING_AFTER_LOAD EQ 0><span style="color:green">PASS</span><CFELSE><span style="color:red">FAIL</span></CFIF></td></tr>
<tr><td>HQ missing after load</td><td>#VerifySummary.HQ_MISSING_AFTER_LOAD#</td><td><CFIF VerifySummary.HQ_MISSING_AFTER_LOAD EQ 0><span style="color:green">PASS</span><CFELSE><span style="color:red">FAIL</span></CFIF></td></tr>
</table>
</CFOUTPUT>

<h3>Details (only failed records)</h3>
<CFIF VerifyDetails.RecordCount GT 0>
<table border="1" cellpadding="4" style="border-collapse:collapse">
<tr>
<th>CASE_REC_ID_SEQUENCE</th><th>CASE_NAME</th><th>CASE_NUMBER</th>
<th>Q2_DISTRICT</th><th>Q3_DISTRICT</th>
<th>Q2_DIVISION</th><th>Q3_DIVISION</th>
<th>Q2_HQ</th><th>Q3_HQ</th><th>RESULT</th>
</tr>
<CFOUTPUT QUERY="VerifyDetails">
<tr>
<td>#CASE_REC_ID_SEQUENCE#</td>
<td>#CASE_NAME#</td>
<td>#CASE_NUMBER#</td>
<td>#Q2_DISTRICT#</td>
<td>#Q3_DISTRICT#</td>
<td>#Q2_DIVISION#</td>
<td>#Q3_DIVISION#</td>
<td>#Q2_HQ#</td>
<td>#Q3_HQ#</td>
<td><span style="color:red"><b>#RESULT#</b></span></td>
</tr>
</CFOUTPUT>
</table>
<CFELSE>
<p style="color:green; font-weight:bold">All carry-over checks passed for District, Division, and HQ.</p>
</CFIF>

<h3>Quick Actions</h3>
<ul>
<li><a href="reset_to_qii.cfm?go=yes">1) Reset to Q II state</a></li>
<li><a href="LoadRecords.NextQuarter.cfm">2) Run Load Case Records (Q2 -> Q3)</a></li>
<li><a href="temp_diagnose.cfm?verifyq3=yes">3) Re-run this verification</a></li>
</ul>

</body></html>
<cfabort>
</CFIF>

<!--- === DATABASE STATUS CHECK === --->
<CFIF IsDefined("url.status") AND url.status EQ "yes">
<html><head><title>Database Quarter Status</title></head>
<body style="font-family:arial; font-size:10pt">
<h2>Database Quarter Status Check</h2>

<CFQUERY NAME="QuarterCounts" DATASOURCE="ContLiab">
SELECT DATE_REPORT, DELETED_FLAG, COUNT(*) AS REC_COUNT
FROM LDDB.CONTINGENT_LIAB_REPORT
WHERE DATE_REPORT >= to_date('09/30/2025', 'mm/dd/yyyy')
GROUP BY DATE_REPORT, DELETED_FLAG
ORDER BY DATE_REPORT DESC, DELETED_FLAG
</CFQUERY>

<table border="1" cellpadding="5" style="border-collapse:collapse">
<tr><th>DATE_REPORT</th><th>DELETED_FLAG</th><th>Record Count</th></tr>
<CFOUTPUT QUERY="QuarterCounts">
<tr>
<td>#DateFormat(DATE_REPORT, "mm/dd/yyyy")#</td>
<td><CFIF DELETED_FLAG EQ "">NULL (active)<CFELSE>#DELETED_FLAG#</CFIF></td>
<td>#REC_COUNT#</td>
</tr>
</CFOUTPUT>
</table>

<CFQUERY NAME="MaxDate" DATASOURCE="ContLiab">
SELECT MAX(DATE_REPORT) AS MAX_RPT FROM LDDB.CONTINGENT_LIAB_REPORT
WHERE DATE_REPORT <= ADD_MONTHS(SYSDATE, 2)
</CFQUERY>
<CFOUTPUT><p><strong>Get_PrevReportDate would return:</strong> #DateFormat(MaxDate.MAX_RPT, "mm/dd/yyyy")#</p></CFOUTPUT>

<CFQUERY NAME="MaxActiveDate" DATASOURCE="ContLiab">
SELECT MAX(DATE_REPORT) AS MAX_RPT FROM LDDB.CONTINGENT_LIAB_REPORT
WHERE DATE_REPORT <= ADD_MONTHS(SYSDATE, 2)
AND DELETED_FLAG IS NULL
</CFQUERY>
<CFOUTPUT><p><strong>Max active (non-deleted) date:</strong> #DateFormat(MaxActiveDate.MAX_RPT, "mm/dd/yyyy")#</p></CFOUTPUT>

<h3>Quick Actions:</h3>
<ul>
<li><a href="reset_to_qii.cfm?go=yes">Reset to Q II state (soft-delete Q III/Q IV active rows)</a></li>
<li><a href="LoadRecords.NextQuarter.cfm">Run Load Case Records</a></li>
<li><a href="temp_diagnose.cfm?verifyq3=yes">Verify Q2 -> Q3 carry-over (District/Division/HQ)</a></li>
<li><a href="../V1.0/Report.full.cfm">View Report</a></li>
</ul>
</body></html>
<cfabort>
</CFIF>
<!DOCTYPE html>
<html>
<head><title>Diagnose District/Division Carry-Over</title></head>
<body style="font-family:arial; font-size:10pt">

<h2>Diagnose District/Division for Case REC ID 18891</h2>

<h3>ALL quarters for this case (CASE_REC_ID_SEQUENCE = 18891)</h3>
<CFQUERY NAME="GetAllQ" DATASOURCE="ContLiab">
SELECT PRIMARYKEY, DATE_REPORT, 
       DIST_PERF_CLUSTER_CODE, DIST_PERF_CLUSTER_NAME, 
       AREA_CODE, AREA_NAME
FROM LDDB.CONTINGENT_LIAB_REPORT
WHERE CASE_REC_ID_SEQUENCE = 18891
AND DELETED_FLAG IS NULL
ORDER BY DATE_REPORT DESC
</CFQUERY>
<CFIF GetAllQ.RecordCount GT 0>
    <table border="1" cellpadding="4">
    <tr><th>DATE_REPORT</th><th>PK</th><th>DIST_PERF_CLUSTER_CODE</th><th>DIST_PERF_CLUSTER_NAME</th><th>AREA_CODE</th><th>AREA_NAME</th></tr>
    <CFOUTPUT query="GetAllQ">
    <tr>
    <td>#DateFormat(DATE_REPORT,'mm/dd/yyyy')#</td>
    <td>#PRIMARYKEY#</td>
    <td><CFIF DIST_PERF_CLUSTER_CODE EQ ""><span style="color:red">EMPTY</span><CFELSE><strong>#DIST_PERF_CLUSTER_CODE#</strong></CFIF></td>
    <td><CFIF DIST_PERF_CLUSTER_NAME EQ ""><span style="color:red">EMPTY</span><CFELSE><strong>#DIST_PERF_CLUSTER_NAME#</strong></CFIF></td>
    <td>#AREA_CODE#</td>
    <td>#AREA_NAME#</td>
    </tr>
    </CFOUTPUT>
    </table>
<CFELSE>
    <p style="color:red">No records found!</p>
</CFIF>

<h3>Check if DIVISION columns exist in table</h3>
<CFTRY>
    <CFQUERY NAME="CheckDiv" DATASOURCE="ContLiab">
    SELECT DIVISION_CODE, DIVISION_NAME 
    FROM LDDB.CONTINGENT_LIAB_REPORT 
    WHERE PRIMARYKEY = 51767
    </CFQUERY>
    <p style="color:green"><strong>DIVISION_CODE and DIVISION_NAME columns EXIST.</strong></p>
    <CFOUTPUT>
    <p>Q III values: DIVISION_CODE=[#CheckDiv.DIVISION_CODE#] | DIVISION_NAME=[#CheckDiv.DIVISION_NAME#]</p>
    </CFOUTPUT>
<CFCATCH type="any">
    <p style="color:red"><strong>DIVISION columns DO NOT EXIST in table!</strong></p>
    <CFOUTPUT><p>Error: #cfcatch.message#</p></CFOUTPUT>
</CFCATCH>
</CFTRY>

<h3>Fix: Copy District from earliest quarter that has data</h3>
<CFIF IsDefined("url.fix") AND url.fix EQ "yes">

    <!--- First find source data --->
    <CFQUERY NAME="FindSource" DATASOURCE="ContLiab">
    SELECT DIST_PERF_CLUSTER_CODE, DIST_PERF_CLUSTER_NAME, DATE_REPORT
    FROM LDDB.CONTINGENT_LIAB_REPORT
    WHERE CASE_REC_ID_SEQUENCE = 18891
    AND DELETED_FLAG IS NULL
    AND DIST_PERF_CLUSTER_CODE IS NOT NULL
    ORDER BY DATE_REPORT DESC
    </CFQUERY>
    
    <CFIF FindSource.RecordCount GT 0>
        <CFOUTPUT><p>Found source: DATE=#DateFormat(FindSource.DATE_REPORT,'mm/dd/yyyy')# | CODE=#FindSource.DIST_PERF_CLUSTER_CODE# | NAME=#FindSource.DIST_PERF_CLUSTER_NAME#</p></CFOUTPUT>
        
        <!--- Update ALL Q III records that have empty district from the most recent quarter with data --->
        <CFQUERY NAME="DoFix" DATASOURCE="ContLiab">
        UPDATE LDDB.CONTINGENT_LIAB_REPORT t
        SET DIST_PERF_CLUSTER_CODE = (
                SELECT src.DIST_PERF_CLUSTER_CODE 
                FROM LDDB.CONTINGENT_LIAB_REPORT src
                WHERE src.CASE_REC_ID_SEQUENCE = t.CASE_REC_ID_SEQUENCE
                AND src.DELETED_FLAG IS NULL
                AND src.DIST_PERF_CLUSTER_CODE IS NOT NULL
                AND src.DATE_REPORT < to_date('06/30/2026', 'mm/dd/yyyy')
                AND src.DATE_REPORT = (SELECT MAX(DATE_REPORT) FROM LDDB.CONTINGENT_LIAB_REPORT m 
                                       WHERE m.CASE_REC_ID_SEQUENCE = t.CASE_REC_ID_SEQUENCE
                                       AND m.DELETED_FLAG IS NULL 
                                       AND m.DIST_PERF_CLUSTER_CODE IS NOT NULL
                                       AND m.DATE_REPORT < to_date('06/30/2026', 'mm/dd/yyyy'))
                AND ROWNUM = 1),
            DIST_PERF_CLUSTER_NAME = (
                SELECT src.DIST_PERF_CLUSTER_NAME 
                FROM LDDB.CONTINGENT_LIAB_REPORT src
                WHERE src.CASE_REC_ID_SEQUENCE = t.CASE_REC_ID_SEQUENCE
                AND src.DELETED_FLAG IS NULL
                AND src.DIST_PERF_CLUSTER_CODE IS NOT NULL
                AND src.DATE_REPORT < to_date('06/30/2026', 'mm/dd/yyyy')
                AND src.DATE_REPORT = (SELECT MAX(DATE_REPORT) FROM LDDB.CONTINGENT_LIAB_REPORT m 
                                       WHERE m.CASE_REC_ID_SEQUENCE = t.CASE_REC_ID_SEQUENCE
                                       AND m.DELETED_FLAG IS NULL 
                                       AND m.DIST_PERF_CLUSTER_CODE IS NOT NULL
                                       AND m.DATE_REPORT < to_date('06/30/2026', 'mm/dd/yyyy'))
                AND ROWNUM = 1)
        WHERE t.DATE_REPORT = to_date('06/30/2026', 'mm/dd/yyyy')
        AND t.DELETED_FLAG IS NULL
        AND t.DIST_PERF_CLUSTER_CODE IS NULL
        AND EXISTS (SELECT 1 FROM LDDB.CONTINGENT_LIAB_REPORT src2
                    WHERE src2.CASE_REC_ID_SEQUENCE = t.CASE_REC_ID_SEQUENCE
                    AND src2.DELETED_FLAG IS NULL
                    AND src2.DIST_PERF_CLUSTER_CODE IS NOT NULL
                    AND src2.DATE_REPORT < to_date('06/30/2026', 'mm/dd/yyyy'))
        </CFQUERY>
        
        <p style="color:green; font-weight:bold">District UPDATE done!</p>
    <CFELSE>
        <p style="color:red">No source quarter found with District data for this case!</p>
    </CFIF>
    
    <!--- Verify --->
    <CFQUERY NAME="Verify" DATASOURCE="ContLiab">
    SELECT DIST_PERF_CLUSTER_CODE, DIST_PERF_CLUSTER_NAME
    FROM LDDB.CONTINGENT_LIAB_REPORT
    WHERE PRIMARYKEY = 51767
    </CFQUERY>
    <CFOUTPUT>
    <p><strong>After fix - Q III (PK=51767): DIST_CODE=[#Verify.DIST_PERF_CLUSTER_CODE#] | DIST_NAME=[#Verify.DIST_PERF_CLUSTER_NAME#]</strong></p>
    </CFOUTPUT>
    
<CFELSE>
    <p><a href="temp_diagnose.cfm?fix=yes" style="color:blue; font-weight:bold; font-size:12pt">RUN FIX - Copy District to Q III from any earlier quarter</a></p>
</CFIF>

</body>
</html>

</body>
</html>
