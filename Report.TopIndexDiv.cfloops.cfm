
<!---------------------- Report.TopIndexDiv.cfloops.cfm ---------------------->
<!---------------------------------------------------------------------------->
<!--- KS1 --->
	<!---<CFOUTPUT>
		Program = "Report.TopIndexDiv.cfloops.cfm at 4"
	</CFOUTPUT>--->
	
<!--- 
INCLUDEd in Report.TopIndexDiv.cfm.
CFLOOPs to cycle through cases in categories, assessment levels 

Includes cumulative calculations of amounts in case types, categories for Front Office Review and Short-term liabilities report formats


Assess_Cutoff_List set in Report.TopIndexDiv.cfm

--->


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
 		 <CFIF Current_Removed_List_Index EQ "Current" AND QueryNamePrefix EQ "Addendum">
 		<!---<CFIF (Current_Removed_List_Index EQ "Current" 
 				or Current_Removed_List_Index EQ "Removed")
 			AND QueryNamePrefix EQ "Addendum">--->
			<CFBREAK>

		</CFIF>


		 <CFSET Skip_Assess_Cutoff_List = "no"> 


<!---
<CFIF Skip_Assess_Cutoff_List EQ "no">
--->


		<CFLOOP INDEX="Assess_Cutoff_List_Index" LIST="#Assess_Cutoff_List#">
				
		<!--- KS2 --->
	<!---<CFOUTPUT>
		<br />
		Program = "Report.TopIndexDiv.cfloops.cfm   at 62"
		<br />
		Assess_Cutoff_List = #Assess_Cutoff_List#
		<br />
		Assess_Cutoff_List_Index = #Assess_Cutoff_List_Index#
		<br />
		Current_Removed_List_Index = #Current_Removed_List_Index#
		<br />
		
		<!---FrontOffcReviewFormat = #Form.FrontOffcReviewFormat#--->
		<!---CorpFinFormat_STL = #CorpFinFormat_STL#--->
		
	</CFOUTPUT>--->
		
		
		
		<CFIF Current_Removed_List_Index EQ "New">

					<CFIF Assess_Cutoff_List_Index EQ "NewTenMillionAndAbove" OR 
					Assess_Cutoff_List_Index EQ "MostLikelyUnderTenMillion_MaxReasonableOverOneMillion">

						 <!--- <cfif Assess_Cutoff_List_Index EQ "MostLikelyUnderTenMillion_MaxReasonableOverOneMillion">
							<cfoutput>I am here....topindex,cfloops line 62 </cfoutput><cfabort>
						</cfif>  --->
		
						<CFSET Skip_CLRC_Query = "no">
		
			        <CFELSE>
        
   						<CFSET Skip_CLRC_Query = "yes">
		
					</CFIF>

		<CFELSEIF Current_Removed_List_Index EQ "Removed">
<!---KS --->
					<!---<CFIF Assess_Cutoff_List_Index EQ "TenMillionAndAbove" 
							OR Assess_Cutoff_List_Index EQ "MostLikelyUnderTenMillion_MaxReasonableOverOneMillion">--->
									
					<CFIF Assess_Cutoff_List_Index EQ "TenMillionAndAbove" 
							OR Assess_Cutoff_List_Index EQ "MostLikelyUnderTenMillion_MaxReasonableOverOneMillion"
								OR Assess_Cutoff_List_Index EQ "UnderTenMillion">
						<CFSET Skip_CLRC_Query = "no">
		
			        <CFELSE>
        
   						<CFSET Skip_CLRC_Query = "yes">
		
					</CFIF>

		<CFELSEIF Current_Removed_List_Index EQ "Current">

<!---KS2 --->
					<!---<CFIF Assess_Cutoff_List_Index EQ "TenMillionAndAbove">--->
					
					<CFIF Assess_Cutoff_List_Index EQ "TenMillionAndAbove"
							or Assess_Cutoff_List_Index EQ "UnderTenMillion">
		
						<CFSET Skip_CLRC_Query = "no">
		
			        <CFELSE>
        
   						<CFSET Skip_CLRC_Query = "yes">
		
					</CFIF>
<!---KS --->
		<!---<CFELSE>
    
					<CFSET Skip_CLRC_Query = "no">--->

						

		</CFIF>			
	
	
	
				<!--- <CFELSEIF Assess_Cutoff_List_Index EQ "TenMillionAndAbove">
      
					<CFSET Skip_CLRC_Query = "yes">

    			<CFELSE>
    
					<CFSET Skip_CLRC_Query = "no">

				</cfif> --->


<!---
<CFSET Skip_CLRC_Query = "no">
--->








			<CFIF Skip_CLRC_Query EQ "no">



<!--- Query for each subcategory of cases, output used in CFLOOP --->
				<CFSET CLRC_Query_Name = QueryNamePrefix & "_" & "CONTINGENT_LIAB_GetRecord_Current" & "_" & Current_Removed_List_Index & "_" & Case_Type_List_Index & "_" & Assess_Cutoff_List_Index>


<!---  								<p>
In report.topindexdiv.cfloops.cfm at 84:
<br /> --->

