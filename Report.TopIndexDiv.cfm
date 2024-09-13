<cfinclude template="MfaCookieCheck.cfm">

<!------------------------- Report.TopIndexDiv.cfm --------------------------->
<!---------------------------------------------------------------------------->
<!--- KS1 --->
<!---	<CFOUTPUT>
		Program = "Report.TopIndexDiv.cfm at 4"
	</CFOUTPUT>--->

<!--- 
Included in Report.full.cfm.
Display Index of retrieved cases 
--->


<!---
<CFOUTPUT>

<CFIF (IsDefined("Form.FrontOffcReviewFormat") AND Form.FrontOffcReviewFormat EQ "FrontOffcReviewFormat")>
Form.FrontOffcReviewFormat = #Form.FrontOffcReviewFormat#
<p></p>
</CFIF>

<CFIF (IsDefined("Form.CorpFinFormat_STL") AND Form.CorpFinFormat_STL EQ "CorpFinFormat_STL")>
Form.CorpFinFormat_STL = #Form.CorpFinFormat_STL#
<p></p>
</cfif>

<CFIF (IsDefined("Form.CorpFinFormat") AND Form.CorpFinFormat EQ "CorpFinFormat")>
Form.CorpFinFormat = #Form.CorpFinFormat#
<p></p>
</cfif>

</CFOUTPUT>
--->

<CFIF IsDefined("Form.FrontOffcReviewFormat") 
AND 
Form.FrontOffcReviewFormat EQ "FrontOffcReviewFormat">

<!---
padding-left:25pt;
--->

	<div id="TopIndex" style="font-size:8pt; border:thin solid green; padding:5pt; padding-left:35pt; margin-top:10pt">

<CFELSEIF IsDefined("Form.CorpFinFormat_STL") 
AND 
Form.CorpFinFormat_STL EQ "CorpFinFormat_STL">

	<div id="TopIndex" style="font-size:8pt; border:thin solid green; padding:5pt; padding-left:30pt; margin-top:10pt">

<CFELSEIF Init_Check_Auth_User_A.RecordCount EQ 1 
AND NOT 
(
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
)>

<!--- 

margin-top:35pt 
margin-top:45pt; 

--->

	<CFOUTPUT>
	<div id="TopIndex" style="position:relative; font-size:8pt; border:thin solid green; padding:5pt; margin-top:55pt; Report.TopIndexDiv.cfm at 52">
	</CFOUTPUT>



<CFELSEIF IsDefined("Form.CorpFinFormat") 
AND 
Form.CorpFinFormat EQ "CorpFinFormat">

	<div id="TopIndex" style="font-size:8pt; border:thin solid green; padding:5pt; margin-top:40pt; Report.TopIndexDiv.cfm at 59">

<CFELSE>

<!--- margin-top:40pt --->

	<div id="TopIndex" style="font-size:8pt; border:thin solid green; padding:5pt; margin-top:40pt; page-break-after:always; Report.TopIndexDiv.cfm at 63">

</cfif>


<CFSET MillionsNotation = "<span style='font-size:6pt; margin-left:0.5pt'>M</span>">

<!---
<CFIF Init_Check_Auth_User_A.RecordCount EQ 1 AND NOT (IsDefined("Form.CorpFinFormat") AND Form.CorpFinFormat EQ "CorpFinFormat")>
	<div id="TopIndex" style="font-size:8pt; border:thin solid green; padding:5pt; margin-top:65pt">
<CFELSE>
	<div id="TopIndex" style="font-size:8pt; border:thin solid green; padding:5pt; margin-top:40pt">
</cfif>
--->


