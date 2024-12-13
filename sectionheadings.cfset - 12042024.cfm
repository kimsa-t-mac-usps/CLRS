<cfinclude template="MfaCookieCheck.cfm">

<!---------------------- SectionHeading.cfset.cfm ---------------------------->
<!---------------------------------------------------------------------------->
<!--- KS1 --->
	<!---<CFOUTPUT>
		<br />
		Program = "SectionHeading.cfset.cfm at 4"
		<br />
	</CFOUTPUT>--->
	
	
<!---

Sets headings, subheadings
Calculates totals for  short-term liabilities(STL)

--->



<!---KS2 --->
<!---<CFOUTPUT>
<p>
In sectionheadings.cfset.cfm at 17: 
<br>
CASE_TYPE_Label = #CASE_TYPE_Label#
<br>
Old_CASE_TYPE_Label = #Old_CASE_TYPE_Label#
<br>
This_CASE_TYPE = #This_CASE_TYPE#
<br>
Assess_Cutoff_List_Index = #Assess_Cutoff_List_Index#
<p>
</cfoutput>--->

<!---<CFOUTPUT>
<p>
HeaderParm = #HeaderParm#
<p>
</cfoutput>--->
<!---<cfdump var="#Form#" >--->
<!---ks2 -------------------------------------------------------------------------------------->
	<CFIF (This_CASE_TYPE EQ 2
		and CASE_TYPE_Label EQ "II. Contingent Receivables: Assessed Below $10 Million"
			and CASE_TYPE_Label NEQ Old_CASE_TYPE_Label
				and Assess_Cutoff_List_Index EQ "UnderTenMillion")>
		<CFOUTPUT>
			<!---<cfdump var="#CASE_TYPE_Label#" >--->
			<a #AParm#><h5 class="SectionHeadAfterFirst">#CASE_TYPE_Label#</h5></a>
		</cfoutput>
		
	<CFELSEIF (This_CASE_TYPE EQ 11
		and CASE_TYPE_Label EQ "III. Cases To Be Removed - Contingent Liabilities: Assessed Below $10 Million"
			and CASE_TYPE_Label NEQ Old_CASE_TYPE_Label
				and Assess_Cutoff_List_Index EQ "UnderTenMillion")>
	<CFOUTPUT>
	<!---<a #AParm#><h3 class="SectionHeadAfterFirst">#CASE_TYPE_Label#</h3></a sectionheadings.cfset.cfm at 115>--->
	</cfoutput>
	
	<CFELSEIF (This_CASE_TYPE EQ 12
		and CASE_TYPE_Label EQ "III. Cases To Be Removed - Contingent Liabilities: Assessed Below $10 Million"
			and CASE_TYPE_Label NEQ Old_CASE_TYPE_Label
				and Assess_Cutoff_List_Index EQ "UnderTenMillion")>
	<CFOUTPUT>
	<a #AParm#><h3 class="SectionHeadAfterFirst">#CASE_TYPE_Label#</h3></a sectionheadings.cfset.cfm at 115>
	</cfoutput>
	
	</CFIF>	
	
<!---ks2 -------------------------------------------------------------------------------------->
<CFIF NOT IsDefined("CASE_TYPE")
AND
IsDefined("This_CASE_TYPE")>

	<CFSET CASE_TYPE = This_CASE_TYPE>

</CFIF>


<CFIF CASE_TYPE_Label NEQ Old_CASE_TYPE_Label>

	<CFIF Old_CASE_TYPE_Label NEQ "" 
	AND 
	HeaderParm NEQ "TopIndex">
    
		<CFSET ThisASSESSMENT_PROBABILITY = ASSESSMENT_PROBABILITY>
		<CFINCLUDE TEMPLATE="ASSESSMENT_PROBABILITY_Label_Count.loop.cfm">
	
    </cfif>


	<CFIF HeaderParm EQ "TopIndex">
		
		<CFSET AParm = 'href = "##' & CASE_TYPE_Label & '"'>
	<CFELSE>
		<CFSET AParm = 'name = "' & CASE_TYPE_Label & '"'>
		
	</cfif>


	<CFIF HeaderParm EQ "TopIndex">

<!---
		Assess_Cutoff_List_Index EQ "MostLikelyUnderTenMillion_MaxReasonableOverTenMillion"
