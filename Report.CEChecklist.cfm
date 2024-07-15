<cfinclude template="MfaCookieCheck.cfm">

<!------------------------- Report.CECheckList.cfm --------------------------->
<!---------------------------------------------------------------------------->
<!--- KS1 --->
	<!---<CFOUTPUT>
		Program = "Report.CECheckList.cfm at 4"
	</CFOUTPUT>--->
<tr>

<CFQUERY NAME="Get_Checklist_Reponses" DATASOURCE="contliab">

SELECT *
FROM CONTINGENT_LIAB_C_E_CHECKLIST
WHERE CASE_REC_ID_SEQUENCE = #CASE_REC_ID_SEQUENCE#

</cfquery>


<th align="right" valign="top">

<CFOUTPUT>
<div id="CaseEvaluationChecklistHeader_#This_CurrentRow#">
</cfoutput>

<CFIF Get_MC_APPR_FLAG.RecordCount EQ 1 AND GetMC.RecordCount EQ 1>
Case Evaluation Checklist

<CFELSEIF Get_Checklist_Reponses.RecordCount EQ 1>

<CFOUTPUT>
See <a href="" onClick="showCaseEvaluationChecklistDiv(#This_CurrentRow#); return false"><b>Case Evaluation Checklist</b></a>
</cfoutput>

<CFELSE>

<span style="color:gray; font-size:8pt; font-weight:normal">
[No&nbsp;Case&nbsp;Evaluation&nbsp;Checklist]
</span>

</cfif>

</div>

</th>

<CFIF Get_Checklist_Reponses.RecordCount NEQ 1>

<td>

<CFELSE>

<CFIF Get_MC_APPR_FLAG.RecordCount EQ 1 AND GetMC.RecordCount EQ 1>

<CFOUTPUT>
<td id="CaseEvaluationChecklist_#This_CurrentRow#" style="display:inline; background:ffd5aa; padding:5pt">
</cfoutput>

<CFELSE>

<CFOUTPUT>
<td id="CaseEvaluationChecklist_#This_CurrentRow#" style="display:none; background:ffd5aa; padding:5pt">
</cfoutput>

</cfif>

<!---
<CFOUTPUT>
<div id="CaseEvaluationChecklist_#This_CurrentRow#" style="display:none; background:ffd5aa; padding:3pt">
</cfoutput>
--->

<b>Forum:</b>

<CFIF Trim(Get_Checklist_Reponses.FORUM) NEQ "">

<CFOUTPUT>
<b>#Trim(Get_Checklist_Reponses.FORUM)#</b>
</cfoutput>

<CFELSE>
_____
</cfif>

<p>

<b>Client:</b>

<CFIF Trim(Get_Checklist_Reponses.CLIENT) NEQ "">

<CFOUTPUT>
<b>#Trim(Get_Checklist_Reponses.CLIENT)#</b>
</cfoutput>

<CFELSE>
_____
</cfif>

<p>


<CFLOOP QUERY="Get_AllQuesNum">

<CFOUTPUT>
<b>#QUESNUM_TRIM#.</b> #QUESTEXT_TRIM#
</cfoutput>


<CFSET ThisQuesField = "Get_Checklist_Reponses.QUES_" & QUESNUM_TRIM>

<CFSET ThisQuesFieldValue = Evaluate(ThisQuesField)>

<CFSWITCH EXPRESSION="#ThisQuesFieldValue#">

<CFCASE VALUE="0">
	<CFSET ThisQuesFieldValueText = "<b>Not Applicable</b>">
</cfcase>

<CFCASE VALUE="1">
	<CFSET ThisQuesFieldValueText = "<b>Yes</b>">
</cfcase>

<CFCASE VALUE="2">
	<CFSET ThisQuesFieldValueText = "<b>No</b>">
</cfcase>

<CFCASE VALUE="9">
	<CFSET ThisQuesFieldValueText = "<b>Unknown At This Time</b>">
</cfcase>

<CFDEFAULTCASE>
	<CFSET ThisQuesFieldValueText = "[No&nbsp;response]">
</CFDEFAULTCASE>

</cfswitch>

<CFOUTPUT>
#ThisQuesFieldValueText#
</cfoutput>

<p>

</cfloop>


</cfif>

<!---
</div>
--->

</td>
</tr>




