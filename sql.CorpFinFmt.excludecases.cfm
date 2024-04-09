
<!--- Used in cfloop.cur_rem.casetype.assesscutoff.query.cfm --->

<CFOUTPUT>
<!--- Exclude cases "New This Quarter": --->

AND NOT
(

<!---
ASSESSMENT_AMOUNT >= 1000000
--->

(
clr.ASSESSMENT_AMOUNT >= #OneMillion#

<!---
OR
clr.ASSESSMENT_AMOUNT_UPPER >= #OneMillion#
--->

)

AND
clr.STATUS_CODE = 1
AND
clr.STATUS_CODE_SELECTED IS NULL
)


AND NOT
(

<!---
ASSESSMENT_AMOUNT >= 1000000
--->

(
clr.ASSESSMENT_AMOUNT >= #OneMillion#

<!---
OR
clr.ASSESSMENT_AMOUNT_UPPER >= #OneMillion#
--->

)

AND
clr.STATUS_CODE IS NULL
AND
clr.STATUS_CODE_SELECTED = '1'
)


<!--- Exclude Assess_Cutoff_List_Index EQ "MostLikelyUnder1Million_MaxReasonableOver1Million" --->
AND NOT
(

<!---
<CFIF Current_Removed_List_Index EQ "Removed">
CASE_TYPE < 11
AND
</CFIF>
--->



<!--- Exclude only Liabilities, not Receivables: --->

<CFIF Current_Removed_List_Index EQ "Removed">
clr.CASE_TYPE = 1
<CFELSE>
clr.CASE_TYPE IN (1,11)
</cfif>


AND

<!---
clr.ASSESSMENT_AMOUNT < #OneMillion#
--->

clr.ASSESSMENT_AMOUNT < #TenMillion#


AND
clr.ASSESSMENT_AMOUNT IS NOT NULL


AND
(
clr.ASSESSMENT_AMOUNT_UPPER >= #OneMillion#

AND
clr.ASSESSMENT_AMOUNT_UPPER IS NOT NULL


OR
(
clr.ASSESSMENT_AMT_UPPER_HIGH_END IS NOT NULL
AND
clr.ASSESSMENT_AMT_UPPER_HIGH_END >= #OneMillion#
)
)




)




<!--- Exclude cases from prev report below Corp Fin thresholds: --->
<!--- Query Get_PrevReport_CASE_REC_ID_SEQUENCE in application.cfm --->
AND 
clr.CASE_REC_ID_SEQUENCE NOT IN
(#ValueList(Get_PrevReport_CASE_REC_ID_SEQUENCE.CASE_REC_ID_SEQUENCE)#)



</CFOUTPUT>

