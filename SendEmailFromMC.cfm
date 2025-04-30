<cfinclude template="MfaCookieCheck.cfm">

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
<title>Send Approval / Disapproval E-mail From MC</title>
</head>

<body>

<!---
<CFSET todayDate = Now()>
<CFSET todayDateFmt = DateFormat(todayDate, "mm/dd/yyyy")>
--->


<CFIF IsDefined("Form.MC_Approval_Flag")>

	<CFQUERY NAME="Upd_CONTINGENT_LIAB_C_E_CHECKLIST" DATASOURCE="contliab">
	
	UPDATE CONTINGENT_LIAB_C_E_CHECKLIST
	
	SET
	
	<!---
	UPD_DATE = to_date('#todayDateFmt#', 'mm/dd/yyyy'),
	--->
	
	UPD_DATE = SYSDATE,
	
	UPD_USERID = '#Form.RespondingUser_Id#',
	
	
	<CFIF IsDefined("Form.MC_Approval_Flag")>
	MC_APPR_FLAG = #Form.MC_Approval_Flag#,
	MC_USERID = '#Form.RespondingUser_Id#'
	</cfif>
	
	<CFIF IsDefined("Form.DisapprovalComment")>
	,
	<CFSET ThisMC_COMMENT = Trim(Form.DisapprovalComment)>
	<CFSET ThisMC_COMMENT = JSStringFormat(ThisMC_COMMENT)>
	<CFSET ThisMC_COMMENT = Replace(ThisMC_COMMENT, "\r\n", "<br>", "ALL")>
	MC_COMMENT = <CFQUERYPARAM VALUE="#ThisMC_COMMENT#" CFSQLType="CF_SQL_LONGVARCHAR">
	
	</cfif>
	
	WHERE CASE_REC_ID_SEQUENCE = #Form.CASE_REC_ID_SEQUENCE#
	
	</cfquery>



	<CFQUERY NAME="Upd_CONTINGENT_LIAB" DATASOURCE="contliab">
	
	UPDATE CONTINGENT_LIAB_REPORT
	
	SET
	
	<CFIF Form.MC_Approval_Flag EQ 1>
	
    CONCUR_MC = 1,
        
    CONCUR_MC_DATE = SYSDATE,
    
    CONCUR_MC_USER_ID = '#Form.RespondingUser_Id#',
        
	</cfif>
	
	<!---
	DATE_LAST_UPDATE = to_date('#todayDateFmt#', 'mm/dd/yyyy'),
	--->
	
	DATE_LAST_UPDATE = SYSDATE,
	
	LAST_UPDATE_USER_ID = '#Form.RespondingUser_Id#'
	
	
	WHERE CASE_REC_ID_SEQUENCE = #Form.CASE_REC_ID_SEQUENCE#
	
	</cfquery>



	<CFSWITCH EXPRESSION="#Form.MC_Approval_Flag#">
	
	<CFCASE VALUE="1">
		<CFSET ApprWordSubj = "Approved">
		<CFSET ApprWordText = "approved">
	</cfcase>
	
	<CFCASE VALUE="2">
		<CFSET ApprWordSubj = "Disapproved">
		<CFSET ApprWordText = "disapproved">
	</cfcase>
	
	</cfswitch>


<CFELSEIF IsDefined("Form.Alt_Approval_Flag")>


	<CFQUERY NAME="Upd_CONTINGENT_LIAB_C_E_CHECKLIST" DATASOURCE="contliab">
	
	UPDATE CONTINGENT_LIAB_C_E_CHECKLIST
	
	SET
	
	<!---
	UPD_DATE = to_date('#todayDateFmt#', 'mm/dd/yyyy'),
	--->
	
	UPD_DATE = SYSDATE,
	
	UPD_USERID = '#Form.RespondingUser_Id#',
	
	
	<CFIF IsDefined("Form.Alt_Approval_Flag")>
	ALT_APPR_FLAG = #Form.Alt_Approval_Flag#,
	ALT_USERID = '#Form.RespondingUser_Id#'
	</cfif>
	
	<CFIF IsDefined("Form.DisapprovalComment")>
	,
	<CFSET ThisAlt_COMMENT = Trim(Form.DisapprovalComment)>
	<CFSET ThisAlt_COMMENT = JSStringFormat(ThisAlt_COMMENT)>
	<CFSET ThisAlt_COMMENT = Replace(ThisAlt_COMMENT, "\r\n", "<br>", "ALL")>
	ALT_COMMENT = <CFQUERYPARAM VALUE="#ThisAlt_COMMENT#" CFSQLType="CF_SQL_LONGVARCHAR">
	
	</cfif>
	
	WHERE CASE_REC_ID_SEQUENCE = #Form.CASE_REC_ID_SEQUENCE#
	
	</cfquery>
	


	<CFQUERY NAME="Upd_CONTINGENT_LIAB" DATASOURCE="contliab">
	
	UPDATE CONTINGENT_LIAB_REPORT
	
	SET
	
	<CFIF Form.Alt_Approval_Flag EQ 1>
	CONCUR_ALT = 1,
	</cfif>
	
	<!---
	DATE_LAST_UPDATE = to_date('#todayDateFmt#', 'mm/dd/yyyy'),
	--->
	
	DATE_LAST_UPDATE = SYSDATE,
	
	LAST_UPDATE_USER_ID = '#Form.RespondingUser_Id#'
	
	
	WHERE CASE_REC_ID_SEQUENCE = #Form.CASE_REC_ID_SEQUENCE#
	
	</cfquery>


	<CFSWITCH EXPRESSION="#Form.Alt_Approval_Flag#">
	
	<CFCASE VALUE="1">
		<CFSET ApprWordSubj = "Approved">
		<CFSET ApprWordText = "approved">
	</cfcase>
	
	<CFCASE VALUE="2">
		<CFSET ApprWordSubj = "Disapproved">
		<CFSET ApprWordText = "disapproved">
	</cfcase>
	
	</cfswitch>
	

