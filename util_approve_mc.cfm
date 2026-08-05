<cfinclude template="MfaCookieCheck.cfm">
<!--- Utility: Set CONCUR_MC = 1 for test cases. Delete this file after testing. --->

<h3>MC Approval Utility (Test Only)</h3>

<CFIF IsDefined("URL.go") AND URL.go EQ "yes">

	<CFQUERY NAME="ApproveAll" DATASOURCE="ContLiab">
	UPDATE CONTINGENT_LIAB_REPORT
	SET CONCUR_MC = 1
	WHERE DELETED_FLAG IS NULL
	AND CONCUR_MC IS NULL
	AND ROWNUM <= 20
	</CFQUERY>

	<p style="color:green; font-weight:bold">Done. Set CONCUR_MC = 1 for up to 20 cases.</p>

	<CFQUERY NAME="CheckCount" DATASOURCE="ContLiab">
	SELECT COUNT(*) AS CT FROM CONTINGENT_LIAB_REPORT
	WHERE DELETED_FLAG IS NULL AND CONCUR_MC = 1
	</CFQUERY>
	<CFOUTPUT><p>Total MC-approved cases now: #CheckCount.CT#</p></CFOUTPUT>

<CFELSEIF IsDefined("URL.undo") AND URL.undo EQ "yes">

	<CFQUERY NAME="UndoAll" DATASOURCE="ContLiab">
	UPDATE CONTINGENT_LIAB_REPORT
	SET CONCUR_MC = NULL
	WHERE CONCUR_MC = 1
	</CFQUERY>

	<p style="color:orange; font-weight:bold">Reverted. All CONCUR_MC set back to NULL.</p>

<CFELSE>

	<CFQUERY NAME="GetStatus" DATASOURCE="ContLiab">
	SELECT 
		COUNT(*) AS TOTAL_ACTIVE,
		SUM(CASE WHEN CONCUR_MC = 1 THEN 1 ELSE 0 END) AS MC_APPROVED
	FROM CONTINGENT_LIAB_REPORT
	WHERE DELETED_FLAG IS NULL
	</CFQUERY>

	<CFOUTPUT>
	<p>Active cases: #GetStatus.TOTAL_ACTIVE#</p>
	<p>MC-approved (CONCUR_MC=1): #GetStatus.MC_APPROVED#</p>
	</CFOUTPUT>

	<p><a href="util_approve_mc.cfm?go=yes">Approve 20 cases for MC (set CONCUR_MC=1)</a></p>
	<p><a href="util_approve_mc.cfm?undo=yes">Undo all MC approvals (revert to NULL)</a></p>

</CFIF>
