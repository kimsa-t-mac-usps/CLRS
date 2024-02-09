<cfinclude template="MfaCookieCheck.cfm">


<CFSET Result_String = Replace(Orig_String, "\r\n", "<br>", "ALL")>
<CFSET Result_String = Replace(Result_String, '\"', '"', 'ALL')>
<CFSET Result_String = Replace(Result_String, "\'", "'", "ALL")>

<CFSET Result_String = Replace(Result_String, "\", "", "ALL")>
<CFSET Result_String = Replace(Result_String, "''''", "'", "ALL")>
<CFSET Result_String = Replace(Result_String, "''", "'", "ALL")>

<!---
<CFSET Result_String = Replace(Result_String, "'", "''", "ALL")>
--->

<!--- Replace left and right curly double quotes with ditto marks --->
<CFSET Result_String = Replace(Result_String, chr(8220), chr(34), "ALL")>
<CFSET Result_String = Replace(Result_String, chr(8221), chr(34), "ALL")>

<!--- Replace left and right curly single quotes with straight apostrophe --->
<CFSET Result_String = Replace(Result_String, chr(8216), chr(39), "ALL")>
<CFSET Result_String = Replace(Result_String, chr(8217), chr(39), "ALL")>

<!--- Replace inverted question mark and "t" (probably from pasting text with bullet) with hyphen --->
<CFSET Result_String = Replace(Result_String, chr(191) & "t", "- ", "ALL")>

<!--- Replace inverted question mark with hyphen and spaces --->
<CFSET Result_String = Replace(Result_String, chr(191), " - ", "ALL")>



