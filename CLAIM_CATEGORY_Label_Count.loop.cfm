
<!------------------------- CLAIM_CATEGORY_Label_Count.loop.cfm -------------->
<!---------------------------------------------------------------------------->
<!--- KS1 --->
	<!---<CFOUTPUT>
		Program = "CLAIM_CATEGORY_Label_Count.loop.cfm at 4"
	</CFOUTPUT>--->
	
<CFLOOP CONDITION="(CLAIM_CATEGORY_Label_Count NEQ ThisCLAIM_CATEGORY) AND (CLAIM_CATEGORY_Label_Count LE CLAIM_CATEGORY_Label_List_Len) AND (HeaderParm EQ 'TopIndex')">



	<CFIF NOT
	(
	IsDefined("SelectedCategory")
	AND
	SelectedCategory NEQ "ALL"
	)>
	
		<p>
		
		
		<CFIF HeaderParm EQ "TopIndex">
			<CFSET CheckFlag = "no">
			<h5 style="color:gray; position:relative; left:15pt; font-weight:normal; font-size:9pt">
		<CFELSE>
			<h5 style="color:gray">
		</cfif>
		
		<CFOUTPUT>
		[#ListGetAt(CLAIM_CATEGORY_Label_List, CLAIM_CATEGORY_Label_Count)#]</h5>
		</cfoutput>
    
	</cfif>


	<CFIF CLAIM_CATEGORY_Label_Count EQ CLAIM_CATEGORY_Label_List_Len>
		<CFBREAK>
	</cfif>
	
	
	<CFSET CLAIM_CATEGORY_Label_Count = CLAIM_CATEGORY_Label_Count + 1>


</cfloop>


