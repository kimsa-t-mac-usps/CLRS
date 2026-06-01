<cfinclude template="MfaCookieCheck.cfm">


<!--- Has INCLUDEs for Report.ptB.cfm - Report.ptE.cfm --->

<!---
Same CFLOOP bypasses in:
-- cfloop.cur_rem.casetype.assesscutoff.query.cfm
-- cfloop.cur_rem.casetype.assesscutoff.output.cfm
-- Report.TopIndexDiv.cfloops.cfm
--->

<CFLOOP INDEX="Current_Removed_List_Index" LIST="#Current_Removed_List#">
	<CFLOOP INDEX="Case_Type_List_Index" LIST="#Case_Type_List#">

<!--- For CorpFin report, skip Addendum if index is "Removed" --->
		<CFIF Current_Removed_List_Index EQ "Removed"
		AND
		Case_Type_List_Index EQ "Addendum">

			<CFBREAK>

		</CFIF>

		<CFSET Skip_Assess_Cutoff_List = "no">


		<CFLOOP INDEX="Assess_Cutoff_List_Index" LIST="#Assess_Cutoff_List#">

			<CFIF Current_Removed_List_Index EQ "New">

				<CFIF Assess_Cutoff_List_Index EQ "NewTenMillionAndAbove" OR Assess_Cutoff_List_Index EQ "MostLikelyUnderTenMillion_MaxReasonableOverOneMillion">
		
					<CFSET Skip_CLRC_Query = "no">
		
        		<CFELSE>
        
		   			<CFSET Skip_CLRC_Query = "yes">
		
				</CFIF>
				<!---test --->
				

				<CFELSEIF Current_Removed_List_Index EQ "Removed">
					<!---KS---<CFIF Assess_Cutoff_List_Index EQ "TenMillionAndAbove" OR Assess_Cutoff_List_Index EQ "MostLikelyUnderTenMillion_MaxReasonableOverOneMillion">--->
					<CFIF Assess_Cutoff_List_Index EQ "TenMillionAndAbove" 
						OR Assess_Cutoff_List_Index EQ "MostLikelyUnderTenMillion_MaxReasonableOverOneMillion"
							OR Assess_Cutoff_List_Index EQ "UnderTenMillion">
		
						<CFSET Skip_CLRC_Query = "no">
		
			        <CFELSE>
        
   						<CFSET Skip_CLRC_Query = "yes">
		
					</CFIF>

				<!---test --->
			<CFELSEIF Assess_Cutoff_List_Index EQ "NewTenMillionAndAbove" OR Assess_Cutoff_List_Index EQ "MostLikelyUnderTenMillion_MaxReasonableOverOneMillion">
      
				<CFSET Skip_CLRC_Query = "yes">

		    <CFELSE>
    
				<CFSET Skip_CLRC_Query = "no">

			</cfif>
  
			<CFIF Skip_CLRC_Query EQ "no">


				<CFSET CLRC_Query_Name = QueryNamePrefix & "_" & "CONTINGENT_LIAB_GetRecord_Current" & "_" & Current_Removed_List_Index & "_" & Case_Type_List_Index & "_" & Assess_Cutoff_List_Index>


				<CFIF IsDefined("Form.CorpFinFormat") AND Form.CorpFinFormat EQ "CorpFinFormat">

					<CFSET Query_CurrentRow = CLRC_Query_Name & ".CurrentRow">

				</CFIF>

				<CFIF NOT IsDefined("This_CurrentRow")>

					<CFSET This_CurrentRow = 0>

				</CFIF>


<CFSET CLRC_RecCt = CLRC_Query_Name & ".RecordCount">
<CFIF IsDefined(CLRC_RecCt)>

	<!---<CFOUTPUT>
	#CLRC_RecCt# = 
    #Evaluate(CLRC_RecCt)#
	</CFOUTPUT>--->

