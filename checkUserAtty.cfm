<cfinclude template="MfaCookieCheck.cfm">
<!---
Included on InHouse Web site Welcome page (iframe on InHouse/frametest/welcome.main.htm): Checks if user gets links to Contingent Liabilities for report, adding new case, accessing Protocol
--->


<cfset RespondingUser_Id = TRIM(UCASE(RemoveChars(auth_user,1,find('\',auth_user))))>



<CFQUERY NAME="Get_LatestReportDate" DATASOURCE="contliab">

SELECT MAX(DATE_REPORT) AS DATE_REPORT_LATEST

FROM CONTINGENT_LIAB_REPORT

</cfquery>


<CFQUERY NAME="Get_Ee_ThisUser" DATASOURCE="contliab">
<!---
SELECT EENAME
FROM LDEXTRA
WHERE
(UPPER(AD_USERID) LIKE UPPER('#RespondingUser_Id#%')
OR UPPER(AD_MAILNICKNAME) LIKE UPPER('#RespondingUser_Id#%'))
AND EENAME NOT LIKE 'Test User%'
--->

SELECT b.EENAME

FROM LAWDEPARTMENT a, LDEXTRA b

WHERE a.PRIMARYKEY = b.PRIMARYKEY

AND (UPPER(b.AD_USERID) LIKE UPPER('#RespondingUser_Id#%') OR UPPER(b.AD_MAILNICKNAME) LIKE UPPER('#RespondingUser_Id#%'))

AND (a.SEPARATFLG != 'S' OR a.SEPARATFLG IS NULL OR a.SEPARATFLG = '0')

</cfquery>


<CFIF Get_Ee_ThisUser.RecordCount EQ 1>
	<CFSET ThisEEName = Trim(Get_Ee_ThisUser.EENAME)>
</cfif>


<CFSET AuthorizedFlag = "No">

<!---
<script>

<cfoutput>
alert('checkUserAtty.cfm at 53: AuthorizedFlag = "#AuthorizedFlag#"');
</cfoutput>

</script>
--->




<CFQUERY NAME="Check_Auth_User_A" DATASOURCE="contliab">
SELECT USERPRMKEY
FROM BUSINESSSERVUSERS
WHERE CONTINGENT_LIAB_AUTH = 'A'
AND (UPPER(AD_USERID) LIKE UPPER('#RespondingUser_Id#%')
OR UPPER(AD_MAILNICKNAME) LIKE UPPER('#RespondingUser_Id#%'))
</cfquery>


<CFIF Check_Auth_User_A.RecordCount EQ 1>

	<CFSET AuthorizedFlag = "Yes">
	<CFSET OfficeScope = "All Offices">

<!---
<script>

<cfoutput>
alert('checkUserAtty.cfm at 80: AuthorizedFlag = "#AuthorizedFlag#"');
</cfoutput>

</script>
--->




<CFELSE>


	<CFQUERY NAME="Get_Auth_User_PRMKEY" DATASOURCE="contliab">
	
	SELECT USERPRMKEY, CONTINGENT_LIAB_AUTH
	
	FROM BUSINESSSERVUSERS
	
	WHERE (CONTINGENT_LIAB_AUTH = 'O' OR CONTINGENT_LIAB_AUTH = 'B' OR CONTINGENT_LIAB_AUTH = 'T')
	
	AND (UPPER(AD_USERID) LIKE UPPER('#RespondingUser_Id#%')
	OR UPPER(AD_MAILNICKNAME) LIKE UPPER('#RespondingUser_Id#%'))
	
	</cfquery>
	
	
	<CFIF Get_Auth_User_PRMKEY.RecordCount EQ 1>
	
		<CFSET AuthorizedFlag = "Yes">
		
<!---    
<script>

<cfoutput>
alert('checkUserAtty.cfm at 114: AuthorizedFlag = "#AuthorizedFlag#"');
</cfoutput>

</script>
--->
        
        
        
        
        
        
        
		<CFSET ThisCONTINGENT_LIAB_AUTH = Get_Auth_User_PRMKEY.CONTINGENT_LIAB_AUTH>
		
		
		<CFQUERY NAME="Get_Auth_User_Office" DATASOURCE="contliab">
		
		SELECT LDOFFICES.OFFICE_PRM_KEY, LDOFFICES.OFFICE
		
		FROM LAWDEPARTMENT, LDOFFICES
		
		
		WHERE trim(LAWDEPARTMENT.OFFICE) = trim(LDOFFICES.OFFICE)
		
        and
        LDOFFICES.DELETE_FLAG IS NULL

		
		AND LAWDEPARTMENT.PRIMARYKEY = (SELECT USERPRMKEY
		
		FROM BUSINESSSERVUSERS
		
		WHERE (CONTINGENT_LIAB_AUTH = 'O' OR CONTINGENT_LIAB_AUTH = 'B' OR CONTINGENT_LIAB_AUTH = 'T')
		
		AND (UPPER(AD_USERID) LIKE UPPER('#RespondingUser_Id#%')
		OR UPPER(AD_MAILNICKNAME) LIKE UPPER('#RespondingUser_Id#%')))
		
		</cfquery>
		
		<CFIF Get_Auth_User_Office.RecordCount EQ 1>
			<CFSET OfficeScope = Trim(Get_Auth_User_Office.OFFICE)>
			<CFSET DefaultOffice = Get_Auth_User_Office.OFFICE_PRM_KEY>
		
			<CFIF Left(OfficeScope, 9) EQ "Southeast">
				<CFSET OfficeScope = "Southeast">
			</cfif>
		
		</cfif>
	

	<CFELSE>
	
		<CFQUERY NAME="Get_Indiv_User" DATASOURCE="contliab">
		SELECT LAWDEPARTMENT.PRIMARYKEY
		FROM LAWDEPARTMENT, LDEXTRA
		WHERE LAWDEPARTMENT.PRIMARYKEY = LDEXTRA.PRIMARYKEY
		AND (TITLE LIKE 'Managing Counsel%'
		OR TITLE LIKE 'Deputy Managing%'
		OR title LIKE 'Attorney%'
		OR title LIKE 'Chief%'
		OR title LIKE 'Senior Counsel%'
		OR title LIKE 'Senior Litigation%'
		OR title LIKE 'Program Manager%'
		OR title LIKE 'Executive Program%')
		
		AND (UPPER(AD_USERID) LIKE UPPER('#RespondingUser_Id#%')
		OR UPPER(AD_MAILNICKNAME) LIKE UPPER('#RespondingUser_Id#%'))
		
		AND 
		(
		LAWDEPARTMENT.SEPARATFLG != 'S' 
		OR 
		LAWDEPARTMENT.SEPARATFLG IS NULL 
		OR 
		LAWDEPARTMENT.SEPARATFLG = '0'
		)
		
		
		</cfquery>
		
		<CFIF IsDefined("Get_Indiv_User.RecordCount") AND Get_Indiv_User.RecordCount EQ 1>
		
			<CFSET AuthorizedFlag = "Yes">
			
<!---        
<script>

<cfoutput>
alert('checkUserAtty.cfm at 202: AuthorizedFlag = "#AuthorizedFlag#"');
</cfoutput>

</script>
--->
            
            
            
            
            
			<CFQUERY NAME="Get_Atty_AssignedCounsel" DATASOURCE="contliab">
			
			SELECT LAWDEPARTMENT.PRIMARYKEY
			FROM LAWDEPARTMENT, LDEXTRA, CONTINGENT_LIAB_REPORT
			WHERE LAWDEPARTMENT.PRIMARYKEY = LDEXTRA.PRIMARYKEY
			
			AND (COUNSEL_LAW_DEPT = LAWDEPARTMENT.PRIMARYKEY
			OR COCOUNSEL_LAW_DEPT = LAWDEPARTMENT.PRIMARYKEY)
			
			AND (TITLE LIKE 'Managing Counsel%'
			OR TITLE LIKE 'Deputy Managing%'
			OR title LIKE 'Attorney%'
			OR title LIKE 'Chief%'
			OR title LIKE 'Senior Counsel%'
			OR title LIKE 'Senior Litigation%'
			OR title LIKE 'Program Manager%'
			OR title LIKE 'Executive Program%')
			
			AND (UPPER(AD_USERID) LIKE UPPER('#RespondingUser_Id#%')
			OR UPPER(AD_MAILNICKNAME) LIKE UPPER('#RespondingUser_Id#%'))
			
			AND 
			(
			LAWDEPARTMENT.SEPARATFLG != 'S' 
			OR 
			LAWDEPARTMENT.SEPARATFLG IS NULL 
			OR 
			LAWDEPARTMENT.SEPARATFLG = '0'
			)
			
			
			
			AND (COUNSEL_LAW_DEPT = #Get_Indiv_User.PRIMARYKEY#
			OR COCOUNSEL_LAW_DEPT = #Get_Indiv_User.PRIMARYKEY#)
			
			AND DATE_REPORT = to_date('#DateFormat(Get_LatestReportDate.DATE_REPORT_LATEST, "mm/dd/yyyy")#', 'mm/dd/yyyy')
			
			</cfquery>
			
		<!---
		<CFOUTPUT>
		Get_Atty_AssignedCounsel.RecordCount = #Get_Atty_AssignedCounsel.RecordCount#
		<P>
		</cfoutput>
		--->
		
		<CFELSE>
			<CFSET AuthorizedFlag = "No">
            
<!---        
<script>

<cfoutput>
alert('checkUserAtty.cfm at 265: AuthorizedFlag = "#AuthorizedFlag#"');
</cfoutput>

</script>
--->
            
            
            
            
            
		</cfif>
		
		
	</cfif>
	
	
</cfif>


<!---
<CFOUTPUT>
AuthorizedFlag = "#AuthorizedFlag#"
<p>
</cfoutput>
--->



<CFIF AuthorizedFlag EQ "Yes">

	<div id="ContingLiabLinks" style="font-family:arial; font-size:9pt; background:ffd5aa; padding:5pt; width:100%; height:20pt; margin-left:13pt">
	
	
	<li><i>See also</i> <b>Law Department Contingent Liabilities</b>

	<ul style="margin-top:0pt; margin-left:42pt" type="circle">

	<!---<li><a href="InsertRecord.cfm" target="_blank">Add New Case</a> [with Case Evaluation Checklist]--->
	
	
	<CFIF IsDefined("OfficeScope") OR (IsDefined("Get_Atty_AssignedCounsel.RecordCount") AND Get_Atty_AssignedCounsel.RecordCount GT 0)>

		<li><a href="Report.cfm" target="_blank">Current Report</a> [Current cases for which you are responsible]

		
	<CFELSE>
	
		<script language="javascript">
		
		parent.IFrameEeList.style.height = "45px";
		
		parent.IFrameEeList.style.marginBottom = "-12px";
		
		</script>
	
	</cfif>


<!---
https://lawdept.usps.gov/inhouse/framed/conting.liab.htm
--->

	<li><a href="https://lawdept.usps.gov/InHouse/conting.liab.htm" target="_top">Contingent Liability Protocol and Reference Materials</a>
		<!---KS 3.19.26 --->
	<!---<CFOUTPUT><li><a href="#CL_Protocol_URL#" target="_top">Contingent Liability Protocol and Reference Materials</a></CFOUTPUT>--->

	
	</div>

<CFELSE>

	<script language="javascript">
	parent.IFrameEeList.style.height = 0;
	parent.IFrameEeList.style.display = "none";
	</script>
	
</cfif>