<!---KS1 --->
	<!---<CFOUTPUT>
	<br>	
	In report.topindexdiv.cfloops.cfm at 175:
	<br>	
	Case_Type_List_Index = #Case_Type_List_Index#
	<br>
	CLRC_Query_Name = #CLRC_Query_Name#
	<br>
	Current_Removed_List = #Current_Removed_List#
	<br>
	Current_Removed_List_Index = #Current_Removed_List_Index#<br>
	Assess_Cutoff_List = #Assess_Cutoff_List#<br>
	Assess_Cutoff_List_Index = #Assess_Cutoff_List_Index#<br>
	Skip_CLRC_Query = #Skip_CLRC_Query#
	<br>
	</CFOUTPUT>--->
				
				<CFSET ASSESSMENT_PROBABILITY_Label_Count = 1>
				
				<CFSET Query_RecordCount = CLRC_Query_Name & ".RecordCount">
				
					<CFSET This_RecordCount = Evaluate(Query_RecordCount)> 	
				
				<CFSET Query_CurrentRow = CLRC_Query_Name & ".CurrentRow">
				<CFIF This_RecordCount EQ 0>
				
					<CFINCLUDE TEMPLATE="sectionheadings.cfswitch.cfm">
					<CFINCLUDE TEMPLATE="sectionheadings.cfset.cfm">
	
				<CFELSE>
				

					<CFLOOP QUERY="#CLRC_Query_Name#">
					
						<CFFLUSH interval=500>
					
						<CFSET This_Current_IndexRow = This_Current_IndexRow + 1>

						<CFINCLUDE TEMPLATE="DetermineThresholdStatus.cfm">
						
						
						<CFQUERY NAME="Get_MC_APPR_FLAG" DATASOURCE="lddb">
						SELECT MC_APPR_FLAG, ALT_APPR_FLAG
						FROM CONTINGENT_LIAB_C_E_CHECKLIST
						WHERE CASE_REC_ID_SEQUENCE = #CASE_REC_ID_SEQUENCE#
						AND (MC_APPR_FLAG <> 1 OR MC_APPR_FLAG IS NULL)
						</cfquery>
						
						<CFQUERY NAME="Get_MC_APPR_FLAG_Approved" DATASOURCE="lddb">
						SELECT MC_APPR_FLAG, ALT_APPR_FLAG
						FROM CONTINGENT_LIAB_C_E_CHECKLIST
						WHERE CASE_REC_ID_SEQUENCE = #CASE_REC_ID_SEQUENCE#
						AND MC_APPR_FLAG = 1
						</cfquery>
						
						
						<CFQUERY NAME="Get_Case_WithoutChecklist" DATASOURCE="lddb">
						SELECT DISTINCT CASE_REC_ID_SEQUENCE
						FROM CONTINGENT_LIAB_REPORT
						WHERE
						CASE_REC_ID_SEQUENCE = #CASE_REC_ID_SEQUENCE#
						
						AND
						DELETED_FLAG IS NULL


						AND CASE_REC_ID_SEQUENCE NOT IN
						(
						SELECT CASE_REC_ID_SEQUENCE
						FROM VIEW_CONTING_GET_CHKLISTCASES
						)
						
						</cfquery>


						<CFIF (IsDefined("Form.FrontOffcReviewFormat") AND Form.FrontOffcReviewFormat EQ "FrontOffcReviewFormat")
						OR
						(IsDefined("Form.CorpFinFormat_STL") AND Form.CorpFinFormat_STL EQ "CorpFinFormat_STL")>
						
							<CFSET TopIndex_Assess_Amt = "">


							<CFIF ASSESSMENT_AMOUNT NEQ "">
								<CFSET TopIndex_ASSESSMENT_AMOUNT_DisplayAmt = ASSESSMENT_AMOUNT / OneMillion>
							<CFELSE>
								<CFSET TopIndex_ASSESSMENT_AMOUNT_DisplayAmt = 0>
							</cfif>
							
							
							<CFIF IsDefined("TopIndex_ASSESSMENT_AMOUNT_DisplayAmt")>
								<CFSET TopIndex_Assess_Amt = NumberFormat(TopIndex_ASSESSMENT_AMOUNT_DisplayAmt, '__._') & MillionsNotation>
							</CFIF>



						</cfif>


						<CFINCLUDE TEMPLATE="sectionheadings.cfswitch.cfm">
							
						<CFINCLUDE TEMPLATE="sectionheadings.cfset.cfm">


						<CFQUERY NAME="Get_MC_APPR_FLAG_Index" DATASOURCE="lddb">
						SELECT MC_APPR_FLAG
						FROM CONTINGENT_LIAB_C_E_CHECKLIST
						WHERE CASE_REC_ID_SEQUENCE = #CASE_REC_ID_SEQUENCE#
						</cfquery>


						<CFIF IsDefined("EarlierRptDate")>

							<CFINCLUDE TEMPLATE="Report.TopIndexDiv.TopIndex_Assess_Amt.cfm">

							<span style="position:relative; left:15pt; width:90%; line-height:13px">
							
							
							
							<CFIF IsDefined("Form.CorpFinFormat") 
							AND 
							Form.CorpFinFormat EQ "CorpFinFormat">
							
								<CFOUTPUT>
							
							    <span id="Index_CaseNum_#This_Current_IndexRow#" style="font-size:8pt; font-weight:bold; background:green; text-align:center; color:white; width:21; height:10; padding-left:1px; border: 1px solid white; display:none">#This_Current_IndexRow#</span>
							
								<span id="TopIndex_Gray_#This_Current_IndexRow#">
								<!---
								GAC - 07/08/2013 - changed image reference
							    <img src="https://lawdept.usps.gov/inhouse/images/bulletblack.gray.GIF" width="11" height="11" style="margin-top:2px; border-bottom: 1px solid white; vertical-align:bottom">
								--->
							    <img src="../images/bulletblack.gray.GIF" width="11" height="11" style="margin-top:2px; border-bottom: 1px solid white; vertical-align:bottom">
							
							
							    </span>
							
								</CFOUTPUT>

							<CFELSE>

								<li><span style="width:3px"></span>
							
							</cfif>
							
<!--- From 	<CFIF IsDefined("EarlierRptDate")> --->
						<CFELSEIF 
						(
						DATE_LAST_UPDATE EQ "" 
						AND 
						(
						Get_MC_APPR_FLAG_Approved.RecordCount EQ 1 
						OR 
						Get_Case_WithoutChecklist.RecordCount GT 0
						)
						) 
						OR 
						(
						IsDefined("Form.CorpFinFormat") 
						AND 
						Form.CorpFinFormat EQ "CorpFinFormat"
						)>


							<CFINCLUDE TEMPLATE="Report.TopIndexDiv.TopIndex_Assess_Amt.cfm">


							<span style="position:relative; left:15pt; width:90%; line-height:13px">
							
							
							<CFIF IsDefined("Form.CorpFinFormat") AND Form.CorpFinFormat EQ "CorpFinFormat">
							
								<CFOUTPUT>
							
							    <span id="Index_CaseNum_#This_Current_IndexRow#" style="font-size:8pt; font-weight:bold; background:green; text-align:center; color:white; width:21; height:10; padding-left:1px; border: 1px solid white; display:none">#This_Current_IndexRow#</span>
							
								<span id="TopIndex_Gray_#This_Current_IndexRow#">
							    
								<!---
								GAC - 07/08/2013 - changed image reference
							    <img src="https://lawdept.usps.gov/inhouse/images/bulletblack.gray.GIF" width="11" height="11" style="margin-top:2px; border-bottom: 1px solid white; vertical-align:bottom">
								--->
							    <img src="../images/bulletblack.gray.GIF" width="11" height="11" style="margin-top:2px; border-bottom: 1px solid white; vertical-align:bottom">
							    
							    </span>
							
								</CFOUTPUT>

<!--- From <CFIF IsDefined("Form.CorpFinFormat") AND Form.CorpFinFormat EQ "CorpFinFormat"> --->
							<CFELSEIF IsDefined("Get_Auth_User_Office.OFFICE_PRM_KEY")>
							
							
								<CFIF Get_Auth_User_Office.OFFICE_PRM_KEY EQ ALT_LAW_DEPT_OFFICE>
							
									<li class="TopIndex_Gray">
							
							
<!---
Check for HQ Corporate and Postal Business Law (45). If yes, include Corporate (23) and HQ Pricing and Product Development (25).
--->

								<CFELSEIF Get_Auth_User_Office.OFFICE_PRM_KEY EQ 45>
							
									<CFIF ALT_LAW_DEPT_OFFICE EQ 23
									OR
									ALT_LAW_DEPT_OFFICE EQ 25>
							
										<li class="TopIndex_Gray">
							
									<CFELSE>
		
<!---        					
										<li class="TopIndex">
--->

<span style="position:relative; left:3pt">
<img src="../images/bulletblack.gif" width="11" height="11" style="margin-top:2px; border-bottom: 1px solid white; vertical-align:bottom">
</span>

                            
                            
                            
                            
                            
									</CFIF>



