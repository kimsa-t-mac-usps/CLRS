<cfinclude template="MfaCookieCheck.cfm">

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
<title>Law Department Contingent Liabilities: Insert Record Action</title>
</head>

<body>



<CFQUERY NAME="Get_ReportDate" DATASOURCE="lddb">
SELECT *
FROM view_conting_get_reportdate
</cfquery>


<CFSET ThisReportDate = DateFormat(Get_ReportDate.REPORT_DATE, "mm/dd/yyyy")>

<!---
<CFOUTPUT>
--->

<CFQUERY NAME="CONTINGENT_LIAB_Insert" DATASOURCE="lddb">


INSERT INTO CONTINGENT_LIAB_REPORT
(PRIMARYKEY,
CASE_NAME,
CASE_NUMBER,

LM_MATTER_NUMBER,

CASE_TYPE,

<CFIF Form.CLAIM_CATEGORY NEQ "">
CLAIM_CATEGORY,
</cfif>

<CFIF Form.DATE_FILED NEQ "">
DATE_FILED,
</cfif>

<CFIF IsDefined("Form.DATE_FILED_UNKNOWN") AND Form.DATE_FILED_UNKNOWN NEQ "">
DATE_FILED_UNKNOWN,
</cfif>

<CFIF Form.AMOUNT_SOUGHT NEQ "">
AMOUNT_SOUGHT,
</cfif>

<CFIF IsDefined("Form.AMOUNT_SOUGHT_UPPER") AND Form.AMOUNT_SOUGHT_UPPER NEQ "">
AMOUNT_SOUGHT_UPPER,
</cfif>

<CFIF IsDefined("Form.AMOUNT_SOUGHT_UNKNOWN") AND Form.AMOUNT_SOUGHT_UNKNOWN NEQ "">
AMOUNT_SOUGHT_UNKNOWN,
</cfif>

<CFIF Form.ASSESSMENT_PROBABILITY NEQ "">
ASSESSMENT_PROBABILITY,
</cfif>

<CFIF Form.ASSESSMENT_AMOUNT NEQ "">
ASSESSMENT_AMOUNT,
</cfif>


<CFIF IsDefined("Form.ASSESSMENT_AMT_HIGH_END") AND Form.ASSESSMENT_AMT_HIGH_END NEQ "">
ASSESSMENT_AMT_HIGH_END,
</cfif>


<CFIF IsDefined("Form.ASSESSMENT_AMOUNT_UPPER") AND Form.ASSESSMENT_AMOUNT_UPPER NEQ "">
ASSESSMENT_AMOUNT_UPPER,
</cfif>


<CFIF IsDefined("ASSESSMENT_AMT_UPPER_HIGH_END") AND Form.ASSESSMENT_AMT_UPPER_HIGH_END NEQ "">
ASSESSMENT_AMT_UPPER_HIGH_END,
</cfif>



<CFIF IsDefined("Form.ASSESSMENT_AMOUNT_UNKNOWN") AND Form.ASSESSMENT_AMOUNT_UNKNOWN NEQ "">
ASSESSMENT_AMT_UNKNOWN,
</cfif>

<CFIF IsDefined("Form.ASSESSMENT_AMT_MAX_UNKNOWN") AND Form.ASSESSMENT_AMT_MAX_UNKNOWN NEQ "">
ASSESSMENT_AMT_MAX_UNKNOWN,
</cfif>



<CFIF IsDefined("Form.SHORT_TERM_LIABILITY") AND Form.SHORT_TERM_LIABILITY NEQ "">
SHORT_TERM_LIABILITY,
</cfif>


<CFIF IsDefined("Form.FIELD_GRIEVANCE_FLAG") AND Form.FIELD_GRIEVANCE_FLAG NEQ "">
FIELD_GRIEVANCE_FLAG,
</cfif>


<CFIF IsDefined("Form.NATL_GATS_NUMBER") AND Form.NATL_GATS_NUMBER NEQ "">
NATL_GATS_NUMBER,
</cfif>


<CFIF IsDefined("Form.DIST_PERF_CLUSTER_CODE") AND Form.DIST_PERF_CLUSTER_CODE NEQ "0">
DIST_PERF_CLUSTER_CODE,
DIST_PERF_CLUSTER_NAME,

	<CFIF Form.DIST_PERF_CLUSTER_CODE DOES NOT CONTAIN "Multiple">
	AREA_CODE,
	AREA_NAME,
	</cfif>


<CFELSEIF IsDefined("Form.DIVISION_CODE") AND Form.DIVISION_CODE NEQ "0">
DIVISION_CODE,


<CFELSEIF IsDefined("Form.HQ_AREA_NAME") AND Form.HQ_AREA_NAME NEQ "0">
AREA_CODE,
AREA_NAME,
</cfif>


<!---
<CFIF IsDefined("Form.Unions_Selected")
AND
Form.Unions_Selected NEQ "">

	UNIONS_SELECTED,

</CFIF>
--->



<!---
<CFIF 
(
IsDefined("Form.UNIONS_SELECTED_ALL")
AND
Form.UNIONS_SELECTED_ALL NEQ ""
)
OR 
(
IsDefined("Form.UNIONS_SELECTED")
AND
Form.UNIONS_SELECTED NEQ ""
)>

	UNIONS_SELECTED,

</CFIF>
--->





<CFIF IsDefined("Form.UNIONS_SELECTED_ALL")
AND
Form.UNIONS_SELECTED_ALL NEQ "">

	UNIONS_SELECTED,

</CFIF>















STATUS_CODE_SELECTED,

COUNSEL_LAW_DEPT,

COCOUNSEL_LAW_DEPT,

LAW_DEPT_OFFICE,

ALT_LAW_DEPT_OFFICE,

COUNSEL_OTHER,
FACTS_POSITIONS_LONG,

LAST_UPDATE_USER_ID,
DATE_REPORT,
COMMENT_GENERAL,
CASE_REC_ID_SEQUENCE)

