

<CFAPPLICATION NAME="ContingLiab"
SESSIONTIMEOUT=#CreateTimeSpan(0,0,10,0)#
SESSIONMANAGEMENT="Yes"
SEARCHIMPLICITSCOPES="True">



<!--- Previous:

requestTimeout = "1300"

--->

<!---
<CFSETTING requestTimeout = "1800">
--->



<CFSETTING requestTimeout = "5000">



<!-- applicationCFM at 11 -->
<link rel="stylesheet" type="text/css" href="stylesheet.css">


<!---

NOTE: <CFQUERY NAME="#CLRC_Query_Name#" occurs in cfloop.cur_rem.casetype.assesscutoff.query.cfm and Get_Single_Record.cfm

--->






<!---
<CFOUTPUT>
GetFileFromPath(GetBaseTemplatePath()) = #GetFileFromPath(GetBaseTemplatePath())#
</CFOUTPUT>

<p></p>
--->


<CFSET ThisTemplatePath = GetDirectoryFromPath(GetBaseTemplatePath())>

<CFSET ThisTemplatePath = RemoveChars(ThisTemplatePath, Len(ThisTemplatePath), 1)>



<!--- Text length limit for COMMENT_GENERAL textarea value, used in EditRecord.topjs.cfm, EditRecord.ptD.cfm, and Report.ptE.cfm --->
<CFSET Comment_Gen_Char_Limit = 3500>


<CFSET OneMillion = "1000000">

<CFSET FiveMillion = "5000000">

<CFSET TenMillion = "10000000">



<CFSET BackslashIndex = 1>