<!---
Check for HQ Procurement and Property Law (50). If yes, include HQ Civil Practice (22).
--->

								<CFELSEIF Get_Auth_User_Office.OFFICE_PRM_KEY EQ 50>
							
									<CFIF ALT_LAW_DEPT_OFFICE EQ 22>
							
										<li class="TopIndex_Gray">
							
									<CFELSE>
							
										<!---        					
										<li class="TopIndex">
--->

<span style="position:relative; left:3pt">
<img src="../images/bulletblack.gif" width="11" height="11" style="margin-top:2px; border-bottom: 1px solid white; vertical-align:bottom">
</span>

							
									</CFIF>



<!---
Check for HQ Legal Strategy (55). If yes, include HQ Civil Practice (22) and HQ Pricing and Product Development (25).
--->

								<CFELSEIF Get_Auth_User_Office.OFFICE_PRM_KEY EQ 55>
							
									<CFIF ALT_LAW_DEPT_OFFICE EQ 22
									OR
									ALT_LAW_DEPT_OFFICE EQ 25>
							
										<li class="TopIndex_Gray">
							
									<CFELSE>
							
										<!---        					
										<li class="TopIndex">
--->

<span style="position:relative; left:3pt">
<img src="../images/bulletblack.gif" width="11" height="11" style="margin-top:2px; border-bottom: 1px solid white; vertical-align:bottom">
</span>

							
									</CFIF>
							

<!---
Check for Northeast Windsor (16) or Northeast New York (7). If yes, include both.
--->

								<CFELSEIF Get_Auth_User_Office.OFFICE_PRM_KEY EQ 7
								OR
								Get_Auth_User_Office.OFFICE_PRM_KEY EQ 16>
							
									<CFIF ALT_LAW_DEPT_OFFICE EQ 7
									OR
									ALT_LAW_DEPT_OFFICE EQ 16>
							
										<li class="TopIndex_Gray">
							
									<CFELSE>
							
										<!---        					
										<li class="TopIndex">
--->

<span style="position:relative; left:3pt">
<img src="../images/bulletblack.gif" width="11" height="11" style="margin-top:2px; border-bottom: 1px solid white; vertical-align:bottom">
</span>

							
									</CFIF>



<!---
<!--- For Southern (104), include Southwest (4) and Southeast (5) --->
--->

								<CFELSEIF Get_Auth_User_Office.OFFICE_PRM_KEY EQ 104>
							
									<CFIF ALT_LAW_DEPT_OFFICE EQ 4
									OR
									ALT_LAW_DEPT_OFFICE EQ 5>
							
										<li class="TopIndex_Gray">
							
									<CFELSE>
							
										<!---        					
										<li class="TopIndex">
--->

<span style="position:relative; left:3pt">
<img src="../images/bulletblack.gif" width="11" height="11" style="margin-top:2px; border-bottom: 1px solid white; vertical-align:bottom">
</span>

							
									</CFIF>
							
							
							
								<CFELSE>
							
									<!---        					
										<li class="TopIndex">
--->

<span style="position:relative; left:3pt">
<img src="../images/bulletblack.gif" width="11" height="11" style="margin-top:2px; border-bottom: 1px solid white; vertical-align:bottom">
</span>

							
                            
<!--- Close <CFIF Get_Auth_User_Office.OFFICE_PRM_KEY EQ ALT_LAW_DEPT_OFFICE> --->
								</CFIF>


<!--- From <CFIF IsDefined("Form.CorpFinFormat") AND Form.CorpFinFormat EQ "CorpFinFormat"> --->
							<CFELSE>


								<!---        					
										<li class="TopIndex">
--->

<span style="position:relative; left:3pt">
<img src="../images/bulletblack.gif" width="11" height="11" style="margin-top:2px; border-bottom: 1px solid white; vertical-align:bottom">
</span>

							
<!--- Close <CFIF IsDefined("Form.CorpFinFormat") AND Form.CorpFinFormat EQ "CorpFinFormat"> --->
							</cfif>


							<CFIF ThresholdStatus EQ "Below" 
							AND NOT 
							(
							IsDefined("Form.CorpFinFormat") 
							AND 
							Form.CorpFinFormat EQ "CorpFinFormat"
							)>
							
							<!---
							<CFOUTPUT>
							STATUS_CODE_SELECTED = #STATUS_CODE_SELECTED#
							</CFOUTPUT>
							
							<br />
							--->
							
								<CFIF ListFind(STATUS_CODE_SELECTED, 4) GT 0>
							
									<CFSET TimesStyleFlag = "background:maroon; color:white;">
							
								<CFELSE>

									<CFSET TimesStyleFlag = "">
							
								</cfif>

<!---
margin-right:-1px; 
--->

								<CFOUTPUT>

								<span style="font-size:10pt; font-weight:bold; text-align:center; margin-right:2px; margin-left:1px; #TimesStyleFlag#" Report.TopIndexDiv.cfloops.cfm at 493>&times;</span>

								</CFOUTPUT>
							
							
							<CFELSE>

<!---
width:10px;
--->

								<CFOUTPUT>
								<span style="width:11px" Report.TopIndexDiv.cfloops.cfm at 506>&nbsp;</span>
							    </CFOUTPUT>
							
							</cfif>
							
                            
							<CFSET CheckFlag = "no">

<!--- From 	CFELSEIF <CFIF IsDefined("EarlierRptDate")> --->
						<CFELSE>


							<CFIF CheckFlag EQ "yes">
								<br>
							</cfif>
							
							
							<CFIF FINALIZED_FLAG EQ 1>
							
								<CFINCLUDE TEMPLATE="Report.TopIndexDiv.TopIndex_Assess_Amt.cfm">

								<span style="position:relative; left:19pt; width:90%; line-height:13px"><img src="Padlock.papersize.pct76.crop.b.gif" width="13" height="12" align="baseline" alt="Padlock image" style="margin-right:7px">
								
								
								<CFIF ThresholdStatus EQ "Below" 
								AND NOT 
								(
								IsDefined("Form.CorpFinFormat") 
								AND 
								Form.CorpFinFormat EQ "CorpFinFormat"
								)>
								
									<CFIF ListFind(STATUS_CODE_SELECTED, 4) GT 0>
								
										<CFSET TimesStyleFlag = "background:maroon; color:white;">
								
										<script language="javascript">
								
										if (document.getElementById("IndexLegendIncrxStatus"))
										IndexLegendIncrxStatus.style.display = "block";
								
										</script>

									<CFELSE>

										<CFSET TimesStyleFlag = "cfloops">
								
									</cfif>


									<CFOUTPUT>
									<span style="font-size:10pt; font-weight:bold; text-align:center; margin-right:-1px; margin-left:-10px; #TimesStyleFlag# at 384">&times;</span>
									</CFOUTPUT>
								
<!--- From <CFIF ThresholdStatus EQ "Below"  --->
								</cfif>


