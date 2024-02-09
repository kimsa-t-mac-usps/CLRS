<cfinclude template="MfaCookieCheck.cfm">

<!---

Sets Report headings based on This_CASE_TYPE, Assess_Cutoff_List_Index, ASSESSMENT_PROBABILITY, CLAIM_CATEGORY

Case_Type_List set in Report.full.cfm
Assess_Cutoff_List_Index from CFLOOP in Report.TopIndexDiv.cfloops.cfm 
Assess_Cutoff_List set in Report.TopIndexDiv.cfm

--->

<CFIF IsDefined("CASE_TYPE")
AND
IsDefined("This_RecordCount")
AND
This_RecordCount NEQ 0>

	<CFSET This_CASE_TYPE = CASE_TYPE>

<!---
<p>
In sectionheadings.cfswitch.cfm at 13:
<br />

    	<CFOUTPUT>
        This_CASE_TYPE = #This_CASE_TYPE#
        </CFOUTPUT>

<p>
--->


<CFELSE>

<!---
<p>
In sectionheadings.cfswitch.cfm at 28:
<br />

	<CFIF NOT IsDefined("This_CASE_TYPE")>
    	This_CASE_TYPE NOT DEFINED
    <CFELSE>
    	<CFOUTPUT>
        This_CASE_TYPE = #This_CASE_TYPE#
        </CFOUTPUT>
    </CFIF>
<p>
--->




	<CFIF NOT IsDefined("This_CASE_TYPE")>
    	<CFSET Prev_This_CASE_TYPE = 0>
	<CFELSE>
    	<CFSET Prev_This_CASE_TYPE = This_CASE_TYPE>
    </CFIF>


	<CFSET This_CASE_TYPE = ListFind(Case_Type_List, Case_Type_List_Index)>

<!---
<p>
In sectionheadings.cfswitch.cfm at 55:
<br />

	<CFIF NOT IsDefined("This_CASE_TYPE")>
    	This_CASE_TYPE NOT DEFINED
    <CFELSE>
    	<CFOUTPUT>
        This_CASE_TYPE = #This_CASE_TYPE#
        </CFOUTPUT>
    </CFIF>
<p>
--->





<!---
	<CFIF This_CASE_TYPE NEQ Prev_This_CASE_TYPE>
--->


	<CFIF This_CASE_TYPE NEQ Prev_This_CASE_TYPE
	OR
	NOT IsDefined("ASSESSMENT_PROBABILITY_LabelList_Ct")>
		
    	<CFSET ASSESSMENT_PROBABILITY_LabelList_Ct = 1>
	
	<CFELSE>    
    
    	<CFSET ASSESSMENT_PROBABILITY_LabelList_Ct = ASSESSMENT_PROBABILITY_LabelList_Ct + 1>
    
	</CFIF>


	<CFIF NOT IsDefined("ASSESSMENT_PROBABILITY")>
    	<CFSET Prev_ASSESSMENT_PROBABILITY = 0>
	<CFELSE>
    	<CFSET Prev_ASSESSMENT_PROBABILITY = ASSESSMENT_PROBABILITY>
    </CFIF>


   	<CFSET ASSESSMENT_PROBABILITY = ASSESSMENT_PROBABILITY_LabelList_Ct>


	<CFIF ASSESSMENT_PROBABILITY NEQ Prev_ASSESSMENT_PROBABILITY>
    	<CFSET CLAIM_CATEGORY_Ct = 1>
	<CFELSE>    
    	<CFSET CLAIM_CATEGORY_Ct = CLAIM_CATEGORY_Ct + 1>
    </CFIF>


   	<CFSET CLAIM_CATEGORY = CLAIM_CATEGORY_Ct>


</CFIF>


<!---
<p>
In sectionheadings.cfswitch.cfm at 50:
<br />

<CFOUTPUT>
This_CASE_TYPE = #This_CASE_TYPE#
<br />
CLRC_Query_Name = #CLRC_Query_Name#
<br />

Assess_Cutoff_List_Index = #Assess_Cutoff_List_Index#
<p>
</CFOUTPUT>
--->




<!--- Fix for CorpFin Report where no New Contingent Receivables (Section 1); switch to Removed Contingent Liabilities --->

<!---
	<CFIF (
	(IsDefined("Form.CorpFinFormat") AND Form.CorpFinFormat EQ "CorpFinFormat")
	OR
	(IsDefined("Form.FrontOffcReviewFormat") AND Form.FrontOffcReviewFormat EQ "FrontOffcReviewFormat")
	OR
	(IsDefined("Form.CorpFinFormat_STL") AND Form.CorpFinFormat_STL EQ "CorpFinFormat_STL")
	)>
--->


<!---
		<CFIF CLRC_Query_Name CONTAINS "Removed_Liabilities_5MillionAndAbove"
		AND
		This_CASE_TYPE EQ 2>

			<CFSET This_CASE_TYPE = 11>
