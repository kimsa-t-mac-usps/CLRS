<!--- Update Division on the ACTIVE Q3 record for S - Knoxville HIPP Training --->
<!--- Only runs when ?go=yes is in the URL --->
<cfif IsDefined("URL.go") AND URL.go EQ "yes">

    <cfquery name="UpdateDivision" datasource="contliab">
    UPDATE CONTINGENT_LIAB_REPORT
    SET DIVISION_CODE = 'Texas Division',
        DIVISION_NAME = 'Texas Division'
    WHERE PRIMARYKEY = 59614
    AND DELETED_FLAG IS NULL
    </cfquery>

    <h3 style="color:green">Done! Updated PK 59614 with DIVISION_CODE = 'Texas Division'</h3>
    <p><a href="Get_Single_Record.cfm?PRIMARYKEY=59614&ThisReportDate_Parm=06/30/2026&PrevReportDate_Parm=03/31/2026">View the record now</a></p>

<cfelse>
    <h3>This will update the ACTIVE Q3 record (PK 59614) for "S - Knoxville HIPP Training"</h3>
    <p>Set DIVISION_CODE = 'Texas Division' and DIVISION_NAME = 'Texas Division'</p>
    <p><a href="fix_division_59614.cfm?go=yes" style="color:red; font-weight:bold">Click here to run the update</a></p>
</cfif>
