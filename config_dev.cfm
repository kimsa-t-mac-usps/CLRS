<!--- ============================================================
     Environment Configuration: DEV
     ============================================================ --->

<!--- Base URL --->
<CFSET App_Base_URL = "https://lawdept1-dev.usps.gov">

<!--- LDAP Settings --->
<CFSET LDAPServerName = "ldaps-prod.usa.dce.usps.gov">
<CFSET ldap_secure = "CFSSL_BASIC">
<CFSET ldap_port = "636">
<CFSET startstr = "dc=usa,dc=dce,dc=usps,dc=gov">

<!--- File Upload / Spreadsheet Directories --->
<CFSET Spreadsheets_Uploads_Dir = "\\eagnmnwbd203\wwwroot2\ClientService\DocUploadsFromCF2018\Doc.ContingentLiabilities\Spreadsheets\">
<CFSET Spreadsheets_Uploads_Dir_URL = "/ClientService/DocUploadsFromCF2018/Doc.ContingentLiabilities/Spreadsheets/">

<!--- Server List (used for auth bypass in CheckUserAuth.cfm, SetUserID.TestUser.cfm) --->
<CFSET Sit_Server_List = "">

<!--- Default user ID for local dev when no Windows auth present --->
<CFSET Default_Dev_User_Id = "YSRJ00">

<!--- Environment identifier --->
<CFSET Environment_Name = "DEV">