<CFLOOP CONDITION="BackslashIndex GT 0">

	<CFSET LastBackslash = BackslashIndex>

	<CFSET BackslashIndex = Find("\", ThisTemplatePath, LastBackslash + 1)>

</cfloop>


<CFSET ThisTemplateFolder = Right(ThisTemplatePath, Len(ThisTemplatePath) - LastBackslash)>



<!--- For production, Comment out Test_Email_Addr, Test_Server, Test_Server_Folder: --->


<!---
<CFSET Test_Email_Addr = "Kimsa.t.mac@usps.gov">
<CFSET Test_Server = "lawdept">
<CFSET Test_Server_Folder = ThisTemplateFolder & "/">
--->


<!---
<CFSET Test_Email_Addr = "Kimsa.t.mac@usps.gov">

<!---
<CFSET Test_Server = "eagnmntwe1860:7443">
--->

<CFSET Test_Server = CGI.SERVER_NAME & ":8182">

<CFSET Test_Server_Folder = ThisTemplateFolder & "/">
--->



<!--- Used in Report.ptE.cfm: List of cases to Turn off Text highlighting in Facts / Positions (full name of each case): --->


<CFSET TurnOffTextHighlight = "">


<!---

<CFSET TurnOffTextHighlight = "McConnell v. Donahoe">

<CFSET TurnOffTextHighlight = ListAppend(TurnOffTextHighlight, "McConnell v. Brennan")>

<CFSET TurnOffTextHighlight = "McConnell (aka Velva B.) v. Brennan">

--->


<!--- Durr case added after consulting N.Whitehead, C.Zadina, other Chicago managers --->
<!---KS Turn On Stephen for Factor/Positon textHighlight 2.14.24 --->
<!---<CFSET TurnOffTextHighlight = "Stephen Durr v United States Postal Service; Chicago Network Distribution Center (CNDC)">--->



<!---
B8GQQ0
<CFSET TurnOffTextHighlight = ListAppend(TurnOffTextHighlight, "Diping Y. Anderson v. Postmaster General")>
--->

<!--- See below for additional ListAppend for TurnOffTextHighlight for RespondingUser_Id EQ B8GQQ0 (W. Provoda) --->



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

<!--- Definitions:

[See also LabelLists.cfm]

CASE_TYPE
-- 1: Liability
-- 2: Receivable
-- CASE_TYPE+10: Removed


CLAIM_CATEGORY_Labels = "Business,Labor,Tort">

ASSESSMENT_PROBABILITY_LabelList = "Probable,Reasonably Possible,Remote"

Estimated_Time_Resolution_ValueList = "2,100,200"
Estimated_Time_Resolution_LabelList = "Less Than 1 Year,1 - 5 Years,Over 5 Years"

Assess_Cutoff_List set in Report.ptA.cfm


--->






<CFQUERY NAME="Get_PW" DATASOURCE="ContLiab">
SELECT PW, AD_MAILNICKNAME
FROM BUSINESSSERVUSERS
WHERE USERPRMKEY = 361
</cfquery>







<cfset startstr = "dc=usa,dc=dce,dc=usps,dc=gov">

<CFSET LDAPDistingName = "CN=Sindermann Jr\, Robert P,OU=Users,OU=HQ,OU=Users & Workstations," & startstr>
<CFSET LDAPServerName = "eagandcs-sha2.usa.dce.usps.gov">
<!---<CFSET LDAPServerName = "eagandcs.usa.dce.usps.gov">--->


<CFSET todayDate = Now()>
<CFSET todayDateFmt = DateFormat(todayDate, "mm/dd/yyyy")>

<!---
<CFSET Spreadsheets_Uploads_Dir = "D:\Inetpub\wwwroot\InHouse\ContingentLiabilities\Spreadsheets\">
--->

<!---
<CFSET Spreadsheets_Uploads_Dir = "D:\Inetpub\wwwroot\ClientService\ContingentLiabilities\Spreadsheets\">
--->


<!---
<CFSET CFFILE_Uploads_Dir = "D:\web\cf\cfusion\wwwroot\ClientService\DocUploadsFromCF2018\Doc.LitigationHold\Matters\">
<CFSET CFFILE_Uploads_Dir_URL = "https://eagnmntwe1860:7443/ClientService/DocUploadsFromCF2018/Doc.LitigationHold/Matters/">
--->

<!---
<CFSET Spreadsheets_Uploads_Dir = "D:\web\cf\cfusion\wwwroot\ClientService\DocUploadsFromCF2018\Doc.ContingentLiabilities\Spreadsheets\">
--->



<CFSET Spreadsheets_Uploads_Dir = "D:\web\inetpub\wwwroot2\ClientService\DocUploadsFromCF2018\Doc.ContingentLiabilities\Spreadsheets\">




<!---
<CFSET Spreadsheets_Uploads_Dir_URL = "../Spreadsheets/">

<CFSET Spreadsheets_Uploads_Dir_URL = "https://eagnmntwe1860:7443/ClientService/DocUploadsFromCF2018/Doc.ContingentLiabilities/Spreadsheets/">

--->


<!---
<CFSET Spreadsheets_Uploads_Dir_URL = "https://eagnmnss29c:8182/ClientService/DocUploadsFromCF2018/Doc.ContingentLiabilities/Spreadsheets/">
--->



<CFSET Spreadsheets_Uploads_Dir_URL = "/ClientService/DocUploadsFromCF2018/Doc.ContingentLiabilities/Spreadsheets/">




<!---
<CFSET CFFILE_Spsheet_Uploads_Dir_Link = "/ClientService/DocUploadsFromCF2018/Doc.ContingentLiabilities/Spreadsheets/FY" & RptDateToFmt_FY & "_Q" & RptDateToFmt_FYQuarter & "/">
--->






<CFSET NewCLProtocolReportDate = "06/30/2010">


<CFSET PostRedesignReportDate = "09/30/2011">


<CFSET PostDistDivReorgRptDate = "06/30/2021">



<CFSET RowColorGreen = "CCFFCC">





<CFSET ThisTemplatePath = GetDirectoryFromPath(GetBaseTemplatePath())>

<CFSET ThisTemplatePath = RemoveChars(ThisTemplatePath, Len(ThisTemplatePath), 1)>




<CFSET BackslashIndex = 1>


<CFLOOP CONDITION="BackslashIndex GT 0">

	<CFSET LastBackslash = BackslashIndex>

	<CFSET BackslashIndex = Find("\", ThisTemplatePath, LastBackslash + 1)>

</cfloop>


<CFSET ThisTemplateFolder = Right(ThisTemplatePath, Len(ThisTemplatePath) - LastBackslash)>

<!---
<CFSET Test_Server_Folder = "Test.20110325/">
--->

<CFIF IsDefined("Test_Server")>
        <CFSET This_Server = Test_Server>
<CFELSE>
        <!---<CFSET This_Server = "lawdept">--->
        <!---<CFSET This_Server = "eagnmnss0b6">--->

<!---
        <CFSET This_Server = CGI.SERVER_NAME & ":7443">
--->

<!---
        <CFSET This_Server = CGI.SERVER_NAME & ":8182">
--->

		<CFSET This_Server = CGI.SERVER_NAME>



</cfif>

<CFIF IsDefined("Test_Server_Folder")>
	<CFSET ServerFolder = Test_Server_Folder>
<CFELSE>
	<CFSET ServerFolder = "V1.0/">
</cfif>

<!--- Moved to LabelLists.cfm
<cfset YesNo_List = "Y,N">
--->
<cfif len(cgi.auth_user) eq 0 and cgi.SERVER_NAME neq "eagnmnwep1431" and cgi.SERVER_NAME neq "eagnmnwep1432" >
	<cfset Init_user_id = "K6GVN0">
<cfelse>
	<cfset Init_User_Id = TRIM(UCASE(RemoveChars(cgi.auth_user,1,find('\',cgi.auth_user))))>
</cfif>




<!---
<!--- User test: Jim Schlett KV83HK / schletjg --->
<cfset Init_User_Id = "schletjg">
--->



<CFIF GetFileFromPath(GetBaseTemplatePath()) DOES NOT CONTAIN "NotAuthorized.cfm">

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
<!---


--->	
	
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
	


	<CFIF RespondingUser_Id EQ "B8GQQ0">

		<CFSET TurnOffTextHighlight = ListAppend(TurnOffTextHighlight, "Diping Y. Anderson v. Postmaster General")>

	</CFIF>

	<CFQUERY NAME="GetUserInfo" DATASOURCE="ContLiab">
	
	SELECT b.LASTNAME, b.FIRSTNAME, a.LONGEMAIL, b.PRIMARYKEY, b.AD_USERID, b.AD_MAILNICKNAME, Trim(a.LASTNAME) || ', ' || Trim(a.FIRSTNAME) AS FULLNAME
	
	FROM LAWDEPARTMENT a, LDEXTRA b
	
	WHERE a.PRIMARYKEY = b.PRIMARYKEY
	
	AND (UPPER(b.AD_USERID) LIKE UPPER('#RespondingUser_Id#%') OR UPPER(b.AD_MAILNICKNAME) LIKE UPPER('#RespondingUser_Id#%'))
	
	AND (SEPARATFLG != 'S' OR SEPARATFLG IS NULL OR SEPARATFLG = '0')
	
	</cfquery>
	
	<CFIF GetUserInfo.RecordCount NEQ 1>
	
		<script language="javascript">
	//	alert("Error with User ID.");
		location.href = "NotAuthorized.cfm"
		</script>
	
	<CFELSE>
	
<!---
    dn="#LDAPDistingName#"
--->
<cftry>
		<cfldap action="QUERY"
		    name="QueryGetDisplayName"
		    attributes="displayName, mail"
			maxrows="10000"
			timeout="9000"
		    start="#startstr#"
			filter="(&(objectClass=user)(|(extensionAttribute13=#GetUserInfo.AD_USERID#)(mailNickName=#GetUserInfo.AD_MAILNICKNAME#)))"
			scope="subtree"
			sort="name"
		    server="#LDAPServerName#"
		    username="usa\#Trim(Get_PW.AD_MAILNICKNAME)#"
		    password="#Get_PW.PW#">
		<cfcatch type="any">
			<cflog text="QueryGetDisplayName Error: #cfcatch.message#" type="error" file="clrs-ldap">
			
		</cfcatch>
		<cffinally>
			<cflog text="LDAP QueryGetDisplayName Result: displayName #queryGetDisplayname.displayname# | mail #queryGetDisplayname.mail#" type="information" file="clrs-ldap">
		</cffinally>
		</cftry>

		<CFSET This_EE_From_Line = '"' & Trim(QueryGetDisplayName.displayName) & '"' & ' <' & Trim(QueryGetDisplayName.mail) & '>'>


		<CFSET ThisEEName = Trim(GetUserInfo.FULLNAME)>
	
		<CFSET TrimUserLastName = Trim(GetUserInfo.LASTNAME)>
		<CFSET TrimUserFirstName = Trim(GetUserInfo.FIRSTNAME)>
		
	</cfif>

	<CFINCLUDE TEMPLATE="Query.Get_Bus_Serv_Contact.cfm">

<!---
    dn="#LDAPDistingName#"
--->

<cftry>
	<cfldap action="QUERY"
	    name="QueryGetBusServContactDisplayName"
	    attributes="displayName, mail"
		maxrows="10000"
		timeout="9000"
	    start="#startstr#"
		filter="(&(objectClass=user)(employeeID=#NumberFormat(Get_Bus_Serv_Contact.EMPLOYEE_ID, '00000000')#))"
		scope="subtree"
		sort="name"
	    server="#LDAPServerName#"
	    username="usa\#Trim(Get_PW.AD_MAILNICKNAME)#"
	    password="#Get_PW.PW#">
		<cfcatch type="any">
			<cflog text="QueryGetBusServContactDisplayName Error: #cfcatch.message#" type="error" file="clrs-ldap">
			
		</cfcatch>
		<cffinally>
			<cflog text="LDAP QueryGetBusServContactDisplayName Result: displayName #QueryGetBusServContactDisplayName.displayname# | mail #QueryGetBusServContactDisplayName.mail#" type="information" file="clrs-ldap">
		</cffinally>
	</cftry>
	<CFSET This_BusServContact_From_Line = '"' & Trim(QueryGetBusServContactDisplayName.displayName) & '"' & ' <' & Trim(QueryGetBusServContactDisplayName.mail) & '>'>
	
	<CFQUERY NAME="Get_All_ReportDates" DATASOURCE="ContLiab">
	SELECT DATE_RPT_FMT
	FROM view_conting_all_rptdates_fmt
	</cfquery>
		
	<CFSET ReportDatesList = ValueList(Get_All_ReportDates.DATE_RPT_FMT)>

<!---
<CFOUTPUT>
<p>
ReportDatesList = "#ReportDatesList#"
<p>
</CFOUTPUT>
--->

	<CFSET ReportDatesList_ListLen = ListLen(ReportDatesList)>

	<CFSET EarliestReportDate = DateFormat(ListLast(ReportDatesList), "mm/dd/yyyy")>

<!--- Get cases of earlier report if defined; otherwise get latest date report (ListFirst(ReportDatesList)) --->

	<CFIF IsDefined("EarlierRptDate")>
	
		<CFSET ThisReportDate = DateFormat(EarlierRptDate, "mm/dd/yyyy")>
	
<!---    
		<CFIF ReportDatesList_ListLen GT 1>
--->	
    

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


<!---
<CFOUTPUT>
<p>
In application.cfm AT 554:
<br />
ThisReportDate = "#ThisReportDate#"
<br />

PrevReportDate = "#PrevReportDate#"
<p>
</CFOUTPUT>
--->


<!---
	<CFIF PrevReportDate NEQ "">
--->

	<CFIF PrevReportDate NEQ ""
	AND NOT
	IsDefined("PrevRptDate_String")>

	
		<CFSET RptDateToFmt = PrevReportDate>
	
		<CFINCLUDE TEMPLATE="RptDateFYQFmt.cfm">
	
		<CFSET PrevRptDate_String = ReportDate_String>
	
	    <CFSET PrevRptDateToFmt_FY = RptDateToFmt_FY>
	
	    <CFSET PrevRptDateToFmt_FYQuarter = RptDateToFmt_FYQuarter>



<!---
		<CFSET PrevCFFILE_Destination_Dir = "D:\web\cf\cfusion\wwwroot\ClientService\DocUploadsFromCF2018\Doc.ContingentLiabilities\Spreadsheets\FY" & RptDateToFmt_FY & "_Q" & RptDateToFmt_FYQuarter & "\Cases\">
--->	


		<CFSET PrevCFFILE_Destination_Dir = Spreadsheets_Uploads_Dir & "FY" & RptDateToFmt_FY & "_Q" & RptDateToFmt_FYQuarter & "\Cases\">




    
<!---	
		<CFSET PrevCFFILE_Uploads_Dir_Link = "/Doc.ContingentLiabilities/Spreadsheets/FY" & RptDateToFmt_FY & "_Q" & RptDateToFmt_FYQuarter & "/Cases/">
--->



<!---
		<CFSET PrevCFFILE_Uploads_Dir_Link = "https://eagnmntwe1860:7443/ClientService/DocUploadsFromCF2018/Doc.ContingentLiabilities/Spreadsheets/FY" & RptDateToFmt_FY & "_Q" & RptDateToFmt_FYQuarter & "/Cases/">
--->



		<CFSET PrevCFFILE_Uploads_Dir_Link = Spreadsheets_Uploads_Dir_URL & "FY" & RptDateToFmt_FY & "_Q" & RptDateToFmt_FYQuarter & "/Cases/">


	<CFELSEIF ReportDatesList_ListLen GT 1
	AND
   	ThisReportDate EQ EarliestReportDate>


		<CFSET PrevRptDate_String = "">
	
	    <CFSET PrevRptDateToFmt_FY = "">
	
	    <CFSET PrevRptDateToFmt_FYQuarter = "">



	</CFIF>

    
    




<!---
	<CFSET Spreadsheets_Uploads_Dir = "D:\web\inetpub\wwwroot2\ClientService\DocUploadsFromCF2018\Doc.ContingentLiabilities\Spreadsheets\">
--->


<!---
	<CFSET Spreadsheets_Uploads_Dir_URL = "/ClientService/DocUploadsFromCF2018/Doc.ContingentLiabilities/Spreadsheets/">
--->

<!---
	</CFIF>
--->

<!---
	<CFSET CFFILE_Spsheet_Uploads_Dir = "\ClientService\DocUploadsFromCF2018\Doc.ContingentLiabilities\Spreadsheets\FY" & RptDateToFmt_FY & "_Q" & RptDateToFmt_FYQuarter & "\">
--->


	<CFSET RptDateToFmt = ThisReportDate>

	<CFINCLUDE TEMPLATE="RptDateFYQFmt.cfm">



<!---
<CFOUTPUT>
<p>
In application.cfm at 669:
<br />
RptDateToFmt = "#RptDateToFmt#"
<br />
ThisReportDate = "#ThisReportDate#"
<br />

PrevReportDate = "#PrevReportDate#"
<p>
</CFOUTPUT>

--->








<!--- Also reset in Spreadsheet.CL.cfm, for Case List spsheet: --->

	<CFSET CFFILE_Spsheet_Uploads_Dir = "D:\web\inetpub\wwwroot2\ClientService\DocUploadsFromCF2018\Doc.ContingentLiabilities\Spreadsheets\FY" & RptDateToFmt_FY & "_Q" & RptDateToFmt_FYQuarter & "\">


	<CFSET CFFILE_Spsheet_Uploads_Dir_Link = "/ClientService/DocUploadsFromCF2018/Doc.ContingentLiabilities/Spreadsheets/FY" & RptDateToFmt_FY & "_Q" & RptDateToFmt_FYQuarter & "/">


<!---
<CFOUTPUT>
<p>
application.cfm at 666: RptDateToFmt_FYQuarter = "#RptDateToFmt_FYQuarter#"
<p>

<cfabort>

</CFOUTPUT>
--->


<!---
	<CFSET CFFILE_Destination_Dir = "D:\web\cf\cfusion\wwwroot\ClientService\DocUploadsFromCF2018\Doc.ContingentLiabilities\Spreadsheets\FY" & RptDateToFmt_FY & "_Q" & RptDateToFmt_FYQuarter & "\Cases\">
--->


	<CFSET CFFILE_Destination_Dir = Spreadsheets_Uploads_Dir & "FY" & RptDateToFmt_FY & "_Q" & RptDateToFmt_FYQuarter & "\Cases\">


	<CFSET CFFILE_Uploads_Dir_Link = Spreadsheets_Uploads_Dir_URL & "FY" & RptDateToFmt_FY & "_Q" & RptDateToFmt_FYQuarter & "/Cases/">

<!---
<CFSET RptDate = "9/30/2011">
--->


<!--- For Report Date on or after 9/30/2011 (PostRedesignReportDate), use Redesign list of Areas, Districts: --->
	<CFIF IsDefined("RptDate")>

<!---
	<CFOUTPUT>
	RptDate = #RptDate#
    <p></p>
	</CFOUTPUT>
--->

		<CFSET ThisReportDateCompare = DateCompare(RptDate, PostRedesignReportDate)>

	<CFELSE>

<!---
	<CFOUTPUT>	
	ThisReportDate = #ThisReportDate#
    <p></p>
	</CFOUTPUT>
--->

		<CFSET ThisReportDateCompare = DateCompare(ThisReportDate, PostRedesignReportDate)>
	
	</CFIF>


<!---
<CFOUTPUT>
ThisReportDateCompare = #ThisReportDateCompare#
<p>

</CFOUTPUT>
--->



	

<!--- For Report Date on or after 6/30/2021 --->
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




	<CFQUERY NAME="Get_Districts" DATASOURCE="ContLiab">
	
<!---    
    
	SELECT AREA_CODE,
	DIST_PERF_CLUSTER_CODE,
	NAME
	
	from areas_districts
	
	WHERE
	
	<!---
	GAC - 07/16/2013 - Commented item below and added perf_cluster != 'A'
	DISTRICT_CODE != 0
	--->
	
	dist_perf_cluster_code != 'A'
	
	
	and
	dist_perf_cluster_code != 'Multiple'
	
	
	and
	name != 'General Counsel / Law Department'
	
	
	and
	name not like 'HQ%'
	
    
--->    
    
    
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



	<CFQUERY NAME="Get_Areas" DATASOURCE="ContLiab">
	
	SELECT AREA_CODE,
	NAME
	
	from areas_districts
	
	WHERE
	<!---
	GAC - 07/16/2013 - Commented item below and added perf_cluster != 'A'
	DISTRICT_CODE = 0
	--->
	
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








	<CFQUERY NAME="Get_HQ" DATASOURCE="ContLiab">
	
	SELECT AREA_CODE,
	NAME
	
	from areas_districts
	
	WHERE
	DISTRICT_CODE = 0
	
<!---
AND
(
AREA_CODE LIKE '6%'
OR
AREA_CODE = 'Mult'
)
--->


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
	





<!---
<CFOUTPUT>
PrevReportDate = "#PrevReportDate#"

</CFOUTPUT>
--->


<!---
Get_Single_Record
--->

	<CFIF GetFileFromPath(GetBaseTemplatePath()) DOES NOT CONTAIN "Get_Single_Record">



		<CFSET PrevReportDate_Fmt = DateFormat(PrevReportDate, 'mm/dd/yyyy')>






<!--- Cases in prev report below Corp Fin thresholds: --->
		<CFQUERY NAME="Get_PrevReport_CASE_REC_ID_SEQUENCE" DATASOURCE="ContLiab">


		SELECT DISTINCT CASE_REC_ID_SEQUENCE
		FROM CONTINGENT_LIAB_REPORT
		WHERE


		DATE_REPORT = to_date('#DateFormat(PrevReportDate, "mm/dd/yyyy")#', 'mm/dd/yyyy')

		AND


<!---
		DATE_REPORT = to_date('<cfqueryparam value="#DateFormat(PrevReportDate, "mm/dd/yyyy")#" cfsqltype="cf_sql_date">', 'mm/dd/yyyy')
--->


<!---
		DATE_REPORT = to_date('<cfqueryparam value="#DateFormat(PrevReportDate, 'mm/dd/yyyy')#" cfsqltype="cf_sql_date">', 'mm/dd/yyyy')
		
--->


<!---
		DATE_REPORT = to_date('<cfqueryparam value="#DateFormat(PrevReportDate, 'mm/dd/yyyy')#" cfsqltype="cf_sql_char">', 'mm/dd/yyyy')
--->


<!---
		DATE_REPORT = to_date('<cfqueryparam value="#PrevReportDate_Fmt#" cfsqltype="cf_sql_date">', 'mm/dd/yyyy')
        AND
--->






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
        
<!---        
		ASSESSMENT_AMOUNT < #OneMillion#
--->

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




<!---
<CFOUTPUT>
ValueList(Get_PrevReport_CASE_REC_ID_SEQUENCE.CASE_REC_ID_SEQUENCE) =
#ValueList(Get_PrevReport_CASE_REC_ID_SEQUENCE.CASE_REC_ID_SEQUENCE)#
<p>
</CFOUTPUT>
--->





<!--- Used in textcompare.cfm: --->
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
	
	
	<CFSET Unions_List_ColLen_Max = 5>
	
	<CFSET Unions_List_Width_TotalPct = 65>
	
	<CFSET Unions_List_Loop_Max = Ceiling(ListLen(Unions_List) / Unions_List_ColLen_Max)>
	
	<CFSET Unions_List_BreakPt =  Ceiling(ListLen(Unions_List) / Unions_List_Loop_Max)>
	
	<CFSET Unions_List_Span_Width = Unions_List_Width_TotalPct / Unions_List_Loop_Max>
	
	
	
	<CFSET Status_Code_Max = 15>
	
	
	<!--- Dropped status_code 3, is now split between 7 (chg in liab assessment) and 4 (chg in damages assessment) --->
	<!--- Status_code labels in cfswitch.status_code.cfm --->
	<CFSET Status_Code_Order = "1,2,7,4,9,8,5,6,11,12,13,14,15">
	
	
	<CFSET Status_Code_To_Be_Removed_List = "11,12,13,14,15">
	
	
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
	
	
	<CFQUERY NAME="GetMC" DATASOURCE="ContLiab">
	SELECT USERPRMKEY, CONTINGENT_LIAB_CONCUR
	FROM VIEW_CONTING_BUSSERVUSERS_OBT
	WHERE UPPER(AD_USERID) LIKE UPPER('#RespondingUser_Id#%')
	OR UPPER(AD_MAILNICKNAME) LIKE UPPER('#RespondingUser_Id#%')
	</cfquery>

<!--- Used in Report with
(CONTINGENT_LIAB_GetRecord_Current_Count.Current_Count GT IndexOnlyCaseCountCutoff
AND NOT IsDefined("Form.IndexOnly")) --->

<!---
<CFSET IndexOnlyCaseCountCutoff = 15>
--->

	<CFSET IndexOnlyCaseCountCutoff = 1>
	
	
	<CFSET RedBoldToggleDiv = "<div onClick=""this.style.color='black'; this.style.fontWeight='normal'"" onDblclick=""this.style.color='red'; this.style.fontWeight='bold'"">">
	
	<CFSET RedBoldToggleSpan = "<span onClick=""this.style.color='black'; this.style.fontWeight='normal'"" onDblclick=""this.style.color='red'; this.style.fontWeight='bold'"">">
	
	
<!--- Close <CFIF GetFileFromPath(GetBaseTemplatePath()) DOES NOT CONTAIN "NotAuthorized.cfm"> --->
</CFIF>




