<cfinclude template="MfaCookieCheck.cfm">

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
<title>Concurrence for Report</title>
</head>

<body>

<!--- Moved to application.cfm: 
<CFSET todayDate = Now()>
<CFSET todayDateFmt = DateFormat(todayDate, "mm/dd/yyyy")>
--->

<CFIF IsDefined("Form.ConcurUser")>

	<CFQUERY NAME="Upd_CONTINGENT_LIAB_Concur" DATASOURCE="lddb">
	
	UPDATE CONTINGENT_LIAB_REPORT
	
	SET
	
	<CFIF Form.ConcurUser EQ 1>
	CONCUR_MC = 1,
	CONCUR_MC_DATE = to_date('#todayDateFmt#', 'mm/dd/yyyy'),
	CONCUR_MC_USER_ID = '#Form.RespondingUser_Id#'
	<CFELSE>
	CONCUR_ALT = 1,
	CONCUR_ALT_DATE = to_date('#todayDateFmt#', 'mm/dd/yyyy'),
	CONCUR_ALT_USER_ID = '#Form.RespondingUser_Id#'
	</cfif>
	
	WHERE PRIMARYKEY = #Form.RecID#
	
	</cfquery>
	
	
	<!---
	<CFOUTPUT>
	<form name="ReturnForm" METHOD="POST" ACTION="Report.cfm###Form.RecID#">
	</cfoutput>
	</form>
	--->
	
	
	
	
	
	
	<CFIF IsDefined("Form.RecordDisplay_Parm") AND Form.RecordDisplay_Parm EQ "Single"
	AND 
	IsDefined("Form.ThisReportDate_Parm") AND Form.ThisReportDate_Parm NEQ ""
	AND
	IsDefined("Form.PrevReportDate_Parm") AND Form.PrevReportDate_Parm NEQ "">
	
		<CFSET ReturnFormAction_ThisReportDate_Parm = Form.ThisReportDate_Parm>
		<CFSET ReturnFormAction_PrevReportDate_Parm = Form.PrevReportDate_Parm>
	
	<CFELSEIF IsDefined("RecordDisplay_Parm")
	AND 
	IsDefined("ThisReportDate_Parm")
	AND
	IsDefined("PrevReportDate_Parm")>
	
		<CFSET ReturnFormAction_ThisReportDate_Parm = ThisReportDate_Parm>
		<CFSET ReturnFormAction_PrevReportDate_Parm = PrevReportDate_Parm>
	
	</cfif>
	
	
	<CFIF IsDefined("ReturnFormAction_ThisReportDate_Parm") AND IsDefined("ReturnFormAction_PrevReportDate_Parm")>
	
		<CFOUTPUT>
			<form name="ReturnForm" METHOD="POST" ACTION="Get_Single_Record.cfm?PRIMARYKEY=#Form.RecID#&ThisReportDate_Parm=#ReturnFormAction_ThisReportDate_Parm#&PrevReportDate_Parm=#ReturnFormAction_PrevReportDate_Parm#">
			</form>
		</cfoutput>
	
	<CFELSE>
	
		<CFOUTPUT>
			<form name="ReturnForm" METHOD="POST" ACTION="Report.cfm###Form.RecID#">
			</form>
		</cfoutput>
	
	</CFIF>
	
	
	
	
	
	<script language="javascript">
	ReturnForm.submit();
	</script>
	
<CFELSE>
	
	<script language="javascript">
	alert("Form error.")
	</script>

</cfif>


</body>
</html>


</body>
</html>



