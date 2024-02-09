<cfinclude template="MfaCookieCheck.cfm">

<tr>

<CFIF Get_Checklist_Responses.RecordCount EQ 1>

<!---
<CFQUERY NAME="Get_AllQuesNum" DATASOURCE="lddb">
SELECT TRIM(QUESNUM) AS QUESNUM_TRIM, TRIM(QUESTEXT) AS QUESTEXT_TRIM, SORTORDER
FROM PCESSURVEYQUES
WHERE SURVEY LIKE 'Conting Liability Checklist%'
ORDER BY SORTORDER
</cfquery>
--->

<CFQUERY NAME="Get_AllQuesNum" DATASOURCE="lddb">
SELECT *
FROM VIEW_CONTING_GET_CHECKLISTQUES
</cfquery>




<CFSET StartQues_Arb = 19>
<CFSET EndQues_Arb = 20>

<CFSET StartQues_Tort = 21>
<CFSET EndQues_Tort = 32>

<CFSET StartQues_TortDeath = 33>
<CFSET EndQues_TortDeath = 37>

</cfif>

<CFIF Get_Checklist_Responses.RecordCount EQ 1>
	<th align="left" valign="top">
<CFELSE>
	<th align="right" valign="top">
</cfif>

<CFOUTPUT>
<a name="BkMark_CaseEvaluationChecklistHeader_#CONTINGENT_LIAB_GetRecord.CurrentRow#"></a>
<div id="CaseEvaluationChecklistHeader_#CONTINGENT_LIAB_GetRecord.CurrentRow#" style="background:ffd5aa; padding:5pt">
</cfoutput>

<CFIF Get_Checklist_Responses.RecordCount EQ 1>

<CFOUTPUT>
See <a href="" onClick="showCaseEvaluationChecklistDiv(#CONTINGENT_LIAB_GetRecord.CurrentRow#); return false"><b>Case Evaluation Checklist</b></a>
</cfoutput>

<CFELSE>

<span style="color:gray">
[No&nbsp;Case Evaluation&nbsp;Checklist]
</span>

</cfif>

</div>

</th>

<CFIF Get_Checklist_Responses.RecordCount NEQ 1>

<td>
&nbsp;

<CFELSE>

<form name="ChecklistForm" METHOD="POST" ACTION="EditRecord.Action.cfm">

<CFOUTPUT>
<td class="CaseEvaluationChecklist" id="CaseEvaluationChecklist_#CONTINGENT_LIAB_GetRecord.CurrentRow#" style="display:none; background:ffd5aa; padding:5pt">
</cfoutput>

<b>Forum</b>&nbsp;&nbsp;<CFOUTPUT><input type="text" name="FORUM" size="65"  maxlength="254" value="#Trim(Get_Checklist_Responses.FORUM)#"></cfoutput>
<p>
<b>Client</b>&nbsp;&nbsp;<CFOUTPUT><input type="text" name="CLIENT" size="65"  maxlength="254" value="#Trim(Get_Checklist_Responses.CLIENT)#"></cfoutput>
<p>



<CFLOOP QUERY="Get_AllQuesNum">

<CFIF SORTORDER EQ StartQues_Arb>

<div class="quesSet" style="background:bfdfff">
<CFOUTPUT>
<i><b>If this is a national arbitration, Questions #StartQues_Arb# - #EndQues_Arb# must be answered.</b></i>
</cfoutput>

<p>

<CFELSEIF SORTORDER EQ StartQues_Tort>

<div class="quesSet" style="background:ffffcc">
<CFOUTPUT>
<i><b>If this is a tort matter, Questions #StartQues_Tort# - #EndQues_Tort# must be answered.</b></i>
</cfoutput>

<p>

<CFELSEIF SORTORDER EQ StartQues_TortDeath>

<div class="quesSet" style="background:ffd5aa">
<CFOUTPUT>
<i><b>If this is a tort death matter, Questions #StartQues_TortDeath# - #EndQues_TortDeath# must be answered.</b></i>
</cfoutput>

<p>

</cfif>


<CFOUTPUT>
<b>#QUESNUM_TRIM#.</b> #QUESTEXT_TRIM#
</cfoutput>


<CFSET ThisQuesField = "Get_Checklist_Responses.QUES_" & QUESNUM_TRIM>

<CFSET ThisQuesFieldValue = Evaluate(ThisQuesField)>

<blockquote>

<CFSET ChecklistAnswerOptionsLabels_Counter = 0>

<CFLOOP INDEX="ChecklistAnswerOptionsList_Index" LIST="#ChecklistAnswerOptionsList#">

<CFSET ChecklistAnswerOptionsLabels_Counter = ChecklistAnswerOptionsLabels_Counter + 1>


<CFIF ChecklistAnswerOptionsList_Index EQ ThisQuesFieldValue>
	<CFSET CheckedWord = "CHECKED">
<CFELSE>
	<CFSET CheckedWord = "">
</cfif>

<CFIF ChecklistAnswerOptionsList_Index EQ "99">
<div style="position:relative; left:135; top:-80">
</cfif>

<CFOUTPUT>
<input type="radio" name="ChecklistResponse_#QUESNUM_TRIM#" value="#ChecklistAnswerOptionsList_Index#" #CheckedWord#>#ListGetAt(ChecklistAnswerOptionsLabels, ChecklistAnswerOptionsLabels_Counter)#<br>
</cfoutput>

<CFIF ChecklistAnswerOptionsList_Index EQ "99">
</div>
</cfif>

</cfloop>

</blockquote>

<CFIF SORTORDER EQ EndQues_Arb OR SORTORDER EQ EndQues_Tort OR SORTORDER EQ EndQues_TortDeath>
</div>
</cfif>


</cfloop>

<input TYPE="SUBMIT" NAME="ActionButton" VALUE="Update Checklist" style="width:100pt; margin-top:15pt">

<CFOUTPUT>
<input type="hidden" name="CASE_REC_ID_SEQUENCE" value="#CASE_REC_ID_SEQUENCE#">
<input type="hidden" name="RecID" value="#ThisRecID#">
<input type="hidden" name="RespondingUser_Id" value="#RespondingUser_Id#">
</cfoutput>

</form>

</cfif>


</td>
</tr>



