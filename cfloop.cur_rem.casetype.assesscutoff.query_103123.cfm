<cfinclude template="MfaCookieCheck.cfm">

<!----------------- cfloop.cur_rem.casetype.assesscutoff.query.cfm ----------->
<!---------------------------------------------------------------------------->
<!--- KS --->
	<!---<CFOUTPUT>
		<br />
		Program = "cfloop.cur_rem.casetype.assesscutoff.query.cfm at 4"
		<br />
	</CFOUTPUT>--->

<!--- Settings for ranges in queries for assessments in case categories --->

<!---

Most Likely Payout Range:
ASSESSMENT_AMOUNT
ASSESSMENT_AMT_HIGH_END

Maximum Reasonable Payout Range:
ASSESSMENT_AMOUNT_UPPER
ASSESSMENT_AMT_UPPER_HIGH_END


ASSESSMENT_PROBABILITY 
=1:Probable, =2:Reas Possible, =3:Remote



5/21/09 Changed SQL references to 5000000 cutoff: Use ASSESSMENT_AMOUNT instead of ASSESSMENT_AMOUNT_UPPER


7/9/09 Changed SQL references to 5000000 cutoff: Use ASSESSMENT_AMOUNT or ASSESSMENT_AMT_HIGH_END or ASSESSMENT_AMOUNT_UPPER or ASSESSMENT_AMT_UPPER_HIGH_END instead of ASSESSMENT_AMOUNT alone



Same CFLOOP bypasses in:
-- cfloop.cur_rem.casetype.assesscutoff.query.cfm
-- cfloop.cur_rem.casetype.assesscutoff.output.cfm
-- Report.TopIndexDiv.cfloops.cfm

--->

<!---
See CFSET Assess_Cutoff_List in Report.ptA.cfm, Report.TopIndexDiv.cfm
--->

<!--- KS1 --->
<!---<CFOUTPUT>
		<br />
		Program = "cfloop.cur_rem.casetype.assesscutoff.query.cfm at 46"
		<br />
		Current_Removed_List = #Current_Removed_List#
		<br />
		<!---Current_Removed_List_Index = #Current_Removed_List_Index#
		<br />--->
		Case_Type_List	= #Case_Type_List#
		<br />
		Assess_Cutoff_List = #Assess_Cutoff_List#
		<br />
	</CFOUTPUT>--->



	
<!--- Included in Report.ptA.cfm --->

<CFLOOP INDEX="Current_Removed_List_Index" LIST="#Current_Removed_List#">

	<CFLOOP INDEX="Case_Type_List_Index" LIST="#Case_Type_List#">

		<CFSET Skip_Assess_Cutoff_List = "no">

		<CFIF Skip_Assess_Cutoff_List EQ "no">

			<CFLOOP INDEX="Assess_Cutoff_List_Index" LIST="#Assess_Cutoff_List#">

				<CFIF Current_Removed_List_Index EQ "New">

					<CFIF Assess_Cutoff_List_Index EQ "NewTenMillionAndAbove" OR Assess_Cutoff_List_Index EQ "MostLikelyUnderTenMillion_MaxReasonableOverOneMillion">
		
						<CFSET Skip_CLRC_Query = "no">
		
			        <CFELSE>
        
   						<CFSET Skip_CLRC_Query = "yes">
		
					</CFIF>

				<CFELSEIF Current_Removed_List_Index EQ "Removed">
					<!---KS---<CFIF Assess_Cutoff_List_Index EQ "TenMillionAndAbove" OR Assess_Cutoff_List_Index EQ "MostLikelyUnderTenMillion_MaxReasonableOverOneMillion">--->
					<CFIF Assess_Cutoff_List_Index EQ "TenMillionAndAbove" 
						OR Assess_Cutoff_List_Index EQ "MostLikelyUnderTenMillion_MaxReasonableOverOneMillion"
							OR Assess_Cutoff_List_Index EQ "UnderTenMillion">
		
						<CFSET Skip_CLRC_Query = "no">
		
			        <CFELSE>
        
   						<CFSET Skip_CLRC_Query = "yes">
		
					</CFIF>
	
				<CFELSEIF Assess_Cutoff_List_Index EQ "NewTenMillionAndAbove">
      
					<CFSET Skip_CLRC_Query = "yes">

    			<CFELSE>
    
					<CFSET Skip_CLRC_Query = "no">

				</cfif>

    
				<CFIF Skip_CLRC_Query EQ "no">

