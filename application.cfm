
<CFAPPLICATION NAME="ContingLiab"
SESSIONTIMEOUT=#CreateTimeSpan(0,0,10,0)#
SESSIONMANAGEMENT="Yes"
SETDOMAINCOOKIES="Yes"
SEARCHIMPLICITSCOPES="True">
<CFSETTING requestTimeout = "5000">

<!--- Load environment-specific configuration (Dev/SIT/CAT) --->
<CFINCLUDE TEMPLATE="config.cfm">

<link rel="stylesheet" type="text/css" href="stylesheet.css">

<!--- Extract the current template folder name from the full path --->
<CFSET ThisTemplatePath = GetDirectoryFromPath(GetBaseTemplatePath())>
<CFSET ThisTemplatePath = RemoveChars(ThisTemplatePath, Len(ThisTemplatePath), 1)>

<!--- Text length limit for COMMENT_GENERAL textarea value, used in EditRecord.topjs.cfm, EditRecord.ptD.cfm, and Report.ptE.cfm --->
<CFSET Comment_Gen_Char_Limit = 3500>

<!--- Dollar thresholds used for Corp Fin reporting cutoffs --->
<CFSET OneMillion = "1000000">
<CFSET FiveMillion = "5000000">
<CFSET TenMillion = "10000000">

