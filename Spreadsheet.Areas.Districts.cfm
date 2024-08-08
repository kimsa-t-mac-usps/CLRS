<cfinclude template="MfaCookieCheck.cfm">


<CFIF IsDefined("RptDate")>
	<CFSET RptDateToFmt = RptDate>
<CFELSE>
	<CFSET RptDateToFmt = ThisReportDate>
</CFIF>

<!---
<CFINCLUDE TEMPLATE="CFINCLUDEs/RptDateFYQFmt.cfm">
--->


<CFINCLUDE TEMPLATE="RptDateFYQFmt.cfm">



<CFSET SpreadsheetTitle = "CONFIDENTIAL Contingent Liabilities Report, ">

<CFSET SpreadsheetTitle = SpreadsheetTitle & RptDateFmtString & ": ">

<CFIF IsDefined("RptScope") AND RptScope EQ "Districts">

	<CFSET SpreadsheetTitle = SpreadsheetTitle & "Areas / Districts and HQ">
    
<CFELSE>

	<CFSET SpreadsheetTitle = SpreadsheetTitle & "Areas and HQ">

</CFIF>



<!---
<CFSET SpreadsheetTitle = SpreadsheetTitle & " " & RptDateToFmt>
--->

<head>
<title>
<CFOUTPUT>
#SpreadsheetTitle#
</CFOUTPUT>
</title>
</head>





<CFQUERY NAME="Get_Areas_Data" DATASOURCE="contliab">

select AREA_NAME, 

<CFIF IsDefined("RptScope") AND RptScope EQ "Districts">
DIST_PERF_CLUSTER_NAME, 
</cfif>

ASSESSMENT_PROBABILITY, CLAIM_CATEGORY, sum(ASSESSMENT_AMOUNT) AS LIKELY_LOW, sum(ASSESSMENT_AMT_HIGH_END) AS LIKELY_HIGH, sum(ASSESSMENT_AMOUNT) + sum(ASSESSMENT_AMT_HIGH_END - ASSESSMENT_AMOUNT) AS LIKELY_SUM, sum(ASSESSMENT_AMOUNT_UPPER) AS MAX_LOW, sum(ASSESSMENT_AMT_UPPER_HIGH_END)  AS MAX_HIGH, sum(ASSESSMENT_AMOUNT_UPPER) + sum(ASSESSMENT_AMT_UPPER_HIGH_END - ASSESSMENT_AMOUNT_UPPER) AS MAX_SUM


from contingent_liab_report 

where 

<!---
date_report = to_date('6/30/2011', 'mm/dd/yyyy')
--->

date_report = to_date('#RptDateToFmt#', 'mm/dd/yyyy')

and
CONCUR_MC = 1

and
FINALIZED_FLAG = 1

and
DELETED_FLAG IS NULL

and
(
CASE_TYPE = 1
or
CASE_TYPE = 11
)


and

(

(
ASSESSMENT_AMOUNT IS NOT NULL
and
ASSESSMENT_AMOUNT != 0
and
(
ASSESSMENT_AMT_HIGH_END IS NULL
or
ASSESSMENT_AMT_HIGH_END = 0
)
)

or

(
ASSESSMENT_AMT_HIGH_END IS NOT NULL
and
ASSESSMENT_AMT_HIGH_END != 0
)

)


and not
(
ASSESSMENT_AMOUNT is null
and
ASSESSMENT_AMT_HIGH_END IS NULL
)



and

(

(
ASSESSMENT_AMOUNT_UPPER IS NOT NULL
and
ASSESSMENT_AMOUNT_UPPER != 0
and
(
ASSESSMENT_AMT_UPPER_HIGH_END IS NULL
or
ASSESSMENT_AMT_UPPER_HIGH_END = 0
)
)

or

(
ASSESSMENT_AMT_UPPER_HIGH_END IS NOT NULL
and
ASSESSMENT_AMT_UPPER_HIGH_END != 0
)

)


and not
(
ASSESSMENT_AMOUNT_UPPER is null
and
ASSESSMENT_AMT_UPPER_HIGH_END IS NULL
)


group by area_name, 

<CFIF IsDefined("RptScope") AND RptScope EQ "Districts">
DIST_PERF_CLUSTER_NAME, 
</cfif>

ASSESSMENT_PROBABILITY, CLAIM_CATEGORY