<!---
<CFSET Current_Removed_List_Index = "New">
<CFSET Case_Type_List_Index = "Liabilities">
<CFSET Assess_Cutoff_List_Index = "New1MillionAndAbove">
--->

					<CFSET CLRC_Query_Name = QueryNamePrefix & "_" & "CONTINGENT_LIAB_GetRecord_Current" & "_" & Current_Removed_List_Index & "_" & Case_Type_List_Index & "_" & Assess_Cutoff_List_Index>



<!--- KS2 --->
<!---<CFOUTPUT>
		<br />
		Program = "cfloop.cur_rem.casetype.assesscutoff.query.cfm at 125"
		<br />
		Current_Removed_List = #Current_Removed_List#
		<br />
		<!---Current_Removed_List_Index = #Current_Removed_List_Index#
		<br />--->
		Case_Type_List	= #Case_Type_List#
		<br />
		Assess_Cutoff_List = #Assess_Cutoff_List#
		<br />
	</CFOUTPUT>--->





<!---
<p>
In cfloop.cur_rem.casetype.assesscutoff.query.cfm at 100:
<br />

<CFOUTPUT>
CLRC_Query_Name = "#CLRC_Query_Name#"
</CFOUTPUT>

<p>



<CFOUTPUT>
--->

	
					<CFQUERY NAME="#CLRC_Query_Name#" DATASOURCE="lddb">

					SELECT

					clr.PRIMARYKEY,
					clr.CASE_NAME,
					clr.CASE_NUMBER,
					clr.LM_MATTER_NUMBER,
					clr.LM_MATTER_KEY,
					clr.CASE_TYPE,
					clr.CLAIM_CATEGORY,
					clr.DATE_FILED,
					clr.DATE_FILED_UNKNOWN,
					clr.AMOUNT_SOUGHT,
					clr.AMOUNT_SOUGHT_UPPER,
					clr.AMOUNT_SOUGHT_UNKNOWN,
					clr.ASSESSMENT_PROBABILITY,
					clr.ASSESSMENT_AMOUNT,
					clr.ASSESSMENT_AMT_HIGH_END,
					clr.ASSESSMENT_AMOUNT_UPPER,
					clr.ASSESSMENT_AMT_UPPER_HIGH_END,
					clr.ASSESSMENT_AMT_UNKNOWN,
					clr.ASSESSMENT_AMT_MAX_UNKNOWN,
					clr.STATUS,
					clr.STATUS_CODE,
					clr.STATUS_CODE_SELECTED,
					clr.FIELD_GRIEVANCE_FLAG,
					clr.NATL_GATS_NUMBER,
					clr.PAYOUT_AMOUNT,
					clr.PAYOUT_LT_100K,
					clr.PAYOUT_DATE,
					clr.PAYOUT_DATE_NA,
					clr.AREA_NAME,
					clr.AREA_CODE,
					clr.DIST_PERF_CLUSTER_NAME,
					clr.DIST_PERF_CLUSTER_CODE,

					clr.DIVISION_CODE,

					clr.UNIONS_SELECTED,

					clr.SHORT_TERM_LIABILITY,
					clr.COUNSEL_LAW_DEPT,
					clr.COCOUNSEL_LAW_DEPT,
					clr.COUNSEL_OTHER,
					clr.LAW_DEPT_OFFICE,
					clr.ALT_LAW_DEPT_OFFICE,
					clr.FACTS_POSITIONS_LONG,
					clr.DATE_LAST_UPDATE,
					clr.LAST_UPDATE_USER_ID,
					clr.DATE_REPORT,
					clr.COMMENT_GENERAL,
					clr.FINALIZED_FLAG,
					clr.CASE_REC_ID_SEQUENCE,
					clr.CONCUR_MC,
					clr.CONCUR_ALT,

<!--- Add Approving MC --->                    
					lde.MC_Name


					FROM CONTINGENT_LIAB_REPORT clr

