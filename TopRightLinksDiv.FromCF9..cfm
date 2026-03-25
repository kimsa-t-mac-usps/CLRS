<cfinclude template="MfaCookieCheck.cfm">


<!--- 
Included in Report.full.cfm.
Green box in upper-right of Report. Links to New Case form, Protocol, Report format (Front Office, Corp Finance), Spreadsheet options, format options for finalizing, dropdown menus for selecting District, HQ Dept, etc., and previous Quarterly reports
--->

<CFIF Check_Auth_User_A.RecordCount EQ 1>
	<CFSET TopRightLinksFontSize = "8pt">
	<CFSET TopRightLinksMarginTop = "4pt">
<CFELSE>
	<CFSET TopRightLinksFontSize = "9pt">
	<CFSET TopRightLinksMarginTop = "6pt">
</cfif>


<CFOUTPUT>
<div id="TopRightLinks" style="position:absolute; top:20; right:58; background:CCFFCC; padding:5pt; text-align:left; font-weight:bold; font-size:#TopRightLinksFontSize#; font-family:verdana">
</cfoutput>

<!---
<CFIF IsDefined("Form.CorpFinFormat")>

<CFOUTPUT>
Form.CorpFinFormat = "#Form.CorpFinFormat#"
</CFOUTPUT>

<CFELSE>
	Form.CorpFinFormat NOT DEFINED.
</CFIF>

<br />

<CFIF IsDefined("Form.FrontOffcReviewFormat")>

<CFOUTPUT>
Form.FrontOffcReviewFormat = "#Form.FrontOffcReviewFormat#"
</CFOUTPUT>

<CFELSE>

Form.FrontOffcReviewFormat NOT DEFINED.

</CFIF>

<br />
--->


&middot;&nbsp;<a href="InsertRecord.cfm">New Case for This Quarter</a>

<CFOUTPUT>
<p style="margin-top:#TopRightLinksMarginTop#">
</CFOUTPUT>
<CFOUTPUT>&middot;&nbsp;<a href="#LawDept_Base_URL#/inhouse/conting.liab.htm" target="_blank">Contingent Liability Protocol</a></CFOUTPUT>


<CFIF Check_Auth_User_A.RecordCount EQ 1>

<CFOUTPUT>

<CFIF IsDefined("Form.CorpFinFormat") AND Form.CorpFinFormat EQ "CorpFinFormat">

	<p style="margin-top:#TopRightLinksMarginTop#">
	&middot;&nbsp;<a href="" onClick="unsetCorpFinFormat(); return false">Report for Law Dept</a>

	<CFIF IsDefined("Form.CorpFinFormatFrontOffcVersion") AND Form.CorpFinFormatFrontOffcVersion EQ "CorpFinFormatFrontOffcVersion">

	<p style="margin-top:#TopRightLinksMarginTop#">
	&middot;&nbsp;<a href="" onClick="setCorpFinFormat(); return false">Report for Corp Finance (Corp Finance Version)</a>

	<CFELSE>

	<p style="margin-top:#TopRightLinksMarginTop#">
	&middot;&nbsp;<a href="" onClick="setCorpFinFrontOffcFormat(); return false">Report for Corp Finance (Front Office Version)</a>

	</cfif>

<CFELSEIF IsDefined("Form.FrontOffcReviewFormat") AND Form.FrontOffcReviewFormat EQ "FrontOffcReviewFormat">

	<p style="margin-top:#TopRightLinksMarginTop#">
	&middot;&nbsp;<a href="" onClick="unsetFrontOffcReviewFormat(); return false">Report for Law Dept</a>

	<p style="margin-top:#TopRightLinksMarginTop#">
	&middot;&nbsp;<a href="" onClick="setCorpFinFormat(); return false">Report for Corp Finance</a>
	<div style="font-weight:normal; margin-left:5pt">
	&middot;&nbsp;<a href="" onClick="setCorpFinFrontOffcFormat(); return false">Front Office Version</a>
	</div>

<CFELSE>

	<p style="margin-top:#TopRightLinksMarginTop#">
	&middot;&nbsp;<a href="" onClick="setFrontOffcReviewFormat(); return false">Front Office Review</a>

	<p style="margin-top:#TopRightLinksMarginTop#">

<!---
	&middot;&nbsp;<a href="" onClick="setCorpFinFormat('PDF'); return false">Report for Corp Finance</a>&nbsp;&nbsp;