VALUES
(CONTINGENT_LIAB_REPORT_PRMKEY.NEXTVAL,
'#Form.CASE_NAME#',
'#Form.CASE_NUMBER#',

'#Form.LM_MATTER_NUMBER#',

#Form.CASE_TYPE#,

<CFIF Form.CLAIM_CATEGORY NEQ "">
#Form.CLAIM_CATEGORY#,
</cfif>

<CFIF Form.DATE_FILED NEQ "">
<CFSET DateFiledFmt = DateFormat(Form.DATE_FILED, "mm/dd/yyyy")>
to_date('#DateFiledFmt#', 'mm/dd/yyyy'),
</cfif>

<CFIF IsDefined("Form.DATE_FILED_UNKNOWN") AND Form.DATE_FILED_UNKNOWN NEQ "">
#Form.DATE_FILED_UNKNOWN#,
</cfif>

<CFIF Form.AMOUNT_SOUGHT NEQ "">

<CFSET ThisString = Form.AMOUNT_SOUGHT>

<CFINCLUDE TEMPLATE="IsNumeric.validate.cfm">

<CFSET AMOUNT_SOUGHT_Dollars = ValidatedString * OneMillion>


#AMOUNT_SOUGHT_Dollars#,

</cfif>

<CFIF IsDefined("Form.AMOUNT_SOUGHT_UPPER") AND Form.AMOUNT_SOUGHT_UPPER NEQ "">

<CFSET ThisString = Form.AMOUNT_SOUGHT_UPPER>

<CFINCLUDE TEMPLATE="IsNumeric.validate.cfm">

<CFSET AMOUNT_SOUGHT_UPPER_Dollars = ValidatedString * OneMillion>

#AMOUNT_SOUGHT_UPPER_Dollars#,

</cfif>


<CFIF IsDefined("Form.AMOUNT_SOUGHT_UNKNOWN") AND Form.AMOUNT_SOUGHT_UNKNOWN NEQ "">
#Form.AMOUNT_SOUGHT_UNKNOWN#,
</cfif>

<CFIF Form.ASSESSMENT_PROBABILITY NEQ "">
#Form.ASSESSMENT_PROBABILITY#,
</cfif>


<CFIF Form.ASSESSMENT_AMOUNT NEQ "">

<CFSET ThisString = Form.ASSESSMENT_AMOUNT>

<CFINCLUDE TEMPLATE="IsNumeric.validate.cfm">

<CFSET ASSESSMENT_AMOUNT_Dollars = ValidatedString * OneMillion>

#ASSESSMENT_AMOUNT_Dollars#,

</cfif>



<CFIF IsDefined("Form.ASSESSMENT_AMT_HIGH_END") AND Form.ASSESSMENT_AMT_HIGH_END NEQ "">

<CFSET ThisString = Form.ASSESSMENT_AMT_HIGH_END>

<CFINCLUDE TEMPLATE="IsNumeric.validate.cfm">

<CFSET ASSESSMENT_AMT_HIGH_END_Dollars = ValidatedString * OneMillion>

#ASSESSMENT_AMT_HIGH_END_Dollars#,

</cfif>




<CFIF IsDefined("Form.ASSESSMENT_AMOUNT_UPPER") AND Form.ASSESSMENT_AMOUNT_UPPER NEQ "">

<CFSET ThisString = Form.ASSESSMENT_AMOUNT_UPPER>

<CFINCLUDE TEMPLATE="IsNumeric.validate.cfm">

<CFSET ASSESSMENT_AMOUNT_UPPER_Dollars = ValidatedString * OneMillion>

#ASSESSMENT_AMOUNT_UPPER_Dollars#,

</cfif>



<CFIF IsDefined("Form.ASSESSMENT_AMT_UPPER_HIGH_END") AND Form.ASSESSMENT_AMT_UPPER_HIGH_END NEQ "">

<CFSET ThisString = Form.ASSESSMENT_AMT_UPPER_HIGH_END>

<CFINCLUDE TEMPLATE="IsNumeric.validate.cfm">

<CFSET ASSESSMENT_AMT_UPPER_HIGH_END_Dollars = ValidatedString * OneMillion>

#ASSESSMENT_AMT_UPPER_HIGH_END_Dollars#,

</cfif>




<CFIF IsDefined("Form.ASSESSMENT_AMOUNT_UNKNOWN") AND Form.ASSESSMENT_AMOUNT_UNKNOWN NEQ "">
#Form.ASSESSMENT_AMOUNT_UNKNOWN#,
</cfif>


<CFIF IsDefined("Form.ASSESSMENT_AMT_MAX_UNKNOWN") AND Form.ASSESSMENT_AMT_MAX_UNKNOWN NEQ "">
#Form.ASSESSMENT_AMT_MAX_UNKNOWN#,
</cfif>


<CFIF IsDefined("Form.SHORT_TERM_LIABILITY") AND Form.SHORT_TERM_LIABILITY NEQ "">
#Form.SHORT_TERM_LIABILITY#,
</cfif>



<CFIF IsDefined("Form.FIELD_GRIEVANCE_FLAG") AND Form.FIELD_GRIEVANCE_FLAG NEQ "">
'#Form.FIELD_GRIEVANCE_FLAG#',
</cfif>


<CFIF IsDefined("Form.NATL_GATS_NUMBER") AND Form.NATL_GATS_NUMBER NEQ "">
'#Form.NATL_GATS_NUMBER#',
</cfif>




<CFIF IsDefined("Form.DIST_PERF_CLUSTER_CODE") AND Form.DIST_PERF_CLUSTER_CODE NEQ "0">

	<CFSET Slashes_DIST_PERF_CLUSTER_CODE_Index = Find(" // ", Form.DIST_PERF_CLUSTER_CODE)>
	<CFSET Slashes_Next_Word = Slashes_DIST_PERF_CLUSTER_CODE_Index + 4>

	<CFSET This_DIST_PERF_CLUSTER_CODE = Left(Form.DIST_PERF_CLUSTER_CODE, Slashes_DIST_PERF_CLUSTER_CODE_Index - 1)>

	'#This_DIST_PERF_CLUSTER_CODE#',

	<CFIF This_DIST_PERF_CLUSTER_CODE NEQ "Multiple">

		<CFSET Vert_Bars_DIST_PERF_CLUSTER_CODE_Index = Find(" || ", Form.DIST_PERF_CLUSTER_CODE)>
		<CFSET Vert_Bars_Next_Word = Vert_Bars_DIST_PERF_CLUSTER_CODE_Index + 4>

		<CFSET This_DIST_PERF_CLUSTER_NAME = Mid(Form.DIST_PERF_CLUSTER_CODE, Slashes_Next_Word, Vert_Bars_DIST_PERF_CLUSTER_CODE_Index - (Slashes_Next_Word))>

		'#This_DIST_PERF_CLUSTER_NAME#',

		<CFSET Ampersands_DIST_PERF_CLUSTER_CODE_Index = Find(" && ", Form.DIST_PERF_CLUSTER_CODE)>
		<CFSET Ampersands_Next_Word = Ampersands_DIST_PERF_CLUSTER_CODE_Index + 4>

		<CFSET This_DIST_AREA_CODE = Mid(Form.DIST_PERF_CLUSTER_CODE, Vert_Bars_Next_Word, Ampersands_DIST_PERF_CLUSTER_CODE_Index - (Vert_Bars_Next_Word))>

		<CFSET This_DIST_AREA_NAME = Right(Form.DIST_PERF_CLUSTER_CODE, Len(Form.DIST_PERF_CLUSTER_CODE) - (Ampersands_Next_Word - 1))>

		'#This_DIST_AREA_CODE#',
		'#This_DIST_AREA_NAME#',

	<CFELSE>

		<CFSET This_DIST_PERF_CLUSTER_NAME = Right(Form.DIST_PERF_CLUSTER_CODE, Len(Form.DIST_PERF_CLUSTER_CODE) - (Slashes_Next_Word - 1))>

		'#This_DIST_PERF_CLUSTER_NAME#',

	</cfif>



<CFELSEIF IsDefined("Form.DIVISION_CODE") AND Form.DIVISION_CODE NEQ "0">


	'#Form.DIVISION_CODE#',



<CFELSEIF IsDefined("Form.HQ_AREA_NAME") AND Form.HQ_AREA_NAME NEQ "0">

	<CFSET Slashes_HQ_AREA_NAME_Index = Find(" // ", Form.HQ_AREA_NAME)>

	<CFSET This_HQ_AREA_CODE = Left(Form.HQ_AREA_NAME, Slashes_HQ_AREA_NAME_Index - 1)>

	<CFSET This_HQ_AREA_NAME = Right(Form.HQ_AREA_NAME, Len(Form.HQ_AREA_NAME) - (Slashes_HQ_AREA_NAME_Index + 3))>

	'#This_HQ_AREA_CODE#',
	'#This_HQ_AREA_NAME#',

</cfif>


<!---
<CFIF IsDefined("Form.Unions_Selected")
AND
Form.Unions_Selected NEQ "">

	'#Form.Unions_Selected#',

</CFIF>
--->




<!---
<CFIF IsDefined("Form.UNIONS_SELECTED_ALL")
AND
Form.UNIONS_SELECTED_ALL NEQ "">

	'#Form.UNIONS_SELECTED_ALL#',

<CFELSEIF IsDefined("Form.UNIONS_SELECTED")
AND
Form.UNIONS_SELECTED NEQ "">

	'#Form.UNIONS_SELECTED#',

</CFIF>
--->





<CFIF IsDefined("Form.UNIONS_SELECTED_ALL")
AND
Form.UNIONS_SELECTED_ALL NEQ "">

	'#Form.UNIONS_SELECTED_ALL#',

</CFIF>






















#Form.STATUS_CODE_SELECTED#,


#Form.COUNSEL_LAW_DEPT#,

#Form.COCOUNSEL_LAW_DEPT#,

#Form.LAW_DEPT_OFFICE#,

#Form.ALT_LAW_DEPT_OFFICE#,

'#Form.COUNSEL_OTHER#',

<CFSET ThisFACTS_POSITIONS_LONG = Trim(Form.FACTS_POSITIONS_LONG)>

<!---
<CFSET ThisFACTS_POSITIONS_LONG = JSStringFormat(ThisFACTS_POSITIONS_LONG)>
<CFSET ThisFACTS_POSITIONS_LONG = Replace(ThisFACTS_POSITIONS_LONG, "\r\n", "<br>", "ALL")>
--->
<!---
			<CFSET Orig_String = JSStringFormat(TrimOtherRefs)>
			<CFINCLUDE TEMPLATE="ReplaceSlashQuote.cfm">

			OTHER_REFS_NOTE = '#Result_String#',
--->

<CFSET Orig_String = JSStringFormat(ThisFACTS_POSITIONS_LONG)>
<CFINCLUDE TEMPLATE="ReplaceSlashQuote.cfm">
<CFSET ThisFACTS_POSITIONS_LONG = Result_String>

<CFQUERYPARAM VALUE="#ThisFACTS_POSITIONS_LONG#" CFSQLType="CF_SQL_LONGVARCHAR">,


'#RespondingUser_Id#',

to_date('#ThisReportDate#', 'mm/dd/yyyy'),


<!---
<CFSET ThisCOMMENT_GENERAL = Trim(Form.COMMENT_GENERAL)>
<CFSET ThisCOMMENT_GENERAL = JSStringFormat(ThisCOMMENT_GENERAL)>
<CFSET ThisCOMMENT_GENERAL = Replace(ThisCOMMENT_GENERAL, "\r\n", "<br>", "ALL")>
<CFQUERYPARAM VALUE="#ThisCOMMENT_GENERAL#" CFSQLType="CF_SQL_LONGVARCHAR">,
--->

<CFSET ThisCOMMENT_GENERAL = Trim(Form.COMMENT_GENERAL)>

<CFSET Orig_String = JSStringFormat(ThisCOMMENT_GENERAL)>
<CFINCLUDE TEMPLATE="ReplaceSlashQuote.cfm">
<CFSET ThisCOMMENT_GENERAL = Result_String>

<CFQUERYPARAM VALUE="#ThisCOMMENT_GENERAL#" CFSQLType="CF_SQL_LONGVARCHAR">,


CONTINGENT_LIAB_SEQUENCE.NEXTVAL)


