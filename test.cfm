<cfinclude template="MfaCookieCheck.cfm">
<!---
<cfset Init_User_Id = TRIM(UCASE(RemoveChars(auth_user,1,find('\',auth_user))))>
Init_User_Id variable equals: <cfoutput>"#Init_User_Id#"</cfoutput> <br>--->

<!---<h3>Server:  Eagnmnwep1431<//h3><br>
<CFDUMP VAR="#CGI#">--->

<!---<!DOCTYPE html>
<html>
	<head>
		<title>CF Mail Test on DEV</title>
	</head>
	<body>
		<p>This is a test for cfmail to see if the connection works11111</p>
		<!---<cfdump var="#cgi#" >--->
		<cftry>
		<cfmail from="Kimsa.t.mac@usps.gov"
		 subject="Thank you for your email"
		  to="Kimsa.t.mac@usps.gov"
		  <!---BCC="Kimsa.t.mac@usps.gov"--->
		   usetls="true" debug="true" >
			<p>Kimsa,</p>
			<p>It worked for me.</p>
			<p>Kimsa</p>
		</cfmail>
		<cfcatch type="any" >
			<cfdump var="#cfcatch#" >
		</cfcatch>
		</cftry>
	</body>
</html>
</html>
--->
	


<CFIF NOT (IsDefined("Form.CorpFinFormat") AND Form.CorpFinFormat EQ "CorpFinFormat")>
	
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
	
	<tr Report.ptc.cfm at >
		<td>District /</td>
		<td>
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
                		<CFSET This_DIST_PERF_CLUSTER_NAME = This_DIST_PERF_CLUSTER_NAME & " District">
					<CFELSE>
            			<!---12/9/2025 commenting out cfset below with the cfset under it added p element--->          	
						<CFSET This_DIST_PERF_CLUSTER_NAME = This_DIST_PERF_CLUSTER_NAME & "line 384(" & This_AREA_NAME & ")">          	
					</CFIF>
                </cfif>

				<CFSET NewList = This_DIST_PERF_CLUSTER_NAME>

        			<CFIF This_DIST_PERF_CLUSTER_NAME DOES NOT CONTAIN "District">   
        				<CFSET NewList = NewList & " District">
					</CFIF>             
      
				<CFIF ThisReportDate NEQ EarliestReportDate AND PrevReportDate NEQ "">       
					<CFSET OldList = CONTINGENT_LIAB_GetRecord_PrevRpt.DIST_PERF_CLUSTER_NAME>	
							
					<CFIF CONTINGENT_LIAB_GetRecord_PrevRpt.DIST_PERF_CLUSTER_NAME DOES NOT CONTAIN "District">
						<CFSET OldList = OldList & " District">
			    	</CFIF>
		            
					<CFINCLUDE TEMPLATE="textcompare.cfm">
			
					<cfoutput>hqdept1</cfoutput>
				<CFELSE>	
					<CFOUTPUT>#NewList#</cfoutput>	
				</CFIF>

			<CFELSEIF This_AREA_NAME NEQ "" AND SelectDistrict EQ "no">
				<CFIF This_DIST_PERF_CLUSTER_NAME NEQ "">
        			<br />   
    			</CFIF>
	
				<CFSET NewList = This_AREA_NAME>
	
				<CFIF STATUS_CODE EQ 1 OR STATUS_CODE_SELECTED EQ "1">
					<CFSET OldList = This_AREA_NAME>
					<CFINCLUDE TEMPLATE="textcompare.cfm">
	
					<cfoutput>hqdept2</cfoutput>
				<CFELSE>			
					<CFOUTPUT>#NewList#</cfoutput>	
				</cfif>
	
			</CFIF>
			
		</td>
	</tr>
	<tr Report.ptc.cfm at >
		<td>Division / </td>
		<td>
			<CFIF IsDefined("CONTINGENT_LIAB_GetRecord_PrevRpt.RecordCount") AND CONTINGENT_LIAB_GetRecord_PrevRpt.DIST_PERF_CLUSTER_NAME NEQ "">
				<CFIF SelectDistrict EQ "yes">
					<!---12/9/025 added font size--->
					<div class="PreviouslyReported" style="margin-top:5pt; font-size:8pt" >
				<CFELSE>
        			<!---12/9/025 added font size--->
					<div class="PreviouslyReported" style="font-size:8pt">        
				</CFIF>            

				<CFIF IsDefined("This_DIST_PERF_CLUSTER_NAME")AND This_DIST_PERF_CLUSTER_NAME NEQ CONTINGENT_LIAB_GetRecord_PrevRpt.DIST_PERF_CLUSTER_NAME>
	    			[Previously reported as: 
					
					<CFIF CONTINGENT_LIAB_GetRecord_PrevRpt.DIST_PERF_CLUSTER_NAME CONTAINS "MULTIPLE">					
		        		<CFOUTPUT>#CONTINGENT_LIAB_GetRecord_PrevRpt.DIST_PERF_CLUSTER_NAME#]</CFOUTPUT>
    	    		<CFELSE>      		
	    	    		<CFOUTPUT>#CONTINGENT_LIAB_GetRecord_PrevRpt.DIST_PERF_CLUSTER_NAME# District]</CFOUTPUT>
        			</CFIF>
        		</CFIF>
        			</div>
			</cfif>
				<cfoutput>#This_DIVISION_NAME# -- hqdept3a - </cfoutput>

			
		</td>
	</tr>
	<tr Report.ptc.cfm at >
		<td>HQ&nbsp;Dept /</td>
		<td>
			
			<CFIF IsDefined("CONTINGENT_LIAB_GetRecord_PrevRpt.RecordCount") AND CONTINGENT_LIAB_GetRecord_PrevRpt.DIST_PERF_CLUSTER_NAME NEQ "">
				<CFIF SelectDistrict EQ "yes">
					<!---12/9/025 added font size--->
					<div class="PreviouslyReported" style="margin-top:5pt; font-size:8pt" >
				<CFELSE>
        			<!---12/9/025 added font size--->
					<div class="PreviouslyReported" style="font-size:8pt">      
				</CFIF>            

				<CFIF IsDefined("This_DIST_PERF_CLUSTER_NAME") AND This_DIST_PERF_CLUSTER_NAME NEQ CONTINGENT_LIAB_GetRecord_PrevRpt.DIST_PERF_CLUSTER_NAME>
	    			[Previously reported as: 
		      
					<CFIF CONTINGENT_LIAB_GetRecord_PrevRpt.DIST_PERF_CLUSTER_NAME CONTAINS "MULTIPLE">			
        				<CFOUTPUT>#CONTINGENT_LIAB_GetRecord_PrevRpt.DIST_PERF_CLUSTER_NAME#]</CFOUTPUT>
        			<CFELSE>    		
	    	    		<CFOUTPUT>#CONTINGENT_LIAB_GetRecord_PrevRpt.DIST_PERF_CLUSTER_NAME# District]</CFOUTPUT>
        			</CFIF>
        		</CFIF>
        		</div>
	
			</cfif>
			<cfoutput>#This_DIVISION_NAME# -- hqdept3a - </cfoutput>
	
		<!---12/9/2025 START - ADDED FROM BELOW FOR PREVIOUS DIVISION--->
			<CFIF IsDefined("CONTINGENT_LIAB_GetRecord_PrevRpt.RecordCount")
			AND CONTINGENT_LIAB_GetRecord_PrevRpt.DIVISION_NAME NEQ "" AND CONTINGENT_LIAB_GetRecord_PrevRpt.DIVISION_NAME NEQ This_DIVISION_NAME>
	
				<div class="PreviouslyReported" style="font-size:8pt">
    				[Previously reported as: 	
        			<CFOUTPUT>#CONTINGENT_LIAB_GetRecord_PrevRpt.DIVISION_NAME#]</CFOUTPUT>   
				</div>
	
			</cfif>
		<!---12/9/2025 END - ADDED FROM BELOW FOR PREVIOUS DIVISION--->
		
			<CFIF This_DIVISION_CODE NEQ "">
				<cfset NewList = "line519"> 
				<!---12/8/2025 added br---><br>
				<div>
  
				<CFSET OldList = CONTINGENT_LIAB_GetRecord_PrevRpt.DIVISION_CODE>      
				<CFINCLUDE TEMPLATE="textcompare.cfm">
	
				<cfoutput>#This_AREA_NAME# -- hqdept3b - </cfoutput>
    			</div>
    
    		</CFIF>

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
						<cfoutput>hqdept-final2</cfoutput>
				   	</div>
    
				</cfif>
			</CFIF>
		


<!--- Close <CFIF NOT (IsDefined("Form.CorpFinFormat") AND Form.CorpFinFormat EQ "CorpFinFormat")> --->
</cfif>

			
	</td>
	</tr>
	
	