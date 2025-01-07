<cfinclude template="MfaCookieCheck.cfm">

<!------------------------- Report.ptC.cfm ----------------------------------->
<!---------------------------------------------------------------------------->
<!--- KS1 --->
	<!---<CFOUTPUT>
		Program = "Report.ptC.cfm at 4"
	</CFOUTPUT>--->

<!---

For displaying Get_Single_Record.cfm: 

Query CONTINGENT_LIAB_GetRecord_PrevRpt in Get_Single_Record.cfm


--->


<link Report.ptC.cfm rel="stylesheet" type="text/css" href="stylesheet.css">



<CFIF DATE_LAST_UPDATE EQ "" 
AND 
(Get_MC_APPR_FLAG_Approved.RecordCount EQ 1 OR Get_Case_WithoutChecklist.RecordCount GT 0) 
AND NOT 
IsDefined("EarlierRptDate")>

	<CFOUTPUT>
	<div id="TableBorder_#This_CurrentRow#" style="border:thin solid maroon; width:100%; margin-bottom:10pt; padding:5pt">
	</cfoutput>

<CFELSE>


	<CFIF IsDefined("PrevSTLNote") AND PrevSTLNote NEQ "">
	
	    <CFOUTPUT>
	    <div id="PrevSTLTableBorder_#This_CurrentRow#" style="width:100%; border: 1px dashed">
	    </CFOUTPUT>
	
	    <CFSET PrevSTLNote = "">
	
	<CFELSE>
	
		<CFOUTPUT>
		<div id="TableBorder_#This_CurrentRow#" style="width:100%">
		</cfoutput>
	
	</CFIF>
	

</cfif>



<CFOUTPUT>
<table id="RecTable_#This_CurrentRow#" cellpadding="4" cellspacing="4" width="100%" style="margin-bottom:15pt; background:#RowColor#" border=0>
</cfoutput>


<CFIF NOT
(
IsDefined("EarlierRptDate")
OR
(
IsDefined("Form.CorpFinFormat")
AND
Form.CorpFinFormat EQ "CorpFinFormat"
)
OR
(
IsDefined("SelectedCategory")
AND
SelectedCategory CONTAINS "Non-HQ"
)
)>

	<CFINCLUDE TEMPLATE="RecordTableLinkRows.cfm">

<CFELSE>

	<CFSET UpdateNeededFlag = "no">

</cfif>

<tr Report.ptC.cfm at 97>

<CFOUTPUT>
<div id="CaseRecord_#This_CurrentRow#">
</cfoutput>


<th align="right" valign="top">



<CFIF IsDefined("Form.CorpFinFormat") AND Form.CorpFinFormat EQ "CorpFinFormat">

	<CFOUTPUT>
	
	<span id="Report_Body_CaseNum_#This_CurrentRow#" style="position:absolute; left:10pt; display:none">
	
	<span style="font-size:8pt; font-weight:bold; background:green; text-align:center; color:white; width:19; height:10; padding-left:1px">#This_CurrentRow#</span>
	
	</span>
	
	</CFOUTPUT>

</cfif>



<CFIF NOT (IsDefined("PkeyBkmarkFlag") AND PkeyBkmarkFlag EQ "yes")>

	<CFOUTPUT>
	<a name="#PRIMARYKEY#">Case Name</a>
	</cfoutput>

<CFELSE>

	Case Name

	<CFSET PkeyBkmarkFlag = "no">

</cfif>

</th>


<td>

<CFSET NewList = Trim(CASE_NAME)>

<CFIF STATUS_CODE EQ 1 OR STATUS_CODE_SELECTED EQ "1">

	<CFIF ThisReportDate NEQ EarliestReportDate AND PrevReportDate NEQ "">
		<CFSET OldList = Trim(CONTINGENT_LIAB_GetRecord_PrevRpt.CASE_NAME)>
	</cfif>

	<CFINCLUDE TEMPLATE="textcompare.cfm">

<CFELSE>

	<CFOUTPUT>
	#NewList#
	</cfoutput>

</cfif>

</td>

</tr>

<tr  Report.ptC.cfm at 165>

<th align="right" valign="top">
Case Number
</th>

<td>

<CFIF CASE_NUMBER EQ "">
	_____