</cfquery>


<!---
</cfoutput>
--->

<!---
Record Inserted.
--->

<CFQUERY NAME="Get_Currval" DATASOURCE="lddb">
SELECT CONTINGENT_LIAB_SEQUENCE.CURRVAL AS SEQ_CURRVAL
FROM DUAL
</cfquery>

<!---
<CFOUTPUT>
Currval = #Get_Currval.SEQ_CURRVAL#
</cfoutput>
--->



<CFIF Form.LM_MATTER_NUMBER NEQ "">


	<CFQUERY NAME="Get_Matter_Key" DATASOURCE="lddb">

	select
	c.matter_key

	from
	lawmanager.matter c

	where
	c.matter_number = '#Form.LM_MATTER_NUMBER#'

	</cfquery>


	<CFIF Get_Matter_Key.RecordCount GT 0>


		<CFQUERY NAME="CONTINGENT_LIAB_Update" DATASOURCE="lddb">
		UPDATE CONTINGENT_LIAB_REPORT
		SET

		<CFIF Get_Matter_Key.RecordCount EQ 1>
			LM_MATTER_KEY = #Get_Matter_Key.matter_key#
		<CFELSE>
			LM_MATTER_KEY = NULL
		</cfif>

		WHERE CASE_REC_ID_SEQUENCE = #Get_Currval.SEQ_CURRVAL#
		</cfquery>

	</cfif>

