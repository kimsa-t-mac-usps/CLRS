<cfinclude template="MfaCookieCheck.cfm">

<!------------------------- Report.ptC.cfm ----------------------------------->
<!---------------------------------------------------------------------------->
<!--- KS1 --->
	<CFOUTPUT>
		Program = "Report.ptC.cfm at 4"
	</CFOUTPUT>

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

<!---12/30/24 start --DISTRICT DIVISION AREA --->
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
	<cfoutput>This_DIST_PERF_CLUSTER_NAME=#This_DIST_PERF_CLUSTER_NAME#</cfoutput><br>
	<cfoutput>This_AREA_NAME=#This_AREA_NAME#</cfoutput><br>
	<cfoutput>DIVISION_CODE=#DIVISION_CODE#</cfoutput><br>
	<CFSET This_DIVISION_CODE = DIVISION_CODE><br>
	<cfoutput>Divsion code is defined as= #This_DIVISION_CODE#</cfoutput><br>
	
	<CFIF IsDefined("DIVISION_CODE")>
		<CFSET This_DIVISION_CODE = DIVISION_CODE>
	<CFELSE>
    
		<!---12/27 commented out and added below <CFSET This_DIVISION_CODE = ""--->
		<cfset This_DIVISION_CODE = "">
	</CFIF>
	<CFIF IsDefined("DIVISION_NAME")>
		<CFSET This_DIVISION_NAME = DIVISION_NAME>
		<cfoutput>true This_DIVISION_name= #This_DIVISION_NAME#</cfoutput><br>
	<CFELSE>
	   	<CFSET This_DIVISION_NAME = This_DIVISION_CODE>
	   	<cfoutput>false This_DIVISION_name= #This_DIVISION_NAME#</cfoutput><br>
	</CFIF>
	
	<CFIF This_DIST_PERF_CLUSTER_NAME NEQ "" AND This_AREA_NAME DOES NOT CONTAIN "HQ"
	AND ListFind(ValueList(Get_Districts.NAME), This_DIST_PERF_CLUSTER_NAME) EQ 0>
		<CFSET SelectDistrict = "yes">
		<cfoutput>SelectDistrict=#SelectDistrict#</cfoutput><br>
	<cfelse>
		<CFSET SelectDistrict = "no">
		<cfoutput>SelectDistrict=#SelectDistrict#</cfoutput><br>
		<cfset getDistName = ListFind(ValueList(Get_Districts.NAME), This_DIST_PERF_CLUSTER_NAME)>
		<cfoutput>get distname  = #Get_Districts.NAME#</cfoutput><br>
		<cfset thisAreaName = #AREA_NAME#>
		<cfoutput>thisAreaName=#thisAreaName#</cfoutput><br>
		<CFSET THISNAME = #ValueList(Get_Districts.name, This_DIST_PERF_CLUSTER_NAME)#>
		<cfoutput>THIS IS THISnAMEe  = #THISNAME#</cfoutput><br>
		<cfoutput>find getdistname NUMBER = #getDistName#</cfoutput><br>
	</cfif>	
