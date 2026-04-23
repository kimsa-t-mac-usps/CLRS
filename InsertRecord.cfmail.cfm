<cfinclude template="MfaCookieCheck.cfm">


<!---
<CFQUERY NAME="GetUserInfo" DATASOURCE="contliab">

SELECT LDEXTRA.LASTNAME, LDEXTRA.FIRSTNAME, LAWDEPARTMENT.LONGEMAIL, LDEXTRA.PRIMARYKEY

FROM LAWDEPARTMENT, LDEXTRA

WHERE LAWDEPARTMENT.PRIMARYKEY = LDEXTRA.PRIMARYKEY

AND (UPPER(AD_USERID) LIKE UPPER('#RespondingUser_Id#%') OR UPPER(AD_MAILNICKNAME) LIKE UPPER('#RespondingUser_Id#%'))

</cfquery>

<CFSET TrimUserLastName = Trim(GetUserInfo.LASTNAME)>
<CFSET TrimUserFirstName = Trim(GetUserInfo.FIRSTNAME)>
<CFSET TrimUserEMailAddr = Trim(GetUserInfo.LONGEMAIL)>

<CFIF TrimUserEMailAddr EQ "">
	<CFSET DefaultUserLongEmailFirstName = Replace(TrimUserFirstName, " ", ".", "ALL")>
	<CFSET DefaultUserLongEmailFirstName = Replace(DefaultUserLongEmailFirstName, "..", "", "ALL")>
	<CFIF Right(DefaultUserLongEmailFirstName, 1) NEQ ".">
		<CFSET DefaultUserLongEmailFirstName = DefaultUserLongEmailFirstName & ".">
	</cfif>
	<CFSET TrimUserEMailAddr = DefaultUserLongEmailFirstName & TrimUserLastName>
</cfif>
--->


<CFQUERY NAME="GetAll_Auth_Users_Office" DATASOURCE="contliab">

SELECT DISTINCT a.LASTNAME, a.FIRSTNAME, a.LONGEMAIL, a.PRIMARYKEY, c.SORTORDER

FROM lawdepartment a, BUSINESSSERVUSERS b, LDPOSITIONSORT c

WHERE a.PRIMARYKEY = b.USERPRMKEY