<!--- Parse folder name from template path --->
<CFSET BackslashIndex = 1>
<CFLOOP CONDITION="BackslashIndex GT 0">
	<CFSET LastBackslash = BackslashIndex>
	<CFSET BackslashIndex = Find("\", ThisTemplatePath, LastBackslash + 1)>
</cfloop>
<CFSET ThisTemplateFolder = Right(ThisTemplatePath, Len(ThisTemplatePath) - LastBackslash)>

<!--- Used in Report.ptE.cfm: List of cases to turn off text highlighting in Facts/Positions --->
<CFSET TurnOffTextHighlight = "">

<!--- Narrative deletion display toggle based on Corp Fin format --->
<CFIF IsDefined("Form.CorpFinFormat") AND Form.CorpFinFormat EQ "CorpFinFormat">
<style>
div.NarrDeletion_Note {display:none}
span.NarrDeletion {display:none}
</style>
<CFELSE>
<style>
div.NarrDeletion_Note {display:inline}
span.NarrDeletion {display:inline}
</style>
</CFIF>

<!--- Definitions: [See also LabelLists.cfm]
CASE_TYPE: 1=Liability, 2=Receivable, CASE_TYPE+10=Removed
CLAIM_CATEGORY_Labels = "Business,Labor,Tort"
ASSESSMENT_PROBABILITY_LabelList = "Probable,Reasonably Possible,Remote"
Estimated_Time_Resolution_ValueList = "2,100,200"
Estimated_Time_Resolution_LabelList = "Less Than 1 Year,1 - 5 Years,Over 5 Years"
Assess_Cutoff_List set in Report.ptA.cfm
--->

<!--- Get LDAP service account credentials --->
<CFQUERY NAME="Get_PW" DATASOURCE="ContLiab">
SELECT PW, AD_MAILNICKNAME
FROM BUSINESSSERVUSERS
WHERE USERPRMKEY = 361
</cfquery>

<!--- Date variables --->
<CFSET todayDate = Now()>
<CFSET todayDateFmt = DateFormat(todayDate, "mm/dd/yyyy")>

<!--- Key application dates --->
<CFSET NewCLProtocolReportDate = "06/30/2010">
<CFSET PostRedesignReportDate = "09/30/2011">
<CFSET PostDistDivReorgRptDate = "06/30/2021">
<CFSET RowColorGreen = "CCFFCC">

<!--- Re-parse template folder (needed after potential include resets) --->
<CFSET ThisTemplatePath = GetDirectoryFromPath(GetBaseTemplatePath())>
<CFSET ThisTemplatePath = RemoveChars(ThisTemplatePath, Len(ThisTemplatePath), 1)>
<CFSET BackslashIndex = 1>
<CFLOOP CONDITION="BackslashIndex GT 0">
	<CFSET LastBackslash = BackslashIndex>
	<CFSET BackslashIndex = Find("\", ThisTemplatePath, LastBackslash + 1)>
</cfloop>
<CFSET ThisTemplateFolder = Right(ThisTemplatePath, Len(ThisTemplatePath) - LastBackslash)>

<!--- Determine server and folder settings --->
<CFIF IsDefined("Test_Server")>
	<CFSET This_Server = Test_Server>
<CFELSE>
	<CFSET This_Server = CGI.SERVER_NAME>
</cfif>

<CFIF IsDefined("Test_Server_Folder")>
	<CFSET ServerFolder = Test_Server_Folder>
<CFELSE>
	<CFSET ServerFolder = "V1.0/">
</cfif>

<!--- Determine the initial user ID from Windows auth or default for local dev --->
<cfif len(cgi.auth_user) eq 0 and len(Default_Dev_User_Id) gt 0>
	<cfset Init_user_id = Default_Dev_User_Id>
<cfelse>
	<cfset Init_User_Id = TRIM(UCASE(RemoveChars(cgi.auth_user,1,find('\',cgi.auth_user))))>
</cfif>

<CFIF GetFileFromPath(GetBaseTemplatePath()) DOES NOT CONTAIN "NotAuthorized.cfm">

<!--- Verify user is authorized for Contingent Liabilities --->
<cftry>
	<CFQUERY NAME="Init_Check_Auth_User_A" DATASOURCE="ContLiab" result="checkAuthAResult">
	SELECT USERPRMKEY FROM BUSINESSSERVUSERS a, LAWDEPARTMENT b
	WHERE a.USERPRMKEY = b.PRIMARYKEY
	AND (a.CONTINGENT_LIAB_AUTH = 'A' OR a.CONTINGENT_LIAB_AUTH = 'I')
	AND (UPPER(a.AD_USERID) LIKE UPPER('#Init_User_Id#%')
	OR UPPER(a.AD_MAILNICKNAME) LIKE UPPER('#Init_User_Id#%'))
	AND (b.SEPARATFLG != 'S' OR b.SEPARATFLG IS NULL OR b.SEPARATFLG = '0')
	</cfquery>
	<cfcatch type="any">
		<cfdump var="#cfcatch#" abort="true">
	</cfcatch>
	<cffinally>
		<cflog text="Init_Check_Auth_User_A: #serializeJson(checkAuthAResult)#" type="information" file="clrs-ldap">
	</cffinally>
</cftry>
	
	<!--- If single authorized user and not from InHouse or special format, use test user; otherwise use init user --->
	<CFIF Init_Check_Auth_User_A.RecordCount EQ 1
	AND NOT
	(
	IsDefined("FromInHouse")
	AND
	FromInHouse EQ "yes"
	)
	AND NOT
	(
	(
	IsDefined("Form.CorpFinFormat")
	AND
	Form.CorpFinFormat EQ "CorpFinFormat"
	)
	OR
	(
	IsDefined("Form.FrontOffcReviewFormat")
	AND
	Form.FrontOffcReviewFormat EQ "FrontOffcReviewFormat"
	)
	)>
	
		<CFINCLUDE TEMPLATE="SetUserID.TestUser.cfm">
	
	<CFELSE>
	
		<cfset RespondingUser_Id = Init_User_Id>
	
	</cfif>

	<!--- User-specific text highlight override for W. Provoda --->
	<CFIF RespondingUser_Id EQ "B8GQQ0">
		<CFSET TurnOffTextHighlight = ListAppend(TurnOffTextHighlight, "Diping Y. Anderson v. Postmaster General")>
	</CFIF>

	<!--- Get responding user's info from database --->
	<CFQUERY NAME="GetUserInfo" DATASOURCE="ContLiab">
	SELECT b.LASTNAME, b.FIRSTNAME, a.LONGEMAIL, b.PRIMARYKEY, b.AD_USERID, b.AD_MAILNICKNAME, Trim(a.LASTNAME) || ', ' || Trim(a.FIRSTNAME) AS FULLNAME
	FROM LAWDEPARTMENT a, LDEXTRA b
	WHERE a.PRIMARYKEY = b.PRIMARYKEY
	AND (UPPER(b.AD_USERID) LIKE UPPER('#RespondingUser_Id#%') OR UPPER(b.AD_MAILNICKNAME) LIKE UPPER('#RespondingUser_Id#%'))
	AND (SEPARATFLG != 'S' OR SEPARATFLG IS NULL OR SEPARATFLG = '0')
	</cfquery>
	
	<CFIF GetUserInfo.RecordCount NEQ 1>
	
		<script language="javascript">
		location.href = "NotAuthorized.cfm"
		</script>
	
	<CFELSE>

	<!--- LDAP query to get user display name and email --->
	<cftry>
		<cfldap action="QUERY"
		    name="QueryGetDisplayName"
		    attributes="displayName, mail"
			start="#startstr#"
			filter="(&(objectClass=user)(|(extensionAttribute13=#GetUserInfo.AD_USERID#)(mailNickName=#GetUserInfo.AD_MAILNICKNAME#)))"
			scope="subtree"
			sort="name"
		    server="#LDAPServerName#"
		    secure = "CFSSL_BASIC"
		    port="636"
		    username="usa\#Trim(Get_PW.AD_MAILNICKNAME)#"
		    password="#Get_PW.PW#">
		<cfcatch type="any">
			<cflog text="QueryGetDisplayName Error: #cfcatch.message#" type="error" file="clrs-ldap">
		</cfcatch>
	</cftry>

		<cfif IsDefined("QueryGetDisplayName") AND QueryGetDisplayName.RecordCount GT 0>
			<CFSET This_EE_From_Line = '"' & Trim(QueryGetDisplayName.displayName) & '"' & ' <' & Trim(QueryGetDisplayName.mail) & '>'>
		<cfelse>
			<CFSET This_EE_From_Line = '"' & Trim(GetUserInfo.FULLNAME) & '"' & ' <' & Trim(GetUserInfo.LONGEMAIL) & '>'>
		</cfif>
		<CFSET ThisEEName = Trim(GetUserInfo.FULLNAME)>
		<CFSET TrimUserLastName = Trim(GetUserInfo.LASTNAME)>
		<CFSET TrimUserFirstName = Trim(GetUserInfo.FIRSTNAME)>
		
	</cfif>

	<CFINCLUDE TEMPLATE="Query.Get_Bus_Serv_Contact.cfm">

	<!--- LDAP query to get Business Service Contact display name and email --->
	<cftry>
	<cfldap action="QUERY"
	    name="QueryGetBusServContactDisplayName"
	    attributes="displayName, mail"
	    start="#startstr#"
	    filter="(&(objectClass=user)(|(extensionAttribute13=#GetUserInfo.AD_USERID#)(mailNickName=#GetUserInfo.AD_MAILNICKNAME#)))"
		scope="subtree"
		sort="name"
	    server="#LDAPServerName#"
	    secure = "CFSSL_BASIC"
		port="636"
	    username="usa\#Trim(Get_PW.AD_MAILNICKNAME)#"
	    password="#Get_PW.PW#">
		<cfcatch type="any">
			<cflog text="QueryGetBusServContactDisplayName Error: #cfcatch.message#" type="error" file="clrs-ldap">
		</cfcatch>
	</cftry>
	<cfif IsDefined("QueryGetBusServContactDisplayName") AND QueryGetBusServContactDisplayName.RecordCount GT 0>
		<CFSET This_BusServContact_From_Line = '"' & Trim(QueryGetBusServContactDisplayName.displayName) & '"' & ' <' & Trim(QueryGetBusServContactDisplayName.mail) & '>'>
	<cfelse>
		<CFSET This_BusServContact_From_Line = '"' & Trim(GetUserInfo.FULLNAME) & '"' & ' <' & Trim(GetUserInfo.LONGEMAIL) & '>'>
	</cfif>
	<!--- Get all available report dates --->
	<CFQUERY NAME="Get_All_ReportDates" DATASOURCE="ContLiab">
	SELECT DATE_RPT_FMT
	FROM view_conting_all_rptdates_fmt
	</cfquery>
		
	<CFSET ReportDatesList = ValueList(Get_All_ReportDates.DATE_RPT_FMT)>
	<CFSET ReportDatesList_ListLen = ListLen(ReportDatesList)>
	<CFSET EarliestReportDate = DateFormat(ListLast(ReportDatesList), "mm/dd/yyyy")>

	<!--- Determine ThisReportDate and PrevReportDate based on parameters or defaults --->
	<CFIF IsDefined("EarlierRptDate")>
	
		<CFSET ThisReportDate = DateFormat(EarlierRptDate, "mm/dd/yyyy")>

		<CFIF ReportDatesList_ListLen GT 1
		AND
    	ThisReportDate NEQ EarliestReportDate>
	    	<CFSET PrevReportDate = ListGetAt(ReportDatesList, ListFind(ReportDatesList, ThisReportDate) + 1)>
		<CFELSE>
			<CFSET PrevReportDate = "">
		</cfif>
	
	<CFELSEIF IsDefined("ThisReportDate_Parm")>
	
		<CFSET ThisReportDate = ThisReportDate_Parm>
		<CFIF IsDefined("PrevReportDate_Parm")>
			<CFSET PrevReportDate = PrevReportDate_Parm>
		<CFELSE>
			<CFSET PrevReportDate = "">
		</CFIF>
	
	<CFELSE>
	
		<CFSET ThisReportDate = DateFormat(ListFirst(ReportDatesList), "mm/dd/yyyy")>
		<CFIF ReportDatesList_ListLen GT 1>
			<CFSET PrevReportDate = DateFormat(ListGetAt(ReportDatesList, 2), "mm/dd/yyyy")>
		<CFELSE>
			<CFSET PrevReportDate = "">
		</cfif>
	
	</cfif>

	<!--- Build previous report date paths if applicable --->
	<CFIF PrevReportDate NEQ ""
	AND NOT
	IsDefined("PrevRptDate_String")>

		<CFSET RptDateToFmt = PrevReportDate>
		<CFINCLUDE TEMPLATE="RptDateFYQFmt.cfm">
		<CFSET PrevRptDate_String = ReportDate_String>
	    <CFSET PrevRptDateToFmt_FY = RptDateToFmt_FY>
	    <CFSET PrevRptDateToFmt_FYQuarter = RptDateToFmt_FYQuarter>
		<CFSET PrevCFFILE_Destination_Dir = Spreadsheets_Uploads_Dir & "FY" & RptDateToFmt_FY & "_Q" & RptDateToFmt_FYQuarter & "\Cases\">
		<CFSET PrevCFFILE_Uploads_Dir_Link = Spreadsheets_Uploads_Dir_URL & "FY" & RptDateToFmt_FY & "_Q" & RptDateToFmt_FYQuarter & "/Cases/">

	<CFELSEIF ReportDatesList_ListLen GT 1
	AND
   	ThisReportDate EQ EarliestReportDate>

		<CFSET PrevRptDate_String = "">
	    <CFSET PrevRptDateToFmt_FY = "">
	    <CFSET PrevRptDateToFmt_FYQuarter = "">

	</CFIF>

	<!--- Format current report date --->
	<CFSET RptDateToFmt = ThisReportDate>
	<CFINCLUDE TEMPLATE="RptDateFYQFmt.cfm">

	<!--- Also reset in Spreadsheet.CL.cfm, for Case List spsheet --->
	<CFSET CFFILE_Spsheet_Uploads_Dir = "D:\web\inetpub\wwwroot2\ClientService\DocUploadsFromCF2018\Doc.ContingentLiabilities\Spreadsheets\FY" & RptDateToFmt_FY & "_Q" & RptDateToFmt_FYQuarter & "\">
	<CFSET CFFILE_Spsheet_Uploads_Dir_Link = "/ClientService/DocUploadsFromCF2018/Doc.ContingentLiabilities/Spreadsheets/FY" & RptDateToFmt_FY & "_Q" & RptDateToFmt_FYQuarter & "/">

	<CFSET CFFILE_Destination_Dir = Spreadsheets_Uploads_Dir & "FY" & RptDateToFmt_FY & "_Q" & RptDateToFmt_FYQuarter & "\Cases\">
	<CFSET CFFILE_Uploads_Dir_Link = Spreadsheets_Uploads_Dir_URL & "FY" & RptDateToFmt_FY & "_Q" & RptDateToFmt_FYQuarter & "/Cases/">

	<!--- For Report Date on or after 9/30/2011 (PostRedesignReportDate), use Redesign list of Areas, Districts --->
	<CFIF IsDefined("RptDate")>
		<CFSET ThisReportDateCompare = DateCompare(RptDate, PostRedesignReportDate)>
	<CFELSE>
		<CFSET ThisReportDateCompare = DateCompare(ThisReportDate, PostRedesignReportDate)>
	</CFIF>

	<!--- For Report Date on or after 6/30/2021 (PostDistDivReorgRptDate) --->
	<CFIF IsDefined("RptDate")>
		<CFSET PostDistDivReorgDateCompare = DateCompare(RptDate, PostDistDivReorgRptDate)>
	<CFELSE>
		<CFSET PostDistDivReorgDateCompare = DateCompare(ThisReportDate, PostDistDivReorgRptDate)>
	</CFIF>

	<cfswitch expression="#PostDistDivReorgDateCompare#"> 
    	<cfcase value="-1">
		<CFSET USPSOrg = "Pre_DistDivReorg">        
        </cfcase>
		<cfdefaultcase>
		<CFSET USPSOrg = "Post_DistDivReorg">        
		</cfdefaultcase> 
	</cfswitch>

	<!--- Get Districts based on org structure era --->
	<CFQUERY NAME="Get_Districts" DATASOURCE="ContLiab">
    <CFIF USPSOrg EQ "Post_DistDivReorg">
    	SELECT
	    NAME,
    	AREA_CODE,
	    AREA_DISTRICT_FLAG,
        DIST_PERF_CLUSTER_CODE,
    	DIVISION_CODE
		from areas_districts
		WHERE
    	AREA_DISTRICT_FLAG = 'D'
	<CFELSE>
     	SELECT 
        AREA_CODE,
		DIST_PERF_CLUSTER_CODE,
		NAME
		from areas_districts
		WHERE
		dist_perf_cluster_code != 'A'
		and
		dist_perf_cluster_code != 'Multiple'
		and
		name != 'General Counsel / Law Department'
		and
		name not like 'HQ%'
	</CFIF>    
	AND
    (
	START_DATE_REPORT IS NULL
	OR
	START_DATE_REPORT  <= to_date('#ThisReportDate#', 'mm/dd/yyyy')
	)
	AND
    (
	THRU_DATE_REPORT IS NULL
	OR
	THRU_DATE_REPORT  >= to_date('#ThisReportDate#', 'mm/dd/yyyy')
	)
	ORDER BY 
    SORT_ORDER NULLS LAST,
    upper(NAME)
	</cfquery>

	<!--- Get Areas --->
	<CFQUERY NAME="Get_Areas" DATASOURCE="ContLiab">
	SELECT AREA_CODE,
	NAME
	from areas_districts
	WHERE
	dist_perf_cluster_code = 'A'
	AND
    (
	START_DATE_REPORT IS NULL
	OR
	START_DATE_REPORT  <= to_date('#ThisReportDate#', 'mm/dd/yyyy')
	)
	AND
    (
	THRU_DATE_REPORT IS NULL
	OR
	THRU_DATE_REPORT  >= to_date('#ThisReportDate#', 'mm/dd/yyyy')
	)
	ORDER BY upper(NAME)
	</cfquery>

	<!--- Get Divisions --->
	<CFQUERY NAME="Get_Divisions" DATASOURCE="ContLiab">
	SELECT 
    DIVISION_CODE,
    AREA_CODE,
    NAME,
    REGION_CODE
	from areas_districts
	WHERE
	AREA_DISTRICT_FLAG = 'V'
	AND
    (
	START_DATE_REPORT IS NULL
	OR
	START_DATE_REPORT  <= to_date('#ThisReportDate#', 'mm/dd/yyyy')
	)
	AND
    (
	THRU_DATE_REPORT IS NULL
	OR
	THRU_DATE_REPORT  >= to_date('#ThisReportDate#', 'mm/dd/yyyy')
	)
 	ORDER BY 
    SORT_ORDER NULLS LAST,
    upper(NAME)
	</CFQUERY>

	<!--- Get HQ entries --->
	<CFQUERY NAME="Get_HQ" DATASOURCE="ContLiab">
	SELECT AREA_CODE,
	NAME
	from areas_districts
	WHERE
	DISTRICT_CODE = 0
	AND
	AREA_CODE LIKE '6%'
	<CFIF ThisReportDateCompare GE 0>
		AND
		THRU_DATE_REPORT IS NULL
	<CFELSE>
		AND
		(
		START_DATE_REPORT IS NULL
		OR
		(
		NOT
		START_DATE_REPORT >= to_date('#PostRedesignReportDate#', 'mm/dd/yyyy')
		)
		)
	</CFIF>
	ORDER BY upper(NAME)
	</cfquery>

	<!--- Get previous report cases below Corp Fin thresholds (skip for single record views) --->
	<CFIF GetFileFromPath(GetBaseTemplatePath()) DOES NOT CONTAIN "Get_Single_Record">

		<CFSET PrevReportDate_Fmt = DateFormat(PrevReportDate, 'mm/dd/yyyy')>

		<!--- Cases in prev report below Corp Fin thresholds --->
		<CFQUERY NAME="Get_PrevReport_CASE_REC_ID_SEQUENCE" DATASOURCE="ContLiab">
		SELECT DISTINCT CASE_REC_ID_SEQUENCE
		FROM CONTINGENT_LIAB_REPORT
		WHERE
		DATE_REPORT = to_date('#DateFormat(PrevReportDate, "mm/dd/yyyy")#', 'mm/dd/yyyy')
		AND
        CASE_TYPE = 1
		AND
		DELETED_FLAG IS NULL
		AND
		(
		(
		ASSESSMENT_PROBABILITY IN (1,2)
		AND
		(
		ASSESSMENT_AMT_UNKNOWN = 1
		OR
		(
		(
		ASSESSMENT_AMOUNT < <cfqueryparam cfsqltype="numeric" value="#OneMillion#">
		OR
		ASSESSMENT_AMOUNT IS NULL
		)
		AND NOT
		(
		ASSESSMENT_AMOUNT_UPPER >= <cfqueryparam cfsqltype="numeric" value="#OneMillion#">
		OR
		(
		ASSESSMENT_AMT_UPPER_HIGH_END IS NOT NULL
		AND
		ASSESSMENT_AMT_UPPER_HIGH_END >= <cfqueryparam cfsqltype="numeric" value="#OneMillion#">
		)
		)
		)
		)
		)
		OR
		(
		ASSESSMENT_PROBABILITY = 3
		AND
		(
		(
		ASSESSMENT_AMOUNT < <cfqueryparam cfsqltype="numeric" value="#TenMillion#">
		AND
		ASSESSMENT_AMOUNT_UPPER IS NULL
		)
		OR
		(
		ASSESSMENT_AMOUNT IS NULL
		AND
		ASSESSMENT_AMOUNT_UPPER < <cfqueryparam cfsqltype="numeric" value="#TenMillion#">
		)
		OR
		(
		ASSESSMENT_AMOUNT < <cfqueryparam cfsqltype="numeric" value="#TenMillion#">
		AND
		ASSESSMENT_AMOUNT_UPPER < <cfqueryparam cfsqltype="numeric" value="#TenMillion#">
		)
		OR
		ASSESSMENT_AMT_UNKNOWN = 1
		)
		AND NOT
		(
		(
		ASSESSMENT_AMOUNT < <cfqueryparam cfsqltype="numeric" value="#OneMillion#">
		OR
		ASSESSMENT_AMOUNT IS NULL
		)
		AND
		(
		ASSESSMENT_AMOUNT_UPPER >= <cfqueryparam cfsqltype="numeric" value="#OneMillion#">
		OR
		(
		ASSESSMENT_AMT_UPPER_HIGH_END IS NOT NULL
		AND
        <CFOUTPUT>
		ASSESSMENT_AMT_UPPER_HIGH_END >= <cfqueryparam cfsqltype="numeric" value="#OneMillion#">
        </CFOUTPUT>
		)
		)
		)
		)
		)
		ORDER BY CASE_REC_ID_SEQUENCE
		</cfquery>

	</CFIF>

	<!--- Used in textcompare.cfm --->
	<CFSET PunctuationList = "">
	<CFSET PunctuationList = ListAppend(PunctuationList, '"')>
	<CFSET PunctuationList = ListAppend(PunctuationList, "'")>
	<CFSET PunctuationList = ListAppend(PunctuationList, ".")>
	<CFSET PunctuationList = ListAppend(PunctuationList, ";")>
	<CFSET PunctuationList = ListAppend(PunctuationList, "/")>
	<CFSET PunctuationList = ListAppend(PunctuationList, "\")>
	<CFSET PunctuationList = ListAppend(PunctuationList, "<br><br>")>
	<CFSET BlankList = ",,,,,">
	
	<CFINCLUDE TEMPLATE="LabelLists.cfm">
	
	<!--- Unions list layout settings --->
	<CFSET Unions_List_ColLen_Max = 5>
	<CFSET Unions_List_Width_TotalPct = 65>
	<CFSET Unions_List_Loop_Max = Ceiling(ListLen(Unions_List) / Unions_List_ColLen_Max)>
	<CFSET Unions_List_BreakPt =  Ceiling(ListLen(Unions_List) / Unions_List_Loop_Max)>
	<CFSET Unions_List_Span_Width = Unions_List_Width_TotalPct / Unions_List_Loop_Max>
	
	<!--- Status code settings. Dropped status_code 3, now split between 7 (chg in liab assessment) and 4 (chg in damages assessment) --->
	<CFSET Status_Code_Max = 15>
	<CFSET Status_Code_Order = "1,2,7,4,9,8,5,6,11,12,13,14,15">
	<CFSET Status_Code_To_Be_Removed_List = "11,12,13,14,15">
	
	<!--- Checklist questions --->
	<CFQUERY NAME="Get_ChecklistQues" DATASOURCE="ContLiab">
	SELECT *
	FROM VIEW_CONTING_GET_CHECKLISTQUES
	</cfquery>
	
	<CFQUERY NAME="Get_AllQuesNum" DATASOURCE="ContLiab">
	SELECT *
	FROM VIEW_CONTING_GET_ALLQUESNUM
	</cfquery>
	
	<CFSET QuesNumList = ValueList(Get_ChecklistQues.QUESNUM_TRIM)>
	<CFSET MaroonBorderList = "">
	
	<!--- Get managing counsel info for current user --->
	<CFQUERY NAME="GetMC" DATASOURCE="ContLiab">
	SELECT USERPRMKEY, CONTINGENT_LIAB_CONCUR
	FROM VIEW_CONTING_BUSSERVUSERS_OBT
	WHERE UPPER(AD_USERID) LIKE UPPER('#RespondingUser_Id#%')
	OR UPPER(AD_MAILNICKNAME) LIKE UPPER('#RespondingUser_Id#%')
	</cfquery>

	<!--- IndexOnlyCaseCountCutoff: Used in Report to determine index-only display --->
	<CFSET IndexOnlyCaseCountCutoff = 1>
	
	<!--- Toggle elements: click=black/normal, double-click=red/bold --->
	<CFSET RedBoldToggleDiv = "<div onClick=""this.style.color='black'; this.style.fontWeight='normal'"" onDblclick=""this.style.color='red'; this.style.fontWeight='bold'"">">
	<CFSET RedBoldToggleSpan = "<span onClick=""this.style.color='black'; this.style.fontWeight='normal'"" onDblclick=""this.style.color='red'; this.style.fontWeight='bold'"">">
	
</CFIF>
