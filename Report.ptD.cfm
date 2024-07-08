<cfinclude template="MfaCookieCheck.cfm">
<!------------------------- Report.ptD.cfm --------------------------->
<!---------------------------------------------------------------------------->
<!--- KS1 --->
	<!---<CFOUTPUT>
		Program = "Report.ptD.cfm at 4"
	</CFOUTPUT>--->



<tr>

<th align="right" valign="top">


Change 
in
Status


</th>

<td>



<CFIF DateCompare(ThisReportDate, NewCLProtocolReportDate) GE 0>
	
	
	<CFIF STATUS_CODE_SELECTED NEQ "">
	
		
		<CFINCLUDE TEMPLATE="Loop.Status_Code_List.cfm">
		
		
	<CFELSE>
		
		<CFIF UpdateNeededFlag EQ "yes" AND (STATUS_CODE EQ 2 OR STATUS_CODE EQ "")>
		
			<!---<strong>[Unspecified]&nbsp;<span class='ClickEdit'>Click "Edit This Case Record" to specify</span></strong>--->
		
		<CFELSE>
		
			<CFSET Status_Code_Var = STATUS_CODE>
			<CFINCLUDE TEMPLATE="cfswitch.status_code.cfm">
			
			<CFIF Status_Code_Label EQ "[Unspecified]" OR Status_Code_Var EQ 3>
				<!---<CFSET Status_Code_Label = "<strong>" & Status_Code_Label & "&nbsp;<span class='ClickEdit'>Click ""Edit This Case Record"" to specify</span>" & "</strong>">--->
			<CFELSEIF Status_Code_Var NEQ 2>
				<CFSET Status_Code_Label = "<li><strong>" & Status_Code_Label & "</strong>">
			</CFIF>
			
			<CFOUTPUT>
			#Status_Code_Label#
			</cfoutput>
			
		</CFIF>
		
		
	</CFIF>
	
	
	<!--- For ReportDate earlier than NewCLProtocolReportDate: --->
