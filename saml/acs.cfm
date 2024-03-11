<cfset samlResponse = "#ProcessSAMLResponse("ContLiab_idp","ContLiab_sp")#">
<cfdump var="#samlResponse#">
<cfcookie name="_mfa.authenticated_clrs" value="#samlResponse.AUTHENTICATED#" expires="#dateAdd('n',20,now())#">
<cfcookie name="_mfa.nameid_clrs" value="#samlResponse.NAMEID#" expires="#dateAdd('n',20,now())#">
<cfcookie name="_mfa.nameidformat_clrs" value="#samlResponse.NAMEIDFORMAT#" expires="#dateAdd('n',20,now())#">
<cfcookie name="_mfa.sessionindex_clrs" value="#samlResponse.SESSIONINDEX#" expires="#dateAdd('n',20,now())#">
<cfcookie name="_mfa.relaystate_clrs" value="#samlResponse.RELAYSTATE#" expires="#dateAdd('n',20,now())#">
<cfinvoke component="appLog" method="createAppLogRecord">
    <cfinvokeargument name="authName" value="#samlResponse.NAMEID#">
    <cfinvokeargument name="authSessionId" value="#samlResponse.SESSIONINDEX#">
    <cfinvokeargument name="templatePath" value="#samlResponse.RELAYSTATE#">
    <cfinvokeargument name="appName" value="#application.appName#">
  </cfinvoke>
<cflocation url="../#urldecode(cookie._mfa.relaystate_clrs)#">

