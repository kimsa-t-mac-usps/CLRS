<cfinclude template="MfaCookieCheck.cfm">

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
<title>Contingent Liabilities: Unavailable For New Cases</title>

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

The system is <b>temporarily unavailable for entering new cases</b> while the Current Report is being finalized.
<p>
If you need to enter a new case during this period, please contact 


<!---
<b>Maria Montalvo</b> or <b>Peggy McMahon</b>.
--->

<CFINCLUDE TEMPLATE="Query.Get_Bus_Serv_Contact.cfm">

<CFOUTPUT>

<a href="mailto:#Get_Bus_Serv_Contact_Trim_LONGEMAIL#?subject=New Contingent Liabilities Case"><b>#Get_Bus_Serv_Contact.Trim_FIRSTNAME# #Get_Bus_Serv_Contact.Trim_LASTNAME#</b></a>,

#Get_Bus_Serv_Contact.Trim_OFFICE#, 
#Get_Bus_Serv_Contact.Trim_VOICE#,

</CFOUTPUT>


or


<CFOUTPUT>

<a href="mailto:#Get_Bus_Serv_Mgr_Trim_LONGEMAIL#?subject=New Contingent Liabilities Case"><b>#Get_Bus_Serv_Mgr.Trim_FIRSTNAME# #Get_Bus_Serv_Mgr.Trim_LASTNAME#</b></a>,

#Get_Bus_Serv_Mgr.Trim_TITLE#, 
#Get_Bus_Serv_Mgr.Trim_VOICE#.

</CFOUTPUT>


</body>
</html>



