<cfoutput></cfoutput><br>
<cfoutput>##</cfoutput><br>

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
//division_code is defined
		<CFSET This_DIVISION_CODE = DIVISION_CODE>

	<CFELSE>
    
		<!---12/27 commented out and added below <CFSET This_DIVISION_CODE = ""--->
		<cfset This_DIVISION_CODE = ""
	</CFIF>


	<CFIF IsDefined("DIVISION_NAME")>

		<CFSET This_DIVISION_NAME = DIVISION_NAME>

	<CFELSE>
   		<!---12/24/2024 put this in ?? CFSET This_DIVISION_NAME = ""
		<CFSET This_DIVISION_NAME = This_DIVISION_CODE>--->
		<CFSET This_DIVISION_NAME = "">
	</CFIF>


<cfoutput></cfoutput><br>
<cfoutput>##</cfoutput><br>


	<CFIF This_DIST_PERF_CLUSTER_NAME NEQ ""
	AND 
	This_AREA_NAME DOES NOT CONTAIN "HQ"
	AND
	ListFind(ValueList(Get_Districts.NAME), This_DIST_PERF_CLUSTER_NAME) EQ 0>
    
 
 		<CFSET SelectDistrict = "yes">
 
		<strong>[Select New District]&nbsp;<span class='ClickEdit'>Click "Edit This Case Record" to select</span></strong>
		<!---<span style="normal">[Select New District]&nbsp;<span class='ClickEdit'>Click "Edit This Case Record" to select</span></span>--->
	    
	<CFELSE>
    
		<CFSET SelectDistrict = "no">

	</CFIF>

	<CFIF This_DIST_PERF_CLUSTER_NAME NEQ ""
	AND
	SelectDistrict EQ "no">
    

		<CFIF This_AREA_NAME NEQ "">
        
        
        	<CFIF This_DIST_PERF_CLUSTER_NAME DOES NOT CONTAIN "District">
        //this happened
				<CFSET This_DIST_PERF_CLUSTER_NAME = This_DIST_PERF_CLUSTER_NAME & " District (" & This_AREA_NAME & ")">
                
			<CFELSE>
            
				<CFSET This_DIST_PERF_CLUSTER_NAME = This_DIST_PERF_CLUSTER_NAME & " (" & This_AREA_NAME & ")">
                
			</CFIF>
                
                            
		</cfif>
<cfoutput></cfoutput><br>
<cfoutput>##</cfoutput><br>

	
		<CFSET NewList = This_DIST_PERF_CLUSTER_NAME>
        
        
        <CFIF This_DIST_PERF_CLUSTER_NAME DOES NOT CONTAIN "District"> 
        
        	<CFSET NewList = NewList & " District-- LINE 402">
            
		</CFIF>             
        
	


		<CFIF ThisReportDate NEQ EarliestReportDate AND PrevReportDate NEQ "">
           //this is \executed 
			<CFSET OldList = CONTINGENT_LIAB_GetRecord_PrevRpt.DIST_PERF_CLUSTER_NAME>
				//this gets executed
			<CFIF CONTINGENT_LIAB_GetRecord_PrevRpt.DIST_PERF_CLUSTER_NAME DOES NOT CONTAIN "District">
				<CFSET OldList = OldList & " District">
    		</CFIF>
            //this gets executed
			<CFINCLUDE TEMPLATE="textcompare.cfm">
	
	
		<CFELSE>

			<CFOUTPUT>
			#NewList#
    		</cfoutput>

		</CFIF>


<cfoutput></cfoutput><br>
<cfoutput>##</cfoutput><br>


	<CFELSEIF This_AREA_NAME NEQ ""
	AND
	SelectDistrict EQ "no">
	

		//THIS IS TRUE
		<CFIF This_DIST_PERF_CLUSTER_NAME NEQ "">

        	<br />
    
    	</CFIF>

	//THIS HAPPENS
		<CFSET NewList = This_AREA_NAME>
	<cfoutput>
		new list #NewList#
	</cfoutput>
		<CFIF STATUS_CODE EQ 1 OR STATUS_CODE_SELECTED EQ "1">
	

			<CFSET OldList = This_AREA_NAME>
	

			<CFINCLUDE TEMPLATE="textcompare.cfm">
	
	
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
 

		<CFIF IsDefined("This_DIST_PERF_CLUSTER_NAME")
		AND
		This_DIST_PERF_CLUSTER_NAME NEQ CONTINGENT_LIAB_GetRecord_PrevRpt.DIST_PERF_CLUSTER_NAME> 


	    	<!---[Previously reported as: --->
		<!---12/26/2024 during the call to get rid of the previous reported section when choosing the previously recorded-
		commented out the [Prviously reported as: - above, added the or section in the cfif below and commented out the 1st  <cfoutput> beolw--->
		
		<!---BEFORE CODE
		[Previously reported as:
		<CFIF CONTINGENT_LIAB_GetRecord_PrevRpt.DIST_PERF_CLUSTER_NAME CONTAINS "MULTIPLE"> --->
        
			<CFIF CONTINGENT_LIAB_GetRecord_PrevRpt.DIST_PERF_CLUSTER_NAME CONTAINS "MULTIPLE" 
			or CONTINGENT_LIAB_GetRecord_PrevRpt.DIST_PERF_CLUSTER_NAME eq DIST_PERF_CLUSTER_NAME>
			
        		<!---CFOUTPUT>
				#CONTINGENT_LIAB_GetRecord_PrevRpt.DIST_PERF_CLUSTER_NAME#]
				</CFOUTPUT---><br/>
        
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
    
    	<!---added 12/27--->
    	<CFSET OldList = CONTINGENT_LIAB_GetRecord_PrevRpt.DIVISION_CODE & " (" & CONTINGENT_LIAB_GetRecord_PrevRpt.AREA_CODE &")"> 
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
	
			<CFINCLUDE TEMPLATE="textcompare.cfm">
		
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