<!--- Add LOJ for Approving MC --->

					left outer join
					(
					select distinct 
					ldextra.EENAME as MC_Name,
					ldextra.AD_USERID,
					ldextra.AD_MAILNICKNAME
					from 
					<!---Kimsa LDEXTRA ldextra--->
					LDEXTRA ldextra where ldextra.sepdate is null
					) lde
					on
					trim(UPPER(clr.CONCUR_MC_USER_ID)) = Trim(UPPER(lde.AD_USERID))
					OR 
					trim(UPPER(clr.CONCUR_MC_USER_ID)) = UPPER(lde.AD_MAILNICKNAME)


					WHERE
					clr.DATE_REPORT = to_date('#DateFormat(ThisReportDate, "mm/dd/yyyy")#', 'mm/dd/yyyy')

					AND
					clr.DELETED_FLAG IS NULL

					<CFIF IsDefined("SelectedCategory")
					AND
					SelectedCategory NEQ "ALL">

						AND


						<CFSET CLAIM_CATEGORY_Labels_Ct = 0>

						<CFLOOP INDEX="CLAIM_CATEGORY_Labels_Index" LIST="#CLAIM_CATEGORY_Labels#">

							<CFSET CLAIM_CATEGORY_Labels_Ct = CLAIM_CATEGORY_Labels_Ct + 1>

							<CFIF CLAIM_CATEGORY_Labels_Index EQ SelectedCategory>
	
							    clr.CLAIM_CATEGORY = #CLAIM_CATEGORY_Labels_Ct#
		
							<CFELSEIF CLAIM_CATEGORY_Labels_Index EQ "Labor"
							AND
							SelectedCategory CONTAINS "Non-HQ">

								(
							    clr.CLAIM_CATEGORY = #CLAIM_CATEGORY_Labels_Ct#
                                AND
						        (
                                clr.AREA_NAME IS NULL
						        OR
								clr.AREA_NAME NOT LIKE 'HQ%'
                                )
                                )

							</CFIF>

						</CFLOOP>


    
    				</CFIF>


					<CFIF IsDefined("SelectedPC")>

						<CFSET Slashes_DIST_PERF_CLUSTER_CODE_Index = Find(" // ", SelectedPC)>
	
						<CFIF Slashes_DIST_PERF_CLUSTER_CODE_Index GT 0>

							<CFSET This_DIST_PERF_CLUSTER_CODE = Left(SelectedPC, Slashes_DIST_PERF_CLUSTER_CODE_Index - 1)>

							<CFIF This_DIST_PERF_CLUSTER_CODE EQ "ALL">

								AND clr.DIST_PERF_CLUSTER_CODE IS NOT NULL
								AND 
						        (clr.AREA_NAME IS NULL
						        OR
								clr.AREA_NAME NOT LIKE 'HQ%')

							<CFELSE>
                            
								AND clr.DIST_PERF_CLUSTER_CODE = '#This_DIST_PERF_CLUSTER_CODE#'

							</cfif>

						</cfif>

					<CFELSEIF IsDefined("SelectedHQDept")>
	
						<CFSET Slashes_HQ_AREA_NAME_Index = Find(" // ", SelectedHQDept)>

						<CFIF Slashes_HQ_AREA_NAME_Index GT 0>
	
							<CFSET This_HQ_AREA_CODE = Left(SelectedHQDept, Slashes_HQ_AREA_NAME_Index - 1)>
							<CFSET This_HQ_AREA_NAME = Right(SelectedHQDept, Len(SelectedHQDept) - (Slashes_HQ_AREA_NAME_Index + 3))>

							<CFIF This_HQ_AREA_CODE EQ "ALL">
                            
								AND clr.AREA_NAME LIKE 'HQ%'
		
							<CFELSE>
                            
								AND clr.AREA_NAME = '#This_HQ_AREA_NAME#'
        
							</CFIF>
                            
                            

                            <CFIF SelectedHQDept CONTAINS "HQ Labor Relations">
                            
                            	<CFIF IsDefined("SelectedUnion")>

                            		AND clr.UNIONS_SELECTED LIKE '%#SelectedUnion#%'
                            
                            	</CFIF>
                            
                            </CFIF>
                            
        
						</cfif>

	
					<CFELSEIF IsDefined("SelectedLDOffice")>
    
						<CFSET Slashes_SelectedLDOffice_Index = Find(" // ", SelectedLDOffice)>

						<CFIF Slashes_SelectedLDOffice_Index GT 0>
	
							<CFSET This_SelectedLDOffice_CODE = Left(SelectedLDOffice, Slashes_SelectedLDOffice_Index - 1)>

<!--- Include LAW_DEPT_OFFICE (OFFICE_PRM_KEY in LDOFFICES) for both Northeast Windsor (16) and New York (former code 7) --->	
					    	<CFIF This_SelectedLDOffice_CODE EQ 7
							OR
							This_SelectedLDOffice_CODE EQ 16>

					    	    AND clr.LAW_DEPT_OFFICE IN (7,16)
	
					    	<CFELSE>
        
					    	    AND clr.LAW_DEPT_OFFICE = #This_SelectedLDOffice_CODE#

							</CFIF>

						</cfif>


					</cfif>

					AND

					<CFIF Current_Removed_List_Index EQ "Current"
					OR
					Current_Removed_List_Index EQ "New">

						<CFIF Case_Type_List_Index EQ "Liabilities" OR Case_Type_List_Index EQ "Addendum">
                        

<!---
<!--- Include CASE_TYPE = 11 for final resolution of carry-over case from previous quarter --->
							CASE_TYPE IN (1, 11)
