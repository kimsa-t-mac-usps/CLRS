<cfinclude template="MfaCookieCheck.cfm">

<CFQUERY NAME="ActiveHolds_NotSentToICP" DATASOURCE="#ThisDataSource#">

/*
From SQL.ActiveHolds.NotSentToICP.20171205.b.xls
*/

SELECT distinct

trim(lawdept.office) AS "Office",
trim(initcap(matter.matter_name)) AS "Matter_Name",
trim(matter.matter_number) AS "Matter_Number",
matter.matter_key AS "Matter_Key",

mattertype.description AS "Case_Type",


to_char(cur_msg.preserv_time_start, 'yyyy/mm/dd') AS "Preservation_Start",

case cur_msg.preserv_time_end
when to_date('9999/12/31', 'yyyy/mm/dd') then '[Ongoing]'
else to_char(cur_msg.preserv_time_end, 'yyyy/mm/dd')
end "Preservation_End",

trim(lawdept.LASTNAME) || ', ' || trim(lawdept.FIRSTNAME) AS "Assigned_Primary",

lawdept.PRIMARYKEY AS "Assigned_Pkey",

case lawdept.SEPARATFLG
when 'S' then 'Former employee'
end "Assigned_Status"



FROM
LAWMANAGER.MATTER matter,

lawmanager.mattertype,

LIT_HOLD_NOTICES_REV notices
left outer join
LIT_HOLD_NOTICE_CUR_MSG cur_msg
on
cur_msg.LM_MATTER_KEY = notices.LM_MATTER_KEY
,

LIT_HOLD_NOTICES_RESPONSES_REV resp,

lawdepartment lawdept,

  (
  ldextra
  left outer join
  (
  lawmanager.personnel pers
  left outer join
  lawmanager.matterentity me
  on pers.object_key = me.entity_key
  )
  on
  (
  UPPER(pers.login_name) = Trim(UPPER(ldextra.AD_USERID))
  OR UPPER(pers.login_name) = ldextra.AD_MAILNICKNAME
  )
  )



WHERE

notices.PRIMARYKEY = resp.L_H_N_PKEY


and
not exists

(
select
resp_sub2.client_userid

from
LIT_HOLD_NOTICES_REV notices_sub2,
LIT_HOLD_NOTICES_RESPONSES_REV resp_sub2

where
resp_sub2.client_userid = 'RVFHH0'

and
resp_sub2.L_H_N_PKEY = notices_sub2.PRIMARYKEY

and
notices_sub2.LM_MATTER_KEY = matter.matter_key

/*
group by
matter.matter_key
*/

)



and
notices.LM_MATTER_KEY = matter.matter_key

and
me.matter_key = notices.lm_matter_key

and
lawdept.primarykey = ldextra.primarykey

and
matter.matter_type_key = mattertype.matter_type_key




/* LMRoles = ""1,2,44,46,91"" */

and
me.matter_entity_type_key IN (1, 2, 91)


/*
RPS_entity_key = 9997544299
*/

and
me.entity_key != 9997544299



and
resp.UNDO_FLAG IS NULL


and
notices.DELETED_FLAG IS NULL

AND
notices.DRAFT_FLAG = 0





/* Active Holds only */

and
notices.lm_matter_key IN
(
SELECT notices_sub.lm_matter_key
FROM LIT_HOLD_NOTICES_REV notices_sub, LIT_HOLD_NOTICES_RESPONSES_REV resp_sub
WHERE notices_sub.PRIMARYKEY = resp_sub.L_H_N_PKEY
and
notices_sub.lm_matter_key = matter.matter_key


group by
notices_sub.lm_matter_key

having
(
count(resp_sub.RELEASE_DATE_SENT) = 0
and
count(resp_sub.RELEASE_DONTSEND_FLAG) = 0
)

)




AND
ldextra.primarykey =
(
select MAX(primarykey)

from
ldextra ldx

where
ldx.AD_USERID = ldextra.AD_USERID
)



group by
lawdept.office,
matter.matter_name,
matter.matter_number,
matter.matter_key,
mattertype.description,


cur_msg.preserv_time_start,
cur_msg.preserv_time_end,

lawdept.LASTNAME,
lawdept.FIRSTNAME,
lawdept.PRIMARYKEY,
lawdept.SEPARATFLG


order by

/*
lawdept.office,
matter.matter_name,
matter.matter_number
*/

"Office",
"Matter Name",
"Matter Number"


</CFQUERY>



<div style="line-height:150%">


<CFLOOP QUERY="ActiveHolds_NotSentToICP">

<CFOUTPUT>


<li><a href="" onClick="Notice_Form_Matter_#Matter_Key#.submit(); return false" class="formlink">#Matter_Name#</a> 


<form name="Notice_Form_Matter_#Matter_Key#" method="post" action="form.cfm" style="margin-bottom:-10pt" target="_blank">

<!---
<input type="hidden" name="LIT_HOLD_MATTER_KEY" value="452153">
<input type="hidden" name="LIT_HOLD_MATTER_NAME" value="Collins, Morris R">
<input type="hidden" name="LIT_HOLD_MATTER_NUMBER" value="CM200945213">
<input type="hidden" name="LIT_HOLD_TypeDescription" value="EEOC">
--->


<input type="hidden" name="LIT_HOLD_MATTER_KEY" value="#Matter_Key#">
<input type="hidden" name="LIT_HOLD_MATTER_NAME" value="#Matter_Name#">
<input type="hidden" name="LIT_HOLD_MATTER_NUMBER" value="#Matter_Number#">
<input type="hidden" name="LIT_HOLD_TypeDescription" value="#Case_Type#">

<input type="hidden" name="Matter_Status_Flag" value="">
            
<input type="hidden" name="RespondingUser_Id" value="">
            			
<input type="hidden" name="EmailFormMode" value="">
	
<input type="hidden" name="FromTextSearchResults" value="">
    		
<input type="hidden" name="SearchText_Value" value="">
            
            
<!---
<input type="hidden" name="SelectedSender" value="334">
--->            


<input type="hidden" name="SelectedSender" value="#Assigned_Pkey#">
           
<input type="hidden" name="AutoSendToICP" value="yes">


</form>

</CFOUTPUT>


</CFLOOP>

</div>


