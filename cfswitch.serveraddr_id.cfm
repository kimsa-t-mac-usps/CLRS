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

<CFCASE VALUE="eagnmnss58b">
	<CFSET ServerID = "eagnmnss58b">
</CFCASE>

<CFCASE VALUE="eagnmnss146">
	<CFSET ServerID = "eagnmnss146">
</CFCASE>

<CFCASE VALUE="eagnmnwbd203">
	<CFSET ServerID = "eagnmnwbd203">
</CFCASE>

<CFCASE VALUE="eagnmnwbd204">
	<CFSET ServerID = "eagnmnwbd204">
</CFCASE>

<CFDEFAULTCASE>
	<CFSET ServerID = CGI.SERVER_NAME>
</CFDEFAULTCASE>

</CFSWITCH>

<CFSET ServerID_NoBrackets = ServerID>

<CFSET ServerID = "[" & ServerID & "]">