--->

<!---        
		<CFELSEIF CLRC_Query_Name CONTAINS "Removed_Receivables_5MillionAndAbove"
		AND
		This_CASE_TYPE EQ 2>
--->

<!---
		<CFELSEIF CLRC_Query_Name CONTAINS "Removed"
		AND
		This_CASE_TYPE LT 10>
--->

		<CFIF CLRC_Query_Name CONTAINS "Removed"
		AND
		This_CASE_TYPE LT 10>

			<CFSET This_CASE_TYPE = This_CASE_TYPE + 10>
  
		</CFIF>
    
<!---    
	</CFIF>
--->



<!---
<p>
In sectionheadings.cfswitch.cfm at 132:
<br />

<CFOUTPUT>
This_CASE_TYPE = #This_CASE_TYPE#
<p>
</CFOUTPUT>
--->






<!---
<CFIF Assess_Cutoff_List_Index EQ "Under1MillionOver5Million">
--->


<!---
<CFIF Assess_Cutoff_List_Index EQ "MostLikelyUnder1Million_MaxReasonableOver1Million">
	<CFSET This_CASE_TYPE = "Addendum">
</CFIF>
--->

<!---
<CFIF Assess_Cutoff_List_Index EQ "MostLikelyUnderTenMillion_MaxReasonableOverTenMillion">
	<CFSET This_CASE_TYPE = "Addendum">
</CFIF>
--->


<!---<CFIF Assess_Cutoff_List_Index EQ "MostLikelyUnderTenMillion_MaxReasonableOverOneMillion">
	<CFSET This_CASE_TYPE = "Addendum">
</CFIF>--->







<!---
<p>
In sectionheadings.cfswitch.cfm at 165:
<br />
<CFOUTPUT>
This_CASE_TYPE = #This_CASE_TYPE#
<p>
</CFOUTPUT>
--->


<!---
or
(
status_code_selected like '%11%'
or
status_code_selected like '%12%'
or
status_code_selected like '%13%'
or
status_code_selected like '%14%'
or
status_code_selected like '%15%'
)

--->






<CFSWITCH EXPRESSION="#This_CASE_TYPE#">

<CFCASE VALUE="1">

<!---
	<CFSET CASE_TYPE_Label = "I. Contingent Liabilities:">
--->
    
   	<CFSET CASE_TYPE_Label = "">

</cfcase>


<CFCASE VALUE="2">

<!---
	<CFSET CASE_TYPE_Label = "II. Contingent Receivables:">
--->


	<CFIF (
	(IsDefined("Form.CorpFinFormat") AND Form.CorpFinFormat EQ "CorpFinFormat")
	OR
	(IsDefined("Form.FrontOffcReviewFormat") AND Form.FrontOffcReviewFormat EQ "FrontOffcReviewFormat")
	OR
	(IsDefined("Form.CorpFinFormat_STL") AND Form.CorpFinFormat_STL EQ "CorpFinFormat_STL")
	)
	AND
	CLRC_Query_Name DOES NOT CONTAIN "Removed">

<!---
		<CFSET CASE_TYPE_Label = "IV. ">
--->

		<CFSET CASE_TYPE_Label = "III. ">


	<CFELSE>
    
   		<CFSET CASE_TYPE_Label = "II. ">

	</cfif>


	<CFSET CASE_TYPE_Label = CASE_TYPE_Label & "Contingent Receivables:">


</cfcase>

<!---
<CFCASE VALUE="11">
	<CFSET CASE_TYPE_Label = "III. Cases To Be Removed -- Contingent Liabilities:">
</cfcase>

<CFCASE VALUE="12">
	<CFSET CASE_TYPE_Label = "III. Cases To Be Removed -- Contingent Receivables:">
</cfcase>
--->

<CFCASE VALUE="11">

<!---
	<CFSET CASE_TYPE_Label = "II. Cases To Be Removed -- Contingent Liabilities:">
--->


	<CFIF (
	(IsDefined("Form.CorpFinFormat") AND Form.CorpFinFormat EQ "CorpFinFormat")
	OR
	(IsDefined("Form.FrontOffcReviewFormat") AND Form.FrontOffcReviewFormat EQ "FrontOffcReviewFormat")
	OR
	(IsDefined("Form.CorpFinFormat_STL") AND Form.CorpFinFormat_STL EQ "CorpFinFormat_STL")
	)>

		<CFSET CASE_TYPE_Label = "II. ">

	<CFELSE>
    
   		<CFSET CASE_TYPE_Label = "III. ">

	</cfif>


	<CFSET CASE_TYPE_Label = CASE_TYPE_Label & "Cases To Be Removed -- Contingent Liabilities:">

</cfcase>


<CFCASE VALUE="12">

