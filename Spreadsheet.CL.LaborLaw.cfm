<cfinclude template="MfaCookieCheck.cfm">



<CFIF IsDefined("RptDate")>
	<CFSET RptDateToFmt = RptDate>

<!---
<CFOUTPUT>
In Spreadsheet.CL.cfm at 8:
<br />
RptDate = "#RptDate#"
</CFOUTPUT>
--->


<CFELSE>
	<CFSET RptDateToFmt = ThisReportDate>

<!---
<CFOUTPUT>
In Spreadsheet.CL.cfm at 20:
<br />
ThisReportDate = "#ThisReportDate#"
</CFOUTPUT>
--->

</CFIF>

<!---
<CFOUTPUT>
In Spreadsheet.CL.cfm at 31:
<br />
RptDateToFmt = "#RptDateToFmt#"



</CFOUTPUT>

<cfabort>
--->



<!---
<CFINCLUDE TEMPLATE="CFINCLUDEs/RptDateFYQFmt.cfm">
--->


<CFINCLUDE TEMPLATE="RptDateFYQFmt.cfm">


<CFSET SpreadsheetTitle = "CONFIDENTIAL Contingent Liabilities Report, ">

<CFSET SpreadsheetTitle = SpreadsheetTitle & RptDateFmtString & ", ">

<CFIF IsDefined("RptScope")>

	<CFIF RptScope EQ "Districts">
		<CFSET SpreadsheetTitle = SpreadsheetTitle & "Areas / Districts and HQ">
	<CFELSEIF RptScope EQ "Areas">
		<CFSET SpreadsheetTitle = SpreadsheetTitle & "Areas and HQ">


	<CFELSEIF RptScope EQ "Cases">

		<CFSET SpreadsheetTitle = SpreadsheetTitle & "Case List">




    </CFIF>
    
<CFELSE>

	<CFSET SpreadsheetTitle = SpreadsheetTitle & "Areas and HQ">

</CFIF>



<!---
<CFSET SpreadsheetTitle = SpreadsheetTitle & " " & RptDateToFmt>
---><head>
<title>
<CFOUTPUT>
#SpreadsheetTitle#
</CFOUTPUT>
</title>
</head>






<CFOUTPUT>



<!---
<CFQUERY NAME="Get_Spreadsheet_Data" DATASOURCE="ContLiab">
--->



<CFIF NOT IsDefined("RptScope")
OR
(
IsDefined("RptScope")
AND
(
RptScope EQ "Districts"
OR
RptScope EQ "Areas"
)
)>

	select AREA_NAME, 

	<CFIF IsDefined("RptScope") AND RptScope EQ "Districts">
		DIST_PERF_CLUSTER_NAME, 
	</cfif>

	ASSESSMENT_PROBABILITY, 
	CLAIM_CATEGORY, 

	sum(ASSESSMENT_AMOUNT) AS LIKELY_LOW, 
	sum(ASSESSMENT_AMOUNT) + sum(ASSESSMENT_AMT_HIGH_END - ASSESSMENT_AMOUNT) AS LIKELY_SUM,
    sum(ASSESSMENT_AMOUNT_UPPER) AS MAX_LOW, 
    sum(ASSESSMENT_AMT_UPPER_HIGH_END) AS MAX_HIGH, 
    sum(ASSESSMENT_AMOUNT_UPPER) + sum(ASSESSMENT_AMT_UPPER_HIGH_END - ASSESSMENT_AMOUNT_UPPER) AS MAX_SUM

<CFELSEIF RptScope EQ "Cases">

	select 
    
<!---    
    CASE_NAME,
--->
 
   
<!---    
	case
    when CASE_TYPE = 2 then INITCAP(CASE_NAME) || ' [Receivable]'
    else INITCAP(CASE_NAME)
    end "Case_Name",
--->    


<!--- Col 1 --->
	case
    when CASE_TYPE = 2 then CASE_NAME || ' [Receivable]'
    else CASE_NAME
    end "Case_Name",



    
<!--- Col 3 --->
    CASE_NUMBER AS "Case_Number",

