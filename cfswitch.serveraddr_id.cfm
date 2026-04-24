<!--- Displays server ID / name in page header --->

<CFSWITCH EXPRESSION="#CGI.SERVER_NAME#">

<!---
<CFCASE VALUE="56.207.69.229">
	<CFSET ServerID = "d2f">
</CFCASE>

<CFCASE VALUE="56.207.69.228">
	<CFSET ServerID = "d08">
</CFCASE>

<CFCASE VALUE="56.207.31.151">
	<CFSET ServerID = "ba0">
</CFCASE>
--->

<CFCASE VALUE="eagnmnss58b,56.76.29.90">
	<CFSET ServerID = "eagnmnss58b">
</CFCASE>

<CFCASE VALUE="eagnmnss146,56.76.28.86">
	<CFSET ServerID = "eagnmnss146">
</CFCASE>

<CFCASE VALUE="eagnmnwbd203,56.76.100.115">
	<CFSET ServerID = "eagnmnwbd203">
</CFCASE>

<CFCASE VALUE="eagnmnwbd204,56.76.100.116">
	<CFSET ServerID = "eagnmnwbd204">
</CFCASE>

<CFDEFAULTCASE>
	<CFSET ServerID = "lawdept1-dev.usps.gov">
</CFDEFAULTCASE>

</CFSWITCH>

<CFSET ServerID_NoBrackets = ServerID>

<CFSET ServerID = "[" & ServerID & "]">


