
<!---
<CFQUERY NAME="Get_TestUser_Pkey" DATASOURCE="contliab">
SELECT TESTUSER_PKEY
FROM TEST_USER
WHERE SETTINGUSER_PKEY = #Init_Check_Auth_User_A.USERPRMKEY#
</cfquery>
--->

<CFQUERY NAME="Get_TestUser_Name" DATASOURCE="contliab">
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
			<cflog text="Line 31: ThisEEName: #ThisEEName#" type="information" file="clrs-ldap">

<CFELSE>

	<cfset RespondingUser_Id = TRIM(UCASE(RemoveChars(cgi.auth_user,1,find('\',cgi.auth_user))))>

	<CFQUERY NAME="Get_Ee_ThisUser" DATASOURCE="contliab" result="check_EE_This_User">
	SELECT Trim(LAWDEPARTMENT.LASTNAME) || ', ' || Trim(LAWDEPARTMENT.FIRSTNAME) AS FULLNAME
	FROM LAWDEPARTMENT, LDEXTRA
	WHERE
	LAWDEPARTMENT.PRIMARYKEY = LDEXTRA.PRIMARYKEY
	
	AND (LAWDEPARTMENT.SEPARATFLG != 'S' OR LAWDEPARTMENT.SEPARATFLG IS NULL OR LAWDEPARTMENT.SEPARATFLG = '0')
	
	AND (UPPER(AD_USERID) LIKE UPPER('#RespondingUser_Id#%')
	OR UPPER(AD_MAILNICKNAME) LIKE UPPER('#RespondingUser_Id#%'))
	</cfquery>
		<cflog text="Line 48: Init_Check_Auth_User_A: #serializeJson(check_EE_This_User)#" type="information" file="clrs-ldap">

<!---
<CFOUTPUT>
Get_Ee_ThisUser.RecordCount = #Get_Ee_ThisUser.RecordCount#
<p>
</cfoutput>
--->

	<CFIF Get_Ee_ThisUser.RecordCount EQ 1>
		<CFSET ThisEEName = Trim(Get_Ee_ThisUser.FULLNAME)>
	</cfif>
		<cflog text="Line 60: ThisEEName: #ThisEEName#"  type="information" file="clrs-ldap">
	
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

