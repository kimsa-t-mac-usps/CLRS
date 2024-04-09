

<!--- Check whether user authorized to access CL system and scope of authorization: Department-wide, Office-wide, case-only, or none --->

<!--- Included separately in Report.ptA.cfm, InsertRecord.cfm, EditRecord.cfm --->

<CFSET AuthorizedFlag = "No">

<!---
<script>

<cfoutput>
alert('CheckUserAuth.cfm at 11: AuthorizedFlag = "#AuthorizedFlag#"');
</cfoutput>

</script>
--->






<!---
CONTINGENT_LIAB_AUTH = 'A' = Full Access
CONTINGENT_LIAB_AUTH = 'I' = Input Access (for inputting new Conting Liab case records)
--->


<!---
<CFQUERY NAME="Check_Auth_User_A" DATASOURCE="ContLiab">
SELECT USERPRMKEY
FROM BUSINESSSERVUSERS a, LDEXTRA b
WHERE a.USERPRMKEY = b.PRIMARYKEY
AND (a.CONTINGENT_LIAB_AUTH = 'A' OR a.CONTINGENT_LIAB_AUTH = 'I')
AND (UPPER(b.AD_USERID) LIKE UPPER('#RespondingUser_Id#%')
OR UPPER(b.AD_MAILNICKNAME) LIKE UPPER('#RespondingUser_Id#%'))
</cfquery>
--->


<CFINCLUDE TEMPLATE="Query.Check_Auth_User_A.cfm">

<!---
<script>

<cfoutput>
alert('CheckUserAuth.cfm at 46: Check_Auth_User_A.RecordCount = "#Check_Auth_User_A.RecordCount#"');
</cfoutput>

</script>
--->




<CFIF Check_Auth_User_A.RecordCount EQ 1>
	<CFSET AuthorizedFlag = "Yes">
	<CFSET OfficeScope = "All Law Department Offices">


<!---
<script>

<cfoutput>
alert('CheckUserAuth.cfm at 51: AuthorizedFlag = "#AuthorizedFlag#"');
</cfoutput>

</script>
--->



<CFELSE>


	<CFQUERY NAME="Get_Auth_User_PRMKEY" DATASOURCE="ContLiab">
	
	SELECT USERPRMKEY, CONTINGENT_LIAB_AUTH
	
	FROM BUSINESSSERVUSERS a, LDEXTRA b
	WHERE a.USERPRMKEY = b.PRIMARYKEY
	
	AND (a.CONTINGENT_LIAB_AUTH = 'O' OR a.CONTINGENT_LIAB_AUTH = 'B' OR a.CONTINGENT_LIAB_AUTH = 'T')
	
	AND (UPPER(b.AD_USERID) LIKE UPPER('#RespondingUser_Id#%')
	OR UPPER(b.AD_MAILNICKNAME) LIKE UPPER('#RespondingUser_Id#%'))
	
	</cfquery>
	

<!---
<script>

<cfoutput>
alert('CheckUserAuth.cfm at 95: Get_Auth_User_PRMKEY.RecordCount = "#Get_Auth_User_PRMKEY.RecordCount#"');
</cfoutput>

</script>
--->

	
	<CFIF Get_Auth_User_PRMKEY.RecordCount EQ 1>
	
		<CFSET AuthorizedFlag = "Yes">
	
<!---    
<script>

<cfoutput>
alert('CheckUserAuth.cfm at 85: AuthorizedFlag = "#AuthorizedFlag#"');
</cfoutput>

</script>
--->    
    
    
    
		<CFSET ThisCONTINGENT_LIAB_AUTH = Get_Auth_User_PRMKEY.CONTINGENT_LIAB_AUTH>

<!---
CONTINGENT_LIAB_AUTH = 'O' = Office-wide Authorization
CONTINGENT_LIAB_AUTH = 'B' = Business Claim cases only (St. Louis)
CONTINGENT_LIAB_AUTH = 'T' = Tort Claim cases only (St. Louis)
--->


		<CFQUERY NAME="Get_Auth_User_Office" DATASOURCE="ContLiab">
		
		SELECT DISTINCT
        
        b.OFFICE_PRM_KEY, trim(b.OFFICE) AS OFFICE
		
		FROM LAWDEPARTMENT a, LDOFFICES b
		
		WHERE 


		(
        
        (
        trim(a.OFFICE) = trim(b.OFFICE)
		AND
		trim(a.OFFICE) != 'General Law Service Center'
		)
        
		OR

		(
		trim(a.OFFICE) = 'General Law Service Center'
        
<!---        
        AND
        trim(a.ALTERNOFFC) IS NULL
--->		
		
        AND
        trim(b.OFFICE) = 'National Tort Center'
		)

		)


        and
        b.DELETE_FLAG IS NULL
        
		AND a.PRIMARYKEY = (SELECT USERPRMKEY
		
		FROM BUSINESSSERVUSERS c, LDEXTRA d
		WHERE c.USERPRMKEY = d.PRIMARYKEY
		
		AND (c.CONTINGENT_LIAB_AUTH = 'O' OR c.CONTINGENT_LIAB_AUTH = 'B' OR c.CONTINGENT_LIAB_AUTH = 'T')
		
		AND (UPPER(d.AD_USERID) LIKE UPPER('#RespondingUser_Id#%')
		OR UPPER(d.AD_MAILNICKNAME) LIKE UPPER('#RespondingUser_Id#%')))
		
		</cfquery>


