<cfinclude template="MfaCookieCheck.cfm">

<!---------------------- SectionHeading.cfswitch.cfm ------------------------->
	<CFIF IsDefined("CASE_TYPE") AND IsDefined("This_RecordCount") AND This_RecordCount NEQ 0>
		<CFSET This_CASE_TYPE = CASE_TYPE>
	
	<CFELSE>
			<CFIF NOT IsDefined("This_CASE_TYPE")>
				<CFSET Prev_This_CASE_TYPE = 0>
			<CFELSE>
				<CFSET Prev_This_CASE_TYPE = This_CASE_TYPE>
			</CFIF>
		
			<CFSET This_CASE_TYPE = ListFind(Case_Type_List, Case_Type_List_Index)>
	
			<CFIF This_CASE_TYPE NEQ Prev_This_CASE_TYPE OR NOT IsDefined("ASSESSMENT_PROBABILITY_LabelList_Ct")>
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


	</CFIF><!---end of 1st if IsDefined("CASE_TYPE") AND IsDefined("This_RecordCount") AND This_RecordCount NEQ 0--->

	<CFIF CLRC_Query_Name CONTAINS "Removed" AND This_CASE_TYPE LT 10>
			<CFSET This_CASE_TYPE = This_CASE_TYPE + 10>
	</CFIF>
	
	<!--- KS2 --->
	<!---<CFOUTPUT>
		<br />
		Program = "SectionHeading.cfSwitch.cfm at 59 --- KS2"
		<br />
		EXPRESSION = #Assess_Cutoff_List_Index#
		<br />
		Assess_Cutoff_List_Index =  #Assess_Cutoff_List_Index#
		<br />
		This_CASE_TYPE = #This_CASE_TYPE#
		<br />
		CLRC_Query_Name = #CLRC_Query_Name#
		<br />
	</CFOUTPUT>--->
	
	<!---KS1 -- Test only --->
	
		<!---<cfset Assess_Cutoff_List_Index = "UnderTenMillion">--->
		
		
		<!--- KS2 --->
	<!---<CFOUTPUT>
		<br />
		Program = "SectionHeading.cfSwitch.cfm at 78"
		<br />
		EXPRESSION = #Assess_Cutoff_List_Index#
		<br />
		Assess_Cutoff_List_Index = #Assess_Cutoff_List_Index#
		<br />
		This_CASE_TYPE = #This_CASE_TYPE#
		<br />
		CLRC_Query_Name = #CLRC_Query_Name#
		<br />
	</CFOUTPUT>--->
		
		
		
		
	<!------------------------------------------KS1------------------------------------------>		
	
	<CFSWITCH EXPRESSION="#This_CASE_TYPE#">
			<CFCASE VALUE="1">

			<!--- <CFSET CASE_TYPE_Label = "I. Contingent Liabilities:"> --->
			<CFSET CASE_TYPE_Label = "">

		</cfcase>
		<CFCASE VALUE="2">

			<!---<CFSET CASE_TYPE_Label = "II. Contingent Receivables:">--->
			<CFIF (
			(IsDefined("Form.CorpFinFormat") AND Form.CorpFinFormat EQ "CorpFinFormat")
			OR
			(IsDefined("Form.FrontOffcReviewFormat") AND Form.FrontOffcReviewFormat EQ "FrontOffcReviewFormat")
			OR
			(IsDefined("Form.CorpFinFormat_STL") AND Form.CorpFinFormat_STL EQ "CorpFinFormat_STL")
			)
			AND
			CLRC_Query_Name DOES NOT CONTAIN "Removed">

				<!---<CFSET CASE_TYPE_Label = "IV. ">--->
				<CFSET CASE_TYPE_Label = "III. ">
			<CFELSE>
				<CFSET CASE_TYPE_Label = "II. ">

			</cfif>

				<!---- 2/16/2023 dd32j0 Commented out and replaced with below   --->
				<CFSET CASE_TYPE_Label = CASE_TYPE_Label & "Contingent Receivables: ">

		</cfcase>
