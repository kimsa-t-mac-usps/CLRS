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


<!--- For CorpFin report, skip Addendum if index is "Removed" 
		<CFIF Current_Removed_List_Index EQ "Removed"
		AND
		Case_Type_List_Index EQ "Addendum">

			<CFBREAK>

		</CFIF>--->

<!--- For CorpFin report, skip Addendum if index is "Current" Lenee' --->
<!--- 		<CFIF Current_Removed_List_Index EQ "Current"
		AND
		Case_Type_List_Index EQ "Addendum">

			<CFBREAK>

		</CFIF> --->
		



<!---
<CFOUTPUT>

Case_Type_List_Index = #Case_Type_List_Index#
<br />

</CFOUTPUT>
--->



		<CFSET Skip_Assess_Cutoff_List = "no">


		<CFLOOP INDEX="Assess_Cutoff_List_Index" LIST="#Assess_Cutoff_List#">


<!---
<CFOUTPUT>

Assess_Cutoff_List_Index = #Assess_Cutoff_List_Index#
<br />

</CFOUTPUT>
--->
			<!--- <cfif Assess_Cutoff_List_Index EQ "MostLikelyUnderTenMillion_MaxReasonableOverOneMillion">
							<cfoutput>I am here cfloopxxxxx.output line 98</cfoutput><cfabort>
						</cfif> --->


			<CFIF Current_Removed_List_Index EQ "New">

<!--- 				<cfoutput>
cfloop.output line 95					
CLRC_Query_Name = #CLRC_Query_Name#<br>
Current_Removed_List = #Current_Removed_List#<br>
Current_Removed_List_Index = #Current_Removed_List_Index#<br>
Assess_Cutoff_List = #Assess_Cutoff_List#<br>
Assess_Cutoff_List_Index = #Assess_Cutoff_List_Index#<br>
</CFOUTPUT>  --->

				<CFIF Assess_Cutoff_List_Index EQ "NewTenMillionAndAbove" OR Assess_Cutoff_List_Index EQ "MostLikelyUnderTenMillion_MaxReasonableOverOneMillion">

					<!--- <cfif Assess_Cutoff_List_Index EQ "MostLikelyUnderTenMillion_MaxReasonableOverOneMillion">
							<cfoutput>I am here cfloopxxxxx.output line 98</cfoutput><cfabort>
						</cfif> --->
		
					<CFSET Skip_CLRC_Query = "no">
		
        		<CFELSE>
        
		   			<CFSET Skip_CLRC_Query = "yes">
		
				</CFIF>

			<CFELSEIF Current_Removed_List_Index EQ "Removed">

					<CFIF Assess_Cutoff_List_Index EQ "TenMillionAndAbove" OR Assess_Cutoff_List_Index EQ "MostLikelyUnderTenMillion_MaxReasonableOverOneMillion">
		
						<CFSET Skip_CLRC_Query = "no">
		
			        <CFELSE>
        
   						<CFSET Skip_CLRC_Query = "yes">
		
					</CFIF>

			<CFELSEIF Current_Removed_List_Index EQ "Current">
				

					<CFIF Assess_Cutoff_List_Index EQ "TenMillionAndAbove">
		
						<CFSET Skip_CLRC_Query = "no">
		
			        <CFELSE>
        
   						<CFSET Skip_CLRC_Query = "yes">
		
					</CFIF>
					<!--- <cfoutput>Skip_CLRC_Query  EQ #Skip_CLRC_Query#</cfoutput> --->

		<CFELSE>
    
					<CFSET Skip_CLRC_Query = "no">

						

		</CFIF>	

    
    
			<CFIF Skip_CLRC_Query EQ "no">


				<CFSET CLRC_Query_Name = QueryNamePrefix & "_" & "CONTINGENT_LIAB_GetRecord_Current" & "_" & Current_Removed_List_Index & "_" & Case_Type_List_Index & "_" & Assess_Cutoff_List_Index>


<!--- <CFOUTPUT>

CLRC_Query_Name = #CLRC_Query_Name# cfloop.xxxx.output.cfm line 163
<br />
Current_Removed_List EQ #Current_Removed_List#

</CFOUTPUT> ---> 






				<CFIF IsDefined("Form.CorpFinFormat") AND Form.CorpFinFormat EQ "CorpFinFormat">

					<CFSET Query_CurrentRow = CLRC_Query_Name & ".CurrentRow">

				</CFIF>



				<CFIF NOT IsDefined("This_CurrentRow")>

					<CFSET This_CurrentRow = 0>

				</CFIF>



<!--- <p>
In cfloop.cur_rem.casetype.assesscutoff.output.cfm at 145:
<br />


