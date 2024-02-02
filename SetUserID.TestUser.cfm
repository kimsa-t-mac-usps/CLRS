<!---
<CFQUERY NAME="Get_TestUser_Pkey" DATASOURCE="lddb">
SELECT TESTUSER_PKEY
FROM TEST_USER
WHERE SETTINGUSER_PKEY = #Init_Check_Auth_User_A.USERPRMKEY#
</cfquery>
--->

<CFQUERY NAME="Get_TestUser_Name" DATASOURCE="lddb">
SELECT LDEXTRA.AD_USERID, Trim(LAWDEPARTMENT.LASTNAME) || ', ' || Trim(LAWDEPARTMENT.FIRSTNAME) AS FULLNAME
FROM LAWDEPARTMENT, LDEXTRA
WHERE
LAWDEPARTMENT.PRIMARYKEY = LDEXTRA.PRIMARYKEY

AND (LAWDEPARTMENT.SEPARATFLG != 'S' OR LAWDEPARTMENT.SEPARATFLG IS NULL OR LAWDEPARTMENT.SEPARATFLG = '0')

AND LAWDEPARTMENT.PRIMARYKEY =

(SELECT TESTUSER_PKEY
FROM TEST_USER
WHERE SETTINGUSER_PKEY = #Init_Check_Auth_User_A.USERPRMKEY#)

</cfquery>


<CFIF Get_TestUser_Name.RecordCount EQ 1>

	<cfset RespondingUser_Id = Trim(UCase(Get_TestUser_Name.AD_USERID))>
	<CFSET ThisEEName = Trim(Get_TestUser_Name.FULLNAME)>

<CFELSE>

	<cfset RespondingUser_Id = TRIM(UCASE(RemoveChars(auth_user,1,find('\',auth_user))))>

	<CFQUERY NAME="Get_Ee_ThisUser" DATASOURCE="lddb">
	SELECT Trim(LAWDEPARTMENT.LASTNAME) || ', ' || Trim(LAWDEPARTMENT.FIRSTNAME) AS FULLNAME
	FROM LAWDEPARTMENT, LDEXTRA
	WHERE
	LAWDEPARTMENT.PRIMARYKEY = LDEXTRA.PRIMARYKEY
	
	AND (LAWDEPARTMENT.SEPARATFLG != 'S' OR LAWDEPARTMENT.SEPARATFLG IS NULL OR LAWDEPARTMENT.SEPARATFLG = '0')
	
	AND (UPPER(AD_USERID) LIKE UPPER('#RespondingUser_Id#%')
	OR UPPER(AD_MAILNICKNAME) LIKE UPPER('#RespondingUser_Id#%'))
	</cfquery>

<!---
<CFOUTPUT>
Get_Ee_ThisUser.RecordCount = #Get_Ee_ThisUser.RecordCount#
<p>
</cfoutput>
--->

	<CFIF Get_Ee_ThisUser.RecordCount EQ 1>
		<CFSET ThisEEName = Trim(Get_Ee_ThisUser.FULLNAME)>
	</cfif>
	
</cfif>


<CFIF UCase(Init_User_Id) NEQ UCase(RespondingUser_Id)>

<!---	<CFOUTPUT>
<!---
<span style="font-size:8pt">[Display for User: #ThisEEName#]</span>

<br />
"#UCase(Init_User_Id)#"
"#UCase(RespondingUser_Id)#"

<p>
--->

	<div SetUserID.TestUser.cfm style="font-size:8pt">[Display for User: #ThisEEName#]</div>

	</cfoutput>--->

</cfif>