<p>CASE_TYPE_Label</p>
<p>rao</p>
		<CFCASE VALUE="11">

			<!---<CFSET CASE_TYPE_Label = "II. Cases To Be Removed -- Contingent Liabilities:">--->

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

		<CFSET CASE_TYPE_Label = CASE_TYPE_Label & "Cases To Be Removed - Contingent Liabilities:">

		</cfcase><!---end of case value = "11"--->


		<CFCASE VALUE="12">

			<!--- <CFSET CASE_TYPE_Label = "II. Cases To Be Removed -- Contingent Receivables:"> --->

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

			<CFSET CASE_TYPE_Label = CASE_TYPE_Label & "Cases To Be Removed - Contingent Receivables:">

		</cfcase> <!--- end of  CFCASE VALUE="12"  --->

		<!--- Corp Fin only --->
		<CFCASE VALUE="Addendum">
			<CFSET CASE_TYPE_Label = "IV. Addendum:">
			<!---<CFSET CASE_TYPE_Label = "V. Addendum:"> --->
		</cfcase>   <!--- end of CFCASE VALUE="Addendum" ---->

	</cfswitch>  <!---end of CFSWITCH EXPRESSION="#This_CASE_TYPE#"--->
   
   
   <!--- KS2 --->
	<!---<CFOUTPUT>
		<br />
		Program = "SectionHeading.cfSwitch.cfm at 183"
		<br />
		EXPRESSION = #Assess_Cutoff_List_Index#
		<br />
		Assess_Cutoff_List = #Assess_Cutoff_List#
		<br />
		Assess_Cutoff_List_Index = #Assess_Cutoff_List_Index#
		<br />
		This_CASE_TYPE = #This_CASE_TYPE#
		<br />
		CASE_TYPE_Label = #CASE_TYPE_Label#
		<br />
		CLRC_Query_Name = #CLRC_Query_Name#
		<br />
		
		<!---Value = #Value#--->
	</CFOUTPUT>--->
   
   
   
   
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
		</cfcase>	<!--- end of CFCASE VALUE="TenMillionAndAbove"--->

<!---KS2 8/19--->

<!-----------------------------------KS2----------------------------------------->
		<!---<CFCASE VALUE="UnderTenMillion">--->

			<!---<CFIF This_CASE_TYPE EQ 1 or This_CASE_TYPE EQ 2
						or This_CASE_TYPE EQ 11 or This_CASE_TYPE EQ 12>

				<CFIF (
				(IsDefined("Form.CorpFinFormat") AND Form.CorpFinFormat EQ "CorpFinFormat")
				OR
				(IsDefined("Form.FrontOffcReviewFormat") AND Form.FrontOffcReviewFormat EQ "FrontOffcReviewFormat")
				OR
				(IsDefined("Form.CorpFinFormat_STL") AND Form.CorpFinFormat_STL EQ "CorpFinFormat_STL")
				)>
				<CFIF This_CASE_TYPE EQ 1>
						<CFSET CASE_TYPE_Label = "I.kkkkkkkkkk ">
						<CFSET CASE_TYPE_Label = CASE_TYPE_Label & "Contingent Liabilities: ">
					<CFELSEIF This_CASE_TYPE EQ 2>
   						<CFSET CASE_TYPE_Label = "II.kkkkkkkk ">        
   						<CFSET CASE_TYPE_Label = CASE_TYPE_Label & "Contingent Receivables: ">   
					<CFELSEIF This_CASE_TYPE EQ 11>
   						<CFSET CASE_TYPE_Label = "III. ">    
   					<CFELSEIF This_CASE_TYPE EQ 12>
   						<CFSET CASE_TYPE_Label = "III.kkkkkk ">		
				</cfif>

				<CFSET CASE_TYPE_Label = CASE_TYPE_Label & "Contingent Liabilities: ">
			</cfif>

			<CFSET CASE_TYPE_Label = CASE_TYPE_Label & " Assessed Below $10 Million">
			</cfif>
		</cfcase>--->

		<!---<CFCASE VALUE="TenMillionAndAbove">--->
