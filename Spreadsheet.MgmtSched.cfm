<cfinclude template="MfaCookieCheck.cfm">


<html>




<CFIF IsDefined("RptDate")>
	<CFSET RptDateToFmt = RptDate>
<CFELSE>
	<CFSET RptDateToFmt = ThisReportDate>
</CFIF>


<CFINCLUDE TEMPLATE="RptDateFYQFmt.cfm">



<CFSET SpreadsheetTitle = "CONFIDENTIAL Contingent Liabilities Report, ">

<CFSET SpreadsheetTitle = SpreadsheetTitle & "Management Schedule Updates Spreadsheet, ">

<CFSET SpreadsheetTitle = SpreadsheetTitle & RptDateFmtString>



<head>

<title>

Contingent Liabilities 

<CFOUTPUT>

FY #RptDateToFmt_FY# Q#RptDateToFmt_FYQuarter#: 

</CFOUTPUT>


Management Schedule Spreadsheet Updates

</title>

</head>


<!---

For production, must comment out hard-coded value for date_report in WHERE clause 

--->

<CFQUERY NAME="Get_MgmtSched_Cases" DATASOURCE="lddb">

/*

Liabilities only
Probable, Most Likely Payout (lower end) 10+ million

*/


  select 

  '' AS "Fiscal Service ref key",
    
  CASE_NUMBER AS "Entity ref key",
  
  CASE_NAME AS "Name or type of case",
  
  '' AS "Description of Contingency",
  
  'Legal' AS "Type of Contingency",
  
  
  case 
  
  when AMOUNT_SOUGHT IS NULL
  then '[Unknown]'
  
  else to_char((AMOUNT_SOUGHT / 1000), '999G999G999G999') 
  
  end "Amount claimed (1000s)",


  case ASSESSMENT_PROBABILITY 
  when 1 then 'P - Probable'

  end "Likelihood of loss",


  to_char((ASSESSMENT_AMOUNT / 1000), '999G999G999G999') AS "Potent Loss (a) P (1000s)",

  
  '' AS "(b) RP",
  

  to_char((ASSESSMENT_AMOUNT_UPPER / 1000), '999G999G999G999') AS "Potent Loss (c) Upper (1000s)",


  '' AS "(d) Unknown",

  'Yes - Interim LRL' AS "Is assessment of case(s) . . .",

  'N/A' AS "Brief description . . .",


  to_char((ASSESSMENT_AMOUNT / 1000), '999G999G999G999') AS "Amt on Balance Sheet (1000s)",


  '11' AS "Note disclosure",
  
  'Yes' AS "For amounts in col 11 . . .",
  
  '' AS "Provide an explanation . . .",
  
  'No updates since interim' AS "If updates were provided . . .",

  '' AS "Brief description . . .",
  
  '' AS "If the lead counsel . . .",
  
  '' AS "Provide an explanation . . ."




from contingent_liab_report 

where 

/*
date_report = to_date('12/31/2019', 'mm/dd/yyyy')
*/


date_report = to_date('#RptDateToFmt#', 'mm/dd/yyyy')



and
CONCUR_MC = 1

and
FINALIZED_FLAG = 1

and
DELETED_FLAG IS NULL


and
CASE_TYPE IN (1, 11)


AND
ASSESSMENT_PROBABILITY = 1


and
ASSESSMENT_AMOUNT >= #TenMillion#




order by upper(CASE_NAME), CASE_NUMBER



</CFQUERY>



<cfset theSheet = SpreadsheetNew("CLReport")>


<CFIF IsDefined("SpreadsheetTitle")>

	<cfset SpreadsheetSetHeader(theSheet, "", SpreadsheetTitle, "")>

</CFIF>


<cfset SpreadsheetSetFooter(theSheet, "", DateFormat(todayDate, "m/d/yyyy"), "")>



<!---
<CFSET CFFILE_MgmtSched_Destination_Dir = "D:\Inetpub\wwwroot\ClientService\ContingentLiabilities\Spreadsheets\FY" & RptDateToFmt_FY & "_Q" & RptDateToFmt_FYQuarter & "\">
--->

<!---
K:\web\inetpub\wwwroot2\ClientService\ContingentLiabilities\V1.0
K:\web\inetpub\wwwroot2\ClientService\DocUploadsFromCF2018\Doc.ContingentLiabilities\Spreadsheets\FY
--->




<!---

D:\web\inetpub\wwwroot2\ClientService\DocUploadsFromCF2018\Doc.ContingentLiabilities\Spreadsheets\

<CFSET CFFILE_MgmtSched_Destination_Dir = "D:\web\inetpub\wwwroot2\ClientService\DocUploadsFromCF2018\Doc.ContingentLiabilities\Spreadsheets\FY" & RptDateToFmt_FY & "_Q" & RptDateToFmt_FYQuarter & "\">
--->



<CFSET CFFILE_MgmtSched_Destination_Dir = Spreadsheets_Uploads_Dir & "FY" & RptDateToFmt_FY & "_Q" & RptDateToFmt_FYQuarter & "\">






<CFIF NOT DirectoryExists(CFFILE_MgmtSched_Destination_Dir)>
	<cfdirectory action = "create" directory = "#CFFILE_MgmtSched_Destination_Dir#">
</CFIF>



<!---
<CFSET CFFILE_MgmtSched_Uploads_Dir_Link = "../../Spreadsheets/FY" & RptDateToFmt_FY & "_Q" & RptDateToFmt_FYQuarter & "/">
--->



<CFSET CFFILE_MgmtSched_Uploads_Dir_Link = "/ClientService/DocUploadsFromCF2018/Doc.ContingentLiabilities/Spreadsheets/FY" & RptDateToFmt_FY & "_Q" & RptDateToFmt_FYQuarter & "/">





    
<cfset SpreadsheetFileName = "CLReport.MgmtSched.FY" & RptDateToFmt_FY & "_Q" & RptDateToFmt_FYQuarter & "_">

<CFSET theFile_Name_Date = DateFormat(todayDate, "yyyymmdd") & LSTimeFormat(Now(), "HHmmss")>

<cfset SpreadsheetFileName = SpreadsheetFileName & theFile_Name_Date & ".xls">

<cfset theFile = CFFILE_MgmtSched_Destination_Dir & SpreadsheetFileName>








<cfspreadsheet action="write" filename="#theFile#" query="Get_MgmtSched_Cases" overwrite=true>





<!---
<CFOUTPUT>

<p>
Spreadsheet #SpreadsheetFileName# has been saved.
<p>

Open <a href="#CFFILE_MgmtSched_Uploads_Dir_Link##SpreadsheetFileName#">spreadsheet</a>

</CFOUTPUT>
--->


<script>


<CFOUTPUT>

newSpreadsheetWindow = window.open("#CFFILE_MgmtSched_Uploads_Dir_Link##SpreadsheetFileName#", "newSpreadsheetWindow", "location=yes,scrollbars=yes,toolbar=yes,menubar=yes,resizable=yes");

</CFOUTPUT>


history.back();


</script>




</html>