<!--- From <CFIF FINALIZED_FLAG EQ 1> --->
							<CFELSEIF CONCUR_MC EQ 1>

								<CFIF ThresholdStatus EQ "Below">
								
									<CFINCLUDE TEMPLATE="Report.TopIndexDiv.TopIndex_Assess_Amt.cfm">
								
									<CFIF NOT (IsDefined("Form.CorpFinFormat") AND Form.CorpFinFormat EQ "CorpFinFormat")>
								
										<span style="position:relative; left:20pt; width:90%; line-height:13px"><img src="checkmark.black.pct66.gif" width="13" height="13" align="baseline" alt="Checkmark image" style="margin-right:-6px">
									
										<span style="font-size:10pt; font-weight:bold; text-align:center; margin-right:-1px; at 410">&times;</span>
								
										<CFSET CheckFlag = "no">
								
									</CFIF>
								

								<CFELSE>


									<CFINCLUDE TEMPLATE="Report.TopIndexDiv.TopIndex_Assess_Amt.cfm">
								
								
									<span style="position:relative; left:20pt; width:90%; line-height:13px"><img src="checkmark.black.pct66.gif" width="13" height="13" align="baseline" alt="Checkmark image" style="margin-right:4px">
								
									<CFSET CheckFlag = "no">
								
                                
								</cfif>

<!--- From <CFIF FINALIZED_FLAG EQ 1> --->
							<CFELSEIF Get_MC_APPR_FLAG_Index.RecordCount GT 0>


								<CFIF Get_MC_APPR_FLAG_Index.MC_APPR_FLAG EQ 2>
								
									<CFIF IsDefined("Get_Auth_User_Office.OFFICE_PRM_KEY")>
								
										<CFIF Get_Auth_User_Office.OFFICE_PRM_KEY EQ ALT_LAW_DEPT_OFFICE>
								
											<CFSET SignalColor = "gray">
								
								<!---
								Check for Northeast Windsor (16) or Northeast New York (7). If yes, include both.
								--->
										<CFELSEIF Get_Auth_User_Office.OFFICE_PRM_KEY EQ 7
										OR
										Get_Auth_User_Office.OFFICE_PRM_KEY EQ 16>


											<CFIF ALT_LAW_DEPT_OFFICE EQ 7
											OR
											ALT_LAW_DEPT_OFFICE EQ 16>
								
												<CFSET SignalColor = "gray">
								
											<CFELSE>
								
												<CFSET SignalColor = "maroon">
								
											</cfif>


<!--- For Southern (104), include Southwest (4) and Southeast (5) --->
										<CFELSEIF Get_Auth_User_Office.OFFICE_PRM_KEY EQ 104>

											<CFIF ALT_LAW_DEPT_OFFICE EQ 104
											OR
											ALT_LAW_DEPT_OFFICE EQ 4>
								
												<CFSET SignalColor = "gray">
								
											<CFELSE>
								
												<CFSET SignalColor = "maroon">
								
											</cfif>


										<CFELSE>
								
											<CFSET SignalColor = "maroon">
								
										</cfif>


									<CFELSE>

										<CFSET SignalColor = "maroon">
								
<!--- Close <CFIF IsDefined("Get_Auth_User_Office.OFFICE_PRM_KEY")> --->
									</cfif>
								


									<CFINCLUDE TEMPLATE="Report.TopIndexDiv.TopIndex_Assess_Amt.cfm">
									
									<CFOUTPUT>
									<span style="position:relative; left:18pt; width:90%; line-height:13px"><span style="font-size:9pt; font-weight:bold; background:#SignalColor#; text-align:center; color:white; width:13; height:10; padding-left:1px; border: 1px solid white; margin-right:7px">D</span>
									</cfoutput>
									
									
									<CFIF ThresholdStatus EQ "Below" 
									AND NOT 
									(
									IsDefined("Form.CorpFinFormat") 
									AND 
									Form.CorpFinFormat EQ "CorpFinFormat"
									)>
                                    
										<span style="font-size:10pt; font-weight:bold; text-align:center; margin-right:-1px; margin-left:-10px; at 459">&times;</span>
									
									</cfif>


<!--- From <CFIF Get_MC_APPR_FLAG_Index.MC_APPR_FLAG EQ 2> --->
								<CFELSEIF Get_MC_APPR_FLAG_Index.MC_APPR_FLAG EQ 0 
								OR 
								Get_MC_APPR_FLAG_Index.MC_APPR_FLAG EQ "">


									<CFIF IsDefined("Get_Auth_User_Office.OFFICE_PRM_KEY")>
									
										<CFIF Get_Auth_User_Office.OFFICE_PRM_KEY EQ ALT_LAW_DEPT_OFFICE>
									
											<CFSET SignalColor = "gray">
									
									<!---
									Check for Northeast Windsor (16) or Northeast New York (7). If yes, include both.
									--->
										<CFELSEIF Get_Auth_User_Office.OFFICE_PRM_KEY EQ 7
										OR
										Get_Auth_User_Office.OFFICE_PRM_KEY EQ 16>
									
											<CFIF ALT_LAW_DEPT_OFFICE EQ 7
											OR
											ALT_LAW_DEPT_OFFICE EQ 16>
									
												<CFSET SignalColor = "gray">
									
											<CFELSE>
									
												<CFSET SignalColor = "orange">
									
											</cfif>


									<!--- For Southern (104), include Southwest (4) and Southeast (5) --->
										<CFELSEIF Get_Auth_User_Office.OFFICE_PRM_KEY EQ 104>
									
											<CFIF ALT_LAW_DEPT_OFFICE EQ 104
											OR
											ALT_LAW_DEPT_OFFICE EQ 4>
									
												<CFSET SignalColor = "gray">
									
											<CFELSE>
									
												<CFSET SignalColor = "orange">
									
											</cfif>


										<CFELSE>
									
											<CFSET SignalColor = "orange">
									
										</cfif>
									
                                    
									<CFELSE>
									
										<CFSET SignalColor = "orange">
									
                                    
<!--- Close <CFIF IsDefined("Get_Auth_User_Office.OFFICE_PRM_KEY")> --->
									</cfif>
									


									<CFINCLUDE TEMPLATE="Report.TopIndexDiv.TopIndex_Assess_Amt.cfm">
									
									<CFOUTPUT>
									<span style="position:relative; left:18pt; width:90%; line-height:13px"><span style="font-size:9pt; font-weight:bold; background:#SignalColor#; text-align:center; color:white; width:13; height:10; padding-left:1px; border: 1px solid white; margin-right:7px">N</span>
									</cfoutput>
									
									
									<CFIF ThresholdStatus EQ "Below" 
									AND NOT 
									(
									IsDefined("Form.CorpFinFormat") 
									AND 
									Form.CorpFinFormat EQ "CorpFinFormat"
									)>
                                    
										<span style="font-size:10pt; font-weight:bold; text-align:center; margin-right:-1px; margin-left:-10px; at 491">&times;</span>
									
									</cfif>
									
									
									<CFSET CheckFlag = "no">
									