</cfif>



<CFIF IsDefined("Form.MC_Approval_Flag") 
OR 
IsDefined("Form.Alt_Approval_Flag")>


<!--- Trigger e-mail to assigned counsel: I have approved / disapproved; Link to record
--->

	<CFQUERY NAME="Get_CounselInfo" DATASOURCE="contliab">
	
	SELECT LDEXTRA.LASTNAME, LDEXTRA.FIRSTNAME, LAWDEPARTMENT.LONGEMAIL, LDEXTRA.PRIMARYKEY
	
	FROM LAWDEPARTMENT, LDEXTRA
	
	WHERE LDEXTRA.PRIMARYKEY = LAWDEPARTMENT.PRIMARYKEY
	
	AND LDEXTRA.PRIMARYKEY = #Form.COUNSEL_LAW_DEPT#
	
	</cfquery>
	
	<CFSET Trim_Counsel_LastName = Trim(Get_CounselInfo.LASTNAME)>
	<CFSET Trim_Counsel_FirstName = Trim(Get_CounselInfo.FIRSTNAME)>
	<CFSET Trim_Counsel_EMailAddr = Trim(Get_CounselInfo.LONGEMAIL)>
	
	<CFIF Trim_Counsel_EMailAddr EQ "">
		<CFSET Default_Counsel_LongEmailFirstName = Replace(Trim_Counsel_FirstName, " ", ".", "ALL")>
		<CFSET Default_Counsel_LongEmailFirstName = Replace(Default_Counsel_LongEmailFirstName, "..", "", "ALL")>
		<CFIF Right(Default_Counsel_LongEmailFirstName, 1) NEQ ".">
			<CFSET Default_Counsel_LongEmailFirstName = Default_Counsel_LongEmailFirstName & ".">
		</cfif>
		<CFSET Trim_Counsel_EMailAddr = Default_Counsel_LongEmailFirstName & Trim_Counsel_LastName>
	</cfif>


	<CFIF Form.COCOUNSEL_LAW_DEPT NEQ "" 
	AND 
	Form.COCOUNSEL_LAW_DEPT NEQ 0>


		<CFQUERY NAME="Get_Co_CounselInfo" DATASOURCE="contliab">
		
		SELECT LDEXTRA.LASTNAME, LDEXTRA.FIRSTNAME, LAWDEPARTMENT.LONGEMAIL, LDEXTRA.PRIMARYKEY
		
		FROM LAWDEPARTMENT, LDEXTRA
		
		WHERE LDEXTRA.PRIMARYKEY = LAWDEPARTMENT.PRIMARYKEY
		
		AND LDEXTRA.PRIMARYKEY = #Form.COCOUNSEL_LAW_DEPT#
		
		</cfquery>


		<CFSET Trim_Co_Counsel_LastName = Trim(Get_Co_CounselInfo.LASTNAME)>
		<CFSET Trim_Co_Counsel_FirstName = Trim(Get_Co_CounselInfo.FIRSTNAME)>
		<CFSET Trim_Co_Counsel_EMailAddr = Trim(Get_Co_CounselInfo.LONGEMAIL)>
		
		<CFIF Trim_Co_Counsel_EMailAddr EQ "">
			<CFSET Default_Co_Counsel_LongEmailFirstName = Replace(Trim_Co_Counsel_FirstName, " ", ".", "ALL")>
			<CFSET Default_Co_Counsel_LongEmailFirstName = Replace(Default_Co_Counsel_LongEmailFirstName, "..", "", "ALL")>
			<CFIF Right(Default_Co_Counsel_LongEmailFirstName, 1) NEQ ".">
				<CFSET Default_Co_Counsel_LongEmailFirstName = Default_Co_Counsel_LongEmailFirstName & ".">
			</cfif>
			<CFSET Trim_Co_Counsel_EMailAddr = Default_Co_Counsel_LongEmailFirstName & Trim_Co_Counsel_LastName>
		</cfif>
	
	<CFELSE>
	
		<CFSET Trim_Co_Counsel_EMailAddr = "">
	
	</cfif>