<CFELSE>

	
	<CFIF STATUS_CODE NEQ 3>
	
		<CFSET Status_Code_Var = STATUS_CODE>
		
		<CFINCLUDE TEMPLATE="cfswitch.status_code.cfm">
		
		<CFSET StatusCodeText = Status_Code_Label>
		
		
		<CFIF ThisReportDate NEQ EarliestReportDate AND PrevReportDate NEQ "">
		
			<CFSET Status_Code_Var = CONTINGENT_LIAB_GetRecord_PrevRpt.STATUS_CODE>
		
			<CFINCLUDE TEMPLATE="cfswitch.status_code.cfm">
		
			<CFSET PrevStatusCodeText = Status_Code_Label>
		
		</cfif>
		
		
		
		<CFSET NewList = StatusCodeText>
		
		<CFIF ThisReportDate NEQ EarliestReportDate AND PrevReportDate NEQ "">
			<CFSET OldList = PrevStatusCodeText>
		</cfif>
		
		<CFIF STATUS_CODE EQ 2>
			<CFSET OldList = "No Change Since Last Report">
		</cfif>
		
		
		
		<CFIF StatusCodeText NEQ "New This Quarter" AND StatusCodeText NEQ "Updated This Quarter">
			<CFSET Status_Compare_Flag = "yes">
		</cfif>

		<CFINCLUDE TEMPLATE="textcompare.cfm">



		<CFSET Status_Compare_Flag = "no">
		
		
		
	<CFELSEIF STATUS_CODE EQ 3 AND (NOT IsDefined("CONTINGENT_LIAB_GetRecord_PrevRpt.RecordCount") OR (IsDefined("CONTINGENT_LIAB_GetRecord_PrevRpt.RecordCount") AND CONTINGENT_LIAB_GetRecord_PrevRpt.RecordCount EQ 0))>
		
		
		<!--- 
		
		Changed 3/21/08 specifically for Pittsburgh Metro APWU v. USPS, Case Number  07-0781, at request of Steve Boardman
		
		--->
		
		
		<strong>Change in Assessment or Amount Sought (Still Meets Threshold)</strong>
		
		
	<CFELSEIF STATUS_CODE EQ 3 AND IsDefined("CONTINGENT_LIAB_GetRecord_PrevRpt.RecordCount") AND CONTINGENT_LIAB_GetRecord_PrevRpt.RecordCount EQ 1>
		
		
		<!--- For case where ASSESSMENT_AMOUNT_UPPER was null in previous report, but was entered in current report and is equal to ASSESSMENT_AMOUNT, changing STATUS_CODE to 3, but with no actual change: --->
		<CFIF (IsDefined("ASSESSMENT_PROBABILITY_Diff") AND ASSESSMENT_PROBABILITY_Diff EQ "no") 
		AND
		(IsDefined("ASSESSMENT_AMOUNT_Diff") AND ASSESSMENT_AMOUNT_Diff EQ "no") 
		AND
		(IsDefined("ASSESSMENT_AMOUNT_UPPER_Diff") AND ASSESSMENT_AMOUNT_UPPER_Diff EQ "no")>
		
			No Change Since Last Report
		
		<CFELSE>
		
			<strong>Previously Reported as
		
			<CFIF IsDefined("AMOUNT_SOUGHT_Diff") AND AMOUNT_SOUGHT_Diff EQ "yes">

				Amount&nbsp;Sought:
			
				<CFIF CONTINGENT_LIAB_GetRecord_PrevRpt.AMOUNT_SOUGHT NEQ "">
			
					<CFSET Prev_AMOUNT_SOUGHT_DisplayAmt = CONTINGENT_LIAB_GetRecord_PrevRpt.AMOUNT_SOUGHT / OneMillion>
					<CFSET Prev_AMOUNT_SOUGHT_DisplayAmt_NumFmt = NumberFormat(Prev_AMOUNT_SOUGHT_DisplayAmt, '_$__._')>
			
					<CFOUTPUT>
			
					<CFIF ASSESSMENT_PROBABILITY_Diff EQ "yes" OR ASSESSMENT_AMOUNT_Diff EQ "yes" OR (IsDefined("ASSESSMENT_AMOUNT_UPPER_Diff") AND ASSESSMENT_AMOUNT_UPPER_Diff EQ "yes")>
						#Prev_AMOUNT_SOUGHT_DisplayAmt_NumFmt# Million;
					<CFELSE>
						#Prev_AMOUNT_SOUGHT_DisplayAmt_NumFmt# Million
					</cfif>
			
					</cfoutput>
			
				<CFELSE>
			
					<CFIF CONTINGENT_LIAB_GetRecord_PrevRpt.AMOUNT_SOUGHT_UNKNOWN NEQ "" AND CONTINGENT_LIAB_GetRecord_PrevRpt.AMOUNT_SOUGHT_UNKNOWN NEQ 0>
				
						<CFLOOP INDEX="Prev_AMOUNT_SOUGHT_UNKNOWN_Index" FROM="1" TO="#ListLen(Unknown_NA_List)#">
					
							<CFIF CONTINGENT_LIAB_GetRecord_PrevRpt.AMOUNT_SOUGHT_UNKNOWN EQ Prev_AMOUNT_SOUGHT_UNKNOWN_Index>
								<CFSET Prev_AMOUNT_SOUGHT_UNKNOWN_Word = "[" & ListGetAt(Unknown_NA_List, Prev_AMOUNT_SOUGHT_UNKNOWN_Index) & "]">
								<CFBREAK>
							</cfif>
					
						</cfloop>
					
					
						<CFOUTPUT>
					
						<CFIF (IsDefined("ASSESSMENT_PROBABILITY_Diff") AND ASSESSMENT_PROBABILITY_Diff EQ "yes") OR (IsDefined("ASSESSMENT_AMOUNT_Diff") AND ASSESSMENT_AMOUNT_Diff EQ "yes") OR (IsDefined("ASSESSMENT_AMOUNT_UPPER_Diff") AND ASSESSMENT_AMOUNT_UPPER_Diff EQ "yes")>
							#Prev_AMOUNT_SOUGHT_UNKNOWN_Word#;
						<CFELSE>
							#Prev_AMOUNT_SOUGHT_UNKNOWN_Word#
						</cfif>
					
						</CFOUTPUT>
					
					<CFELSE>
					
						<CFIF (IsDefined("ASSESSMENT_PROBABILITY_Diff") AND ASSESSMENT_PROBABILITY_Diff EQ "yes") OR (IsDefined("ASSESSMENT_AMOUNT_Diff") AND ASSESSMENT_AMOUNT_Diff EQ "yes") OR (IsDefined("ASSESSMENT_AMOUNT_UPPER_Diff") AND ASSESSMENT_AMOUNT_UPPER_Diff EQ "yes")>
						_____;
					
						<CFELSE>
						_____
					
						</cfif>
				
					</cfif>
				
				
				</cfif>
			
			</cfif>
		
		
			
			<CFIF (IsDefined("ASSESSMENT_PROBABILITY_Diff") AND ASSESSMENT_PROBABILITY_Diff EQ "yes") OR (IsDefined("ASSESSMENT_AMOUNT_Diff") AND ASSESSMENT_AMOUNT_Diff EQ "yes") OR (IsDefined("ASSESSMENT_AMOUNT_UPPER_Diff") AND ASSESSMENT_AMOUNT_UPPER_Diff EQ "yes")>
		
				Assessment:
			
				<CFIF CONTINGENT_LIAB_GetRecord_PrevRpt.ASSESSMENT_PROBABILITY NEQ "">
			
					<CFSET ThisPrev_ASSESSMENT_PROBABILITY = ListGetAt(ASSESSMENT_PROBABILITY_LabelList, CONTINGENT_LIAB_GetRecord_PrevRpt.ASSESSMENT_PROBABILITY)>
			
					<CFOUTPUT>
					
					#ThisPrev_ASSESSMENT_PROBABILITY# /
			
					</cfoutput>
			
				</cfif>
			
			
				<CFIF CONTINGENT_LIAB_GetRecord_PrevRpt.ASSESSMENT_AMOUNT NEQ "">
			
					<CFSET Prev_ASSESSMENT_AMOUNT_DisplayAmt = CONTINGENT_LIAB_GetRecord_PrevRpt.ASSESSMENT_AMOUNT / OneMillion>
			
					<CFOUTPUT>
					#NumberFormat(Prev_ASSESSMENT_AMOUNT_DisplayAmt, '_$__._')#
					</cfoutput>
			
			
					<CFIF CONTINGENT_LIAB_GetRecord_PrevRpt.ASSESSMENT_AMOUNT NEQ CONTINGENT_LIAB_GetRecord_PrevRpt.ASSESSMENT_AMOUNT_UPPER
					AND
					CONTINGENT_LIAB_GetRecord_PrevRpt.ASSESSMENT_AMOUNT_UPPER NEQ "">
			
			
						<CFSET Prev_ASSESSMENT_AMOUNT_UPPER_DisplayAmt = CONTINGENT_LIAB_GetRecord_PrevRpt.ASSESSMENT_AMOUNT_UPPER / OneMillion>
			
						<CFOUTPUT>
						- #NumberFormat(Prev_ASSESSMENT_AMOUNT_UPPER_DisplayAmt, '_$__._')#
						</cfoutput>
			
					</cfif>
			
				<CFELSE>
				_____
			
				</cfif>
			
				Million
			
			
			
			</cfif>
		
			</strong>
		
		<!--- Close <CFIF (IsDefined("ASSESSMENT_PROBABILITY_Diff") AND ASSESSMENT_PROBABILITY_Diff EQ "no") 
		AND
		(IsDefined("ASSESSMENT_AMOUNT_Diff") AND ASSESSMENT_AMOUNT_Diff EQ "no") 
		AND
		(IsDefined("ASSESSMENT_AMOUNT_UPPER_Diff") AND ASSESSMENT_AMOUNT_UPPER_Diff EQ "no")>
		--->
		</cfif>

		