<!--- From <CFIF Get_MC_APPR_FLAG_Index.MC_APPR_FLAG EQ 2> --->	
								<CFELSE>


									<CFIF IsDefined("Get_Auth_User_Office.OFFICE_PRM_KEY")>
									
										<CFIF Get_Auth_User_Office.OFFICE_PRM_KEY EQ ALT_LAW_DEPT_OFFICE>
									
											<CFSET SignalColor = "gray">
									
									<!---
									Check for Northeast Windsor (16) or Northeast New York (7). If yes, include both.
									--->
										<CFELSEIF Get_Auth_User_Office.OFFICE_PRM_KEY EQ 7
										OR
										Get_Auth_User_Office.OFFICE_PRM_KEY EQ 16>
									
											<CFIF ALT_LAW_DEPT_OFFICE EQ 7
											OR
											ALT_LAW_DEPT_OFFICE EQ 16>
									
												<CFSET SignalColor = "gray">
									
											<CFELSE>
									
												<CFSET SignalColor = "green">
									
											</cfif>



									<!--- For Southern (104), include Southwest (4) and Southeast (5) --->
										<CFELSEIF Get_Auth_User_Office.OFFICE_PRM_KEY EQ 104>
									
											<CFIF ALT_LAW_DEPT_OFFICE EQ 104
											OR
											ALT_LAW_DEPT_OFFICE EQ 4>
									
												<CFSET SignalColor = "gray">
									
											<CFELSE>
									
												<CFSET SignalColor = "green">
									
											</cfif>


										<CFELSE>
									
											<CFSET SignalColor = "green">
									
<!--- Close <CFIF Get_Auth_User_Office.OFFICE_PRM_KEY EQ ALT_LAW_DEPT_OFFICE> --->
										</cfif>
									
                                    
									<CFELSE>

										<CFSET SignalColor = "green">
									
                                    
<!--- Close <CFIF IsDefined("Get_Auth_User_Office.OFFICE_PRM_KEY")> --->
									</cfif>


									<CFINCLUDE TEMPLATE="Report.TopIndexDiv.TopIndex_Assess_Amt.cfm">
									
									
									<CFOUTPUT>
									<span style="position:relative; left:18pt; width:90%; line-height:13px"><span style="font-size:9pt; font-weight:bold; background:#SignalColor#; text-align:center; color:white; width:13; height:10; padding-left:1px; border: 1px solid white; margin-right:7px">U</span>
									</cfoutput>
									
									
									<CFIF ThresholdStatus EQ "Below" 
									AND NOT 
									(
									IsDefined("Form.CorpFinFormat") 
									AND 
									Form.CorpFinFormat EQ "CorpFinFormat"
									)>
                                    
										<span style="font-size:10pt; font-weight:bold; text-align:center; margin-right:-1px; margin-left:-10px; at 544">&times;</span>
									
									</cfif>
									
									
								</cfif>


							<CFELSE>



								<CFIF IsDefined("Get_Auth_User_Office.OFFICE_PRM_KEY")>

									<CFIF Get_Auth_User_Office.OFFICE_PRM_KEY EQ ALT_LAW_DEPT_OFFICE>
								
										<CFSET SignalColor = "gray">
								
								<!---
								Check for Northeast Windsor (16) or Northeast New York (7). If yes, include both.
								--->
									<CFELSEIF Get_Auth_User_Office.OFFICE_PRM_KEY EQ 7
									OR
									Get_Auth_User_Office.OFFICE_PRM_KEY EQ 16>
								
										<CFIF ALT_LAW_DEPT_OFFICE EQ 7
										OR
										ALT_LAW_DEPT_OFFICE EQ 16>
								
											<CFSET SignalColor = "gray">
								
										<CFELSE>
								
											<CFSET SignalColor = "green">
									
										</cfif>


								<!--- For Southern (104), include Southwest (4) and Southeast (5) --->
									<CFELSEIF Get_Auth_User_Office.OFFICE_PRM_KEY EQ 104>
								
										<CFIF ALT_LAW_DEPT_OFFICE EQ 104
										OR
										ALT_LAW_DEPT_OFFICE EQ 4>
								
											<CFSET SignalColor = "gray">
								
										<CFELSE>
								
											<CFSET SignalColor = "green">
								
										</cfif>
								
								
									<CFELSE>

										<CFSET SignalColor = "green">

									</cfif>


<!--- From <CFIF IsDefined("Get_Auth_User_Office.OFFICE_PRM_KEY")> --->
								<CFELSE>

									<CFSET SignalColor = "green">
								
								</cfif>
								



								<CFINCLUDE TEMPLATE="Report.TopIndexDiv.TopIndex_Assess_Amt.cfm">

								<CFOUTPUT>
								<span style="position:relative; left:18pt; width:90%; line-height:13px"><span style="font-size:9pt; font-weight:bold; background:#SignalColor#; text-align:center; color:white; width:13; height:10; padding-left:1px; border: 1px solid white; margin-right:7px">U</span>
								</cfoutput>
								
								
								<CFIF ThresholdStatus EQ "Below" 
								AND NOT 
								(
								IsDefined("Form.CorpFinFormat") 
								AND 
								Form.CorpFinFormat EQ "CorpFinFormat"
								)>
                                
									<span style="font-size:10pt; font-weight:bold; text-align:center; margin-right:-1px; margin-left:-10px; at 581">&times;</span>
								
								</cfif>
								
								
								<CFSET CheckFlag = "no">

<!--- Close <CFIF FINALIZED_FLAG EQ 1> --->								
							</cfif>
								
								
						</cfif>


						<CFOUTPUT>
						
						
						<CFIF IsDefined("Form.CorpFinFormat") AND Form.CorpFinFormat EQ "CorpFinFormat"
						AND
						(
						Assess_Cutoff_List_Index EQ "UnderTenMillion"
						OR
						Assess_Cutoff_List_Index EQ "MostLikelyUnder1Million_MaxReasonableOver1Million"
						
						OR
						Assess_Cutoff_List_Index EQ "MostLikelyUnderTenMillion_MaxReasonableOverTenMillion"

						OR
						Assess_Cutoff_List_Index EQ "MostLikelyUnderTenMillion_MaxReasonableOverOneMillion"
						
						)>
						
							#Trim(CASE_NAME)#</span>
						
						<CFELSEIF (IsDefined("Form.IndexOnly") AND Form.IndexOnly EQ "IndexOnly")
						OR
						(CONTINGENT_LIAB_GetRecord_Current_Count.Current_Count GT IndexOnlyCaseCountCutoff
						AND NOT IsDefined("Form.IndexOnly")
						AND NOT IsDefined("SelectedPC")
						AND NOT IsDefined("SelectedHQDept")
						)>
						
						
							<a href="javascript: openCLCaseWindow(#PRIMARYKEY#, '#ThisReportDate_Parm#', '#PrevReportDate_Parm#')">#Trim(CASE_NAME)#</a></span>
						
						
						<CFELSE>
						
							<a href="###PRIMARYKEY#">#Trim(CASE_NAME)#</a></span>
						
						</cfif>
						
						</cfoutput>

						<br>


						<CFIF 
						(
						IsDefined("Form.FrontOffcReviewFormat") 
						AND 
						Form.FrontOffcReviewFormat EQ "FrontOffcReviewFormat"
						)
						OR
						(
						IsDefined("Form.CorpFinFormat_STL") 
						AND 
						Form.CorpFinFormat_STL EQ "CorpFinFormat_STL"
						)>
						
						
						
							<CFSET Adjusted_ASSESSMENT_PROBABILITY_Label_Count = ASSESSMENT_PROBABILITY_Label_Count - 1>
							<CFSET Adjusted_CLAIM_CATEGORY_Label_Count = CLAIM_CATEGORY_Label_Count - 1>
						
							<CFIF Adjusted_ASSESSMENT_PROBABILITY_Label_Count GT 3>
								<CFSET Adjusted_ASSESSMENT_PROBABILITY_Label_Count = Adjusted_ASSESSMENT_PROBABILITY_Label_Count - 3>
							<CFELSE>
								<CFSET Adjusted_ASSESSMENT_PROBABILITY_Label_Count = Adjusted_ASSESSMENT_PROBABILITY_Label_Count>
							</cfif>



							<CFIF ASSESSMENT_AMOUNT NEQ "">
								<CFSET Addl_ASSESSMENT_AMOUNT = ASSESSMENT_AMOUNT>
							<CFELSE>
								<CFSET Addl_ASSESSMENT_AMOUNT = 0>
							</cfif>
						