<!---
<CFSET ToLine = Trim_Counsel_EMailAddr & "@usps.gov," & Trim_Co_Counsel_EMailAddr & "@usps.gov">
--->

	<CFSET ToLine = Trim_Counsel_EMailAddr & "@usps.gov">
	
	<CFIF Trim_Co_Counsel_EMailAddr NEQ "">
		<CFSET ToLine = ListAppend(ToLine, Trim_Co_Counsel_EMailAddr & "@usps.gov")>
	</cfif>


	<CFQUERY NAME="Get_SenderInfo" DATASOURCE="contliab">
	
	SELECT LDEXTRA.LASTNAME, 
    LDEXTRA.FIRSTNAME, 
    LAWDEPARTMENT.LONGEMAIL, 
    trim(LAWDEPARTMENT.OFFICE) AS OFFICE, 
    LDEXTRA.PRIMARYKEY
	
	FROM LAWDEPARTMENT, 
    LDEXTRA
	
	WHERE LAWDEPARTMENT.PRIMARYKEY = LDEXTRA.PRIMARYKEY
	
	AND (UPPER(AD_USERID) LIKE UPPER('#Form.RespondingUser_Id#%') OR UPPER(AD_MAILNICKNAME) LIKE UPPER('#Form.RespondingUser_Id#%'))
	
	</cfquery>
	
	
	<CFQUERY NAME="GetCCLine_Auth_Users_Office" DATASOURCE="contliab">
	
	SELECT DISTINCT lawdepartment.LASTNAME, lawdepartment.FIRSTNAME, lawdepartment.LONGEMAIL, lawdepartment.PRIMARYKEY, LDPOSITIONSORT.SORTORDER
	
	FROM lawdepartment, BUSINESSSERVUSERS, LDEXTRA, LDPOSITIONSORT
	
	WHERE lawdepartment.PRIMARYKEY = BUSINESSSERVUSERS.USERPRMKEY
	
	AND lawdepartment.PRIMARYKEY = LDEXTRA.PRIMARYKEY
	
<!---	
	AND 
    LAWDEPARTMENT.OFFICE LIKE '#Get_SenderInfo.OFFICE#%'
--->


	AND 
    trim(LAWDEPARTMENT.OFFICE) = '#Get_SenderInfo.OFFICE#'


	AND LAWDEPARTMENT.TITLE = LDPOSITIONSORT.POSITION
	
	AND (lawdepartment.SEPARATFLG != 'S' OR lawdepartment.SEPARATFLG IS NULL)
	
	AND (BUSINESSSERVUSERS.CONTINGENT_LIAB_AUTH = 'O' OR BUSINESSSERVUSERS.CONTINGENT_LIAB_AUTH = 'B' OR BUSINESSSERVUSERS.CONTINGENT_LIAB_AUTH = 'T')
	
	AND NOT (UPPER(LDEXTRA.AD_USERID) LIKE UPPER('#Form.RespondingUser_Id#%') OR UPPER(LDEXTRA.AD_MAILNICKNAME) LIKE UPPER('#Form.RespondingUser_Id#%'))
	
	ORDER BY LDPOSITIONSORT.SORTORDER, lawdepartment.LASTNAME
	
	</cfquery>

	
	<CFSET CCLine = "">


	<CFLOOP QUERY="GetCCLine_Auth_Users_Office">
	
		<CFSET TrimCCLineLastName = Trim(LASTNAME)>
		<CFSET TrimCCLineFirstName = Trim(FIRSTNAME)>
		<CFSET TrimCCLineEMailAddr = Trim(LONGEMAIL)>
		
		<CFIF TrimCCLineEMailAddr EQ "">
			<CFSET DefaultCCLongEmailFirstName = Replace(TrimCCLineFirstName, " ", ".", "ALL")>
			<CFSET DefaultCCLongEmailFirstName = Replace(DefaultCCLongEmailFirstName, "..", "", "ALL")>
			<CFIF Right(DefaultCCLongEmailFirstName, 1) NEQ ".">
				<CFSET DefaultCCLongEmailFirstName = DefaultCCLongEmailFirstName & ".">
			</cfif>
			<CFSET TrimCCLineEMailAddr = DefaultCCLongEmailFirstName & TrimCCLineLastName>
		</cfif>
		
		<CFSET CCLine = ListAppend(CCLine, TrimCCLineEMailAddr & "@usps.gov")>
	
	</cfloop>

