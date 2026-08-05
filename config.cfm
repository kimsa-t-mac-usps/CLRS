<!--- ============================================================
     config.cfm — Environment Config Loader
     
     Auto-detects the current environment based on CGI.SERVER_NAME
     and includes the appropriate config_[env].cfm file.
     
     Include this file early in application.cfm:
         <CFINCLUDE TEMPLATE="config.cfm">
     ============================================================ --->

<CFSET detectedServerName = LCase(CGI.SERVER_NAME)>

<CFIF detectedServerName EQ "127.0.0.1" OR detectedServerName EQ "localhost">
    <!--- LOCAL developer workstation --->
    <CFINCLUDE TEMPLATE="config_local.cfm">

<CFELSEIF FindNoCase("sit", detectedServerName) GT 0
      OR detectedServerName EQ "eagnmnwbd203"
      OR detectedServerName EQ "eagnmnwbd204">
    <!--- SIT Environment --->
    <CFINCLUDE TEMPLATE="config_sit.cfm">

<CFELSEIF FindNoCase("cat", detectedServerName) GT 0
          OR detectedServerName EQ "eagnmnwbd205"
          OR detectedServerName EQ "eagnmnwbd206">
    <!--- CAT Environment --->
    <CFINCLUDE TEMPLATE="config_cat.cfm">

<CFELSE>
    <!--- Default: DEV (localhost, dev server, or unrecognized) --->
    <CFINCLUDE TEMPLATE="config_dev.cfm">

</CFIF>

<!--- Derived URLs (shared across all environments) --->
<CFSET CL_Protocol_URL = App_Base_URL & "/inhouse/framed/conting.liab.htm">