<!---<CFOUTPUT>
In Report.TopIndexDiv.cfloops.cfm at 345: Adjusted_ASSESSMENT_PROBABILITY_Label_Count = #Adjusted_ASSESSMENT_PROBABILITY_Label_Count#

CASE_TYPE = #CASE_TYPE#

Assess_Cutoff_List_Index = #Assess_Cutoff_List_Index#
</CFOUTPUT>--->




							<CFSWITCH EXPRESSION="#Adjusted_ASSESSMENT_PROBABILITY_Label_Count#">
							
							<CFCASE VALUE="1">
							
								<CFIF CASE_TYPE EQ 1>
							
									<CFIF Assess_Cutoff_List_Index EQ "TenMillionAndAbove">
							
										<CFSET Liab_CumulativeProbable_TenMillionAndAbove[Adjusted_CLAIM_CATEGORY_Label_Count] = Liab_CumulativeProbable_TenMillionAndAbove[Adjusted_CLAIM_CATEGORY_Label_Count] + Addl_ASSESSMENT_AMOUNT>
							
									<CFELSEIF Assess_Cutoff_List_Index EQ "NewTenMillionAndAbove">
							
										<CFSET Liab_CumulativeProbable_NewTenMillionAndAbove[Adjusted_CLAIM_CATEGORY_Label_Count] = Liab_CumulativeProbable_NewTenMillionAndAbove[Adjusted_CLAIM_CATEGORY_Label_Count] + Addl_ASSESSMENT_AMOUNT>
							
<!---                            
									<CFELSEIF Assess_Cutoff_List_Index EQ "MostLikelyUnder1Million_MaxReasonableOver1Million">
							
										<CFSET Addendum_CumulativeProbable_MostLikelyUnder1Million_MaxReasonableOver1Million[Adjusted_CLAIM_CATEGORY_Label_Count] = Addendum_CumulativeProbable_MostLikelyUnder1Million_MaxReasonableOver1Million[Adjusted_CLAIM_CATEGORY_Label_Count] + Addl_ASSESSMENT_AMOUNT>
--->							

									<!--- <CFELSEIF Assess_Cutoff_List_Index EQ "MostLikelyUnderTenMillion_MaxReasonableOverTenMillion">
							
										<CFSET Addendum_CumulativeProbable_MostLikelyUnderTenMillion_MaxReasonableOverTenMillion[Adjusted_CLAIM_CATEGORY_Label_Count] = Addendum_CumulativeProbable_MostLikelyUnderTenMillion_MaxReasonableOverTenMillion[Adjusted_CLAIM_CATEGORY_Label_Count] + Addl_ASSESSMENT_AMOUNT> --->
							

									<CFELSEIF Assess_Cutoff_List_Index EQ "MostLikelyUnderTenMillion_MaxReasonableOverOneMillion">
							
										<CFSET Addendum_CumulativeProbable_MostLikelyUnderTenMillion_MaxReasonableOverOneMillion[Adjusted_CLAIM_CATEGORY_Label_Count] = Addendum_CumulativeProbable_MostLikelyUnderTenMillion_MaxReasonableOverOneMillion[Adjusted_CLAIM_CATEGORY_Label_Count] + Addl_ASSESSMENT_AMOUNT>







									<CFELSE>
							
										<CFSET Liab_CumulativeProbable_UnderTenMillion[Adjusted_CLAIM_CATEGORY_Label_Count] = Liab_CumulativeProbable_UnderTenMillion[Adjusted_CLAIM_CATEGORY_Label_Count] + Addl_ASSESSMENT_AMOUNT>
							
									</cfif>
							
								<CFELSEIF CASE_TYPE EQ 2>
							
									<CFIF Assess_Cutoff_List_Index EQ "TenMillionAndAbove">
							
										<CFSET Receiv_CumulativeProbable_TenMillionAndAbove[Adjusted_CLAIM_CATEGORY_Label_Count] = Receiv_CumulativeProbable_TenMillionAndAbove[Adjusted_CLAIM_CATEGORY_Label_Count] + Addl_ASSESSMENT_AMOUNT>
							
									<CFELSEIF Assess_Cutoff_List_Index EQ "NewTenMillionAndAbove">
							
										<CFSET Receiv_CumulativeProbable_NewTenMillionAndAbove[Adjusted_CLAIM_CATEGORY_Label_Count] = Receiv_CumulativeProbable_NewTenMillionAndAbove[Adjusted_CLAIM_CATEGORY_Label_Count] + Addl_ASSESSMENT_AMOUNT>
							
									<CFELSE>
							
										<CFSET Receiv_CumulativeProbable_UnderTenMillion[Adjusted_CLAIM_CATEGORY_Label_Count] = Receiv_CumulativeProbable_UnderTenMillion[Adjusted_CLAIM_CATEGORY_Label_Count] + Addl_ASSESSMENT_AMOUNT>
							
									</cfif>
							
								<CFELSEIF CASE_TYPE EQ 11>
							
									<CFIF Assess_Cutoff_List_Index EQ "TenMillionAndAbove">
						<!---KS --->			<!---<CFIF Assess_Cutoff_List_Index EQ "TenMillionAndAbove"
										OR Assess_Cutoff_List_Index EQ "UnderTenMillion">--->
									<CFSET Liab_CumulativeProbable_TenMillionAndAbove_Removed[Adjusted_CLAIM_CATEGORY_Label_Count] = Liab_CumulativeProbable_TenMillionAndAbove_Removed[Adjusted_CLAIM_CATEGORY_Label_Count] + Addl_ASSESSMENT_AMOUNT>
							
									<CFELSE>
							
									<CFSET Liab_CumulativeProbable_UnderTenMillion_Removed[Adjusted_CLAIM_CATEGORY_Label_Count] = Liab_CumulativeProbable_UnderTenMillion_Removed[Adjusted_CLAIM_CATEGORY_Label_Count] + Addl_ASSESSMENT_AMOUNT>
							
									</cfif>
							
								<CFELSEIF CASE_TYPE EQ 12>
							
									<CFIF Assess_Cutoff_List_Index EQ "TenMillionAndAbove">
						<!---KS --->			<!---<CFIF Assess_Cutoff_List_Index EQ "TenMillionAndAbove"
										OR Assess_Cutoff_List_Index EQ "UnderTenMillion">--->
									<CFSET Receiv_CumulativeProbable_TenMillionAndAbove_Removed[Adjusted_CLAIM_CATEGORY_Label_Count] = Receiv_CumulativeProbable_TenMillionAndAbove_Removed[Adjusted_CLAIM_CATEGORY_Label_Count] + Addl_ASSESSMENT_AMOUNT>
							
									<CFELSE>
							
									<CFSET Receiv_CumulativeProbable_UnderTenMillion_Removed[Adjusted_CLAIM_CATEGORY_Label_Count] = Receiv_CumulativeProbable_UnderTenMillion_Removed[Adjusted_CLAIM_CATEGORY_Label_Count] + Addl_ASSESSMENT_AMOUNT>
							
									</cfif>
							
								</cfif>
							
							</cfcase>


							<CFCASE VALUE="2">
							
								<CFIF CASE_TYPE EQ 1>
							
									<CFIF Assess_Cutoff_List_Index EQ "TenMillionAndAbove">
							
										<CFSET Liab_CumulativeReasPoss_TenMillionAndAbove[Adjusted_CLAIM_CATEGORY_Label_Count] = Liab_CumulativeReasPoss_TenMillionAndAbove[Adjusted_CLAIM_CATEGORY_Label_Count] + Addl_ASSESSMENT_AMOUNT>
							
									<CFELSEIF Assess_Cutoff_List_Index EQ "NewTenMillionAndAbove">
							
										<CFSET Liab_CumulativeReasPoss_NewTenMillionAndAbove[Adjusted_CLAIM_CATEGORY_Label_Count] = Liab_CumulativeReasPoss_NewTenMillionAndAbove[Adjusted_CLAIM_CATEGORY_Label_Count] + Addl_ASSESSMENT_AMOUNT>