<!---
	<CFSET CASE_TYPE_Label = "II. Cases To Be Removed -- Contingent Receivables:">
--->

	<CFIF (
	(IsDefined("Form.CorpFinFormat") AND Form.CorpFinFormat EQ "CorpFinFormat")
	OR
	(IsDefined("Form.FrontOffcReviewFormat") AND Form.FrontOffcReviewFormat EQ "FrontOffcReviewFormat")
	OR
	(IsDefined("Form.CorpFinFormat_STL") AND Form.CorpFinFormat_STL EQ "CorpFinFormat_STL")
	)>

		<CFSET CASE_TYPE_Label = "II. ">

	<CFELSE>
    
   		<CFSET CASE_TYPE_Label = "III. ">

	</cfif>


	<CFSET CASE_TYPE_Label = CASE_TYPE_Label & "Cases To Be Removed -- Contingent Receivables:">


</cfcase>


<!--- Corp Fin only --->
<CFCASE VALUE="Addendum">


	<CFSET CASE_TYPE_Label = "IV. Addendum:">


<!---
	<CFSET CASE_TYPE_Label = "V. Addendum:">
--->


</cfcase>

</cfswitch>


<!---
If CorpFin:

<CFSET Assess_Cutoff_List = "New1MillionAndAbove,5MillionAndAbove,Under5Million">

--->

<!---
<CFIF Assess_Cutoff_List_Index EQ "5MillionAndAbove">
	<CFSET CASE_TYPE_Label = CASE_TYPE_Label & " Assessed At or Above $5 Million">
<CFELSE>
	<CFSET CASE_TYPE_Label = CASE_TYPE_Label & " Assessed Below $5 Million">
</cfif>
--->

<CFSWITCH EXPRESSION="#Assess_Cutoff_List_Index#">

<CFCASE VALUE="TenMillionAndAbove">

	<CFIF This_CASE_TYPE EQ 1>

		<CFIF (
		(IsDefined("Form.CorpFinFormat") AND Form.CorpFinFormat EQ "CorpFinFormat")
		OR
		(IsDefined("Form.FrontOffcReviewFormat") AND Form.FrontOffcReviewFormat EQ "FrontOffcReviewFormat")
		OR
		(IsDefined("Form.CorpFinFormat_STL") AND Form.CorpFinFormat_STL EQ "CorpFinFormat_STL")
		)>

			<CFSET CASE_TYPE_Label = "III. ">

		<CFELSE>
        
   			<CFSET CASE_TYPE_Label = "I. ">
            
        </cfif>

		<CFSET CASE_TYPE_Label = CASE_TYPE_Label & "Contingent Liabilities:">

	</cfif>
            

	<CFSET CASE_TYPE_Label = CASE_TYPE_Label & " Assessed At or Above $10 Million">
    
    
</cfcase>


<!---Kimsa  -----------------------------------------------------------------------------------------------------
<CFCASE VALUE="UnderTenMillion">


	<CFIF This_CASE_TYPE EQ 1>

		<CFIF (
		(IsDefined("Form.CorpFinFormat") AND Form.CorpFinFormat EQ "CorpFinFormat")
		OR
		(IsDefined("Form.FrontOffcReviewFormat") AND Form.FrontOffcReviewFormat EQ "FrontOffcReviewFormat")
		OR
		(IsDefined("Form.CorpFinFormat_STL") AND Form.CorpFinFormat_STL EQ "CorpFinFormat_STL")
		)>

			<CFSET CASE_TYPE_Label = "III. ">

		<CFELSE>
        
   			<CFSET CASE_TYPE_Label = "I. ">
            
        </cfif>

		<CFSET CASE_TYPE_Label = CASE_TYPE_Label & "Contingent Liabilities:">

	</cfif>


	<CFSET CASE_TYPE_Label = CASE_TYPE_Label & " Assessed Below $10 Million">


</cfcase>
--------------------------------------------------------------------------------------------------------------------------
--->

<!--- Only for CorpFin --->

<!---
<CFCASE VALUE="New1MillionAndAbove">
--->

<CFCASE VALUE="NewTenMillionAndAbove">

<!---
	<CFSET CASE_TYPE_Label = CASE_TYPE_Label & "I. Contingent Liabilities: New Cases Assessed At or Above $1 Million (incl. Cases Previously Below Reporting Threshold)">
--->

	<CFSET CASE_TYPE_Label = "I. ">


	<CFIF This_CASE_TYPE EQ 1
	OR
	This_CASE_TYPE EQ 11>

		<CFSET CASE_TYPE_Label = CASE_TYPE_Label & "Contingent Liabilities: ">

	<CFELSE>
        
		<CFSET CASE_TYPE_Label = CASE_TYPE_Label & "Contingent Receivables: ">
            
    </cfif>


	<CFSET CASE_TYPE_Label = CASE_TYPE_Label & "New Cases Assessed At or Above $10 Million (incl. Cases Previously Below Reporting Threshold)">


