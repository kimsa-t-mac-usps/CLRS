<cfinclude template="MfaCookieCheck.cfm">

<!--- Query CONTINGENT_LIAB_GetRecord in EditRecord.ptA --->


<tr>

<th align="right" valign="top">

<!---
<span style="color:red; font-size:9pt">[NEW]</span>&nbsp;
--->

Change in
Status

<!---
<CFOUTPUT>
<br />
Before: STATUS_CODE = "#STATUS_CODE#"
<p></p>
</CFOUTPUT>
--->

<!---
<!--- Default STATUS_CODE = 2 (No Change) --->
<CFIF STATUS_CODE EQ "">
	<CFSET This_STATUS_CODE = 2>
<CFELSE>
	<CFSET This_STATUS_CODE = 0>
</CFIF>
--->



<!--- Default STATUS_CODE = 0 (No code) --->
<CFSET This_STATUS_CODE = 0>



<!---
<CFOUTPUT>
<br />
After: STATUS_CODE = "#STATUS_CODE#"
<br />
This_STATUS_CODE = "#This_STATUS_CODE#"
<p></p>
</CFOUTPUT>
--->

<CFIF NOT (STATUS_CODE EQ 1 OR STATUS_CODE_SELECTED EQ "1")>

<!---
<div style="font-size:8pt; width:100pt; margin-top:3pt; color:white; background:maroon; padding:2pt">
--->

<div style="color:white; background:maroon; font-size:8pt; font-style:italic; padding:2pt">
Select all that apply
</div>

</cfif>

</th>

<td>


<CFIF STATUS_CODE_SELECTED NEQ "">
	<CFSET STATUS_CODE_SELECTED_Sorted = ListSort(STATUS_CODE_SELECTED, "Numeric")>
<CFELSE>
	<CFSET STATUS_CODE_SELECTED_Sorted = "">
</CFIF>


<CFIF STATUS_CODE EQ 1 OR STATUS_CODE_SELECTED EQ "1">


<CFOUTPUT>
<input type="hidden" name="STATUS_CODE" value="1"><b>New This Quarter</b>
</cfoutput>

<br>

<CFELSE>



<CFQUERY NAME="CONTINGENT_LIAB_GetRecord_PrevRpt" DATASOURCE="contliab">

SELECT ASSESSMENT_PROBABILITY,
AMOUNT_SOUGHT,
ASSESSMENT_AMOUNT,
ASSESSMENT_AMOUNT_UPPER,
PAYOUT_AMOUNT,
SHORT_TERM_LIABILITY

FROM CONTINGENT_LIAB_REPORT
WHERE DATE_REPORT = to_date('#DateFormat(PrevReportDate, "mm/dd/yyyy")#', 'mm/dd/yyyy')
AND CASE_REC_ID_SEQUENCE = #CASE_REC_ID_SEQUENCE#

</cfquery>


<CFIF STATUS_CODE_SELECTED_Sorted NEQ "">

<script language="javascript">

<CFOUTPUT>
prevButtonValue = #ListLast(STATUS_CODE_SELECTED_Sorted)#;
</CFOUTPUT>

</script>


<CFELSEIF STATUS_CODE NEQ "">

<script language="javascript">

<CFOUTPUT>
prevButtonValue = #STATUS_CODE#;
</CFOUTPUT>

</script>


<CFELSE>

<script language="javascript">

<CFOUTPUT>
prevButtonValue = 0;
</CFOUTPUT>

</script>


</CFIF>



<CFOUTPUT>
<input type="hidden" name="STATUS_CODE_SELECTED_Orig" value="#STATUS_CODE_SELECTED#">
</cfoutput>



<input type="hidden" name="STATUS_CODE_SELECTED_ALL" />




<CFSET CheckedWord_Array = ArrayNew(1)>

<!--- Initialize array: --->
<CFSET temp = ArraySet(CheckedWord_Array, 1, Status_Code_Max, "")>



<!---
<CFOUTPUT>
STATUS_CODE_SELECTED_Sorted = "#STATUS_CODE_SELECTED_Sorted#"
<p></p>
</CFOUTPUT>
--->


<CFIF STATUS_CODE_SELECTED_Sorted EQ "">

<!--- Use Default STATUS_CODE if any --->

