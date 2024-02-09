<cfinclude template="MfaCookieCheck.cfm">

<!-------------------- cfloop.cur_rem.casetype.assesscutoff.recct.cfm -------->
<!---------------------------------------------------------------------------->
<!--- KS1 --->
	<!---<CFOUTPUT>
		Program = "cfloop.cur_rem.casetype.assesscutoff.recct.cfm at 4"
	</CFOUTPUT>--->
	
<CFLOOP INDEX="Current_Removed_List_Index" LIST="#Current_Removed_List_Reverse#">

	<CFLOOP INDEX="Case_Type_List_Index" LIST="#Case_Type_List_Reverse#">
	
		<CFLOOP INDEX="Assess_Cutoff_List_Index" LIST="#Assess_Cutoff_List_Reverse#">
		
			<CFSET Last_CLRC_Query_Name = QueryNamePrefix & "_" & "CONTINGENT_LIAB_GetRecord_Current" & "_" & Current_Removed_List_Index & "_" & Case_Type_List_Index & "_" & Assess_Cutoff_List_Index>
			
			<CFSET Last_CLRC_Query_Name_RecCt = Last_CLRC_Query_Name & ".RecordCount">
			
			
			<CFIF IsDefined(Last_CLRC_Query_Name_RecCt) AND Evaluate(Last_CLRC_Query_Name_RecCt) GT 0>
				<CFBREAK>
			<!---    
			<CFELSE>
			
			<CFOUTPUT>
			<p>
			[#Last_CLRC_Query_Name_RecCt# = 0]
			<p>
			</CFOUTPUT>
			--->
			</cfif>
		
		</cfloop>
	
	
		<CFIF IsDefined(Last_CLRC_Query_Name_RecCt) AND Evaluate(Last_CLRC_Query_Name_RecCt) GT 0>
			<CFBREAK>
		<!---
		<CFELSE>
		
		<CFOUTPUT>
		<p>
		[#Last_CLRC_Query_Name_RecCt# = 0]
		<p>
		</CFOUTPUT>
		--->
		</cfif>
	
	</cfloop>
	
	
	<CFIF IsDefined(Last_CLRC_Query_Name_RecCt) AND Evaluate(Last_CLRC_Query_Name_RecCt) GT 0>
		<CFBREAK>
	<!---
	<CFELSE>
	
	<CFOUTPUT>
	<p>
	[#Last_CLRC_Query_Name_RecCt# = 0]
	<p>
	</CFOUTPUT>
	--->
	</cfif>

</cfloop>



