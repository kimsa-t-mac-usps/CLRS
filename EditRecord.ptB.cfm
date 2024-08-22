<cfinclude template="MfaCookieCheck.cfm">

<tr>
<td>

<CFIF FINALIZED_FLAG EQ 1>
<div style="font-size:8pt; background:khaki; padding-top:3pt; padding-bottom:2pt; padding-left:4pt; padding-right:8pt; font-style:italic; font-weight:bold; margin-bottom:-1pt"><img src="Padlock.gif" width="12" height="15" align="baseline">&nbsp;&nbsp;Record Finalized</div>
</cfif>


</td>

<td align="right" style="font-size:8pt">

<CFIF IsDefined("Get_Checklist_Responses.RecordCount")>

	<CFIF Get_Checklist_Responses.RecordCount EQ 1>

		<CFOUTPUT>
		<span style="background:ffd5aa; padding:5pt"><a href="##BkMark_CaseEvaluationChecklistHeader_#CONTINGENT_LIAB_GetRecord.CurrentRow#" onClick="showCaseEvaluationChecklistDiv(#CONTINGENT_LIAB_GetRecord.CurrentRow#)"><b>See Case Evaluation Checklist</b></a></span>
		</cfoutput>

	</CFIF>

<CFELSEIF IsDefined("RecIDParm")>


	<CFQUERY NAME="Get_Checklist_Responses" DATASOURCE="contliab">
	SELECT checklist.*
	
    FROM 
    CONTINGENT_LIAB_C_E_CHECKLIST checklist,
    CONTINGENT_LIAB_REPORT report
    
	WHERE 
    checklist.CASE_REC_ID_SEQUENCE = report.CASE_REC_ID_SEQUENCE 
    
    and
    report.primarykey = #RecIDParm#
    
    </cfquery>

</cfif>

</td>
</tr>

<CFIF NOT 
(
(
IsDefined("Form.Operation") 
AND 
(
Form.Operation EQ "Updated" 
OR 
Form.Operation EQ "Inserted"
)
) 
OR 
IsDefined("RecIDParm")
)>

	<CFINCLUDE TEMPLATE="sectionheadings.cfset.cfm">

</cfif>


<tr>

<th align="right" valign="top">
Case Name
</th>

<td>

<CFOUTPUT>
<input type="text" name="CASE_NAME" size="65"  maxlength="254" value="#Trim(CASE_NAME)#">
</cfoutput>

</td>

</tr>

<tr>

<th align="right" valign="top">
Case Number
</th>

<td>

<CFOUTPUT>
<input type="text" name="CASE_NUMBER" size="65"  maxlength="254" value="#Trim(CASE_NUMBER)#">
</cfoutput>

</td>

</tr>


<tr>

<th align="right" valign="top">
<!---
<span style="color:red; font-size:9pt">[NEW]</span>&nbsp;
--->

Matter Number
<div style="font-size:8pt; font-style:italic; font-weight:normal">

<CFIF LM_MATTER_KEY NEQ "">

<!---
	<CFOUTPUT>
	(<a href="https://56.207.31.151/lawmanager.net/exec/httpsrvr.dll/main?NB=MatterAllWS&QRY=|matter_key%3D#LM_MATTER_KEY#|&TYP=detail&HTYP=edit" target="_blank">LawManager</a>)
	</CFOUTPUT>
--->

<!---
https://lawdept2.usps.gov/lmWeb/tabular.jsp?NB=MatterAllWS&QRY=|matter_key%3D889839
--->


	<CFOUTPUT>
    (<a href="https://lawdept2.usps.gov/lmWeb/tabular.jsp?NB=MatterAllWS&QRY=|matter_key%3D#LM_MATTER_KEY#" target="_blank">LawManager</a>)
	</CFOUTPUT>


<CFELSE>

	(LawManager)

</CFIF>

</div>
</th>

<td>

<CFOUTPUT>
<input type="text" name="LM_MATTER_NUMBER" size="65"  maxlength="254" value="#Trim(LM_MATTER_NUMBER)#">
</cfoutput>


<div style="font-family:verdana; font-size:7.5pt; font-style:italic">