<!-----------------------------------KS2----------------------------------------->		
		<!---<CFCASE VALUE="UnderTenMillion">
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
   					<CFSET CASE_TYPE_Label = "I.kkkkkkkkkkkkkk ">            
        		</cfif>

				<CFSET CASE_TYPE_Label = CASE_TYPE_Label & "Contingent Liabilities:">

			</cfif>
           
			<CFSET CASE_TYPE_Label = CASE_TYPE_Label & " Assessed Below $10 Million">    
		</cfcase>	<!--- end of CFCASE VALUE="TenMillionAndAbove"--->--->


		<!---<CFCASE VALUE="UnderTenMillion">
			<CFIF This_CASE_TYPE EQ 1>
				<CFSET CASE_TYPE_Label = "I.kkkkkkkkkkkkkk ">            
        		<CFSET CASE_TYPE_Label = CASE_TYPE_Label & "Contingent Liabilities:">
				<CFSET CASE_TYPE_Label = CASE_TYPE_Label & " Assessed Below $10 Million">  
			</cfif>	  
		</cfcase>--->	

		<CFCASE VALUE="UnderTenMillion">
			<CFIF This_CASE_TYPE EQ 1 and CLRC_Query_Name CONTAINS "CONTINGENT" >
				<CFSET CASE_TYPE_Label = "I. Contingent Liabilities:">
					
			<CFELSEIF This_CASE_TYPE EQ 2 and CLRC_Query_Name CONTAINS "CONTINGENT">
				<CFSET CASE_TYPE_Label = "II. Contingent Receivables:">
		
			<CFELSEIF This_CASE_TYPE EQ 11 and CLRC_Query_Name CONTAINS "Removed">
				<CFSET CASE_TYPE_Label = "III. Cases To Be Removed - Contingent Liabilities:">
				
			<CFELSEIF This_CASE_TYPE EQ 12 and CLRC_Query_Name CONTAINS "Removed">
	       		<CFSET CASE_TYPE_Label = "III. Cases To Be Removed - Contingent Receivables:">
				
			</cfif>	  
			<CFSET CASE_TYPE_Label = CASE_TYPE_Label & " Assessed Below $10 Million">	
	
		</cfcase>

<!-----------------------------------KS2----------------------------------------->







		<CFCASE VALUE="NewTenMillionAndAbove">

			<CFSET CASE_TYPE_Label = "I. ">
			<CFIF This_CASE_TYPE EQ 1 OR This_CASE_TYPE EQ 11>
				<CFSET CASE_TYPE_Label = CASE_TYPE_Label & "Contingent Liabilities: ">
			<CFELSE>
				<CFSET CASE_TYPE_Label = CASE_TYPE_Label & "Contingent Receivables: ">      
   			 </cfif>

			<CFSET CASE_TYPE_Label = CASE_TYPE_Label & "New Cases Assessed At or Above $10 Million (incl. Cases Previously Below Reporting Threshold)">
		</cfcase>	<!--- end of CFCASE VALUE="NewTenMillionAndAbove"--->



		<CFCASE VALUE="MostLikelyUnderTenMillion_MaxReasonableOverOneMillion">

			<!---
			<CFSET CASE_TYPE_Label = CASE_TYPE_Label & " Contingent Liabilities: Most Likely Payout Below $10 Million and Maximum Reasonable Payout At or Above $1 Million">
			--->

			<CFSET CASE_TYPE_Label = "IV. Addendum: ">

   			 <CFIF This_CASE_TYPE EQ 1>
				<CFSET CASE_TYPE_Label = CASE_TYPE_Label & "Contingent Liabilities: Most Likely Payout Below $10 Million and Maximum Reasonable Payout At or Above $1 Million (Including New Cases and Cases Previously Reporting Below Threshold)"></CFIF>
			<CFIF This_CASE_TYPE EQ 2>
				<CFSET CASE_TYPE_Label = CASE_TYPE_Label & "Contingent Receivables: Most Likely Payout Below $10 Million and Maximum Reasonable Payout At or Above $1 Million (Including New Cases and Cases Previously Reporting Below Threshold)"></CFIF>
			<CFIF This_CASE_TYPE EQ 11>
				<CFSET CASE_TYPE_Label = CASE_TYPE_Label & "Cases To Be Removed - Contingent Liabilities: Most Likely Payout Below $10 Million and Maximum Reasonable Payout At or Above $1 Million"></CFIF>
			<CFIF This_CASE_TYPE EQ 12>
				<CFSET CASE_TYPE_Label = CASE_TYPE_Label & "Cases To Be Removed - Contingent Receivables: Most Likely Payout Below $10 Million and Maximum Reasonable Payout At or Above $1 Million"></CFIF>
   			 
   			
   			

				<!--- <CFSET CASE_TYPE_Label = CASE_TYPE_Label & "Most Likely Payout Below $10 Million and Maximum Reasonable Payout At or Above $1 Million (Including New Cases and Cases to be Removed)"> --->
			 
		</cfcase>	<!--- end of CFCASE VALUE="MostLikelyUnderTenMillion_MaxReasonableOverOneMillion"--->

	</cfswitch>  <!---end of CFSWITCH EXPRESSION="#Assess_Cutoff_List_Index#"--->



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
	
	
	
	
	 <!--- KS3 --->
	<!---<CFOUTPUT>
		<br />
		Program = "SectionHeading.cfSwitch.cfm at 398"
		<br />
		EXPRESSION = #Assess_Cutoff_List_Index#
		<br />
		Assess_Cutoff_List = #Assess_Cutoff_List#
		<br />
		Assess_Cutoff_List_Index = #Assess_Cutoff_List_Index#
		<br />
		This_CASE_TYPE = #This_CASE_TYPE#
		<br />
		CASE_TYPE_Label = #CASE_TYPE_Label#
		<br />
		CLRC_Query_Name = #CLRC_Query_Name#
		<br />
		
		<!---Value = #Value#--->
	</CFOUTPUT>--->
   
	
	
	
