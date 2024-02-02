

<!---
<CFINCLUDE TEMPLATE="string_compare.routine.cfm">
--->



<CFIF NOT
(
IsDefined("TextHighlight")
AND
TextHighlight EQ "Disabled"
)>

	<CFINCLUDE TEMPLATE="string_compare.routine.cfm">

</CFIF>



<CFSET RptDateToFmt = ThisReportDate>
<CFINCLUDE TEMPLATE="RptDateFYQFmt.cfm">


<CFINCLUDE TEMPLATE="Report.topjs.cfm">


<CFSET This_CurrentRow = 0>
<CFSET RowColor = "linen">
<CFSET CLRC_Query_Name = "Get_Single_Record">




<CFINCLUDE TEMPLATE="CheckUserAuth.cfm">

<CFQUERY NAME="#CLRC_Query_Name#" DATASOURCE="lddb" result=singleResult>

SELECT

clr.PRIMARYKEY,
clr.CASE_NAME,
clr.CASE_NUMBER,

clr.LM_MATTER_NUMBER,
clr.LM_MATTER_KEY,

clr.CASE_TYPE,
clr.CLAIM_CATEGORY,
clr.DATE_FILED,
clr.DATE_FILED_UNKNOWN,
clr.AMOUNT_SOUGHT,
clr.AMOUNT_SOUGHT_UPPER,
clr.AMOUNT_SOUGHT_UNKNOWN,
clr.ASSESSMENT_PROBABILITY,
clr.ASSESSMENT_AMOUNT,
clr.ASSESSMENT_AMT_HIGH_END,
clr.ASSESSMENT_AMOUNT_UPPER,
clr.ASSESSMENT_AMT_UPPER_HIGH_END,
clr.ASSESSMENT_AMT_UNKNOWN,
clr.ASSESSMENT_AMT_MAX_UNKNOWN,
clr.STATUS,
clr.STATUS_CODE,
clr.STATUS_CODE_SELECTED,
clr.FIELD_GRIEVANCE_FLAG,
clr.NATL_GATS_NUMBER,
clr.PAYOUT_AMOUNT,
clr.PAYOUT_LT_100K,
clr.PAYOUT_DATE,
clr.PAYOUT_DATE_NA,
clr.AREA_NAME,
clr.AREA_CODE,
clr.DIST_PERF_CLUSTER_NAME,
clr.DIST_PERF_CLUSTER_CODE,
clr.DIVISION_CODE,
clr.UNIONS_SELECTED,
clr.SHORT_TERM_LIABILITY,
clr.COUNSEL_LAW_DEPT,
clr.COCOUNSEL_LAW_DEPT,
clr.COUNSEL_OTHER,
clr.LAW_DEPT_OFFICE,
clr.ALT_LAW_DEPT_OFFICE,
clr.FACTS_POSITIONS_LONG,
clr.DATE_LAST_UPDATE,
clr.LAST_UPDATE_USER_ID,
clr.DATE_REPORT,
clr.COMMENT_GENERAL,
clr.FINALIZED_FLAG,
clr.CASE_REC_ID_SEQUENCE,
clr.CONCUR_MC,
clr.CONCUR_ALT,
clr.spreadsheet_flag,
clr.spreadsheet_by_displayname,
clr.spreadsheet_saved_date,

lde.MC_Name


FROM CONTINGENT_LIAB_REPORT clr


<!--- Add LOJ for Approving MC --->

					left outer join
					(
					select distinct 
					ldextra.EENAME as MC_Name,
					ldextra.AD_USERID,
					ldextra.AD_MAILNICKNAME
					from 
					LDEXTRA ldextra where ldextra.sepdate is null
					) lde
					on
					trim(UPPER(clr.CONCUR_MC_USER_ID)) = Trim(UPPER(lde.AD_USERID))
					OR 
					trim(UPPER(clr.CONCUR_MC_USER_ID)) = UPPER(lde.AD_MAILNICKNAME)



WHERE
clr.PRIMARYKEY = <cfqueryparam value="#PRIMARYKEY#" cfsqltype="cf_sql_numeric">


AND
clr.DELETED_FLAG IS NULL

</cfquery>




<CFIF IsDefined("PrevReportDate_Parm")>

<CFQUERY NAME="CONTINGENT_LIAB_GetRecord_PrevRpt" DATASOURCE="lddb">

SELECT *

FROM CONTINGENT_LIAB_REPORT

WHERE DATE_REPORT = to_date('#DateFormat(PrevReportDate_Parm, "mm/dd/yyyy")#', 'mm/dd/yyyy')

AND 
CASE_REC_ID_SEQUENCE = <cfqueryparam value=#Get_Single_Record.CASE_REC_ID_SEQUENCE# cfsqltype="cf_sql_numeric">

AND
DELETED_FLAG IS NULL

</cfquery>

</cfif>

<CFQUERY NAME="Get_MC_APPR_FLAG" DATASOURCE="lddb">
SELECT MC_APPR_FLAG, ALT_APPR_FLAG
FROM VIEW_CONTING_GET_MC_APPR_FLAG
WHERE CASE_REC_ID_SEQUENCE = <cfqueryparam value=#Get_Single_Record.CASE_REC_ID_SEQUENCE# cfsqltype="cf_sql_numeric">
</cfquery>

<CFQUERY NAME="Get_MC_APPR_FLAG_Approved" DATASOURCE="lddb">
SELECT MC_APPR_FLAG, ALT_APPR_FLAG
FROM VIEW_CONTING_GET_MC_APR_FLG_AP
WHERE CASE_REC_ID_SEQUENCE = <cfqueryparam value=#Get_Single_Record.CASE_REC_ID_SEQUENCE# cfsqltype="cf_sql_numeric">
</cfquery>

<!--- Copied from Report.ptA.cfm: --->

<CFQUERY NAME="Get_Case_WithoutChecklist" DATASOURCE="lddb">
SELECT DISTINCT CASE_REC_ID_SEQUENCE
FROM VIEW_CONTING_CASE_REC_ID_SEQ
WHERE CASE_REC_ID_SEQUENCE = <cfqueryparam value=#Get_Single_Record.CASE_REC_ID_SEQUENCE# cfsqltype="cf_sql_numeric">
AND CASE_REC_ID_SEQUENCE NOT IN

(
select CASE_REC_ID_SEQUENCE
from CONTINGENT_LIAB_C_E_CHECKLIST
)

</cfquery>


<CFLOOP QUERY="#CLRC_Query_Name#">

<CFSET RptDateToFmt = ThisReportDate_Parm>

<CFINCLUDE TEMPLATE="RptDateFYQFmt.cfm">


<title>
<CFOUTPUT>
#RptDateFmtString#

--

CL Case:

#CASE_NAME#
</CFOUTPUT>
</title>


<CFINCLUDE TEMPLATE="Report.ptC.cfm">


<CFINCLUDE TEMPLATE="Report.ptD.cfm">


<CFINCLUDE TEMPLATE="Report.ptE.cfm">

</table>

</div>

</CFLOOP>


