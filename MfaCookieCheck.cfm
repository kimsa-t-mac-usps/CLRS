<cfif cgi.SERVER_NAME neq "eagnmnss58b">
<cfif not isdefined("cookie._mfa.authenticated_clrs")>
    <cfinvoke component="components\saml" method="doMfaInit">
        <cfinvokeargument name="relayPage" value="#getFileFromPath(getBaseTemplatePath())#">
        <cfinvokeargument name="queryString" value="#cgi.QUERY_STRING#">
    </cfinvoke>
</cfif>
</cfif>