--->

							(
							clr.CASE_TYPE = 1
                            
<!---                            
                            <CFIF IsDefined("Get_PrevReport_CASE_REC_ID_SEQUENCE.RecordCount")
							AND
							Get_PrevReport_CASE_REC_ID_SEQUENCE.RecordCount GT 0>
                            
								OR
    	                        (
        	                    CASE_TYPE = 11
								AND
								CASE_REC_ID_SEQUENCE IN
								(#ValueList(Get_PrevReport_CASE_REC_ID_SEQUENCE.CASE_REC_ID_SEQUENCE)#)
								)
                            
                            </CFIF>
--->                            
                            
							)

						<CFELSE>

							clr.CASE_TYPE = 2

<!---
							<CFIF Current_Removed_List_Index EQ "New">
								AND
								STATUS_CODE_SELECTED != '2'
							</CFIF>
--->

							<!---LAN change 4/28/23--->
							<CFIF Current_Removed_List_Index EQ "New" AND Assess_Cutoff_List_Index NEQ "MostLikelyUnderTenMillion_MaxReasonableOverOneMillion">
								AND
								clr.STATUS_CODE_SELECTED NOT LIKE '%2%'
							</CFIF>


						</cfif>


					<CFELSEIF Current_Removed_List_Index EQ "Removed">

						<CFIF Case_Type_List_Index EQ "Liabilities">
							clr.CASE_TYPE = 11
						<CFELSE>
							clr.CASE_TYPE = 12
						</cfif>

					</cfif>


					<CFIF 
					(
					IsDefined("Form.CorpFinFormat") 
					AND 
					Form.CorpFinFormat EQ "CorpFinFormat"
					) 
					OR
					(
					IsDefined("Form.FrontOffcReviewFormat") 
					AND 
					Form.FrontOffcReviewFormat EQ "FrontOffcReviewFormat"
					)>

						AND
						clr.CONCUR_MC = 1

					</cfif>


					AND

					<CFIF Assess_Cutoff_List_Index EQ "TenMillionAndAbove">

						(

<!---
						<CFINCLUDE TEMPLATE="sql.assesscutoff.fivemillion.above.cfm">
--->


						<CFINCLUDE TEMPLATE="sql.assesscutoff.tenmillion.above.cfm">


						)

						<CFIF 
						(
						IsDefined("Form.CorpFinFormat") 
						AND 
						Form.CorpFinFormat EQ "CorpFinFormat"
						) 
						OR
						(
						IsDefined("Form.FrontOffcReviewFormat") 
						AND 
						Form.FrontOffcReviewFormat EQ "FrontOffcReviewFormat"
						)>

							<CFINCLUDE TEMPLATE="sql.CorpFinFmt.excludecases.cfm">

<!--- Exclude cases from prev report below Corp Fin thresholds: --->


                            <CFIF IsDefined("Get_PrevReport_CASE_REC_ID_SEQUENCE.RecordCount")
							AND
							Get_PrevReport_CASE_REC_ID_SEQUENCE.RecordCount GT 0>

								AND 
								clr.CASE_REC_ID_SEQUENCE NOT IN
								(#ValueList(Get_PrevReport_CASE_REC_ID_SEQUENCE.CASE_REC_ID_SEQUENCE)#)

							</CFIF>


						</cfif>


					<CFELSEIF Assess_Cutoff_List_Index EQ "NewTenMillionAndAbove">

<!---
<input type="checkbox" name="STATUS_CODE" id="STATUS_CODE_2" value="2" onClick="hideShowButton('No Change', 1, this.value)" CHECKED />No Change Since Last Report 
<input type="checkbox" name="STATUS_CODE" id="STATUS_CODE_7" value="7" onClick="hideShowButton('Update', 1, this.value)"  />Change in Liability Assessment 
<input type="checkbox" name="STATUS_CODE" id="STATUS_CODE_4" value="4" onClick="hideShowButton('', 1, this.value)"  />Change in Damages Assessment or Amount Sought (Still Meets Threshold) 
<input type="checkbox" name="STATUS_CODE" id="STATUS_CODE_9" value="9" onClick="hideShowButton('Update', 1, this.value)"  />Revised Most Likely Payout 
<input type="checkbox" name="STATUS_CODE" id="STATUS_CODE_8" value="8" onClick="hideShowButton('Update', 1, this.value)"  />Additional Facts 
<input type="checkbox" name="STATUS_CODE" id="STATUS_CODE_5" value="5" onClick="hideShowButton('Update', 1, this.value)"  />Settlement, Not Yet Final and Paid 
<input type="checkbox" name="STATUS_CODE" id="STATUS_CODE_6" value="6" onClick="hideShowButton('Update', 1, this.value)"  />Unfavorable Decision, Not Yet Final and Paid 
<input type="checkbox" name="STATUS_CODE" id="STATUS_CODE_11" value="11" onClick="hideShowButton('Remove', 1, this.value)"  />Favorable Decision 
<input type="checkbox" name="STATUS_CODE" id="STATUS_CODE_12" value="12" onClick="hideShowButton('Remove', 1, this.value)"  />Unfavorable Decision, Final and Paid 
<input type="checkbox" name="STATUS_CODE" id="STATUS_CODE_13" value="13" onClick="hideShowButton('Remove', 1, this.value)"  />Settlement, Final and Paid 
<input type="checkbox" name="STATUS_CODE" id="STATUS_CODE_14" value="14" onClick="hideShowButton('Remove', 1, this.value)"  />Withdrawn 
<input type="checkbox" name="STATUS_CODE" id="STATUS_CODE_15" value="15" onClick="hideShowButton('Remove', 1, this.value)"  />Reassessed; No Longer Meets Threshold 


NOT:

<input type="checkbox" name="STATUS_CODE" id="STATUS_CODE_11" value="11" onClick="hideShowButton('Remove', 1, this.value)"  />Favorable Decision 
<input type="checkbox" name="STATUS_CODE" id="STATUS_CODE_12" value="12" onClick="hideShowButton('Remove', 1, this.value)"  />Unfavorable Decision, Final and Paid 
<input type="checkbox" name="STATUS_CODE" id="STATUS_CODE_13" value="13" onClick="hideShowButton('Remove', 1, this.value)"  />Settlement, Final and Paid 
<input type="checkbox" name="STATUS_CODE" id="STATUS_CODE_14" value="14" onClick="hideShowButton('Remove', 1, this.value)"  />Withdrawn 

--->


						(

						(

						(
						clr.ASSESSMENT_PROBABILITY IN (1,2)
						AND
						(
						clr.ASSESSMENT_AMOUNT >= <cfqueryparam cfsqltype="numeric" value="#TenMillion#">
						
                        
<!---                        
						OR
						clr.ASSESSMENT_AMOUNT_UPPER >= #OneMillion#
--->
						
						)
						)

						OR

						(
						clr.ASSESSMENT_PROBABILITY = 3
						AND
						(
						clr.ASSESSMENT_AMOUNT >= <cfqueryparam cfsqltype="numeric" value="#TenMillion#">

<!---
						OR
						clr.ASSESSMENT_AMOUNT_UPPER >= #TenMillion#
--->

						)
						)

						)

						AND

						(

						(
						clr.STATUS_CODE = 1
						AND
						clr.STATUS_CODE_SELECTED IS NULL
						)

						OR

						(
						clr.STATUS_CODE IS NULL
						AND
						clr.STATUS_CODE_SELECTED = '1'
						)


						<CFIF IsDefined("Get_PrevReport_CASE_REC_ID_SEQUENCE.RecordCount")
						AND
						Get_PrevReport_CASE_REC_ID_SEQUENCE.RecordCount GT 0>


							OR
<!--- Include cases from prev report below Corp Fin thresholds: --->
							clr.CASE_REC_ID_SEQUENCE IN
							(#ValueList(Get_PrevReport_CASE_REC_ID_SEQUENCE.CASE_REC_ID_SEQUENCE)#)

						</CFIF>


						)

						)


						<CFIF 
						(
						IsDefined("Form.CorpFinFormat") 
						AND 
						Form.CorpFinFormat EQ "CorpFinFormat"
						) 
						OR
						(
						IsDefined("Form.FrontOffcReviewFormat") 
						AND 
						Form.FrontOffcReviewFormat EQ "FrontOffcReviewFormat"
						)>

<!--- Only exclude Liabilities: --->

							AND NOT
							(

							clr.CASE_TYPE IN (1,11)

							AND
							clr.ASSESSMENT_AMOUNT < <cfqueryparam cfsqltype="numeric" value="#TenMillion#">

							OR
							clr.ASSESSMENT_AMOUNT IS NULL



							AND
							(
							clr.ASSESSMENT_AMOUNT_UPPER >= <cfqueryparam cfsqltype="numeric" value="#OneMillion#">
							AND
							clr.ASSESSMENT_AMOUNT_UPPER IS NOT NULL

							OR
							(
							clr.ASSESSMENT_AMT_UPPER_HIGH_END IS NOT NULL
							AND
							clr.ASSESSMENT_AMT_UPPER_HIGH_END >= <cfqueryparam cfsqltype="numeric" value="#OneMillion#">
							)

							)



							)


						</cfif>

<!---
					<CFELSEIF Assess_Cutoff_List_Index EQ "MostLikelyUnder1Million_MaxReasonableOver1Million">


					<CFELSEIF Assess_Cutoff_List_Index EQ "MostLikelyUnderTenMillion_MaxReasonableOverTenMillion">

--->





					<CFELSEIF Assess_Cutoff_List_Index EQ "MostLikelyUnderTenMillion_MaxReasonableOverOneMillion">


						(
<!---
						clr.ASSESSMENT_AMOUNT IS NOT NULL
						AND
						clr.ASSESSMENT_AMOUNT < <cfqueryparam cfsqltype="numeric" value="#OneMillion#">
						AND
						(
						clr.ASSESSMENT_AMOUNT_UPPER >= <cfqueryparam cfsqltype="numeric" value="#OneMillion#">
						OR
						(
						clr.ASSESSMENT_AMT_UPPER_HIGH_END IS NOT NULL
						AND
						clr.ASSESSMENT_AMT_UPPER_HIGH_END >= <cfqueryparam cfsqltype="numeric" value="#OneMillion#">
						)
						)
--->

						--line 641
						<!---clr.ASSESSMENT_AMOUNT IS NOT NULL
						clr.ASSESSMENT_AMOUNT IS NOT NULL
						AND--->
						(clr.ASSESSMENT_AMOUNT < <cfqueryparam cfsqltype="numeric" value="#TenMillion#"> or clr.assessment_amount is null)
						AND
						(
						clr.ASSESSMENT_AMOUNT_UPPER >= <cfqueryparam cfsqltype="numeric" value="#OneMillion#">
						OR
						(
						clr.ASSESSMENT_AMT_UPPER_HIGH_END IS NOT NULL
						AND
						clr.ASSESSMENT_AMT_UPPER_HIGH_END >= <cfqueryparam cfsqltype="numeric" value="#OneMillion#">
						)
						)




						)

<!--- For "Under5Million" --->
					<CFELSE>

<!---
						<CFINCLUDE TEMPLATE="sql.assesscutoff.fivemillion.below.cfm">
--->

						<CFINCLUDE TEMPLATE="sql.assesscutoff.tenmillion.below.cfm">


						<CFIF 
						(
						IsDefined("Form.CorpFinFormat") 
						AND 
						Form.CorpFinFormat EQ "CorpFinFormat"
						) 
						OR
						(
						IsDefined("Form.FrontOffcReviewFormat") 
						AND 
						Form.FrontOffcReviewFormat EQ "FrontOffcReviewFormat"
						)>

							<CFOUTPUT>
							<CFINCLUDE TEMPLATE="sql.CorpFinFmt.excludecases.cfm">
							</CFOUTPUT>


                            <CFIF IsDefined("Get_PrevReport_CASE_REC_ID_SEQUENCE.RecordCount")
							AND
							Get_PrevReport_CASE_REC_ID_SEQUENCE.RecordCount GT 0>

<!--- Exclude cases from prev report below Corp Fin thresholds: --->
								AND 
								clr.CASE_REC_ID_SEQUENCE NOT IN
								(#ValueList(Get_PrevReport_CASE_REC_ID_SEQUENCE.CASE_REC_ID_SEQUENCE)#)

							</CFIF>


						</cfif>

					</cfif>


					<CFIF IsDefined("ThisRecID")>
                    
						AND clr.PRIMARYKEY = #ThisRecID#
                        
					</cfif>


					<CFIF IsDefined("Get_Auth_User_Office.RecordCount") 
					AND 
					Get_Auth_User_Office.RecordCount EQ 1 
					AND 
					IsDefined("Get_Auth_User_Office.OFFICE_PRM_KEY")>


<!---
						<CFINCLUDE TEMPLATE="SQL.CheckForOfficeOverlap.cfm">
--->



						AND 
    					(
					    clr.LAW_DEPT_OFFICE = #Get_Auth_User_Office.OFFICE_PRM_KEY#
						OR
					    clr.ALT_LAW_DEPT_OFFICE = #Get_Auth_User_Office.OFFICE_PRM_KEY#
					    )




<!--- Check for Business cases authorization (B) or Torts authorization (T) (St Louis) --->
						<CFIF IsDefined("ThisCONTINGENT_LIAB_AUTH")>

							<CFIF ThisCONTINGENT_LIAB_AUTH EQ "B">
                            
								AND clr.CLAIM_CATEGORY = 1
                                
							<CFELSEIF ThisCONTINGENT_LIAB_AUTH EQ "T">
                            
								AND clr.CLAIM_CATEGORY = 3
                                
							</cfif>

						</cfif>


					<CFELSEIF IsDefined("Get_Indiv_User.RecordCount") 
					AND 
					Get_Indiv_User.RecordCount EQ 1>

<!--- HQ ELL = 24 --->

						<CFIF Get_Indiv_User.OFFICE_PRM_KEY EQ 24>

<!---                        
							AND (clr.LAW_DEPT_OFFICE = #Get_Indiv_User.OFFICE_PRM_KEY#
                            OR clr.ALT_LAW_DEPT_OFFICE = #Get_Indiv_User.OFFICE_PRM_KEY#)
--->
                            
						<CFELSE>
                        
							AND (clr.COUNSEL_LAW_DEPT = #Get_Indiv_User.PRIMARYKEY#
							OR clr.COCOUNSEL_LAW_DEPT = #Get_Indiv_User.PRIMARYKEY#)
                            
						</cfif>

					</cfif>


					<CFIF 
					(
					IsDefined("Form.CorpFinFormat") 
					AND 
					Form.CorpFinFormat EQ "CorpFinFormat"
					) 
					OR
					(
					IsDefined("Form.FrontOffcReviewFormat") 
					AND 
					Form.FrontOffcReviewFormat EQ "FrontOffcReviewFormat"
					)>

						AND

						<CFIF IsDefined("Form.CorpFinFormat_STL") 
						AND 
						Form.CorpFinFormat_STL EQ "CorpFinFormat_STL">

<!--- STATUS_CODE check added 2/20/09 to exclude Removed cases: 
STATUS_CODE <= 10
--->

<!--- Crx: CASE_TYPE check added 2/26/09 to exclude Removed cases: --->

							CASE_TYPE < 11

							AND
							clr.ASSESSMENT_PROBABILITY = 1 

							AND
							(

							clr.ASSESSMENT_AMOUNT >= <cfqueryparam cfsqltype="numeric" value="#TenMillion#">
							OR

<!--- For CorpFin, Addendum, incl Narrative: --->

							(

<!---
ASSESSMENT_AMOUNT < 1000000
--->

							(
							clr.ASSESSMENT_AMOUNT < <cfqueryparam cfsqltype="numeric" value="#TenMillion#">
							OR
							clr.ASSESSMENT_AMOUNT IS NULL
							)

							AND
							(
							clr.ASSESSMENT_AMOUNT_UPPER >= <cfqueryparam cfsqltype="numeric" value="#OneMillion#">
							OR
							(
							clr.ASSESSMENT_AMT_UPPER_HIGH_END IS NOT NULL
							AND
							clr.ASSESSMENT_AMT_UPPER_HIGH_END >= <cfqueryparam cfsqltype="numeric" value="#OneMillion#">
							)
							)

							)

							) 

							AND
							clr.SHORT_TERM_LIABILITY = 2

						<CFELSE>

							(

							(
							--Line 848	
							clr.ASSESSMENT_PROBABILITY = 1 
							AND 
							(

							clr.ASSESSMENT_AMOUNT >= <cfqueryparam cfsqltype="numeric" value="#TenMillion#">
							OR


<!--- For CorpFin, Addendum, incl Narrative: --->

							(

<!---
ASSESSMENT_AMOUNT < 1000000
--->

							(
							clr.ASSESSMENT_AMOUNT < <cfqueryparam cfsqltype="numeric" value="#TenMillion#">
							OR
							clr.ASSESSMENT_AMOUNT IS NULL
							)

							AND
							(
							clr.ASSESSMENT_AMOUNT_UPPER >= <cfqueryparam cfsqltype="numeric" value="#OneMillion#">
							OR
							(
							clr.ASSESSMENT_AMT_UPPER_HIGH_END IS NOT NULL
							AND
							clr.ASSESSMENT_AMT_UPPER_HIGH_END >= <cfqueryparam cfsqltype="numeric" value="#OneMillion#">
							)
							)

							)

							) 
							)

							OR 

							(
							clr.ASSESSMENT_PROBABILITY = 2 
							AND 
							(

							clr.ASSESSMENT_AMOUNT >= <cfqueryparam cfsqltype="numeric" value="#TenMillion#">
							OR

<!--- For CorpFin, Addendum, incl Narrative: --->

							(

<!---
ASSESSMENT_AMOUNT < 1000000
--->

							(
							clr.ASSESSMENT_AMOUNT < <cfqueryparam cfsqltype="numeric" value="#TenMillion#">
							OR
							clr.ASSESSMENT_AMOUNT IS NULL
							)

							OR
							(
							clr.ASSESSMENT_AMOUNT_UPPER >= <cfqueryparam cfsqltype="numeric" value="#TenMillion#">
							and
							clr.ASSESSMENT_AMOUNT is null
							and 
							clr.ASSESSMENT_AMT_UNKNOWN = 1
							OR
							(
							clr.ASSESSMENT_AMT_UPPER_HIGH_END IS NOT NULL
							AND
							clr.ASSESSMENT_AMT_UPPER_HIGH_END >= <cfqueryparam cfsqltype="numeric" value="#OneMillion#">
							)
							)

							)

							) 
							)

							OR 

							(
							clr.ASSESSMENT_PROBABILITY = 3 AND 
							(

							clr.ASSESSMENT_AMOUNT >= <cfqueryparam cfsqltype="numeric" value="#TenMillion#">
                            
<!---                            
							OR
							clr.ASSESSMENT_AMOUNT_UPPER >= #TenMillion#
--->

							OR

<!--- For CorpFin, Addendum, incl narrative: --->

							(
							<!---Begin New code block for assessment unknown--->
						<!---	(
							clr.ASSESSMENT_AMOUNT_UPPER >= #TenMillion#
							and
							clr.ASSESSMENT_AMOUNT is null
							and 
							clr.ASSESSMENT_AMT_UNKNOWN = 1
							)

							OR--->
							<!---End New code block for assessment unknown--->
							(
							clr.ASSESSMENT_AMOUNT < <cfqueryparam cfsqltype="numeric" value="#TenMillion#">
							OR
							clr.ASSESSMENT_AMOUNT IS NULL
							)
							
							AND
							(
							clr.ASSESSMENT_AMOUNT_UPPER >= <cfqueryparam cfsqltype="numeric" value="#TenMillion#">
							OR
							(
							clr.ASSESSMENT_AMT_UPPER_HIGH_END IS NOT NULL
							AND
							clr.ASSESSMENT_AMT_UPPER_HIGH_END >= <cfqueryparam cfsqltype="numeric" value="#TenMillion#">
							)
							)


<!--- Status Withdrawn: STATUS_CODE_SELECTED = 14 --->
							AND
                            clr.STATUS_CODE_SELECTED NOT LIKE '%14%'


							)

							) 
							)


<!--- Include removed Liab and Receivable cases (CASE_TYPE = 11 or = 12)--->
							OR 
							(

							(
							clr.CASE_TYPE = 11
							OR 
							clr.CASE_TYPE = 12
							)

							AND clr.CASE_REC_ID_SEQUENCE IN 
                            (#ValueList(CONTINGENT_LIAB_PrevRpt_CASE_REC_ID_SEQUENCE.CASE_REC_ID_SEQUENCE)#)
							)

							)

<!--- Close <CFIF IsDefined("Form.CorpFinFormat_STL") AND Form.CorpFinFormat_STL EQ "CorpFinFormat_STL"> --->
						</cfif>

<!--- Close <CFIF IsDefined("Form.CorpFinFormat") --->
					</cfif>


					<CFIF (IsDefined("Form.CorpFinFormat") AND Form.CorpFinFormat EQ "CorpFinFormat")>

						<CFINCLUDE TEMPLATE="sql.Get_ChecklistCases.cfm">

					</cfif>


					ORDER BY 
                    
<!--- Not sorting by CASE_TYPE for New Cases, so CASE_TYPE=1 and CASE_TYPE=11 come out together --->
					<CFIF Assess_Cutoff_List_Index NEQ "NewTenMillionAndAbove">
                                        
                    	clr.CASE_TYPE, 
                        
					</cfif>
                    
                        
					clr.ASSESSMENT_PROBABILITY, clr.CLAIM_CATEGORY, upper(clr.CASE_NAME), clr.CASE_NUMBER



					</cfquery>

<!---
</CFOUTPUT>

<cfabort>
--->


<!---
</CFIF>
--->



<!---
<CFOUTPUT>
cfloop.cur_rem.casetype.assesscutoff.query.cfm at 1014:
<p>
CLRC_Query_Name = "#CLRC_Query_Name#"

<table>

<CFLOOP QUERY="#CLRC_Query_Name#">

<tr>
<td>
#PRIMARYKEY#
<td>
#CASE_NAME#

</cfloop>

</table>

</CFOUTPUT>
--->



<!--- Close <CFIF Skip_CLRC_Query EQ "no"> --->
				</cfif>

<!--- Close <CFLOOP INDEX="Assess_Cutoff_List_Index" LIST="#Assess_Cutoff_List#"> --->
			</cfloop>

<!--- Close <CFIF Skip_Assess_Cutoff_List EQ "no"> --->
		</cfif>

<!--- Close <CFLOOP INDEX="Case_Type_List_Index" LIST="#Case_Type_List#"> --->
	</cfloop>

<!--- Close <CFLOOP INDEX="Current_Removed_List_Index" LIST="#Current_Removed_List#"> --->
</cfloop>



