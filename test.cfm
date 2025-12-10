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
	<tr><!---start of new row district--->
		<td>DISTRICT /</td><!---district row col 1--->
		<td>
		
		
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
					<CFSET This_DIST_PERF_CLUSTER_NAME = This_DIST_PERF_CLUSTER_NAME & " District">
				<CFELSE>
					<!---12/9/2025 commenting out cfset below with the cfset under it added p element--->
					<CFSET This_DIST_PERF_CLUSTER_NAME = This_DIST_PERF_CLUSTER_NAME & " (" & This_AREA_NAME & ")">				
				</CFIF>                          
			</cfif>

		<!---cfset for <CFIF This_DIST_PERF_CLUSTER_NAME NEQ "" AND SelectDistrict EQ "no">--->
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
			<!---cfoutput>hqdept1</cfoutput--->
			<CFELSE>
				<CFOUTPUT>#NewList#</cfoutput>
			</CFIF>

		<CFELSEIF This_AREA_NAME NEQ "" AND SelectDistrict EQ "no">
			<CFIF This_DIST_PERF_CLUSTER_NAME NEQ "">
				<br />
			</CFIF>

		<!---cfset for <CFIF This_DIST_PERF_CLUSTER_NAME NEQ "" AND SelectDistrict EQ "no">--->
		<CFSET NewList = This_AREA_NAME>
	
			<CFIF STATUS_CODE EQ 1 OR STATUS_CODE_SELECTED EQ "1">
				<CFSET OldList = This_AREA_NAME>
				<CFINCLUDE TEMPLATE="textcompare.cfm">
				<cfoutput>hqdept2</cfoutput>
			<CFELSE>
				<CFOUTPUT>#NewList#</cfoutput>
			</cfif>
	
		</CFIF>

		<CFIF IsDefined("CONTINGENT_LIAB_GetRecord_PrevRpt.RecordCount") AND CONTINGENT_LIAB_GetRecord_PrevRpt.DIST_PERF_CLUSTER_NAME NEQ "">
		<!---12/10/2025 this cfif is true--->
			<CFIF SelectDistrict EQ "yes">
		<!---12/9/025 added font size--->
				<div class="PreviouslyReported" style="margin-top:5pt; font-size:8pt" >

			<CFELSE>
       	<!---12/9/025 added font size--->
				<div class="PreviouslyReported" style="font-size:8pt">
            
			</CFIF>            

			<CFIF IsDefined("This_DIST_PERF_CLUSTER_NAME")	AND This_DIST_PERF_CLUSTER_NAME NEQ CONTINGENT_LIAB_GetRecord_PrevRpt.DIST_PERF_CLUSTER_NAME>		
				<cfif This_DIST_PERF_CLUSTER_NAME CONTAINS "MULTIPLE">
			<cfelse>
				[Previously reported as:
					<cfoutput >#CONTINGENT_LIAB_GetRecord_PrevRpt.DIST_PERF_CLUSTER_NAME# District]</cfoutput>
			</cfif>
		
			</CFIF>
        
       
		</div>
	
		</cfif>

		
		</td><!---district row col 2--->
	</tr><!---end of district row--->
	<tr><!---division row--->
		<td>DIVISION /</td><!---division row col 1--->
		<td>
		
		<CFIF IsDefined("CONTINGENT_LIAB_GetRecord_PrevRpt.RecordCount")
	AND
	CONTINGENT_LIAB_GetRecord_PrevRpt.DIVISION_NAME NEQ ""
	AND
	CONTINGENT_LIAB_GetRecord_PrevRpt.DIVISION_NAME NEQ This_DIVISION_NAME>
	
		<cfoutput><strong>#This_DIVISION_NAME#</strong></cfoutput>
		<div class="PreviouslyReported" style="font-size:8pt">
			
    	[Previously reported as: 
		
        <CFOUTPUT>
		#CONTINGENT_LIAB_GetRecord_PrevRpt.DIVISION_NAME#]
		</CFOUTPUT>
        
		</div>
	<cfelse>
		<cfoutput>#This_DIVISION_NAME# -- hqdept3a - </cfoutput>
	</cfif>

		</td><!---division row col 2--->
	</tr><!---end of division row--->
	<tr><!---hq dept row--->
		<td>HQ&nbsp;DEPT /</td><!---hq dept row col1--->
		<td>
		
			<CFIF This_DIVISION_CODE NEQ "">
    
			<!---12/9/2025 comment out br below--->
				<!---br /--->
			<!---comment out 12/9/2025 oldList below with new NewList line below
				<CFSET NewList = This_DIVISION_CODE>--->
				<cfset NewList = "line519"> 
				<div>

					<CFSET OldList = CONTINGENT_LIAB_GetRecord_PrevRpt.DIVISION_CODE>
					<CFINCLUDE TEMPLATE="textcompare.cfm">
		
					<cfoutput>#This_AREA_NAME# -- hqdept3b - </cfoutput>
    			</div>

   			 </CFIF>

					<!---12/9/2025 MOVED THIS SECTION ABOVE
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
						
						</cfif>--->


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
						<cfoutput>hqdept-final2</cfoutput>
    				</div>
    
				</cfif>

			</CFIF>
		
		</td><!---hq dept row col 2--->
	</tr><!---end of hq dept row--->
</CFIF>