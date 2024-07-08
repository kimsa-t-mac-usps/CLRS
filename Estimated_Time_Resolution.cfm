<cfinclude template="MfaCookieCheck.cfm">

<CFIF DateCompare(ThisReportDate, NewCLProtocolReportDate) GE 0>


	<CFIF SHORT_TERM_LIABILITY NEQ "">

		<CFIF SHORT_TERM_LIABILITY EQ 1>

			<CFSET Estimated_Time_Resolution_Label = "[Not Short-term Liability]">

		<CFELSEIF SHORT_TERM_LIABILITY GE 2>
        
			<CFSET Estimated_Time_Resolution_Label = ListGetAt(Estimated_Time_Resolution_LabelList,	ListFind(Estimated_Time_Resolution_ValueList, SHORT_TERM_LIABILITY))>
    
    	</CFIF>

	<CFELSE>

		<CFSET Estimated_Time_Resolution_Label = "[Unspecified]&nbsp;<span class='ClickEdit'>Click ""Edit This Case Record"" to specify</span>">

    </CFIF>


	<CFIF IsDefined("Form.CorpFinFormat") AND Form.CorpFinFormat EQ "CorpFinFormat" AND Left(Estimated_Time_Resolution_Label, 13) EQ "[Unspecified]">
		<CFSET Estimated_Time_Resolution_Label = "[Unspecified]">
	</cfif>


	<CFIF SHORT_TERM_LIABILITY NEQ CONTINGENT_LIAB_GetRecord_PrevRpt.SHORT_TERM_LIABILITY
	AND NOT
	(STATUS_CODE EQ 1 OR STATUS_CODE_SELECTED EQ "1")>


		<CFIF CONTINGENT_LIAB_GetRecord_PrevRpt.SHORT_TERM_LIABILITY NEQ "">

			<CFIF CONTINGENT_LIAB_GetRecord_PrevRpt.SHORT_TERM_LIABILITY EQ 1>

				<CFSET Prev_Estimated_Time_Resolution_Label = "[Not Short-term Liability]">

			<CFELSEIF CONTINGENT_LIAB_GetRecord_PrevRpt.SHORT_TERM_LIABILITY GE 2>
        
				<CFSET Prev_Estimated_Time_Resolution_Label = ListGetAt(Estimated_Time_Resolution_LabelList,	ListFind(Estimated_Time_Resolution_ValueList, CONTINGENT_LIAB_GetRecord_PrevRpt.SHORT_TERM_LIABILITY))>
    
    		</CFIF>

		<CFELSE>

			<CFSET Prev_Estimated_Time_Resolution_Label = "[Unspecified]">

	    </CFIF>



<!---
<CFOUTPUT>
Estimated_Time_Resolution_Label = "#Estimated_Time_Resolution_Label#"
<br />
Prev_Estimated_Time_Resolution_Label = "#Prev_Estimated_Time_Resolution_Label#"
<p>
</CFOUTPUT>
--->
        
        
<!---
		<CFIF Prev_Estimated_Time_Resolution_Label EQ "[Unspecified]"
		OR
		(IsDefined("Form.CorpFinFormat") AND Form.CorpFinFormat EQ "CorpFinFormat")>
--->


		<CFIF Prev_Estimated_Time_Resolution_Label EQ "[Unspecified]">

			<CFSET Estimated_Time_Resolution_Label = "<strong>" & Estimated_Time_Resolution_Label & "</strong>">

		<CFELSE>

			<CFSET Estimated_Time_Resolution_Label = "<strong>" & Estimated_Time_Resolution_Label & "</strong> " & "<div class='PreviouslyReported'>[Previously reported as: " & Prev_Estimated_Time_Resolution_Label & "]</div>">

		</CFIF>



	<CFELSEIF SHORT_TERM_LIABILITY EQ 1
	OR
	(IsDefined("UpdateNeededFlag") AND UpdateNeededFlag EQ "yes" AND SHORT_TERM_LIABILITY EQ "")
	OR
	(STATUS_CODE EQ 1 OR STATUS_CODE_SELECTED EQ "1")>

		<CFSET Estimated_Time_Resolution_Label = "<strong>" & Estimated_Time_Resolution_Label & "</strong>">

	</CFIF>


	<CFOUTPUT>
    #Estimated_Time_Resolution_Label#
   	</CFOUTPUT>    