</cfcase>


<!---
<CFCASE VALUE="Under1MillionOver5Million">
	<CFSET CASE_TYPE_Label = CASE_TYPE_Label & " Contingent Liabilities Assessed Low End Below $1 Million and High End At or Above $5 Million">
</cfcase>
--->

<!---
<CFCASE VALUE="MostLikelyUnder1Million_MaxReasonableOver1Million">

        <CFSET CASE_TYPE_Label = CASE_TYPE_Label & " Contingent Liabilities: Most Likely Payout Below $1 Million and Maximum Reasonable Payout At or Above $1 Million">

</cfcase>
--->




<!---
<CFCASE VALUE="MostLikelyUnderTenMillion_MaxReasonableOverTenMillion">

        <CFSET CASE_TYPE_Label = CASE_TYPE_Label & " Contingent Liabilities: Most Likely Payout Below $10 Million and Maximum Reasonable Payout At or Above $10 Million">

</cfcase>
--->


<CFCASE VALUE="MostLikelyUnderTenMillion_MaxReasonableOverOneMillion">

<!---
        <CFSET CASE_TYPE_Label = CASE_TYPE_Label & " Contingent Liabilities: Most Likely Payout Below $10 Million and Maximum Reasonable Payout At or Above $1 Million">
--->

	<CFSET CASE_TYPE_Label = "IV. Addendum: ">




	<!---<CFIF This_CASE_TYPE EQ 1 kimsa
	OR
	This_CASE_TYPE EQ 11>

		<CFSET CASE_TYPE_Label = CASE_TYPE_Label & "Contingent Liabilities: ">

	<CFELSE>
        
		<CFSET CASE_TYPE_Label = CASE_TYPE_Label & "Contingent Receivables: ">
            
    </cfif>--->


	<!---<CFSET CASE_TYPE_Label = CASE_TYPE_Label & "Most Likely Payout Below $10 Million and Maximum Reasonable Payout At or Above $1 Million">--->

 <CFIF This_CASE_TYPE EQ 1>
				<CFSET CASE_TYPE_Label = CASE_TYPE_Label & "Contingent Liabilities: Most Likely Payout Below $10 Million and Maximum Reasonable Payout At or Above $1 Million (Including New Cases)"></CFIF>
			<CFIF This_CASE_TYPE EQ 2>
				<CFSET CASE_TYPE_Label = CASE_TYPE_Label & "Contingent Receivables: Most Likely Payout Below $10 Million and Maximum Reasonable Payout At or Above $1 Million (Including New Cases)"></CFIF>
			<CFIF This_CASE_TYPE EQ 11>
				<CFSET CASE_TYPE_Label = CASE_TYPE_Label & "Contingent Liabilities: Most Likely Payout Below $10 Million and Maximum Reasonable Payout At or Above $1 Million (Including Cases to be Removed)"></CFIF>
			<CFIF This_CASE_TYPE EQ 12>
				<CFSET CASE_TYPE_Label = CASE_TYPE_Label & "Contingent Receivables: Most Likely Payout Below $10 Million and Maximum Reasonable Payout At or Above $1 Million (Including Cases to be Removed)"></CFIF>
   			 

</cfcase>


</cfswitch>




<!---
<CFOUTPUT>
<p>
In cfswitch.cfm at 302: CASE_TYPE_Label = "#CASE_TYPE_Label#"
<p>
</cfoutput>
--->


<CFSWITCH EXPRESSION="#ASSESSMENT_PROBABILITY#">

<CFCASE VALUE="1">
	<CFSET ASSESSMENT_PROBABILITY_Label = "A. Probable">
</cfcase>

<CFCASE VALUE="2">
	<CFSET ASSESSMENT_PROBABILITY_Label = "B. Reasonably Possible">
</cfcase>

<CFCASE VALUE="3">
	<CFSET ASSESSMENT_PROBABILITY_Label = "C. Remote">
</cfcase>

</cfswitch>

<!---
<CFOUTPUT>
<p>
In cfswitch.cfm: ASSESSMENT_PROBABILITY_Label = "#ASSESSMENT_PROBABILITY_Label#"
<p>
</cfoutput>
--->


<CFSWITCH EXPRESSION="#CLAIM_CATEGORY#">

<CFCASE VALUE="1">
	<CFSET CLAIM_CATEGORY_Label = "1. Business Claims">
</cfcase>

<CFCASE VALUE="2">
	<CFSET CLAIM_CATEGORY_Label = "2. Labor Claims">
</cfcase>

<CFCASE VALUE="3">
	<CFSET CLAIM_CATEGORY_Label = "3. Tort Claims">
</cfcase>

</cfswitch>