<!---	
	
	<!---KS2------------------------------------------------------------------------------------>
	<!---KS2------------------------------------------------------------------------------------>
	
<!--- KS2 --->
	<CFOUTPUT>
		<br />
		Program = "SectionHeading.cfSwitch.cfm at 307"
		<br />
		EXPRESSION = #Assess_Cutoff_List_Index#
		<br />
		This_CASE_TYPE = #This_CASE_TYPE#
		<br />
		<!---CASE_TYPE_Label = #CASE_TYPE_Label#--->
		<br />
	</CFOUTPUT>
	
	<!---KS1 -- Test only --->
		<cfset Assess_Cutoff_List_Index = "UnderTenMillion">
	<!------------------------------------------KS1------------------------------------------>		
	
	<CFSWITCH EXPRESSION="#This_CASE_TYPE#">
	<!---<CFSWITCH EXPRESSION="UnderTenMillion">--->
		<CFCASE VALUE="1">

			<!--- <CFSET CASE_TYPE_Label = "I. Contingent Liabilities:"> --->
			<CFSET CASE_TYPE_Label = "">

		</cfcase>
		<CFCASE VALUE="2">

			<!---<CFSET CASE_TYPE_Label = "II. Contingent Receivables:">--->
			<CFIF (
			(IsDefined("Form.CorpFinFormat") AND Form.CorpFinFormat EQ "CorpFinFormat")
			OR
			(IsDefined("Form.FrontOffcReviewFormat") AND Form.FrontOffcReviewFormat EQ "FrontOffcReviewFormat")
			OR
			(IsDefined("Form.CorpFinFormat_STL") AND Form.CorpFinFormat_STL EQ "CorpFinFormat_STL")
			)
			AND
			CLRC_Query_Name DOES NOT CONTAIN "Removed">

				<!---<CFSET CASE_TYPE_Label = "IV. ">--->
				<CFSET CASE_TYPE_Label = "III. ">
			<CFELSE>
				<CFSET CASE_TYPE_Label = "II. ">

			</cfif>

				<!---- 2/16/2023 dd32j0 Commented out and replaced with below   --->
				<CFSET CASE_TYPE_Label = CASE_TYPE_Label & "Contingent Receivables: ">

		</cfcase>

		<CFCASE VALUE="11">

			<!---<CFSET CASE_TYPE_Label = "II. Cases To Be Removed -- Contingent Liabilities:">--->

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

		</cfcase><!---end of case value = "11"--->


		<CFCASE VALUE="12">

			<!--- <CFSET CASE_TYPE_Label = "II. Cases To Be Removed -- Contingent Receivables:"> --->

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

		</cfcase> <!--- end of  CFCASE VALUE="12"  --->

		<!--- Corp Fin only --->
		<CFCASE VALUE="Addendum">
			<CFSET CASE_TYPE_Label = "IV. Addendum:">
			<!---<CFSET CASE_TYPE_Label = "V. Addendum:">--->
		</cfcase>   <!--- end of CFCASE VALUE="Addendum" ---->

	</cfswitch>  <!---end of CFSWITCH EXPRESSION="#This_CASE_TYPE#"--->
   
   
   <!--- KS1 --->
	<CFOUTPUT>
		<br />
		Program = "SectionHeading.cfSwitch.cfm at 158"
		<br />
		EXPRESSION = #Assess_Cutoff_List_Index#
		<br />
		This_CASE_TYPE = #This_CASE_TYPE#
		<br />
		CASE_TYPE_Label = #CASE_TYPE_Label#
		<br />
	</CFOUTPUT>
   
   
   
   
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
		</cfcase>	<!--- end of CFCASE VALUE="TenMillionAndAbove"--->