<CFIF IsDefined("Test_Email_Addr")>
		<CFSET SendEmailFromMC_To = Test_Email_Addr>
	<CFELSE>
		<CFSET SendEmailFromMC_To = ToLine>
	</CFIF>


	<CFMAIL
	    FROM="Kimsa.T.Mac@usps.gov" <!---#This_EE_From_Line#--->
	    TO="#ToLine#"
	    CC="#CCLine#"
	    BCC="Kimsa.T.Mac@usps.gov,#Trim(QueryGetBusServContactDisplayName.mail)#" <!---gccontliab@usps.gov--->
	    SUBJECT="#ApprWordSubj#: New Contingent Liabilities Case Record"
		TYPE="HTML">
	
<!--- Kimsa test email--->
	<!---<CFIF IsDefined("Test_Email_Addr")>
		<CFSET SendEmailFromMC_To = Test_Email_Addr>
	<CFELSE>
		<CFSET SendEmailFromMC_To = ToLine>
	</CFIF>


	<CFMAIL
	    FROM="#This_EE_From_Line#"
	    TO="#ToLine#"
	    CC="#CCLine#"
	    BCC="LawDeptSurvey@usps.gov,#Trim(QueryGetBusServContactDisplayName.mail)#"
	    SUBJECT="#ApprWordSubj#: New Contingent Liabilities Case Record"
		TYPE="HTML">--->
	
	
	<div style="font-family:arial; font-size:10pt">
	
	<CFOUTPUT>
	
	
	<CFIF IsDefined("Test_Email_Addr")>
	
	TO="#ToLine#"
	<p>
	
	</cfif>
	
	<!---
	GAC - 07/08/2013 - changed lawdept.usps.gov
	I have <b>#ApprWordText#</b> this Contingent Liabilities Case Record: <a href="https://lawdept.usps.gov/InHouse/ContingentLiabilities/Report.cfm?RecIDParm=#Form.RecID#">#Form.CASE_NAME#, #Form.CASE_NUMBER#</a>.
	--->
	
	
	<!--- Bob Sindermann 12/6/2013: Changed to Lawdept1 to correct for users still on Lawdept or BA0 server --->
	<!---KS 4.7.25 Updated Server: changed lawdept1.usps.gov to lawdept.usps.gov --->
	I have <b>#ApprWordText#</b> this Contingent Liabilities Case Record: <a href="https://eagnmnss58b:8182/InHouse/ContingentLiabilities/Report.cfm?RecIDParm=#Form.RecID#">#Form.CASE_NAME#, #Form.CASE_NUMBER#</a>.
	
	
	<CFIF IsDefined("Form.DisapprovalComment") AND ((IsDefined("Form.MC_Approval_Flag") AND Form.MC_Approval_Flag EQ "2") OR (IsDefined("Form.Alt_Approval_Flag") AND Form.Alt_Approval_Flag EQ "2"))>
	
	<CFIF Form.DisapprovalComment NEQ "">
	<p>
	<i>Please note:</i>
	#Form.DisapprovalComment#
	</cfif>
	
	</cfif>
	
	<p>
	Please contact me if you have any questions.
	
	<p>
	Thank you,
	<br>
	
	
	#TrimUserFirstName#
	
	#TrimUserLastName#
	
	
	</div>
	
	</cfoutput>
	
	</CFMAIL>


<!--- From <CFIF IsDefined("Form.MC_Approval_Flag") --->
<CFELSE>

	Error in Send Mail function.

</cfif>


<CFOUTPUT>
<form name="ReturnForm" METHOD="POST" ACTION="Report.cfm###Form.RecID#">
</cfoutput>
</form>


<CFIF Form.COCOUNSEL_LAW_DEPT NEQ "" AND Form.COCOUNSEL_LAW_DEPT NEQ 0>
	<CFSET AlertCoCounselText = "and " & Trim_Co_Counsel_FirstName & " " & Trim_Co_Counsel_LastName & " ">
<CFELSE>
	<CFSET AlertCoCounselText = "">
</cfif>



<script language="javascript">

<CFOUTPUT>
alert("An e-mail notice has been sent to #Trim_Counsel_FirstName# #Trim_Counsel_LastName# #AlertCoCounselText# that the new case record has been #ApprWordText#.");
</cfoutput>

ReturnForm.submit();
</script>


</body>
</html>