<!---
	ASSESSMENT_PROBABILITY, 
--->


<!--- Col 6 --->
	CASE to_char(ASSESSMENT_PROBABILITY)
	when '1' then 'Probable'
	when '2' then 'Reasonably Possible'
	when '3' then 'Remote'
	END "Assessment_Probability",




<!---
    CASE_TYPE,
--->

	CASE to_char(CASE_TYPE)
	when '1' then 'Liability'
	when '2' then 'Receivable'
	END "Case_Type",


<!---
	CLAIM_CATEGORY, 
--->	

    
	CASE to_char(CLAIM_CATEGORY)
	when '1' then 'Business'
	when '2' then 'Labor'
	when '3' then 'Tort'
	END "Claim_Category",
    
    
    
<!---
    to_char(DATE_FILED, 'yyyy/mm/dd') AS DATE_FILED,
--->    
    
<!--- Col 2 --->
    case
    when DATE_FILED is NULL then '[Unknown]'
    else to_char(DATE_FILED, 'yyyy/mm/dd') 
    end "Date_Filed",
    
    
    
    
<!---    
    to_char(SHORT_TERM_LIABILITY) AS SHORT_TERM_LIABILITY,
	    
For Est Time to Resoln: 2=Less Than 1 Year, 100=1 - 5 Years, 200=Over 5 Years
--->


<!--- Col 10 --->
	CASE to_char(SHORT_TERM_LIABILITY)
	when '2' then 'Less Than 1 Year'
	when '100' then '1 - 5 Years'
	when '200' then 'Over 5 Years'
	END "Est_Time_to_Resoln",


<!---


	to_char(AMOUNT_SOUGHT, '999G999G999') AS AMOUNT_SOUGHT,
	
	to_number(AMOUNT_SOUGHT, '999G999') AS AMOUNT_SOUGHT,

	to_char(AMOUNT_SOUGHT, '999,999,999.99') AS AMOUNT_SOUGHT,

	trim(to_char(AMOUNT_SOUGHT, '999G999G999')) AS AMOUNT_SOUGHT,	
--->

<!---
    AMOUNT_SOUGHT,
--->



<!---
	to_char(AMOUNT_SOUGHT, '999,999,999') AS AMOUNT_SOUGHT,
--->


<!--- Col 7 --->
	case

    when 
    AMOUNT_SOUGHT is null 
    and
    AMOUNT_SOUGHT_UNKNOWN = 1
    then '[Unknown]'
    
	else to_char(AMOUNT_SOUGHT, '999,999,999')

	end "Amount_Sought",






<!---


	to_char(ASSESSMENT_AMOUNT, '999G999G999') AS ASSESSMENT_AMOUNT,
	
	to_number(ASSESSMENT_AMOUNT, '999G999') AS ASSESSMENT_AMOUNT,

	trim(to_char(ASSESSMENT_AMOUNT, '999G999G999')) AS ASSESSMENT_AMOUNT,	

	to_char(ASSESSMENT_AMOUNT, '999,999,999.99') AS ASSESSMENT_AMOUNT,

--->

<!---
	ASSESSMENT_AMOUNT, 

	to_char(ASSESSMENT_AMOUNT, '999,999,999') AS ASSESSMENT_AMOUNT,

--->


<!--- Col 8 --->
	case

    when 
    ASSESSMENT_AMOUNT is null 
    and
    ASSESSMENT_AMT_UNKNOWN = 1
    then '[Unknown]'
    
	else to_char(ASSESSMENT_AMOUNT, '999,999,999')

	end "Most Likely Payout",
	




<!---
	ASSESSMENT_AMT_HIGH_END,