<!--- Close <CFIF Form.LM_MATTER_NUMBER NEQ "" AND Form.LM_MATTER_KEY EQ ""> --->
</CFIF>





<!---
<CFQUERY NAME="Get_ChecklistQues" DATASOURCE="lddb">
SELECT *
FROM VIEW_CONTING_GET_CHECKLISTQUES
</cfquery>
--->



<CFSET QuesNumList = ValueList(Get_ChecklistQues.QUESNUM_TRIM)>

<CFSET QuesNumListSQLFields = "">

<CFSET QuesNumListSQLValues = "">

<!---
Save Checklist Reponses:
--->

<CFQUERY NAME="Save_Checklist_Reponses" DATASOURCE="lddb">

INSERT INTO CONTINGENT_LIAB_C_E_CHECKLIST

(CASE_REC_ID_SEQUENCE,
ORIG_DATE,
ORIG_USERID,
MC_APPR_FLAG,
FORUM,
CLIENT,

<CFLOOP INDEX="QuesNumListIndex" LIST="#QuesNumList#">

<CFSET ThisFormQues = "Form.ChecklistResponse_" & QuesNumListIndex>

<CFIF IsDefined(ThisFormQues)>


<CFSET QuesNumListSQLFields = ListAppend(QuesNumListSQLFields, "QUES_" & QuesNumListIndex)>

</cfif>

</cfloop>

#QuesNumListSQLFields#

)

