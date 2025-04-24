<cfinclude template="MfaCookieCheck.cfm">

<!---
Included in cfloop.cur_rem.casetype.assesscutoff.query.cfm, Report.ptA.cfm
--->


<!---

(

(
clr.ASSESSMENT_AMT_UPPER_HIGH_END IS NULL
OR
clr.ASSESSMENT_AMT_UPPER_HIGH_END < #FiveMillion#
)

AND

(
clr.ASSESSMENT_AMOUNT_UPPER IS NULL
OR
clr.ASSESSMENT_AMOUNT_UPPER < #FiveMillion#
)

AND

(
clr.ASSESSMENT_AMT_HIGH_END IS NULL
OR
clr.ASSESSMENT_AMT_HIGH_END < #FiveMillion#
)

AND

(
clr.ASSESSMENT_AMOUNT IS NULL
OR
clr.ASSESSMENT_AMOUNT < #FiveMillion#
)

)

--->


(
--line 46 tenmillion.below.cfm 

clr.ASSESSMENT_AMOUNT IS NULL

OR

<!---
clr.ASSESSMENT_AMOUNT < #FiveMillion#
--->


<!---
clr.ASSESSMENT_AMOUNT < <cfqueryparam cfsqltype="numeric" value="#FiveMillion#">
--->

<!---KS Updated Above HightEnd  --->
clr.ASSESSMENT_AMOUNT < <cfqueryparam cfsqltype="numeric" value="#TenMillion#"> 
AND clr.ASSESSMENT_AMOUNT NOT IN (5100000) AND clr.ASSESSMENT_AMOUNT_UPPER NOT IN (63000000)
<!---KS20250422 --->
<!---AND clr.ASSESSMENT_AMOUNT_UPPER NOT IN (10100000)--->
 


<!---(
    (clr.ASSESSMENT_AMOUNT_UPPER < <cfqueryparam cfsqltype="numeric" value="#TenMillion#"> 
		OR clr.ASSESSMENT_AMOUNT_UPPER IN (10100000))
    OR
    (clr.ASSESSMENT_AMOUNT_UPPER < <cfqueryparam cfsqltype="numeric" value="#TenMillion#"> 
		OR clr.ASSESSMENT_AMOUNT_UPPER IN (200900000))
)--->		


AND (clr.ASSESSMENT_AMOUNT_UPPER >= <cfqueryparam cfsqltype="numeric" value="#OneMillion#">)

AND (clr.ASSESSMENT_AMT_HIGH_END is null OR clr.ASSESSMENT_AMT_HIGH_END < <cfqueryparam cfsqltype="numeric" value="#TenMillion#">)

)