<CFIF LM_MATTER_NUMBER NEQ "" AND LM_MATTER_KEY EQ "">

	<span style="color:red; font-weight:bold; font-style:italic">
	[Matter Number not found in LawManager. Please verify and correct.]
	</span>

<CFELSE>

	Up to 11 characters. Leave blank if not applicable.

</cfif>

</div>


<CFOUTPUT>
<input type="hidden" name="LM_MATTER_KEY" value="#LM_MATTER_KEY#">
</cfoutput>



</td>

</tr>



<tr>

<th align="right" valign="top">
Case Type
</th>

<td>

<CFLOOP INDEX="CASE_TYPE_Index" FROM="1" TO="2">

	<CFIF CASE_TYPE GT 10>
		<CFSET CASE_TYPE_Display = CASE_TYPE - 10>
	<CFELSE>
		<CFSET CASE_TYPE_Display = CASE_TYPE>
	</cfif>
	
	<CFIF CASE_TYPE_Display EQ CASE_TYPE_Index>
		<CFSET SelectedWord = "CHECKED">
	<CFELSE>
		<CFSET SelectedWord = "">
	</cfif>
	
	<CFOUTPUT>
	<input type="radio" name="CASE_TYPE_Choice" value="#CASE_TYPE_Index#" #SelectedWord#>&nbsp;#ListGetAt(CASE_TYPE_LabelList, CASE_TYPE_Index)#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	</cfoutput>
	
</cfloop>

<CFOUTPUT>
<input type="hidden" name="CASE_TYPE" value="#CASE_TYPE#">
</cfoutput>


</td>

</tr>

<tr>

<th align="right" valign="top">
Category
</th>

<td>

<CFLOOP INDEX="CLAIM_CATEGORY_Index" FROM="1" TO="#ListLen(CLAIM_CATEGORY_Labels)#">

	<CFIF CLAIM_CATEGORY EQ CLAIM_CATEGORY_Index>
		<CFSET SelectedWord = "CHECKED">
	<CFELSE>
		<CFSET SelectedWord = "">
	</cfif>
	
	<CFOUTPUT>
	<input type="radio" name="CLAIM_CATEGORY" value="#CLAIM_CATEGORY_Index#" #SelectedWord#>&nbsp;#ListGetAt(CLAIM_CATEGORY_Labels, CLAIM_CATEGORY_Index)#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	</cfoutput>
	
</cfloop>


</td>

</tr>


<tr>

<th align="right" valign="top" style="padding-top:15pt; padding-bottom:15pt">

District /
<p style='margin-top:10pt'>
Division /
<p style='margin-top:10pt'>
HQ&nbsp;Dept

</th>

<td style="padding-top:15pt; padding-bottom:15pt">


<cfset prev_dist_perf_cluster_code = GetRecord_PrevRpt.DIST_PERF_CLUSTER_CODE>
<cfset prev_DIVISION_CODE = GetRecord_PrevRpt.DIVISION_CODE>
<CFSET This_DIST_PERF_CLUSTER_CODE = DIST_PERF_CLUSTER_CODE>


<CFSET DropdownList = "District">


<SELECT NAME="DIST_PERF_CLUSTER_CODE" style="font-family:arial; font-size:9pt; margin-top:2pt; margin-bottom:5pt; padding-bottom:1; background:khaki" SIZE="1">

<option value="0" style="color:white;background:maroon">Select a District . . .

<CFINCLUDE TEMPLATE="areas.districts.dropdown.FromTable.cfm">

</select>


<CFIF Get_Divisions.RecordCount GT 0>

	<CFSET DropdownList = "Division">

	<br />
    


	<CFSET This_Division_Code = DIVISION_CODE>

<!---
	<CFSET This_Division_Name = NAME>
--->

	<SELECT NAME="DIVISION_CODE" style="font-family:arial; font-size:9pt; margin-top:2pt; margin-bottom:5pt; padding-bottom:1; background:khaki" SIZE="1">

	<option value="0" style="color:white;background:maroon">Select a Division . . .

	<CFINCLUDE TEMPLATE="areas.districts.dropdown.FromTable.cfm">

	</select>

</CFIF>



<br>


<CFSET This_HQ_AREA_NAME = AREA_NAME>


