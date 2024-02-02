
<!---------------------------- Report.Full.cfm ------------------------------->
<!---------------------------------------------------------------------------->
<!--- KS1 --->
	<!---<CFOUTPUT>
		Program = "Report.Full.cfm at 4"
	</CFOUTPUT>--->

<html>

<head>
	<link rel='stylesheet' type='text/css' href='stylesheet.css'>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>

[<CFOUTPUT>#CGI.SERVER_NAME#</CFOUTPUT>] 

<CFIF NOT IsDefined("EarlierRptDate")>
DRAFT
</cfif>

CONFIDENTIAL Law Department Contingent Liabilities

</title>









<CFIF IsDefined("Form.RecID") AND Form.RecID NEQ "">
	<CFSET ThisRecID = Form.RecID>
<CFELSEIF IsDefined("RecIDParm")>
	<CFSET ThisRecID = RecIDParm>
</cfif>


<CFIF IsDefined("EarlierRptDate")>
	<CFSET RptDateParm = "?EarlierRptDate=" & EarlierRptDate>
<CFELSE>
	<CFSET RptDateParm = "">
</CFIF>






<!--- Routine for highlighting text differences since previous Quarter report --->
<CFINCLUDE TEMPLATE="string_compare.routine.cfm">


<CFSET RptDateToFmt = ThisReportDate>
<CFINCLUDE TEMPLATE="RptDateFYQFmt.cfm">




<!--- Contains link to stylesheeet; contains various JavaScript routines and functions --->
<CFINCLUDE TEMPLATE="Report.topjs.cfm">



<!--- NOT moved to application.cfm: --->
<!--- Check whether user authorized to access CL system and scope of authorization: Department-wide, Office-wide, case-only, or none --->
<CFINCLUDE TEMPLATE="CheckUserAuth.cfm">


<!--- Displays server ID / name in page header --->
<CFINCLUDE TEMPLATE="cfswitch.serveraddr_id.cfm">

<!--- Top part of Report page: Displayed banner heading. Queries to retrieve cases, based on authorization, selected scope (District, HQ Dept, etc.), and selected format (Front Office Review, Corp Finance) --->
<CFINCLUDE TEMPLATE="Report.ptA.cfm">





<!--- Moved to application.cfm: --->
<!---
<!--- For Report Date on or after 9/30/2011 (PostRedesignReportDate), use Redesign list of Areas, Districts: --->
<CFIF IsDefined("RptDate")>

	<CFSET ThisReportDateCompare = DateCompare(RptDate, PostRedesignReportDate)>

<CFELSE>

	<CFSET ThisReportDateCompare = DateCompare(ThisReportDate, PostRedesignReportDate)>

</CFIF>
--->







<!--- 
Green box in upper-right of Report. Links to New Case form, Protocol, Report format (Front Office, Corp Finance), Spreadsheet options, format options for finalizing, dropdown menus for selecting District, HQ Dept, etc., and previous Quarterly reports
--->
<CFINCLUDE TEMPLATE="TopRightLinksDiv.cfm">


<!--- Form with parms to return to Report.full.cfm after selecting Report scope option (including earlier report, selected District, HQ Office, etc.) --->
<CFINCLUDE TEMPLATE="ReturnForm.cfm">

<!---
<CFOUTPUT>
CONTINGENT_LIAB_GetRecord_Current_Count.Current_Count = #CONTINGENT_LIAB_GetRecord_Current_Count.Current_Count#
<p>
</CFOUTPUT>
--->


<CFIF
(
(IsDefined("Form.IndexOnly") AND Form.IndexOnly EQ "IndexOnly")
OR
(CONTINGENT_LIAB_GetRecord_Current_Count.Current_Count GT IndexOnlyCaseCountCutoff
AND NOT IsDefined("Form.IndexOnly")
AND NOT IsDefined("SelectedPC")
AND NOT IsDefined("SelectedDiv")
AND NOT IsDefined("SelectedHQDept")
)
)
AND ThisReportDate NEQ EarliestReportDate
AND PrevReportDate NEQ "">

	<CFSET PrevReportDate_Parm = DateFormat(PrevReportDate, "mm/dd/yyyy")>

<!---
	<CFSET ThisReportDate_Parm = DateFormat(ThisReportDate, "mm/dd/yyyy")>
--->

<CFELSE>

	<CFSET PrevReportDate_Parm = "">


</cfif>



<CFSET ThisReportDate_Parm = DateFormat(ThisReportDate, "mm/dd/yyyy")>






<CFIF CONTINGENT_LIAB_GetRecord_Current_Count.Current_Count EQ 0>


	<b>[No Records found.]</b>


<CFELSE>


	<CFSET Old_CASE_TYPE_Label = "">
	<CFSET Old_ASSESSMENT_PROBABILITY_Label = "">
	<CFSET Old_CLAIM_CATEGORY_Label = "">

<!--- Moved to LabelLists.cfm:
<CFSET ASSESSMENT_PROBABILITY_Label_List = "A. Probable,B. Reasonably Possible,C. Remote">
<CFSET ASSESSMENT_PROBABILITY_Label_List_Len = ListLen(ASSESSMENT_PROBABILITY_Label_List)>

<CFSET CLAIM_CATEGORY_Label_List = "1. Business Claims,2. Labor Claims,3. Tort Claims">
<CFSET CLAIM_CATEGORY_Label_List_Len = ListLen(CLAIM_CATEGORY_Label_List)>
--->

	<CFSET ASSESSMENT_PROBABILITY_Label_Count = 1>
	
	
	<CFIF CONTINGENT_LIAB_GetRecord_Current_Count.Current_Count GT 1>
	
	
		<CFSET This_Current_IndexRow = 0>
		<CFSET This_CurrentRow = 0>
	
	
		<CFIF NOT (
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
		)
		OR
		(
		IsDefined("Form.CorpFinFormat_STL") 
		AND 
		Form.CorpFinFormat_STL EQ "CorpFinFormat_STL"
		)
		)>
	
	
			<CFIF CONTINGENT_LIAB_GetRecord_Current_Count.Current_Count GT IndexOnlyCaseCountCutoff>


