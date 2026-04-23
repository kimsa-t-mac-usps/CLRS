<cfinclude template="MfaCookieCheck.cfm">

<!--- HQ Department lists in areas.districts.arrays.cfm --->
<!---
<CFSET HQ_Array = ArrayNew(2)>
<CFSET HQ_Array_Ct = 0>
--->

<!---
<CFLOOP INDEX="AllHQLists_Index" LIST="#AllHQLists#">

<CFFLUSH interval=10>

<CFSET ThisHQ_Array_List = Evaluate(AllHQLists_Index)>

<CFSET HQ_Array_Ct = HQ_Array_Ct + 1>

<CFSET ThisListArray = ListToArray(ThisHQ_Array_List)>

<CFSET HQ_Array[HQ_Array_Ct] = ThisListArray>

<CFSET This_HQ_Code = HQ_Array[HQ_Array_Ct][1]>
<CFSET This_HQ_Name = HQ_Array[HQ_Array_Ct][2]>
--->

<CFIF IsDefined("This_HQ_AREA_NAME") 
AND 
This_HQ_AREA_NAME EQ "HQ MULTIPLE Departments">

	<CFSET HQMultSelectedWord = "SELECTED">
		<CFELSE>
	<CFSET HQMultSelectedWord = "">

</CFIF>

<CFOUTPUT>
<option value="Multiple // HQ MULTIPLE Departments" #HQMultSelectedWord#>HQ MULTIPLE Departments 
</cfoutput>

<!---
<option value="Mult // HQ MULTIPLE Departments" >HQ MULTIPLE Departments 
--->

<CFLOOP QUERY="Get_HQ">

	<CFSET This_HQ_Code = AREA_CODE>
	<CFSET This_HQ_Name = NAME>


	<CFIF IsDefined("This_HQ_AREA_NAME") AND This_HQ_AREA_NAME EQ This_HQ_Name>
		<CFSET SelectedWord = "SELECTED">
	<CFELSE>
		<CFSET SelectedWord = "">
	</cfif>

	<CFOUTPUT>
	<option value="#This_HQ_Code# // #This_HQ_Name#" #SelectedWord#>#This_HQ_Name# 
	</CFOUTPUT>

</cfloop>


