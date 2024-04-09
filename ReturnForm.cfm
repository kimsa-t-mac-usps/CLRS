
<!--- 
Included in Report.full.cfm.

Form to return to Report.full.cfm after selecting Report scope option (earlier report, selected District, HQ Office, etc.) 
--->

<CFIF IsDefined("EarlierRptDate")>
    <CFSET ReportScopeParmChar = "&">  
<CFELSE>
    <CFSET ReportScopeParmChar = "?">
</cfif>


<CFIF IsDefined("SelectedPC")>
	<CFSET ReportScopeParm = ReportScopeParmChar & "SelectedPC=" & SelectedPC>
<CFELSEIF IsDefined("SelectedHQDept")>
	<CFSET ReportScopeParm = ReportScopeParmChar & "SelectedHQDept=" & SelectedHQDept>
<CFELSEIF IsDefined("SelectedLDOffice")>
	<CFSET ReportScopeParm = ReportScopeParmChar & "SelectedLDOffice=" & SelectedLDOffice>
<CFELSE>
	<CFSET ReportScopeParm = "">
</cfif>


<CFOUTPUT>

<CFIF IsDefined("EarlierRptDate")>
	<form name="ReturnForm" METHOD="POST" ACTION="Report.full.cfm?EarlierRptDate=#ThisReportDate##ReportScopeParm#">
<CFELSE>
	<form name="ReturnForm" METHOD="POST" ACTION="Report.full.cfm#ReportScopeParm#">
</cfif>

</cfoutput>


<input type="hidden" name="CorpFinFormat" value="">
<input type="hidden" name="CorpFinFormatFrontOffcVersion" value="">
<input type="hidden" name="CorpFinFormat_STL" value="">

<input type="hidden" name="FrontOffcReviewFormat" value="">

<input type="hidden" name="IndexOnly" value="">

<CFIF IsDefined("Form.CorpFinFormat") AND Form.CorpFinFormat EQ "CorpFinFormat" AND IsDefined("Form.MaroonBorderList") AND Form.MaroonBorderList NEQ "" AND NOT IsDefined("EarlierRptDate")>

<CFOUTPUT>
<input type="hidden" name="MaroonBorderList" value="#Form.MaroonBorderList#">
</cfoutput>

<CFELSE>

<CFOUTPUT>
<input type="hidden" name="MaroonBorderList" value="#MaroonBorderList#">
</cfoutput>

</cfif>

</form>


