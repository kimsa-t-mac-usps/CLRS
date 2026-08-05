<cfset PRIMARYKEY = 59614>

<cfquery name="GetCaseInfo" datasource="contliab">
SELECT CASE_REC_ID_SEQUENCE, CASE_NAME
FROM CONTINGENT_LIAB_REPORT
WHERE PRIMARYKEY = <cfqueryparam value="#PRIMARYKEY#" cfsqltype="cf_sql_numeric">
AND DELETED_FLAG IS NULL
</cfquery>

<h3>Case: <cfoutput>#GetCaseInfo.CASE_NAME# (CASE_REC_ID_SEQUENCE: #GetCaseInfo.CASE_REC_ID_SEQUENCE#)</cfoutput></h3>

<h3>ACTIVE records only (DELETED_FLAG IS NULL) - one per quarter:</h3>
<cfquery name="GetActiveQuarters" datasource="contliab">
SELECT PRIMARYKEY, DATE_REPORT, 
       DIST_PERF_CLUSTER_CODE, DIST_PERF_CLUSTER_NAME, 
       DIVISION_CODE, DIVISION_NAME
FROM CONTINGENT_LIAB_REPORT
WHERE CASE_REC_ID_SEQUENCE = <cfqueryparam value="#GetCaseInfo.CASE_REC_ID_SEQUENCE#" cfsqltype="cf_sql_numeric">
AND DELETED_FLAG IS NULL
ORDER BY DATE_REPORT DESC
</cfquery>

<table border="1" cellpadding="5" cellspacing="0" style="font-family:arial; font-size:10pt">
<tr style="background:navy; color:white">
    <th>PK</th><th>DATE_REPORT</th><th>DIST_CODE</th><th>DIST_NAME</th><th>DIVISION_CODE</th><th>DIVISION_NAME</th>
</tr>
<cfoutput query="GetActiveQuarters">
<tr style="background:<cfif DIVISION_CODE NEQ ''>##ccffcc<cfelse>##ffffff</cfif>">
    <td>#PRIMARYKEY#</td><td>#DateFormat(DATE_REPORT, "mm/dd/yyyy")#</td>
    <td>[#DIST_PERF_CLUSTER_CODE#]</td><td>[#DIST_PERF_CLUSTER_NAME#]</td>
    <td style="font-weight:bold">[#DIVISION_CODE#]</td><td style="font-weight:bold">[#DIVISION_NAME#]</td>
</tr>
</cfoutput>
</table>
<p>Green rows = has Division data</p>

<hr>
<h3>ALL records (including soft-deleted) with non-empty DIVISION_CODE:</h3>
<cfquery name="GetDivisionRecords" datasource="contliab">
SELECT PRIMARYKEY, DATE_REPORT, DIVISION_CODE, DIVISION_NAME, DELETED_FLAG
FROM CONTINGENT_LIAB_REPORT
WHERE CASE_REC_ID_SEQUENCE = <cfqueryparam value="#GetCaseInfo.CASE_REC_ID_SEQUENCE#" cfsqltype="cf_sql_numeric">
AND DIVISION_CODE IS NOT NULL
ORDER BY DATE_REPORT DESC
</cfquery>
<cfif GetDivisionRecords.RecordCount EQ 0>
<p style="color:red; font-weight:bold">NO RECORDS FOUND with DIVISION_CODE set (in any quarter, active or deleted)!</p>
<cfelse>
<table border="1" cellpadding="5" cellspacing="0" style="font-family:arial; font-size:10pt">
<tr style="background:navy; color:white">
    <th>PK</th><th>DATE_REPORT</th><th>DIVISION_CODE</th><th>DIVISION_NAME</th><th>DELETED_FLAG</th>
</tr>
<cfoutput query="GetDivisionRecords">
<tr><td>#PRIMARYKEY#</td><td>#DateFormat(DATE_REPORT, "mm/dd/yyyy")#</td>
    <td>#DIVISION_CODE#</td><td>#DIVISION_NAME#</td><td>#DELETED_FLAG#</td></tr>
</cfoutput>
</table>
</cfif>

<hr>
<h3>All records (full list):</h3>
<cfquery name="GetAllQuarters" datasource="contliab">
SELECT PRIMARYKEY, DATE_REPORT, 
       DIST_PERF_CLUSTER_CODE, DIST_PERF_CLUSTER_NAME, 
       DIVISION_CODE, DIVISION_NAME,
       DELETED_FLAG
FROM CONTINGENT_LIAB_REPORT
WHERE CASE_REC_ID_SEQUENCE = <cfqueryparam value="#GetCaseInfo.CASE_REC_ID_SEQUENCE#" cfsqltype="cf_sql_numeric">
ORDER BY DATE_REPORT DESC
</cfquery>

<h3>All records for this case across all quarters:</h3>
<table border="1" cellpadding="5" cellspacing="0" style="font-family:arial; font-size:10pt">
<tr style="background:navy; color:white">
    <th>PK</th>
    <th>DATE_REPORT</th>
    <th>DIST_PERF_CLUSTER_CODE</th>
    <th>DIST_PERF_CLUSTER_NAME</th>
    <th>DIVISION_CODE</th>
    <th>DIVISION_NAME</th>
    <th>DELETED_FLAG</th>
</tr>
<cfoutput query="GetAllQuarters">
<tr style="background:<cfif DELETED_FLAG EQ 'Y'>##ffcccc<cfelse>##ffffff</cfif>">
    <td>#PRIMARYKEY#</td>
    <td>#DateFormat(DATE_REPORT, "mm/dd/yyyy")#</td>
    <td>[#DIST_PERF_CLUSTER_CODE#]</td>
    <td>[#DIST_PERF_CLUSTER_NAME#]</td>
    <td>[#DIVISION_CODE#]</td>
    <td>[#DIVISION_NAME#]</td>
    <td>#DELETED_FLAG#</td>
</tr>
</cfoutput>
</table>
<p>Red rows = soft-deleted (DELETED_FLAG='Y')</p>
