<cfinclude template="MfaCookieCheck.cfm">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<!---<meta http-equiv="X-UA-Compatible" content="IE=edge">--->
<title>DRAFT CONFIDENTIAL Law Department Contingent Liabilities: Edit Record</title>

<style>
body {font-family:arial,sans-serif;font-size:10pt; background:CCFFCC}
td {font-family:arial,sans-serif;font-size:10pt}

textarea {font-family:arial,sans-serif;font-size:10pt}
th {font-family:arial,sans-serif;font-size:10pt; font-weight:bold; width:10%; align:right}

A:hover {background:black; color:white; text-decoration:none; font-family:arial; font-size:10pt; font-weight:bold}
A:active {background:yellow; color:black; text-decoration:none; font-family:arial; font-size:10pt; font-weight:bold}

</style>

<script language="JavaScript" src="calendar5.js"></script>

<!---
<!--- Text length limit for COMMENT_GENERAL textarea value, used in EditRecord.topjs.cfm and EditRecord.ptD.cfm --->
<CFSET Comment_Gen_Char_Limit = 100>
--->

<CFINCLUDE TEMPLATE="EditRecord.topjs.cfm">


<CFSET Calendar_Count = 0>


<!---
<cfset RespondingUser_Id = TRIM(UCASE(RemoveChars(auth_user,1,find('\',auth_user))))>
--->

<!---
<CFSET UserID = "kkx8mz">


<CFIF NOT IsDefined("UserID")>
<cfset RespondingUser_Id = TRIM(UCASE(RemoveChars(auth_user,1,find('\',auth_user))))>
<CFELSE>
<cfset RespondingUser_Id = UserID>
</cfif>
--->

<!---
<CFINCLUDE TEMPLATE="CFINCLUDEs/SetUserID.cfm">
--->

<!---
<CFINCLUDE TEMPLATE="CFINCLUDEs/LabelLists.cfm">
--->

<CFSET ChecklistAnswerOptionsList = "1,2,0,9">

<!---
<CFINCLUDE TEMPLATE="Unknown_NA_List.cfm">
--->

<CFQUERY NAME="Get_ReportDate" DATASOURCE="contliab">

SELECT MAX(DATE_REPORT) AS REPORT_DATE

FROM CONTINGENT_LIAB_REPORT

</cfquery>


<CFSET ThisReportDate = DateFormat(Get_ReportDate.REPORT_DATE, "mm/dd/yyyy")>



<CFQUERY NAME="Get_PrevReportDate" DATASOURCE="contliab">

SELECT MAX(DATE_REPORT) AS DATE_REPORT_PREV

FROM CONTINGENT_LIAB_REPORT

WHERE DATE_REPORT < to_date('#DateFormat(ThisReportDate, "mm/dd/yyyy")#', 'mm/dd/yyyy')

</cfquery>

<CFSET PrevReportDate = DateFormat(Get_PrevReportDate.DATE_REPORT_PREV, "mm/dd/yyyy")>



<CFIF (IsDefined("Form.RecID") AND Form.RecID NEQ "")>
	<CFSET ThisRecID = Form.RecID>
<CFELSEIF IsDefined("RecIDParm")>
	<CFSET ThisRecID = RecIDParm>
</cfif>


<CFIF IsDefined("ReturnRecID")>

<!---
	<CFOUTPUT>
	<script language="javascript">
	location.href = "###ReturnRecID#";
	</script>
	</cfoutput>
--->


</cfif>

</head>

<body>

<!---
<CFINCLUDE TEMPLATE="CFINCLUDEs/CheckUserAuth.cfm">
--->

<CFINCLUDE TEMPLATE="CheckUserAuth.cfm">


<CFIF IsDefined("SelectedLDOffice")>
	<CFSET SelectedLDOffice_Parm = "?SelectedLDOffice=" & SelectedLDOffice>
<CFELSE>
	<CFSET SelectedLDOffice_Parm = "">
</CFIF>


<CFINCLUDE TEMPLATE="EditRecord.ptA.cfm">

<CFLOOP QUERY="CONTINGENT_LIAB_GetRecord">

	<CFINCLUDE TEMPLATE="sectionheadings.cfswitch.EditRecord.cfm">
	
	<CFINCLUDE TEMPLATE="rowcolor.alternate.cfm">
	
	<CFOUTPUT>
    
<!---    
	<form name="CaseForm_#CONTINGENT_LIAB_GetRecord.CurrentRow#" METHOD="POST" ACTION="EditRecord.Action.cfm"
	onSubmit="return showStatusCodeSelected(this.form); return checkupdFactsFlagArray(this, this.name)">
--->   

<!---

Added onSubmit="return showStatusCodeSelected()" to avoid new CF error (below) for using "Complex object types" in CaseForm form STATUS_CODE checklist options to be saved in STATUS_CODE_SELECTED column in UPDATE in EditRecord.Action.cfm.

Added form field STATUS_CODE_SELECTED_ALL to hold concatenated string of STATUS_CODE values to be saved for STATUS_CODE_SELECTED column.

"Error","ajp-nio-127.0.0.1-8018-exec-1","05/14/21","13:26:57","","Complex object types cannot be converted to simple values.The expression has requested a variable or an intermediate expression result as a simple value. However, the result cannot be converted to a simple value. Simple values are strings, numbers, boolean values, and date/time values. Queries, arrays, and COM objects are examples of complex values. <p> The most likely cause of the error is that you tried to use a complex value as a simple one. For example, you tried to use a query variable in a cfif tag. The specific sequence of files included or processed is: D:\web\inetpub\wwwroot2\ClientService\ContingentLiabilities\V1.0.Test20210426\EditRecord.Action.cfm, line: 445 "

--->


<!---
	<form name="CaseForm_#CONTINGENT_LIAB_GetRecord.CurrentRow#" METHOD="POST" ACTION="EditRecord.Action.cfm"
	onSubmit="return showStatusCodeSelected(this); return showUnionsSelected(this); return checkupdFactsFlagArray(this, this.name)">
--->

<cfinvoke component="components/clrsFunctions" method="getPrevReptRecord" returnvariable="GetRecord_PrevRpt">
	<cfinvokeargument name="prevRptDate" value="#url.PrevReportDate_Parm#">
	<cfinvokeargument name="caseRecordIdSeq" value="#CASE_REC_ID_SEQUENCE#">
</cfinvoke>

	<form name="CaseForm_#CONTINGENT_LIAB_GetRecord.CurrentRow#" METHOD="POST" ACTION="EditRecord.Action.cfm"
	onSubmit="return showStatusCodeSelected(this); return checkupdFactsFlagArray(this, this.name)">
    
	</CFOUTPUT>
	
<!--- 4/24/09:
onSubmit attribute in CFFORM tag appears not to work anymore, maybe because of upgrade to CF8. Therefore, added onClick="return checkupdFactsFlagArray(this.form, this.form.name)" to Submit This Update button in EditRecord.ptD.cfm. 
--->

	<CFOUTPUT>
	
	<input type="hidden" name="RespondingUser_Id" value="#RespondingUser_Id#">
	<input type="hidden" name="CASE_REC_ID_SEQUENCE" value="#CASE_REC_ID_SEQUENCE#">
	
	<CFIF IsDefined("SelectedLDOffice")>
		<input type="hidden" name="SelectedLDOffice" value="#SelectedLDOffice#">
	<CFELSE>
		<input type="hidden" name="SelectedLDOffice">
	</cfif>
	
	
	<CFIF IsDefined("RecordDisplay_Parm") AND RecordDisplay_Parm EQ "Single">
		<input type="hidden" name="RecordDisplay_Parm" value="#RecordDisplay_Parm#">
	    
	    <CFIF IsDefined("ThisReportDate_Parm") AND ThisReportDate_Parm NEQ "">
	       	<input type="hidden" name="ThisReportDate_Parm" value="#ThisReportDate_Parm#">
		</cfif>
	
	    <CFIF IsDefined("PrevReportDate_Parm") AND PrevReportDate_Parm NEQ "">
	       	<input type="hidden" name="PrevReportDate_Parm" value="#PrevReportDate_Parm#">
		</cfif>
	
	</CFIF>
	

	<CFIF IsDefined("TextHighlight")
	AND
	TextHighlight EQ "Disabled">
	
		<input type="hidden" name="TextHighlight" value="#TextHighlight#">
	    
	</CFIF>
	

	</cfoutput>
	
	
	<CFIF IsDefined("RecIDParm") AND IsDefined("RowColorParm")>
		<CFSET RowColor = RowColorParm>
	</cfif>
	
	<CFOUTPUT>
	<input type="hidden" name="RecID" value="#PRIMARYKEY#">
	</cfoutput>
	
	<blockquote>
	
	<div style="background:ffffcc; padding:10pt; width:75%">
	
	<CFINCLUDE TEMPLATE="Instruc.Form.Requirements.cfm">
	
	</div>
	
	</blockquote>
	
	<CFOUTPUT>
	
	<table border=0 cellpadding="5" cellspacing="5" width="100%" style="margin-bottom:10pt; background:#RowColor#">
	
	<a name="#PRIMARYKEY#">&nbsp;</a>
	
	</cfoutput>
	
	
	<CFINCLUDE TEMPLATE="EditRecord.ptB.cfm">
	
	<CFINCLUDE TEMPLATE="EditRecord.ptC.cfm">
	
	<CFINCLUDE TEMPLATE="EditRecord.ptD.cfm">
	
	
	</table>
	
	</form>
	
	<!--- Checklist Record:
	--->
	
	<table cellpadding="5" cellspacing="5" width="90%">
	
	<CFINCLUDE TEMPLATE="EditRecord.ptE.cfm">
	
	</table>
	
</cfloop>


<script language="JavaScript">


<CFLOOP INDEX="FormCtIndex" FROM="1" TO="#CONTINGENT_LIAB_GetRecord.RecordCount#">

	<CFSET ThisCalCt = 0>
	
	<CFLOOP INDEX="FieldListIndex" LIST="DATE_FILED,PAYOUT_DATE">
	
		<CFSET ThisCalCt = ThisCalCt + 1>

		<CFOUTPUT>
		var cal#ThisCalCt# = new calendar5(document.CaseForm_#FormCtIndex#.#FieldListIndex#);
		</cfoutput>
	
	</cfloop>

</cfloop>


</script>


</body>


</html>



