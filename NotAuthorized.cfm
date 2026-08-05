<cfinclude template="MfaCookieCheck.cfm">
<cflog text="NotAuthorized.cfm HIT: SERVER_NAME=#cgi.SERVER_NAME# | HTTP_HOST=#cgi.HTTP_HOST# | RespondingUser_Id=#IIF(IsDefined('RespondingUser_Id'),DE(RespondingUser_Id),DE('UNDEF'))# | Init_User_Id=#IIF(IsDefined('Init_User_Id'),DE(Init_User_Id),DE('UNDEF'))#" type="error" file="clrs-ldap">

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
<title>Not Authorized</title>

<style>
body {font-family:arial,sans-serif;font-size:10pt}
</style>

</head>

<body>

<h2>
<small>U.S. Postal Service Law Department 
<br>
Contingent Liabilities
</small>
<p>
Sorry!
</h2>

The system has found <b>no Contingent Liabilities cases</b> for which you are responsible.
<p>
You are not currently authorized to view the case records.

<!-- DEBUG: SERVER_NAME=<cfoutput>#cgi.SERVER_NAME#</cfoutput> | HTTP_HOST=<cfoutput>#cgi.HTTP_HOST#</cfoutput> | RespondingUser_Id=<cfoutput>#IIF(IsDefined('RespondingUser_Id'),DE(RespondingUser_Id),DE('UNDEF'))#</cfoutput> | AuthorizedFlag=<cfoutput>#IIF(IsDefined('AuthorizedFlag'),DE(AuthorizedFlag),DE('UNDEF'))#</cfoutput> | Check_Auth_User_A_RC=<cfoutput>#IIF(IsDefined('Check_Auth_User_A'),DE(Check_Auth_User_A.RecordCount),DE('UNDEF'))#</cfoutput> | Init_Check_Auth_User_A_RC=<cfoutput>#IIF(IsDefined('Init_Check_Auth_User_A'),DE(Init_Check_Auth_User_A.RecordCount),DE('UNDEF'))#</cfoutput> | Sit_Server_List=<cfoutput>#IIF(IsDefined('Sit_Server_List'),DE(Sit_Server_List),DE('UNDEF'))#</cfoutput> -->

</body>
</html>