<!---
<CFOUTPUT>
<p></p>
CheckUserAuth.cfm at 89:
<br />


Get_Auth_User_Office.RecordCount = #Get_Auth_User_Office.RecordCount#
<p></p>


Get_Auth_User_Office.OFFICE = "#Get_Auth_User_Office.OFFICE#"
<br />

Get_Auth_User_Office.OFFICE_PRM_KEY = #Get_Auth_User_Office.OFFICE_PRM_KEY#

</CFOUTPUT>


<cfabort>
--->



		<CFIF Get_Auth_User_Office.RecordCount EQ 1>
		
			<CFIF Trim(Get_Auth_User_Office.OFFICE) CONTAINS "General Law">

				<CFSET OfficeScope = "National Tort Center">

			<CFELSE>

				<CFSET OfficeScope = Trim(Get_Auth_User_Office.OFFICE)>

	   		</CFIF>

<!---
<CFOUTPUT>
<br />
OfficeScope = "#OfficeScope#"
<p>
</CFOUTPUT>
--->

<!---
<CFABORT>
--->


			<CFSET DefaultOffice = Get_Auth_User_Office.OFFICE_PRM_KEY>
		
		    <CFQUERY NAME="Find_Office_Concur" DATASOURCE="ContLiab">
        
<!---        
			SELECT b.USERPRMKEY
	        FROM LAWDEPARTMENT a, BUSINESSSERVUSERS b
	        WHERE a.PRIMARYKEY = b.USERPRMKEY
			AND b.CONTINGENT_LIAB_CONCUR = 2
	        AND a.OFFICE LIKE '#OfficeScope#%'
		
        
        
        FROM LAWDEPARTMENT a, LDOFFICES b
		

<!---
        trim(a.OFFICE) = trim(b.OFFICE)
--->
        
        (
        trim(a.OFFICE) = trim(b.OFFICE)
        OR
		trim(a.OFFICE) = trim(b.OFFCOLD)
        )

--->		
        
			SELECT bususers.USERPRMKEY

	        FROM 
            LAWDEPARTMENT lawdept, 
            LDOFFICES,
            BUSINESSSERVUSERS bususers

	        WHERE 
            lawdept.PRIMARYKEY = bususers.USERPRMKEY
			
            AND 
            bususers.CONTINGENT_LIAB_CONCUR = 2
	        
            AND
            (
             
            (
	        trim(lawdept.OFFICE) = trim(LDOFFICES.OFFICE)
			AND
            trim(lawdept.OFFICE) LIKE '#OfficeScope#%'
            )
        	OR
			(
			trim(lawdept.OFFICE) = trim(LDOFFICES.OFFCOLD)
			AND
            trim(LDOFFICES.OFFCOLD) LIKE '#OfficeScope#%'
            )
        
        	)
        
			</cfquery>
		
		
			<CFIF Left(OfficeScope, 9) EQ "Southeast">
				<CFSET OfficeScope = "Southeast">
			</cfif>
		
		<!--- Close <CFIF Get_Auth_User_Office.RecordCount EQ 1> --->
		</cfif>


<!--- from <CFIF Get_Auth_User_PRMKEY.RecordCount EQ 1> --->
	<CFELSE>

		<CFQUERY NAME="Get_Indiv_User" DATASOURCE="ContLiab">
        
<!---        
		SELECT a.PRIMARYKEY, a.OFFICE, b.OFFICE_PRM_KEY
--->


		SELECT DISTINCT
        a.PRIMARYKEY, a.OFFICE, b.OFFICE_PRM_KEY


		FROM LAWDEPARTMENT a, LDOFFICES b, LDEXTRA c

		WHERE a.PRIMARYKEY = c.PRIMARYKEY
<!---
		AND a.OFFICE = b.OFFICE
--->

<!---
		and
		trim(a.OFFICE) = trim(b.OFFICE)
--->


		AND
        (
        trim(a.OFFICE) = trim(b.OFFICE)
        OR
		trim(a.OFFICE) = trim(b.OFFCOLD)
        )
		

        and
        b.DELETE_FLAG IS NULL


		AND (a.TITLE LIKE 'Managing Counsel%'
		OR a.TITLE LIKE 'Deputy Managing%'
		OR a.title LIKE 'Attorney%'
		OR a.title LIKE 'Chief%'
		OR a.title LIKE 'Senior Counsel%'
		OR a.title LIKE 'Senior Litigation%'
		OR a.title LIKE 'Program Manager%'
		OR a.title LIKE 'Executive Program%')
		
		AND 
		(
		UPPER(c.AD_USERID) LIKE UPPER('#RespondingUser_Id#%')
		OR 
		UPPER(c.AD_MAILNICKNAME) LIKE UPPER('#RespondingUser_Id#%')
		)
		
		AND 
		(
		a.SEPARATFLG != 'S' 
		OR 
		a.SEPARATFLG IS NULL 
		OR 
		a.SEPARATFLG = '0'
		)
		
		
		</cfquery>
		