--->


		<CFIF NOT
		(
		<!---kimsaAssess_Cutoff_List_Index EQ "MostLikelyUnderTenMillion_MaxReasonableOverOneMillion"--->
		     Assess_Cutoff_List_Index EQ "UnderTenMillion"
		AND
		This_CASE_TYPE EQ 2
		)>


			<CFIF 
			IsDefined("Form.CorpFinFormat") 
			AND 
			Form.CorpFinFormat EQ "CorpFinFormat">
	
<!---
				<CFIF NOT
				(
				CASE_TYPE EQ 1 
				AND	
				Assess_Cutoff_List_Index EQ "New1MillionAndAbove"
				)>
--->	    


<!---
				Assess_Cutoff_List_Index EQ "NewOneMillionAndAbove"
--->


				<CFIF NOT
				(
				(
				CASE_TYPE EQ 1 
				OR
				CASE_TYPE EQ 11
				)
				AND	
				Assess_Cutoff_List_Index EQ "NewTenMillionAndAbove"
				)>



					<br>
					<!---<hr style="width:350pt; color:lightgrey" sectionheadings.cfset.cfm at 71>--->
	        
		        </CFIF>
	
			<CFELSEIF NOT
			(
			CASE_TYPE EQ 1 
			AND	
			Assess_Cutoff_List_Index EQ "TenMillionAndAbove"
			)>
	
				<br>
				<!---<hr style="width:350pt; color:lightgrey" sectionheadings.cfset.cfm at 83>--->
	
			</cfif>

<!---
			Assess_Cutoff_List_Index EQ "NewOneMillionAndAbove"
--->

			<CFIF NOT
			(
			CASE_TYPE EQ 11
			AND	
			Assess_Cutoff_List_Index EQ "NewTenMillionAndAbove"
			)>

				<CFOUTPUT>
				<a sectionheadings.cfset.cfm at 89 #AParm#><h5>#CASE_TYPE_Label#</h5></a>
				</cfoutput>

			</CFIF>


		</CFIF>
        
        
    <!--- KS2 --->
	<!---<CFOUTPUT>
		<br />
		Program = "SectionHeading.cfSet.cfm at 154 -- KS2"
		<br />
		Case_Type = #Case_Type#
		<br />
		Assess_Cutoff_List_Index = #Assess_Cutoff_List_Index#
		<br />
		CASE_TYPE_Label = #CASE_TYPE_Label#
		<br />
		<!---<a #AParm#><h3 class="SectionHeadAfterFirst">#CASE_TYPE_Label#</h3></a sectionheadings.cfset.cfm at 115>--->
		
	</CFOUTPUT> --->   
        

		<CFIF This_RecordCount EQ 0>
			<p>
			[No Cases] 
                
<!---
                [sectionheadings.cfset.cfm at 101]
--->
			<p>
		</cfif>

	
<!--- From <CFIF HeaderParm EQ "TopIndex"> --->
	<CFELSE>
	
		<!---</table sectionheadings.cfset.cfm at 119>--->


		<CFIF CASE_TYPE_Label DOES NOT CONTAIN "I. Contingent Liabilities">
<!---<p>kimsa1</p>--->
	    	<cfoutput>
	    		
	    		<!---<h5>#CASE_TYPE_LABEL#rao</h5>--->
		
			<!---<a #AParm#><h3 class="SectionHead">#CASE_TYPE_Label#</h3></a sectionheadings.cfset.cfm at 102>--->
			</cfoutput>
<!---<p>kimsa2</p>--->
		<CFELSE>

<!---
			CASE_TYPE_Label CONTAINS "Assessed At or Above $5 Million">
--->

			<CFIF NOT
			(
			IsDefined("Form.CorpFinFormat") 
			AND 
			Form.CorpFinFormat EQ "CorpFinFormat"
			)
			AND
			CASE_TYPE_Label CONTAINS "Assessed At or Above $10 Million">
    
				<CFOUTPUT>
				<a #AParm#><h3 class="SectionHeadAfterFirst">#CASE_TYPE_Label#</h3></a sectionheadings.cfset.cfm at 115>
				</cfoutput>

			<CFELSE>

				<cfoutput>
				<a #AParm#><h3 class="SectionHead">#CASE_TYPE_Label#</h3></a sectionheadings.cfset.cfm at 121>
				</cfoutput>

			</cfif>

		</cfif>


		<CFIF This_RecordCount EQ 0>
			<p>
			[No Cases]

