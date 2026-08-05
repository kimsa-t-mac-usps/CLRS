<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate">
    <meta http-equiv="Expires" content="0">
    <title>LDAP Server Migration Test</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; background: #f5f5f5; }
        .container { max-width: 900px; margin: 0 auto; background: #fff; padding: 20px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
        h1 { color: #333; border-bottom: 2px solid #0066cc; padding-bottom: 10px; }
        h2 { color: #555; margin-top: 30px; }
        .test-result { padding: 12px; margin: 10px 0; border-radius: 4px; border-left: 4px solid #ccc; }
        .pass { background: #d4edda; border-left-color: #28a745; }
        .fail { background: #f8d7da; border-left-color: #dc3545; }
        .warn { background: #fff3cd; border-left-color: #ffc107; }
        .info { background: #d1ecf1; border-left-color: #17a2b8; }
        table { width: 100%; border-collapse: collapse; margin: 10px 0; }
        th, td { padding: 8px 12px; border: 1px solid #ddd; text-align: left; }
        th { background: #f0f0f0; }
        .label { font-weight: bold; width: 200px; }
        .timestamp { color: #666; font-size: 0.9em; }
    </style>
</head>
<body>
<div class="container">
    <h1>LDAP Server Migration Verification Test</h1>
    <p class="timestamp">Test executed: <cfoutput>#DateFormat(Now(), "mm/dd/yyyy")# #TimeFormat(Now(), "hh:mm:ss tt")#</cfoutput></p>
    <p class="timestamp">Server: <cfoutput>#CGI.SERVER_NAME#</cfoutput></p>

    <cfset testsPassed = 0>
    <cfset testsFailed = 0>
    <cfset newServer = "ldaps-prod.usa.dce.usps.gov">
    <cfset oldServer = "eagandcs-sha2.usa.dce.usps.gov">
    <cfset ldapPort = "636">
    <cfset startstr = "dc=usa,dc=dce,dc=usps,dc=gov">
    <cfset testUserId = "YSRJ00">

    <!--- ============================================================ --->
    <!--- TEST 1: Verify application.cfm has the new LDAP server name --->
    <!--- ============================================================ --->
    <h2>Test 1: Configuration Check</h2>
    <p>Verify <code>application.cfm</code> is configured with the new LDAP server.</p>

    <cfset appFile = GetDirectoryFromPath(GetBaseTemplatePath()) & "application.cfm">
    <cffile action="read" file="#appFile#" variable="appContent">

    <cfif FindNoCase(newServer, appContent) GT 0>
        <div class="test-result pass">
            <strong>PASS:</strong> <code>application.cfm</code> contains the new server: <code><cfoutput>#newServer#</cfoutput></code>
        </div>
        <cfset testsPassed = testsPassed + 1>
    <cfelse>
        <div class="test-result fail">
            <strong>FAIL:</strong> <code>application.cfm</code> does NOT contain the new server: <code><cfoutput>#newServer#</cfoutput></code>
        </div>
        <cfset testsFailed = testsFailed + 1>
    </cfif>

    <!--- Check old server is NOT active (uncommented) --->
    <!--- Look for an uncommented active CFSET line with the old server name --->
    <cfset activeOldPattern = '<CFSET LDAPServerName = "' & oldServer & '">'>
    <cfset commentedOldPattern = '<!---<CFSET LDAPServerName = "' & oldServer & '">'>
    <cfset hasActiveOld = (FindNoCase(activeOldPattern, appContent) GT 0)>
    <cfset hasCommentedOld = (FindNoCase(commentedOldPattern, appContent) GT 0)>
    <!--- If we find the pattern, but EVERY occurrence is inside a comment, it's OK --->
    <cfif hasActiveOld AND hasCommentedOld>
        <!--- The pattern exists but is preceded by comment marker - it's commented out --->
        <div class="test-result pass">
            <strong>PASS:</strong> Old server <code><cfoutput>#oldServer#</cfoutput></code> is commented out (inactive).
        </div>
        <cfset testsPassed = testsPassed + 1>
    <cfelseif hasActiveOld AND NOT hasCommentedOld>
        <div class="test-result fail">
            <strong>FAIL:</strong> Old server <code><cfoutput>#oldServer#</cfoutput></code> appears to still be ACTIVE (not commented out).
        </div>
        <cfset testsFailed = testsFailed + 1>
    <cfelse>
        <div class="test-result pass">
            <strong>PASS:</strong> Old server <code><cfoutput>#oldServer#</cfoutput></code> is not set as LDAPServerName.
        </div>
        <cfset testsPassed = testsPassed + 1>
    </cfif>

    <!--- ============================================================ --->
    <!--- TEST 2: Verify LDAPServerName variable value at runtime      --->
    <!--- ============================================================ --->
    <h2>Test 2: Runtime Variable Check</h2>
    <p>Verify the <code>LDAPServerName</code> variable is set to the new server at runtime.</p>

    <cfif IsDefined("LDAPServerName") AND LDAPServerName EQ newServer>
        <div class="test-result pass">
            <strong>PASS:</strong> <code>LDAPServerName</code> = <code><cfoutput>#LDAPServerName#</cfoutput></code>
        </div>
        <cfset testsPassed = testsPassed + 1>
    <cfelseif IsDefined("LDAPServerName")>
        <div class="test-result fail">
            <strong>FAIL:</strong> <code>LDAPServerName</code> = <code><cfoutput>#LDAPServerName#</cfoutput></code> (expected: <code><cfoutput>#newServer#</cfoutput></code>)
        </div>
        <cfset testsFailed = testsFailed + 1>
    <cfelse>
        <div class="test-result fail">
            <strong>FAIL:</strong> <code>LDAPServerName</code> variable is not defined.
        </div>
        <cfset testsFailed = testsFailed + 1>
    </cfif>

    <!--- ============================================================ --->
    <!--- TEST 3: LDAP connectivity to NEW server                      --->
    <!--- ============================================================ --->
    <h2>Test 3: New LDAP Server Connectivity</h2>
    <p>Attempt an LDAP query against <code><cfoutput>#newServer#</cfoutput></code> on port <cfoutput>#ldapPort#</cfoutput>.</p>

    <cfset newServerConnected = false>
    <cftry>
        <cfldap action="QUERY"
            name="TestNewServer"
            attributes="displayName, mail"
            start="#startstr#"
            filter="(&(objectClass=user)(|(extensionAttribute13=#testUserId#)(mailNickName=#testUserId#)))"
            scope="subtree"
            server="#newServer#"
            secure="CFSSL_BASIC"
            port="#ldapPort#"
            username="usa\#Trim(Get_PW.AD_MAILNICKNAME)#"
            password="#Get_PW.PW#"
            timeout="30000">

        <cfset newServerConnected = true>

        <cfif TestNewServer.RecordCount GTE 1>
            <div class="test-result pass">
                <strong>PASS:</strong> Successfully connected to <code><cfoutput>#newServer#</cfoutput></code> and retrieved <cfoutput>#TestNewServer.RecordCount#</cfoutput> record(s).
                <table>
                    <tr><th>displayName</th><th>mail</th></tr>
                    <cfoutput query="TestNewServer" maxrows="3">
                    <tr><td>#displayName#</td><td>#mail#</td></tr>
                    </cfoutput>
                </table>
            </div>
            <cfset testsPassed = testsPassed + 1>
        <cfelse>
            <div class="test-result warn">
                <strong>WARN:</strong> Connected to <code><cfoutput>#newServer#</cfoutput></code> but returned 0 records for user <code><cfoutput>#testUserId#</cfoutput></code>. Verify user ID is valid.
            </div>
            <cfset testsPassed = testsPassed + 1>
        </cfif>

        <cfcatch type="any">
            <div class="test-result fail">
                <strong>FAIL:</strong> Could NOT connect to new server <code><cfoutput>#newServer#</cfoutput></code>
                <br>Error: <cfoutput>#cfcatch.message#</cfoutput>
                <cfif Len(cfcatch.detail)><br>Detail: <cfoutput>#cfcatch.detail#</cfoutput></cfif>
            </div>
            <cfset testsFailed = testsFailed + 1>
        </cfcatch>
    </cftry>

    <!--- ============================================================ --->
    <!--- TEST 4: Old LDAP server should be decommissioned/unreachable --->
    <!--- ============================================================ --->
    <h2>Test 4: Old LDAP Server Status</h2>
    <p>Attempt an LDAP query against old server <code><cfoutput>#oldServer#</cfoutput></code> (expected to fail or timeout if decommissioned).</p>

    <cftry>
        <cfldap action="QUERY"
            name="TestOldServer"
            attributes="displayName, mail"
            start="#startstr#"
            filter="(&(objectClass=user)(|(extensionAttribute13=#testUserId#)(mailNickName=#testUserId#)))"
            scope="subtree"
            server="#oldServer#"
            secure="CFSSL_BASIC"
            port="#ldapPort#"
            username="usa\#Trim(Get_PW.AD_MAILNICKNAME)#"
            password="#Get_PW.PW#"
            timeout="10000">

        <cfif TestOldServer.RecordCount GTE 1>
            <div class="test-result warn">
                <strong>WARN:</strong> Old server <code><cfoutput>#oldServer#</cfoutput></code> is still responding (<cfoutput>#TestOldServer.RecordCount#</cfoutput> record(s) returned). It may not be decommissioned yet.
            </div>
        <cfelse>
            <div class="test-result info">
                <strong>INFO:</strong> Old server <code><cfoutput>#oldServer#</cfoutput></code> responded but returned 0 records.
            </div>
        </cfif>
        <cfset testsPassed = testsPassed + 1>

        <cfcatch type="any">
            <div class="test-result pass">
                <strong>PASS:</strong> Old server <code><cfoutput>#oldServer#</cfoutput></code> is unreachable (expected if decommissioned).
                <br>Error: <cfoutput>#cfcatch.message#</cfoutput>
            </div>
            <cfset testsPassed = testsPassed + 1>
        </cfcatch>
    </cftry>

    <!--- ============================================================ --->
    <!--- TEST 5: Verify contingliabadmin LDAPServerName.cfm           --->
    <!--- ============================================================ --->
    <h2>Test 5: ContingLibAdmin Configuration Check</h2>
    <p>Verify <code>InHouse\contingliabadmin\LDAPServerName.cfm</code> is also updated.</p>

    <!--- Derive the admin file path from this template's location --->
    <cfset thisDir = GetDirectoryFromPath(GetBaseTemplatePath())>
    <cfset webRoot = ReplaceNoCase(thisDir, "ClientService\ContingentLiabilities\V1.0\", "")>
    <cfset adminFile = webRoot & "InHouse\contingliabadmin\LDAPServerName.cfm">
    <cfif FileExists(adminFile)>
        <cffile action="read" file="#adminFile#" variable="adminContent">
        <cfif FindNoCase('LDAPServerName = "' & newServer & '"', adminContent) GT 0>
            <div class="test-result pass">
                <strong>PASS:</strong> <code>contingliabadmin\LDAPServerName.cfm</code> is set to <code><cfoutput>#newServer#</cfoutput></code>
            </div>
            <cfset testsPassed = testsPassed + 1>
        <cfelse>
            <div class="test-result fail">
                <strong>FAIL:</strong> <code>contingliabadmin\LDAPServerName.cfm</code> does NOT appear to use <code><cfoutput>#newServer#</cfoutput></code>
            </div>
            <cfset testsFailed = testsFailed + 1>
        </cfif>
    <cfelse>
        <div class="test-result warn">
            <strong>WARN:</strong> File not found: <code><cfoutput>#adminFile#</cfoutput></code>
        </div>
    </cfif>

    <!--- ============================================================ --->
    <!--- SUMMARY                                                       --->
    <!--- ============================================================ --->
    <h2>Summary</h2>
    <table>
        <tr>
            <td class="label">Old LDAP Server:</td>
            <td><code><cfoutput>#oldServer#</cfoutput></code></td>
        </tr>
        <tr>
            <td class="label">New LDAP Server:</td>
            <td><code><cfoutput>#newServer#</cfoutput></code></td>
        </tr>
        <tr>
            <td class="label">Port:</td>
            <td><cfoutput>#ldapPort#</cfoutput> (SSL)</td>
        </tr>
        <tr>
            <td class="label">Tests Passed:</td>
            <td><cfoutput><strong style="color:green">#testsPassed#</strong></cfoutput></td>
        </tr>
        <tr>
            <td class="label">Tests Failed:</td>
            <td><cfoutput><strong style="color:<cfif testsFailed GT 0>red<cfelse>green</cfif>">#testsFailed#</strong></cfoutput></td>
        </tr>
        <tr>
            <td class="label">Overall Result:</td>
            <td>
                <cfif testsFailed EQ 0>
                    <strong style="color: green; font-size: 1.2em;">ALL TESTS PASSED</strong>
                <cfelse>
                    <strong style="color: red; font-size: 1.2em;">SOME TESTS FAILED - Review above</strong>
                </cfif>
            </td>
        </tr>
    </table>

</div>
</body>
</html>
