<cfinclude template="MfaCookieCheck.cfm">

<!---
Included in cfloop.cur_rem.casetype.assesscutoff.query.cfm, Report.ptA.cfm
--->


<!---
(
clr.ASSESSMENT_AMT_UPPER_HIGH_END >= #FiveMillion#

or
(
clr.ASSESSMENT_AMOUNT_UPPER >= #FiveMillion#
and
clr.ASSESSMENT_AMOUNT is null
and 
clr.ASSESSMENT_AMT_UNKNOWN = 1
)

OR
(
clr.ASSESSMENT_AMT_UPPER_HIGH_END IS NULL 
AND 
clr.ASSESSMENT_AMOUNT_UPPER >= #FiveMillion#
)
OR
(
clr.ASSESSMENT_AMOUNT_UPPER IS NULL 
AND 
(
clr.ASSESSMENT_AMT_HIGH_END >= #FiveMillion#
OR
(
clr.ASSESSMENT_AMT_HIGH_END IS NULL 
AND 
clr.ASSESSMENT_AMOUNT >= #FiveMillion#
)
)
)
)
--->


<!---
clr.ASSESSMENT_AMOUNT >= #FiveMillion#
--->


<!---
clr.ASSESSMENT_AMOUNT >= <cfqueryparam cfsqltype="numeric" value="#FiveMillion#">
--->


clr.ASSESSMENT_AMOUNT >= <cfqueryparam cfsqltype="numeric" value="#TenMillion#"> 
<!---clr.ASSESSMENT_AMOUNT >= <cfqueryparam cfsqltype="numeric" value="#TenMillion#"> OR clr.ASSESSMENT_AMT_HIGH_END >= <cfqueryparam cfsqltype="numeric" value="#TenMillion#">--->





