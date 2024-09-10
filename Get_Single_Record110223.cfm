<cfinclude template="MfaCookieCheck.cfm">


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



<!---
<CFIF Get_Auth_User_Office.RecordCount EQ 1>

	<CFSET OfficeScope = Trim(Get_Auth_User_Office.OFFICE)>
	<CFSET DefaultOffice = Get_Auth_User_Office.OFFICE_PRM_KEY>

    <CFQUERY NAME="Find_Office_Concur" DATASOURCE="contliab">

	SELECT USERPRMKEY
        FROM LAWDEPARTMENT a, BUSINESSSERVUSERS b
        WHERE a.PRIMARYKEY = b.USERPRMKEY
	AND CONTINGENT_LIAB_CONCUR = 2
        AND a.OFFICE LIKE '#OfficeScope#%'

	</cfquery>


<CFIF Left(OfficeScope, 9) EQ "Southeast">
	<CFSET OfficeScope = "Southeast">
</cfif>

<!--- Close <CFIF Get_Auth_User_Office.RecordCount EQ 1> --->
</cfif>
--->


<!---
<CFOUTPUT>

<p>
Get_Single_Record.cfm at 69: CLRC_Query_Name = "#CLRC_Query_Name#"
<p>

</CFOUTPUT>
--->



<CFQUERY NAME="#CLRC_Query_Name#" DATASOURCE="contliab" result=singleResult>

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

<!---
left outer join
LDEXTRA lde
on
(
trim(UPPER(clr.CONCUR_MC_USER_ID)) = Trim(UPPER(lde.AD_USERID))
OR 
trim(UPPER(clr.CONCUR_MC_USER_ID)) = UPPER(lde.AD_MAILNICKNAME)
)
--->



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
clr.PRIMARYKEY = #PRIMARYKEY#


AND
clr.DELETED_FLAG IS NULL

</cfquery>




<CFIF IsDefined("PrevReportDate_Parm")>

<CFQUERY NAME="CONTINGENT_LIAB_GetRecord_PrevRpt" DATASOURCE="contliab">

SELECT *

FROM CONTINGENT_LIAB_REPORT

WHERE DATE_REPORT = to_date('#DateFormat(PrevReportDate_Parm, "mm/dd/yyyy")#', 'mm/dd/yyyy')

AND 
CASE_REC_ID_SEQUENCE = #Get_Single_Record.CASE_REC_ID_SEQUENCE#

AND
DELETED_FLAG IS NULL

</cfquery>

</cfif>

<!---
create or replace view view_conting_get_mc_appr_flag as
select MC_APPR_FLAG, ALT_APPR_FLAG, CASE_REC_ID_SEQUENCE
    from CONTINGENT_LIAB_C_E_CHECKLIST
   where MC_APPR_FLAG <> 1 OR MC_APPR_FLAG IS NULL
--->

<CFQUERY NAME="Get_MC_APPR_FLAG" DATASOURCE="contliab">
SELECT MC_APPR_FLAG, ALT_APPR_FLAG
FROM VIEW_CONTING_GET_MC_APPR_FLAG
WHERE CASE_REC_ID_SEQUENCE = #Get_Single_Record.CASE_REC_ID_SEQUENCE#
</cfquery>

<!---
create or replace view view_conting_get_mc_apr_flg_ap as
select MC_APPR_FLAG, ALT_APPR_FLAG, CASE_REC_ID_SEQUENCE
    from CONTINGENT_LIAB_C_E_CHECKLIST
   where MC_APPR_FLAG = 1
--->

<CFQUERY NAME="Get_MC_APPR_FLAG_Approved" DATASOURCE="contliab">
SELECT MC_APPR_FLAG, ALT_APPR_FLAG
FROM VIEW_CONTING_GET_MC_APR_FLG_AP
WHERE CASE_REC_ID_SEQUENCE = #Get_Single_Record.CASE_REC_ID_SEQUENCE#
</cfquery>

<!--- Copied from Report.ptA.cfm: --->


<!---
<CFQUERY NAME="Get_ChecklistCases" DATASOURCE="contliab">
SELECT *
FROM VIEW_CONTING_GET_CHKLISTCASES
</cfquery>
--->

<CFQUERY NAME="Get_Case_WithoutChecklist" DATASOURCE="contliab">
SELECT DISTINCT CASE_REC_ID_SEQUENCE
FROM VIEW_CONTING_CASE_REC_ID_SEQ

WHERE CASE_REC_ID_SEQUENCE = #Get_Single_Record.CASE_REC_ID_SEQUENCE#

<!---
<CFIF IsDefined("Get_ChecklistCases.RecordCount") AND Get_ChecklistCases.RecordCount GT 0>
AND CASE_REC_ID_SEQUENCE NOT IN (#ValueList(Get_ChecklistCases.CASE_REC_ID_SEQUENCE)#)
</cfif>
--->

AND CASE_REC_ID_SEQUENCE NOT IN

<!---
(
SELECT CASE_REC_ID_SEQUENCE
FROM VIEW_CONTING_GET_CHKLISTCASES
)
--->

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