<CFIF This_STATUS_CODE EQ 2>

	<CFLOOP INDEX="Status_Code_List_Index" LIST="#This_STATUS_CODE#">
	<CFSET CheckedWord_Array[Status_Code_List_Index] = "CHECKED">
	</CFLOOP>


<CFELSE>

	<CFLOOP INDEX="Status_Code_List_Index" LIST="#STATUS_CODE#">
	<CFSET CheckedWord_Array[Status_Code_List_Index] = "CHECKED">
	</CFLOOP>


</CFIF>


<CFELSE>


<CFLOOP INDEX="Status_Code_List_Index" LIST="#STATUS_CODE_SELECTED_Sorted#">

<CFSET CheckedWord_Array[Status_Code_List_Index] = "CHECKED">

</CFLOOP>


</CFIF>


<!--- ListRest removes "New This Quarter" from checkbox choices: --->
<CFLOOP INDEX="Status_Code_Loop_Index" LIST="#ListRest(Status_Code_Order)#">

<CFIF Status_Code_Loop_Index EQ 11>
<div style="background:ffd5aa; margin-top:3pt; margin-bottom:-75pt; padding-top:2pt; padding-bottom:0pt; width:80%">
</CFIF>


<CFSET Status_Code_Form_Value = Status_Code_Loop_Index>
<CFSET Status_Code_Var = Status_Code_Form_Value>
<CFINCLUDE TEMPLATE="cfswitch.status_code.cfm">

<CFSET ThisCheckedWord = CheckedWord_Array[Status_Code_Form_Value]>

<CFIF Status_Code_Label NEQ "[Unused]">

<CFOUTPUT>
<input type="checkbox" name="STATUS_CODE" id="STATUS_CODE_#Status_Code_Form_Value#" value="#Status_Code_Form_Value#" onClick="uncheckNoChange(this.value); hideShowButton('#HideShowButton_String#', #CONTINGENT_LIAB_GetRecord.CurrentRow#, this.value)" #ThisCheckedWord# />#Status_Code_Label#
</CFOUTPUT>

<br />

</CFIF>


</CFLOOP>



<div style="font-family:verdana; color:maroon; padding:5pt; padding-bottom:3pt; margin:0pt; position:relative; left:215pt; top:-75pt; width:115pt; height:74pt; font-size:8pt">

These <b>Status</b> options apply <b>only</b> if this case is to be <b>removed</b> after the current report 