<CFIF 
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
)>



	<CFSET CL_Arrays_List = "">
	
	
	<CFSET Liab_CumulativeProbable_TenMillionAndAbove = ArrayNew(1)>
	<CFSET CL_Arrays_List = ListAppend(CL_Arrays_List, "Liab_CumulativeProbable_TenMillionAndAbove")>
	
	<CFSET Liab_CumulativeProbable_UnderTenMillion = ArrayNew(1)>
	<CFSET CL_Arrays_List = ListAppend(CL_Arrays_List, "Liab_CumulativeProbable_UnderTenMillion")>
	
	
	<CFSET Liab_CumulativeProbable_NewTenMillionAndAbove = ArrayNew(1)>
	<CFSET CL_Arrays_List = ListAppend(CL_Arrays_List, "Liab_CumulativeProbable_NewTenMillionAndAbove")>
	
	<CFSET Liab_CumulativeReasPoss_NewTenMillionAndAbove = ArrayNew(1)>
	<CFSET CL_Arrays_List = ListAppend(CL_Arrays_List, "Liab_CumulativeReasPoss_NewTenMillionAndAbove")>
	
	<CFSET Liab_CumulativeRemote_NewTenMillionAndAbove = ArrayNew(1)>
	<CFSET CL_Arrays_List = ListAppend(CL_Arrays_List, "Liab_CumulativeRemote_NewTenMillionAndAbove")>
	
	
	<CFSET Liab_CumulativeReasPoss_TenMillionAndAbove = ArrayNew(1)>
	<CFSET CL_Arrays_List = ListAppend(CL_Arrays_List, "Liab_CumulativeReasPoss_TenMillionAndAbove")>
	
	<CFSET Liab_CumulativeReasPoss_UnderTenMillion = ArrayNew(1)>
	<CFSET CL_Arrays_List = ListAppend(CL_Arrays_List, "Liab_CumulativeReasPoss_UnderTenMillion")>
	
	
	<CFSET Liab_CumulativeRemote_TenMillionAndAbove = ArrayNew(1)>
	<CFSET CL_Arrays_List = ListAppend(CL_Arrays_List, "Liab_CumulativeRemote_TenMillionAndAbove")>
	
	<CFSET Liab_CumulativeRemote_UnderTenMillion = ArrayNew(1)>
	<CFSET CL_Arrays_List = ListAppend(CL_Arrays_List, "Liab_CumulativeRemote_UnderTenMillion")>
	
	
	
	<CFSET Receiv_CumulativeProbable_TenMillionAndAbove = ArrayNew(1)>
	<CFSET CL_Arrays_List = ListAppend(CL_Arrays_List, "Receiv_CumulativeProbable_TenMillionAndAbove")>
	
	<CFSET Receiv_CumulativeProbable_UnderTenMillion = ArrayNew(1)>
	<CFSET CL_Arrays_List = ListAppend(CL_Arrays_List, "Receiv_CumulativeProbable_UnderTenMillion")>
	
	
	<CFSET Receiv_CumulativeProbable_NewTenMillionAndAbove = ArrayNew(1)>
	<CFSET CL_Arrays_List = ListAppend(CL_Arrays_List, "Receiv_CumulativeProbable_NewTenMillionAndAbove")>
	
	<CFSET Receiv_CumulativeReasPoss_NewTenMillionAndAbove = ArrayNew(1)>
	<CFSET CL_Arrays_List = ListAppend(CL_Arrays_List, "Receiv_CumulativeReasPoss_NewTenMillionAndAbove")>
	
	<CFSET Receiv_CumulativeRemote_NewTenMillionAndAbove = ArrayNew(1)>
	<CFSET CL_Arrays_List = ListAppend(CL_Arrays_List, "Receiv_CumulativeRemote_NewTenMillionAndAbove")>
	
	
	<CFSET Receiv_CumulativeReasPoss_TenMillionAndAbove = ArrayNew(1)>
	<CFSET CL_Arrays_List = ListAppend(CL_Arrays_List, "Receiv_CumulativeReasPoss_TenMillionAndAbove")>
	
	<CFSET Receiv_CumulativeReasPoss_UnderTenMillion = ArrayNew(1)>
	<CFSET CL_Arrays_List = ListAppend(CL_Arrays_List, "Receiv_CumulativeReasPoss_UnderTenMillion")>
	
	
	<CFSET Receiv_CumulativeRemote_TenMillionAndAbove = ArrayNew(1)>
	<CFSET CL_Arrays_List = ListAppend(CL_Arrays_List, "Receiv_CumulativeRemote_TenMillionAndAbove")>
	
	<CFSET Receiv_CumulativeRemote_UnderTenMillion = ArrayNew(1)>
	<CFSET CL_Arrays_List = ListAppend(CL_Arrays_List, "Receiv_CumulativeRemote_UnderTenMillion")>
	
	
	
	<CFSET Liab_CumulativeProbable_TenMillionAndAbove_Removed = ArrayNew(1)>
	<CFSET CL_Arrays_List = ListAppend(CL_Arrays_List, "Liab_CumulativeProbable_TenMillionAndAbove_Removed")>
	
	<CFSET Liab_CumulativeProbable_UnderTenMillion_Removed = ArrayNew(1)>
	<CFSET CL_Arrays_List = ListAppend(CL_Arrays_List, "Liab_CumulativeProbable_UnderTenMillion_Removed")>
	
	<CFSET Liab_CumulativeReasPoss_TenMillionAndAbove_Removed = ArrayNew(1)>
	<CFSET CL_Arrays_List = ListAppend(CL_Arrays_List, "Liab_CumulativeReasPoss_TenMillionAndAbove_Removed")>
	
	<CFSET Liab_CumulativeReasPoss_UnderTenMillion_Removed = ArrayNew(1)>
	<CFSET CL_Arrays_List = ListAppend(CL_Arrays_List, "Liab_CumulativeReasPoss_UnderTenMillion_Removed")>
	
	<CFSET Liab_CumulativeRemote_TenMillionAndAbove_Removed = ArrayNew(1)>
	<CFSET CL_Arrays_List = ListAppend(CL_Arrays_List, "Liab_CumulativeRemote_TenMillionAndAbove_Removed")>
	
	<CFSET Liab_CumulativeRemote_UnderTenMillion_Removed = ArrayNew(1)>
	<CFSET CL_Arrays_List = ListAppend(CL_Arrays_List, "Liab_CumulativeRemote_UnderTenMillion_Removed")>
	
	<CFSET Receiv_CumulativeProbable_TenMillionAndAbove_Removed = ArrayNew(1)>
	<CFSET CL_Arrays_List = ListAppend(CL_Arrays_List, "Receiv_CumulativeProbable_TenMillionAndAbove_Removed")>
	
	<CFSET Receiv_CumulativeProbable_UnderTenMillion_Removed = ArrayNew(1)>
	<CFSET CL_Arrays_List = ListAppend(CL_Arrays_List, "Receiv_CumulativeProbable_UnderTenMillion_Removed")>
	
	<CFSET Receiv_CumulativeReasPoss_TenMillionAndAbove_Removed = ArrayNew(1)>
	<CFSET CL_Arrays_List = ListAppend(CL_Arrays_List, "Receiv_CumulativeReasPoss_TenMillionAndAbove_Removed")>
	
	<CFSET Receiv_CumulativeReasPoss_UnderTenMillion_Removed = ArrayNew(1)>
	<CFSET CL_Arrays_List = ListAppend(CL_Arrays_List, "Receiv_CumulativeReasPoss_UnderTenMillion_Removed")>
	
	<CFSET Receiv_CumulativeRemote_TenMillionAndAbove_Removed = ArrayNew(1)>
	<CFSET CL_Arrays_List = ListAppend(CL_Arrays_List, "Receiv_CumulativeRemote_TenMillionAndAbove_Removed")>
	
	<CFSET Receiv_CumulativeRemote_UnderTenMillion_Removed = ArrayNew(1)>
	<CFSET CL_Arrays_List = ListAppend(CL_Arrays_List, "Receiv_CumulativeRemote_UnderTenMillion_Removed")>
	
	<!---
	<CFSET Addendum_CumulativeProbable_Under1MillionOver5Million = ArrayNew(1)>
	<CFSET CL_Arrays_List = ListAppend(CL_Arrays_List, "Addendum_CumulativeProbable_Under1MillionOver5Million")>
	
	<CFSET Addendum_CumulativeReasPoss_Under1MillionOver5Million = ArrayNew(1)>
	<CFSET CL_Arrays_List = ListAppend(CL_Arrays_List, "Addendum_CumulativeReasPoss_Under1MillionOver5Million")>
	
	<CFSET Addendum_CumulativeRemote_Under1MillionOver5Million = ArrayNew(1)>
	<CFSET CL_Arrays_List = ListAppend(CL_Arrays_List, "Addendum_CumulativeRemote_Under1MillionOver5Million")>
	--->
	