<!--- From <CFIF DateCompare(ThisReportDate, NewCLProtocolReportDate) GE 0> --->
<CFELSE>

<!---
<CFOUTPUT>
SHORT_TERM_LIABILITY = "#SHORT_TERM_LIABILITY#"
<p>
</CFOUTPUT>
--->


	<CFIF SHORT_TERM_LIABILITY NEQ "">


		<CFIF SHORT_TERM_LIABILITY EQ 1>

			<CFSET NewList = "[Not Short-term Liability]">

		<CFELSEIF SHORT_TERM_LIABILITY GE 2>
        
			<CFSET NewList = ListGetAt(Estimated_Time_Resolution_LabelList,	ListFind(Estimated_Time_Resolution_ValueList, SHORT_TERM_LIABILITY))>
    
    	</CFIF>



	<CFELSE>

		<CFIF NOT (IsDefined("Form.CorpFinFormat") AND Form.CorpFinFormat EQ "CorpFinFormat")>

	
<!---
Earliest report with Short-term liability:
EarlierRptDate=06/30/2007
--->
	
			<CFIF NOT IsDefined("EarlierRptDate") AND NOT (IsDefined("ALT_LAW_DEPT_OFFICE_Flag") AND ALT_LAW_DEPT_OFFICE_Flag EQ "yes")>

				<CFSET NewList = '[Unspecified]&nbsp;<span class="ClickEdit">Click "Edit This Case Record" to specify</span>'>

			<CFELSEIF IsDefined("EarlierRptDate")>
	
    			<CFSET NewList = "[Unspecified]">

			<CFELSE>
			
				<CFSET NewList = "[Unspecified]">

			</cfif>

		<CFELSE>

			<CFSET NewList = "[Unspecified]">

		</cfif>

<!--- Close <CFIF SHORT_TERM_LIABILITY NEQ ""> --->
	</cfif>


	<CFIF ThisReportDate NEQ EarliestReportDate 
	AND PrevReportDate NEQ "" 
	AND CONTINGENT_LIAB_GetRecord_PrevRpt.SHORT_TERM_LIABILITY NEQ "">


		<CFIF CONTINGENT_LIAB_GetRecord_PrevRpt.SHORT_TERM_LIABILITY EQ 1>

			<CFSET OldList = "[Not Short-term Liability]">

		<CFELSEIF CONTINGENT_LIAB_GetRecord_PrevRpt.SHORT_TERM_LIABILITY GE 2>
        
			<CFSET OldList = ListGetAt(Estimated_Time_Resolution_LabelList,	ListFind(Estimated_Time_Resolution_ValueList, CONTINGENT_LIAB_GetRecord_PrevRpt.SHORT_TERM_LIABILITY))>
    
    	</CFIF>


	<CFELSE>
	
		<CFSET OldList = "">

	</cfif>


<!---
<CFOUTPUT>
ThisReportDate = #ThisReportDate#
<br />
PrevReportDate = #PrevReportDate#
<br />
OldList = "#OldList#"
<br />
NewList = "#NewList#"
<p>
</CFOUTPUT>
--->


<!---
	<CFINCLUDE TEMPLATE="CFINCLUDEs/textcompare.cfm">
--->    
    
	<CFINCLUDE TEMPLATE="textcompare.cfm">


<!--- Close <CFIF DateCompare(ThisReportDate, NewCLProtocolReportDate) GE 0> --->
</CFIF>