<!--- Close <CFIF STATUS_CODE NEQ 3> --->
	</cfif>
	
	
	
<!--- Close <CFIF DateCompare(ThisReportDate, NewCLProtocolReportDate) GE 0> --->
</cfif>

</td>

</tr>


<!---
<CFIF STATUS_CODE EQ 12 OR STATUS_CODE EQ 13>
--->

<CFIF ListContains(STATUS_CODE_SELECTED, 12) GT 0 
OR
ListContains(STATUS_CODE_SELECTED, 13) GT 0>


	
	<tr>
	
	<th align="right" valign="top">
	Payout Amount
	</th>
	
	<td>
	
	
	<CFIF PAYOUT_AMOUNT NEQ "">
	
		
		<CFSET PAYOUT_AMOUNT_DisplayAmt = PAYOUT_AMOUNT / OneMillion>
		
		<CFSET NewList = NumberFormat(PAYOUT_AMOUNT_DisplayAmt, '_$__._') & " Million">
		
		<CFIF ThisReportDate NEQ EarliestReportDate AND PrevReportDate NEQ "">
		
			<CFIF CONTINGENT_LIAB_GetRecord_PrevRpt.PAYOUT_AMOUNT NEQ "">
				<CFSET Old_PAYOUT_AMOUNT_DisplayAmt = CONTINGENT_LIAB_GetRecord_PrevRpt.PAYOUT_AMOUNT / OneMillion>
				<CFSET OldList = NumberFormat(Old_PAYOUT_AMOUNT_DisplayAmt, '_$__._') & " Million">
			<CFELSE>
				<CFSET OldList = "">
			</cfif>
		
		</cfif>
		
		
		<CFINCLUDE TEMPLATE="textcompare.cfm">
		
		
		<CFIF DiffFlag EQ "yes">
			<CFSET PAYOUT_AMOUNT_Diff = "yes">
		<CFELSE>
			<CFSET PAYOUT_AMOUNT_Diff = "no">
		</cfif>
		
		
		<!--- <CFIF PAYOUT_AMOUNT NEQ ""> --->
	<CFELSEIF PAYOUT_LT_100K NEQ "">
		
		<CFIF PAYOUT_LT_100K EQ 1>
			<CFSET NewList = "Less than $100,000">
		<CFELSEIF PAYOUT_LT_100K EQ 2>
			<CFSET NewList = "[None or N/A]">
		<CFELSE>
			<CFSET NewList = "">
		</cfif>
		
		<CFIF ThisReportDate NEQ EarliestReportDate AND PrevReportDate NEQ "">
		
			<CFIF CONTINGENT_LIAB_GetRecord_PrevRpt.PAYOUT_LT_100K NEQ "">
			
				<CFIF CONTINGENT_LIAB_GetRecord_PrevRpt.PAYOUT_LT_100K EQ 1>
					<CFSET OldList = "Less than $100,000">
				<CFELSEIF CONTINGENT_LIAB_GetRecord_PrevRpt.PAYOUT_LT_100K EQ 2>
					<CFSET OldList = "[None or N/A]">
				<CFELSE>
					<CFSET OldList = "">
				</cfif>
			
			</cfif>
		
		</cfif>
		
		<CFINCLUDE TEMPLATE="textcompare.cfm">
		
		
		<CFIF DiffFlag EQ "yes">
			<CFSET PAYOUT_LT_100K_Diff = "yes">
		<CFELSE>
			<CFSET PAYOUT_LT_100K_Diff = "no">
		</cfif>
		
		
	<CFELSE>
		
		_____
		
	
	</cfif>
	
	</td>
	
	</tr>