<!---
<CFOUTPUT>
<p>
CheckUserAuth.cfm at 369:
<br />
Get_Indiv_User.RecordCount = #Get_Indiv_User.RecordCount#
<p>

</CFOUTPUT>

<cfabort>
--->




		<CFIF Get_Indiv_User.RecordCount EQ 1>

<!--- ThisReportDate set in Report.ptA.cfm --->



<!--- HQ ELL = Office # 24 --->

<!--- Crx 1/31/2011: OfficeScope set for ELL attys, but Get_Indiv_User_Cases record set is indiv assigned cases only. If ELL atty (non-mgr,	 non-BUSINESSSERV table user) has case in system, Report shows all ELL, not just indiv cases. If ELL atty does not have case in system, redirect NotAuthorized.cfm --->


			<CFIF Get_Indiv_User.OFFICE_PRM_KEY EQ 24>
				<CFSET OfficeScope = Trim(Get_Indiv_User.OFFICE)>
			</cfif>
			
			
			<CFIF NOT (IsDefined("ThisPage") AND ThisPage EQ "InsertRecord")>
	
    
<!---            
<CFOUTPUT>    		
--->				
            
				<CFQUERY NAME="Get_Indiv_User_Cases" DATASOURCE="ContLiab">
				
				
				SELECT PRIMARYKEY
				FROM CONTINGENT_LIAB_REPORT
				WHERE DATE_REPORT = to_date('#DateFormat(ThisReportDate, "mm/dd/yyyy")#', 'mm/dd/yyyy')


<!---
<CFIF Get_Indiv_User.OFFICE_PRM_KEY EQ 24>
AND (LAW_DEPT_OFFICE = #Get_Indiv_User.OFFICE_PRM_KEY#
OR ALT_LAW_DEPT_OFFICE = #Get_Indiv_User.OFFICE_PRM_KEY#)
<CFELSE>
AND (COUNSEL_LAW_DEPT = #Get_Indiv_User.PRIMARYKEY#
OR COCOUNSEL_LAW_DEPT = #Get_Indiv_User.PRIMARYKEY#)
</cfif>
--->


				AND 
				(COUNSEL_LAW_DEPT = #Get_Indiv_User.PRIMARYKEY#
				OR COCOUNSEL_LAW_DEPT = #Get_Indiv_User.PRIMARYKEY#)
				
				</cfquery>


<!---
</CFOUTPUT>                
                
<cfabort>
--->



<!---
<script>

<cfoutput>
alert('CheckUserAuth.cfm at 288: Get_Indiv_User_Cases.RecordCount = "#Get_Indiv_User_Cases.RecordCount#"');
</cfoutput>

</script>
--->



                
				
				<CFIF Get_Indiv_User_Cases.RecordCount GT 0>
					<CFSET AuthorizedFlag = "Yes">
				    
<!---                
<script>

<cfoutput>
alert('CheckUserAuth.cfm at 290: AuthorizedFlag = "#AuthorizedFlag#"');
</cfoutput>

</script>
--->
                    
                    
                    
                    
				<CFELSEIF Get_Indiv_User_Cases.RecordCount EQ 0 AND IsDefined("EarlierRptDate")>
					<CFSET AuthorizedFlag = "Yes">
				
<!---            
<script>

<cfoutput>
alert('CheckUserAuth.cfm at 306: AuthorizedFlag = "#AuthorizedFlag#"');
</cfoutput>

</script>
--->
                
                
				</cfif>


<!--- Close <CFIF NOT (IsDefined("ThisPage") AND ThisPage EQ "InsertRecord")> --->
			</CFIF>

<!--- Close <CFIF Get_Indiv_User.RecordCount EQ 1> --->
		</cfif>

<!--- Close <CFIF Get_Auth_User_PRMKEY.RecordCount EQ 1> --->
	</cfif>

<!---
<CFOUTPUT>
<p>
Get_Indiv_User.RecordCount = #Get_Indiv_User.RecordCount#
<p>
AuthorizedFlag = "#AuthorizedFlag#"

</CFOUTPUT>


<cfabort>
--->







	<CFIF 
	NOT 
	(
	IsDefined("ThisPage") 
	AND 
	ThisPage EQ "InsertRecord"
	) 
	OR 
	(
	IsDefined("ThisPage") 
	AND 
	ThisPage EQ "InsertRecord" 
	AND 
	IsDefined("Get_Indiv_User.RecordCount") 
	AND 
	Get_Indiv_User.RecordCount NEQ 1
	)>

		<CFIF AuthorizedFlag EQ "No">
<!---    
<script>

<cfoutput>
alert('CheckUserAuth.cfm at 367: AuthorizedFlag = "#AuthorizedFlag#"');
</cfoutput>

</script>
--->
    

			<script language="javascript">
			location.href = 'NotAuthorized.cfm';
			</script>

            
            
            
		</cfif>

	</cfif>

</cfif>



