<cfinclude template="MfaCookieCheck.cfm">

<!---
5/21/09 Changed references to 5000000 cutoff: Use ASSESSMENT_AMOUNT instead of ASSESSMENT_AMOUNT_UPPER. Also add range for ASSESSMENT_AMOUNT (to ASSESSMENT_AMT_HIGH_END) and ASSESSMENT_AMOUNT_UPPER (to ASSESSMENT_AMT_UPPER_HIGH_END), using
Form.ASSESSMENT_AMT_HIGH_END_Orig and Form.ASSESSMENT_AMT_UPPER_HIGH_END_Orig
--->


<CFQUERY NAME="GetAll_Auth_Users_Office" DATASOURCE="contliab">

SELECT DISTINCT a.LASTNAME, a.FIRSTNAME, a.LONGEMAIL, a.PRIMARYKEY, c.SORTORDER

FROM lawdepartment a, BUSINESSSERVUSERS b, LDPOSITIONSORT c

WHERE a.PRIMARYKEY = b.USERPRMKEY

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
CHR(32) = space

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

<!--- Kimsa Comment email for testing on development 7/18/2023--->

<CFIF IsDefined("Test_Email_Addr")>
	<CFSET EditRecord_cfmail_To = Test_Email_Addr>
<CFELSE>
	<CFSET EditRecord_cfmail_To = ToMCLine> 
</CFIF>


<CFMAIL
   
     FROM="#This_EE_From_Line#"
    TO="#EditRecord_cfmail_To#"
    BCC="gccontliab@usps.gov,#Trim(QueryGetBusServContactDisplayName.mail)#"
    SUBJECT="#Form.CASE_NAME#: #ASSESSMENT_AMOUNT_Change# in Contingent Liabilities Assessment"
	TYPE="HTML">



<div style="font-family:arial; font-size:10pt">
<CFOUTPUT>


<CFIF IsDefined("Test_Email_Addr")>
TO: #ToMCLine#
<p>
</cfif>


For the Contingent Liabilities report on



<CFIF IsDefined("Test_Server_Folder")>
	<CFSET ServerFolder = Test_Server_Folder>
<CFELSE>
	<CFSET ServerFolder = "">
</cfif>

<CFIF IsDefined("Test_Server")>
        <CFSET This_Server = Test_Server>
<CFELSE>
		<!---
		GAC-8/08/2013: changed this_server to cgi variable
        <CFSET This_Server = "lawdept">
		--->
        <!--- URL now derives from App_Base_URL defined in application.cfm --->
        <CFSET This_Server = App_Base_URL>
        
</cfif>


<a href="<cfoutput>#This_Server#</cfoutput>/ClientService/ContingentLiabilities/#ServerFolder#Report.cfm?RecIDParm=#ThisRecID#">#Form.CASE_NAME#</a>,



Case No. #Form.CASE_NUMBER#:
<p>
The Most Likely Payout has been <b>#ASSESSMENT_AMOUNT_Change_Phrase#</b>:

<ul>

<li><b>Previous Damages Assessment range</b>
<ul>
<li>Most Likely Payout: 

<b>$#Form.ASSESSMENT_AMOUNT_Orig# Million</b> 

<CFIF Form.ASSESSMENT_AMT_HIGH_END_Orig NEQ "">
	- $#Form.ASSESSMENT_AMT_HIGH_END_Orig# Million
</CFIF>

<li>Maximum Reasonable Payout:

$#Form.ASSESSMENT_AMOUNT_UPPER_Orig# Million

<CFIF Form.ASSESSMENT_AMT_UPPER_HIGH_END_Orig NEQ "">
	- $#Form.ASSESSMENT_AMT_UPPER_HIGH_END_Orig# Million
</CFIF>

</ul>
<p>

<li><b>Revised Damages Assessment range</b>
<!---
$#Form.ASSESSMENT_AMOUNT# Million - $#Form.ASSESSMENT_AMOUNT_UPPER# Million
--->


<ul>

<li>Most Likely Payout: 

<b>$#Form.ASSESSMENT_AMOUNT# Million</b> 

<CFIF Form.ASSESSMENT_AMT_HIGH_END NEQ "">
	- $#Form.ASSESSMENT_AMT_HIGH_END# Million
</CFIF>

<li>Maximum Reasonable Payout:

$#Form.ASSESSMENT_AMOUNT_UPPER# Million

<CFIF Form.ASSESSMENT_AMT_UPPER_HIGH_END NEQ "">
	- $#Form.ASSESSMENT_AMT_UPPER_HIGH_END# Million
</CFIF>

</ul>


</cfoutput>

</ul>
Please let me know if you have any questions or need anything else.
<p>
Thank you,
<br>

<CFOUTPUT>

#TrimUserFirstName# #TrimUserLastName#

</cfoutput>

</div>

</CFMAIL>