<!---	
	<CFSET Addendum_CumulativeProbable_MostLikelyUnder1Million_MaxReasonableOver1Million = ArrayNew(1)>
	<CFSET CL_Arrays_List = ListAppend(CL_Arrays_List, "Addendum_CumulativeProbable_MostLikelyUnder1Million_MaxReasonableOver1Million")>
	
	<CFSET Addendum_CumulativeReasPoss_MostLikelyUnder1Million_MaxReasonableOver1Million = ArrayNew(1)>
	<CFSET CL_Arrays_List = ListAppend(CL_Arrays_List, "Addendum_CumulativeReasPoss_MostLikelyUnder1Million_MaxReasonableOver1Million")>
	
	<CFSET Addendum_CumulativeRemote_MostLikelyUnder1Million_MaxReasonableOver1Million = ArrayNew(1)>
	<CFSET CL_Arrays_List = ListAppend(CL_Arrays_List, "Addendum_CumulativeRemote_MostLikelyUnder1Million_MaxReasonableOver1Million")>
--->	
	
<!---    
	<CFSET Addendum_CumulativeProbable_MostLikelyUnderTenMillion_MaxReasonableOverTenMillion = ArrayNew(1)>
	<CFSET CL_Arrays_List = ListAppend(CL_Arrays_List, "Addendum_CumulativeProbable_MostLikelyUnderTenMillion_MaxReasonableOverTenMillion")>
	
	<CFSET Addendum_CumulativeReasPoss_MostLikelyUnderTenMillion_MaxReasonableOverTenMillion = ArrayNew(1)>
	<CFSET CL_Arrays_List = ListAppend(CL_Arrays_List, "Addendum_CumulativeReasPoss_MostLikelyUnderTenMillion_MaxReasonableOverTenMillion")>
	
	<CFSET Addendum_CumulativeRemote_MostLikelyUnderTenMillion_MaxReasonableOverTenMillion = ArrayNew(1)>
	<CFSET CL_Arrays_List = ListAppend(CL_Arrays_List, "Addendum_CumulativeRemote_MostLikelyUnderTenMillion_MaxReasonableOverTenMillion")>
