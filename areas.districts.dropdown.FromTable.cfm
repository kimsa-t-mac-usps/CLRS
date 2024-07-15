<cfinclude template="MfaCookieCheck.cfm">


<CFIF (IsDefined("DropdownList") AND DropdownList EQ "District") OR (NOT IsDefined("DropdownList") AND Get_Districts.RecordCount GT 0 )>
	<cflog text="@@@@@ this is first if @@@@@" type="information" file="clrs_adddft">
	
	<CFSET Prev_This_District_Code = "">

	<CFLOOP QUERY="Get_Districts">	
		<CFSET This_District_Code = DIST_PERF_CLUSTER_CODE>
		<CFSET This_District_Name = NAME>
		<CFSET This_District_Area = AREA_CODE>
		<cflog text="@@ This_District_Code: #This_District_Code#" type="information" file="clrs_adddft">
		<cflog text="@@ This_District_Name: #This_District_Name#" type="information" file="clrs_adddft">
		<cflog text="@@ This_District_Area: #This_District_Area#" type="information" file="clrs_adddft">
		<CFIF This_District_Code EQ "">
        	<CFSET This_District_Code = This_District_Name>
			<cflog text="$$ This_District_Code: #This_District_Code#" type="information" file="clrs_adddft">
        </CFIF>
			
    
	<cflog text="Prev_This_District_code: #Prev_This_District_Code#" type="information" file="clrs_adddft">
		<CFIF This_District_Code NEQ Prev_This_District_Code>
			<cflog text="this_district_code does not equal prev_this_district_code" type="information " file="clrs_adddft">
			<CFSET Prev_This_District_Code = This_District_Code>
			<CFIF IsDefined("This_DIST_PERF_CLUSTER_CODE") AND This_DIST_PERF_CLUSTER_CODE EQ This_District_Code>
				<cflog text="This_DIST_PERF_CLUSTER_CODE: #THIS_DIST_PERF_CLUSTER_CODE#" type="information" file="clrs_adddft">
				<CFSET SelectedWord = "SELECTED">
			<CFELSE>
				<CFSET SelectedWord = "">
			</cfif>
			<cflog text="-----SELECTEDWORD: #SelectedWord#" type="information" file="clrs_adddft">
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
		<CFIF (IsDefined("SelectedPC") AND SelectedPC EQ This_Division_Name ) OR (IsDefined("This_Division_Code") AND This_Division_Code EQ This_Division_Name)>
			<CFSET SelectedWord = "SELECTED">
		<CFELSE>
			<CFSET SelectedWord = "">
		</cfif>
	<CFOUTPUT>
		<option value="#DIVISION_CODE#" #SelectedWord#>#NAME#
	</CFOUTPUT>
	</CFLOOP>
</CFIF>


