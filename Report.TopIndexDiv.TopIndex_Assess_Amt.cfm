<cfinclude template="MfaCookieCheck.cfm">

<!--- 
For Front Office Review or Short-term Liabilities: Show Most Likely Payout in Index entry 

Used in Report.TopIndexDiv.cfloops.cfm
--->

<CFIF ((IsDefined("Form.FrontOffcReviewFormat") AND Form.FrontOffcReviewFormat EQ "FrontOffcReviewFormat") 
OR
(IsDefined("Form.CorpFinFormat_STL") AND Form.CorpFinFormat_STL EQ "CorpFinFormat_STL"))
AND
TopIndex_Assess_Amt NEQ "">

	<CFOUTPUT>
	<span class="TopIndexAmt">#TopIndex_Assess_Amt#</span>
	</cfoutput>

	<CFIF NOT (IsDefined("Form.CorpFinFormat_STL") AND Form.CorpFinFormat_STL EQ "CorpFinFormat_STL")>

		<CFIF SHORT_TERM_LIABILITY EQ 2>
			<span class="ShortTermFlag">S</span>
		</cfif>

	</cfif>

</cfif>




