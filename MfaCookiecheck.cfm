
<cfif cgi.SERVER_NAME neq "lawdept-sit.usps.gov">
<cfif not isdefined("cookie._mfa.authenticated_clrs")>
    <cfinvoke component="components/saml" method="doMfaInit">
        <cfinvokeargument name="relayPage" value="#getFileFromPath(getBaseTemplatePath())#">
        <cfinvokeargument name="queryString" value="#cgi.QUERY_STRING#">
    </cfinvoke>
</cfif>
</cfif>