order by area_name, 

<CFIF IsDefined("RptScope") AND RptScope EQ "Districts">
DIST_PERF_CLUSTER_NAME, 
</cfif>

ASSESSMENT_PROBABILITY, CLAIM_CATEGORY


</cfquery>



<!---
<CFOUTPUT>
Recip_List.RecordCount = #Recip_List.RecordCount#
<p></p>
Recip_List.PRIMARYKEY = #Recip_List.PRIMARYKEY#
<p></p>
Recip_List.CLIENT_LASTNAME = "#Recip_List.CLIENT_LASTNAME#"
<p></p>
Recip_List.CLIENT_FIRSTNAME = "#Recip_List.CLIENT_FIRSTNAME#"
<p></p>
Recip_List.CLIENT_INITIALS = "#Recip_List.CLIENT_INITIALS#"
<p></p>


</CFOUTPUT>
--->

<!---
<CFOUTPUT>
<p></p>
Recip_List.RecordCount = #Recip_List.RecordCount#
</cfoutput>
--->


<!---
<CFOUTPUT>
Recip_List.ColumnList = #Recip_List.ColumnList#
</cfoutput>

<cfabort>
--->







<CFSET theFile_Name_Date = DateFormat(todayDate, "yyyymmdd") & LSTimeFormat(Now(), "HHmmss")>

<!---
<CFSET Spreadsheet_Destination_Dir = Spreadsheets_Uploads_Dir & MatterNumber & "\" & "Spreadsheet\">
--->

<!---
<cfset theFile = GetDirectoryFromPath(GetCurrentTemplatePath()) & "LitHoldReport.MK." & Spreadsheet_MK & "." & theFile_Name_Date & ".xls">
--->


<!---
<CFOUTPUT>
Spreadsheet_Destination_Dir = "#Spreadsheet_Destination_Dir#"<br />
GetDirectoryFromPath(GetCurrentTemplatePath()) = "#GetDirectoryFromPath(GetCurrentTemplatePath())#"
</CFOUTPUT>

<cfabort>
--->


<!---
<CFIF NOT DirectoryExists(Spreadsheet_Destination_Dir)>
	<cfdirectory action = "create" directory = "#Spreadsheet_Destination_Dir#">
</CFIF>
--->


<!---
<cfset theFile = Spreadsheet_Destination_Dir & "LitHoldReport.MK." & Spreadsheet_MK & "." & theFile_Name_Date & ".xls">
--->


<cfset SpreadsheetFileName = "CLReport."> 


<CFIF IsDefined("RptScope") AND RptScope EQ "Districts">

	<cfset SpreadsheetFileName = SpreadsheetFileName & "Districts.">
    
<CFELSE>

	<cfset SpreadsheetFileName = SpreadsheetFileName & "Areas.">
    
</cfif>


<cfset SpreadsheetFileName = SpreadsheetFileName & theFile_Name_Date & ".xls">




<cfset theFile = Spreadsheets_Uploads_Dir & SpreadsheetFileName>



<cfset theSheet = SpreadsheetNew("CLReport")>

<!---
<cfset pageSetup = theSheet.getPrintSetup() />
<cfset pageSetup.setLandscape(true) />
--->




<cfset CreateObject( "java", "java.lang.StringBuffer" ).Init() />






 
<!---
<cfset SpreadsheetAddRow(theSheet,"LASTNAME,FIRSTNAME,INITIALS,DATE SENT,JOBTITLE,LOCATION,FACILITY_STREET,PRIMARYKEY")>
--->

<!---
<cfset SpreadsheetFormatRow(theSheet,"bold","1")>
--->


<!---
<cfscript> 
format1 = SructNew();
    format1.font="Courier"; 
    format1.fontsize="10"; 
    format1.color="dark_blue;"; 
    format1.italic="true"; 
    format1.bold="true"; 
    format1.alignment="left"; 
    format1.textwrap="true"; 
    format1.fgcolor="pale_blue"; 
    format1.bottomborder="thick"; 
    format1.bottombordercolor="blue_grey"; 
    format1.topbordercolor="blue_grey"; 
    format1.topborder="thick"; 
    format1.leftborder="dotted"; 
    format1.leftbordercolor="blue_grey"; 
    format1.rightborder="dotted"; 
    format1.rightbordercolor="blue_grey"; 
    SpreadsheetFormatRow(theSheet,format1,"1"); 