<SELECT NAME="HQ_AREA_NAME" id="HQ_AREA_NAME" style="font-family:arial; font-size:9pt; margin-top:0pt; padding-bottom:1; background:khaki" SIZE="1" onChange="checkHQ_AREA_NAME(this)">

<option value="0" style="color:white;background:maroon">Select a Headquarters Department . . .

<CFINCLUDE TEMPLATE="hq.dept.dropdown.FromTable.cfm">

</select>



</td>

</tr>


<tr id="Unions_Selected_Row"

<CFIF This_HQ_AREA_NAME EQ "HQ Labor Relations">

	style="color:maroon">

<CFELSE>

	style="display:none; color:maroon">

</cfif>



<th align="right" valign="top">
Union(s)


<div style="color:white; background:maroon; font-size:8pt; font-style:italic; padding:2pt">
Select all that apply
</div>

</th>

<td valign="top" style="background:ffffcc">

<div id="Unions_List_Div" style="margin-bottom:10pt">

<CFSET This_UNIONS_SELECTED_List = UNIONS_SELECTED>


<CFLOOP INDEX="Unions_List_Loop_Index" FROM="1" TO="#Unions_List_Loop_Max#">

	<CFSET Unions_List_Loop_Start = ((Unions_List_Loop_Index - 1) * Unions_List_BreakPt) + 1>
	
	<CFSET Unions_List_Loop_End = Unions_List_Loop_Index * Unions_List_BreakPt>
	
	<CFIF Unions_List_Loop_End GT ListLen(Unions_List)>
		<CFSET Unions_List_Loop_End = ListLen(Unions_List)>
	</CFIF>
	
	<CFSET Unions_List_Span_LeftOffset = (Unions_List_Loop_Index - 1) * Unions_List_Span_Width>
	
	
	<CFOUTPUT>
	<span id="Unions_List_Span_#Unions_List_Loop_Index#" style="width:#Unions_List_Span_Width#%; left:#Unions_List_Span_LeftOffset#pt; vertical-align:top">
	</cfoutput>
	
	
	<CFLOOP INDEX="Unions_List_Index" FROM="#Unions_List_Loop_Start#" TO="#Unions_List_Loop_End#">
	
		<CFIF ListFind(This_UNIONS_SELECTED_List, ListGetAt(Unions_List, Unions_List_Index)) GT 0>
			<CFSET Unions_Selected_CheckedWord = "CHECKED">
		<CFELSE>
			<CFSET Unions_Selected_CheckedWord = "">
		</CFIF>
		
		
		<CFOUTPUT>
		<input type="checkbox" name="Unions_Selected" value="#ListGetAt(Unions_List, Unions_List_Index)#" #Unions_Selected_CheckedWord#>#ListGetAt(Unions_List, Unions_List_Index)#
		</CFOUTPUT>
		
		<br />
	
	</CFLOOP>
	
	
	</span>


</CFLOOP>


<input type="hidden" name="Unions_Selected_ALL" />



</div id="Unions_List_Div">


</td>


</tr>


<tr>

<th align="right" valign="top">
Date Filed
</th>

<td>

<CFOUTPUT>
<input type="text" name="DATE_FILED" id="DATE_FILED" size="10" maxlength="10" value="#DateFormat(DATE_FILED, "mm/dd/yyyy")#" style="width:60pt;height:14pt; text-align:right" onBlur="checkDateAsTyped(#CONTINGENT_LIAB_GetRecord.CurrentRow#)" onClick="clearUnknown(#CONTINGENT_LIAB_GetRecord.CurrentRow#, this.name, 'Date Filed')">

<CFSET Calendar_Count = Calendar_Count + 1>

<img src="cal.gif" alt="Display Calendar" onClick="javascript:cal#Calendar_Count#.popup();">
</cfoutput>

<small><i>(mm/dd/yyyy)</i></small>


<CFLOOP INDEX="DATE_FILED_UNKNOWN_Index" FROM="1" TO="#ListLen(Unknown_NA_List)#">

	&nbsp;&nbsp;
	
	<CFIF DATE_FILED_UNKNOWN EQ DATE_FILED_UNKNOWN_Index>
		<CFSET CheckedWord = "Checked">
	<CFELSE>
		<CFSET CheckedWord = "">
	</cfif>
	
	<CFOUTPUT>
	<input type="radio" name="DATE_FILED_UNKNOWN" value="#DATE_FILED_UNKNOWN_Index#" #CheckedWord#>#ListGetAt(Unknown_NA_List, DATE_FILED_UNKNOWN_Index)#
	</cfoutput>
	
