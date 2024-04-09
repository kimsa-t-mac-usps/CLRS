

<!--- Query Get_Districts in appllcation.cfm. Area, District lists NO LONGER in areas.districts.arrays.cfm --->

<!---
<CFSET Districts_Array = ArrayNew(2)>
<CFSET Districts_Array_Ct = 0>
--->



<CFIF 
(
IsDefined("DropdownList")
AND
DropdownList EQ "District"
)
OR
(
NOT IsDefined("DropdownList")
AND
Get_Districts.RecordCount GT 0
)>

	
	<CFSET Prev_This_District_Code = "">
	
<!---	
	<option value="Multiple // MULTIPLE Districts" >MULTIPLE Districts 
--->	
	
	<!---
	Query Get_Districts in application.cfm
	--->
	
	
	<CFLOOP QUERY="Get_Districts">
	
	
		<CFSET This_District_Code = DIST_PERF_CLUSTER_CODE>
		<CFSET This_District_Name = NAME>
		<CFSET This_District_Area = AREA_CODE>
	
       	<CFIF This_District_Code EQ "">
        	<CFSET This_District_Code = This_District_Name>
        </CFIF>
    
	
		<CFIF This_District_Code NEQ Prev_This_District_Code>
	
			<CFSET Prev_This_District_Code = This_District_Code>
	
			<CFIF IsDefined("This_DIST_PERF_CLUSTER_CODE") AND This_DIST_PERF_CLUSTER_CODE EQ This_District_Code>
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


<!---
<CFELSEIF DropdownList EQ "Division"
AND
Get_Divisions.RecordCount GT 0>
--->


<CFELSEIF 
(
IsDefined("DropdownList")
AND
DropdownList EQ "Division"
)
OR
(
NOT IsDefined("DropdownList")
AND
Get_Divisions.RecordCount GT 0
)>


<!---    
    <CFIF This_Division_Code EQ "Multiple">

		<CFSET SelectedWord = "SELECTED">
		
	<CFELSE>
		
	  	<CFSET SelectedWord = "">

	</CFIF>


	<option value="Multiple" #SelectedWord#>MULTIPLE Divisions
--->        

	<CFLOOP QUERY="Get_Divisions">


		<CFSET This_Division_Name = NAME>

<!---
		<CFIF IsDefined("DIVISION_CODE") 
		AND 
		IsDefined("This_Division_Code")
		AND
		DIVISION_CODE EQ This_Division_Code>
	    
			<CFSET SelectedWord = "SELECTED">
		
		<CFELSE>
		
	    	<CFSET SelectedWord = "">
		
		</cfif>
--->


		<CFIF 
		(
		IsDefined("SelectedPC") 
		AND 
		SelectedPC EQ This_Division_Name
		)
		OR
		(
		IsDefined("This_Division_Code")
		AND
		This_Division_Code EQ This_Division_Name
		)>
	    
			<CFSET SelectedWord = "SELECTED">
		
		<CFELSE>
		
	    	<CFSET SelectedWord = "">
		
		</cfif>








	
		<CFOUTPUT>

<!---
		<option value="#DIVISION_CODE#" #SelectedWord#>#DIVISION_CODE#
--->	


		<option value="#DIVISION_CODE#" #SelectedWord#>#NAME#

		</CFOUTPUT>
    
    
	</CFLOOP>


</CFIF>

