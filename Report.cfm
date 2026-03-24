<cfinclude template="MfaCookieCheck.cfm">

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
<title>Report Redirect</title>

<script language="javascript">

function checkSearch() {

thisURL = document.URL;

thisURLHash = thisURL.indexOf("#");

if (thisURLHash >= 0) thisHash = thisURL.substring(thisURLHash);
else thisHash = "";

if (location.search) searchString = location.search;
else searchString = "";

/*
GAC - 06/19/2013 - Changed redirect from
location.href = "https://#This_Server#/InHouse/ContingentLiabilities/#ServerFolder#Report.full.cfm" + searchString + thisHash;
to:

*/
<cfoutput>
location.href = "#This_Server_Base_URL#/ClientService/ContingentLiabilities/#ServerFolder#Report.full.cfm" + searchString + thisHash;
</cfoutput>

}
</script>


</head>


<body onLoad="checkSearch()">

</body>
</html>