</cfscript> 
--->



<CFSET HeaderRowColHeads = "AREA,">


<CFIF IsDefined("RptScope") AND RptScope EQ "Districts">

	<CFSET HeaderRowColHeads = HeaderRowColHeads & "DISTRICT / PC,">
    
</cfif>


<CFSET HeaderRowColHeads = HeaderRowColHeads & "PROBABILITY,CATEGORY,MOST LIKELY PAYOUT,MAX REASONABLE PAYOUT">


<cfset SpreadsheetAddRow(theSheet, HeaderRowColHeads)>



<!---
<cfset SpreadsheetFormatRow(theSheet, {bold=TRUE, alignment="center"}, 1)>

<cfset SpreadsheetFormatRow(theSheet, {bold=TRUE, alignment="left"}, 1)>
--->


<cfset ThisRow = 1>


<CFLOOP QUERY="Get_Areas_Data">


<cfset ColCt = 1>


<CFIF AREA_NAME EQ "">

	<cfset SpreadsheetAddColumn(theSheet, "Multiple Areas", Get_Areas_Data.CurrentRow+1, ColCt, false)>

<CFELSE>

	<cfset SpreadsheetAddColumn(theSheet, Get_Areas_Data.AREA_NAME, Get_Areas_Data.CurrentRow+1, ColCt, false)>

</CFIF>


<CFIF IsDefined("RptScope") AND RptScope EQ "Districts">
	<cfset ColCt = ColCt + 1>
	<cfset SpreadsheetAddColumn(theSheet, Get_Areas_Data.DIST_PERF_CLUSTER_NAME, Get_Areas_Data.CurrentRow+1, ColCt, false)>
</cfif>


<cfset ColCt = ColCt + 1>


<CFSWITCH EXPRESSION="#ASSESSMENT_PROBABILITY#">

	<CFCASE VALUE="1">
    	<CFSET This_ASSESSMENT_PROBABILITY = "Probable">
    </CFCASE>

	<CFCASE VALUE="2">
      	<CFSET This_ASSESSMENT_PROBABILITY = "Reasonably Possible">
    </CFCASE>

	<CFCASE VALUE="3">
    	<CFSET This_ASSESSMENT_PROBABILITY = "Remote">
    </CFCASE>

</CFSWITCH>


<cfset SpreadsheetAddColumn(theSheet, This_ASSESSMENT_PROBABILITY, Get_Areas_Data.CurrentRow+1, ColCt, false)>


<cfset ColCt = ColCt + 1>



<CFSWITCH EXPRESSION="#CLAIM_CATEGORY#">

	<CFCASE VALUE="1">
    	<CFSET This_CLAIM_CATEGORY = "Business">
    </CFCASE>

	<CFCASE VALUE="2">
    	<CFSET This_CLAIM_CATEGORY = "Labor">
    </CFCASE>

	<CFCASE VALUE="3">
    	<CFSET This_CLAIM_CATEGORY = "Tort">
    </CFCASE>

</CFSWITCH>


<cfset SpreadsheetAddColumn(theSheet, This_CLAIM_CATEGORY, Get_Areas_Data.CurrentRow+1, ColCt, false)>



<cfset ColCt = ColCt + 1>


<CFIF LIKELY_SUM EQ "">

<!---
	<CFSET This_MostLikely = NumberFormat(LIKELY_LOW)>
--->

	<CFSET This_MostLikely = LIKELY_LOW>

<CFELSE>

<!---
	<CFSET This_MostLikely = NumberFormat(LIKELY_SUM)>
--->

	<CFSET This_MostLikely = LIKELY_SUM>

</cfif>



<!---
<cfset format = structnew()> 
<cfset format.dataformat = "$##,####0"> 
--->

<!---
<cfset spreadsheetaddrow(a,"1,2,3,4",2,1)> 
<cfset spreadsheetformatrow(a,format,2)> 
--->


<!---
<cfset NextColCt = ColCt + 1>
<cfset SpreadsheetFormatColumn(theSheet, {dataformat="##,######"}, "#ColCt#, #NextColCt#")>
--->





<!---
<cfset SpreadsheetFormatColumn(theSheet, {dataformat="0,000"}, ColCt)>
--->

