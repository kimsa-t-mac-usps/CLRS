
<cfset Init_User_Id = TRIM(UCASE(RemoveChars(auth_user,1,find('\',auth_user))))>
Init_User_Id variable equals: <cfoutput>"#Init_User_Id#"</cfoutput> <br>

<h3>Server:  Eagnmnwep1432<//h3><br>
<CFDUMP VAR="#CGI#">

