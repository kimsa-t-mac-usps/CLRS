<cfset samlResponse = "#ProcessSAMLResponse("ContLiab_idp","ContLiab_sp")#">
<cfdump var="#samlResponse#">
<cfcookie name="_mfa.authenticated_clrs" value="#samlResponse.AUTHENTICATED#">
<cfcookie name="_mfa.nameid_clrs" value="#samlResponse.NAMEID#">
<cfcookie name="_mfa.nameidformat_clrs" value="#samlResponse.NAMEIDFORMAT#">
<cfcookie name="_mfa.sessionindex_clrs" value="#samlResponse.SESSIONINDEX#">
<cfcookie name="_mfa.relaystate_clrs" value="#samlResponse.RELAYSTATE#">
<cfinvoke component="appLog" method="createAppLogRecord">
    <cfinvokeargument name="authName" value="#samlResponse.NAMEID#">
    <cfinvokeargument name="authSessionId" value="#samlResponse.SESSIONINDEX#">
    <cfinvokeargument name="templatePath" value="#samlResponse.RELAYSTATE#">
    <cfinvokeargument name="appName" value="#application.appName#">
  </cfinvoke>
<cflocation url="../#urldecode(cookie._mfa.relaystate_clrs)#">