<!---
                 [sectionheadings.cfset.cfm at 147]
--->

			<p>
		</cfif>



<!--- Close CFELSE <CFIF HeaderParm EQ "TopIndex"> --->
	</cfif>


	<CFSET Old_CASE_TYPE_Label = CASE_TYPE_Label>
        
        
<!---        
		<table class="CorpFin" cellpadding=7 cellspacing=7 border=0>
		<CFINCLUDE TEMPLATE="Report.CorpFinTableHeaderRow.cfm">
--->  
    
    
<!---    
	<CFIF This_RecordCount NEQ 0
	AND
	CASE_TYPE_Label DOES NOT CONTAIN "IV. Contingent Receivables">
--->
   
   
   	<CFIF This_RecordCount NEQ 0>
   
<!---
		<CFIF CASE_TYPE_Label CONTAINS "IV. Contingent Receivables">

       
       
			<CFIF HeaderParm NEQ "TopIndex">
	   
				<table class="CorpFin" cellpadding=7 cellspacing=7 border=0>
				<CFINCLUDE TEMPLATE="Report.CorpFinTableHeaderRow.cfm">
	   
			</cfif>
	

		<CFELSE>
--->
	        
			<CFSET ThisASSESSMENT_PROBABILITY = ASSESSMENT_PROBABILITY>
	
	<!---
	<p>
	In cfset.cfm, Line 55: Before ASSESSMENT.loop.cfm:
	<p>
	--->
	
			<CFINCLUDE TEMPLATE="ASSESSMENT_PROBABILITY_Label_Count.loop.cfm">
	
			<CFIF HeaderParm EQ "TopIndex">
				<CFSET AParm = 'href = "##' & CASE_TYPE_Label & '_' & ASSESSMENT_PROBABILITY_Label & '"'>
				<CFSET ThisCumulativeTotal = CASE_TYPE_Label & "_" & ASSESSMENT_PROBABILITY_Label & "_Cumulative">
			<CFELSE>
				<CFSET AParm = 'name = "' & CASE_TYPE_Label & '_' & ASSESSMENT_PROBABILITY_Label & '"'>
			</cfif>
	
			<CFIF HeaderParm EQ "TopIndex">
				<h5>
			<CFELSE>
				<h4 style="sectionheadings.cfset.cfm at 163">
			</cfif>
	
			<CFOUTPUT>
			<a #AParm#>#ASSESSMENT_PROBABILITY_Label#</a sectionheadings.cfset.cfm at 178>
			</cfoutput>
	
	
			<CFIF HeaderParm EQ "TopIndex">
	
	
	<!---<CFOUTPUT>
	<br>
	#ASSESSMENT_PROBABILITY_Label_Count#
	<p>
	</cfoutput>--->
	
	
				<CFIF ASSESSMENT_PROBABILITY_Label_Count GT 3>
					<CFSET Adjusted_ASSESSMENT_PROBABILITY_Label_Count = ASSESSMENT_PROBABILITY_Label_Count - 3>
				<CFELSE>
					<CFSET Adjusted_ASSESSMENT_PROBABILITY_Label_Count = ASSESSMENT_PROBABILITY_Label_Count>
				</cfif>
	
	
				<CFSET ThisCumulativeArray = "">
	
	
				<CFSWITCH EXPRESSION="#Adjusted_ASSESSMENT_PROBABILITY_Label_Count#">
	
					<CFCASE VALUE="1">
						<CFSET ThisCumulativeArray = "CumulativeProbable">
					</cfcase>
	
					<CFCASE VALUE="2">
						<CFSET ThisCumulativeArray = "CumulativeReasPoss">
					</cfcase>
	
					<CFCASE VALUE="3">
						<CFSET ThisCumulativeArray = "CumulativeRemote">
					</cfcase>
	
				</cfswitch>
	
<!---
	<CFOUTPUT>
	sectionheadings.cfset.cfm at 295:
	<br />
	CASE_TYPE = #CASE_TYPE#
	<p>
	</CFOUTPUT>