VALUES

(#Get_Currval.SEQ_CURRVAL#,


SYSDATE,

'#RespondingUser_Id#',
0,
'#Form.FORUM#',
'#Form.CLIENT#',

<CFLOOP INDEX="QuesNumListIndex" LIST="#QuesNumList#">

<CFSET ThisFormReponse = "Form.ChecklistResponse_" & QuesNumListIndex>

<CFIF IsDefined(ThisFormReponse)>


<CFSET Evaluate_ThisFormReponse = Evaluate(ThisFormReponse)>

<CFIF Evaluate_ThisFormReponse EQ "99">
<CFSET QuesNumListSQLValues = ListAppend(QuesNumListSQLValues, " ")>
<CFELSE>
<CFSET QuesNumListSQLValues = ListAppend(QuesNumListSQLValues, Evaluate_ThisFormReponse)>
</cfif>

</cfif>

</cfloop>

#ListQualify(QuesNumListSQLValues, "'")#

)

</cfquery>


<CFQUERY NAME="Get_CONTINGENT_LIAB_REPORT_Currval" DATASOURCE="lddb">
SELECT CONTINGENT_LIAB_REPORT_PRMKEY.CURRVAL AS CONTINGENT_LIAB_REPORT_CURRVAL
FROM DUAL
</cfquery>




<!---
E-mail notice to MC, other manager(s):
--->

<CFIF NOT IsDefined("Test_Server")>

<CFINCLUDE TEMPLATE="InsertRecord.cfmail.cfm">

</cfif>


<form name="ReturnForm" METHOD="POST" ACTION="Report.full.cfm">
<CFOUTPUT>

<input type="hidden" name="RecID" value="#Get_CONTINGENT_LIAB_REPORT_Currval.CONTINGENT_LIAB_REPORT_CURRVAL#">

</cfoutput>
</form>



<script language="javascript">

<CFIF NOT IsDefined("Test_Server")>

<CFOUTPUT>
alert("An e-mail notice has been sent to #AlertToLine# that the new case is available for approval.");
</cfoutput>

</cfif>

ReturnForm.submit();

</script>



</body>
</html>



