<cfinclude template="MfaCookieCheck.cfm">
<!---
<cfset Init_User_Id = TRIM(UCASE(RemoveChars(auth_user,1,find('\',auth_user))))>
Init_User_Id variable equals: <cfoutput>"#Init_User_Id#"</cfoutput> <br>

<h3>Server:  Eagnmnwep1432<//h3><br>
<CFDUMP VAR="#CGI#">--->

<!DOCTYPE html>
<html>
	<head>
		<title>CF Mail Test on DEV</title>
	</head>
	<body>
		<p>This is a test for cfmail to see if the connection works11111</p>
		<!---<cfdump var="#cgi#" >--->
		<cftry>
		<cfmail from="Kimsa.t.mac@usps.gov"
		 subject="Thank you for your email"
		  to="Kimsa.t.mac@usps.gov"
		  <!---BCC="Kimsa.t.mac@usps.gov"--->
		   usetls="true" debug="true" >
			<p>Kimsa,</p>
			<p>It worked for me.</p>
			<p>Kimsa</p>
		</cfmail>
		<cfcatch type="any" >
			<cfdump var="#cfcatch#" >
		</cfcatch>
		</cftry>
	</body>
</html>
</html>



