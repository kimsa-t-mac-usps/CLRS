<cfinclude template="MfaCookieCheck.cfm">

<!------------------------- Report.CorpFinTableHeaderRow.cfm ----------------->
<!---------------------------------------------------------------------------->
<!--- KS1 --->
	<!---<CFOUTPUT>
		Program = "Report.CorpFinTableHeaderRow.cfm at 4"
	</CFOUTPUT>--->

	<tr class="CorpFin">
	
	<th class="CorpFinCaseName" style="width:170pt">
	Case Name
	
	<th class="CorpFinCaseNumber">
	Case Number
	
	<th class="CorpFinAmtSought" style="width:15pt">
	Amount Sought
	
<!---
	<th class="CorpFin">
	Liability Assessment / Damages Assessment
--->

	<th class="CorpFin" style="width:15pt">
	Liability
	Assessment
    
	<th class="CorpFin" style="width:40pt">
    Damages
	Assessment



	<th class="CorpFin">
	Status





    
<!--- If Liability (1) or Receivable (2) Removed (+10 = 11 or 12), show outcome --->
	<CFIF CASE_TYPE EQ 11 OR CASE_TYPE EQ 12>

<!---
	<th class="CorpFin">
	Status
--->

	<th class="CorpFin" style="width:30pt">
	Payout Amount
	
	<th class="CorpFin" style="width:30pt">
	Payout Date


	<CFELSE>
    
   	<th class="CorpFin" style="width:15pt">
	Estimated Time&nbsp;to Resolution


	</cfif>



	<CFIF IsDefined("MC_Name")
	AND
	MC_Name NEQ "">

	<th class="CorpFin" style="width:70pt">

	Approving
    Managing&nbsp;Counsel

	</cfif>
    	

	</tr>
	


