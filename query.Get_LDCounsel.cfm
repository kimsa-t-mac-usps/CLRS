<cfinclude template="MfaCookieCheck.cfm">

<head>

<title>
U.S. Postal Service Law Department, Contingent Liabilities and Receivables
</title>

</head>

<CFQUERY NAME="Get_LDCounsel" DATASOURCE="lddb">
select DISTINCT a.LASTNAME, a.FIRSTNAME, Trim(a.OFFICE) AS Trim_OFFICE

from LAWDEPARTMENT a, contingent_liab_report b
WHERE 
(
a.PRIMARYKEY = b.COUNSEL_LAW_DEPT
OR
a.PRIMARYKEY = b.COCOUNSEL_LAW_DEPT
)

AND (a.SEPARATFLG != 'S' OR a.SEPARATFLG IS NULL OR a.SEPARATFLG = '0')

and
DELETED_FLAG IS NULL


AND
DATE_REPORT = to_date('#Form.ThisReportDate#', 'mm/dd/yyyy')

ORDER BY LASTNAME, FIRSTNAME, Trim_OFFICE
</cfquery>

<h5>
U.S. Postal Service Law Department 
<br />
Contingent Liabilities and Receivables 
<br />


<CFOUTPUT>
#Form.CounselCoCounselHeader#
</CFOUTPUT>

</h5>

<h4>
Law Department Counsel / Co-Counsel
</h4>

<table style="width:90%">
<tr style="text-align:left">
<th style="width:15%">
NAME

<th>
OFFICE

<CFLOOP QUERY="Get_LDCounsel">

<tr>

<CFOUTPUT>

<td>
#LASTNAME#, #FIRSTNAME#

<td>
#Trim_OFFICE#

</CFOUTPUT>

</CFLOOP>

</table>