<CFOUTPUT>
(#RptDateFmtString#). 
</CFOUTPUT>


<CFIF ListLast(STATUS_CODE_SELECTED_Sorted) LE 10>
<br />
[Click the <b>Remove&nbsp;This&nbsp;Case</b> button when you finish.]
</cfif>

</div>


<CFOUTPUT>
<div id="clickRemoveSpan_#CONTINGENT_LIAB_GetRecord.CurrentRow#" style="font-family:verdana; position:relative; background:maroon; color:white; display:none; padding:5pt; padding-top:2pt; font-size:8pt; top:-70pt; margin-bottom:5pt">

Please make an appropriate entry in the <b>Payout Amount</b> field and in the <b>Payout Date</b> field below.

<div id="clickRemoveSpanAlso_#CONTINGENT_LIAB_GetRecord.CurrentRow#">
Also, click the <b>Remove This Case</b> button when you finish making changes to this record.
</div> 

</div>
</cfoutput>

</div>

</cfif>

</td>

</tr>



<CFOUTPUT>
<tr id="Payout_Amt_#CONTINGENT_LIAB_GetRecord.CurrentRow#"
</cfoutput>

<!---
<CFIF STATUS_CODE EQ 12 OR STATUS_CODE EQ 13>
--->


<CFIF ListContains(STATUS_CODE_SELECTED_Sorted, 12) GT 0 
OR
ListContains(STATUS_CODE_SELECTED_Sorted, 13) GT 0>

style="color:maroon">

<CFELSE>

style="display:none; color:maroon">

</cfif>


<th align="right" valign="top" style="padding-top:5pt">
Payout Amount
</th>

<td style="padding-top:5pt">

<CFIF PAYOUT_AMOUNT NEQ "">

	<CFSET PAYOUT_AMOUNT_DisplayAmt = PAYOUT_AMOUNT / OneMillion>
    <CFSET PAYOUT_AMOUNT_DisplayAmt = NumberFormat(PAYOUT_AMOUNT_DisplayAmt, '_._')>
	<CFSET PAYOUT_AMOUNT_Orig_Value = PAYOUT_AMOUNT_DisplayAmt>

<CFELSE>

	<CFSET PAYOUT_AMOUNT_DisplayAmt = "">
	<CFSET PAYOUT_AMOUNT_Orig_Value = "">

</cfif>


<CFOUTPUT>

$<input type="text" name="PAYOUT_AMOUNT" size="4" maxlength="6" value="#PAYOUT_AMOUNT_DisplayAmt#" style="width:38pt; height:14pt; text-align:right" onClick="promptUpdateFacts('Payout Amount')" onBlur="checkAmtAsTyped(this.name, 'Payout Amount', #CONTINGENT_LIAB_GetRecord.CurrentRow#)">&nbsp;Million

<input type="hidden" name="PAYOUT_AMOUNT_Orig" value="#PAYOUT_AMOUNT_Orig_Value#">

</cfoutput>



<CFIF PAYOUT_LT_100K EQ 1>
	<CFSET CheckedWord_LT_100K = "CHECKED">
	<CFSET CheckedWord_NA = "">
<CFELSEIF PAYOUT_LT_100K EQ 2>
	<CFSET CheckedWord_LT_100K = "">
	<CFSET CheckedWord_NA = "CHECKED">
<CFELSE>
	<CFSET CheckedWord_LT_100K = "">
	<CFSET CheckedWord_NA = "">
</cfif>

<CFOUTPUT>
<input type="checkbox" name="PAYOUT_LT_100K" style="margin-left:15pt" value="1" onClick="CaseForm_#CONTINGENT_LIAB_GetRecord.CurrentRow#.PAYOUT_NA.checked=false" #CheckedWord_LT_100K#>Less than $100,000
</cfoutput>

<CFOUTPUT>
<input type="checkbox" name="PAYOUT_NA" style="margin-left:15pt" value="2" onClick="CaseForm_#CONTINGENT_LIAB_GetRecord.CurrentRow#.PAYOUT_LT_100K.checked=false" #CheckedWord_NA#>None or N/A
</cfoutput>


<div style="font-size:8pt; font-style:italic; font-family:verdana">

<li><span style="font-weight:bold; font-style:normal">Payout Amount</span> in Millions with up to one decimal place and no comma. <li>If less than $1 Million, use decimal. E.g., for <b>$400,000</b>, use <b><u>0</u>.4</b>
<li>Leave <span style="font-weight:bold; font-style:normal">Payout Amount</span> field <b>blank</b> if selecting "Less than $100,000" or "None or N/A."

</div>

</td>

</tr>


<CFOUTPUT>
<tr id="Payout_Date_#CONTINGENT_LIAB_GetRecord.CurrentRow#"
</cfoutput>


<!---
<CFIF STATUS_CODE EQ 12 OR STATUS_CODE EQ 13>
--->


<CFIF ListContains(STATUS_CODE_SELECTED_Sorted, 12) GT 0 
OR
ListContains(STATUS_CODE_SELECTED_Sorted, 13) GT 0>

style="color:maroon">

<CFELSE>

style="color:maroon; display:none">

</cfif>


<th align="right" valign="top" style="padding-top:5pt; padding-bottom:15pt">
Payout Date
<br>
or
<br>
Date Finalized
</th>

<td style="padding-top:5pt">


<CFIF PAYOUT_DATE NEQ "">

    <CFSET PAYOUT_DATE_Display = DateFormat(PAYOUT_DATE, "mm/dd/yyyy")>
	<CFSET PAYOUT_DATE_Orig_Value = PAYOUT_DATE_Display>

<CFELSE>

	<CFSET PAYOUT_DATE_Display = "">
	<CFSET PAYOUT_DATE_Orig_Value = "">

</cfif>


<CFSET Calendar_Count = Calendar_Count + 1>


<CFOUTPUT>

<input type="text" name="PAYOUT_DATE" size="10" maxlength="10" value="#PAYOUT_DATE_Display#" style="width:60pt;height:14pt; text-align:right" onBlur="checkDateAsTyped(#CONTINGENT_LIAB_GetRecord.CurrentRow#)" onClick="promptUpdateFacts('Payout Date / Date Finalized')">

<input type="hidden" name="PAYOUT_DATE_Orig" value="#PAYOUT_DATE_Orig_Value#">

<img src="cal.gif" alt="Display Calendar" onClick="javascript:cal#Calendar_Count#.popup();">

</cfoutput>

<small><i>(mm/dd/yyyy)</i></small>

&nbsp;&nbsp;

<CFIF PAYOUT_DATE_NA EQ 1>
	<CFSET CheckedWord = "Checked">
<CFELSE>
	<CFSET CheckedWord = "">
</cfif>

<CFOUTPUT>
<input type="checkbox" name="PAYOUT_DATE_NA" value="1" #CheckedWord#>None or N/A
</cfoutput>

<div style="font-size:8pt; font-style:italic; font-family:verdana">

<li>Leave <span style="font-weight:bold; font-style:normal">Payout Date</span> field <b>blank</b> if selecting "None or N/A."

</div>




</td>

</tr>


<CFIF SHORT_TERM_LIABILITY EQ "" OR SHORT_TERM_LIABILITY EQ 1>

	<CFSET EstTimeResolnDivStyle = 'style="color:white; background:maroon; font-weight:bold; padding-top:3pt; padding-bottom:3pt; padding-left:3pt; width:135pt"'>
	<CFSET EstTimeResolnCellStyle = 'style="padding-top:10t"'>
<CFELSE>
	<CFSET EstTimeResolnDivStyle = "">
   	<CFSET EstTimeResolnCellStyle = 'style="padding-top:15pt"'>
</CFIF>



<tr>


<CFOUTPUT>
<th align="right" valign="top" #EstTimeResolnCellStyle#>
</CFOUTPUT>

<!---
<span style="color:red; font-size:9pt">[NEW]</span> 
--->

Estimated&nbsp;Time to Resolution

</th>


<CFOUTPUT>
<td #EstTimeResolnCellStyle#>
</CFOUTPUT>



<CFOUTPUT>
<div #EstTimeResolnDivStyle#>
</CFOUTPUT>


<CFIF IsDefined("CONTINGENT_LIAB_GetRecord_PrevRpt.RecordCount")
AND
CONTINGENT_LIAB_GetRecord_PrevRpt.RecordCount GT 0>

	<CFSET This_SHORT_TERM_LIABILITY_Orig = CONTINGENT_LIAB_GetRecord_PrevRpt.SHORT_TERM_LIABILITY>

<CFELSE>

	<CFSET This_SHORT_TERM_LIABILITY_Orig = "">

</CFIF>




<CFSET Estimated_Time_Resolution_ValueList_Ct = 1>

<CFLOOP INDEX="SHORT_TERM_LIABILITY_Index" LIST="#Estimated_Time_Resolution_ValueList#">


<CFIF SHORT_TERM_LIABILITY EQ SHORT_TERM_LIABILITY_Index>
	<CFSET SelectedWord = "CHECKED">
<CFELSE>
	<CFSET SelectedWord = "">
</cfif>


<CFOUTPUT>

<input type="radio" name="SHORT_TERM_LIABILITY" value="#SHORT_TERM_LIABILITY_Index#" onClick="checkSHORT_TERM_LIABILITY_Selected(this.form)" #SelectedWord#>&nbsp;#ListGetAt(Estimated_Time_Resolution_LabelList, Estimated_Time_Resolution_ValueList_Ct)#


</cfoutput>



<CFIF SHORT_TERM_LIABILITY_Index NEQ This_SHORT_TERM_LIABILITY_Orig>


<CFIF SelectedWord EQ "CHECKED">
	<CFSET STL_Chg_Display = "inline">
<CFELSE>
	<CFSET STL_Chg_Display = "none">
</cfif>


<CFOUTPUT>

<div id="SHORT_TERM_LIABILITY_Chg_Div_#SHORT_TERM_LIABILITY_Index#" style="position:absolute;  left:280pt; width:200pt; margin-top:2pt; color:maroon; font-weight:bold; display: #STL_Chg_Display#">

</CFOUTPUT>

<<<&nbsp;&nbsp;Change from Last Report

</div>



</CFIF>


<br />




<CFSET Estimated_Time_Resolution_ValueList_Ct = Estimated_Time_Resolution_ValueList_Ct + 1>

</cfloop>





<CFOUTPUT>
<input type="hidden" name="SHORT_TERM_LIABILITY_Orig" value="#This_SHORT_TERM_LIABILITY_Orig#">
</CFOUTPUT>





</div>

</td>

</tr>


<!--- If a Labor case --->
<CFIF CLAIM_CATEGORY EQ 2>

<tr>


<CFOUTPUT>
<th align="right" valign="top" style="padding-top:10pt">
</CFOUTPUT>

<!---
<span style="color:red; font-size:9pt">[NEW]</span> 
--->

If&nbsp;Field&nbsp;Grievance, held in abeyance?


<td style="padding-top:10pt">

<b>If this is a field grievance,</b> is it being held in abeyance pending resolution of a national-level dispute?

<br />


<CFLOOP INDEX="YesNo_List_Index" LIST="#YesNo_List#">

<CFIF YesNo_List_Index EQ FIELD_GRIEVANCE_FLAG>
	<CFSET This_YesNo_CheckedWord = "CHECKED">
<CFELSE>
	<CFSET This_YesNo_CheckedWord = "">
</CFIF>


<CFIF YesNo_List_Index EQ "Y">

<nobr>

<CFOUTPUT>
<input type="radio" name="FIELD_GRIEVANCE_FLAG" value="#YesNo_List_Index#" #This_YesNo_CheckedWord# />
</CFOUTPUT>

Yes&nbsp;&nbsp;<b>>>></b>&nbsp;

<i>Enter GATS Number of National-level Case:</i> 

<CFOUTPUT>
<input type="text" name="NATL_GATS_NUMBER" size="40"  maxlength="520" value="#NATL_GATS_NUMBER#">
</cfoutput>

</nobr>


<CFELSE>

<p style="margin-top:0pt">

<CFOUTPUT>
<input type="radio" name="FIELD_GRIEVANCE_FLAG" value="#YesNo_List_Index#" #This_YesNo_CheckedWord# />
</CFOUTPUT>


<CFIF YesNo_List_Index EQ "N">
No

<CFELSEIF YesNo_List_Index EQ "0">
N/A

</CFIF>


</CFIF>



</CFLOOP>

<!--- Close <CFIF CLAIM_CATEGORY EQ 2> --->
</CFIF>


<tr>

<th align="right" valign="middle">
Law Dept Counsel

<!--- Flag where none selected because case currently assigned to former Ee, whose primarykey is not found among current Ees --->
<CFIF ListFind(ValueList(EeList.PRIMARYKEY), COUNSEL_LAW_DEPT) EQ 0>

	<div style="color:white; background:maroon; font-size:8pt; font-style:italic; padding:2pt">
	Select current Law Dept Counsel
	</div>

</CFIF>


</th>

<td>

<CFSET ThisCOUNSEL_LAW_DEPT = COUNSEL_LAW_DEPT>

<SELECT NAME="COUNSEL_LAW_DEPT" style="font-family:arial; font-size:9pt; margin-top:10pt; margin-bottom:5pt; padding-bottom:1; background:BFDFFF" SIZE="1">

<option value="0" style="color:white;background:6495ED">Select an employee . . .



<CFOUTPUT QUERY="EeList">

<CFIF PRIMARYKEY EQ ThisCOUNSEL_LAW_DEPT>
	<CFSET SelectedWord = "SELECTED">
<CFELSE>
	<CFSET SelectedWord = "">
</cfif>

<CFIF PRIMARYKEY NEQ 0 AND PRIMARYKEY NEQ "">
<option value="#PRIMARYKEY#" #SelectedWord#>#Trim(LASTNAME)#, #Trim(FIRSTNAME)#
</cfif>

</cfoutput>

</select>










</td>

</tr>

<tr>

<th align="right" valign="top">
Law Dept Co&#8209;Counsel
</th>

<td>

<CFSET ThisCOCOUNSEL_LAW_DEPT = COCOUNSEL_LAW_DEPT>

<SELECT NAME="COCOUNSEL_LAW_DEPT" style="font-family:arial; font-size:9pt; margin-top:0pt; margin-bottom:5pt; padding-bottom:1; background:FFD5AA" SIZE="1">

<option value="0" style="color:white;background:chocolate">Select an employee . . .

<CFOUTPUT QUERY="EeList">

<CFIF PRIMARYKEY EQ ThisCOCOUNSEL_LAW_DEPT>
	<CFSET SelectedWord = "SELECTED">
<CFELSE>
	<CFSET SelectedWord = "">
</cfif>

<CFIF PRIMARYKEY NEQ 0 AND PRIMARYKEY NEQ "">
<option value="#PRIMARYKEY#" #SelectedWord#>#Trim(LASTNAME)#, #Trim(FIRSTNAME)#
</cfif>

</cfoutput>

</select>

</td>

</tr>

<tr>

<th align="right" valign="top">
Law Dept Reporting Office
</th>

<td>






<CFSET ThisLAW_DEPT_OFFICE = LAW_DEPT_OFFICE>

<SELECT NAME="LAW_DEPT_OFFICE" style="font-family:arial; font-size:9pt; margin-top:0pt; margin-bottom:5pt; padding-bottom:1; background:CCFFCC" SIZE="1">

<option value="0" style="color:white; background:maroon">Select an office . . .

<CFSET Office_Selected_Flag = "">


<CFOUTPUT QUERY="LDOffices">

<CFIF OFFICE_PRM_KEY EQ ThisLAW_DEPT_OFFICE>
	<CFSET SelectedWord = "SELECTED">
    
    <CFSET Office_Selected_Flag = "yes">
    
<CFELSE>
	<CFSET SelectedWord = "">
</cfif>

<CFSET TrimOFFICE = Trim(OFFICE)>

<CFIF Left(TrimOFFICE, 9) EQ "Southeast">
	<CFSET TrimOFFICE = "Southeast">
</cfif>

<option VALUE="#OFFICE_PRM_KEY#" #SelectedWord#>#TrimOFFICE#

</cfoutput>

</select>

</div>



<CFIF Office_Selected_Flag NEQ "yes">

<!---
left:325pt; 
--->

<div style="position:absolute; left:450pt; font-family:verdana; font-size:7.5pt; margin-top:-25pt; margin-bottom:-13pt">

<div style="color:white; background:maroon; margin-top:0pt; padding:5pt; font-weight:bold">
<<< Select the Law Department Office
<br />
responsible for reporting this case.
</div>

</div>

</cfif>








</td>

</tr>

<tr>

<th align="right" valign="top">
Alternate Law Dept Office

<div style="font-size:8pt; font-style:italic; font-weight:normal">
(Read-only access)
</div>

</th>

<td>

<CFSET ThisALT_LAW_DEPT_OFFICE = ALT_LAW_DEPT_OFFICE>

<SELECT NAME="ALT_LAW_DEPT_OFFICE" style="font-family:arial; font-size:9pt; margin-top:0pt; margin-bottom:5pt; padding-bottom:1; background:66ccff" SIZE="1">

<option value="0" style="color:white; background:0099cc">Select an office . . .

<CFOUTPUT QUERY="LDOffices">

<CFIF OFFICE_PRM_KEY EQ ThisALT_LAW_DEPT_OFFICE>
	<CFSET SelectedWord = "SELECTED">
<CFELSE>
	<CFSET SelectedWord = "">
</cfif>

<CFSET TrimOFFICE = Trim(OFFICE)>

<CFIF Left(TrimOFFICE, 9) EQ "Southeast">
	<CFSET TrimOFFICE = "Southeast">
</cfif>

<option VALUE="#OFFICE_PRM_KEY#" #SelectedWord#>#TrimOFFICE#

</cfoutput>

</select>

</div>

</td>

</tr>

<tr>

<th align="right" valign="top">
Other Representative for USPS

<div style="font-size:8pt; font-style:italic; font-weight:normal">
(Non-Law Department)
</div>

</th>

<td>
<CFOUTPUT>
<input type="text" name="COUNSEL_OTHER" size="65"  maxlength="254" value="#Trim(COUNSEL_OTHER)#">
</cfoutput>
</td>

</tr>



