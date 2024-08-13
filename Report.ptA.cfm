<cfinclude template="MfaCookieCheck.cfm">

<!---------------------------- Report.ptA.cfm -------------------------------->
<!---------------------------------------------------------------------------->
<!--- KS1 --->
	<!---<CFOUTPUT>
		<br />
		Program = "Report.ptA.cfm at 4"
	</CFOUTPUT>--->

<!--- 
Included in Report.full.cfm.
Top part of Report page: Displayed banner heading. Queries to retrieve cases, based on authorization, selected scope (District, HQ Dept, etc.), and selected format (Front Office Review, Corp Finance) 
--->


<!---
Query CONTINGENT_LIAB_GetRecord_PrevRpt in Report.cfm
--->

<!--- Moved to application.cfm:
<!--- Used in textcompare.cfm: --->
<CFSET PunctuationList = "">
<CFSET PunctuationList = ListAppend(PunctuationList, '"')>
<CFSET PunctuationList = ListAppend(PunctuationList, "'")>
<CFSET PunctuationList = ListAppend(PunctuationList, ".")>
<CFSET PunctuationList = ListAppend(PunctuationList, ";")>
<CFSET PunctuationList = ListAppend(PunctuationList, "/")>
<CFSET PunctuationList = ListAppend(PunctuationList, "\")>
<CFSET PunctuationList = ListAppend(PunctuationList, "<br><br>")>

<CFSET BlankList = ",,,,,">
--->

<!---
<CFQUERY NAME="Get_ChecklistCases" DATASOURCE="contliab">
SELECT *
FROM VIEW_CONTING_GET_CHKLISTCASES
</cfquery>


<CFQUERY NAME="Get_ChecklistCases_Approved" DATASOURCE="contliab">
SELECT *
FROM VIEW_CONTING_GET_CHKLISTCASES
WHERE MC_APPR_FLAG = 1
</cfquery>
--->


<!--- Moved to application.cfm:
<CFQUERY NAME="Get_AllQuesNum" DATASOURCE="contliab">
SELECT *
FROM VIEW_CONTING_GET_ALLQUESNUM
</cfquery>


<CFSET QuesNumList = ValueList(Get_AllQuesNum.QUESNUM_TRIM)>
--->


<!--- View query:
select DISTINCT DATE_REPORT
    from CONTINGENT_LIAB_REPORT
   ORDER BY DATE_REPORT DESC
--->

<!--- Moved to application.cfm: --->
<!---
<CFQUERY NAME="Get_All_ReportDates" DATASOURCE="contliab">
SELECT *
FROM VIEW_CONTING_ALL_REPORTDATES
</cfquery>


<CFSET ReportDatesList = ValueList(Get_All_ReportDates.DATE_REPORT)>

<CFSET ReportDatesList_ListLen = ListLen(ReportDatesList)>

<CFIF ReportDatesList_ListLen GT 1>
	<CFSET PrevReportDate = DateFormat(ListGetAt(ReportDatesList, 2), "mm/dd/yyyy")>
<CFELSE>
	<CFSET PrevReportDate = "">
</cfif>

<CFSET EarliestReportDate = DateFormat(ListLast(ReportDatesList), "mm/dd/yyyy")>

<!--- Get cases of earlier report if defined; otherwise get latest date report (ListFirst(ReportDatesList)) --->

<CFIF IsDefined("EarlierRptDate")>

	<CFSET ThisReportDate = DateFormat(EarlierRptDate, "mm/dd/yyyy")>

<CFELSE>

	<CFSET ThisReportDate = DateFormat(ListFirst(ReportDatesList), "mm/dd/yyyy")>

</cfif>
--->


<CFIF ((IsDefined("Form.CorpFinFormat") AND Form.CorpFinFormat EQ "CorpFinFormat") OR
(IsDefined("Form.FrontOffcReviewFormat") AND Form.FrontOffcReviewFormat EQ "FrontOffcReviewFormat")) AND
ThisReportDate NEQ EarliestReportDate AND PrevReportDate NEQ "">




<!---
VIEW_CONTING_PRV_CAS_RECID_SEQ
--->

<CFQUERY NAME="CONTINGENT_LIAB_PrevRpt_CASE_REC_ID_SEQUENCE" DATASOURCE="contliab">
SELECT CASE_REC_ID_SEQUENCE
FROM view_conting_prv_recid_seq_2
WHERE DATE_REPORT = to_date('#DateFormat(PrevReportDate, "mm/dd/yyyy")#', 'mm/dd/yyyy')
</cfquery>


<!---
<CFOUTPUT>
ValueList(CONTINGENT_LIAB_PrevRpt_CASE_REC_ID_SEQUENCE.CASE_REC_ID_SEQUENCE) = #ValueList(CONTINGENT_LIAB_PrevRpt_CASE_REC_ID_SEQUENCE.CASE_REC_ID_SEQUENCE)#
<p>
</CFOUTPUT>
--->


</cfif>



</head>

<!---
<!--- Moved to Report.full.cfm.  --->
<CFINCLUDE TEMPLATE="CFINCLUDEs/CheckUserAuth.cfm">
--->



<!---
<CFIF IsDefined("Get_Auth_User_Office.RecordCount")
AND
Get_Auth_User_Office.RecordCount GT 0>

<CFOUTPUT>
<p>
Get_Auth_User_Office.OFFICE_PRM_KEY = #Get_Auth_User_Office.OFFICE_PRM_KEY#
<p>
</CFOUTPUT>

</CFIF>
--->


<!---
<CFOUTPUT>
--->


<CFQUERY NAME="CONTINGENT_LIAB_GetRecord_Current_Count" DATASOURCE="contliab">

SELECT COUNT(*) AS Current_Count

FROM CONTINGENT_LIAB_REPORT
WHERE

DATE_REPORT = to_date('#DateFormat(ThisReportDate, "mm/dd/yyyy")#', 'mm/dd/yyyy')

AND
DELETED_FLAG IS NULL


<CFIF IsDefined("ThisRecID")>
AND PRIMARYKEY = #ThisRecID#
</cfif>


<CFIF IsDefined("SelectedPC")>

	<CFSET Slashes_DIST_PERF_CLUSTER_CODE_Index = Find(" // ", SelectedPC)>

	<CFIF Slashes_DIST_PERF_CLUSTER_CODE_Index GT 0>

		<CFSET This_DIST_PERF_CLUSTER_CODE = Left(SelectedPC, Slashes_DIST_PERF_CLUSTER_CODE_Index - 1)>

		<CFIF This_DIST_PERF_CLUSTER_CODE EQ "ALL">
<!---
		AND AREA_NAME NOT LIKE 'HQ%'
--->

		AND DIST_PERF_CLUSTER_CODE IS NOT NULL
		AND
        (AREA_NAME IS NULL
        OR
		AREA_NAME NOT LIKE 'HQ%')

		<CFELSE>
		AND DIST_PERF_CLUSTER_CODE = '#This_DIST_PERF_CLUSTER_CODE#'

		</cfif>


	<CFELSE>

		<CFSET Vert_Bars_DIVISION_CODE_Index = Find(" || ", SelectedPC)>


		<CFIF Vert_Bars_DIVISION_CODE_Index GT 0>

			AND DIVISION_CODE = '#Left(SelectedPC, Vert_Bars_DIVISION_CODE_Index - 1)#'

		<CFELSE>

			AND DIVISION_CODE = '#SelectedPC#'

		</CFIF>

	</cfif>



<CFELSEIF IsDefined("SelectedHQDept")>

	<CFSET Slashes_HQ_AREA_NAME_Index = Find(" // ", SelectedHQDept)>

	<CFIF Slashes_HQ_AREA_NAME_Index GT 0>

		<CFSET This_HQ_AREA_CODE = Left(SelectedHQDept, Slashes_HQ_AREA_NAME_Index - 1)>
		<CFSET This_HQ_AREA_NAME = Right(SelectedHQDept, Len(SelectedHQDept) - (Slashes_HQ_AREA_NAME_Index + 3))>

		<CFIF This_HQ_AREA_CODE EQ "ALL">
		AND AREA_NAME LIKE 'HQ%'

		<CFELSE>
		AND AREA_NAME = '#This_HQ_AREA_NAME#'

		</CFIF>


		<CFIF SelectedHQDept CONTAINS "HQ Labor Relations">
                            
        	<CFIF IsDefined("SelectedUnion")>

				AND UNIONS_SELECTED LIKE '%#SelectedUnion#%'
                            
			</CFIF>
                            
		</CFIF>


	</cfif>

<CFELSEIF IsDefined("SelectedLDOffice")>

	<CFSET Slashes_SelectedLDOffice_Index = Find(" // ", SelectedLDOffice)>

	<CFIF Slashes_SelectedLDOffice_Index GT 0>

		<CFSET This_SelectedLDOffice_CODE = Left(SelectedLDOffice, Slashes_SelectedLDOffice_Index - 1)>

<!--- Include (OFFICE_PRM_KEY in LDOFFICES) for both Northeast Windsor (16) and New York (former code 7) --->	
    	<CFIF This_SelectedLDOffice_CODE EQ 7
		OR
		This_SelectedLDOffice_CODE EQ 16>

    	    AND LAW_DEPT_OFFICE IN (7,16)
	
    	<CFELSE>
        
    	    AND LAW_DEPT_OFFICE = #This_SelectedLDOffice_CODE#

		</CFIF>


	</cfif>

</cfif>



<CFIF 
IsDefined("Get_Auth_User_Office.RecordCount") 
AND 
Get_Auth_User_Office.RecordCount EQ 1 
AND 
IsDefined("Get_Auth_User_Office.OFFICE_PRM_KEY")>


<!---
	<CFINCLUDE TEMPLATE="SQL.CheckForOfficeOverlap.cfm">
--->


	AND 
    (
    LAW_DEPT_OFFICE = #Get_Auth_User_Office.OFFICE_PRM_KEY#
	OR
    ALT_LAW_DEPT_OFFICE = #Get_Auth_User_Office.OFFICE_PRM_KEY#
    )










	<CFIF IsDefined("ThisCONTINGENT_LIAB_AUTH")>

		<CFIF ThisCONTINGENT_LIAB_AUTH EQ "B">
        
			AND CLAIM_CATEGORY = 1

		<CFELSEIF ThisCONTINGENT_LIAB_AUTH EQ "T">

			AND CLAIM_CATEGORY = 3
	
		</cfif>

	</cfif>


<CFELSEIF IsDefined("Get_Indiv_User.RecordCount") 
AND 
Get_Indiv_User.RecordCount EQ 1>

<!--- HQ ELL = 24 --->

	<CFIF Get_Indiv_User.OFFICE_PRM_KEY EQ 24>

		AND (LAW_DEPT_OFFICE = #Get_Indiv_User.OFFICE_PRM_KEY#
		OR ALT_LAW_DEPT_OFFICE = #Get_Indiv_User.OFFICE_PRM_KEY#)

	<CFELSE>

		AND (COUNSEL_LAW_DEPT = #Get_Indiv_User.PRIMARYKEY#
		OR COCOUNSEL_LAW_DEPT = #Get_Indiv_User.PRIMARYKEY#)

	</cfif>

</cfif>


<CFIF 
(
IsDefined("Form.CorpFinFormat") 
AND 
Form.CorpFinFormat EQ "CorpFinFormat"
) 
OR
(
IsDefined("Form.FrontOffcReviewFormat") 
AND 
Form.FrontOffcReviewFormat EQ "FrontOffcReviewFormat"
)>

	AND

<!---
((ASSESSMENT_PROBABILITY = 1 AND ASSESSMENT_AMOUNT >= 1000000)
OR (ASSESSMENT_PROBABILITY = 2 AND ASSESSMENT_AMOUNT >= 1000000)
OR (ASSESSMENT_PROBABILITY = 3 AND ASSESSMENT_AMOUNT >= TenMillion)
--->


	<CFIF IsDefined("Form.CorpFinFormat_STL") 
	AND 
	Form.CorpFinFormat_STL EQ "CorpFinFormat_STL">

		ASSESSMENT_PROBABILITY = 1
		AND

<!---
ASSESSMENT_AMOUNT >= 1000000
--->

<!---
		ASSESSMENT_AMOUNT >= #OneMillion#
--->

		ASSESSMENT_AMOUNT >= #TenMillion#



<!---
OR
<!--- For CorpFin, Addendum, incl Narrative: --->
(ASSESSMENT_AMOUNT < 1000000 AND ASSESSMENT_AMOUNT_UPPER >= 5000000)
--->


		AND
		SHORT_TERM_LIABILITY = 2

		AND
		CASE_TYPE NOT IN (11,12)


	<CFELSE>

		(

		(
		ASSESSMENT_PROBABILITY = 1 AND
		(

		(
		ASSESSMENT_AMOUNT >= #TenMillion#

<!---
AND 
<CFINCLUDE TEMPLATE="sql.assesscutoff.fivemillion.above.cfm">
--->

		)


		OR

<!--- For CorpFin, Addendum, incl Narrative: --->
		(
        
<!---
ASSESSMENT_AMOUNT < 1000000 
--->


		(

<!---
ASSESSMENT_AMOUNT < 1000000
--->

		(
        
<!---        
		ASSESSMENT_AMOUNT < #OneMillion#
--->


		ASSESSMENT_AMOUNT < #TenMillion#
		
		OR
		ASSESSMENT_AMOUNT IS NULL
		)


		AND
		(
		ASSESSMENT_AMOUNT_UPPER >= #OneMillion#
		OR
		(
		ASSESSMENT_AMT_UPPER_HIGH_END IS NOT NULL
		AND
		ASSESSMENT_AMT_UPPER_HIGH_END >= #OneMillion#
		)
		)
		
		)



<!---
AND 
<CFINCLUDE TEMPLATE="sql.assesscutoff.fivemillion.above.cfm">
--->

		)
		
		)
		)
		
		OR
		
		(
		ASSESSMENT_PROBABILITY = 2 AND
		(
		
		
		(
        
<!---        
		ASSESSMENT_AMOUNT >= #OneMillion#
--->

		ASSESSMENT_AMOUNT >= #TenMillion#



<!---
AND 
<CFINCLUDE TEMPLATE="sql.assesscutoff.fivemillion.above.cfm">
--->

		)


		OR

<!--- For CorpFin, Addendum, incl Narrative: --->
		(
        
        
<!---
ASSESSMENT_AMOUNT < 1000000 
--->

		(

<!---
ASSESSMENT_AMOUNT < 1000000
--->


		(
<!---
		ASSESSMENT_AMOUNT < #OneMillion#
--->

		ASSESSMENT_AMOUNT < #TenMillion#

		OR
		ASSESSMENT_AMOUNT IS NULL
		)


		AND
		(
		ASSESSMENT_AMOUNT_UPPER >= #OneMillion#
		OR
		(
		ASSESSMENT_AMT_UPPER_HIGH_END IS NOT NULL
		AND
		ASSESSMENT_AMT_UPPER_HIGH_END >= #OneMillion#
		)
		)
		
		)


<!---
AND 
<CFINCLUDE TEMPLATE="sql.assesscutoff.fivemillion.above.cfm">
--->


		)
		
		)
		)
		
		OR
		
		(
		ASSESSMENT_PROBABILITY = 3 AND
		(
		(ASSESSMENT_AMOUNT_UPPER IS NULL AND ASSESSMENT_AMOUNT >= #TenMillion#)
		OR
		ASSESSMENT_AMOUNT_UPPER >= #TenMillion#
		
		OR
		(

<!---
ASSESSMENT_AMOUNT < 1000000
--->


		(
        
<!---
		ASSESSMENT_AMOUNT < #OneMillion#
--->


		ASSESSMENT_AMOUNT < #TenMillion#

		OR
		ASSESSMENT_AMOUNT IS NULL
		)


		AND
		(
		ASSESSMENT_AMOUNT_UPPER >= #OneMillion#
		OR
		(
		ASSESSMENT_AMT_UPPER_HIGH_END IS NOT NULL
		AND
		ASSESSMENT_AMT_UPPER_HIGH_END >= #OneMillion#
		)
		)
		
		)
		
		
		)
		)


<!--- Include removed cases (CASE_TYPE = 11)--->
		OR
		(
		
		(
		CASE_TYPE = 11
		OR
		CASE_TYPE = 12

<!---
or
(
status_code_selected like '%11%'
or
status_code_selected like '%12%'
or
status_code_selected like '%13%'
or
status_code_selected like '%14%'
or
status_code_selected like '%15%'
)
--->


		)
		
		AND CASE_REC_ID_SEQUENCE IN (#ValueList(CONTINGENT_LIAB_PrevRpt_CASE_REC_ID_SEQUENCE.CASE_REC_ID_SEQUENCE)#)
		)
		
		)


<!--- Close <CFIF IsDefined("Form.CorpFinFormat_STL") AND Form.CorpFinFormat_STL EQ "CorpFinFormat_STL"> --->
	</CFIF>


</cfif>


<CFIF (IsDefined("Form.CorpFinFormat") AND Form.CorpFinFormat EQ "CorpFinFormat")>

	<CFINCLUDE TEMPLATE="sql.Get_ChecklistCases.cfm">

</CFIF>


</cfquery>



<!---
</CFOUTPUT>
--->



<!---
<CFOUTPUT>
<p></p>
CONTINGENT_LIAB_GetRecord_Current_Count.Current_Count = #CONTINGENT_LIAB_GetRecord_Current_Count.Current_Count#

</CFOUTPUT>
--->


<!---
<CFABORT>
--->



<!--- Moved to CFINCLUDEs\LabelLists.cfm:
<CFSET Current_Removed_List = "Current,Removed">
--->

<CFSET Case_Type_List = "Liabilities,Receivables">



<CFIF (
(IsDefined("Form.CorpFinFormat") AND Form.CorpFinFormat EQ "CorpFinFormat")
OR
(IsDefined("Form.FrontOffcReviewFormat") AND Form.FrontOffcReviewFormat EQ "FrontOffcReviewFormat")
OR
(IsDefined("Form.CorpFinFormat_STL") AND Form.CorpFinFormat_STL EQ "CorpFinFormat_STL")
)>

<!---
	<CFSET Assess_Cutoff_List = "5MillionAndAbove,Under5Million,New1MillionAndAbove">
--->

<!---
	<CFSET Assess_Cutoff_List = "New1MillionAndAbove,5MillionAndAbove,Under5Million">
--->


	<!---kimsa<CFSET Assess_Cutoff_List = "NewTenMillionAndAbove,TenMillionAndAbove,UnderTenMillion">--->
      <CFSET Assess_Cutoff_List = "NewTenMillionAndAbove,TenMillionAndAbove">

<CFELSE>

<!---
	<CFSET Assess_Cutoff_List = "5MillionAndAbove,Under5Million">
--->

	<CFSET Assess_Cutoff_List = "TenMillionAndAbove,UnderTenMillion">



</cfif>


<CFSET QueryNamePrefix = "MainReport">

<!--- Settings for ranges in queries for assessments in case categories --->
<CFINCLUDE TEMPLATE="cfloop.cur_rem.casetype.assesscutoff.query.cfm">


<!--- For Addendum in report to Corp Finance --->
<CFIF (
(IsDefined("Form.CorpFinFormat") AND Form.CorpFinFormat EQ "CorpFinFormat")
OR
(IsDefined("Form.FrontOffcReviewFormat") AND Form.FrontOffcReviewFormat EQ "FrontOffcReviewFormat")
OR
(IsDefined("Form.CorpFinFormat_STL") AND Form.CorpFinFormat_STL EQ "CorpFinFormat_STL")
)>

<!--- Moved to CFINCLUDEs\LabelLists.cfm:
<CFSET Current_Removed_List = "Current,Removed">
--->


	<!---kimsa<CFSET Case_Type_List = "Addendum">--->

<!---
	<CFSET Assess_Cutoff_List = "MostLikelyUnder1Million_MaxReasonableOver1Million">

	<CFSET Assess_Cutoff_List = "MostLikelyUnderTenMillion_MaxReasonableOverTenMillion">

--->

<!---KS1 --->

	
    		<CFSET Case_Type_List = "Liabilities,Receivables">
			<CFSET Current_Removed_List = "New,Removed,Current">
			<CFSET Assess_Cutoff_List = "MostLikelyUnderTenMillion_MaxReasonableOverOneMillion">
             

			<CFSET Assess_Cutoff_List = "MostLikelyUnderTenMillion_MaxReasonableOverOneMillion">



	<CFSET QueryNamePrefix = "Addendum">

	<CFINCLUDE TEMPLATE="cfloop.cur_rem.casetype.assesscutoff.query.cfm">


</cfif>


<!---
<body id="DocBody" onLoad="newCaseWindowOpen = false">
--->

<body id="DocBody" onLoad="openInfoChgCompatView(); newCaseWindow = null; hideOrShowLinksDivs(); rotate()">
<!---<cfinclude template="AddHeader.cfm">--->

<CFIF
(
IsDefined("Form.CorpFinFormat") AND Form.CorpFinFormat EQ "CorpFinFormat"
)
OR
(
IsDefined("Form.FrontOffcReviewFormat") AND Form.FrontOffcReviewFormat EQ "FrontOffcReviewFormat"
)>


	<div style="margin-top:200pt; text-align:center">


</cfif>


<h2>

<small>

--- RESTRICTED INFORMATION ---
<br>



<small><small>U.S. Postal Service Law Department


<CFIF NOT
(
IsDefined("Form.CorpFinFormat") AND Form.CorpFinFormat EQ "CorpFinFormat"
)
AND NOT
(
IsDefined("Form.FrontOffcReviewFormat") AND Form.FrontOffcReviewFormat EQ "FrontOffcReviewFormat"
)>


	<span style="color:white; font-weight:normal; font-style:normal">

	<CFOUTPUT>
	#ServerID#
	</CFOUTPUT>

	</span>


</CFIF>


<br>
Contingent Liabilities and Receivables
</small></small>
<br>

<!--- Moved to Report.full.cfm: 
<CFSET RptDateToFmt = ThisReportDate>
<CFINCLUDE TEMPLATE="CFINCLUDEs/RptDateFYQFmt.cfm">
--->


<CFSET CounselCoCounselHeader = "">


<CFIF NOT IsDefined("EarlierRptDate")>

	<span id="DRAFTHeader">DRAFT</span>
	<CFSET CounselCoCounselHeader = "DRAFT ">

</cfif>



<CFOUTPUT>
#RptDateFmtString#
</cfoutput>




<CFIF (
IsDefined("Form.CorpFinFormat") 
AND 
Form.CorpFinFormat EQ "CorpFinFormat"
)
OR
(
IsDefined("Form.FrontOffcReviewFormat") 
AND 
Form.FrontOffcReviewFormat EQ "FrontOffcReviewFormat"
)>

	<div style="margin-top:15pt; color:red; font-weight:bold">

	ATTORNEY-CLIENT COMMUNICATION
	<br>
	CONTENTS MAY NOT BE REPRODUCED OR
    <br>
	DISSEMINATED WITHOUT PRIOR APPROVAL

	</div>

</CFIF>









</small>


<CFSET CounselCoCounselHeader = CounselCoCounselHeader & "Report for " & RptDateFmtString>


<form name="CounselCoCounselList_Form" METHOD="POST" ACTION="query.Get_LDCounsel.cfm" target="_blank">

<CFOUTPUT>
<input name="CounselCoCounselHeader" type="hidden" value="#CounselCoCounselHeader#">
<input name="ThisReportDate" type="hidden" value="#DateFormat(ThisReportDate, 'mm/dd/yyyy')#">
</CFOUTPUT>

</form>



<CFOUTPUT>

<script language="javascript">

RecCt = #CONTINGENT_LIAB_GetRecord_Current_Count.Current_Count#;


LatestRptDate = "#DateFormat(ListFirst(ReportDatesList), 'mm/dd/yyyy')#";

document.title =

"RESTRICTED INFORMATION: " +

<CFIF NOT IsDefined("EarlierRptDate")>
"DRAFT " +
</cfif>

"CONFIDENTIAL Law Department Contingent Liabilities & Receivables, #RptDateFmtString#";

docTitle = document.title;
</script>

</cfoutput>

<p>


<CFIF IsDefined("Form.CorpFinFormat_STL") AND Form.CorpFinFormat_STL EQ "CorpFinFormat_STL">

	Projected Short-Term Contingent Liability Payouts

</cfif>


<div id="CaseRecordsRptHeader">

<!--- OfficeScope set in CheckUserAuth.cfm --->

<CFIF IsDefined("OfficeScope") AND NOT (OfficeScope CONTAINS "All" AND IsDefined("SelectedLDOffice"))>


	<CFOUTPUT>
	#OfficeScope#
	</cfoutput>


	<CFIF IsDefined("SelectedCategory")
	AND
	SelectedCategory NEQ "ALL">
	
		<br>
		
		<CFOUTPUT>
		#SelectedCategory# Claims Only
		</CFOUTPUT>
		
	</cfif>


</cfif>


<CFIF IsDefined("ThisCONTINGENT_LIAB_AUTH")>

	<CFIF ThisCONTINGENT_LIAB_AUTH EQ "B">

		Business Claims

	<CFELSEIF ThisCONTINGENT_LIAB_AUTH EQ "T">

		Tort Claims

	</cfif>

</cfif>


<div style="color:maroon; margin-bottom:35pt">

<CFIF IsDefined("url.SelectedPC")>
	<!--- <cfdump var="#url.SelectedPC#"> --->

	<CFSET Slashes_DIST_PERF_CLUSTER_CODE_Index = Find(" // ", SelectedPC)>
	<CFSET Slashes_Next_Word = Slashes_DIST_PERF_CLUSTER_CODE_Index + 4>

	<CFIF Slashes_DIST_PERF_CLUSTER_CODE_Index GT 0>

		<CFSET This_DIST_PERF_CLUSTER_CODE = Left(SelectedPC, Slashes_DIST_PERF_CLUSTER_CODE_Index - 1)>

		<CFIF This_DIST_PERF_CLUSTER_CODE NEQ "Multiple" AND This_DIST_PERF_CLUSTER_CODE NEQ "ALL">

			<CFSET Vert_Bars_DIST_PERF_CLUSTER_CODE_Index = Find(" || ", SelectedPC)>
			<CFSET Vert_Bars_Next_Word = Vert_Bars_DIST_PERF_CLUSTER_CODE_Index + 4>

			<CFSET This_DIST_PERF_CLUSTER_NAME = Mid(SelectedPC, Slashes_Next_Word, Vert_Bars_DIST_PERF_CLUSTER_CODE_Index - (Slashes_Next_Word))>

			<CFOUTPUT>
			<small>
            
<!---            
            <small style="font-size:8pt; font-family:verdana; font-style:italic">From Performance Cluster</small>
--->
			
            <small style="font-size:8pt; font-family:verdana; font-style:italic">From District</small>

            <br>
            #This_DIST_PERF_CLUSTER_NAME#

            </small>
            
			</cfoutput>

		<CFELSE>

			<CFSET This_DIST_PERF_CLUSTER_NAME = Right(SelectedPC, Len(SelectedPC) - (Slashes_Next_Word - 1))>

			<CFOUTPUT>
			<small>

<!---
            <small style="font-size:8pt; font-family:verdana; font-style:italic">From Performance Cluster</small>
--->


            <small style="font-size:8pt; font-family:verdana; font-style:italic">From District</small>
            
            <br>
            #This_DIST_PERF_CLUSTER_NAME#
            </small>
			</cfoutput>

		</cfif>


	<CFELSE>
    
    
		<CFSET Vert_Bars_DIST_PERF_CLUSTER_CODE_Index = Find(" || ", SelectedPC)>

<!---
		<CFSET This_DIST_PERF_CLUSTER_CODE = Left(SelectedPC, Vert_Bars_DIST_PERF_CLUSTER_CODE_Index - 1)>
--->

<!---
		<CFSET This_Division_Name = Left(SelectedPC, Vert_Bars_DIST_PERF_CLUSTER_CODE_Index - 1)>
--->



		<CFIF Vert_Bars_DIST_PERF_CLUSTER_CODE_Index GT 0>

			<CFSET This_Division_Name = Left(SelectedPC, Vert_Bars_DIST_PERF_CLUSTER_CODE_Index)>
    
    	<CFELSE>
        
			<CFSET This_Division_Name = SelectedPC>
        
        </CFIF>
        
            
        
		<CFOUTPUT>
		<small>
        <small style="font-size:8pt; font-family:verdana; font-style:italic">From</small>
        <br>
        
<!---        
        #This_Division_Name# Division
--->        
        
		#This_Division_Name#
        
        
        </small>
		</cfoutput>



	</cfif>


<CFELSEIF IsDefined("SelectedHQDept")>

<cfset ampIdx = find("%26",SelectedHQDept)>
<cfif ampIdx gt 0>
	<cfset SelectedHQDept = replace(SelectedHQDept,"%26", "&")>
</cfif>
	<CFSET Slashes_HQ_AREA_NAME_Index = Find(" // ", SelectedHQDept)>

	<CFIF Slashes_HQ_AREA_NAME_Index GT 0>

		<CFSET This_HQ_AREA_CODE = Left(SelectedHQDept, Slashes_HQ_AREA_NAME_Index - 1)>
		<CFSET This_HQ_AREA_NAME = Right(SelectedHQDept, Len(SelectedHQDept) - (Slashes_HQ_AREA_NAME_Index + 3))>

		<CFOUTPUT>
		<small>
        <small style="font-size:8pt; font-family:verdana; font-style:italic">From HQ Department</small>
        <br>
        #This_HQ_AREA_NAME#

        <CFIF This_HQ_AREA_NAME EQ "HQ Labor Relations">
                            
        	<CFIF IsDefined("SelectedUnion")>
            <li>Union: #SelectedUnion#
            </CFIF>

		</CFIF>

        </small>
		</cfoutput>

	</cfif>

<CFELSEIF IsDefined("SelectedLDOffice")>
	<cfset ampIdx = find("%26",SelectedLDOffice)>
<cfif ampIdx gt 0>
	<cfset SelectedLDOffice = replace(SelectedLDOffice,"%26", "&")>
</cfif>


	<CFSET Slashes_SelectedLDOffice_Index = Find(" // ", SelectedLDOffice)>

	<CFIF Slashes_SelectedLDOffice_Index GT 0>

		<CFSET This_SelectedLDOffice_CODE = Left(SelectedLDOffice, Slashes_SelectedLDOffice_Index - 1)>
		<CFSET This_SelectedLDOffice_NAME = Right(SelectedLDOffice, Len(SelectedLDOffice) - (Slashes_SelectedLDOffice_Index + 3))>

		<CFOUTPUT>
		<small>
        <small style="font-size:8pt; font-family:verdana; font-style:italic">From Law Department Office</small>
        <br>
        #This_SelectedLDOffice_NAME#
        </small>
		</cfoutput>

	</cfif>


</cfif>


<CFIF IsDefined("SelectedPC") 
OR 
IsDefined("SelectedHQDept") 
OR 
IsDefined("SelectedLDOffice")>

	<div id="BackToFullReportLink" style="color:black; font-weight:normal; font-size:10pt">
<CFOUTPUT>
	<a href="Report.full.cfm#RptDateParm#">
	 > Back to Full Report
	</a>
	</CFOUTPUT>

	<!---KS<CFOUTPUT>
	<a href="Report.cfm#RptDateParm#">
	Back to Full Report
	</a>
	</CFOUTPUT>--->

	</div>

</CFIF>


</div>


</div>


</h2>



<CFIF
(
IsDefined("Form.CorpFinFormat") AND Form.CorpFinFormat EQ "CorpFinFormat"
)
OR
(
IsDefined("Form.FrontOffcReviewFormat") AND Form.FrontOffcReviewFormat EQ "FrontOffcReviewFormat"
)>


	</div style="margin-top:200pt; text-align:center">


</cfif>