<!---
width:20%; 
--->			
            
            
            
            
				<div id="IndexReportBlueBox" style="font-weight:bold; background:#bfdfff; padding:5pt; margin-bottom:10pt; font-size:10pt; width:50%">

				
				<CFIF (
				IsDefined("Form.IndexOnly") 
				AND 
				Form.IndexOnly EQ "IndexOnly"
				)
				OR
				(
				NOT IsDefined("Form.IndexOnly")
				AND NOT IsDefined("SelectedPC")
				AND NOT IsDefined("SelectedDiv")
				AND NOT IsDefined("SelectedHQDept")
				)>
	

					<CFSET IndexOnlyDirectionsDiv_Display = "yes">

					<span id="IndexOnlyLink" style="color:gray">[Index&#8209;Only]</span>&nbsp;&nbsp;/&nbsp;&nbsp;<span id="FullReportLink"><a href="javascript: setIndexOnly('FullReport')">Index&nbsp;+&nbsp;Case&nbsp;Reports</a></span>


				<CFELSE>


					<span id="IndexOnlyLink"><a href="javascript: setIndexOnly('IndexOnly')">Index&#8209;Only</a></span>&nbsp;&nbsp;/&nbsp;&nbsp;<span id="FullReportLink" style="color:gray">[Index&nbsp;+&nbsp;Case&nbsp;Reports]</span>


				</CFIF>


				</div>


				<CFIF IsDefined("IndexOnlyDirectionsDiv_Display") 
				AND 
				IndexOnlyDirectionsDiv_Display EQ "yes">

<!--- Deleted margin-bottom:-90pt; --->

					<div id="IndexOnlyDirectionsDiv" style="font-weight:normal; font-size:8pt; font-family:verdana; padding:5pt; margin-top:5pt; margin-bottom:20pt; background:#ffd5aa; width:50%">
				
					This is <b>Index-Only Display:</b> Click a case name below; the case report will appear in a new window. You can toggle between this window and the new window.
				
					<p style="margin-top:5pt">
					For the <b>Index and all Case Reports</b>,
					click "Index&nbsp;+&nbsp;Case&nbsp;Reports," above.
				
					<p style="margin-top:5pt">
					<input type="checkbox" name="TextHighlightingDisable" id="TextHighlightingDisable" value="yes" style="float:left">
					<b>Turn off text highlighting</b> in Facts&nbsp;/&nbsp;Positions narrative [for faster display of Case Reports]



					<CFINCLUDE TEMPLATE="Warning.Banner.cfm">


				
					</div>
				
				<CFELSE>

<!--- Placeholder to keep INDEX box below from overlapping --->




					<div style="margin-top:20pt; margin-bottom:20pt; width:50%">

				    &nbsp;



					<CFINCLUDE TEMPLATE="Warning.Banner.cfm">



				    </div>





				</cfif>


			</cfif>


		</cfif>








<!--- Display Index of retrieved cases --->
		<CFINCLUDE TEMPLATE="Report.TopIndexDiv.cfm">


<!--- Close <CFIF CONTINGENT_LIAB_GetRecord_Current.RecordCount GT 1>: --->
	</cfif>



<!--- For STL (short-term liab) report, prevent full case report. STL report is just Top Index. --->
	<CFIF NOT 
	(
	IsDefined("Form.CorpFinFormat_STL") 
	AND 
	Form.CorpFinFormat_STL EQ "CorpFinFormat_STL"
	)
	AND NOT 
	(
	IsDefined("Form.IndexOnly") 
	AND 
	Form.IndexOnly EQ "IndexOnly"
	)
	AND NOT
	(
	CONTINGENT_LIAB_GetRecord_Current_Count.Current_Count GT IndexOnlyCaseCountCutoff
	AND NOT IsDefined("Form.IndexOnly")
	AND NOT IsDefined("SelectedPC")
	AND NOT IsDefined("SelectedDiv")
	AND NOT IsDefined("SelectedHQDept")
	)>


		<CFSET RowNum = 0>
		
		<CFSET Old_CASE_TYPE_Label = "">
		<CFSET Old_ASSESSMENT_PROBABILITY_Label = "">
		<CFSET Old_CLAIM_CATEGORY_Label = "">
		
		<CFSET HeaderParm = "Body">


<!--- Moved to LabelLists.cfm
<CFSET Current_Removed_List_Reverse = "Removed,Current">
<CFSET Case_Type_List_Reverse = "Receivables,Liabilities">
--->


		<CFIF (
		(
		IsDefined("Form.CorpFinFormat") 
		AND Form.CorpFinFormat EQ "CorpFinFormat"
		)
		OR
		(
		IsDefined("Form.FrontOffcReviewFormat") 
		AND 
		Form.FrontOffcReviewFormat EQ "FrontOffcReviewFormat"
		)
		OR
		(
		IsDefined("Form.CorpFinFormat_STL") 
		AND 
		Form.CorpFinFormat_STL EQ "CorpFinFormat_STL"
		)
		)>
		

			<!---Kimsa<CFSET Assess_Cutoff_List_Reverse = "Under10Million,10MillionAndAbove,New1MillionAndAbove">--->
           <CFSET Assess_Cutoff_List_Reverse = "TenMillionAndAbove,NewTenMillionAndAbove">
		<CFELSE>

			<CFSET Assess_Cutoff_List_Reverse = "UnderTenMillion,TenMillionAndAbove">

		</cfif>


		<CFSET Last_CLRC_Query_Name = "">
		<CFSET QueryNamePrefix = "MainReport">

		<CFINCLUDE TEMPLATE="cfloop.cur_rem.casetype.assesscutoff.recct.cfm">

<!---
Moved to LabelLists.cfm:
<CFSET Current_Removed_List = "Current,Removed">
--->


		<CFSET Case_Type_List = "Liabilities,Receivables">


		<CFIF (
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
		)
		OR
		(
		IsDefined("Form.CorpFinFormat_STL") 
		AND 
		Form.CorpFinFormat_STL EQ "CorpFinFormat_STL"
		)
		)>
		
		<!---kimsa
			<CFSET Assess_Cutoff_List = "New1MillionAndAbove,5MillionAndAbove,Under5Million">
		
		<CFELSE>
		
			<CFSET Assess_Cutoff_List = "5MillionAndAbove,Under5Million">
		
		</cfif>--->
		
			<!---Kimsa<CFSET Assess_Cutoff_List = "NewTenMillionAndAbove,TenMillionAndAbove,UnderTenMillion">--->
		 <CFSET Assess_Cutoff_List = "NewTenMillionAndAbove,TenMillionAndAbove">
			 <CFSET Current_Removed_List = "New,Removed,Current"> 
		<CFELSE>
		
			<CFSET Assess_Cutoff_List = "TenMillionAndAbove,UnderTenMillion">
		
		</cfif>