</cfloop>


</td>

</tr>

<tr>

<th align="right" valign="top">
Amount Sought
</th>

<td>

<CFIF AMOUNT_SOUGHT NEQ "">

	<CFSET AMOUNT_SOUGHT_DisplayAmt = AMOUNT_SOUGHT / OneMillion>

	<CFOUTPUT>
	
	$<input type="text" name="AMOUNT_SOUGHT" size="6" maxlength="8" value="#NumberFormat(AMOUNT_SOUGHT_DisplayAmt, '_._')#" style="width:38pt; height:14pt; text-align:right" onClick="clearUnknown(#CONTINGENT_LIAB_GetRecord.CurrentRow#, this.name, 'Amount Sought')" onBlur="checkAmtAsTyped(this.name, 'Amount Sought', #CONTINGENT_LIAB_GetRecord.CurrentRow#)">&nbsp;Million
	
	</cfoutput>
	
	
	<CFSET AMOUNT_SOUGHT_Orig_Value = NumberFormat(AMOUNT_SOUGHT_DisplayAmt, '_._')>

<CFELSE>

	<CFOUTPUT>
	$<input type="text" name="AMOUNT_SOUGHT" size="6" maxlength="8" value="" style="width:38pt; height:14pt; text-align:right" onClick="clearUnknown(#CONTINGENT_LIAB_GetRecord.CurrentRow#, this.name, 'Amount Sought')" onBlur="checkAmtAsTyped(this.name, 'Amount Sought', #CONTINGENT_LIAB_GetRecord.CurrentRow#)">&nbsp;Million
	</cfoutput>
	
	<CFSET AMOUNT_SOUGHT_Orig_Value = "">

</cfif>



<CFOUTPUT>
<input type="hidden" name="AMOUNT_SOUGHT_Orig" value="#AMOUNT_SOUGHT_Orig_Value#">
</cfoutput>


<CFIF AMOUNT_SOUGHT_UPPER NEQ "">
	<CFSET AMOUNT_SOUGHT_UPPER_DisplayAmt = AMOUNT_SOUGHT_UPPER / OneMillion>
	<CFSET AMOUNT_SOUGHT_UPPER_Orig_Value = NumberFormat(AMOUNT_SOUGHT_UPPER_DisplayAmt, '_._')>
<CFELSE>
	<CFSET AMOUNT_SOUGHT_UPPER_Orig_Value = "">
</cfif>

<CFSET AMOUNT_SOUGHT_UPPER_Field_Value = AMOUNT_SOUGHT_UPPER_Orig_Value>

<CFIF AMOUNT_SOUGHT_UPPER_Field_Value EQ "">

	<span id="AMOUNT_SOUGHT_RangeLink" style="margin-left:10pt; font-size:8pt; color:maroon">
	[<a href="" style="text-decoration:none" onClick="document.getElementById('AMOUNT_SOUGHT_HighEnd').style.display='inline'; document.getElementById('AMOUNT_SOUGHT_RangeLink').style.display='none'; return false">Range</a>]
	</span>
	
	<span id="AMOUNT_SOUGHT_HighEnd" style="margin-left:10pt; display:none">

<CFELSE>

	<span id="AMOUNT_SOUGHT_HighEnd" style="margin-left:10pt">

</cfif>

<CFOUTPUT>
<b>High End:</b> $<input type="text" name="AMOUNT_SOUGHT_UPPER" size="6" maxlength="8" value="#AMOUNT_SOUGHT_UPPER_Field_Value#" style="width:38pt; height:14pt; text-align:right" onClick="promptUpdateFacts('High End of Amount Sought Range')" onBlur="checkAmtAsTyped(this.name, 'Amount Sought / High End', #CONTINGENT_LIAB_GetRecord.CurrentRow#)">&nbsp;Million
</cfoutput>

</span>