--->


	to_char(ASSESSMENT_AMT_HIGH_END, '999,999,999') AS "Most Likely Payout High End",




	(

    select
    
<!---    
    prev_clr.ASSESSMENT_AMOUNT AS "Prev_Most_Likely_Payout"
--->
    

    case when prev_clr.ASSESSMENT_AMOUNT is NULL then '[No previous report]'
    else to_char(prev_clr.ASSESSMENT_AMOUNT, '999,999,999') 
    end "Prev_Most_Likely_Payout"


	from 
    contingent_liab_report prev_clr
	
	where 
	prev_clr.date_report = to_date('#PrevReportDate#', 'mm/dd/yyyy')
	
	AND 
	prev_clr.CASE_REC_ID_SEQUENCE = clr.CASE_REC_ID_SEQUENCE
	
	and
	prev_clr.CONCUR_MC = 1
	
	and
	prev_clr.FINALIZED_FLAG = 1
	
	and
	prev_clr.DELETED_FLAG IS NULL
	
	) AS "Prev_Most_Likely_Payout",
    
    
    
<!---    
    ASSESSMENT_AMOUNT_UPPER, 
--->


<!--- Col 9 --->
	to_char(ASSESSMENT_AMOUNT_UPPER, '999,999,999') AS "Max Reasonable Payout",






<!---
    ASSESSMENT_AMT_UPPER_HIGH_END
--->


	to_char(ASSESSMENT_AMT_UPPER_HIGH_END, '999,999,999') AS "Max Reasonable Payout High End"
    
    
<!---    
    ,
    clr.CASE_REC_ID_SEQUENCE
--->
    

<CFIF IsDefined("OfficeScope")>

	,
    
    trim(ldo.OFFICE) AS OFFICE,
    
    ldo.OFFICE_PRM_KEY AS OFFICE_KEY


</CFIF>



</CFIF>



from contingent_liab_report clr



<CFIF IsDefined("OfficeScope")>

join 

(
LDOFFICES 

on
clr.LAW_DEPT_OFFICE = LDOFFICES.OFFICE_PRM_KEY

and
trim(LDOFFICES.OFFICE) = '#OfficeScope#'

) ldo


</CFIF>










where 

date_report = to_date('#RptDateToFmt#', 'mm/dd/yyyy')

and
CONCUR_MC = 1

and
FINALIZED_FLAG = 1

and
DELETED_FLAG IS NULL

and
(
<!---
CASE_TYPE = 1
or
CASE_TYPE = 11
--->

<!--- Added Receivables (CASE_TYPE = 2) --->
CASE_TYPE IN (1, 2, 11)

)





and not
(

ASSESSMENT_AMOUNT is null
and
(
ASSESSMENT_AMT_HIGH_END IS NULL
or
ASSESSMENT_AMT_HIGH_END != 0
)
and
(
ASSESSMENT_AMT_UNKNOWN IS NULL
or
ASSESSMENT_AMT_UNKNOWN = 0
)

and 
ASSESSMENT_AMOUNT_UPPER is null
and
(
ASSESSMENT_AMT_UPPER_HIGH_END IS NULL
or
ASSESSMENT_AMT_UPPER_HIGH_END != 0
)
and
(
ASSESSMENT_AMT_MAX_UNKNOWN IS NULL
or
ASSESSMENT_AMT_MAX_UNKNOWN = 0
)

)










AND

(

(


ASSESSMENT_PROBABILITY IN
(1,2)
and
(

(
ASSESSMENT_AMOUNT >= 1000000
or
ASSESSMENT_AMT_HIGH_END >= 1000000
or
ASSESSMENT_AMOUNT_UPPER >= 1000000
or
ASSESSMENT_AMT_UPPER_HIGH_END >= 1000000
)

or

(

(
ASSESSMENT_AMOUNT < 1000000
OR
ASSESSMENT_AMOUNT IS NULL
)

AND
(
ASSESSMENT_AMOUNT_UPPER >= 1000000
OR
(
ASSESSMENT_AMT_UPPER_HIGH_END IS NOT NULL
AND
ASSESSMENT_AMT_UPPER_HIGH_END >= 1000000
)
)

)



)









)

OR
(
ASSESSMENT_PROBABILITY = 3
and

(

(
ASSESSMENT_AMOUNT >= #TenMillion#
or
ASSESSMENT_AMT_HIGH_END >= #TenMillion#
or
ASSESSMENT_AMOUNT_UPPER >= #TenMillion#
or
ASSESSMENT_AMT_UPPER_HIGH_END >= #TenMillion#
)

or

(

(
ASSESSMENT_AMOUNT < 1000000
OR
ASSESSMENT_AMOUNT IS NULL
)

AND
(
ASSESSMENT_AMOUNT_UPPER >= 1000000
OR
(
ASSESSMENT_AMT_UPPER_HIGH_END IS NOT NULL
AND
ASSESSMENT_AMT_UPPER_HIGH_END >= 1000000
)
)

)


)

)
)