<!--- Has INCLUDEs for Report.ptB.cfm - Report.ptE.cfm --->
		<CFINCLUDE TEMPLATE="cfloop.cur_rem.casetype.assesscutoff.output.cfm">


<!--- Addendum --->
		<CFIF (
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
		)
		OR
		(
		IsDefined("Form.CorpFinFormat_STL") 
		AND 
		Form.CorpFinFormat_STL EQ "CorpFinFormat_STL"
		)
		)>
		
		
			<!---kimsa<CFSET Current_Removed_List_Reverse = "Removed,Current">
			<CFSET Case_Type_List_Reverse = "Addendum">
			
			
			<CFSET Assess_Cutoff_List_Reverse = "MostLikelyUnderTenMillion_MaxReasonableOverOneMillion">
			
			<CFSET Last_CLRC_Query_Name = "">
			<CFSET QueryNamePrefix = "Addendum">
			
			<CFINCLUDE TEMPLATE="cfloop.cur_rem.casetype.assesscutoff.recct.cfm">
			
			<!--- Moved to CFINCLUDEs\LabelLists.cfm:
			<CFSET Current_Removed_List = "Current,Removed">
			--->--->
			
			<CFSET Case_Type_List = "Liabilities,Receivables">
			<CFSET Current_Removed_List = "New,Removed,Current">
			<CFSET Assess_Cutoff_List = "MostLikelyUnderTenMillion_MaxReasonableOverOneMillion">
			
			
			<CFSET Last_CLRC_Query_Name = "">
			<CFSET QueryNamePrefix = "Addendum">
			<CFINCLUDE TEMPLATE="cfloop.cur_rem.casetype.assesscutoff.recct.cfm">
			
			<!---Kimsa<CFSET Case_Type_List = "Addendum">--->
			
			
			<CFSET Assess_Cutoff_List = "MostLikelyUnderTenMillion_MaxReasonableOverOneMillion">
			
			<CFINCLUDE TEMPLATE="cfloop.cur_rem.casetype.assesscutoff.output.cfm">

			
		</cfif>


<!--- Close <CFIF NOT (IsDefined("Form.CorpFinFormat_STL") AND Form.CorpFinFormat_STL EQ "CorpFinFormat_STL")> --->
	</cfif>



<!---
Close <CFIF CONTINGENT_LIAB_GetRecord_Current.RecordCount EQ 0>:
--->
</cfif>

</body>


</html>


