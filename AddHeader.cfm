<!---<cfif findNoCase("AddHeader","#CGI.eagnmnss58b#") gt 0>
	<h1 style="background-color:#000099; color:#ffcc66; font-weight:bold; text-align:center;">NEW HEADER</h1>
</cfif>--->

<!---
<!---<h1 style="background-color:#000099; color:#ffcc66; font-weight:bold; text-align:center;">NEW HEADER</h1>--->
<cfif findNoCase("preprod",templatePath) gt 0>
	<h1 style="background-color:#000099; color:#ffcc66; font-weight:bold; text-align:center;">NEW HEADER</h1>
</cfif>--->

<h1 style="background-color:#000099; color:#ffcc66; font-weight:bold; text-align:center;">New sub-header </h1> 
<!---<cfif FindNoCase("AddHeader","#CGI.PATH_INFO#") gt 0> returns <cfoutput>#FindNoCase("AddHeader",templatePath)#</cfoutput>
</cfif>--->