<CFIF NOT IsDefined("RptScope")
OR
(
IsDefined("RptScope")
AND
(
RptScope EQ "Districts"
OR
RptScope EQ "Areas"
)
)>

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


<CFELSEIF RptScope EQ "Cases">

	order by upper(CASE_NAME), CASE_NUMBER


</CFIF>


<!---
</cfquery>
--->



</CFOUTPUT>

<CFABORT>





<CFSET theFile_Name_Date = DateFormat(todayDate, "yyyymmdd") & LSTimeFormat(Now(), "HHmmss")>



<cfset SpreadsheetFileName = "CLReport."> 



<CFIF IsDefined("RptScope")>

	<CFIF RptScope EQ "Districts">
		<cfset SpreadsheetFileName = SpreadsheetFileName & "Districts.">
	<CFELSEIF RptScope EQ "Areas">
		<cfset SpreadsheetFileName = SpreadsheetFileName & "Areas.">
	<CFELSEIF RptScope EQ "Cases">
		<cfset SpreadsheetFileName = SpreadsheetFileName & "Cases.">
    </CFIF>
    
<CFELSE>

	<cfset SpreadsheetFileName = SpreadsheetFileName & "Areas.">

</CFIF>





<cfset SpreadsheetFileName = SpreadsheetFileName & "FY" & RptDateToFmt_FY & ".Q" & RptDateToFmt_FYQuarter>


<cfset SpreadsheetFileName = SpreadsheetFileName & "." & theFile_Name_Date & ".xls">



<!---
<cfset theFile = Spreadsheets_Uploads_Dir & SpreadsheetFileName>
--->



<!--- Initially set in application.cfm: --->

	<CFSET CFFILE_Spsheet_Uploads_Dir = "D:\web\inetpub\wwwroot2\ClientService\DocUploadsFromCF2018\Doc.ContingentLiabilities\Spreadsheets\FY" & RptDateToFmt_FY & "_Q" & RptDateToFmt_FYQuarter & "\">


	<CFSET CFFILE_Spsheet_Uploads_Dir_Link = "/ClientService/DocUploadsFromCF2018/Doc.ContingentLiabilities/Spreadsheets/FY" & RptDateToFmt_FY & "_Q" & RptDateToFmt_FYQuarter & "/">







<cfset theFile = CFFILE_Spsheet_Uploads_Dir & SpreadsheetFileName>


<!---
<CFOUTPUT>

<p>
theFile = "#theFile#"
<p>


</CFOUTPUT>



<cfabort>
--->





<!---
<CFSET SpreadsheetFormatCellRange(theSheet, {alignment="right"}, 3,4,30,10)>
--->





  
<!--- Write the spreadsheet to a file, replacing any existing file. ---> 
<!---
<cfspreadsheet action="write" filename="#theFile#" name="theSheet"  
    sheet=1 overwrite=true>
--->


<cfspreadsheet action="write" filename="#theFile#" query="Get_Spreadsheet_Data" overwrite=true>



    
<script>
<!---
history.back();
location.reload();
--->








<CFOUTPUT>

<!---
newSpreadsheetWindow = window.open("#Spreadsheets_Uploads_Dir_URL##SpreadsheetFileName#", "newSpreadsheetWindow", "location=yes,scrollbars=yes,toolbar=yes,menubar=yes,resizable=yes");
--->


newSpreadsheetWindow = window.open("#CFFILE_Spsheet_Uploads_Dir_Link##SpreadsheetFileName#", "newSpreadsheetWindow", "location=yes,scrollbars=yes,toolbar=yes,menubar=yes,resizable=yes");


history.back();


</CFOUTPUT>

</script>








