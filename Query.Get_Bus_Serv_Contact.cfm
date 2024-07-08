<cfinclude template="MfaCookieCheck.cfm">
<!---------------------- Query.Get_Bus_Serv_Contact.cfm ---------------------->
<!---------------------------------------------------------------------------->
<!--- KS --->
	<!---<CFOUTPUT>
		<br />
		Program = "Query.Get_Bus_Serv_Contact.cfm"
		<br />
	</CFOUTPUT>--->
<CFQUERY NAME="Get_Bus_Serv_Contact" DATASOURCE="lddb">
SELECT Trim(a.LASTNAME) AS Trim_LASTNAME,
Trim(a.FIRSTNAME) AS Trim_FIRSTNAME,
Trim(a.TITLE) AS Trim_TITLE,
Trim(a.OFFICE) AS Trim_OFFICE,
Trim(a.VOICE) AS Trim_VOICE,
Trim(a.LONGEMAIL) AS Trim_LONGEMAIL,
b.EMPLOYEE_ID

FROM lawdepartment a, 
ldextra b,
BUSINESSSERVUSERS c

WHERE a.PRIMARYKEY = b.PRIMARYKEY

AND
(a.SEPARATFLG != 'S' OR a.SEPARATFLG IS NULL OR a.SEPARATFLG = '0')

<!---
AND a.LASTNAME LIKE 'Valentin%'
AND a.FIRSTNAME LIKE 'Maria%'
--->

<!---
AND a.LASTNAME LIKE 'Whitehead%'
AND a.FIRSTNAME LIKE 'Nia%'
--->

AND
b.AD_USERID = c.AD_USERID

AND
c.SURNAME = 'Contingent Liabilities Contact'


</cfquery>



<CFIF Get_Bus_Serv_Contact.Trim_LONGEMAIL EQ "">
	<CFSET Trim_FIRSTNAME = Replace(Get_Bus_Serv_Contact.Trim_FIRSTNAME, " ", ".", "ALL")>
	<CFSET Trim_FIRSTNAME = Replace(Trim_FIRSTNAME, "..", "", "ALL")>
	<CFIF Right(Trim_FIRSTNAME, 1) NEQ ".">
		<CFSET Trim_FIRSTNAME = Trim_FIRSTNAME & ".">
	</cfif>
	<CFSET Get_Bus_Serv_Contact_Trim_LONGEMAIL = Trim_FIRSTNAME & Get_Bus_Serv_Contact.Trim_LASTNAME>
    
<CFELSE>

	<CFSET Get_Bus_Serv_Contact_Trim_LONGEMAIL = Get_Bus_Serv_Contact.Trim_LONGEMAIL>
	
</cfif>


<CFSET Get_Bus_Serv_Contact_Trim_LONGEMAIL = Get_Bus_Serv_Contact_Trim_LONGEMAIL & "@usps.gov">



<CFQUERY NAME="Get_Bus_Serv_Mgr" DATASOURCE="lddb">
SELECT Trim(a.LASTNAME) AS Trim_LASTNAME, Trim(a.FIRSTNAME) AS Trim_FIRSTNAME, Trim(a.TITLE) AS Trim_TITLE, Trim(a.VOICE) AS Trim_VOICE, Trim(a.LONGEMAIL) AS Trim_LONGEMAIL

FROM lawdepartment a
WHERE 
(a.SEPARATFLG != 'S' OR a.SEPARATFLG IS NULL OR a.SEPARATFLG = '0')

AND a.TITLE LIKE 'Manager, Integration and Support%'

</cfquery>



<CFIF Get_Bus_Serv_Mgr.Trim_LONGEMAIL EQ "">
	<CFSET Trim_FIRSTNAME = Replace(Get_Bus_Serv_Mgr.Trim_FIRSTNAME, " ", ".", "ALL")>
	<CFSET Trim_FIRSTNAME = Replace(Trim_FIRSTNAME, "..", "", "ALL")>
	<CFIF Right(Trim_FIRSTNAME, 1) NEQ ".">
		<CFSET Trim_FIRSTNAME = Trim_FIRSTNAME & ".">
	</cfif>
	<CFSET Get_Bus_Serv_Mgr_Trim_LONGEMAIL = Trim_FIRSTNAME & Get_Bus_Serv_Mgr.Trim_LASTNAME>
    
<CFELSE>

	<CFSET Get_Bus_Serv_Mgr_Trim_LONGEMAIL = Get_Bus_Serv_Mgr.Trim_LONGEMAIL>
    
</cfif>


<CFSET Get_Bus_Serv_Mgr_Trim_LONGEMAIL = Get_Bus_Serv_Mgr_Trim_LONGEMAIL & "@usps.gov">