--->    

	<CFSET Addendum_CumulativeProbable_MostLikelyUnderTenMillion_MaxReasonableOverOneMillion = ArrayNew(1)>
	<CFSET CL_Arrays_List = ListAppend(CL_Arrays_List, "Addendum_CumulativeProbable_MostLikelyUnderTenMillion_MaxReasonableOverOneMillion")>
	
	<CFSET Addendum_CumulativeReasPoss_MostLikelyUnderTenMillion_MaxReasonableOverOneMillion = ArrayNew(1)>
	<CFSET CL_Arrays_List = ListAppend(CL_Arrays_List, "Addendum_CumulativeReasPoss_MostLikelyUnderTenMillion_MaxReasonableOverOneMillion")>
	
	<CFSET Addendum_CumulativeRemote_MostLikelyUnderTenMillion_MaxReasonableOverOneMillion = ArrayNew(1)>
	<CFSET CL_Arrays_List = ListAppend(CL_Arrays_List, "Addendum_CumulativeRemote_MostLikelyUnderTenMillion_MaxReasonableOverOneMillion")>



    
    
    
	
	<!--- Initialize arrays for three categories (1=Business, 2=Labor, 3=Tort) --->
	
	<CFLOOP INDEX="CL_Arrays_List_Index" LIST="#CL_Arrays_List#">
	
		<CFSET temp = ArraySet(Evaluate(CL_Arrays_List_Index), 1, 3, 0)>
	
	</CFLOOP>
	
	