--->
	
				<CFSWITCH EXPRESSION="#This_CASE_TYPE#">
	
					<CFCASE VALUE="1">
						<CFSET ThisCumulativeArray = "Liab_" & ThisCumulativeArray & "_" & Assess_Cutoff_List_Index>
					</cfcase>
	
					<CFCASE VALUE="2">
						<CFSET ThisCumulativeArray = "Receiv_" & ThisCumulativeArray & "_" & Assess_Cutoff_List_Index>
					</cfcase>
	
					<CFCASE VALUE="11">
						<CFSET ThisCumulativeArray = "Liab_" & ThisCumulativeArray & "_" & Assess_Cutoff_List_Index & "_Removed">
					</cfcase>
	
					<CFCASE VALUE="12">
						<CFSET ThisCumulativeArray = "Receiv_" & ThisCumulativeArray & "_" & Assess_Cutoff_List_Index & "_Removed">
					</cfcase>
	
					<CFCASE VALUE="Addendum">
						<CFSET ThisCumulativeArray = "Addendum_" & ThisCumulativeArray & "_" & Assess_Cutoff_List_Index>
						<CFSET Addendum_Flag = "yes">
					</cfcase>
	
				</cfswitch>
	
	
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
	
					<!---<CFOUTPUT>
					<span id="#ThisCumulativeArray#" class="CumulativeTotal">(Total for #ThisCumulativeTotal#)</span>
					</cfoutput>--->
	                
				</cfif>
	
	
				</h5>
	
			<CFELSE>
	
				</h4>
	
	<!--- Close <CFIF HeaderParm EQ "TopIndex"> --->
			</cfif>
	
	
			<CFSET ASSESSMENT_PROBABILITY_Label_Count = ASSESSMENT_PROBABILITY_Label_Count + 1> 
			<CFSET Old_ASSESSMENT_PROBABILITY_Label = ASSESSMENT_PROBABILITY_Label>
			<CFSET CLAIM_CATEGORY_Label_Count = 1> 
			<CFSET ThisCLAIM_CATEGORY = CLAIM_CATEGORY>
	
			<CFINCLUDE TEMPLATE="CLAIM_CATEGORY_Label_Count.loop.cfm">
	
	
			<CFIF HeaderParm EQ "TopIndex">
	        
				<CFSET AParm = 'href = "##' & CASE_TYPE_Label & '_' & ASSESSMENT_PROBABILITY_Label & '_' & CLAIM_CATEGORY_Label & '"'>
				<CFSET ThisCumulativeTotal = CASE_TYPE_Label & "_" & ASSESSMENT_PROBABILITY_Label & "_" & CLAIM_CATEGORY_Label & "_Cumulative">
	
			<CFELSE>
	        
				<CFSET AParm = 'name = "' & CASE_TYPE_Label & '_' & ASSESSMENT_PROBABILITY_Label & '_' & CLAIM_CATEGORY_Label & '"'>
	
			</cfif>
	
	
			<CFIF HeaderParm EQ "TopIndex">
				<CFSET CheckFlag = "no">
				<h5 style="position:relative; left:15pt">
			<CFELSE>
				<h5>
			</cfif>
	
	
			<CFOUTPUT>
			<a #AParm#>#CLAIM_CATEGORY_Label#</a>
			</cfoutput>
	
	
			<CFIF HeaderParm EQ "TopIndex" 
			AND 
			(
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
			)
			)>
	
				<!---<CFOUTPUT>
				<span id="#ThisCumulativeArray#_#CLAIM_CATEGORY_Label_Count#" class="CumulativeTotal">(Total for #ThisCumulativeTotal#)</span>
				</cfoutput>--->
	
			</cfif>
	
	
			</h5>


<!---
			Assess_Cutoff_List_Index EQ "Under5Million" 
			OR
			Assess_Cutoff_List_Index EQ "MostLikelyUnderTenMillion_MaxReasonableOverTenMillion"
--->

	
	
			<CFIF HeaderParm NEQ "TopIndex" 
			AND 
			IsDefined("Form.CorpFinFormat") 
			AND 
			Form.CorpFinFormat EQ "CorpFinFormat"
			AND 
			(
			Assess_Cutoff_List_Index EQ "UnderTenMillion" 
			OR
			Assess_Cutoff_List_Index EQ "MostLikelyUnderTenMillion_MaxReasonableOverOneMillion"
			)>
	
				</table sectionheadings.cfset.cfm at 402>
				<table class="CorpFin" cellpadding=7 cellspacing=7 border=0>
				<CFINCLUDE TEMPLATE="Report.CorpFinTableHeaderRow.cfm">
	
			</cfif>
	
	
			<CFSET Old_CLAIM_CATEGORY_Label = CLAIM_CATEGORY_Label>
			<CFSET CLAIM_CATEGORY_Label_Count = CLAIM_CATEGORY_Label_Count + 1> 
	
	
<!---
	<!--- Close CFELSE 	<CFIF CASE_TYPE_Label CONTAINS "IV. Contingent Receivables"> --->
		</cfif>
--->	


<!--- Close <CFIF This_RecordCount NEQ 0> --->
	</cfif>



<!--- From <CFIF CASE_TYPE_Label NEQ Old_CASE_TYPE_Label> --->
<CFELSEIF ASSESSMENT_PROBABILITY_Label NEQ Old_ASSESSMENT_PROBABILITY_Label>

<!---
		<CFIF This_RecordCount NEQ 0
		AND
		CASE_TYPE_Label DOES NOT CONTAIN "IV. Contingent Receivables">
--->


	<CFINCLUDE TEMPLATE="CLAIM_CATEGORY_Label_Count.loop.cfm">

	<CFIF HeaderParm NEQ "TopIndex">

		</table sectionheadings.cfset.cfm at 437>

	</cfif>

	<CFSET ThisASSESSMENT_PROBABILITY = ASSESSMENT_PROBABILITY>

	<CFINCLUDE TEMPLATE="ASSESSMENT_PROBABILITY_Label_Count.loop.cfm">


	<CFIF HeaderParm EQ "TopIndex">
		<CFSET AParm = 'href = "##' & CASE_TYPE_Label & '_' & ASSESSMENT_PROBABILITY_Label & '"'>
		<CFSET ThisCumulativeTotal = CASE_TYPE_Label & "_" & ASSESSMENT_PROBABILITY_Label & "_Cumulative">
	<CFELSE>
		<CFSET AParm = 'name = "' & CASE_TYPE_Label & '_' & ASSESSMENT_PROBABILITY_Label & '"'>
	</cfif>

<!---
	<CFIF IsDefined("Form.CorpFinFormat") 
	AND 
	Form.CorpFinFormat EQ "CorpFinFormat"
	AND
	CASE_TYPE_Label DOES NOT CONTAIN "Addendum"
	AND
	ASSESSMENT_PROBABILITY_Label EQ "C. Remote">

		<CFSET RemoteAssessedNote = ": Assessed At or Above $10 Million">

	<CFELSE>

		<CFSET RemoteAssessedNote = "">

	</CFIF>
--->


	<CFSET RemoteAssessedNote = "">



	<CFIF HeaderParm EQ "TopIndex">

		<CFOUTPUT>
		<h5><a #AParm#>#ASSESSMENT_PROBABILITY_Label##RemoteAssessedNote#</a sectionheadings.cfset.cfm at 390>
		</cfoutput>

<!---
<CFOUTPUT>
<br>
#ASSESSMENT_PROBABILITY_Label_Count#
<p>
</cfoutput>
--->


		<CFIF ASSESSMENT_PROBABILITY_Label_Count GT 3>
			<CFSET Adjusted_ASSESSMENT_PROBABILITY_Label_Count = ASSESSMENT_PROBABILITY_Label_Count - 3>
		<CFELSE>
			<CFSET Adjusted_ASSESSMENT_PROBABILITY_Label_Count = ASSESSMENT_PROBABILITY_Label_Count>
		</cfif>


		<CFSET ThisCumulativeArray = "">


		<CFSWITCH EXPRESSION="#Adjusted_ASSESSMENT_PROBABILITY_Label_Count#">

			<CFCASE VALUE="1">
				<CFSET ThisCumulativeArray = "CumulativeProbable">
			</cfcase>

			<CFCASE VALUE="2">
				<CFSET ThisCumulativeArray = "CumulativeReasPoss">
			</cfcase>

			<CFCASE VALUE="3">
				<CFSET ThisCumulativeArray = "CumulativeRemote">
			</cfcase>

		</cfswitch>


		<CFIF IsDefined("Addendum_Flag") 
		AND 
		Addendum_Flag EQ "yes">
        
			<CFSET ThisCumulativeArray = "Addendum_" & ThisCumulativeArray & "_" & Assess_Cutoff_List_Index>
		
		<CFELSEIF CASE_TYPE EQ 1>
		
        	<CFSET ThisCumulativeArray = "Liab_" & ThisCumulativeArray & "_" & Assess_Cutoff_List_Index>
		
        <CFELSE>
		
        	<CFSET ThisCumulativeArray = "Receiv_" & ThisCumulativeArray & "_" & Assess_Cutoff_List_Index>
		
        </cfif>


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

			<!---<CFOUTPUT>
			<span id="#ThisCumulativeArray#" class="CumulativeTotal">(Total for #ThisCumulativeTotal#)</span>
			</cfoutput>--->
                
		</cfif>

		</h5>

<!--- From <CFIF HeaderParm EQ "TopIndex"> --->
	<CFELSE>

		<CFOUTPUT>
		<a #AParm#><h4 class="SectionHead" style="sectionheadings.cfset.cfm at 442">#ASSESSMENT_PROBABILITY_Label##RemoteAssessedNote#</h4></a>
		</cfoutput>

	</cfif>
        

	<CFSET ASSESSMENT_PROBABILITY_Label_Count = ASSESSMENT_PROBABILITY_Label_Count + 1> 
	<CFSET Old_ASSESSMENT_PROBABILITY_Label = ASSESSMENT_PROBABILITY_Label>
	<CFSET CLAIM_CATEGORY_Label_Count = 1> 
	<CFSET ThisCLAIM_CATEGORY = CLAIM_CATEGORY>

	<CFINCLUDE TEMPLATE="CLAIM_CATEGORY_Label_Count.loop.cfm">


	<CFIF HeaderParm EQ "TopIndex">
		<CFSET AParm = 'href = "##' & CASE_TYPE_Label & '_' & ASSESSMENT_PROBABILITY_Label & '_' & CLAIM_CATEGORY_Label & '"'>
		<CFSET ThisCumulativeTotal = CASE_TYPE_Label & "_" & ASSESSMENT_PROBABILITY_Label & "_" & CLAIM_CATEGORY_Label & "_Cumulative">
	<CFELSE>
		<CFSET AParm = 'name = "' & CASE_TYPE_Label & '_' & ASSESSMENT_PROBABILITY_Label & '_' & CLAIM_CATEGORY_Label & '"'>
	</cfif>


	<CFIF HeaderParm EQ "TopIndex">
		<CFSET CheckFlag = "no">
		<h5 style="position:relative; left:15pt">
	<CFELSE>
		<h5>
	</cfif>


	<CFOUTPUT>
	<a #AParm#>#CLAIM_CATEGORY_Label#</a>
	</cfoutput>


	<CFIF HeaderParm EQ "TopIndex" 
	AND 
	(
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
	)
	)>

		<!---<CFOUTPUT>
		<span id="#ThisCumulativeArray#_#CLAIM_CATEGORY_Label_Count#" class="CumulativeTotal">(Total for #ThisCumulativeTotal#)</span>
		</cfoutput>--->
            
	</cfif>

	</h5>


<!---
	Assess_Cutoff_List_Index EQ "Under5Million" 
	OR
	Assess_Cutoff_List_Index EQ "MostLikelyUnderTenMillion_MaxReasonableOverTenMillion"
--->


	<CFIF HeaderParm NEQ "TopIndex" 
	AND 
	IsDefined("Form.CorpFinFormat") 
	AND 
	Form.CorpFinFormat EQ "CorpFinFormat"
	AND 
	(
	Assess_Cutoff_List_Index EQ "UnderTenMillion" 
	OR
	Assess_Cutoff_List_Index EQ "MostLikelyUnderTenMillion_MaxReasonableOverOneMillion"
	)>

		</table sectionheadings.cfset.cfm at 627>
		<table class="CorpFin" cellpadding=7 cellspacing=7 border=0>
		<CFINCLUDE TEMPLATE="Report.CorpFinTableHeaderRow.cfm">
            
	</cfif>


	<CFSET CLAIM_CATEGORY_Label_Count = CLAIM_CATEGORY_Label_Count + 1> 
	<CFSET Old_CLAIM_CATEGORY_Label = CLAIM_CATEGORY_Label>


<!--- From <CFIF CASE_TYPE_Label NEQ Old_CASE_TYPE_Label> --->
<CFELSEIF CLAIM_CATEGORY_Label NEQ Old_CLAIM_CATEGORY_Label>

	<CFSET ThisCLAIM_CATEGORY = CLAIM_CATEGORY>
	<CFINCLUDE TEMPLATE="CLAIM_CATEGORY_Label_Count.loop.cfm">

	<CFIF HeaderParm NEQ "TopIndex" 
	AND 
	ThisCLAIM_CATEGORY GT 1>

		</table sectionheadings.cfset.cfm at 648>

		<CFOUTPUT>

		<h4 class="SectionHead" style="sectionheadings.cfset.cfm at 542">#ASSESSMENT_PROBABILITY_Label# <small>[cont'd]</small></h4>

		</cfoutput>

	</cfif>


	<CFIF HeaderParm EQ "TopIndex">
    
		<CFSET AParm = 'href = "##' & CASE_TYPE_Label & '_' & ASSESSMENT_PROBABILITY_Label & '_' & CLAIM_CATEGORY_Label & '"'>
		<CFSET ThisCumulativeTotal = CASE_TYPE_Label & "_" & ASSESSMENT_PROBABILITY_Label & "_" & CLAIM_CATEGORY_Label & "_Cumulative">
	<CFELSE>
    
		<CFSET AParm = 'name = "' & CASE_TYPE_Label & '_' & ASSESSMENT_PROBABILITY_Label & '_' & CLAIM_CATEGORY_Label & '"'>
	
    </cfif>


	<CFIF HeaderParm EQ "TopIndex">
		<CFSET CheckFlag = "no">
		<h5 style="position: relative; left:15pt">
	<CFELSE>
		<h5>
	</cfif>


	<CFOUTPUT>
	<a #AParm#>#CLAIM_CATEGORY_Label#</a>
	</cfoutput>


	<CFIF HeaderParm EQ "TopIndex" 
	AND 
	(
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
	)
	)>

		<!---<CFOUTPUT>
		<span id="#ThisCumulativeArray#_#CLAIM_CATEGORY_Label_Count#" class="CumulativeTotal">(Total for #ThisCumulativeTotal#)</span>
		</cfoutput>--->

	</cfif>


	</h5>


<!---

	Assess_Cutoff_List_Index EQ "Under5Million" 
	OR
	Assess_Cutoff_List_Index EQ "MostLikelyUnderTenMillion_MaxReasonableOverTenMillion"

--->

	<CFIF HeaderParm NEQ "TopIndex" AND IsDefined("Form.CorpFinFormat") AND  Form.CorpFinFormat EQ "CorpFinFormat"
	AND 
	(
	Assess_Cutoff_List_Index EQ "UnderTenMillion" 
	OR
	Assess_Cutoff_List_Index EQ "MostLikelyUnderTenMillion_MaxReasonableOverOneMillion"
	)>

		</table sectionheadings.cfset.cfm at 721>
		<table class="CorpFin" cellpadding=7 cellspacing=7 border=0>
		<CFINCLUDE TEMPLATE="Report.CorpFinTableHeaderRow.cfm">

	</cfif>


	<CFSET CLAIM_CATEGORY_Label_Count = CLAIM_CATEGORY_Label_Count + 1> 
	<CFSET Old_CLAIM_CATEGORY_Label = CLAIM_CATEGORY_Label>


<!--- Close <CFIF CASE_TYPE_Label NEQ Old_CASE_TYPE_Label> --->
</cfif>



<!---KS3 --->
<!---<CFOUTPUT>
<p>
In sectionheadings.cfset.cfm at 862: 
<br>
CASE_TYPE_Label = #CASE_TYPE_Label#
<br>
Old_CASE_TYPE_Label = #Old_CASE_TYPE_Label#
<br>
This_CASE_TYPE = #This_CASE_TYPE#
<br>
Assess_Cutoff_List_Index = #Assess_Cutoff_List_Index#
<p>
</cfoutput>--->


