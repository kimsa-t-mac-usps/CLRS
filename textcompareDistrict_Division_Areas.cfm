<cfinclude template="MfaCookieCheck.cfm">

<cfset ThisNewList = NewList>
<cfset ThisOldList = OldList>
<cfset This_AREA_NAME = This_AREA_NAME>
<cfset PREV_AREA_NAME = PREV_AREA_NAME>


<cfset ThisSelectDistrict = SelectDistrict>

<CFSET DiffFlag = "yes">
<!---<CFoutput></cfoutput>--->
<!---<CFoutput><span> old district:   #ThisOldList# </span></cfoutput><br>
<CFoutput><span> new district #ThisNewList# </span></cfoutput><br>
<CFoutput><span> new area  #This_AREA_NAME# </span></cfoutput><br>
<CFoutput><span> old area #PREV_AREA_NAME# </span></cfoutput><br>--->
<!--- SelectDistrict equals "no" comes from report.ptc<CFoutput><span> sd #ThisSelectDistrict# </span></cfoutput>--->

<CFIF ThisNewList eq ThisOldList>
	<!---<cfoutput>true statement</cfoutput>--->
	<cfset newDistrict =ThisNewList>
<cfelse>
	<!---<cfoutput><strong>#ThisNewList#</strong></cfoutput>--->
	<cfset newDistrict ="<strong>" & ThisNewList & "</strong>">
</cfif>

<CFIF This_AREA_NAME eq PREV_AREA_NAME>
	<!---<cfoutput>true statement</cfoutput>--->
	<cfset newAreaName = This_AREA_NAME>
<cfelse>
	<!---<cfoutput><strong>#This_AREA_NAME#</strong></cfoutput>--->
	<cfset newAreaName = "<strong>" & This_AREA_NAME & "</strong>">
</cfif>

<cfset ThisNewList = newDistrict & " District (" & newAreaName & ")">
<cfoutput>#ThisNewList#</cfoutput>
