<cfif cgi.SERVER_NAME neq "eagnmnss58b">
<cfif not isdefined("session.mfa_clrs.authenticated")>
    <cfinvoke component="components\saml" method="doMfaInit">
        <cfinvokeargument name="relayPage" value="#getFileFromPath(getBaseTemplatePath())#">
        <cfinvokeargument name="queryString" value="#cgi.QUERY_STRING#">
    </cfinvoke>
</cfif>
</cfif>