<CFELSE>

	<CFSET NewList = CASE_NUMBER>
	
	<CFIF STATUS_CODE EQ 1 OR STATUS_CODE_SELECTED EQ "1">
	
		<CFIF ThisReportDate NEQ EarliestReportDate AND PrevReportDate NEQ "">
		<CFSET OldList = CONTINGENT_LIAB_GetRecord_PrevRpt.CASE_NUMBER>
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

</tr>


<CFIF NOT (IsDefined("Form.CorpFinFormat") AND Form.CorpFinFormat EQ "CorpFinFormat")>

	<tr Report.ptC.cfm at 209>
	
	<th align="right" valign="top">
	
	<CFIF NOT IsDefined("EarlierRptDate")>
	Matter Number
	<CFELSE>
	Matter Number
	</CFIF>
	
	<div style="font-size:8pt; font-weight:normal">
	
	<CFIF LM_MATTER_KEY NEQ "">
	
	
		<CFOUTPUT>
	    (<a href="https://lawdept2.usps.gov/lmWeb/tabular.jsp?NB=MatterAllWS&QRY=|matter_key%3D#LM_MATTER_KEY#" target="_blank">LawManager</a>)
		</CFOUTPUT>
	
	
	<CFELSE>
	
		(LawManager)
	
	</CFIF>
	
	</div>
	
	</th>
	
	<td>
	
	<CFIF LM_MATTER_NUMBER EQ "">
		_____
	
	<CFELSE>
	
		<CFSET NewList = LM_MATTER_NUMBER>
		
		<CFIF STATUS_CODE EQ 1 OR STATUS_CODE_SELECTED EQ "1">
		
			<CFIF ThisReportDate NEQ EarliestReportDate AND PrevReportDate NEQ "">
				<CFSET OldList = CONTINGENT_LIAB_GetRecord_PrevRpt.LM_MATTER_NUMBER>
			</cfif>
			
			<!---
			<CFINCLUDE TEMPLATE="CFINCLUDEs/textcompare.cfm">
			--->
			
			<CFINCLUDE TEMPLATE="textcompare.cfm">
		
	
		</cfif>
	
	
		<CFIF LM_MATTER_KEY NEQ "">
		
		<!---
		<CFOUTPUT>
		<a href="https://56.207.31.151/lawmanager.net/exec/httpsrvr.dll/main?NB=MatterAllWS&QRY=|matter_key%3D#LM_MATTER_KEY#|&TYP=detail&HTYP=edit" target="_blank">#NewList#</a>
		</CFOUTPUT>
		--->
		
		
		
			<CFOUTPUT>
		    (<a href="https://lawdept2.usps.gov/lmWeb/tabular.jsp?NB=MatterAllWS&QRY=|matter_key%3D#LM_MATTER_KEY#" target="_blank">#NewList#</a>)
			</CFOUTPUT>
		
		
		<CFELSE>
		
			<!---
			<CFIF STATUS_CODE NEQ 1>
			--->
		
			<CFOUTPUT>
			#NewList#
			</CFOUTPUT>
			
			<!---
			</cfif>
			--->
			
			<span style="color:red; font-family:verdana; font-size:8pt; font-weight:bold; font-style:italic">
			[Matter Number not found in LawManager. Please verify and correct.]
			</span>
		
		</CFIF>
		
		
		<!---
		</cfif>
		--->
		
	
	</cfif>
	
	</td>
	
	</tr>

</cfif>





<CFIF NOT (IsDefined("Form.CorpFinFormat") AND Form.CorpFinFormat EQ "CorpFinFormat")>

	<tr Report.ptC.cfm at 319>
	
	<th Report.ptC.cfm at 321 align="right" valign="top" style="line-height:80%">
	
	<p style='margin-top:10pt'>
	District /
	<p style='margin-top:5pt'>
	Division /
	<p style='margin-top:5pt'>
	HQ&nbsp;Dept
	<p style='margin-top:10pt'>
	</th>
	
	
	<td style="vertical-align:middle">
	
	
	<CFSET This_DIST_PERF_CLUSTER_NAME = DIST_PERF_CLUSTER_NAME>
	<CFSET This_AREA_NAME = AREA_NAME>

	<CFIF IsDefined("DIVISION_CODE")>

		<CFSET This_DIVISION_CODE = DIVISION_CODE>

	<CFELSE>
    
		<CFSET This_DIVISION_CODE = "">

	</CFIF>


	<CFIF IsDefined("DIVISION_NAME")>

		<CFSET This_DIVISION_NAME = DIVISION_NAME>

	<CFELSE>
   
		<!---12/24/2024 ?? CFSET This_DIVISION_NAME = ""--->
		<CFSET This_DIVISION_NAME = This_DIVISION_CODE>

	</CFIF>





	<CFIF This_DIST_PERF_CLUSTER_NAME NEQ ""
	AND 
	This_AREA_NAME DOES NOT CONTAIN "HQ"
	AND
	ListFind(ValueList(Get_Districts.NAME), This_DIST_PERF_CLUSTER_NAME) EQ 0>
    
 
 		<CFSET SelectDistrict = "yes">
 
		<strong>[Select New District]&nbsp;<span class='ClickEdit'>Click "Edit This Case Record" to select</span></strong>
		<!---<span>[Select New District]&nbsp;<span class='ClickEdit'>Click "Edit This Case Record" to select</span></span>--->
	    
	<CFELSE>
    
		<CFSET SelectDistrict = "no">

	</CFIF>

	<CFIF This_DIST_PERF_CLUSTER_NAME NEQ ""
	AND
	SelectDistrict EQ "no">
    

		<CFIF This_AREA_NAME NEQ "">
        
        <!--- 1/2/2025 commented out for new texcompareDistictDivisionAreas code
        	<CFIF This_DIST_PERF_CLUSTER_NAME DOES NOT CONTAIN "District">
        
				<CFSET This_DIST_PERF_CLUSTER_NAME = This_DIST_PERF_CLUSTER_NAME & " District (" & This_AREA_NAME & ")">
                
			<CFELSE>
            
				<CFSET This_DIST_PERF_CLUSTER_NAME = This_DIST_PERF_CLUSTER_NAME & " (" & This_AREA_NAME & ")">
                
			</CFIF>
               
               end  1/2/2025 commented out for new texcompareDistictDivisionAreas code---> 
               
               <!---1/2/2025 new code below --->
             <CFIF This_DIST_PERF_CLUSTER_NAME DOES NOT CONTAIN "District">
        
				<CFSET This_DIST_PERF_CLUSTER_NAME = This_DIST_PERF_CLUSTER_NAME>
				<CFSET This_AREA_NAME = This_AREA_NAME>
                
			<CFELSE>
            
				<CFSET This_DIST_PERF_CLUSTER_NAME = This_DIST_PERF_CLUSTER_NAME>
                <CFSET This_AREA_NAME = This_AREA_NAME>
			</CFIF>
			<!---end 1/2/2025 new code below --->
			         
		</cfif>


	
		<CFSET NewList = This_DIST_PERF_CLUSTER_NAME>
        
        <!--- 1/2/2025 commented out for new texcompareDistictDivisionAreas code
        <CFIF This_DIST_PERF_CLUSTER_NAME DOES NOT CONTAIN "District"> 
        
        	<CFSET NewList = NewList & " District -- report.ptc line 403">
            
		</CFIF>             
          end  1/2/2025 commented out for new texcompareDistictDivisionAreas code---> 
	


		<CFIF ThisReportDate NEQ EarliestReportDate AND PrevReportDate NEQ "">
            
			<CFSET OldList = CONTINGENT_LIAB_GetRecord_PrevRpt.DIST_PERF_CLUSTER_NAME>
			
			<!--- 1/2/2025 commented out for new texcompareDistictDivisionAreas code	
			<CFIF CONTINGENT_LIAB_GetRecord_PrevRpt.DIST_PERF_CLUSTER_NAME DOES NOT CONTAIN "District">
				<!---12/20 COMMENTED OUT FOR BELOW 2 LINES <CFSET OldList = OldList & " District">--->
				<CFSET PREV_AREA_NAME = #CONTINGENT_LIAB_GetRecord_PrevRpt.AREA_NAME#>
				<CFSET OldList = OldList & " District (" & PREV_AREA_NAME & ")">
				<!---<CFOUtput>OLD LIST = #OldList#</CFOUtput>--->
					
				
    		</CFIF>
            end  1/2/2025 commented out for new texcompareDistictDivisionAreas code---> 
             <!---1/2/2025 new code below --->
            <CFIF CONTINGENT_LIAB_GetRecord_PrevRpt.DIST_PERF_CLUSTER_NAME DOES NOT CONTAIN "District">
				<!---12/20 COMMENTED OUT FOR BELOW 2 LINES <CFSET OldList = OldList & " District">--->
				<CFSET PREV_AREA_NAME = #CONTINGENT_LIAB_GetRecord_PrevRpt.AREA_NAME#>
				<CFSET OldList = OldList>
				<CFSET PREV_AREA_NAME  = PREV_AREA_NAME>
				<!---<CFOUtput>OLD LIST = #OldList#</CFOUtput>--->
					
				
    		</CFIF>
            <!---end 1/2/2025 new code below --->
			<CFINCLUDE TEMPLATE="textcompareDistrict_Division_Areas.cfm">
	
	
		<CFELSE>

			<CFOUTPUT>
			 #NewList#
    		</cfoutput>

		</CFIF>

	<CFELSEIF This_AREA_NAME NEQ ""
	AND
	SelectDistrict EQ "no">
	


		<CFIF This_DIST_PERF_CLUSTER_NAME NEQ "">

        	<br />
    
    	</CFIF>

	
		<CFSET NewList = This_AREA_NAME>
	
		<CFIF STATUS_CODE EQ 1 OR STATUS_CODE_SELECTED EQ "1">
	

			<CFSET OldList = This_AREA_NAME>


			<CFINCLUDE TEMPLATE="textcompareDistrict_Division_Areas2.cfm">
	
	
		<CFELSE>
	
			<CFOUTPUT>
			#NewList#
			</cfoutput>
	
		</cfif>
	
	</CFIF>



	<CFIF IsDefined("CONTINGENT_LIAB_GetRecord_PrevRpt.RecordCount")
	AND
	CONTINGENT_LIAB_GetRecord_PrevRpt.DIST_PERF_CLUSTER_NAME NEQ "">



		<CFIF SelectDistrict EQ "yes">
	
			<div class="PreviouslyReported" style="margin-top:5pt">

		<CFELSE>
        
			<div class="PreviouslyReported">
            
		</CFIF>            

<!---
		<CFIF IsDefined("This_DIST_PERF_CLUSTER_NAME")
		AND
		This_DIST_PERF_CLUSTER_NAME NEQ CONTINGENT_LIAB_GetRecord_PrevRpt.DIST_PERF_CLUSTER_NAME>


	    	[Previously reported as: 
		
        
			<CFIF CONTINGENT_LIAB_GetRecord_PrevRpt.DIST_PERF_CLUSTER_NAME CONTAINS "MULTIPLE">

        		<CFOUTPUT>
				#CONTINGENT_LIAB_GetRecord_PrevRpt.DIST_PERF_CLUSTER_NAME#]
				</CFOUTPUT><br/>
        
    	    <CFELSE>
        ---><!---
	    	    <CFOUTPUT>
				#CONTINGENT_LIAB_GetRecord_PrevRpt.DIST_PERF_CLUSTER_NAME# District]
				</CFOUTPUT>
        
    	    </CFIF>
        
        
        </CFIF>--->
     
 			<CFIF IsDefined("This_DIST_PERF_CLUSTER_NAME") AND This_DIST_PERF_CLUSTER_NAME NEQ CONTINGENT_LIAB_GetRecord_PrevRpt.DIST_PERF_CLUSTER_NAME> 
		
	    	<!---[Previously reported as: --->
		<!---12/26/2024 during the call to get rid of the previous reported section when choosing the previously recorded-
		commented out the [Prviously reported as: - above, added the or section in the cfif below and commented out the 1st  <cfoutput> beolw--->
		
		<!---BEFORE CODE
		[Previously reported as:
		<CFIF CONTINGENT_LIAB_GetRecord_PrevRpt.DIST_PERF_CLUSTER_NAME CONTAINS "MULTIPLE"> --->
        
			<CFIF CONTINGENT_LIAB_GetRecord_PrevRpt.DIST_PERF_CLUSTER_NAME CONTAINS "MULTIPLE" 
			or CONTINGENT_LIAB_GetRecord_PrevRpt.DIST_PERF_CLUSTER_NAME eq DIST_PERF_CLUSTER_NAME>
			
        		<!---CFOUTPUT>
        			what does this do
				#CONTINGENT_LIAB_GetRecord_PrevRpt.DIST_PERF_CLUSTER_NAME#]
				</CFOUTPUT---<br/--->
        
    	    <CFELSE>
        		[Previously reported as:
	    	    <CFOUTPUT>
				#CONTINGENT_LIAB_GetRecord_PrevRpt.DIST_PERF_CLUSTER_NAME# District]
				</CFOUTPUT>
        
    	    </CFIF>
        
        
        </CFIF>   
        
		</div>
	
	</cfif>







	<CFIF This_DIVISION_CODE NEQ "">
    

        <br />

		<CFSET NewList = This_DIVISION_CODE>


    
		<div>
    
    

		<CFSET OldList = CONTINGENT_LIAB_GetRecord_PrevRpt.DIVISION_CODE>
            

		<CFINCLUDE TEMPLATE="textcompare.cfm">
	

    	</div>
    

    </CFIF>




	<CFIF IsDefined("CONTINGENT_LIAB_GetRecord_PrevRpt.RecordCount")
	AND
	CONTINGENT_LIAB_GetRecord_PrevRpt.DIVISION_NAME NEQ ""
	AND
	CONTINGENT_LIAB_GetRecord_PrevRpt.DIVISION_NAME NEQ This_DIVISION_NAME>
	
		<div class="PreviouslyReported">

    	[Previously reported as: 
		
        <CFOUTPUT>
		#CONTINGENT_LIAB_GetRecord_PrevRpt.DIVISION_NAME#]
		</CFOUTPUT>
        
		</div>
	
	</cfif>


	<CFIF 
	(
	This_DIST_PERF_CLUSTER_NAME EQ ""
	AND
	This_AREA_NAME EQ ""
	AND
	This_DIVISION_NAME EQ ""
	AND
	This_DIVISION_CODE EQ ""
	)>


    
    
    
		<CFIF NOT IsDefined("EarlierRptDate") AND NOT (IsDefined("ALT_LAW_DEPT_OFFICE_Flag") AND ALT_LAW_DEPT_OFFICE_Flag EQ "yes")>

			<div>
		
			<CFSET NewList = '<span style="color:red; font-weight:bold">[None Selected]</span>&nbsp;<span class="ClickEdit">Click "Edit This Case Record" to select</span>'>
		
		   	<CFSET OldList = "">
	
			<!---<CFINCLUDE TEMPLATE="textcompare.cfm">--->
		
        	</div>
        
		<CFELSE>
		
			<CFSET NewList = '[None Selected]'>
		
        	<div>
        
			<CFOUTPUT>
			#NewList#
			</CFOUTPUT>
	
    		</div>
    
		</cfif>


	</CFIF>
		
	
	</td>
	
	</tr>

<!--- Close <CFIF NOT (IsDefined("Form.CorpFinFormat") AND Form.CorpFinFormat EQ "CorpFinFormat")> --->
</cfif>






<CFIF NOT (IsDefined("Form.CorpFinFormat") AND Form.CorpFinFormat EQ "CorpFinFormat")>


	
	
	<CFIF IsDefined("This_AREA_NAME") 
	AND
	This_AREA_NAME EQ "HQ Labor Relations">
	
		<tr  Report.ptC.cfm at 839 id="Unions_Selected_Row">
	
	<CFELSE>
	
		<tr  Report.ptC.cfm at 843 id="Unions_Selected_Row" style="display:none">
	
	</cfif>
	
	
	
	<th align="right" valign="top">
	Union(s)
	</th>
	
	<td valign="top">
	
	<div id="Unions_List_Div" style="margin-bottom:10pt">
	
	<CFSET This_UNIONS_SELECTED_List = UNIONS_SELECTED>
	
	<CFIF This_UNIONS_SELECTED_List EQ "">
	
		[None selected]
	
	<CFELSE>

	
		<CFLOOP INDEX="This_UNIONS_SELECTED_List_Index" LIST="#This_UNIONS_SELECTED_List#">
	
			<CFOUTPUT>
			<li>#This_UNIONS_SELECTED_List_Index#
			</CFOUTPUT>
	
		</CFLOOP>
	
	</cfif>
	
	</div id="Unions_List_Div">
	
	
	
	
	
	</td>
	
	
	</tr>



<!--- Close <CFIF NOT (IsDefined("Form.CorpFinFormat") AND Form.CorpFinFormat EQ "CorpFinFormat")> --->
</cfif>




<tr Report.ptC.cfm at 895 >

<th align="right" valign="top">
Date Filed
</th>

<td>


<CFIF DATE_FILED EQ "">

	
	<CFSET DATE_FILED_UNKNOWN_Word = "_____">
	
	<CFLOOP INDEX="DATE_FILED_UNKNOWN_Index" FROM="1" TO="#ListLen(Unknown_NA_List)#">
	
		<CFIF DATE_FILED_UNKNOWN EQ DATE_FILED_UNKNOWN_Index>
			<CFSET DATE_FILED_UNKNOWN_Word = "[" & ListGetAt(Unknown_NA_List, DATE_FILED_UNKNOWN_Index) & "]">
		</cfif>
	
	</cfloop>
	
	<!---
	<CFOUTPUT>
	#DATE_FILED_UNKNOWN_Word#
	</cfoutput>
	--->
	
	<CFSET NewList = DATE_FILED_UNKNOWN_Word>
	<CFSET OldList = "">
	
<CFELSE>
	
	<CFSET NewList = DateFormat(DATE_FILED, "mm/dd/yyyy")>
	
	<CFIF ThisReportDate NEQ EarliestReportDate AND PrevReportDate NEQ "">
	
		<CFIF CONTINGENT_LIAB_GetRecord_PrevRpt.DATE_FILED NEQ "">
			<CFSET OldList = DateFormat(CONTINGENT_LIAB_GetRecord_PrevRpt.DATE_FILED, "mm/dd/yyyy")>
		<CFELSE>
			<CFSET OldList = "">
		</cfif>
	
	</cfif>

</cfif>


<CFINCLUDE TEMPLATE="textcompare.cfm">




</td>

</tr>

<tr Report.ptC.cfm at 956 >

<th align="right" valign="top">
Amount Sought
</th>

<td>

<CFSET Prev_AMOUNT_SOUGHT_DisplayAmt = "">
<CFSET AMOUNT_SOUGHT_Diff = "no">


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

		<CFSET Prev_AMOUNT_SOUGHT_DisplayAmt = OldList>

	</cfif>

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
<CFINCLUDE TEMPLATE="textcompare.cfm">



	<CFIF DiffFlag EQ "yes">
		<CFSET AMOUNT_SOUGHT_UNKNOWN_Diff = "yes">
	<CFELSE>
		<CFSET AMOUNT_SOUGHT_UNKNOWN_Diff = "no">
	</cfif>

<!--- Close <CFIF AMOUNT_SOUGHT NEQ ""> --->
</cfif>




<CFSET Prev_AMOUNT_SOUGHT_UPPER_DisplayAmt = "">
<CFSET AMOUNT_SOUGHT_UPPER_Diff = "no">


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
	
		<CFSET Prev_AMOUNT_SOUGHT_UPPER_DisplayAmt = OldList>
	
	</cfif>

	<CFINCLUDE TEMPLATE="textcompare.cfm">
	
	
	
	<CFIF DiffFlag EQ "yes">
		<CFSET AMOUNT_SOUGHT_UPPER_Diff = "yes">
	<CFELSE>
		<CFSET AMOUNT_SOUGHT_UPPER_Diff = "no">
	</cfif>
	
</cfif>
	
	
	

<CFIF 
(
IsDefined("AMOUNT_SOUGHT_Diff")
AND
AMOUNT_SOUGHT_Diff EQ "yes"
)
OR
(
IsDefined("AMOUNT_SOUGHT_UPPER_Diff")
AND
AMOUNT_SOUGHT_UPPER_Diff EQ "yes"
)>
    
    <CFIF STATUS_CODE_SELECTED NEQ "1">
    
		<div class="PreviouslyReported">
    	[Previously reported as: 
    
   		<CFIF IsDefined("Prev_AMOUNT_SOUGHT_DisplayAmt")
		AND
		Prev_AMOUNT_SOUGHT_DisplayAmt NEQ "">


	        <CFIF IsDefined("Prev_AMOUNT_SOUGHT_UPPER_DisplayAmt")
			AND
			Prev_AMOUNT_SOUGHT_UPPER_DisplayAmt NEQ "">

		    	<CFOUTPUT>
			    #Prev_AMOUNT_SOUGHT_DisplayAmt#
		        -
			    #Prev_AMOUNT_SOUGHT_UPPER_DisplayAmt#]
		   		</CFOUTPUT>
        
			<CFELSE>

    			<CFOUTPUT>
			    #Prev_AMOUNT_SOUGHT_DisplayAmt#]
		   		</CFOUTPUT>

			</CFIF>
            
        <CFELSE>
            
        _____]
            
        </CFIF>
        
        
		</div>

	</CFIF>


</CFIF>







</td>

</tr>


<tr Report.ptC.cfm at 1183 >

<th align="right" valign="top">
<!---
Assessment
--->


Liability 
Assessment

</th>

<td>

<CFSET NewList = ListGetAt(ASSESSMENT_PROBABILITY_LabelList, ASSESSMENT_PROBABILITY)>


<CFIF ThisReportDate NEQ EarliestReportDate AND PrevReportDate NEQ "">


	<CFIF CONTINGENT_LIAB_GetRecord_PrevRpt.ASSESSMENT_PROBABILITY NEQ "">
		<CFSET OldList = ListGetAt(ASSESSMENT_PROBABILITY_LabelList, CONTINGENT_LIAB_GetRecord_PrevRpt.ASSESSMENT_PROBABILITY)>
	<CFELSE>
		<CFSET OldList = "">
	</CFIF>


	<CFSET Prev_ASSESSMENT_PROBABILITY_Label = OldList>

</cfif>


<CFINCLUDE TEMPLATE="textcompare.cfm">

<CFIF DiffFlag EQ "yes">

	<CFSET ASSESSMENT_PROBABILITY_Diff = "yes">
    
    <CFIF STATUS_CODE_SELECTED NEQ "1">

		<div class="PreviouslyReported">
	    [Previously reported as: 
    
    	<CFOUTPUT>
	    #Prev_ASSESSMENT_PROBABILITY_Label#]
    	</CFOUTPUT>
        
        </div>

	</cfif>
    
<CFELSE>
	<CFSET ASSESSMENT_PROBABILITY_Diff = "no">
</cfif>


</td>

</tr>



<tr Report.ptC.cfm at 1252 >

<th align="right" valign="top">


Damages
Assessment

</th>

<td>


<li><b>Most Likely Payout</b>:

<CFINCLUDE TEMPLATE="assess.amt.compare.cfm">
<CFSET NewList = ASSESSMENT_AMOUNT_DisplayAmt>

<CFINCLUDE TEMPLATE="assess.amt.prev.compare.cfm">
<CFSET OldList = Prev_ASSESSMENT_AMOUNT_DisplayAmt>

<CFINCLUDE TEMPLATE="textcompare.cfm">



<CFIF DiffFlag EQ "yes">
	<CFSET ASSESSMENT_AMOUNT_Diff = "yes">
<CFELSE>
	<CFSET ASSESSMENT_AMOUNT_Diff = "no">
</cfif>

<CFIF DiffFlag EQ "yes" OR ASSESSMENT_AMOUNT_Diff EQ "yes">

	<CFSET ASSESSMENT_AMOUNT_Diff = "yes">
    
    <CFIF STATUS_CODE_SELECTED NEQ "1">
    
		<div class="PreviouslyReported">
        
	    [Previously reported as:
    
    	<CFOUTPUT>
		#Prev_ASSESSMENT_AMOUNT_DisplayAmt#]
		</CFOUTPUT>

		</div>		


	</cfif>
        
</cfif>





<li><b>Maximum Reasonable Payout</b>:

<CFINCLUDE TEMPLATE="assess.amt.upper.compare.cfm">
<CFSET NewList = ASSESSMENT_AMOUNT_UPPER_DisplayAmt>

<CFINCLUDE TEMPLATE="assess.amt.upper.prev.compare.cfm">
<CFSET OldList = Prev_ASSESSMENT_AMOUNT_UPPER_DisplayAmt>


<CFINCLUDE TEMPLATE="textcompare.cfm">



<CFIF DiffFlag EQ "yes">
	<CFSET ASSESSMENT_AMOUNT_UPPER_Diff = "yes">
<CFELSE>
	<CFSET ASSESSMENT_AMOUNT_UPPER_Diff = "no">
</cfif>

<CFIF DiffFlag EQ "yes" OR ASSESSMENT_AMOUNT_UPPER_Diff EQ "yes">

	<CFSET ASSESSMENT_AMOUNT_UPPER_Diff = "yes">
    
    <CFIF STATUS_CODE_SELECTED NEQ "1">
    
		<div class="PreviouslyReported">
        
	    [Previously reported as:
    
    	<CFOUTPUT>
		#Prev_ASSESSMENT_AMOUNT_UPPER_DisplayAmt#]
		</CFOUTPUT>

		</div>		


	</cfif>
        
</cfif>




</td>

</tr>