<!---							
									<CFELSEIF Assess_Cutoff_List_Index EQ "MostLikelyUnder1Million_MaxReasonableOver1Million">
							
										<CFSET Addendum_CumulativeReasPoss_MostLikelyUnder1Million_MaxReasonableOver1Million[Adjusted_CLAIM_CATEGORY_Label_Count] = Addendum_CumulativeReasPoss_MostLikelyUnder1Million_MaxReasonableOver1Million[Adjusted_CLAIM_CATEGORY_Label_Count] + Addl_ASSESSMENT_AMOUNT>
							
                            
									<CFELSEIF Assess_Cutoff_List_Index EQ "MostLikelyUnderTenMillion_MaxReasonableOverTenMillion">
							
										<CFSET Addendum_CumulativeReasPoss_MostLikelyUnderTenMillion_MaxReasonableOverTenMillion[Adjusted_CLAIM_CATEGORY_Label_Count] = Addendum_CumulativeReasPoss_MostLikelyUnderTenMillion_MaxReasonableOverTenMillion[Adjusted_CLAIM_CATEGORY_Label_Count] + Addl_ASSESSMENT_AMOUNT>
--->
                            
									<CFELSEIF Assess_Cutoff_List_Index EQ "MostLikelyUnderTenMillion_MaxReasonableOverOneMillion">
							
										<CFSET Addendum_CumulativeReasPoss_MostLikelyUnderTenMillion_MaxReasonableOverOneMillion[Adjusted_CLAIM_CATEGORY_Label_Count] = Addendum_CumulativeReasPoss_MostLikelyUnderTenMillion_MaxReasonableOverOneMillion[Adjusted_CLAIM_CATEGORY_Label_Count] + Addl_ASSESSMENT_AMOUNT>
                            
                            
									<CFELSE>
							
										<CFSET Liab_CumulativeReasPoss_UnderTenMillion[Adjusted_CLAIM_CATEGORY_Label_Count] = Liab_CumulativeReasPoss_UnderTenMillion[Adjusted_CLAIM_CATEGORY_Label_Count] + Addl_ASSESSMENT_AMOUNT>
							
									</cfif>
							
								<CFELSEIF CASE_TYPE EQ 2>
							
									<CFIF Assess_Cutoff_List_Index EQ "TenMillionAndAbove">
							
										<CFSET Receiv_CumulativeReasPoss_TenMillionAndAbove[Adjusted_CLAIM_CATEGORY_Label_Count] = Receiv_CumulativeReasPoss_TenMillionAndAbove[Adjusted_CLAIM_CATEGORY_Label_Count] + Addl_ASSESSMENT_AMOUNT>
							
									<CFELSEIF Assess_Cutoff_List_Index EQ "NewTenMillionAndAbove">
							
										<CFSET Receiv_CumulativeReasPoss_NewTenMillionAndAbove[Adjusted_CLAIM_CATEGORY_Label_Count] = Receiv_CumulativeReasPoss_NewTenMillionAndAbove[Adjusted_CLAIM_CATEGORY_Label_Count] + Addl_ASSESSMENT_AMOUNT>
							
									<CFELSE>
							
										<CFSET Receiv_CumulativeReasPoss_UnderTenMillion[Adjusted_CLAIM_CATEGORY_Label_Count] = Receiv_CumulativeReasPoss_UnderTenMillion[Adjusted_CLAIM_CATEGORY_Label_Count] + Addl_ASSESSMENT_AMOUNT>
							
									</cfif>
							
								<CFELSEIF CASE_TYPE EQ 11>
							
									<CFIF Assess_Cutoff_List_Index EQ "TenMillionAndAbove">
							
										<CFSET Liab_CumulativeReasPoss_TenMillionAndAbove_Removed[Adjusted_CLAIM_CATEGORY_Label_Count] = Liab_CumulativeReasPoss_TenMillionAndAbove_Removed[Adjusted_CLAIM_CATEGORY_Label_Count] + Addl_ASSESSMENT_AMOUNT>
							
									<CFELSE>
							
										<CFSET Liab_CumulativeReasPoss_UnderTenMillion_Removed[Adjusted_CLAIM_CATEGORY_Label_Count] = Liab_CumulativeReasPoss_UnderTenMillion_Removed[Adjusted_CLAIM_CATEGORY_Label_Count] + Addl_ASSESSMENT_AMOUNT>
							
									</cfif>
							
								<CFELSEIF CASE_TYPE EQ 12>
							
									<CFIF Assess_Cutoff_List_Index EQ "TenMillionAndAbove">
							
										<CFSET Receiv_CumulativeReasPoss_TenMillionAndAbove_Removed[Adjusted_CLAIM_CATEGORY_Label_Count] = Receiv_CumulativeReasPoss_TenMillionAndAbove_Removed[Adjusted_CLAIM_CATEGORY_Label_Count] + Addl_ASSESSMENT_AMOUNT>
							
									<CFELSE>
							
										<CFSET Receiv_CumulativeReasPoss_UnderTenMillion_Removed[Adjusted_CLAIM_CATEGORY_Label_Count] = Receiv_CumulativeReasPoss_UnderTenMillion_Removed[Adjusted_CLAIM_CATEGORY_Label_Count] + Addl_ASSESSMENT_AMOUNT>
							
									</cfif>
							
								</cfif>
							
							</cfcase>
							
							<CFCASE VALUE="3">
							
								<CFIF CASE_TYPE EQ 1>
							
									<CFIF Assess_Cutoff_List_Index EQ "TenMillionAndAbove">
							
										<CFSET Liab_CumulativeRemote_TenMillionAndAbove[Adjusted_CLAIM_CATEGORY_Label_Count] = Liab_CumulativeRemote_TenMillionAndAbove[Adjusted_CLAIM_CATEGORY_Label_Count] + Addl_ASSESSMENT_AMOUNT>
							
									<CFELSEIF Assess_Cutoff_List_Index EQ "NewTenMillionAndAbove">
							
										<CFSET Liab_CumulativeRemote_NewTenMillionAndAbove[Adjusted_CLAIM_CATEGORY_Label_Count] = Liab_CumulativeRemote_NewTenMillionAndAbove[Adjusted_CLAIM_CATEGORY_Label_Count] + Addl_ASSESSMENT_AMOUNT>
							
