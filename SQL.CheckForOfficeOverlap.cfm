
<CFOUTPUT>


<!---
Check for HQ Corporate and Postal Business Law (45). If yes, include Corporate (23) and HQ Pricing and Product Development (25).
--->

<CFIF Get_Auth_User_Office.OFFICE_PRM_KEY EQ 45>

	AND (clr.LAW_DEPT_OFFICE IN (23, 25, #Get_Auth_User_Office.OFFICE_PRM_KEY#)
	OR clr.ALT_LAW_DEPT_OFFICE IN (23, 25, #Get_Auth_User_Office.OFFICE_PRM_KEY#))


<!---
Check for HQ Procurement and Property Law (50). If yes, include HQ Civil Practice (22).
--->

<CFELSEIF Get_Auth_User_Office.OFFICE_PRM_KEY EQ 50>

	AND (clr.LAW_DEPT_OFFICE IN (22, #Get_Auth_User_Office.OFFICE_PRM_KEY#)
	OR clr.ALT_LAW_DEPT_OFFICE IN (22, #Get_Auth_User_Office.OFFICE_PRM_KEY#))


<!---
Check for HQ Legal Strategy (55). If yes, include HQ Civil Practice (22) and HQ Pricing and Product Development (25).
--->

<CFELSEIF Get_Auth_User_Office.OFFICE_PRM_KEY EQ 55>

	AND (clr.LAW_DEPT_OFFICE IN (22, 25, #Get_Auth_User_Office.OFFICE_PRM_KEY#)
	OR clr.ALT_LAW_DEPT_OFFICE IN (22, 25, #Get_Auth_User_Office.OFFICE_PRM_KEY#))


<!---
Check for Northeast Windsor (16) or Northeast New York (7). If yes, include both.
--->

<CFELSEIF 
(
Get_Auth_User_Office.OFFICE_PRM_KEY EQ 7
OR
Get_Auth_User_Office.OFFICE_PRM_KEY EQ 16
)>

	AND (clr.LAW_DEPT_OFFICE IN (7, 16)
	OR clr.ALT_LAW_DEPT_OFFICE IN (7, 16))


<!---
Check for Southern (104). If yes, include Southeast (5) and Southwest (4).
--->

<CFELSEIF Get_Auth_User_Office.OFFICE_PRM_KEY EQ 104>

	AND (clr.LAW_DEPT_OFFICE IN (4, 5, #Get_Auth_User_Office.OFFICE_PRM_KEY#)
	OR clr.ALT_LAW_DEPT_OFFICE IN (4, 5, #Get_Auth_User_Office.OFFICE_PRM_KEY#))


<CFELSE>

	AND (clr.LAW_DEPT_OFFICE = #Get_Auth_User_Office.OFFICE_PRM_KEY#
	OR clr.ALT_LAW_DEPT_OFFICE = #Get_Auth_User_Office.OFFICE_PRM_KEY#)


</cfif>


</CFOUTPUT>