<!---
<cfset SpreadsheetAddColumn(theSheet, NumberFormat(This_MostLikely), Get_Areas_Data.CurrentRow+1, ColCt, false)>

<cfset SpreadsheetFormatCell(theSheet, {dataformat="0,000"}, Get_Areas_Data.CurrentRow+1, ColCt)>
--->



<cfset SpreadsheetAddColumn(theSheet, This_MostLikely, Get_Areas_Data.CurrentRow+1, ColCt, false)>

<cfset SpreadsheetFormatCell(theSheet, {dataformat="0,000"}, Get_Areas_Data.CurrentRow+1, ColCt)>




<!---
<cfset SpreadsheetFormatColumn(theSheet, {dataformat="##,######"}, #ColCt#)>

<cfset SpreadsheetFormatColumn(theSheet, {dataformat="##,######"}, ColCt)>
--->

<!---
<cfset Spreadsheetformatcell(theSheet, {dataformat="#,##0"}, Get_Areas_Data.CurrentRow+1, ColCt, false)>
--->



<cfset ColCt = ColCt + 1>

<CFIF MAX_SUM EQ "">

<!---
	<CFSET This_MaxReasonable = NumberFormat(MAX_LOW)>
--->

	<CFSET This_MaxReasonable = MAX_LOW>
    
<CFELSE>

<!---
	<CFSET This_MaxReasonable = NumberFormat(MAX_SUM)>
--->

	<CFSET This_MaxReasonable = MAX_SUM>
    
</cfif>

<!---
<cfset SpreadsheetFormatColumn(theSheet, {dataformat="##,######"}, Get_Areas_Data.CurrentRow+1)>
--->

<cfset SpreadsheetAddColumn(theSheet, This_MaxReasonable, Get_Areas_Data.CurrentRow+1, ColCt, false)>

<cfset SpreadsheetFormatCell(theSheet, {dataformat="0,000"}, Get_Areas_Data.CurrentRow+1, ColCt)>

<!---
<cfset PrevColCt = ColCt - 1>
<cfset SpreadsheetFormatColumns(theSheet, {dataformat="##,######"}, "#PrevColCt#, #ColCt#")>
--->


</cfloop>


<!---
<cfset spreadsheetSetHeader(SpreadsheetObj,"left header","center header","right header")>
--->

<CFIF IsDefined("SpreadsheetTitle")>

	<cfset SpreadsheetSetHeader(theSheet, "", SpreadsheetTitle, "")>

</CFIF>


<cfset SpreadsheetSetFooter(theSheet, "", DateFormat(todayDate, "m/d/yyyy"), "")>


  
<!--- Write the spreadsheet to a file, replacing any existing file. ---> 
<cfspreadsheet action="write" filename="#theFile#" name="theSheet"  
    sheet=1 overwrite=true>


<!---
<CFSET Spreadsheet_Uploads_Dir_Link = Spreadsheets_Uploads_Dir_URL>
--->


    
<script>
<!---
history.back();
location.reload();
--->

<CFOUTPUT>

<!---
location.href="Report.cfm?MK=#Spreadsheet_MK#"
--->

<!---
location.href="#theFile#"
--->





<!---
setTimeout("location.href='#Spreadsheet_Uploads_Dir_Link##SpreadsheetFileName#'; window.close()", 1500);
--->


<!---
newSpreadsheetWindow = window.open("#Spreadsheet_Uploads_Dir_Link##SpreadsheetFileName#", "newSpreadsheetWindow", "location=yes,scrollbars=yes,toolbar=yes,menubar=yes,resizable=yes");
--->



<!---
document.title = "#SpHeader#";
--->

<!--- If this page has loaded in new window (from href with target), avoid location.href to XLS file for IE 7, because new browser window (blank) stays open after Excel window opens:
location.href="#Spreadsheet_Uploads_Dir_Link##SpreadsheetFileName#";
--->

<!---
location.href="Report.cfm?MK=#Spreadsheet_MK#"
--->

newSpreadsheetWindow = window.open("#Spreadsheets_Uploads_Dir_URL##SpreadsheetFileName#", "newSpreadsheetWindow", "location=yes,scrollbars=yes,toolbar=yes,menubar=yes,resizable=yes");

history.back();


</CFOUTPUT>

</script>








