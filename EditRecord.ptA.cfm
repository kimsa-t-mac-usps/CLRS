<cfinclude template="MfaCookieCheck.cfm">



<!--- Deleted Query GetMC as duplicate with application.cfm --->

<!---
<CFQUERY NAME="GetMC" DATASOURCE="lddb">

SELECT LDEXTRA.PRIMARYKEY

FROM LAWDEPARTMENT, LDEXTRA

WHERE LDEXTRA.PRIMARYKEY = LAWDEPARTMENT.PRIMARYKEY

AND TITLE LIKE 'Managing Counsel%'

AND (UPPER(AD_USERID) LIKE UPPER('#RespondingUser_Id#%')
OR UPPER(AD_MAILNICKNAME) LIKE UPPER('#RespondingUser_Id#%'))

</cfquery>
--->

<!---
<cfoutput>
--->


<CFQUERY NAME="CONTINGENT_LIAB_GetRecord" DATASOURCE="lddb">





SELECT

PRIMARYKEY,
CASE_NAME,
CASE_NUMBER,

LM_MATTER_NUMBER,
LM_MATTER_KEY,

CASE_TYPE,
CLAIM_CATEGORY,
DATE_FILED,
DATE_FILED_UNKNOWN,
AMOUNT_SOUGHT,
AMOUNT_SOUGHT_UPPER,
AMOUNT_SOUGHT_UNKNOWN,
ASSESSMENT_PROBABILITY,

ASSESSMENT_AMOUNT,
ASSESSMENT_AMT_HIGH_END,

ASSESSMENT_AMOUNT_UPPER,
ASSESSMENT_AMT_UPPER_HIGH_END,

ASSESSMENT_AMT_UNKNOWN,
ASSESSMENT_AMT_MAX_UNKNOWN,

STATUS,
STATUS_CODE,

STATUS_CODE_SELECTED,

SHORT_TERM_LIABILITY,
COUNSEL_LAW_DEPT,
COCOUNSEL_LAW_DEPT,
COUNSEL_OTHER,
LAW_DEPT_OFFICE,
ALT_LAW_DEPT_OFFICE,
FACTS_POSITIONS_LONG,
DATE_LAST_UPDATE,
LAST_UPDATE_USER_ID,
DATE_REPORT,
COMMENT_GENERAL,
FINALIZED_FLAG,
CONCUR_MC,

PAYOUT_AMOUNT,
PAYOUT_LT_100K,

PAYOUT_DATE,
PAYOUT_DATE_NA,

AREA_NAME,
AREA_CODE,
DIST_PERF_CLUSTER_NAME,
DIST_PERF_CLUSTER_CODE,

DIVISION_CODE,

UNIONS_SELECTED,


FIELD_GRIEVANCE_FLAG,
NATL_GATS_NUMBER,

CASE_REC_ID_SEQUENCE


FROM CONTINGENT_LIAB_REPORT

WHERE
DATE_REPORT = to_date('#DateFormat(ThisReportDate, "mm/dd/yyyy")#', 'mm/dd/yyyy')


AND
DELETED_FLAG IS NULL


<CFIF Check_Auth_User_A.RecordCount EQ 1 AND IsDefined("ThisRecID") AND ThisRecID NEQ "">

AND PRIMARYKEY = #ThisRecID#

<CFELSEIF IsDefined("Get_Auth_User_Office.RecordCount") AND Get_Auth_User_Office.RecordCount EQ 1 AND IsDefined("Get_Auth_User_Office.OFFICE_PRM_KEY")>