<CFOUTPUT>
CLRC_Query_Name = #CLRC_Query_Name#
</CFOUTPUT>

<p>
 --->

<CFSET CLRC_RecCt = CLRC_Query_Name & ".RecordCount">


<CFIF IsDefined(CLRC_RecCt)>

	<!---<CFOUTPUT>
	#CLRC_RecCt# = 
    
    #Evaluate(CLRC_RecCt)#
	</CFOUTPUT>--->

</CFIF>

<p>



<!---
				<CFSET CLRC_RecCt = CLRC_Query_Name & ".RecordCount">
--->


<!---
<cfabort>
--->


<!---
<CFIF CLRC_Query_Name CONTAINS "New1MillionAndAbove"
AND
IsDefined(CLRC_RecCt)
AND
Evaluate(CLRC_RecCt) EQ 0>


<div style="page-break-before:always" cfloop.cur_rem.casetype.assesscutoff.output.cfm at 153>

<h3>
I. Contingent 

<CFOUTPUT>
#Case_Type_List_Index#:
</CFOUTPUT>

New Cases Assessed At or Above $1 Million (incl. Cases Previously Below Reporting Threshold)
</h3>

[No Cases]

</div>


</CFIF>
--->




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






<!---
						OR
						Assess_Cutoff_List_Index EQ "MostLikelyUnder1Million_MaxReasonableOver1Million"


						OR
						Assess_Cutoff_List_Index EQ "MostLikelyUnderTenMillion_MaxReasonableOverTenMillion"


--->



<!---
<!--- Show full case report, including narrative (exclude from table listing) if previously had been Short-term liability but now is 1 Year or more --->

							<CFIF NOT
							(
							SHORT_TERM_LIABILITY GT 2
							AND
							CONTINGENT_LIAB_GetRecord_PrevRpt.SHORT_TERM_LIABILITY EQ 2
							)>
	
								<CFINCLUDE TEMPLATE="Report.ptB.cfm">
	
							<CFELSE>
	    
<!---        
						    	<tr>
                                
<!--- Changed colspan to 7 from 6 after adding table column "Change in Status" --->                                
						        <td colspan="7" cfloop.cur_rem.casetype.assesscutoff.output.cfm at 295>
	        
	        					<CFSET PrevSTLNote = "<i>[Case previously reported as Short-term Liability (Estimated Time to Resolution: Less Than 1 Year]</i>">
	
								<CFOUTPUT>
								#PrevSTLNote#
								</CFOUTPUT>
--->
	
	
								<CFINCLUDE TEMPLATE="Report.ptC.cfm">
								<CFINCLUDE TEMPLATE="Report.ptD.cfm">
								<CFINCLUDE TEMPLATE="Report.ptE.cfm">
	
								</table>
	
								</div>
	      
						    </cfif>
--->	
    
    						<CFINCLUDE TEMPLATE="Report.ptB.cfm">
    
    

<!--- From <CFIF IsDefined("Form.CorpFinFormat") AND Form.CorpFinFormat EQ "CorpFinFormat"> --->
						<CFELSE>
	
	
							<CFINCLUDE TEMPLATE="Report.ptC.cfm">
							<CFINCLUDE TEMPLATE="Report.ptD.cfm">
							<CFINCLUDE TEMPLATE="Report.ptE.cfm">
	
	
							</table>
	
							</div>


<!--- Close <CFIF IsDefined("Form.CorpFinFormat") AND Form.CorpFinFormat EQ "CorpFinFormat"> --->
						</cfif>


<!---
							<CFINCLUDE TEMPLATE="Report.ptC.cfm">
							<CFINCLUDE TEMPLATE="Report.ptD.cfm">
							<CFINCLUDE TEMPLATE="Report.ptE.cfm">
	
	
							</table>
	
							</div>
--->














<!--- Close <CFLOOP QUERY="#CLRC_Query_Name#"> --->
					</cfloop>

<!--- Close <CFIF This_RecordCount EQ 0> --->
				</cfif>



<!--- Close     <CFIF Skip_CLRC_Query EQ "no"> --->
			</cfif>



<!--- Close <CFLOOP INDEX="Assess_Cutoff_List_Index" LIST="#Assess_Cutoff_List#"> --->
		</cfloop>



<!---
<!--- Close <CFIF Skip_Assess_Cutoff_List EQ "no"> --->
	</cfif>
--->



<!--- Close <CFLOOP INDEX="Case_Type_List_Index" LIST="#Case_Type_List#"> --->
	</cfloop>



<!--- Close <CFLOOP INDEX="Current_Removed_List_Index" LIST="#Current_Removed_List#"> --->
</cfloop>

