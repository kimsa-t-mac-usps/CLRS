<cfinclude template="MfaCookieCheck.cfm">


<CFIF IsNumeric(ThisString)>

	<CFSET ValidatedString = ThisString>

<CFELSE>

	<CFSET ThisString_Len = Len(ThisString)>
	<CFSET ValidatedString = "">

	<CFLOOP INDEX="ThisString_Index" FROM="1" TO="#ThisString_Len#">
		<CFSET ThisString_Char = Mid(ThisString, ThisString_Index, 1)>
		<CFIF (ThisString_Char GE 0 AND ThisString_Char LE 9) OR ThisString_Char EQ ".">
			<CFSET ValidatedString = ValidatedString & ThisString_Char>
		</cfif>
	</cfloop>

</cfif>