<!---
<CFIF Get_Auth_User_Office.OFFICE_PRM_KEY EQ 22 OR Get_Auth_User_Office.OFFICE_PRM_KEY EQ 23>
AND LAW_DEPT_OFFICE IN (1, #Get_Auth_User_Office.OFFICE_PRM_KEY#)

<CFELSE>
AND LAW_DEPT_OFFICE = #Get_Auth_User_Office.OFFICE_PRM_KEY#

</cfif>
--->


<!---
<CFINCLUDE TEMPLATE="SQL.CheckForOfficeOverlap.cfm">
--->



	AND 
    (
    LAW_DEPT_OFFICE = #Get_Auth_User_Office.OFFICE_PRM_KEY#
	OR
    ALT_LAW_DEPT_OFFICE = #Get_Auth_User_Office.OFFICE_PRM_KEY#
    )








<CFIF IsDefined("ThisCONTINGENT_LIAB_AUTH")>

<CFIF ThisCONTINGENT_LIAB_AUTH EQ "B">
AND CLAIM_CATEGORY = 1
<CFELSEIF ThisCONTINGENT_LIAB_AUTH EQ "T">
AND CLAIM_CATEGORY = 3
</cfif>

</cfif>

<CFIF IsDefined("ThisRecID") AND ThisRecID NEQ "">
AND PRIMARYKEY = #ThisRecID#
</cfif>

<CFELSEIF IsDefined("Get_Indiv_User.RecordCount") AND Get_Indiv_User.RecordCount EQ 1>

<CFIF Get_Indiv_User.OFFICE_PRM_KEY EQ 24>
AND (LAW_DEPT_OFFICE = #Get_Indiv_User.OFFICE_PRM_KEY#
OR ALT_LAW_DEPT_OFFICE = #Get_Indiv_User.OFFICE_PRM_KEY#)

<!--- DGC Field --->
<CFELSEIF Get_Indiv_User.OFFICE_PRM_KEY EQ 17>
AND LAW_DEPT_OFFICE = #Get_Indiv_User.OFFICE_PRM_KEY#


<CFELSE>
AND (COUNSEL_LAW_DEPT = #Get_Indiv_User.PRIMARYKEY#
OR COCOUNSEL_LAW_DEPT = #Get_Indiv_User.PRIMARYKEY#)
</cfif>

<CFIF IsDefined("ThisRecID") AND ThisRecID NEQ "">
AND PRIMARYKEY = #ThisRecID#
</cfif>

</cfif>


ORDER BY CASE_TYPE, ASSESSMENT_PROBABILITY, CLAIM_CATEGORY, CASE_NAME, CASE_NUMBER



</cfquery>


<!---
</cfoutput>

<cfabort>
--->


<!---
<CFOUTPUT>
<p>
CONTINGENT_LIAB_GetRecord.RecordCount = #CONTINGENT_LIAB_GetRecord.RecordCount#
<p>
</CFOUTPUT>


<cfabort>
--->


<!---
<script>

<cfoutput>

alert('EditRecord.ptA.cfm at 197: CONTINGENT_LIAB_GetRecord.RecordCount = #CONTINGENT_LIAB_GetRecord.RecordCount#');

</cfoutput>

</script>
--->





<CFIF CONTINGENT_LIAB_GetRecord.RecordCount NEQ 1>


	<CFIF IsDefined("RecIDParm")>

		<CFQUERY NAME="Get_Checklist_Responses" DATASOURCE="lddb">
		SELECT checklist.*
	
	    FROM 
    	CONTINGENT_LIAB_C_E_CHECKLIST checklist,
	    CONTINGENT_LIAB_REPORT report
    
		WHERE 
	    checklist.CASE_REC_ID_SEQUENCE = report.CASE_REC_ID_SEQUENCE 
    
	    and
    	report.primarykey = #RecIDParm#
    
	    </cfquery>


	<CFELSE>

<!--- Disallow Edit if >1 record:
--->


		<script language="javascript">
		location.href = "Report.cfm";
		</script>



	</CFIF>


<CFELSE>

	<CFQUERY NAME="Get_Checklist_Responses" DATASOURCE="lddb">
	SELECT *
	FROM CONTINGENT_LIAB_C_E_CHECKLIST
	WHERE CASE_REC_ID_SEQUENCE = #CONTINGENT_LIAB_GetRecord.CASE_REC_ID_SEQUENCE#
	</cfquery>

</cfif>


<h2>
<small><small>
<small>U.S. Postal Service Law Department
<br>
Contingent Liabilities and Receivables
</small></small>
<br>
DRAFT Report for


<CFSET RptDateToFmt = ThisReportDate>

<CFINCLUDE TEMPLATE="RptDateFYQFmt.cfm">

<CFOUTPUT>
#RptDateFmtString#
</cfoutput>


</small>
<p>





<!--- CFFILE_Destination_Dir and CFFILE_Uploads_Dir_Link defined in application.cfm --->
<!---
<CFSET CFFILE_Destination_Dir = "D:\Inetpub\wwwroot\InHouse\ContingentLiabilities\Spreadsheets\FY" & RptDateToFmt_FY & "_Q" & RptDateToFmt_FYQuarter & "\Cases\">

<CFSET CFFILE_Uploads_Dir_Link = "../Spreadsheets/FY" & RptDateToFmt_FY & "_Q" & RptDateToFmt_FYQuarter & "/Cases/">
--->








<!---
<CFOUTPUT>
CONTINGENT_LIAB_GetRecord.RecordCount = #CONTINGENT_LIAB_GetRecord.RecordCount#
<p>
</cfoutput>
--->

Edit

<CFIF IsDefined("Form.Operation") AND Form.Operation EQ "Updated">
<i style="color:maroon">Updated</i>

<CFELSEIF IsDefined("Form.Operation") AND Form.Operation EQ "Inserted">
<i style="color:maroon">New</i>

</cfif>

<CFIF CONTINGENT_LIAB_GetRecord.RecordCount EQ 1 AND CONTINGENT_LIAB_GetRecord.CASE_TYPE GT 10>
<i style="color:maroon">Removed</i>
</cfif>

Case

<CFIF CONTINGENT_LIAB_GetRecord.RecordCount EQ 1>
Record
<CFELSE>
Records
</cfif>

<CFIF IsDefined("OfficeScope") 
AND NOT 
(
(
IsDefined("Form.Operation") 
AND 
(
Form.Operation EQ "Updated" 
OR 
Form.Operation EQ "Inserted"
)
) 
OR 
IsDefined("RecIDParm")
)>

	<CFOUTPUT>
	for
	<br>
	#OfficeScope#
	</cfoutput>

	<CFIF IsDefined("ThisCONTINGENT_LIAB_AUTH")>

		<CFIF ThisCONTINGENT_LIAB_AUTH EQ "B">
			Business Claims
		<CFELSEIF ThisCONTINGENT_LIAB_AUTH EQ "T">
			Tort Claims
		</cfif>

	</cfif>

</cfif>

<!---
<span style="color:maroon; font-size:10pt">(Revised February 2009)</span>
--->

</h2>




<div style="position: absolute; top: 20; right: 60; background:FFD5AA; padding:5pt; text-align:left">


<CFIF IsDefined("RecordDisplay_Parm")>

	<b>&middot;&nbsp;<a href="" onClick="history.back(); return false">Back</a></b>

<CFELSEIF IsDefined("RecIDParm")>

	<CFOUTPUT>
	<b>&middot;&nbsp;<a href="Report.cfm#SelectedLDOffice_Parm####RecIDParm#">Current Report</a></b>
	</cfoutput>

<CFELSEIF IsDefined("ThisRecID")>

	<CFOUTPUT>
	<b>&middot;&nbsp;<a href="Report.cfm#SelectedLDOffice_Parm####ThisRecID#">Current Report</a></b>
	</cfoutput>

<CFELSE>

	<CFOUTPUT>
	<b>&middot;&nbsp;<a href="Report.cfm">Current Report</a></b>
	</cfoutput>

</cfif>


<!---
<CFINCLUDE TEMPLATE="CFINCLUDEs/areas.districts.arrays.cfm">
--->



<!--- For Report Date on or after 9/30/2011 (PostRedesignReportDate), use Redesign list of Areas, Districts: --->
<CFIF IsDefined("RptDate")>

	<CFSET ThisReportDateCompare = DateCompare(RptDate, PostRedesignReportDate)>

<CFELSE>

	<CFSET ThisReportDateCompare = DateCompare(ThisReportDate, PostRedesignReportDate)>

</CFIF>


<!---
<CFIF ThisReportDateCompare GE 0>

	<CFINCLUDE TEMPLATE="CFINCLUDEs/areas.districts.arrays.cfm">

<CFELSE>

	<CFINCLUDE TEMPLATE="CFINCLUDEs/areas.districts.arrays.20090617.cfm">

</CFIF>
--->



<CFIF NOT IsDefined("RecordDisplay_Parm")>
<p style="margin-top:6pt">
	<!---KS 1.9.24.	Page break issue  --->
<!---<b>&middot;&nbsp;<a href="InsertRecord.cfm">New Case for This Quarter</a></b>--->
</cfif>

</div>

<CFIF NOT 
(
(
IsDefined("Form.Operation") 
AND 
(
Form.Operation EQ "Updated" 
OR 
Form.Operation EQ "Inserted"
)
) 
OR 
IsDefined("RecIDParm")
)>

	<CFSET Old_CASE_TYPE_Label = "">
	<CFSET Old_ASSESSMENT_PROBABILITY_Label = "">
	<CFSET Old_CLAIM_CATEGORY_Label = "">

<!--- Moved to CFINCLUDEs\LabelLists.cfm:
<CFSET ASSESSMENT_PROBABILITY_Label_List = "A. Probable,B. Reasonably Possible,C. Remote">
<CFSET ASSESSMENT_PROBABILITY_Label_List_Len = ListLen(ASSESSMENT_PROBABILITY_Label_List)>

<CFSET CLAIM_CATEGORY_Label_List = "1. Business Claims,2. Labor Claims,3. Tort Claims">
<CFSET CLAIM_CATEGORY_Label_List_Len = ListLen(CLAIM_CATEGORY_Label_List)>
--->


	<div id="TopIndex" style="font-size:8pt; border:thin solid green; padding:5pt">
	
	<div style="font-weight:bold; letter-spacing:10pt; text-align:center; color:green">INDEX</div>
	<p>
	
	<CFSET HeaderParm = "TopIndex">
	
	<CFSET ASSESSMENT_PROBABILITY_Label_Count = 1>
	
	<CFLOOP QUERY="CONTINGENT_LIAB_GetRecord">
	
		<CFINCLUDE TEMPLATE="sectionheadings.cfswitch.cfm">
		
		<CFIF NOT 
		(
		(
		IsDefined("Form.Operation") 
		AND 
		(
		Form.Operation EQ "Updated" 
		OR 
		Form.Operation EQ "Inserted"
		)
		) 
		OR 
		IsDefined("RecIDParm")
		)>
		
			<CFINCLUDE TEMPLATE="sectionheadings.cfset.cfm">
		
		</cfif>
		
		
		<CFOUTPUT>
		<li><a href="###PRIMARYKEY#">#Trim(CASE_NAME)#</a>, Case No.
		
		<CFIF Trim(CASE_NUMBER) NEQ "">
			#Trim(CASE_NUMBER)#
		<CFELSE>
			___
		</cfif>
		
		</cfoutput>
		
	</cfloop>


	<CFIF NOT 
	(
	(
	IsDefined("Form.Operation") 
	AND 
	(
	Form.Operation EQ "Updated" 
	OR 
	Form.Operation EQ "Inserted"
	)
	) 
	OR 
	IsDefined("RecIDParm")
	)>

		<CFLOOP CONDITION="(CLAIM_CATEGORY_Label_Count NEQ ThisCLAIM_CATEGORY) AND (CLAIM_CATEGORY_Label_Count LE CLAIM_CATEGORY_Label_List_Len) AND (HeaderParm EQ 'TopIndex')">
		
			<CFOUTPUT>
			<p>
			<h5 style="color:gray">[#ListGetAt(CLAIM_CATEGORY_Label_List, CLAIM_CATEGORY_Label_Count)#]</h5>
			<p>
			</cfoutput>
			
			<CFSET CLAIM_CATEGORY_Label_Count = CLAIM_CATEGORY_Label_Count + 1>
			
		</cfloop>

		<CFLOOP CONDITION="(ASSESSMENT_PROBABILITY_Label_Count NEQ ThisASSESSMENT_PROBABILITY) AND (ASSESSMENT_PROBABILITY_Label_Count LE ASSESSMENT_PROBABILITY_Label_List_Len) AND (HeaderParm EQ 'TopIndex')">
		
			<CFOUTPUT>
			<p>
			<hr>
			<h4 style="color:gray">[#ListGetAt(ASSESSMENT_PROBABILITY_Label_List, ASSESSMENT_PROBABILITY_Label_Count)#]</h4>
			<p>
			</cfoutput>
			
			<CFSET ASSESSMENT_PROBABILITY_Label_Count = ASSESSMENT_PROBABILITY_Label_Count + 1>
		
		</cfloop>
	
	</cfif>
	
	</div>

	<hr>

<!--- Close <CFIF NOT ((IsDefined("Form.Operation") --->
</cfif>




<CFQUERY NAME="EeList" DATASOURCE="lddb">
SELECT *
FROM VIEW_CONTING_EE_LIST
</cfquery>


<CFQUERY NAME="LDOffices" DATASOURCE="lddb">

<!---
SELECT *
FROM VIEW_CONTING_LDOFFICES_EXCL

<CFIF ThisReportDateCompare GE 0>
WHERE
DELETE_FLAG IS NULL
</cfif>


--->


select DISTINCT office, OFFICE_PRM_KEY, DELETE_FLAG
from ldoffices
where 

<!---
OFFICE_PRM_KEY IN (SELECT OFFICE_PRM_KEY FROM VIEW_CONTING_LDOFFICES_INIT)
--->


trim(office) NOT LIKE 'Select%' 

AND 
trim(office) NOT LIKE 'Law Department%' 

AND 
trim(office) NOT LIKE '%List' 



AND
(
OFFICE NOT LIKE 'Directories%'
AND
OFFICE NOT LIKE '%Atlanta%'
AND
OFFICE NOT LIKE '%Facilities%'
AND
OFFICE NOT LIKE '%Environmental%'
AND
OFFICE NOT LIKE '%General Counsel, HQ%'
AND
OFFICE NOT LIKE '%Business Services%'
AND
OFFICE NOT LIKE '%HQ Integration%'
)


<CFIF ThisReportDateCompare GE 0>
AND
DELETE_FLAG IS NULL
</cfif>


order by office


</cfquery>



<CFSET RowNum = 0>

<CFSET Old_CASE_TYPE_Label = "">
<CFSET Old_ASSESSMENT_PROBABILITY_Label = "">
<CFSET Old_CLAIM_CATEGORY_Label = "">

<CFSET HeaderParm = "Body">



