<cfinclude template="MfaCookieCheck.cfm">

<tr>

<th align="right" valign="top">

Facts / Positions

<div style="font-size:8pt; font-style:italic; font-weight:normal">
(Facts and status at the current time only)
</div>

</th>

<td>

<CFSET TrimFACTS_POSITIONS_LONG = Trim(FACTS_POSITIONS_LONG)>
<CFSET TrimFACTS_POSITIONS_LONG = Replace(TrimFACTS_POSITIONS_LONG,"\", "", "ALL")>
<CFSET TrimFACTS_POSITIONS_LONG = Replace(TrimFACTS_POSITIONS_LONG, "''''", "'", "ALL")>
<CFSET TrimFACTS_POSITIONS_LONG = Replace(TrimFACTS_POSITIONS_LONG, "''", "'", "ALL")>
<CFSET TrimFACTS_POSITIONS_LONG = Replace(TrimFACTS_POSITIONS_LONG, "<br>", "&##10;", "ALL")>

<CFSET TrimFACTS_POSITIONS_LONG_Len = Len(TrimFACTS_POSITIONS_LONG)>
<CFSET TextAreaRows = (TrimFACTS_POSITIONS_LONG_Len / 80) + 5>

<CFIF TextAreaRows GT 25>
	<CFSET TextAreaRows = 25>
</cfif>

<CFOUTPUT>
<textarea name="FACTS_POSITIONS_LONG" rows="#TextAreaRows#" cols="70" onClick="clearupdFactsFlagArray()" onFocus="clearupdFactsFlagArray()">#TrimFACTS_POSITIONS_LONG#</textarea>
</cfoutput>

</td>

</tr>






<tr>

<th align="right" valign="top">

Optional
CILO Spreadsheet Template for Supporting Calculations


</th>

<td valign="top" width="70%" background="#RowColorGreen#">


<CFSET ThisAttachFileIFrameHeight = 170>


<CFOUTPUT>
<div id="IFrameAttach" style="position:relative; background:#RowColorGreen#; margin-top:5pt; width:75%">
</CFOUTPUT>

<CFOUTPUT>
<iframe id="ThisAttachFileIFrame" name="ThisAttachFileIFrame"  src="AttachFile.cfm?CaseRecIDSeq=#CONTINGENT_LIAB_GetRecord.CASE_REC_ID_SEQUENCE#&RecIDParm=#RecIDParm#" width="100%" height="#ThisAttachFileIFrameHeight#" frameborder="0" scrolling="no" marginwidth="0" marginheight="0">
</iframe>
</cfoutput>

</div>



</td>
</tr>





<tr>

<th align="right" valign="top">
Comment / Notes

<div style="font-size:8pt; font-style:italic; font-weight:normal">
(For Law Dept use only.
<br />
DO NOT EXCEED 

<CFOUTPUT>
#Comment_Gen_Char_Limit#
</CFOUTPUT>

CHARACTER LIMIT.)</i>
</div>

<CFSET TrimCOMMENT_GENERAL = Trim(COMMENT_GENERAL)>
<CFSET TrimCOMMENT_GENERAL = Replace(TrimCOMMENT_GENERAL,"\", "", "ALL")>
<CFSET TrimCOMMENT_GENERAL = Replace(TrimCOMMENT_GENERAL, "''''", "'", "ALL")>
<CFSET TrimCOMMENT_GENERAL = Replace(TrimCOMMENT_GENERAL, "''", "'", "ALL")>
<CFSET TrimCOMMENT_GENERAL = Replace(TrimCOMMENT_GENERAL, "<br>", "&##10;", "ALL")>


<CFIF Len(TrimCOMMENT_GENERAL) GT 2000>
	<div style="color:red">
<CFELSE>
	<div>
</CFIF>

<nobr>        
(Length at last update: 
</nobr>

<nobr>
<CFOUTPUT>
#Len(TrimCOMMENT_GENERAL)# characters)
</CFOUTPUT>
</nobr>

</div>





</th>

<td>

<CFOUTPUT>
<textarea name="COMMENT_GENERAL" id="COMMENT_GENERAL" rows="6" cols="70">#TrimCOMMENT_GENERAL#</textarea>
</cfoutput>
</td>

</tr>


<tr>

<th align="right" valign="top" bgcolor="ccffcc">
<small><i>Latest Update Response
<br>
For Current Report
</i></small>

<br>

<CFIF DATE_LAST_UPDATE NEQ "">

<CFOUTPUT>
<small>Date:&nbsp;<i>#DateFormat(DATE_LAST_UPDATE, "m/d/yyyy")#</i></small>
</cfoutput>

<CFQUERY NAME="Get_Upd_User" DATASOURCE="lddb">
SELECT Trim(EENAME) AS TRIM_EENAME
FROM LDEXTRA
WHERE UPPER(AD_USERID) LIKE UPPER('#Trim(LAST_UPDATE_USER_ID)#%')
OR UPPER(AD_MAILNICKNAME) LIKE UPPER('#Trim(LAST_UPDATE_USER_ID)#%')
</cfquery>

<CFIF Get_Upd_User.RecordCount EQ 1>
<br>
<CFOUTPUT>
<small>By:&nbsp;<i>#Replace(Get_Upd_User.TRIM_EENAME, " ", "&nbsp;", "ALL")#</i>
</cfoutput>
</cfif>

<CFELSE>

<small><b>[None]</b></small>

</cfif>

</th>


<td>
<!-- Submit button
-->

<CFIF FINALIZED_FLAG NEQ 1 OR (Check_Auth_User_A.RecordCount EQ 1 AND FINALIZED_FLAG EQ 1)>

<table>

<CFIF IsDefined("Form.Operation") AND Form.Operation EQ "Inserted">

<tr>
<td align="center">
<small>
<i>If you have made a change
<br>
to this new record . . .</i>
</small>
</td>
<td>&nbsp;

</td>
<td align="center">
<small><i>If no further change
<br>
is needed . . .</i></small>
</td>
</tr>

<!---
Both buttons return user to Report.cfm at current version of Case Record:
--->

<tr>
<td align="center">
<input TYPE="SUBMIT" NAME="ActionButton" VALUE="Submit This Change" style="width:100pt">
</td>
<td align="center">
&nbsp;&nbsp;<b>OR</b>&nbsp;&nbsp;
</td>
<td align="center">
<input TYPE="SUBMIT" NAME="ActionButton" VALUE="See Current Report" style="width:110pt">
</td>
</tr>

<CFELSE>


<tr>
<td align="center">

<CFOUTPUT>
<div id="ButtonNoChange_#CONTINGENT_LIAB_GetRecord.CurrentRow#"
</cfoutput>

<CFIF STATUS_CODE EQ 2>
	style="display:inline">
<CFELSE>
	style="display:none">
</cfif>


<CFIF RowColor NEQ "lightgrey">
<input TYPE='SUBMIT' NAME='ActionButton' VALUE='Confirm "No Change"' style='width:100pt' onClick='return checkupdFactsFlagArray(this.form, this.form.name)'>
<CFELSE>
<input TYPE='SUBMIT' NAME='ActionButton' VALUE='Confirm "No Change"' style='background:khaki; width:100pt' onClick='return checkupdFactsFlagArray(this.form, this.form.name)'>
</cfif>


<!---
<CFIF RowColor NEQ "lightgrey">
<input TYPE="SUBMIT" NAME="ActionButton" VALUE="Confirm \"No Change\"" style="width:100pt">
<CFELSE>
<input TYPE="SUBMIT" NAME="ActionButton" VALUE="Confirm \"No Change\"" style="background:khaki; width:100pt">
</cfif>
--->


</div>

</td>
<td align="center">
<!---
&nbsp;&nbsp;<b>OR</b>&nbsp;&nbsp;
--->
</td>
<td align="center">

<CFOUTPUT>
<div id="ButtonUpdate_#CONTINGENT_LIAB_GetRecord.CurrentRow#">
</cfoutput>


<CFIF RowColor NEQ "lightgrey">
<input TYPE="SUBMIT" NAME="ActionButton" VALUE="Submit This Update" style="width:100pt; margin-left:25pt" onClick="return checkupdFactsFlagArray(this.form, this.form.name)">
<CFELSE>
<input TYPE="SUBMIT" NAME="ActionButton" VALUE="Submit This Update" style="background:khaki; width:100pt; margin-left:25pt" onClick="return checkupdFactsFlagArray(this.form, this.form.name)">
</cfif>

</div>

</td>
</tr>


<CFIF Get_Checklist_Responses.RecordCount EQ 1>

<tr>
<td colspan="3" align="center">
<span style="font-weight:bold; color:maroon">NOTE: Case Evaluation Checklist is updated separately. See below.</span>
</td>
</tr>

</cfif>


<tr>
<td colspan="3" align="center">

<!---
<CFOUTPUT>
CASE_TYPE = #CASE_TYPE#
<br>
</cfoutput>
--->

<CFOUTPUT>

<CFIF CASE_TYPE GT 10>
<div id="ButtonRemove_#CONTINGENT_LIAB_GetRecord.CurrentRow#" style="display:inline">
<CFELSE>
<div id="ButtonRemove_#CONTINGENT_LIAB_GetRecord.CurrentRow#" style="display:none">
</cfif>

</cfoutput>

<!---
<b>OR</b>&nbsp;&nbsp;
--->

<CFIF CASE_TYPE LE 10>

<CFIF RowColor NEQ "lightgrey">
<input TYPE="SUBMIT" NAME="ActionButton" VALUE="Remove This Case" style="width:100pt; margin-top:15pt" onClick="removeConfirm(this.form)">
<CFELSE>
<input TYPE="SUBMIT" NAME="ActionButton" VALUE="Remove This Case" style="background:khaki; width:100pt; margin-top:15pt" onClick="removeConfirm(this.form)">
</cfif>

<CFELSE>

<CFIF RowColor NEQ "lightgrey">
<input TYPE="SUBMIT" NAME="ActionButton" VALUE="Un-Remove This Case" style="width:110pt; margin-top:15pt" onClick="UNremoveConfirm()">
<CFELSE>
<input TYPE="SUBMIT" NAME="ActionButton" VALUE="Un-Remove This Case" style="background:khaki; width:110pt; margin-top:15pt" onClick="UNremoveConfirm()">
</cfif>

</cfif>

</div>

<CFIF Check_Auth_User_A.RecordCount EQ 1>


&nbsp;&nbsp;<b>OR</b>&nbsp;&nbsp;


<CFIF FINALIZED_FLAG NEQ 1>

<CFIF RowColor NEQ "lightgrey">
<input TYPE="SUBMIT" NAME="ActionButton" VALUE="Lock This Record" style="width:100pt; margin-top:15pt">
<CFELSE>
<input TYPE="SUBMIT" NAME="ActionButton" VALUE="Lock This Record" style="background:khaki; width:100pt; margin-top:15pt">
</cfif>

<CFIF CONCUR_MC EQ 1>
	&nbsp;&nbsp;<b>OR</b>&nbsp;&nbsp;
	<CFIF RowColor NEQ "lightgrey">
		<input TYPE="SUBMIT" NAME="ActionButton" VALUE="Undo Approvals" style="width:100pt; margin-top:15pt">
	<CFELSE>
		<input TYPE="SUBMIT" NAME="ActionButton" VALUE="Undo Approvals" style="background:khaki; width:100pt; margin-top:15pt">
	</cfif>
</cfif>

<p>

<!---
style="font-family:verdana; width:120pt; margin-top:10pt; margin-left:250pt; border:3px dotted maroon" onClick="return confirmDelete()">
--->


	<CFIF RowColor NEQ "lightgrey">
		<input TYPE="SUBMIT" NAME="ActionButton" VALUE="Delete This Record" style="width:100pt; margin-top:15pt; border:3px dotted maroon" onClick="return confirmDelete()">
	<CFELSE>
		<input TYPE="SUBMIT" NAME="ActionButton" VALUE="Delete This Record" style="background:khaki; width:100pt; margin-top:15pt; border:3px dotted maroon" onClick="return confirmDelete()">
	</cfif>






<CFELSE>

<CFIF RowColor NEQ "lightgrey">
<input TYPE="SUBMIT" NAME="ActionButton" VALUE="UNLock This Record" style="width:100pt; margin-top:15pt">
<CFELSE>
<input TYPE="SUBMIT" NAME="ActionButton" VALUE="UNLock This Record" style="background:khaki; width:100pt; margin-top:15pt">
</cfif>

</cfif>

</cfif>

</td>
</tr>

<!---
Close <CFIF IsDefined("Form.Operation") AND Form.Operation EQ "Inserted">:
--->
</cfif>

</table>

<!---
Close <CFIF FINALIZED_FLAG NEQ 1 OR (Check_Auth_User_A.RecordCount EQ 1 AND FINALIZED_FLAG EQ 1)>:
--->
<CFELSE>
&nbsp;
</cfif>

</td>

</tr>



