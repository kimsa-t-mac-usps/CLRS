<!--- ============================================================
     Environment Configuration: LOCAL (developer workstation)
     ============================================================ --->

<!--- Base URL --->
<CFSET App_Base_URL = "http://127.0.0.1:8500">

<!--- LDAP Settings (same as DEV — requires network access) --->
<CFSET LDAPServerName = "eagandcs-sha2.usa.dce.usps.gov">
<CFSET ldap_secure = "CFSSL_BASIC">
<CFSET ldap_port = "636">
<CFSET startstr = "dc=usa,dc=dce,dc=usps,dc=gov">

<!--- File Upload / Spreadsheet Directories (local paths) --->
<CFSET Spreadsheets_Uploads_Dir = "c:\ColdFusion2023\cfusion\wwwroot\V1.0\Spreadsheets\">
<CFSET Spreadsheets_Uploads_Dir_URL = "/V1.0/Spreadsheets/">

<!--- Server List --->
<CFSET Sit_Server_List = "">

<!--- Default user ID for local dev when no Windows auth present --->
<CFSET Default_Dev_User_Id = "YSRJ00">

<!--- Environment identifier --->
<CFSET Environment_Name = "LOCAL">