--->

	&middot;&nbsp;<a href="" target="_blank" onClick="setCorpFinFormat(); return false">Report for Corp Finance</a>&nbsp;&nbsp;

	<div style="font-weight:normal; margin-left:5pt">
<!---
   	&middot;&nbsp;<a href="" target="_blank" onClick="setCorpFinFormat('PDF'); return false">PDF</a>
	<br />
--->
	&middot;&nbsp;<a href="" onClick="setCorpFinFrontOffcFormat(); return false">Front Office Version</a>
	<br />
	&middot;&nbsp;<a href="" onClick="setCorpFinFormat_STL(); return false">Short-term Liabilities Only</a>
	</div>


</cfif>

</cfoutput>



<p style="margin-top:4pt">


<CFIF IsDefined("EarlierRptDate")>

	<CFSET SpreadsheetRptDateParm = "&RptDate=" & EarlierRptDate>

<CFELSE>

	<CFSET SpreadsheetRptDateParm = "">

</CFIF>


<CFOUTPUT>
<!---
&middot;&nbsp;Spreadsheets&nbsp;&nbsp;<span style="font-size:7pt"><a href="Spreadsheet.CL.cfm?RptScope=Areas#SpreadsheetRptDateParm#">Area Totals</a>&nbsp;|&nbsp;<a href="Spreadsheet.CL.cfm?RptScope=Districts#SpreadsheetRptDateParm#">District Totals</a>&nbsp;|&nbsp;<a href="Spreadsheet.CL.cfm?RptScope=Cases#SpreadsheetRptDateParm#">Case List</a></span>
--->


<!---
&middot;&nbsp;Spreadsheets&nbsp;<span style="font-size:7pt"><a href="Spreadsheet.CL.cfm?RptScope=Cases#SpreadsheetRptDateParm#">Case List</a>&nbsp;|&nbsp;<a href="Spreadsheet.CL.cfm?RptScope=Areas#SpreadsheetRptDateParm#">Area Totals</a>&nbsp;|&nbsp;<a href="Spreadsheet.CL.cfm?RptScope=Districts#SpreadsheetRptDateParm#">District Totals</a></span>




<div style="margin-top:0pt; margin-left:5pt; font-weight:normal; font-size:7pt">[Only MC-approved & Finalized Liabilities cases]</div>
--->


&middot;&nbsp;Spreadsheets&nbsp;<span style="font-weight:normal; font-size:7pt">[Only MC-approved & Finalized Liabilities cases]</span>


<div style="font-weight:normal; margin-left:5pt">

<!---
&middot;&nbsp;<a href="Spreadsheet.CL.cfm?RptScope=Cases#SpreadsheetRptDateParm#">Case List</a>&nbsp;|&nbsp;<a href="Spreadsheet.CL.cfm?RptScope=Areas#SpreadsheetRptDateParm#">Area Totals</a>&nbsp;|&nbsp;<a href="Spreadsheet.CL.cfm?RptScope=Districts#SpreadsheetRptDateParm#">District Totals</a>
--->


&middot;&nbsp;<a href="Spreadsheet.CL.cfm?RptScope=Cases#SpreadsheetRptDateParm#">Case List</a>



<br />

&middot;&nbsp;<a href="Spreadsheet.MgmtSched.cfm" target="_blank">Management Schedule Updates</a>&nbsp;<span style="font-weight:normal; font-size:7pt">[Current Quarter only]</span>

</div>

</CFOUTPUT>


<CFIF NOT IsDefined("EarlierRptDate")>
<cfoutput>
<span id="removeDRAFTLink"><p style="margin-top:#TopRightLinksMarginTop#">
&middot;&nbsp;<a href="" onClick="removeDRAFT(); return false">Remove "DRAFT"</a></span>
</cfoutput>
</cfif>

</cfif>

<cfoutput>
<CFIF CONTINGENT_LIAB_GetRecord_Current_Count.Current_Count EQ 1 OR IsDefined("EarlierRptDate")>
<p style="margin-top:#TopRightLinksMarginTop#">
&middot;&nbsp;<a href="Report.full.cfm">Current Report</a>
</cfif>


<CFIF IsDefined("Form.CorpFinFormat") AND Form.CorpFinFormat EQ "CorpFinFormat">

<!---
<p style="margin-top:#TopRightLinksMarginTop#">
&middot;&nbsp;<a href="" onClick="CounselCoCounselList_Form.submit(); return false"><span id="HideShowIndexCaseNumLabel">List Counsel / Co-Counsel</span></a>
--->