<!---
AND LAWDEPARTMENT.OFFICE IN (SELECT office
FROM ldoffices
WHERE OFFICE_PRM_KEY = #Form.LAW_DEPT_OFFICE#)
--->

AND a.OFFICE IN 
(
SELECT office
FROM ldoffices
WHERE 
<!---
OFFICE_PRM_KEY = #Form.LAW_DEPT_OFFICE#
--->

<!--- Include LAW_DEPT_OFFICE (OFFICE_PRM_KEY in LDOFFICES) for both Northeast Windsor (16) and New York (former code 7) --->	
<CFIF Form.LAW_DEPT_OFFICE EQ 7
OR
Form.LAW_DEPT_OFFICE EQ 16>

	OFFICE_PRM_KEY IN (7,16)
	
<CFELSE>
        
	OFFICE_PRM_KEY = #Form.LAW_DEPT_OFFICE#

</CFIF>

)



AND TRIM(a.TITLE) = TRIM(c.POSITION)

AND (a.SEPARATFLG != 'S' OR a.SEPARATFLG IS NULL)

AND (b.CONTINGENT_LIAB_AUTH = 'O' OR b.CONTINGENT_LIAB_AUTH = 'B' OR b.CONTINGENT_LIAB_AUTH = 'T')

ORDER BY c.SORTORDER, a.LASTNAME

</cfquery>

<CFSET ToMCLine = "">

<CFSET AlertToLine = "">

<CFLOOP QUERY="GetAll_Auth_Users_Office">

<CFSET TrimMCLastName = Trim(LASTNAME)>
<CFSET TrimMCFirstName = Trim(FIRSTNAME)>
<CFSET TrimMCEMailAddr = Trim(LONGEMAIL)>

<!---
<CFSET AlertToLine = ListAppend(AlertToLine, TrimMCFirstName & " " & TrimMCLastName, "," & CHR(32))>
--->

<CFSET AlertToLine = ListAppend(AlertToLine, " " & TrimMCFirstName & " " & TrimMCLastName)>
<CFIF TrimMCEMailAddr EQ "">
	<CFSET DefaultMCLongEmailFirstName = Replace(TrimMCFirstName, " ", ".", "ALL")>
	<CFSET DefaultMCLongEmailFirstName = Replace(DefaultMCLongEmailFirstName, "..", "", "ALL")>
	<CFIF Right(DefaultMCLongEmailFirstName, 1) NEQ ".">
		<CFSET DefaultMCLongEmailFirstName = DefaultMCLongEmailFirstName & ".">
	</cfif>
	<CFSET TrimMCEMailAddr = DefaultMCLongEmailFirstName & TrimMCLastName>
</cfif>

<CFSET ToMCLine = ListAppend(ToMCLine, TrimMCEMailAddr & "@usps.gov")>

</cfloop>


<!--- Kimsa test email --->
<!---<CFIF IsDefined("Test_Email_Addr")>
	<CFSET InsertRecord_cfmail_To = Test_Email_Addr>
<CFELSE>
	<CFSET InsertRecord_cfmail_To = ToMCLine>
</CFIF>

<!---
    FROM="#TrimUserEMailAddr#@usps.gov"
--->


<CFMAIL
    FROM="#This_EE_From_Line#"
    TO="#InsertRecord_cfmail_To#"
    BCC="LawDeptSurvey@usps.gov,#Trim(QueryGetBusServContactDisplayName.mail)#"
    SUBJECT="New Contingent Liabilities Case Record For Approval"
	TYPE="HTML">
--->
<CFIF IsDefined("Test_Email_Addr")>
	<CFSET InsertRecord_cfmail_To = Test_Email_Addr>
<CFELSE>
	<CFSET InsertRecord_cfmail_To = ToMCLine>
</CFIF>

<!---
    FROM="#TrimUserEMailAddr#@usps.gov"
--->


<CFMAIL
    FROM="#This_EE_From_Line#"
    TO="#InsertRecord_cfmail_To#"
    BCC="gccontliab@usps.gov,#Trim(QueryGetBusServContactDisplayName.mail)#"
    SUBJECT="New Contingent Liabilities Case Record For Approval"
	TYPE="HTML">


<div style="font-family:arial; font-size:10pt">
<CFOUTPUT>


<CFIF IsDefined("Test_Email_Addr")>
TO: #ToMCLine#
<p>
</cfif>


<CFIF IsDefined("Test_Server")>
        <CFSET This_Server = Test_Server>
<CFELSE>

<!---
		<!---
		GAC-8/08/2013: changed this_server to cgi variable
        <CFSET This_Server = "lawdept">
		--->
        <CFSET This_Server = #CGI.SERVER_NAME#>
--->

<!--- Bob Sindermann 12/5/2013: Changed to Lawdept1 to correct for users still on Lawdept or BA0 server --->
        <!--- URL now derives from App_Base_URL defined in application.cfm --->
        <CFSET This_Server = App_Base_URL>

</cfif>
<CFIF IsDefined("Test_Server_Folder")>
	<CFSET ServerFolder = Test_Server_Folder>
<CFELSE>
	<CFSET ServerFolder = "V1.0/">
</cfif>
A new Contingent Liabilities case record has been entered in the system for your approval:

<!---
<a href="https://<cfoutput>#This_Server#</cfoutput>/InHouse/ContingentLiabilities/#ServerFolder#Report.cfm?RecIDParm=#Get_CONTINGENT_LIAB_REPORT_Currval.CONTINGENT_LIAB_REPORT_CURRVAL#">#Form.CASE_NAME#, #Form.CASE_NUMBER#</a>.
--->

<a href="#This_Server#/ClientService/ContingentLiabilities/#ServerFolder#Report.cfm?RecIDParm=#Get_CONTINGENT_LIAB_REPORT_Currval.CONTINGENT_LIAB_REPORT_CURRVAL#">#Form.CASE_NAME#, #Form.CASE_NUMBER#</a>.

</cfoutput>

<p>
Please let me know if you have any questions or need anything else.
<p>
Thank you,
<br>
<CFOUTPUT>
#TrimUserFirstName# #TrimUserLastName#
</cfoutput>

</div>

</CFMAIL>



