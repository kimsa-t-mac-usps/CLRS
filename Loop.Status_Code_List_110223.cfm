

<CFLOOP INDEX="Status_Code_List_Index" LIST="#STATUS_CODE_SELECTED#">

<!---	
	<!--- If final disposition (Status_Code_List_Index GE 11), show only final disposition status: --->
	<CFIF 
	(
	(CASE_TYPE EQ 11 OR CASE_TYPE EQ 12)
	AND
	Status_Code_List_Index GE 11
	)
	OR
	NOT 
	(CASE_TYPE EQ 11 OR CASE_TYPE EQ 12)>
	
		
		<CFSET Status_Code_Var = Status_Code_List_Index>
		<CFINCLUDE TEMPLATE="cfswitch.status_code.cfm">
		
		<CFIF Status_Code_Var NEQ 2>
			<CFSET Status_Code_Label = "<strong>" & Status_Code_Label & "</strong>">
		</CFIF>
		
	
	
    
		<CFOUTPUT>
		<li>#Status_Code_Label#
		</cfoutput>

    
	</cfif>
--->	


	<CFSET Status_Code_Var = Status_Code_List_Index>
	<CFINCLUDE TEMPLATE="cfswitch.status_code.cfm">
		
	<CFIF Status_Code_Var NEQ 2>
		<CFSET Status_Code_Label = "<strong>" & Status_Code_Label & "</strong>">
	</CFIF>
		
    
	<CFOUTPUT>
	<li>#Status_Code_Label#</li>
	</cfoutput>



	
	<CFIF NOT (
	(IsDefined("Form.CorpFinFormat") AND Form.CorpFinFormat EQ "CorpFinFormat")
	OR
	(IsDefined("Form.FrontOffcReviewFormat") AND Form.FrontOffcReviewFormat EQ "FrontOffcReviewFormat")
	OR
	(IsDefined("Form.CorpFinFormat_STL") AND Form.CorpFinFormat_STL EQ "CorpFinFormat_STL")
	)>
	
	
		<CFIF IsDefined("ThresholdStatus")
		AND
		ThresholdStatus EQ "Below"
		AND
		IsDefined("Status_Code_Var")
		AND
		Status_Code_Var EQ 4>
		
			<div style="background:maroon; color:white; font-weight:bold; padding:2pt">
			Incorrect Status selected: Assessment is <i>below</i> reporting threshold. Please select appropriate Status.
			</div>
		
		</cfif>
		
	
	</cfif>


</cfloop>