<CFLOOP INDEX="AMOUNT_SOUGHT_UNKNOWN_Index" FROM="1" TO="#ListLen(Unknown_NA_List)#">

	<CFIF AMOUNT_SOUGHT_UNKNOWN EQ AMOUNT_SOUGHT_UNKNOWN_Index>
		<CFSET CheckedWord = "Checked">
	<CFELSE>
		<CFSET CheckedWord = "">
	</cfif>
	
	<CFOUTPUT>
	<input type="radio" name="AMOUNT_SOUGHT_UNKNOWN" style="margin-left:15pt" value="#AMOUNT_SOUGHT_UNKNOWN_Index#" #CheckedWord#>#ListGetAt(Unknown_NA_List, AMOUNT_SOUGHT_UNKNOWN_Index)#
	</cfoutput>
	
</cfloop>


<CFSET FormField = "Amount Sought">
<CFINCLUDE TEMPLATE="Instruc.Amount.cfm">


</td>

</tr>

<tr>

<th align="right" valign="top">

Liability
Assessment

</th>

<td>


<CFLOOP INDEX="ASSESSMENT_PROBABILITY_Index" FROM="1" TO="3">

	<CFIF ASSESSMENT_PROBABILITY EQ ASSESSMENT_PROBABILITY_Index>
		<CFSET SelectedWord = "CHECKED">
	<CFELSE>
		<CFSET SelectedWord = "">
	</cfif>
	
	<CFOUTPUT>
	<input type="radio" name="ASSESSMENT_PROBABILITY" value="#ASSESSMENT_PROBABILITY_Index#"  onClick="promptUpdateFacts('Liability Assessment')" #SelectedWord#>&nbsp;#ListGetAt(ASSESSMENT_PROBABILITY_LabelList, ASSESSMENT_PROBABILITY_Index)#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	</cfoutput>
	
</cfloop>

<CFOUTPUT>
<input type="hidden" name="ASSESSMENT_PROBABILITY_Orig" value="#ASSESSMENT_PROBABILITY#">
</cfoutput>


</td>

</tr>

<tr>

<th align="right" valign="top">


Damages
Assessment

</th>

<td>


<CFIF ASSESSMENT_AMOUNT NEQ "">
	<CFSET ASSESSMENT_AMOUNT_DisplayAmt = ASSESSMENT_AMOUNT / OneMillion>
   	<CFSET ASSESSMENT_AMOUNT_Orig_Value = NumberFormat(ASSESSMENT_AMOUNT_DisplayAmt, '_._')>
<CFELSE>
   	<CFSET ASSESSMENT_AMOUNT_Orig_Value = "">
</CFIF>


<CFSET ASSESSMENT_AMOUNT_Field_Value = ASSESSMENT_AMOUNT_Orig_Value>


<CFOUTPUT>

<li><b>Most Likely Payout</b> $<input type="text" name="ASSESSMENT_AMOUNT" size="6" maxlength="8" value="#ASSESSMENT_AMOUNT_Field_Value#" style="height:14pt; text-align:right" onClick="clearUnknown(#CONTINGENT_LIAB_GetRecord.CurrentRow#, this.name, 'Most Likely Payout')" onBlur="checkAmtAsTyped(this.name, 'Most Likely Payout', #CONTINGENT_LIAB_GetRecord.CurrentRow#)">&nbsp;Million

</cfoutput>




<CFIF ASSESSMENT_AMT_HIGH_END NEQ "">
	<CFSET ASSESSMENT_AMT_HIGH_END_DisplayAmt = ASSESSMENT_AMT_HIGH_END / OneMillion>
	<CFSET ASSESSMENT_AMT_HIGH_END_Orig_Value = NumberFormat(ASSESSMENT_AMT_HIGH_END_DisplayAmt, '_._')>
<CFELSE>
	<CFSET ASSESSMENT_AMT_HIGH_END_Orig_Value = "">
</cfif>

<CFSET ASSESSMENT_AMT_HIGH_END_Field_Value = ASSESSMENT_AMT_HIGH_END_Orig_Value>

