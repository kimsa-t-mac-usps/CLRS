
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
clr.ASSESSMENT_AMOUNT IS NULL
OR

<!---
clr.ASSESSMENT_AMOUNT < #FiveMillion#
--->


<!---
clr.ASSESSMENT_AMOUNT < <cfqueryparam cfsqltype="numeric" value="#FiveMillion#">
--->


clr.ASSESSMENT_AMOUNT < <cfqueryparam cfsqltype="numeric" value="#TenMillion#">


)



