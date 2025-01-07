<cfset ThisNewList = NewList>
<cfset ThisOldList = OldList>

arrray it out,
get the length of array

if they are the same compare each array and then put the difference in strong(which makes it red
If not the same lenght, find idstrict in ecach sarray since district is hardcoded as a sting oin report.ptc line 350???? refer to the variable THIS_DIST_CLUSTER_NAME?? probably a final declartgion since its all caps
--compare the array listing by sorting or some type of array manipulation on before and after the string distrinct and then put them in strong selement

<!---<cfset OldArrayLen = compare("OldArray", "NewArray")>
OldArrayLen to NewArrayLen1 : <cfdump var="#OldArrayLen#" / ><br>
<cfif len(newArray) eq len(oldArray)>
	<cfloop from="1" to="#arraylen(oldarray)#" index="i" >
		<cfif compare(oldarray[i],newarray[i]) eq 0>
			<!--- keep the text black --->
		<cfelse>
		<!--- new array val needs to be red --->
	</cfloop>
</cfif>
--->

<!---<CFSET PunctuationList = "">
	<CFSET PunctuationList = ListAppend(PunctuationList, '"')>
	<CFSET PunctuationList = ListAppend(PunctuationList, "'")>
	<CFSET PunctuationList = ListAppend(PunctuationList, ".")>
	<CFSET PunctuationList = ListAppend(PunctuationList, ";")>
	<CFSET PunctuationList = ListAppend(PunctuationList, "/")>
	<CFSET PunctuationList = ListAppend(PunctuationList, "\")>
	<CFSET PunctuationList = ListAppend(PunctuationList, "<br><br>")>
<CFdump var="#PunctuationList#" >--->

<!---<cfset stringOne  = "this is one word">
<cfset stringTwo = "this is two two words">
<Cfset stringOneCap = "This Is One Word">
<cfset stringTwoCap = "This Is Two Two Words">

<CFSET stringOneArray = ListToArray(stringOne, " ")>
<CFSET stringOneArrayLen = ArrayLen(stringOneArray)>
<CFSET stringTwoArray = ListToArray(stringTwo, " ")>
<CFSET stringTwoArrayLen = ArrayLen(stringTwoArray)>
<CFSET stringOneCapArray = ListToArray(stringOneCap, " ")>
<CFSET stringOneCapArrayLen = ArrayLen(stringOneCapArray)>
<CFSET stringTwoCapArray = ListToArray(stringTwoCap, " ")>
<CFSET stringTwoCapArrayLen = ArrayLen(stringTwoCapArray)>

<cfset OldArrayLen = compare("stringTwo", "stringOneCap")>
Compare string one to string two : <cfdump var="#OldArrayLen#" / ><br>
<cfdump var="#stringOneArray#" >
<cfoutput>count #stringOneArrayLen#</cfoutput><br>
<cfoutput>##</cfoutput><br>
<cfoutput>##</cfoutput><br>
<cfoutput>##</cfoutput><br>
<cfoutput>##</cfoutput><br>
<cfoutput>##</cfoutput><br>
<cfoutput>##</cfoutput><br>
<cfoutput>##</cfoutput><br>
<cfoutput>##</cfoutput><br>
<!----1, if string1 is less than string2    --- 0, if string1 is equal to string2  ----- 1, if string1 is greater than string 2
cmpare(string1, string2) -> returns numeric

stringOne ; stringTwo = -1
stringOne : stringOneCap = -1
stringOne : string One = 0
stringOne : stringTwoCap = -1
compare("stringTwo", "stringTwoCap") = -1
compare("stringTwo", "stringOne" = 1
compare(??? or "stringTwo", "stringOneCap") = 1
 --->---