<p style="margin-top:#TopRightLinksMarginTop#">
&middot;&nbsp;<a href="" onClick="CounselCoCounselList_Form.submit(); return false">List Counsel / Co-Counsel</a>



<p style="margin-top:#TopRightLinksMarginTop#">
&middot;&nbsp;<a href="" onClick="hideShowIndexCaseNum(); return false"><span id="HideShowIndexCaseNumLabel">Show Case Numbering</span></a>

</cfif>





<CFIF CONTINGENT_LIAB_GetRecord_Current_Count.Current_Count NEQ 0 OR IsDefined("EarlierRptDate")>
<p style="margin-top:#TopRightLinksMarginTop#">
&middot;&nbsp;<a href="" onClick="hideShowIndexLink(); return false"><span id="HideShowIndexLabel">Hide Index</span></a>
</cfif>
</cfoutput>

<CFIF CONTINGENT_LIAB_GetRecord_Current_Count.Current_Count NEQ 0>

<cfoutput>
<p style="margin-top:#TopRightLinksMarginTop#">
&middot;&nbsp;<a href="" onClick="setPrint(); return false">Print This Report</a>

<span style="font-weight:normal; font-size:7pt">
[Hides this green box]
</span>

<p style="margin-top:#TopRightLinksMarginTop#">
&middot;&nbsp;<a href="" onClick="writeNewWindow(ALL); return false">Copy All to New Window</a>
</cfoutput>

</cfif>


<CFIF IsDefined("OfficeScope")>

<cfoutput>
<p style="margin-top:#TopRightLinksMarginTop#">
</cfoutput>
&middot;&nbsp;

<SELECT NAME="Select_DIST_PERF_CLUSTER_CODE" style="font-family:verdana; font-size:7.5pt; margin-left:-2pt; margin-top:-2pt; margin-bottom:-2pt; background:khaki" SIZE="1" onChange="setRptSelectOption(this, 'SelectedPC')">

<!---
<option value="0">Select a Performance Cluster . . .
--->


<option value="0">Select a District . . .


<option value="FULL">Full Report

<CFINCLUDE TEMPLATE="areas.districts.dropdown.FromTable.cfm">

</select>


<cfoutput>
<p style="margin-top:#TopRightLinksMarginTop#">
</cfoutput>
&middot;&nbsp;

<SELECT NAME="Select_HQ_AREA_NAME" style="font-family:verdana; font-size:7.5pt; margin-left:-2pt; margin-top:-2pt; margin-bottom:-2pt; background:ffd5aa" SIZE="1" onChange="setRptSelectOption(this, 'SelectedHQDept')">

<option value="0">Select a Headquarters Department . . .

<option value="FULL">Full Report

<CFINCLUDE TEMPLATE="hq.dept.dropdown.FromTable.cfm">


</select>








<CFIF IsDefined("SelectedHQDept")
AND
SelectedHQDept CONTAINS "HQ Labor Relations">


<cfoutput>
<p style="margin-top:#TopRightLinksMarginTop#; margin-left:10pt">
</cfoutput>
&middot;&nbsp;

<SELECT NAME="Select_UNIONS_SELECTED" style="font-family:verdana; font-size:7.5pt; margin-left:-2pt; margin-top:-2pt; margin-bottom:-2pt; background:ffd5aa" SIZE="1" onChange="setRptSelectOption(this, 'SelectedUnion')">

<option value="0">Select a Union . . .

<option value="FULL_LR">Full HQ LR Report

<!---
<CFINCLUDE TEMPLATE="hq.dept.dropdown.FromTable.cfm">
--->



<CFLOOP INDEX="Unions_List_Index" LIST="#Unions_List#">

	<CFIF IsDefined("SelectedUnion")
	AND
	SelectedUnion EQ Unions_List_Index>
		<CFSET USelectedWord = "SELECTED">
	<CFELSE>
		<CFSET USelectedWord = "">
	</cfif>

	<CFOUTPUT>
	<option value="#Unions_List_Index#" #USelectedWord#>#Unions_List_Index#
	</cfoutput>

</CFLOOP>








</select>


</cfif>


















<!--- Close <CFIF IsDefined("OfficeScope")> --->
</cfif>









<CFIF Check_Auth_User_A.RecordCount EQ 1>


<CFQUERY NAME="LDOffices" DATASOURCE="contliab">
SELECT *
FROM VIEW_CONTING_LDOFFICES_INIT
where office_prm_key is not null
</cfquery>