<CFIF ASSESSMENT_AMT_HIGH_END_Field_Value EQ "">

	<span id="ASSESSMENT_AMOUNT_RangeLink" style="margin-left:10pt; font-size:8pt; color:maroon">
	[<a href="" style="text-decoration:none" onClick="document.getElementById('ASSESSMENT_AMOUNT_HighEnd').style.display='inline'; document.getElementById('ASSESSMENT_AMOUNT_RangeLink').style.display='none'; return false">Range</a>]
	</span>

	<span id="ASSESSMENT_AMOUNT_HighEnd" style="margin-left:10pt; display:none">

<CFELSE>

	<span id="ASSESSMENT_AMOUNT_HighEnd" style="margin-left:10pt">

</cfif>

<CFOUTPUT>
<b>High End:</b> $<input type="text" name="ASSESSMENT_AMT_HIGH_END" size="6" maxlength="8" value="#ASSESSMENT_AMT_HIGH_END_Field_Value#" style="height:14pt; text-align:right" onClick="promptUpdateFacts('High End of Most Likely Payout Range')" onBlur="checkAmtAsTyped(this.name, 'Most Likely Payout / High End', #CONTINGENT_LIAB_GetRecord.CurrentRow#)">&nbsp;Million
</cfoutput>

</span>


<CFLOOP INDEX="ASSESSMENT_AMT_UNKNOWN_Index" FROM="1" TO="1">

	<CFIF ASSESSMENT_AMT_UNKNOWN EQ ASSESSMENT_AMT_UNKNOWN_Index>
		<CFSET CheckedWord = "Checked">
	<CFELSE>
		<CFSET CheckedWord = "">
	</cfif>
	
	
	<CFOUTPUT>
	<input type="radio" style="margin-left:15pt" name="ASSESSMENT_AMOUNT_UNKNOWN" value="#ASSESSMENT_AMT_UNKNOWN_Index#" #CheckedWord#>#ListGetAt(Unknown_NA_List, ASSESSMENT_AMT_UNKNOWN_Index)#
	</cfoutput>

</cfloop>


<p style="margin-top:8pt">


<CFIF ASSESSMENT_AMOUNT_UPPER NEQ "">
	<CFSET ASSESSMENT_AMOUNT_UPPER_DisplayAmt = ASSESSMENT_AMOUNT_UPPER / OneMillion>
	<CFSET ASSESSMENT_AMOUNT_UPPER_Orig_Value = NumberFormat(ASSESSMENT_AMOUNT_UPPER_DisplayAmt, '_._')>
<CFELSE>
	<CFSET ASSESSMENT_AMOUNT_UPPER_Orig_Value = "">
</cfif>

<CFSET ASSESSMENT_AMOUNT_UPPER_Field_Value = ASSESSMENT_AMOUNT_UPPER_Orig_Value>


<!---
<CFOUTPUT>
<li><b>Maximum Reasonable Payout</b> $<input type="text" name="ASSESSMENT_AMOUNT_UPPER" size="6" maxlength="8" value="#ASSESSMENT_AMOUNT_UPPER_Field_Value#" style="height:14pt; text-align:right" onClick="promptUpdateFacts('Maximum Reasonable Payout')" onBlur="checkAmtAsTyped(this.name, 'Maximum Reasonable Payout', #CONTINGENT_LIAB_GetRecord.CurrentRow#)">&nbsp;Million</span>
</cfoutput>
--->



<!---

ASSESSMENT_AMT_MAX_UNKNOWN

Started with:
onClick="promptUpdateFacts('Maximum Reasonable Payout')"

From MLP:
onClick="clearUnknown(#CONTINGENT_LIAB_GetRecord.CurrentRow#, this.name, 'Most Likely Payout')" 


onClick="clearUnknown(#CONTINGENT_LIAB_GetRecord.CurrentRow#, 'ASSESSMENT_AMT_MAX_UNKNOWN', 'Maximum Reasonable Payout')" 

--->



<CFOUTPUT>
<li><b>Maximum Reasonable Payout</b> $<input type="text" name="ASSESSMENT_AMOUNT_UPPER" size="6" maxlength="8" value="#ASSESSMENT_AMOUNT_UPPER_Field_Value#" style="height:14pt; text-align:right" onClick="clearUnknown(#CONTINGENT_LIAB_GetRecord.CurrentRow#, 'ASSESSMENT_AMT_MAX', 'Maximum Reasonable Payout')" onBlur="checkAmtAsTyped(this.name, 'Maximum Reasonable Payout', #CONTINGENT_LIAB_GetRecord.CurrentRow#)">&nbsp;Million</span>
</cfoutput>