</CFIF>

		<CFSET This_RecordCount = Evaluate(CLRC_RecCt)>

				<CFIF This_RecordCount EQ 0>

					<CFINCLUDE TEMPLATE="sectionheadings.cfswitch.cfm">
					<CFINCLUDE TEMPLATE="sectionheadings.cfset.cfm">

				<CFELSE>

					<CFLOOP QUERY="#CLRC_Query_Name#">
							<CFFLUSH interval=500>
	
						<CFSET This_CurrentRow = This_CurrentRow + 1>
		
						<CFIF ThisReportDate NEQ EarliestReportDate AND PrevReportDate NEQ "">
	
							<CFQUERY NAME="CONTINGENT_LIAB_GetRecord_PrevRpt" DATASOURCE="ContLiab">
							SELECT *
							FROM CONTINGENT_LIAB_REPORT
							WHERE DATE_REPORT = to_date('#DateFormat(PrevReportDate, "mm/dd/yyyy")#', 'mm/dd/yyyy')
							AND
							DELETED_FLAG IS NULL
	
							AND CASE_REC_ID_SEQUENCE = #CASE_REC_ID_SEQUENCE#
							</cfquery>
	
						</cfif>

						<!--- Deep fallback: find most recent quarter with District data --->
						<CFQUERY NAME="GetRecord_LatestDistrict" DATASOURCE="ContLiab">
						SELECT DIST_PERF_CLUSTER_CODE, DIST_PERF_CLUSTER_NAME, DIVISION_CODE, DIVISION_NAME
						FROM CONTINGENT_LIAB_REPORT
						WHERE CASE_REC_ID_SEQUENCE = <cfqueryparam value="#CASE_REC_ID_SEQUENCE#" cfsqltype="cf_sql_numeric">
						AND DELETED_FLAG IS NULL
						AND DIST_PERF_CLUSTER_CODE IS NOT NULL
						AND DATE_REPORT < to_date('#DateFormat(ThisReportDate, "mm/dd/yyyy")#', 'mm/dd/yyyy')
						ORDER BY DATE_REPORT DESC
						FETCH FIRST 1 ROW ONLY
						</CFQUERY>
	
						<CFQUERY NAME="Get_MC_APPR_FLAG" DATASOURCE="ContLiab">
						SELECT MC_APPR_FLAG, ALT_APPR_FLAG
						FROM VIEW_CONTING_GET_MC_APPR_FLAG
						WHERE CASE_REC_ID_SEQUENCE = #CASE_REC_ID_SEQUENCE#
						</cfquery>
	
						<CFQUERY NAME="Get_MC_APPR_FLAG_Approved" DATASOURCE="ContLiab">
						SELECT MC_APPR_FLAG, ALT_APPR_FLAG
						FROM VIEW_CONTING_GET_MC_APR_FLG_AP
						WHERE CASE_REC_ID_SEQUENCE = #CASE_REC_ID_SEQUENCE#
						</cfquery>
	
						<CFQUERY NAME="Get_Case_WithoutChecklist" DATASOURCE="ContLiab">
						SELECT DISTINCT CASE_REC_ID_SEQUENCE
						FROM VIEW_CONTING_CASE_REC_ID_SEQ
						WHERE CASE_REC_ID_SEQUENCE = #CASE_REC_ID_SEQUENCE#

						AND CASE_REC_ID_SEQUENCE NOT IN
						(
						SELECT CASE_REC_ID_SEQUENCE
						FROM VIEW_CONTING_GET_CHKLISTCASES
						)
	
						</cfquery>
	
	
						<CFINCLUDE TEMPLATE="sectionheadings.cfswitch.cfm">
	
						<CFINCLUDE TEMPLATE="rowcolor.alternate.cfm">
	
						<CFINCLUDE TEMPLATE="sectionheadings.cfset.cfm">

						<CFIF IsDefined("Form.CorpFinFormat") AND Form.CorpFinFormat EQ "CorpFinFormat" 
						AND 
						(
						Assess_Cutoff_List_Index EQ "UnderTenMillion"
						OR
						Assess_Cutoff_List_Index EQ "MostLikelyUnderTenMillion_MaxReasonableOverOneMillion"
						)>
    
    						<CFINCLUDE TEMPLATE="Report.ptB.cfm">
    						<CFELSE>
								<CFINCLUDE TEMPLATE="Report.ptC.cfm">
							<CFINCLUDE TEMPLATE="Report.ptD.cfm">
							<CFINCLUDE TEMPLATE="Report.ptE.cfm">
	
	
							</table>
	
							</div>

						</cfif>


					</cfloop>

				</cfif>


			</cfif>

		</cfloop>


	</cfloop>

</cfloop>



