<cfinclude template="MfaCookieCheck.cfm">

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
<title>E-mail: No Cases for Office</title>
</head>

<body style="font-family:arial; font-size:10pt" onLoad="setTimeout('window.close();',10000)">

<b>U.S. Postal Service Law Department</b>
<br>
<b>Contingent Liabilities and Receivables</b>
<br>

<CFIF IsDefined("Rpt")>

<CFOUTPUT>
<h3>Report for #Rpt#</h3>
</cfoutput>

</cfif>



<CFIF NOT (IsDefined("From") AND IsDefined("Office") AND IsDefined("Rpt"))>

Sorry, there was an error in sending the e-mail message. Please send an e-mail message through Outlook.

<CFELSE>

<!---
<CFQUERY NAME="Get_ReplyUser" DATASOURCE="ContLiab">
SELECT LAWDEPARTMENT.LASTNAME, LAWDEPARTMENT.FIRSTNAME, LAWDEPARTMENT.LONGEMAIL
FROM LAWDEPARTMENT, LDEXTRA
WHERE LAWDEPARTMENT.PRIMARYKEY = LDEXTRA.PRIMARYKEY
AND
(UPPER(AD_USERID) LIKE UPPER('#From#%')
OR UPPER(AD_MAILNICKNAME) LIKE UPPER('#From#%'))
</cfquery>

<CFSET TrimLastName = Trim(Get_ReplyUser.LASTNAME)>
<CFSET TrimFirstName = Trim(Get_ReplyUser.FIRSTNAME)>
<CFSET TrimEMailAddr = Trim(Get_ReplyUser.LONGEMAIL)>

<CFIF TrimEMailAddr EQ "">
	<CFSET DefaultLongEmailFirstName = Replace(TrimFIRSTNAME, " ", ".", "ALL")>
	<CFSET DefaultLongEmailFirstName = Replace(DefaultLongEmailFirstName, "..", "", "ALL")>
	<CFIF Right(DefaultLongEmailFirstName, 1) NEQ ".">
		<CFSET DefaultLongEmailFirstName = DefaultLongEmailFirstName & ".">
	</cfif>
	<CFSET TrimEMailAddr = DefaultLongEmailFirstName & TrimLASTNAME>
</cfif>

<CFSET TrimEMailAddr = TrimEMailAddr & "@usps.gov">
--->

<CFIF IsDefined("Test_Email_Addr")>
	<CFSET email_cfmail_nocases_To = Test_Email_Addr>
<CFELSE>
	<CFSET email_cfmail_nocases_To = Trim(QueryGetBusServContactDisplayName.mail)>
</CFIF>



<!---
    FROM="#TrimEMailAddr#"
--->

<CFMAIL
   
    
    FROM="#This_EE_From_Line#"
    <!---TO="#email_cfmail_nocases_To#"
    BCC="gccontliab@usps.gov"--->
     TO="Kimsa.T.Mac@usps.gov"
    BCC="Kimsa.T.Mac@usps.gov"
    SUBJECT="No Cases From #Trim(Office)# to Report for Contingent Liabilities Report, #Trim(Rpt)#"
	TYPE="HTML">

<!--- Kimsa test email --->
<!---<CFIF IsDefined("Test_Email_Addr")>
	<CFSET email_cfmail_nocases_To = Test_Email_Addr>
<CFELSE>
	<CFSET email_cfmail_nocases_To = Trim(QueryGetBusServContactDisplayName.mail)>
</CFIF>



<!---
    FROM="#TrimEMailAddr#"
--->

<CFMAIL
    FROM="#This_EE_From_Line#"
    TO="#email_cfmail_nocases_To#"
    BCC="LawDeptSurvey@usps.gov"
    SUBJECT="No Cases From #Office# to Report for Contingent Liabilities Report, #Rpt#"
	TYPE="HTML">
--->


<div style="font-family:arial; font-size:10pt">

<CFOUTPUT>
#Trim(Office)#
has no cases to report for the Contingent Liabilities Report, #Rpt#.
<p>
Please let me know if you have any questions or need anything else.
<p>
Thank you,
<br>
#TrimUserFirstName# #TrimUserLastName#
</cfoutput>

</div>

</cfmail>

<h3>Thanks for your message!</h3>

<CFOUTPUT>
We will note your response that #Office# has <b>no cases</b> to report for the current Contingent Liabilities and Receivables Report.
</cfoutput>

<p>
Please let me know if you have any questions.
<p>

<CFOUTPUT>
#Get_Bus_Serv_Contact.Trim_FIRSTNAME# #Get_Bus_Serv_Contact.Trim_LASTNAME#
<br>
#Get_Bus_Serv_Contact.Trim_OFFICE#
<br>
#Get_Bus_Serv_Contact.Trim_VOICE#
</CFOUTPUT>

or 

<CFOUTPUT>
<a href="mailto:#Trim(QueryGetBusServContactDisplayName.mail)#?subject=Contingent Liabilities Question"><b>e-mail</b></a>
</CFOUTPUT>


</cfif>


</body>
</html>



