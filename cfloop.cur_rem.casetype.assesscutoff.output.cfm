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
  <CFOUTPUT>
  <cfinclude template="AddHeaderA.cfm">	
<div  class="header-stky">
  <div id="section_headers" class="header-stk">
		<h5 style="text-align: center" >#CASE_TYPE_LABEL#</h5>
		<h5 style="text-align: center">#ASSESSMENT_PROBABILITY_Label# & #CLAIM_CATEGORY_Label#</h5>
		
   </div>
   </div>	
	
 
<!---<cfdump var="#This_CurrentRow#">--->	
<table class="report-containerr" id="RecTable_#This_CurrentRow#" width="100%">
	<thead class="report-header report-header-addendum-hid" >
		<tr>
			<th class="report-header-cell">
				<div>
					<br>
					<center><b>#CASE_TYPE_LABEL#</b><br />#ASSESSMENT_PROBABILITY_Label# & #CLAIM_CATEGORY_Label#</center>
					<br>
				</div>
			</th>
		</tr>
	</thead>
	<tfoot class="report-footer">
		<tr>
			<th class="report-header-cell"><!---KS add new line code 11.15.24  --->
				<div class="footer-info">
					<center style="color:lightgrey;border-top:1px dotted lightgrey;margin-left:200px;padding-top:10px;width:100%;">end of page</center>
				</div>
			</th>
		</tr>
			
	</tfoot>
	

<tbody>
		<tr>
			<td class="report-content-cell">
				<div class="main"><br />				
					<CFINCLUDE TEMPLATE="Report.ptB.cfm">
				</div>
				
			</td>
		</tr>
		<tr>
			<td class="report-content-cell">
				<div class="main"><br />				
					<!---<div style="padding-left:480px;font-size:14px;margin-top:0px;bottom:10px;"><img src="https://davidwalsh.name/demo/page-break.gif" /></div>--->
				</div>
				
			</td>
		</tr>
		
	</tbody>
    </table> 
    				
    </cfoutput>	
    	<!---<CFINCLUDE TEMPLATE="Report.ptB.cfm">--->
    	<!---<div style="color:lightgrey;padding-left:380px;font-size:14px;margin-top:0px;bottom:10px;"><img src="https://davidwalsh.name/demo/page-break.gif" /></div>--->
				
    	
    						<CFELSE>
    						<CFOUTPUT>
    							
    <cfinclude template="AddHeaderA.cfm">
	<table class="report-container" id="RecTable_#This_CurrentRow#" cellpadding="4" cellspacing="4" width="100%">
	<thead class="report-header">
		<tr>
			<th class="report-header-cell">
				<div>
					<br>
					<center><b>#CASE_TYPE_LABEL#</b><br />#ASSESSMENT_PROBABILITY_Label# & #CLAIM_CATEGORY_Label#</center>
					<br>
				</div>
			</th>
		</tr>
	</thead>
	<tfoot class="report-footer">
		<tr>
			<td class="report-footer-cell">
				<div class="footer-info">					
					<center style="color:lightgrey;border-top:0px dotted lightgrey;margin-top:0px;padding-top:0px;">end of page</center>				
				</div>
			</td>
		</tr>
			
	</tfoot>
	
	</CFOUTPUT>
	<tbody>
		<tr>
			<td class="report-content-cell">
				<div class="main">
					<CFINCLUDE TEMPLATE="Report.ptC.cfm">
				</div>
				<div class="main">
					<CFINCLUDE TEMPLATE="Report.ptD.cfm">
				</div>
				<div class="main">
					<CFINCLUDE TEMPLATE="Report.ptE.cfm">
				</div>
			</td>
		</tr>
		
	</tbody>
    </table>    
							<!---	<CFINCLUDE TEMPLATE="Report.ptC.cfm">
							<CFINCLUDE TEMPLATE="Report.ptD.cfm">
							<CFINCLUDE TEMPLATE="Report.ptE.cfm">
	--->
	
							</table>
	
							</div>

						</cfif>


					</cfloop>

				</cfif>


			</cfif>

		</cfloop>


	</cfloop>

</cfloop>