<!--- Close <CFIF ListContains(STATUS_CODE_SELECTED, 12) GT 0  --->
</cfif>

<CFIF ListContains(STATUS_CODE_SELECTED, 12) GT 0 
OR
ListContains(STATUS_CODE_SELECTED, 13) GT 0>

	
	<tr>
	
	
	<th align="right" valign="top" style="line-height:80%">
	
	Payout Date
	<br>
	or
	<br>
	Date Finalized
	
	</th>
	
	
	<td style="vertical-align:middle">
	
	<CFIF PAYOUT_DATE EQ "">
	
		
		<CFSET PAYOUT_DATE_NA_Word = "_____">
		
		<CFIF PAYOUT_DATE_NA EQ 1>
			<CFSET PAYOUT_DATE_NA_Word = "[None or N/A]">
		</cfif>
		
		
		<CFSET NewList = PAYOUT_DATE_NA_Word>
		
		<CFIF ThisReportDate NEQ EarliestReportDate AND PrevReportDate NEQ "">
		
			<CFIF CONTINGENT_LIAB_GetRecord_PrevRpt.PAYOUT_DATE_NA NEQ "">
				<CFSET OldList = CONTINGENT_LIAB_GetRecord_PrevRpt.PAYOUT_DATE_NA>
			</cfif>
		
		<CFELSE>
			<CFSET OldList = "">
		</cfif>
		
		<CFINCLUDE TEMPLATE="textcompare.cfm">
		
		
	<CFELSE>
		
		<CFSET NewList = DateFormat(PAYOUT_DATE, "mm/dd/yyyy")>
		
		<CFIF ThisReportDate NEQ EarliestReportDate AND PrevReportDate NEQ "">
		
			<CFIF CONTINGENT_LIAB_GetRecord_PrevRpt.PAYOUT_DATE NEQ "">
				<CFSET OldList = DateFormat(CONTINGENT_LIAB_GetRecord_PrevRpt.PAYOUT_DATE, "mm/dd/yyyy")>
			<CFELSE>
				<CFSET OldList = "">
			</cfif>
		
		</cfif>
		
		<CFINCLUDE TEMPLATE="textcompare.cfm">
		
	
	</cfif>
	
	</td>
	
	</tr>