<!--- Close
	<CFIF (IsDefined("Form.FrontOffcReviewFormat") AND Form.FrontOffcReviewFormat EQ "FrontOffcReviewFormat")
	OR
	(IsDefined("Form.CorpFinFormat_STL") AND Form.CorpFinFormat_STL EQ "CorpFinFormat_STL")>
--->
</cfif>
	
	

<div style="font-weight:bold; letter-spacing:10pt; color:green">INDEX</div>


<CFSET IndexKeyTop = 180>

<CFIF NOT IsDefined("EarlierRptDate")>
	
	<div id="IndexKey" style="position:relative; float:right; background:bfdfff; padding:5pt; text-align:left; font-size:8pt; margin-left:5pt; top:-10pt; z-index:-1">
	
	
<!---	
	<span style="position:relative; left:-2pt"><li class="TopIndex">&nbsp;&nbsp;Case needs update</span>
--->    
        
	<img src="../images/bulletblack.gif" width="11" height="11" style="margin-top:2px; border-bottom: 1px solid white; vertical-align:bottom">&nbsp;&nbsp;Case needs update
      
    
	<br>
	<span style="font-size:9pt; font-weight:bold; background:orange; text-align:center; color:white; width:13; height:10; padding-left:1px; border: 1px solid white; margin-right:2pt">N</span> New Case awaiting MC approval
	<br>
	<span style="font-size:9pt; font-weight:bold; background:maroon; text-align:center; color:white; width:13; height:10; padding-left:1px; border: 1px solid white; margin-right:2pt">D</span> New Case disapproved by MC
	<br>
	<span style="font-size:9pt; font-weight:bold; background:green; text-align:center; color:white; width:13; height:10; padding-left:1px; border: 1px solid white; margin-right:2pt">U</span> Updated Case awaiting MC approval
	<br>
	<span id="GrayLetters" style="font-size:9pt; font-weight:bold; background:gray; text-align:center; color:white; width:13; height:10; padding-left:1px; border: 1px solid white; margin-right:2pt">&nbsp;</span> Case reported by other Law Dept Office
	<br>
	<img src="checkmark.black.pct66.gif" width="13" height="13" align="baseline" alt="Checkmark image" style="margin-right:2pt"> Case approved by MC
	
	
	<CFIF IsDefined("Form.FrontOffcReviewFormat") AND Form.FrontOffcReviewFormat EQ "FrontOffcReviewFormat">
	
	<br>
	<span style="font-size:9pt; font-weight:bold; text-align:center; color:maroon; width:13; height:10; padding-left:1px; margin-right:2pt">S</span> Short-term liability
	
	</cfif>
	
	
	<br>
	<img src="Padlock.papersize.pct76.crop.b.gif" width="13" height="12" align="baseline" alt="Padlock image" style="margin-right:2pt"> Case Record finalized; no further updates for Current Report
	<br>
	<!---
	<span style="font-size:9pt; font-weight:bold; text-align:center; margin-right:4pt; margin-left:2pt">&times;</span> Max Reasonable Payout below reporting threshold
	--->
	
	
	<!---<span style="font-size:9pt; font-weight:bold; text-align:center; margin-right:4pt; margin-left:2pt">&times;</span> Most Likely Payout below reporting threshold--->
	
	
	
<!---    
	<span style="font-size:9pt; font-weight:bold; text-align:center; margin-right:4pt; margin-left:2pt">&times;</span> Max Reasonable Payout below reporting threshold
