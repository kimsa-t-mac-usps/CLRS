
<!------------------------- Report.ptB.cfm ----------------------------------->
<!---------------------------------------------------------------------------->
<!--- KS1 --->
	<!---<CFOUTPUT>
		Program = "Report.ptB.cfm at 4"
	</CFOUTPUT>--->
<!---
For CorpFin report: show single table row

Included by cfloop.cur_rem.casetype.assesscutoff.output.cfm
Query CONTINGENT_LIAB_GetRecord_PrevRpt in Report.cfm

--->

<tr>
<td class="CorpFin">

<!---
<span style="color:green">

<CFOUTPUT>
[#Evaluate(Query_CurrentRow)#]
</CFOUTPUT>

</span>
--->

<!---
<span style="font-size:8pt; font-weight:bold; background:green; text-align:center; color:white; width:13; height:10; padding-left:1px">#Evaluate(Query_CurrentRow)#</span>
--->

<CFOUTPUT>
<span id="Report_Body_CaseNum_#This_CurrentRow#" style="font-size:8pt; font-weight:bold; background:green; text-align:center; color:white; width:19; height:10; padding-left:1px; display:none">#This_CurrentRow#</span>
</CFOUTPUT>

<CFSET NewList = Trim(CASE_NAME)>

<CFIF STATUS_CODE EQ 1>

	<CFIF ThisReportDate NEQ EarliestReportDate AND PrevReportDate NEQ "">
		<CFSET OldList = Trim(CONTINGENT_LIAB_GetRecord_PrevRpt.CASE_NAME)>
	</cfif>

<!---
<CFINCLUDE TEMPLATE="CFINCLUDEs/textcompare.cfm">
--->

	<CFINCLUDE TEMPLATE="textcompare.cfm">
	

<CFELSE>

	<CFOUTPUT>
	#NewList#
	</cfoutput>

</cfif>

</td>


<td class="CorpFin">

<CFIF Trim(CASE_NUMBER) EQ "">

	_____


<CFELSE>

	<CFSET NewList = Trim(CASE_NUMBER)>
	
	<CFIF STATUS_CODE EQ 1>
	
		<CFIF ThisReportDate NEQ EarliestReportDate AND PrevReportDate NEQ "">
			<CFSET OldList = Trim(CONTINGENT_LIAB_GetRecord_PrevRpt.CASE_NUMBER)>
		</cfif>
	
<!---
<CFINCLUDE TEMPLATE="CFINCLUDEs/textcompare.cfm">
--->

		<CFINCLUDE TEMPLATE="textcompare.cfm">


	
	<CFELSE>
	
		<CFOUTPUT>
		#NewList#
		</cfoutput>
	
	</cfif>

</cfif>

</td>


<td class="CorpFin" style="text-align:right">


<CFIF AMOUNT_SOUGHT NEQ "">

	<CFSET AMOUNT_SOUGHT_DisplayAmt = AMOUNT_SOUGHT / OneMillion>
	
	<CFSET NewList = NumberFormat(AMOUNT_SOUGHT_DisplayAmt, '_$__._') & " Million">
	
	<CFIF ThisReportDate NEQ EarliestReportDate AND PrevReportDate NEQ "">
	
	
		<CFIF CONTINGENT_LIAB_GetRecord_PrevRpt.AMOUNT_SOUGHT NEQ "">
		
			<CFSET Old_AMOUNT_SOUGHT_DisplayAmt = CONTINGENT_LIAB_GetRecord_PrevRpt.AMOUNT_SOUGHT / OneMillion>
			<CFSET OldList = NumberFormat(Old_AMOUNT_SOUGHT_DisplayAmt, '_$__._') & " Million">
		
		<CFELSE>
		
			<CFSET OldList = "">
		
		</cfif>
	
	
	</cfif>
	
	
<!---
<CFINCLUDE TEMPLATE="CFINCLUDEs/textcompare.cfm">
--->

<CFINCLUDE TEMPLATE="textcompare.cfm">


	
	<CFIF DiffFlag EQ "yes">
		<CFSET AMOUNT_SOUGHT_Diff = "yes">
	<CFELSE>
		<CFSET AMOUNT_SOUGHT_Diff = "no">
	</cfif>


<CFELSE>


	<CFSET AMOUNT_SOUGHT_UNKNOWN_Word = "_____">
	
	<CFLOOP INDEX="AMOUNT_SOUGHT_UNKNOWN_Index" FROM="1" TO="#ListLen(Unknown_NA_List)#">
	
		<CFIF AMOUNT_SOUGHT_UNKNOWN EQ AMOUNT_SOUGHT_UNKNOWN_Index>
			<CFSET AMOUNT_SOUGHT_UNKNOWN_Word = "[" & ListGetAt(Unknown_NA_List, AMOUNT_SOUGHT_UNKNOWN_Index) & "]">
		</cfif>
	
	</cfloop>
	
	
	<CFSET NewList = AMOUNT_SOUGHT_UNKNOWN_Word>
	
	<CFIF ThisReportDate NEQ EarliestReportDate AND PrevReportDate NEQ "">
	
		<CFIF CONTINGENT_LIAB_GetRecord_PrevRpt.AMOUNT_SOUGHT_UNKNOWN NEQ "" AND CONTINGENT_LIAB_GetRecord_PrevRpt.AMOUNT_SOUGHT_UNKNOWN NEQ 0>
		
			<CFLOOP INDEX="Prev_AMOUNT_SOUGHT_UNKNOWN_Index" FROM="1" TO="#ListLen(Unknown_NA_List)#">
			
				<CFIF CONTINGENT_LIAB_GetRecord_PrevRpt.AMOUNT_SOUGHT_UNKNOWN EQ Prev_AMOUNT_SOUGHT_UNKNOWN_Index>
					<CFSET Prev_AMOUNT_SOUGHT_UNKNOWN_Word = "[" & ListGetAt(Unknown_NA_List, Prev_AMOUNT_SOUGHT_UNKNOWN_Index) & "]">
				</cfif>
			
			</cfloop>
			
			<CFSET OldList = Prev_AMOUNT_SOUGHT_UNKNOWN_Word>
			
		<CFELSE>
		
			<CFSET OldList = "">
		
		</cfif>
		
	</cfif>

		
<!---
<CFINCLUDE TEMPLATE="CFINCLUDEs/textcompare.cfm">
--->

<CFINCLUDE TEMPLATE="textcompare.cfm">


		
	<CFIF DiffFlag EQ "yes">
		<CFSET AMOUNT_SOUGHT_UNKNOWN_Diff = "yes">
	<CFELSE>
		<CFSET AMOUNT_SOUGHT_UNKNOWN_Diff = "no">
	</cfif>
		
		
</cfif>
	

<CFIF AMOUNT_SOUGHT_UPPER NEQ "">

	-

	<CFSET AMOUNT_SOUGHT_UPPER_DisplayAmt = AMOUNT_SOUGHT_UPPER / OneMillion>
	
	
	<CFSET NewList = NumberFormat(AMOUNT_SOUGHT_UPPER_DisplayAmt, '_$__._') & " Million">
	
	<CFIF ThisReportDate NEQ EarliestReportDate AND PrevReportDate NEQ "">
	
		<CFIF CONTINGENT_LIAB_GetRecord_PrevRpt.AMOUNT_SOUGHT_UPPER NEQ "">
		
			<CFSET Old_AMOUNT_SOUGHT_UPPER_DisplayAmt = CONTINGENT_LIAB_GetRecord_PrevRpt.AMOUNT_SOUGHT_UPPER / OneMillion>
			<CFSET OldList = NumberFormat(Old_AMOUNT_SOUGHT_UPPER_DisplayAmt, '_$__._') & " Million">
		
		<CFELSE>
		
			<CFSET OldList = "">
		
		</cfif>
		
	</cfif>
	
	
<!---
<CFINCLUDE TEMPLATE="CFINCLUDEs/textcompare.cfm">
--->

<CFINCLUDE TEMPLATE="textcompare.cfm">


	
	<CFIF DiffFlag EQ "yes">
		<CFSET AMOUNT_SOUGHT_UPPER_Diff = "yes">
	<CFELSE>
		<CFSET AMOUNT_SOUGHT_UPPER_Diff = "no">
	</cfif>

</cfif>



</td>





<td class="CorpFin">

<CFSWITCH EXPRESSION="#ASSESSMENT_PROBABILITY#">

<CFCASE VALUE="1">
	<CFSET New_ASSESSMENT_PROBABILITY_Label = "Probable">
</cfcase>

<CFCASE VALUE="2">
	<CFSET New_ASSESSMENT_PROBABILITY_Label = "Reasonably Possible">
</cfcase>

<CFCASE VALUE="3">
	<CFSET New_ASSESSMENT_PROBABILITY_Label = "Remote">
</cfcase>

</cfswitch>

<CFSET NewList = New_ASSESSMENT_PROBABILITY_Label>


<CFIF ThisReportDate NEQ EarliestReportDate AND PrevReportDate NEQ "">

	<CFSWITCH EXPRESSION="#CONTINGENT_LIAB_GetRecord_PrevRpt.ASSESSMENT_PROBABILITY#">
	
	<CFCASE VALUE="1">
		<CFSET Prev_ASSESSMENT_PROBABILITY_Label = "Probable">
	</cfcase>
	
	<CFCASE VALUE="2">
		<CFSET Prev_ASSESSMENT_PROBABILITY_Label = "Reasonably Possible">
	</cfcase>
	
	<CFCASE VALUE="3">
		<CFSET Prev_ASSESSMENT_PROBABILITY_Label = "Remote">
	</cfcase>
	
	<CFDEFAULTCASE>
		<CFSET Prev_ASSESSMENT_PROBABILITY_Label = "">
	</CFDEFAULTCASE>
	
	</cfswitch>
	
	<CFSET OldList = Prev_ASSESSMENT_PROBABILITY_Label>
	
</cfif>


<!---
<CFINCLUDE TEMPLATE="CFINCLUDEs/textcompare.cfm">
--->

<CFINCLUDE TEMPLATE="textcompare.cfm">



<CFIF DiffFlag EQ "yes">
	<CFSET ASSESSMENT_PROBABILITY_Diff = "yes">
<CFELSE>
	<CFSET ASSESSMENT_PROBABILITY_Diff = "no">
</cfif>

</td>




<td class="CorpFin">

<i>Most&nbsp;Likely&nbsp;Payout:</i>
<br />


<CFINCLUDE TEMPLATE="assess.amt.compare.cfm">
<CFSET NewList = ASSESSMENT_AMOUNT_DisplayAmt>

<CFINCLUDE TEMPLATE="assess.amt.prev.compare.cfm">
<CFSET OldList = Prev_ASSESSMENT_AMOUNT_DisplayAmt>

<!---
<CFINCLUDE TEMPLATE="CFINCLUDEs/textcompare.cfm">
--->

<CFINCLUDE TEMPLATE="textcompare.cfm">



<CFIF DiffFlag EQ "yes">
	<CFSET ASSESSMENT_AMOUNT_Diff = "yes">
<CFELSE>
	<CFSET ASSESSMENT_AMOUNT_Diff = "no">
</cfif>



<br style="margin-top:10pt">
<i>Max&nbsp;Reasonable&nbsp;Payout:</i>
<br />



<CFINCLUDE TEMPLATE="assess.amt.upper.compare.cfm">
<CFSET NewList = ASSESSMENT_AMOUNT_UPPER_DisplayAmt>

<CFINCLUDE TEMPLATE="assess.amt.upper.prev.compare.cfm">
<CFSET OldList = Prev_ASSESSMENT_AMOUNT_UPPER_DisplayAmt>

<!---
<CFINCLUDE TEMPLATE="CFINCLUDEs/textcompare.cfm">
--->

<CFINCLUDE TEMPLATE="textcompare.cfm">



<CFIF DiffFlag EQ "yes">
	<CFSET ASSESSMENT_AMOUNT_UPPER_Diff = "yes">
<CFELSE>
	<CFSET ASSESSMENT_AMOUNT_UPPER_Diff = "no">
</cfif>


</td>




<td class="CorpFin">
	
<CFIF STATUS_CODE_SELECTED NEQ "">
	
	<CFINCLUDE TEMPLATE="Loop.Status_Code_List.cfm">
	
</cfif>
	
</td>










<!--- If Liability (1) or Receivable (2) Removed (+10 = 11 or 12), show outcome --->
<CFIF CASE_TYPE EQ 11 OR CASE_TYPE EQ 12>

	
<!---    
	<td class="CorpFin">
	
	<CFIF STATUS_CODE_SELECTED NEQ "">
	
		<CFINCLUDE TEMPLATE="Loop.Status_Code_List.cfm">
	
	</cfif>
	
	</td>
--->	
	
	<td class="CorpFin" style="text-align:right; width:30pt">
	
	<CFIF PAYOUT_AMOUNT NEQ "">
	
		<CFSET PAYOUT_AMOUNT_DisplayAmt = PAYOUT_AMOUNT / OneMillion>
		
		<CFSET NewList = NumberFormat(PAYOUT_AMOUNT_DisplayAmt, '_$__._') & " Million">
		
		<CFIF ThisReportDate NEQ EarliestReportDate 
		AND 
		PrevReportDate NEQ "">
		
			
			<CFIF CONTINGENT_LIAB_GetRecord_PrevRpt.PAYOUT_AMOUNT NEQ "">
			
				<CFSET Old_PAYOUT_AMOUNT_DisplayAmt = CONTINGENT_LIAB_GetRecord_PrevRpt.PAYOUT_AMOUNT / OneMillion>
				<CFSET OldList = NumberFormat(Old_PAYOUT_AMOUNT_DisplayAmt, '_$__._') & " Million">
			
			<CFELSE>
			
				<CFSET OldList = "">
			
			</cfif>
		
		
		</cfif>
		
		
<!---
<CFINCLUDE TEMPLATE="CFINCLUDEs/textcompare.cfm">
--->

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
			<CFSET NewList = "None or N/A">
		<CFELSE>
			<CFSET NewList = "">
		</cfif>
		
        
		<CFIF ThisReportDate NEQ EarliestReportDate 
		AND 
		PrevReportDate NEQ "">
		
			<CFIF CONTINGENT_LIAB_GetRecord_PrevRpt.PAYOUT_LT_100K NEQ "">
			
				<CFIF CONTINGENT_LIAB_GetRecord_PrevRpt.PAYOUT_LT_100K EQ 1>
					<CFSET OldList = "Less than $100,000">
				<CFELSEIF CONTINGENT_LIAB_GetRecord_PrevRpt.PAYOUT_LT_100K EQ 2>
					<CFSET OldList = "None or N/A">
				<CFELSE>
					<CFSET OldList = "">
				</cfif>
			
			</cfif>
		
		</cfif>
		
		
<!---
<CFINCLUDE TEMPLATE="CFINCLUDEs/textcompare.cfm">
--->

		<CFINCLUDE TEMPLATE="textcompare.cfm">


		
		<CFIF DiffFlag EQ "yes">
			<CFSET PAYOUT_LT_100K_Diff = "yes">
		<CFELSE>
			<CFSET PAYOUT_LT_100K_Diff = "no">
		</cfif>
		
		
	<CFELSE>
		
		_____

	
	<!--- Close <CFIF PAYOUT_AMOUNT NEQ ""> --->
	</cfif>
	
	
	</td>
	
	
	
	<td class="CorpFin" style="text-align:right; width:30pt">
	
	<CFIF PAYOUT_DATE NEQ "">
	
	
		<CFSET PAYOUT_DATE_Display = DateFormat(PAYOUT_DATE, "mm/dd/yyyy")>
		
		<CFSET NewList = PAYOUT_DATE_Display>
		
		
		<CFIF ThisReportDate NEQ EarliestReportDate AND PrevReportDate NEQ "">
		
		
			<CFIF CONTINGENT_LIAB_GetRecord_PrevRpt.PAYOUT_DATE NEQ "">
			
				<CFSET Old_PAYOUT_DATE_Display = DateFormat(CONTINGENT_LIAB_GetRecord_PrevRpt.PAYOUT_DATE, "mm/dd/yyyy")>
				<CFSET OldList = Old_PAYOUT_DATE_Display>
			
			<CFELSE>
			
				<CFSET OldList = "">
			
			</cfif>
		
		
		</cfif>
		
		
<!---
<CFINCLUDE TEMPLATE="CFINCLUDEs/textcompare.cfm">
--->

		<CFINCLUDE TEMPLATE="textcompare.cfm">




		<CFIF DiffFlag EQ "yes">
			<CFSET PAYOUT_DATE_Diff = "yes">
		<CFELSE>
			<CFSET PAYOUT_DATE_Diff = "no">
		</cfif>
		
		
		<!--- <CFIF PAYOUT_AMOUNT NEQ ""> --->
	<CFELSEIF PAYOUT_DATE_NA NEQ "">
		
		<CFIF PAYOUT_DATE_NA EQ 1>
			<CFSET NewList = "None or N/A">
		<CFELSE>
			<CFSET NewList = "">
		</cfif>
		
		<CFIF ThisReportDate NEQ EarliestReportDate 
		AND 
		PrevReportDate NEQ "">
		
			<CFIF CONTINGENT_LIAB_GetRecord_PrevRpt.PAYOUT_DATE_NA NEQ "">
			
				<CFIF CONTINGENT_LIAB_GetRecord_PrevRpt.PAYOUT_DATE_NA EQ 1>
					<CFSET OldList = "None or N/A">
				<CFELSE>
					<CFSET OldList = "">
				</cfif>
			
			</cfif>
		
		</cfif>
		
		
<!---
<CFINCLUDE TEMPLATE="CFINCLUDEs/textcompare.cfm">
--->

		<CFINCLUDE TEMPLATE="textcompare.cfm">


		
		<CFIF DiffFlag EQ "yes">
			<CFSET PAYOUT_DATE_NA_Diff = "yes">
		<CFELSE>
			<CFSET PAYOUT_DATE_NA_Diff = "no">
		</cfif>
		
		
	<CFELSE>
		
		_____
		
	<!--- Close <CFIF PAYOUT_DATE NEQ ""> --->
	</cfif>
		
	
	</td>
	
	
<!--- From <CFIF CASE_TYPE EQ 11 OR CASE_TYPE EQ 12> --->
<CFELSE>
	
	<td class="CorpFin">
	
	<!--- Estimated Time to Resolution --->
	
	<CFINCLUDE TEMPLATE="Estimated_Time_Resolution.cfm">
	
	</td>


<!--- Close <CFIF CASE_TYPE EQ 11 OR CASE_TYPE EQ 12> --->
</cfif>



<!---
<p>

In Report.ptB.cfm at 622:

<br />


<CFIF IsDefined("Get_Single_Record.RecordCount")
AND
Get_Single_Record.RecordCount GT 0>

	<CFOUTPUT>
	Get_Single_Record.RecordCount = #Get_Single_Record.RecordCount#
	</CFOUTPUT>

<CFELSE>

	Get_Single_Record.RecordCount NOT DEFINED

</CFIF>

<p>
--->




<CFIF IsDefined("MC_Name")
AND
MC_Name NEQ "">

<td class="CorpFin">

<!--- Approved by Managing Counsel --->


<CFOUTPUT>

#MC_Name#

<!---
<br />
#DateFormat(CONTINGENT_LIAB_GetRecord_PrevRpt.Concur_MC_Date, "m/d/yyyy")#
--->


</CFOUTPUT>


</td>



<CFELSE>

<td class="CorpFin">

MC_Name NOT DEFINED


</td>


</CFIF>


















</tr>


