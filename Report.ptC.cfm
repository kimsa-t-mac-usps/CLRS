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
)
>

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
<!---
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
START NEW CODE 12/10/2025 PUT IT IN A 3 ROWS AND 2 COLUMNS --->
<CFIF NOT (IsDefined("Form.CorpFinFormat") AND Form.CorpFinFormat EQ "CorpFinFormat")>

	<tr><!---start of new row district--->
		<td style ="text-align: right; font-weight: bold;padding-top: 0px;padding-bottom: 0px;padding-left: 0px;padding-right: 0px;">District /</td>
		<td style ="padding-top: 0px;padding-bottom: 0px;padding-left: 5px;padding-right: 0px;">		
		
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
			<CFSET This_DIVISION_NAME = This_DIVISION_CODE>
		</CFIF>
          

		<CFIF This_DIST_PERF_CLUSTER_NAME NEQ "" AND This_AREA_NAME DOES NOT CONTAIN "HQ" AND ListFind(ValueList(Get_Districts.NAME), This_DIST_PERF_CLUSTER_NAME) EQ 0>		
			<CFSET SelectDistrict = "yes">
	
			<strong>[Select New District]&nbsp;<span class='ClickEdit'>Click "Edit This Case Record" to select</span></strong>	
		<CFELSE>		
			<CFSET SelectDistrict = "no">
		</CFIF>

		<CFIF This_DIST_PERF_CLUSTER_NAME NEQ "" AND SelectDistrict EQ "no">
    
			<CFIF This_AREA_NAME NEQ "">        
				<CFIF This_DIST_PERF_CLUSTER_NAME DOES NOT CONTAIN "District">
					<!---12/9/2025 commenting out cfset below with the cfset under it
					<CFSET This_DIST_PERF_CLUSTER_NAME = This_DIST_PERF_CLUSTER_NAME & " District (" & This_AREA_NAME & ")">--->
					<!---12/12/2025-CFSET This_DIST_PERF_CLUSTER_NAME = This_DIST_PERF_CLUSTER_NAME & " District"--->
					<CFSET This_DIST_PERF_CLUSTER_NAME = This_DIST_PERF_CLUSTER_NAME>
				<CFELSE>
					<!---12/9/2025 commenting out cfset below with the cfset under it added p element--->
					<!---CFSET This_DIST_PERF_CLUSTER_NAME = This_DIST_PERF_CLUSTER_NAME & " (" & This_AREA_NAME & ")"--->		
					<CFSET This_DIST_PERF_CLUSTER_NAME = This_DIST_PERF_CLUSTER_NAME>			
				</CFIF>                          
			</cfif>

		<!---cfset for <CFIF This_DIST_PERF_CLUSTER_NAME NEQ "" AND SelectDistrict EQ "no">--->
		<CFSET NewList = This_DIST_PERF_CLUSTER_NAME>
              
			<CFIF This_DIST_PERF_CLUSTER_NAME DOES NOT CONTAIN "District">
				<!--- 12/12/2025 @ 12:00pm replaced the cfset with cfset  <CFSET NewList = NewList & " District"--->
				<cfset NewList = NewList>
			</CFIF>             
        
			<CFIF ThisReportDate NEQ EarliestReportDate AND PrevReportDate NEQ "">		
				<CFSET OldList = CONTINGENT_LIAB_GetRecord_PrevRpt.DIST_PERF_CLUSTER_NAME>			
					<CFIF CONTINGENT_LIAB_GetRecord_PrevRpt.DIST_PERF_CLUSTER_NAME DOES NOT CONTAIN "District">
						<!--- 12/12/2025 @11:43am  CFSET OldList = OldList & " District"--->
						<cfset OldList = OldList & " District">
					</CFIF>					
				<!---12/12/2025@11:49  CFINCLUDE TEMPLATE="textcompare.cfm"--->		
			<!--- 12/12/2025 :11:50 START ADDED THE CFIF CFELSE /CFIF BEOW--->	
				<cfif NewList eq CONTINGENT_LIAB_GetRecord_PrevRpt.DIST_PERF_CLUSTER_NAME>
					<cfoutput>#OldList# </cfoutput>
				<cfelse>
					<!--- 12/15/2025 @ 12:39pm for below cfif <cfoutput><strong>#NewList# District</strong></cfoutput>  --->
					<!--- 12/15/2025 @ 12:39pm  START--->
					<cfif NewList CONTAINS "MULTIPLE">
						<cfoutput><strong>#NewList# </strong></cfoutput>	
					<cfelse>
						<cfoutput><strong>#NewList# District</strong></cfoutput>
					</cfif>
					<!--- 12/15/2025 @ 12:39pm END--->
				</cfif>
			<!--- 12/12/2025 :11:50 START ADDED THE CFIF CFELSE /CFIF BEOW--->	
			<CFELSE>
				<CFOUTPUT>#NewList# District</cfoutput>
			</CFIF>
			
		<CFELSEIF This_AREA_NAME NEQ "" AND SelectDistrict EQ "no">
			<CFIF This_DIST_PERF_CLUSTER_NAME NEQ "">
				<br />
			</CFIF>

		<!---cfset for <CFIF This_DIST_PERF_CLUSTER_NAME NEQ "" AND SelectDistrict EQ "no">--->
		<CFSET NewList = This_AREA_NAME>
	
			<CFIF STATUS_CODE EQ 1 OR STATUS_CODE_SELECTED EQ "1">
				<CFSET OldList = This_AREA_NAME>
				<!---12/12/2025 @ 1:59pm CFINCLUDE TEMPLATE="textcompare.cfm">--->
				<cfoutput></cfoutput>
			<CFELSE>
				<CFOUTPUT></cfoutput>
			</cfif>
	
		</CFIF>

		<CFIF IsDefined("CONTINGENT_LIAB_GetRecord_PrevRpt.RecordCount") AND CONTINGENT_LIAB_GetRecord_PrevRpt.DIST_PERF_CLUSTER_NAME NEQ "">
		<!---12/10/2025 this cfif is true--->
			<CFIF SelectDistrict EQ "yes">
		<!---12/9/025 added font size--->
				<div class="PreviouslyReported" style="margin-top:5pt; font-size:8pt; padding-bottom:0pt" >

			<CFELSE>
       	<!---12/9/025 added font size
				<div class="PreviouslyReported" style="font-size:8pt; padding-bottom:0pt">--->
            
			</CFIF>            
			<!---12/12/2025 @11:15am added for if---><cfset thisDistPerfClusterName = Trim(ReReplace(This_DIST_PERF_CLUSTER_NAME, "\bDistricts\b", "", "all"))>
			<CFIF IsDefined("This_DIST_PERF_CLUSTER_NAME")	AND This_DIST_PERF_CLUSTER_NAME NEQ CONTINGENT_LIAB_GetRecord_PrevRpt.DIST_PERF_CLUSTER_NAME>		
				<cfif This_DIST_PERF_CLUSTER_NAME CONTAINS "MULTIPLE" and This_DIST_PERF_CLUSTER_NAME EQ thisDistPerfClusterName>
				<!---do nothing--->	
				<cfelse>
					<cfif CONTINGENT_LIAB_GetRecord_PrevRpt.DIST_PERF_CLUSTER_NAME CONTAINS "MULTIPLE">
					<div class="PreviouslyReported" style="font-size:8pt; padding-bottom:0pt">
						[Previously reported as:
						<!---cfoutput >#CONTINGENT_LIAB_GetRecord_PrevRpt.DIST_PERF_CLUSTER_NAME# District]</cfoutput--->
						<cfoutput >#CONTINGENT_LIAB_GetRecord_PrevRpt.DIST_PERF_CLUSTER_NAME#]</cfoutput>
					<cfelse> 
					<div class="PreviouslyReported" style="font-size:8pt; padding-bottom:0pt">
						[Previously reported as:
							<!---cfoutput >#CONTINGENT_LIAB_GetRecord_PrevRpt.DIST_PERF_CLUSTER_NAME# District]</cfoutput--->
							<cfoutput >#CONTINGENT_LIAB_GetRecord_PrevRpt.DIST_PERF_CLUSTER_NAME# District]</cfoutput>
					</cfif>
				</cfif>
		
			</CFIF>
        
       
		</div>
	
		</cfif>		
		</td><!---district row col 2--->
	</tr><!---end of district row--->
	<tr><!---division row--->
		<td style ="text-align: right; font-weight: bold;padding-top: 0px;padding-bottom: 0px;padding-left: 0px;padding-right: 0px;">Division /</td><!---division row col 1--->
		<td style ="padding-top: 0px;padding-bottom: 0px;padding-left: 5px;padding-right: 0px;">
		
		<CFIF IsDefined("CONTINGENT_LIAB_GetRecord_PrevRpt.RecordCount") AND CONTINGENT_LIAB_GetRecord_PrevRpt.DIVISION_NAME NEQ "" AND CONTINGENT_LIAB_GetRecord_PrevRpt.DIVISION_NAME NEQ This_DIVISION_NAME>
	      
			<cfoutput><strong>#This_DIVISION_NAME#</strong></cfoutput>
			<div class="PreviouslyReported" style="font-size:8pt;padding-bottom:1pt">
				
			[Previously reported as: 
			
			<CFOUTPUT>
			#CONTINGENT_LIAB_GetRecord_PrevRpt.DIVISION_NAME#]
			</CFOUTPUT>
			
			</div>
		<cfelse>
			<!--- 12/12/2025@ 2:19pm START - out comment cfoutput on this line for below <cfoutput>#This_DIVISION_NAME# - 408</cfoutput> --->
			<cfif CONTINGENT_LIAB_GetRecord_PrevRpt.DIVISION_NAME EQ "" or CONTINGENT_LIAB_GetRecord_PrevRpt.DIVISION_NAME nEQ This_DIVISION_NAME>
				<cfoutput><strong>#This_DIVISION_NAME#</strong></cfoutput>
			<cfelse>
				<cfoutput>#This_DIVISION_NAME#</cfoutput>
			</cfif>
			<!---12/12/2025@ 2:19pm END - out comment cfoutput on this line for below <cfoutput>#This_DIVISION_NAME# - 408</cfoutput>  --->
		</cfif>

		<!---12/16/2025 @10:22am added cf below--->
		<cfif NOt IsDefined("CONTINGENT_LIAB_GetRecord_PrevRpt.RecordCount")>
			<cfoutput><strong>#This_DIVISION_NAME#</strong></cfoutput>
		</cfif>

		</td><!---division row col 2--->
	</tr><!---end of division row--->
	<tr><!---hq dept row--->
		<td style ="text-align: right; font-weight: bold;padding-top: 0px;padding-bottom: 0px;padding-left: 0px;padding-right: 0px;">HQ Dept</td><!---hq dept row col1--->
		<td style ="padding-top: 0px;padding-bottom: 10px;padding-left: 5px;padding-right: 0px;">
		
			<!---CFIF This_DIVISION_CODE NEQ "">
    
			<!---12/9/2025 comment out br below--->
				<!---br /--->
			<!---comment out 12/9/2025 oldList below with new NewList line below
				<CFSET NewList = This_DIVISION_CODE>--->
				<!---12/16/2025@1:44pm commented out the div  @@@@@@@@@@@START
				<div>

					<CFSET OldList = CONTINGENT_LIAB_GetRecord_PrevRpt.DIVISION_CODE>
					<!---CFINCLUDE TEMPLATE="textcompare.cfm"--->
		
					<cfoutput>#This_AREA_NAME# - #CONTINGENT_LIAB_GetRecord_PrevRpt.AREA_NAME#</cfoutput>
    			</div>
				@@@@@@@@@@@END--->
				<!---12/12/2025@12:25pm added cfif---><cfelse><cfoutput>#This_AREA_NAME#</cfoutput>--->
				<!--- </CFIF>--->
					<!---12/16/2025 @1:46 added below cfif--->
					<cfif This_AREA_NAME NEQ CONTINGENT_LIAB_GetRecord_PrevRpt.AREA_NAME>
						<!---12/22/2025@12:20 added cfif cfelse /cfif --->
						<cfif CONTINGENT_LIAB_GetRecord_PrevRpt.AREA_NAME eq ""> 
							<cfoutput><strong>#This_AREA_NAME#</strong></cfoutput>
						<cfelse>
							<cfoutput><strong>#This_AREA_NAME#</strong></cfoutput>
							<div class="PreviouslyReported" style="font-size:8pt; padding-bottom:1pt">
								[Previously reported as :
								<cfoutput>#CONTINGENT_LIAB_GetRecord_PrevRpt.AREA_NAME#]</cfoutput>
							</div>
						</cfif>
						<!---12/22/2025 (replace by above)  cfoutput><strong>#This_AREA_NAME#</strong></cfoutput>
						<div class="PreviouslyReported" style="font-size:8pt; padding-bottom:1pt">
							[Previously reported ashq:
							<cfoutput>#CONTINGENT_LIAB_GetRecord_PrevRpt.AREA_NAME#]</cfoutput>
						</div--->
					<cfelse>
						<cfoutput>#This_AREA_NAME#</cfoutput>	
					</cfif>
		
				

   			

					


			<CFIF (This_DIST_PERF_CLUSTER_NAME EQ "" AND This_AREA_NAME EQ "" AND This_DIVISION_NAME EQ "" AND This_DIVISION_CODE EQ "")>
				<CFIF NOT IsDefined("EarlierRptDate") AND NOT (IsDefined("ALT_LAW_DEPT_OFFICE_Flag") AND ALT_LAW_DEPT_OFFICE_Flag EQ "yes")>

					<div>
						<CFSET NewList = '<span style="color:red; font-weight:bold">[None Selected]</span>&nbsp;<span class="ClickEdit">Click "Edit This Case Record" to select</span>'>
		   				<CFSET OldList = "">
	
						<CFINCLUDE TEMPLATE="textcompare.cfm">
        			</div>
        
				<CFELSE>
					<CFSET NewList = '[None Selected]'>
        			<div>
						<!---12/9/2025 comment out to test HQ Dept / - cfoutput replaced with cfoutput hqdept
							<CFOUTPUT>#NewList#</CFOUTPUT>
						--->
						<cfoutput></cfoutput>
       				</div>
    
				</cfif>

			</CFIF>
		
		</td><!---hq dept row col 2--->
	</tr><!---end of hq dept row--->

</CFIF>
<!---
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
END OF NEW CODE 12/10/2025 PUT IT IN A 3 ROWS AND 2 COLUMNS
--->


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
			<li>#This_UNIONS_SELECTED_List_Index#</li>
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