<!---KS1 8/19--->

<!-----------------------------------KS1----------------------------------------->
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
					<CFSET CASE_TYPE_Label = "I.kkkkkkkkkk ">
				</cfif>

				<CFSET CASE_TYPE_Label = CASE_TYPE_Label & "Contingent Liabilities: ">
			</cfif>

			<CFSET CASE_TYPE_Label = CASE_TYPE_Label & " Assessed Below $10 Million">
		</cfcase>

<!-----------------------------------KS1----------------------------------------->







		<CFCASE VALUE="NewTenMillionAndAbove">

			<CFSET CASE_TYPE_Label = "I. ">
			<CFIF This_CASE_TYPE EQ 1 OR This_CASE_TYPE EQ 11>
				<CFSET CASE_TYPE_Label = CASE_TYPE_Label & "Contingent Liabilities: ">
			<CFELSE>
				<CFSET CASE_TYPE_Label = CASE_TYPE_Label & "Contingent Receivables: ">      
   			 </cfif>

			<CFSET CASE_TYPE_Label = CASE_TYPE_Label & "New Cases Assessed At or Above $10 Million (incl. Cases Previously Below Reporting Threshold)">
		</cfcase>	<!--- end of CFCASE VALUE="NewTenMillionAndAbove"--->



		<CFCASE VALUE="MostLikelyUnderTenMillion_MaxReasonableOverOneMillion">

			<!---
			<CFSET CASE_TYPE_Label = CASE_TYPE_Label & " Contingent Liabilities: Most Likely Payout Below $10 Million and Maximum Reasonable Payout At or Above $1 Million">
			--->

			<CFSET CASE_TYPE_Label = "IV. Addendum: ">

   			 <CFIF This_CASE_TYPE EQ 1>
				<CFSET CASE_TYPE_Label = CASE_TYPE_Label & "Contingent Liabilities: Most Likely Payout Below $10 Million and Maximum Reasonable Payout At or Above $1 Million (Including New Cases)"></CFIF>
			<CFIF This_CASE_TYPE EQ 2>
				<CFSET CASE_TYPE_Label = CASE_TYPE_Label & "Contingent Receivables: Most Likely Payout Below $10 Million and Maximum Reasonable Payout At or Above $1 Million (Including New Cases)"></CFIF>
			<CFIF This_CASE_TYPE EQ 11>
				<CFSET CASE_TYPE_Label = CASE_TYPE_Label & "Contingent Liabilities: Most Likely Payout Below $10 Million and Maximum Reasonable Payout At or Above $1 Million (Including Cases to be Removed)"></CFIF>
			<CFIF This_CASE_TYPE EQ 12>
				<CFSET CASE_TYPE_Label = CASE_TYPE_Label & "Contingent Receivables: Most Likely Payout Below $10 Million and Maximum Reasonable Payout At or Above $1 Million (Including Cases to be Removed)"></CFIF>
   			 
   			
   			

				<!--- <CFSET CASE_TYPE_Label = CASE_TYPE_Label & "Most Likely Payout Below $10 Million and Maximum Reasonable Payout At or Above $1 Million (Including New Cases and Cases to be Removed)"> --->
			 
		</cfcase>	<!--- end of CFCASE VALUE="MostLikelyUnderTenMillion_MaxReasonableOverOneMillion"--->

	</cfswitch>  <!---end of CFSWITCH EXPRESSION="#Assess_Cutoff_List_Index#"--->



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
	
--->