<cfoutput>
<p style="margin-top:#TopRightLinksMarginTop#">
</cfoutput>
&middot;&nbsp;

<SELECT NAME="Select_LDOffice" style="font-family:verdana; font-size:7.5pt; margin-left:-2pt; margin-top:-2pt; margin-bottom:-2pt; background:bfdfff" SIZE="1" onChange="setRptSelectOption(this, 'SelectedLDOffice')">

<option value="0">Select a Law Department Office . . .
<option value="ALL">Full Report


<CFLOOP QUERY="LDOffices">

<CFFLUSH interval=10>

<CFSET Trim_Office = Trim(office)>


<CFSET SelectedWord = "">

<CFIF IsDefined("SelectedLDOffice")>

	<CFSET Slashes_SelectedLDOffice_Index = Find(" // ", SelectedLDOffice)>

	<CFIF Slashes_SelectedLDOffice_Index GT 0>

		<CFSET This_SelectedLDOffice_CODE = Left(SelectedLDOffice, Slashes_SelectedLDOffice_Index - 1)>

		<CFIF This_SelectedLDOffice_CODE EQ OFFICE_PRM_KEY>
			<CFSET SelectedWord = "SELECTED">
		</cfif>

	</cfif>

</cfif>



<CFIF Len(Trim_Office) GT 45>

	<CFSET Trim_Office_Text = Left(Trim_Office, 45) & "&nbsp;.&nbsp;.&nbsp;.">

<CFELSE>

	<CFSET Trim_Office_Text = Trim_Office>

</cfif>



<CFOUTPUT>
<option value="#OFFICE_PRM_KEY# // #Trim_Office#" #SelectedWord#>#Trim_Office_Text#
</CFOUTPUT>


<CFIF NOT (Trim_Office CONTAINS "General Counsel" OR Trim_Office CONTAINS "HQ")>
Office
</CFIF>



</cfloop>


</select>



<cfoutput>
<p style="margin-top:#TopRightLinksMarginTop#">
</cfoutput>
&middot;&nbsp;

<SELECT NAME="Select_CaseCategory" style="font-family:verdana; font-size:7.5pt; margin-left:-2pt; margin-top:-2pt; margin-bottom:-2pt; background:edcdaf" SIZE="1" onChange="setRptSelectOption(this, 'SelectedCategory')">

<option value="0">Select a Claim Category . . .
<option value="ALL">ALL Categories


<!---
From LabelLists.cfm:
<CFSET CLAIM_CATEGORY_Labels = "Business,Labor,Tort">

<CFSET CLAIM_CATEGORY_Labels_Select = "Business,Labor,Labor -- Non-HQ,Tort">
--->



<CFLOOP INDEX="CLAIM_CATEGORY_Labels_Index" LIST="#CLAIM_CATEGORY_Labels_Select#">

	<CFSET SelectedWord = "">

	<CFIF IsDefined("SelectedCategory")>

        <CFIF SelectedCategory EQ CLAIM_CATEGORY_Labels_Index>
			<CFSET SelectedWord = "SELECTED">
		</cfif>

	</CFIF>

	<CFOUTPUT>
	<option value="#CLAIM_CATEGORY_Labels_Index#" #SelectedWord#>#CLAIM_CATEGORY_Labels_Index# Claims
	</CFOUTPUT>

</CFLOOP>

</select>



<!--- Close <CFIF Check_Auth_User_A.RecordCount EQ 1> --->
</cfif>







<cfoutput>
<p style="margin-top:#TopRightLinksMarginTop#">
</cfoutput>
&middot;&nbsp;

<SELECT NAME="Select_Earlier_RptDate" style="font-family:verdana; font-size:7.5pt; margin-left:-2pt; margin-top:-2pt; margin-bottom:-2pt; background:ffffcc" SIZE="1" onChange="setRptSelect(this)">

<option value="" style="background:ffffcc">Select another report . . .

<CFLOOP INDEX="ReportDatesList_Index" LIST="#ReportDatesList#">

<CFSET RptDateToFmt = ReportDatesList_Index>
<CFSET Fmt_RptDateToFmt = DateFormat(RptDateToFmt, "mm/dd/yyyy")>

<CFIF Fmt_RptDateToFmt NEQ ThisReportDate>

<CFINCLUDE TEMPLATE="RptDateFYQFmt.cfm">

<CFOUTPUT>
<option value="#Fmt_RptDateToFmt#">#RptDateFmtString#
</cfoutput>

</cfif>

</cfloop>

</select>



</div>