<!---                            
									<CFELSEIF Assess_Cutoff_List_Index EQ "MostLikelyUnder1Million_MaxReasonableOver1Million">
							
										<CFSET Addendum_CumulativeRemote_MostLikelyUnder1Million_MaxReasonableOver1Million[Adjusted_CLAIM_CATEGORY_Label_Count] = Addendum_CumulativeRemote_MostLikelyUnder1Million_MaxReasonableOver1Million[Adjusted_CLAIM_CATEGORY_Label_Count] + Addl_ASSESSMENT_AMOUNT>
							

									<CFELSEIF Assess_Cutoff_List_Index EQ "MostLikelyUnderTenMillion_MaxReasonableOverTenMillion">
							
										<CFSET Addendum_CumulativeRemote_MostLikelyUnderTenMillion_MaxReasonableOverTenMillion[Adjusted_CLAIM_CATEGORY_Label_Count] = Addendum_CumulativeRemote_MostLikelyUnderTenMillion_MaxReasonableOverTenMillion[Adjusted_CLAIM_CATEGORY_Label_Count] + Addl_ASSESSMENT_AMOUNT>
--->							

									<CFELSEIF Assess_Cutoff_List_Index EQ "MostLikelyUnderTenMillion_MaxReasonableOverOneMillion">
							
										<CFSET Addendum_CumulativeRemote_MostLikelyUnderTenMillion_MaxReasonableOverOneMillion[Adjusted_CLAIM_CATEGORY_Label_Count] = Addendum_CumulativeRemote_MostLikelyUnderTenMillion_MaxReasonableOverOneMillion[Adjusted_CLAIM_CATEGORY_Label_Count] + Addl_ASSESSMENT_AMOUNT>




									<CFELSE>
							
										<CFSET Liab_CumulativeRemote_UnderTenMillion[Adjusted_CLAIM_CATEGORY_Label_Count] = Liab_CumulativeRemote_UnderTenMillion[Adjusted_CLAIM_CATEGORY_Label_Count] + Addl_ASSESSMENT_AMOUNT>
							
									</cfif>
							
								<CFELSEIF CASE_TYPE EQ 2>
							
									<CFIF Assess_Cutoff_List_Index EQ "TenMillionAndAbove">
							
										<CFSET Receiv_CumulativeRemote_TenMillionAndAbove[Adjusted_CLAIM_CATEGORY_Label_Count] = Receiv_CumulativeRemote_TenMillionAndAbove[Adjusted_CLAIM_CATEGORY_Label_Count] + Addl_ASSESSMENT_AMOUNT>
							
									<CFELSEIF Assess_Cutoff_List_Index EQ "NewTenMillionAndAbove">
							
										<CFSET Receiv_CumulativeRemote_NewTenMillionAndAbove[Adjusted_CLAIM_CATEGORY_Label_Count] = Receiv_CumulativeRemote_NewTenMillionAndAbove[Adjusted_CLAIM_CATEGORY_Label_Count] + Addl_ASSESSMENT_AMOUNT>
							
									<CFELSE>
							
										<CFSET Receiv_CumulativeRemote_UnderTenMillion[Adjusted_CLAIM_CATEGORY_Label_Count] = Receiv_CumulativeRemote_UnderTenMillion[Adjusted_CLAIM_CATEGORY_Label_Count] + Addl_ASSESSMENT_AMOUNT>
							
									</cfif>
							
								<CFELSEIF CASE_TYPE EQ 11>
							
									<CFIF Assess_Cutoff_List_Index EQ "TenMillionAndAbove">
							
									<CFSET Liab_CumulativeRemote_TenMillionAndAbove_Removed[Adjusted_CLAIM_CATEGORY_Label_Count] = Liab_CumulativeRemote_TenMillionAndAbove_Removed[Adjusted_CLAIM_CATEGORY_Label_Count] + Addl_ASSESSMENT_AMOUNT>
							
									<CFELSE>
							
									<CFSET Liab_CumulativeRemote_UnderTenMillion_Removed[Adjusted_CLAIM_CATEGORY_Label_Count] = Liab_CumulativeRemote_UnderTenMillion_Removed[Adjusted_CLAIM_CATEGORY_Label_Count] + Addl_ASSESSMENT_AMOUNT>
							
									</cfif>
							
								<CFELSEIF CASE_TYPE EQ 12>
							
									<CFIF Assess_Cutoff_List_Index EQ "TenMillionAndAbove">
							
									<CFSET Receiv_CumulativeRemote_TenMillionAndAbove_Removed[Adjusted_CLAIM_CATEGORY_Label_Count] = Receiv_CumulativeRemote_TenMillionAndAbove_Removed[Adjusted_CLAIM_CATEGORY_Label_Count] + Addl_ASSESSMENT_AMOUNT>
							
									<CFELSE>
							
									<CFSET Receiv_CumulativeRemote_UnderTenMillion_Removed[Adjusted_CLAIM_CATEGORY_Label_Count] = Receiv_CumulativeRemote_UnderTenMillion_Removed[Adjusted_CLAIM_CATEGORY_Label_Count] + Addl_ASSESSMENT_AMOUNT>
							
									</cfif>
							
								</cfif>
							
							</cfcase>
							
							</cfswitch>


<!--- Close <CFIF FINALIZED_FLAG EQ 1> --->
						</cfif>


<!--- Close <CFLOOP QUERY="#CLRC_Query_Name#"> --->
					</cfloop>


					<CFIF This_RecordCount GT 0 AND ASSESSMENT_PROBABILITY_Label_Count NEQ 1>

						<CFINCLUDE TEMPLATE="CLAIM_CATEGORY_Label_Count.loop.cfm">

						<CFINCLUDE TEMPLATE="ASSESSMENT_PROBABILITY_Label_Count.loop.cfm">

					<CFELSE>

					</cfif>



<!--- Close <CFIF This_RecordCount EQ 0> --->
				</CFIF>
                
                
<!--- Close  <CFIF Skip_CLRC_Query EQ "no"> --->
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


<script language="javascript">

<CFOUTPUT>
total_This_Current_IndexRow = #This_Current_IndexRow#;
</CFOUTPUT>

</script>




