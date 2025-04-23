
<cfif cgi.SERVER_NAME neq "eagnmnss58b" AND CGI.SERVER_NAME NEQ "127.0.0.1">
<cfif not isdefined("cookie._mfa.authenticated_clrs")>
    <cfinvoke component="components/saml" method="doMfaInit">
        <cfinvokeargument name="relayPage" value="#getFileFromPath(getBaseTemplatePath())#">
        <cfinvokeargument name="queryString" value="#cgi.QUERY_STRING#">
    </cfinvoke>
</cfif>
</cfif>