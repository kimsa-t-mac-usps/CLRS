<CFSET ASSESSMENT_PROBABILITY_LabelList = "Probable,Reasonably Possible,Remote">

<!--- Also: --->
<CFSET ASSESSMENT_PROBABILITY_Label_List = "a Probable,b. Reasonably Possible,c. Remote">
<CFSET ASSESSMENT_PROBABILITY_Label_List_Len = ListLen(ASSESSMENT_PROBABILITY_Label_List)>


<!---Kimsa<CFSET CASE_TYPE_LabelList = "Liability,Receivable,Addendum_Liability,Addendum_Receivable">--->
<CFSET CASE_TYPE_LabelList = "Liability,Receivable,Addendum">


<CFSET CLAIM_CATEGORY_Labels = "Business,Labor,Tort">

<CFSET CLAIM_CATEGORY_Labels_Select = "Business,Labor,Labor -- Non-HQ,Tort">



<CFSET Unions_List = "">

<CFSET Unions_List = ListAppend(Unions_List, "APWU")>

<CFSET Unions_List = ListAppend(Unions_List, "IT Accounting Services")>

<CFSET Unions_List = ListAppend(Unions_List, "Letter Carriers")>

<CFSET Unions_List = ListAppend(Unions_List, "Mail Handlers")>

<CFSET Unions_List = ListAppend(Unions_List, "Nurses")>

<CFSET Unions_List = ListAppend(Unions_List, "Postal Police Officers")>

<CFSET Unions_List = ListAppend(Unions_List, "Rural Carriers")>

<CFSET Unions_List = ListAppend(Unions_List, "Other")>

<CFSET Unions_List = ListAppend(Unions_List, "N/A")>



<CFSET CLAIM_CATEGORY_Labels_Ct = 0>
<CFSET CLAIM_CATEGORY_Label_List = "">

<CFLOOP INDEX="CLAIM_CATEGORY_Labels_Index" LIST="#CLAIM_CATEGORY_Labels#">

	<CFSET CLAIM_CATEGORY_Labels_Ct = CLAIM_CATEGORY_Labels_Ct + 1>

	<CFIF IsDefined("SelectedCategory")
	AND
	SelectedCategory NEQ "ALL">
    
		<CFIF CLAIM_CATEGORY_Labels_Index EQ SelectedCategory>
		   	<CFSET CLAIM_CATEGORY_Label_List = CLAIM_CATEGORY_Labels_Ct & ". " & CLAIM_CATEGORY_Labels_Index & " Claims">
        <CFBREAK>
		</CFIF>

	<CFELSE>

		<CFSET CLAIM_CATEGORY_Label_List = ListAppend(CLAIM_CATEGORY_Label_List, CLAIM_CATEGORY_Labels_Ct & ". " & CLAIM_CATEGORY_Labels_Index & " Claims")>
       
	</CFIF>
    
</CFLOOP>



<CFSET CLAIM_CATEGORY_Label_List_Len = ListLen(CLAIM_CATEGORY_Label_List)>



<!--- Old STL values: No=1, Yes=2 --->
<CFSET SHORT_TERM_LIABILITY_LabelList = "No,Yes">


<CFSET Estimated_Time_Resolution_ValueList = "2,100,200">
<CFSET Estimated_Time_Resolution_LabelList = "Less Than 1 Year,1 - 5 Years,Over 5 Years">


<CFSET Estimated_Time_Payout_ValueList = "0,2,100,200">
<CFSET Estimated_Time_Payout_LabelList = "Same as Estimated Time to Resolution,Less Than 1 Year,1 - 5 Years,Over 5 Years">





<CFIF (
(IsDefined("Form.CorpFinFormat") AND Form.CorpFinFormat EQ "CorpFinFormat")
OR
(IsDefined("Form.FrontOffcReviewFormat") AND Form.FrontOffcReviewFormat EQ "FrontOffcReviewFormat")
OR
(IsDefined("Form.CorpFinFormat_STL") AND Form.CorpFinFormat_STL EQ "CorpFinFormat_STL")
)>

	<CFSET Current_Removed_List = "New,Removed,Current">

<CFELSE>

	<!--- <CFSET Current_Removed_List = "Current,Removed"> Lenee'--->
	<!---<CFSET Current_Removed_List = "New,Removed">kimsa---> 
	<CFSET Current_Removed_List = "Current,Removed">

</cfif>



<CFIF (
(IsDefined("Form.CorpFinFormat") AND Form.CorpFinFormat EQ "CorpFinFormat")
OR
(IsDefined("Form.FrontOffcReviewFormat") AND Form.FrontOffcReviewFormat EQ "FrontOffcReviewFormat")
OR
(IsDefined("Form.CorpFinFormat_STL") AND Form.CorpFinFormat_STL EQ "CorpFinFormat_STL")
)>

<!---
	<CFSET Current_Removed_List_Reverse = "Removed,Current,New">
--->


	<CFSET Current_Removed_List_Reverse = "Current,Removed,New">

<CFELSE>

	<!---<CFSET Current_Removed_List_Reverse = "Removed,New">kimsa--->
	<CFSET Current_Removed_List_Reverse = "Removed,Current">

</cfif>




<!--- <CFSET Case_Type_List_Reverse = "Receivables,Liabilities"> Lenee'--->
<!---<CFSET Case_Type_List_Reverse = "Liabilities,Receivables">kimsa --->
<CFSET Case_Type_List_Reverse = "Receivables,Liabilities">


<CFSET ChecklistAnswerOptionsLabels = "Yes,No,Not Applicable,Unknown At This Time">


<!---
<CFSET Case_Type_List = "Liabilities,Receivables">
--->

<CFSET Unknown_NA_List = "Unknown,N/A">

<cfset YesNo_List = "Y,N,0">




