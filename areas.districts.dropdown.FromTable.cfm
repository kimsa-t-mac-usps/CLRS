<cfinclude template="MfaCookieCheck.cfm">

<CFIF (IsDefined("DropdownList") AND DropdownList EQ "District") OR (NOT IsDefined("DropdownList") AND Get_Districts.RecordCount GT 0 )>
	
			<CFSET Prev_This_District_Code = "">
	
	<CFLOOP QUERY="Get_Districts">	
		<CFSET This_District_Code = DIST_PERF_CLUSTER_CODE>
		<CFSET This_District_Name = NAME>
		<CFSET This_District_Area = AREA_CODE>
		
		<CFIF This_District_Code EQ "">
        	<CFSET This_District_Code = This_District_Name>
			
        </CFIF>

		<CFIF This_District_Code NEQ Prev_This_District_Code>
			
			<CFSET Prev_This_District_Code = This_District_Code>
			<CFIF IsDefined("prev_dist_perf_cluster_code") AND prev_dist_perf_cluster_code EQ This_District_Code>
				<CFSET SelectedWord = "SELECTED">
			<CFELSE>
				<CFSET SelectedWord = "">
			</cfif>
			
			<CFSET This_District_Area_Option = "">
			<CFSET This_District_Area_Option_Area_Name = "">
			<CFIF This_District_Area NEQ "Multiple" AND This_District_Area NEQ "ALL">
				<CFLOOP QUERY="Get_Areas">
					<CFIF This_District_Area EQ AREA_CODE>
						<CFSET This_District_Area_Option = " || " & This_District_Area & " && " & NAME>
						<CFSET This_District_Area_Option_Area_Name = "(" & NAME & ")">
						<CFBREAK>
					</cfif>
				</CFLOOP>
			</cfif>
			<CFIF This_District_Name CONTAINS "MULTIPLE">
				<CFSET This_District_DropdownEntry = This_District_Name>            
			<CFELSE>
                <CFSET This_District_DropdownEntry = This_District_Name & " District">
 			</CFIF>
	
			<CFOUTPUT>
			<option value="#This_District_Code# // #This_District_Name##This_District_Area_Option#" #SelectedWord#>#This_District_DropdownEntry# #This_District_Area_Option_Area_Name#
			</CFOUTPUT>
	
		</CFIF>
	
	</cfloop>


<CFELSEIF (IsDefined("DropdownList") AND DropdownList EQ "Division" ) OR (NOT IsDefined("DropdownList") AND Get_Divisions.RecordCount GT 0 )>
	
	<CFLOOP QUERY="Get_Divisions">
		<CFSET This_Division_Name = NAME>
		<CFIF (IsDefined("SelectedPC") AND SelectedPC EQ This_Division_Name ) OR (IsDefined("This_Division_Code") AND This_Division_Code EQ This_Division_Name) OR (isdefined("prev_DIVISION_CODE") and prev_division_code eq This_division_name)>
			<CFSET SelectedWord = "SELECTED">
		<CFELSE>
			<CFSET SelectedWord = "">
		</cfif>
	<CFOUTPUT>
		<option value="#DIVISION_CODE#" #SelectedWord#>#NAME#</OPTION>
	</CFOUTPUT>
	</CFLOOP>
</CFIF>