<CFIF ASSESSMENT_AMT_UPPER_HIGH_END NEQ "">
	<CFSET ASSESSMENT_AMT_UPPER_HIGH_END_DisplayAmt = ASSESSMENT_AMT_UPPER_HIGH_END / OneMillion>
	<CFSET ASSESSMENT_AMT_UPPER_HIGH_END_Orig_Value = NumberFormat(ASSESSMENT_AMT_UPPER_HIGH_END_DisplayAmt, '_._')>
<CFELSE>
	<CFSET ASSESSMENT_AMT_UPPER_HIGH_END_Orig_Value = "">
</cfif>

<CFSET ASSESSMENT_AMT_UPPER_HIGH_END_Field_Value = ASSESSMENT_AMT_UPPER_HIGH_END_Orig_Value>

<CFIF ASSESSMENT_AMT_UPPER_HIGH_END_Field_Value EQ "">

	<span id="ASSESSMENT_AMOUNT_UPPER_RangeLink" style="margin-left:10pt; font-size:8pt; color:maroon">
	[<a href="" style="text-decoration:none" onClick="document.getElementById('ASSESSMENT_AMOUNT_UPPER_HighEnd').style.display='inline'; document.getElementById('ASSESSMENT_AMOUNT_UPPER_RangeLink').style.display='none'; return false">Range</a>]
	</span>

	<span id="ASSESSMENT_AMOUNT_UPPER_HighEnd" style="margin-left:10pt; display:none">

<CFELSE>

	<span id="ASSESSMENT_AMOUNT_UPPER_HighEnd" style="margin-left:10pt">

</cfif>

<CFOUTPUT>
<b>High End:</b> $<input type="text" name="ASSESSMENT_AMT_UPPER_HIGH_END" size="6" maxlength="8" value="#ASSESSMENT_AMT_UPPER_HIGH_END_Field_Value#" style="height:14pt; text-align:right" onClick="promptUpdateFacts('High End of Maximum Reasonable Payout Range')" onBlur="checkAmtAsTyped(this.name, 'Maximum Reasonable Payout / High End', #CONTINGENT_LIAB_GetRecord.CurrentRow#)">&nbsp;Million
</cfoutput>

</span>



<CFLOOP INDEX="ASSESSMENT_AMT_MAX_UNKNOWN_Index" FROM="1" TO="1">

	<CFIF ASSESSMENT_AMT_MAX_UNKNOWN EQ ASSESSMENT_AMT_MAX_UNKNOWN_Index>
		<CFSET CheckedWord = "Checked">
	<CFELSE>
		<CFSET CheckedWord = "">
	</cfif>
	
	<CFOUTPUT>
	<input type="radio" style="margin-left:15pt" name="ASSESSMENT_AMT_MAX_UNKNOWN" value="#ASSESSMENT_AMT_MAX_UNKNOWN_Index#" #CheckedWord#>#ListGetAt(Unknown_NA_List, ASSESSMENT_AMT_MAX_UNKNOWN_Index)#
	</cfoutput>

</cfloop>


<p style="margin-top:5pt">

<CFSET FormField = "Assessment Amount">
<CFINCLUDE TEMPLATE="Instruc.Amount.cfm">


<CFOUTPUT>
<input type="hidden" name="ASSESSMENT_AMOUNT_Orig" value="#ASSESSMENT_AMOUNT_Orig_Value#">
<input type="hidden" name="ASSESSMENT_AMT_HIGH_END_Orig" value="#ASSESSMENT_AMT_HIGH_END_Orig_Value#">

<input type="hidden" name="ASSESSMENT_AMOUNT_UPPER_Orig" value="#ASSESSMENT_AMOUNT_UPPER_Orig_Value#">
<input type="hidden" name="ASSESSMENT_AMT_UPPER_HIGH_END_Orig" value="#ASSESSMENT_AMT_UPPER_HIGH_END_Orig_Value#">
</cfoutput>

</td>

</tr>