<!---  below is true -- do not know why--->
	<CFIF This_DIST_PERF_CLUSTER_NAME NEQ "" AND SelectDistrict EQ "no">
		<CFIF This_AREA_NAME NEQ "">  
        	<CFIF This_DIST_PERF_CLUSTER_NAME DOES NOT CONTAIN "District">      
				<CFSET This_DIST_PERF_CLUSTER_NAME = This_DIST_PERF_CLUSTER_NAME & " District (" &This_AREA_NAME& ")">
                <cfoutput>This_DIST_PERF_CLUSTER_NAME(true)=#This_DIST_PERF_CLUSTER_NAME#</cfoutput><br>
                <cfoutput>----This_AREA_NAME(true)=#This_AREA_NAME#</cfoutput><br>
			<CFELSE>           
				<CFSET This_DIST_PERF_CLUSTER_NAME = This_DIST_PERF_CLUSTER_NAME & " (" & This_AREA_NAME & ")">
                <cfoutput>----This_DIST_PERF_CLUSTER_NAME(false)=#This_DIST_PERF_CLUSTER_NAME#</cfoutput><br>
			</CFIF>                     
		</cfif>
		
		
		<!---NEW LIST AND OLD LIST--->
		<CFSET NewList = This_DIST_PERF_CLUSTER_NAME>
		<cfoutput>++++sETTING NewList = #NewList#</cfoutput><br>
		<CFIF This_DIST_PERF_CLUSTER_NAME DOES NOT CONTAIN "District">      
        	<CFSET NewList = NewList & " District"> 
        	<cfoutput>does not contain District</cfoutput><br>  
        <cfelse>
        	<cfoutput>does contain District</cfoutput><br>       
		</CFIF> 
		
		<CFIF ThisReportDate NEQ EarliestReportDate AND PrevReportDate NEQ "">
			<CFSET OldList = CONTINGENT_LIAB_GetRecord_PrevRpt.DIST_PERF_CLUSTER_NAME & " District (" &CONTINGENT_LIAB_GetRecord_PrevRpt.AREA_NAME &")">
			<cfoutput>OldList oustide of inner if= #OldList#</cfoutput><br>
			
			<CFSET THISNAME = #ValueList(Get_Districts.name, This_DIST_PERF_CLUSTER_NAME)#>
			<cfoutput>THIS IS THISnAMEe  = #THISNAME#</cfoutput><br>
			
			<CFIF CONTINGENT_LIAB_GetRecord_PrevRpt.DIST_PERF_CLUSTER_NAME DOES NOT CONTAIN "District">
				<CFSET OldList = OldList & " District">
				<cfoutput>OldList inside the inner cf = #OldList#</cfoutput><br>
    		</CFIF>
    		<!--- new code for old list--->
    		<cfset oldList_this_dist_perf_cluster_name = CONTINGENT_LIAB_GetRecord_PrevRpt.DIST_PERF_CLUSTER_NAME>
    		<cfset oldList_this_area_name = CONTINGENT_LIAB_GetRecord_PrevRpt.area_name>
    		<CFSET old_This_DIST_PERF_CLUSTER_NAME = oldList_this_dist_perf_cluster_name & " District (" &oldList_this_area_name& ")">
    		<cfset OldList = #old_This_DIST_PERF_CLUSTER_NAME#>
    		<cfset NewList = #NewList#>
    		<cfoutput>this is oldlist line 389--- #OldList# end of line</cfoutput>
    		<cfoutput>where line390</cfoutput>
    		<cfoutput>this is newlist line 391--- #NewList# end of line</cfoutput>
    		<!---end new code for old list--->
    		<CFINCLUDE TEMPLATE="textcompare.cfm">
    	<cfelse>
    	
    		<cfoutput>This is new #NewList#</cfoutput><br>
		</CFIF>
		 
		 <!------>
		 <CFelseIF This_AREA_NAME NEQ "" AND SelectDistrict EQ "no">
		 	<CFIF This_DIST_PERF_CLUSTER_NAME NEQ "">
        		<br/><BR><cfoutput> line 401 This_DIST_PERF_CLUSTER_NAME NEQ AND  = #This_DIST_PERF_CLUSTER_NAME# verse old #old_This_DIST_PERF_CLUSTER_NAME#</cfoutput><br>   
    		</CFIF>
		 	<BR><cfoutput>YES THIS AREA NAME DOES NOT EQUAL OR SELECTEDDIST EQ NO line 402</cfoutput><br>
		 	<CFSET NewList = This_AREA_NAME>
			<cfoutput>new list #NewList#</cfoutput>
			<!---TEST--->
			<CFIF STATUS_CODE EQ 1 OR STATUS_CODE_SELECTED EQ "1">
				<CFSET OldList = This_AREA_NAME>
				<CFOUTPUT>LINE 395 OLD LIST = #OldList#</cfoutput>
				<CFINCLUDE TEMPLATE="textcompare.cfm">
			<CFELSE>
				<CFOUTPUT>LINE 397 NEW LIST = #NewList#</cfoutput>
			</cfif>
		 <!---CFELSE--->
		 	<BR><cfoutput>NO THIS AREA NAME DOES EQUAL OR SELECTEDDIST EQ YES</cfoutput><br>
		 </CFIF>
		 
		 <!---NEW TEST--->
		 <CFIF IsDefined("CONTINGENT_LIAB_GetRecord_PrevRpt.RecordCount") AND CONTINGENT_LIAB_GetRecord_PrevRpt.DIST_PERF_CLUSTER_NAME NEQ "">
			<CFIF SelectDistrict EQ "yes">
				<cfoutput>YES DIV CLASS PREVIOULY REPORTED WITH STYLE</cfoutput><br>
				<div class="PreviouslyReported" style="margin-top:5pt">
 			<CFELSE>
 				<cfoutput>FALSE DIV CLASS PREVIOULY REPORTED WITHOUT STYLE</cfoutput><br>
        		<div class="PreviouslyReported">
			</CFIF>  
			
			<CFIF IsDefined("This_DIST_PERF_CLUSTER_NAME") AND This_DIST_PERF_CLUSTER_NAME NEQ CONTINGENT_LIAB_GetRecord_PrevRpt.DIST_PERF_CLUSTER_NAME> 
		
	    	<!---[Previously reported as: --->
		<!---12/26/2024 during the call to get rid of the previous reported section when choosing the previously recorded-
		commented out the [Prviously reported as: - above, added the or section in the cfif below and commented out the 1st  <cfoutput> beolw--->
		
		<!---BEFORE CODE
		[Previously reported as:
		<CFIF CONTINGENT_LIAB_GetRecord_PrevRpt.DIST_PERF_CLUSTER_NAME CONTAINS "MULTIPLE"> --->
        
			<CFIF CONTINGENT_LIAB_GetRecord_PrevRpt.DIST_PERF_CLUSTER_NAME CONTAINS "MULTIPLE" 
			or CONTINGENT_LIAB_GetRecord_PrevRpt.DIST_PERF_CLUSTER_NAME eq DIST_PERF_CLUSTER_NAME>
			
        		<CFOUTPUT>
				#CONTINGENT_LIAB_GetRecord_PrevRpt.DIST_PERF_CLUSTER_NAME#]
				</CFOUTPUT><br/>
        
    	    <CFELSE>
        		[Previously reported as:
	    	    <CFOUTPUT>
				#CONTINGENT_LIAB_GetRecord_PrevRpt.DIST_PERF_CLUSTER_NAME# District]
				</CFOUTPUT>
        
    	    </CFIF>
        
        
        </CFIF>
        </DIV>
		<!---CFELSE---->
			<cfoutput>LEAVES ISDEFINED CONTINGENT_LIAB_GetRecord_PrevRpt.RecordCoun ) AND CONTINGENT_LIAB_GetRecord_PrevRpt.DIST_PERF_CLUSTER_NAME NEQ</cfoutput><br>	 
		
		</CFIF>         
 
		<!---NEW TEST--->
		<CFIF This_DIVISION_CODE NEQ "">
    		<br />
			<CFSET NewList = This_DIVISION_CODE>
			<cfoutput>NEWEST LIST IF THIS DIVISION CODE IS NOT NULL= #NewList#</cfoutput><br>
			<div>
    
    	<CFSET OldList = CONTINGENT_LIAB_GetRecord_PrevRpt.DIVISION_CODE>
    	<!---added 12/27
    	<CFSET OldList = CONTINGENT_LIAB_GetRecord_PrevRpt.DIVISION_CODE & " (" & CONTINGENT_LIAB_GetRecord_PrevRpt.AREA_CODE &")"> --->
		<!---12/27/2024 comenetd out below for above code
		<CFSET OldList = CONTINGENT_LIAB_GetRecord_PrevRpt.DIVISION_CODE> end of 12/27 comented out below--->
     <!---12/27cfoutput>
		this is this dist perf cluster name #This_DIST_PERF_CLUSTER_NAME# --<BR>
		this is area name  #This_AREA_NAME# -- division code #DIVISION_CODE#<BR>
		new list #NewList# old list #OldList# ONE
	</cfoutput--->	
		
		<CFINCLUDE TEMPLATE="textcompare.cfm">	
    	</div>
    </CFIF>
    
    <!---- NEXT TO LAST SECTION--->
    <CFIF IsDefined("CONTINGENT_LIAB_GetRecord_PrevRpt.RecordCount")
	AND
	CONTINGENT_LIAB_GetRecord_PrevRpt.DIVISION_NAME NEQ ""
	AND
	CONTINGENT_LIAB_GetRecord_PrevRpt.DIVISION_NAME NEQ This_DIVISION_NAME>
	
		<div class="PreviouslyReported">

    	[Previously reported as: 
		<cfoutput>THIS IS TRUE</cfoutput><br>
        <CFOUTPUT>
		#CONTINGENT_LIAB_GetRecord_PrevRpt.DIVISION_NAME#]
		</CFOUTPUT>
        
		</div>
	
	</cfif>
	
	
	<!---LAST SECTION--->
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
		   	<cfoutput>OLDLIST IS NOTHING</cfoutput><br>
	
			<CFINCLUDE TEMPLATE="textcompare.cfm">
		
        	</div>
        
		<CFELSE>
		
			<CFSET NewList = '[None Selected]'>
			<cfoutput>NEW LIST IS NONE???</cfoutput><br>
        	<div>
        
			<CFOUTPUT>
			#NewList#
			</CFOUTPUT>
	
    		</div>
    
		</cfif>


	</CFIF>
	
<!---/CFIF-=--->
	</td>
	
	</tr>
	</cfif>
<!---12/30/24 end --DISTRICT DIVISION AREA --->
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