--->


	<span style="font-size:9pt; font-weight:bold; text-align:center; margin-right:4pt; margin-left:2pt">&times;</span> Max Reasonable Payout below reporting threshold

	
	<!---
	 style="display:none"
	--->
	
	<div id="IndexLegendIncrxStatus" style="display:none">
	<span style="font-size:9pt; font-weight:bold; text-align:center; margin-right:4pt; margin-left:2pt; background:maroon; color:white">&times;</span> Below reporting threshold; <b>incorrect Status selected</b>
	</div>
	
	
	</div>
	
</cfif>

	
<CFSET HeaderParm = "TopIndex">
	<!---
	<CFSET ASSESSMENT_PROBABILITY_Label_Count = 1>
	--->
<CFSET CheckFlag = "no">
	
	
<!--- Moved to LabelLists.cfm:
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

<!---
	<CFSET Assess_Cutoff_List = "5MillionAndAbove,Under5Million,New1MillionAndAbove">
--->
	<CFSET Assess_Cutoff_List = "TenMillionAndAbove,NewTenMillionAndAbove">
	
<CFELSE>

	<CFSET Assess_Cutoff_List = "TenMillionAndAbove,UnderTenMillion">
	<!---Kimsa<cfoutput>I am here Div.line 408</cfoutput>--->

</cfif>


<CFSET QueryNamePrefix = "MainReport">


<!--- CFLOOPs to cycle through cases in categories, assessment levels --->
<CFINCLUDE TEMPLATE="Report.TopIndexDiv.cfloops.cfm">



<!--- For Addendum in report to Corp Finance --->
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

	<!--- Moved to LabelLists.cfm:
	 <CFSET Current_Removed_List = "Removed,New">
	<CFSET Case_Type_List = "Liabilities,Receivables">
	<CFSET Case_Type_List = "Addendum">
	
	Lenee'--->
	
	<!---
	<CFSET Assess_Cutoff_List = "Under1MillionOver5Million">
	--->

	

	<CFSET Case_Type_List = "Liabilities,Receivables">
	<CFSET Current_Removed_List = "New,Removed">
	
	<CFSET Assess_Cutoff_List = "MostLikelyUnderTenMillion_MaxReasonableOverOneMillion">  
	

	
	<CFSET QueryNamePrefix = "Addendum">
	
<!--- CFLOOPs to cycle through cases in categories, assessment levels --->
	<CFINCLUDE TEMPLATE="Report.TopIndexDiv.cfloops.cfm">
	
</cfif>



<CFIF 
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
)>

	
	<script language="javascript">
	
	
	
	<CFLOOP INDEX="CL_Arrays_List_Index" LIST="#CL_Arrays_List#">
	
	
		<CFSET ThisArraySum = ArraySum(Evaluate(CL_Arrays_List_Index)) / OneMillion>
	
		<CFOUTPUT>
		if (document.getElementById("#CL_Arrays_List_Index#"))
		#CL_Arrays_List_Index#.innerHTML = "(#NumberFormat(ThisArraySum, '_._')##MillionsNotation#)"
		</cfoutput>
	
	</CFLOOP>
	
	
	
	<CFLOOP INDEX="CL_Arrays_List_Index" LIST="#CL_Arrays_List#">
	
	
		<CFLOOP INDEX="ArrayLoopCt" FROM="1" TO="3">
		
			<CFSET ThisDisplayAssessArray_Amt_Var = CL_Arrays_List_Index & "[" & ArrayLoopCt & "]">
			<CFSET Display_Assess_Amt = Evaluate(ThisDisplayAssessArray_Amt_Var) / OneMillion>
			<CFSET Display_Assess_Amt = NumberFormat(Display_Assess_Amt, '_._') & MillionsNotation>
			
			<CFOUTPUT>
			if (document.getElementById("#CL_Arrays_List_Index#_#ArrayLoopCt#")) #CL_Arrays_List_Index#_#ArrayLoopCt#.innerHTML = "(#Display_Assess_Amt#)";
			</cfoutput>
			
		</CFLOOP>
	
	
	</cfloop>
	
	</script>

</cfif>

<!--- End TopIndex div:--->
</div>