<!--- Close <CFIF ListContains(STATUS_CODE_SELECTED, 12) GT 0  --->
</cfif>





<CFOUTPUT>
<tr id="SHORT_TERM_LIABILITY_#This_CurrentRow#">
</cfoutput>


<th align="right" valign="top">



<!---
Short-term Liability?
--->

<!---
<CFIF NOT (IsDefined("EarlierRptDate") OR (IsDefined("Form.CorpFinFormat") AND Form.CorpFinFormat EQ "CorpFinFormat"))>
<span style="color:red; font-size:9pt">[NEW]</span>&nbsp;Estimated 
<CFELSE>
Estimated 
</cfif>
--->

Estimated 
Time to Resolution



<td>




<CFINCLUDE TEMPLATE="Estimated_Time_Resolution.cfm">



<CFIF CLAIM_CATEGORY EQ 2>

	<tr>
	
	<th align="right" valign="top">
	
	<!---
	Historical note: 
	Earliest report with Short-term liability: EarlierRptDate=06/30/2007
	--->
	
	<!---
	<span style="color:red; font-size:9pt">[NEW]</span> 
	--->
	
	If Field&nbsp;Grievance, held in abeyance?
	
	
	<td>
	
	
	<CFIF FIELD_GRIEVANCE_FLAG NEQ "">
	
		<CFIF FIELD_GRIEVANCE_FLAG EQ "Y">
			<CFSET NewList = "Yes">	
		<CFELSEIF FIELD_GRIEVANCE_FLAG EQ "N">
			<CFSET NewList = "No">	
		<CFELSEIF FIELD_GRIEVANCE_FLAG EQ "0">
			<CFSET NewList = "N/A">
		</CFIF>
	
	<CFELSE>	
		
		<CFSET NewList = "_____">
	
	</CFIF>
	
	
	<CFIF ThisReportDate NEQ EarliestReportDate AND PrevReportDate NEQ "" AND CONTINGENT_LIAB_GetRecord_PrevRpt.FIELD_GRIEVANCE_FLAG NEQ "">
	
		<CFIF CONTINGENT_LIAB_GetRecord_PrevRpt.FIELD_GRIEVANCE_FLAG EQ "Y">
			<CFSET OldList = "Yes">	
		<CFELSEIF CONTINGENT_LIAB_GetRecord_PrevRpt.FIELD_GRIEVANCE_FLAG EQ "N">
			<CFSET OldList = "No">
		<CFELSEIF CONTINGENT_LIAB_GetRecord_PrevRpt.FIELD_GRIEVANCE_FLAG EQ "0">
			<CFSET OldList = "N/A">
		</CFIF>
	
	<CFELSE>
	
		<CFSET OldList = "_____">
	
	</cfif>
	
	
	<!---        
			<CFINCLUDE TEMPLATE="CFINCLUDEs/textcompare.cfm">
	--->
	
	<CFINCLUDE TEMPLATE="textcompare.cfm">
	
	
	
	
	
	<CFIF FIELD_GRIEVANCE_FLAG EQ "Y" OR NATL_GATS_NUMBER NEQ "">
	
		<CFSET NewList = NATL_GATS_NUMBER>	
		
		<CFIF NewList EQ "">
			<CFSET NewList = "_____">
		</CFIF>
		
		<CFIF ThisReportDate NEQ EarliestReportDate AND PrevReportDate NEQ "" AND CONTINGENT_LIAB_GetRecord_PrevRpt.NATL_GATS_NUMBER NEQ "">
		
			<CFSET OldList = CONTINGENT_LIAB_GetRecord_PrevRpt.NATL_GATS_NUMBER>	
		
		<CFELSE>
		
			<CFSET OldList = "_____">
		
		</cfif>
		
		
		<li>GATS Number of National-level Case:
		
	
	<!---        
			<CFINCLUDE TEMPLATE="CFINCLUDEs/textcompare.cfm">
	--->
	
		<CFINCLUDE TEMPLATE="textcompare.cfm">
	
	
	</CFIF>


<!--- Close <CFIF CLAIM_CATEGORY EQ 2> --->
</CFIF>

