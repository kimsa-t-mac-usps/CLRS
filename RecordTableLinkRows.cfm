<cfinclude template="MfaCookieCheck.cfm">


<!---

Included in Report.ptC.cfm

Links to EditRecord.cfm

Links, signals for MC / Deputy approve/disapprove


--->

<link rel="stylesheet" type="text/css" href="stylesheet.css">

<CFIF IsDefined("Get_Auth_User_Office.RecordCount") 
AND 
Get_Auth_User_Office.RecordCount EQ 1 
AND 
IsDefined("Get_Auth_User_Office.OFFICE_PRM_KEY") 
AND 
ALT_LAW_DEPT_OFFICE EQ Get_Auth_User_Office.OFFICE_PRM_KEY>


	<CFSET ALT_LAW_DEPT_OFFICE_Flag = "yes">


<CFELSEIF IsDefined("Get_Auth_User_Office.OFFICE_PRM_KEY")>


<!---
Check for HQ Corporate and Postal Business Law (45). If yes, include Corporate (23) and HQ Pricing and Product Development (25).
--->

	<CFIF Get_Auth_User_Office.OFFICE_PRM_KEY EQ 45>

		<CFIF ALT_LAW_DEPT_OFFICE EQ 23
		OR
		ALT_LAW_DEPT_OFFICE EQ 25>

			<CFSET ALT_LAW_DEPT_OFFICE_Flag = "yes">

		<CFELSE>

			<CFSET ALT_LAW_DEPT_OFFICE_Flag = "">

		</CFIF>


<!---
Check for HQ Procurement and Property Law (50). If yes, include HQ Civil Practice (22).
--->

	<CFELSEIF Get_Auth_User_Office.OFFICE_PRM_KEY EQ 50>

		<CFIF ALT_LAW_DEPT_OFFICE EQ 22>

			<CFSET ALT_LAW_DEPT_OFFICE_Flag = "yes">

		<CFELSE>

			<CFSET ALT_LAW_DEPT_OFFICE_Flag = "">

		</CFIF>


<!---
Check for HQ Legal Strategy (55). If yes, include HQ Civil Practice (22) and HQ Pricing and Product Development (25).
--->

	<CFELSEIF Get_Auth_User_Office.OFFICE_PRM_KEY EQ 55>

		<CFIF ALT_LAW_DEPT_OFFICE EQ 22
		OR
		ALT_LAW_DEPT_OFFICE EQ 25>

			<CFSET ALT_LAW_DEPT_OFFICE_Flag = "yes">

		<CFELSE>

			<CFSET ALT_LAW_DEPT_OFFICE_Flag = "">

		</CFIF>



<!---
Check for Northeast Windsor (16) or Northeast New York (7). If yes, include both.
--->

	<CFELSEIF Get_Auth_User_Office.OFFICE_PRM_KEY EQ 7
	OR
	Get_Auth_User_Office.OFFICE_PRM_KEY EQ 16>

		<CFIF ALT_LAW_DEPT_OFFICE EQ 7
		OR
		ALT_LAW_DEPT_OFFICE EQ 16>

			<CFSET ALT_LAW_DEPT_OFFICE_Flag = "yes">

		<CFELSE>

			<CFSET ALT_LAW_DEPT_OFFICE_Flag = "">

		</CFIF>


<!---
Check for Southern (104). If yes, include Southeast (5) and Southwest (4).
--->

	<CFELSEIF Get_Auth_User_Office.OFFICE_PRM_KEY EQ 104>

		<CFIF ALT_LAW_DEPT_OFFICE EQ 4
		OR
		ALT_LAW_DEPT_OFFICE EQ 5>

			<CFSET ALT_LAW_DEPT_OFFICE_Flag = "yes">

		<CFELSE>

			<CFSET ALT_LAW_DEPT_OFFICE_Flag = "">

		</CFIF>



	<CFELSE>

		<CFSET ALT_LAW_DEPT_OFFICE_Flag = "">

	</cfif>



<CFELSE>

	<CFSET ALT_LAW_DEPT_OFFICE_Flag = "">

</cfif>







<CFIF IsDefined("SelectedLDOffice")>
	<CFSET SelectedLDOffice_Parm = "&SelectedLDOffice=" & SelectedLDOffice>
<CFELSE>
	<CFSET SelectedLDOffice_Parm = "">
</CFIF>



<CFSET This_LAW_DEPT_OFFICE = CLRC_Query_Name & ".LAW_DEPT_OFFICE">


<CFQUERY NAME="Get_Case_LawDept_Office" DATASOURCE="contliab">
SELECT OFFICE
FROM LDOFFICES
WHERE

<!---
OFFICE_PRM_KEY = #Evaluate(This_LAW_DEPT_OFFICE)#
--->

<!--- Include LAW_DEPT_OFFICE (OFFICE_PRM_KEY in LDOFFICES) for both Northeast Windsor (16) and New York (former code 7) --->
<CFIF Evaluate(This_LAW_DEPT_OFFICE) EQ 7
OR
Evaluate(This_LAW_DEPT_OFFICE) EQ 16>

	OFFICE_PRM_KEY IN (7,16)

<CFELSE>

	OFFICE_PRM_KEY = #Evaluate(This_LAW_DEPT_OFFICE)#

</CFIF>



</cfquery>


<!---
<CFOUTPUT>

Evaluate(This_LAW_DEPT_OFFICE) = #Evaluate(This_LAW_DEPT_OFFICE)#
<p></p>

Get_Case_LawDept_Office.RecordCount = #Get_Case_LawDept_Office.RecordCount#
<p></p>


Trim(Get_Case_LawDept_Office.OFFICE) = "#Trim(Get_Case_LawDept_Office.OFFICE)#"
<p>

</CFOUTPUT>
--->





<CFIF Get_Case_LawDept_Office.RecordCount GT 0>

<!---
	<CFIF Left(Get_Case_LawDept_Office.OFFICE, 2) EQ "HQ" 
	OR 
	Left(Get_Case_LawDept_Office.OFFICE, 9) EQ "St. Louis">
--->

	<CFIF Left(Get_Case_LawDept_Office.OFFICE, 2) EQ "HQ" 
	OR 
	Left(Get_Case_LawDept_Office.OFFICE, 9) EQ "St. Louis"
	OR
	Trim(Get_Case_LawDept_Office.OFFICE) EQ "Employment Law"
	OR
	Trim(Get_Case_LawDept_Office.OFFICE) EQ "Labor Law">


    
		<CFSET Alt_Title = "Chief&nbsp;Counsel">
	
	<CFELSE>
	
    	<CFSET Alt_Title = "Deputy&nbsp;MC">
	
	</cfif>
	
</cfif>


<!---
<CFOUTPUT>

<p>
Alt_Title = "#Alt_Title#"
<p>


</CFOUTPUT>
--->






<!---
</cfif>
--->

<tr RecordTableLinkRows.cfm at 210>


<CFIF IsDefined("CLRC_Query_Name") 
AND 
CLRC_Query_Name EQ "Get_Single_Record">

	<CFSET RecordDisplay_Parm = "&RecordDisplay_Parm=Single">

<!---
    <CFOUTPUT>
	CLRC_Query_Name = "#CLRC_Query_Name#"
    <p>
	</CFOUTPUT>
--->

<CFELSE>

	<CFSET RecordDisplay_Parm = "">

<!---
    CLRC_Query_Name UNDEFINED
    <p>
--->

</cfif>



<CFIF IsDefined("ThisReportDate_Parm")>
	<CFSET URL_ThisReportDate_Parm = "&ThisReportDate_Parm=" & ThisReportDate_Parm>
<CFELSE>
	<CFSET URL_ThisReportDate_Parm = "">
</cfif>


<CFIF IsDefined("PrevReportDate_Parm")>
	<CFSET URL_PrevReportDate_Parm = "&PrevReportDate_Parm=" & PrevReportDate_Parm>
<CFELSE>
	<CFSET URL_PrevReportDate_Parm = "">
</CFIF>






<CFSET UpdateNeededFlag = "no">

<!---
<CFOUTPUT>
DATE_LAST_UPDATE = #DATE_LAST_UPDATE#
<br />
Get_MC_APPR_FLAG_Approved.RecordCount = #Get_MC_APPR_FLAG_Approved.RecordCount#
<br />
Get_Case_WithoutChecklist.RecordCount = #Get_Case_WithoutChecklist.RecordCount#
<p>
</CFOUTPUT>
--->

<CFIF DATE_LAST_UPDATE EQ "" 
AND 
(
Get_MC_APPR_FLAG_Approved.RecordCount EQ 1 
OR 
Get_Case_WithoutChecklist.RecordCount GT 0
)>


	<CFSET PkeyBkmarkFlag = "yes">
	
	<CFOUTPUT>
	
	<td colspan="2"><a name="#PRIMARYKEY#">&nbsp;</a>
	<div id="EditRecLink_#This_CurrentRow#" style="background:CCFFCC; padding:3pt; padding-bottom:5pt; margin-top:5pt; margin-bottom:-5pt; font-size:8pt; font-weight:bold">
	
	<CFIF IsDefined("EarlierRptDate") 
	OR 
	ALT_LAW_DEPT_OFFICE_Flag EQ "yes">


		<li class="TopIndex_Gray">&nbsp;&nbsp;[Case needs update]


	<CFELSE>

		<CFSET MaroonBorderList = ListAppend(MaroonBorderList, This_CurrentRow)>
		
		<CFSET UpdateNeededFlag = "yes">
		<!--- UpdateNeededFlag checked in textcompare.cfm --->
		
		<span class="RecordLink" id="UpdateNeededLink_#This_CurrentRow#"><span style="color:white; background:maroon; padding:2pt; font-size:10pt">Update&nbsp;Needed&nbsp;for&nbsp;Current&nbsp;Report:</span>
		
		
		<CFSET This_SHORT_TERM_LIABILITY = CLRC_Query_Name & ".SHORT_TERM_LIABILITY">
		
		
		<CFIF Evaluate(This_SHORT_TERM_LIABILITY) NEQ "">

			<span style="position:relative; right:-2pt"><a  href="EditRecord.cfm?RecIDParm=#PRIMARYKEY#&RowColorParm=#RowColor##SelectedLDOffice_Parm##RecordDisplay_Parm##URL_ThisReportDate_Parm##URL_PrevReportDate_Parm#"><img src="edit.pencil.gif" width="11" height="11" align="bottom" border="0" alt="Edit Icon"></a>&nbsp;<a  href="EditRecord.cfm?RecIDParm=#PRIMARYKEY#&RowColorParm=#RowColor##SelectedLDOffice_Parm##RecordDisplay_Parm##URL_ThisReportDate_Parm##URL_PrevReportDate_Parm#">Edit&nbsp;This&nbsp;Case&nbsp;Record</a>&nbsp;&nbsp;or&nbsp;&nbsp;<a href="EditRecord.Action.cfm?RecIDParm=#PRIMARYKEY#&RespondingUser_Id=#RespondingUser_Id##SelectedLDOffice_Parm##RecordDisplay_Parm##URL_ThisReportDate_Parm##URL_PrevReportDate_Parm#"><img src="ok.pct23.pct85.gif" width="21" height="16" align="middle" border="0" alt="OK Icon" style="margin-bottom:-4pt"></a><a href="EditRecord.Action.cfm?RecIDParm=#PRIMARYKEY#&RespondingUser_Id=#RespondingUser_Id##SelectedLDOffice_Parm##RecordDisplay_Parm##URL_ThisReportDate_Parm##URL_PrevReportDate_Parm#">Confirm&nbsp;"No&nbsp;Change"</a></span>

		<CFELSE>

			<span style="position:relative; right:-2pt"><a  href="EditRecord.cfm?RecIDParm=#PRIMARYKEY#&RowColorParm=#RowColor##SelectedLDOffice_Parm##RecordDisplay_Parm##URL_ThisReportDate_Parm##URL_PrevReportDate_Parm#"><img src="edit.pencil.gif" width="11" height="11" align="bottom" border="0" alt="Edit Icon"></a>&nbsp;<a  href="EditRecord.cfm?RecIDParm=#PRIMARYKEY#&RowColorParm=#RowColor##SelectedLDOffice_Parm##RecordDisplay_Parm##URL_ThisReportDate_Parm##URL_PrevReportDate_Parm#">Edit&nbsp;This&nbsp;Case&nbsp;Record</a></span>

		</cfif>

		</span>

<!--- Close CFELSE from <CFIF IsDefined("EarlierRptDate") OR ALT_LAW_DEPT_OFFICE_Flag EQ "yes"> --->
	</cfif>

	</div>
    
	</td>
	
	</cfoutput>


<!--- From <CFIF DATE_LAST_UPDATE EQ ""  --->
<CFELSE>

	<CFIF FINALIZED_FLAG EQ 1>

		<CFOUTPUT>
		<td>

		<CFIF NOT (IsDefined("PrevReportDate_Parm") 
		AND 
		IsDefined("ThisReportDate_Parm") 
		AND 
		ThisReportDate_Parm LE PrevReportDate_Parm)>


			<CFIF NOT (IsDefined("Form.CorpFinFormat") AND Form.CorpFinFormat EQ "CorpFinFormat")>

				<CFSET PkeyBkmarkFlag = "yes">

				<a name="#PRIMARYKEY#">&nbsp;</a>

			</cfif>


			<div id="RecLocked_#This_CurrentRow#" style="font-size:8pt; background:khaki; padding-top:3pt; padding-bottom:2pt; padding-left:4pt; padding-right:8pt; font-style:italic; font-weight:bold; margin-bottom:-1pt; text-align:center"><img src="Padlock.gif" width="12" height="15" align="baseline" alt="Padlock Image">&nbsp;&nbsp;Record Finalized</div>

		</CFIF>

		</td>
		
		</cfoutput>

	<CFELSE>

		<td>

		<CFIF NOT 
		(
		IsDefined("Form.CorpFinFormat") 
		AND 
		Form.CorpFinFormat EQ "CorpFinFormat"
		)>

			<CFSET PkeyBkmarkFlag = "yes">

			<CFOUTPUT>
			<a name="#PRIMARYKEY#">&nbsp;</a>
			</cfoutput>

		</cfif>


		<CFIF Get_MC_APPR_FLAG.RecordCount EQ 1>


			<CFIF GetMC.RecordCount EQ 1 
			AND 
			GetMC.CONTINGENT_LIAB_CONCUR GE 1 
			AND 
			GetMC.CONTINGENT_LIAB_CONCUR LT 9
			AND NOT 
			(
			GetMC.CONTINGENT_LIAB_CONCUR EQ 2 
			AND 
			Get_MC_APPR_FLAG.ALT_APPR_FLAG EQ 1
			)>
	
				<CFIF GetMC.CONTINGENT_LIAB_CONCUR EQ 1>

					<CFSET FormPrefix = "MC">

				<CFELSEIF GetMC.CONTINGENT_LIAB_CONCUR GT 1 
				AND 
				GetMC.CONTINGENT_LIAB_CONCUR LT 9>
				
                	<CFSET FormPrefix = "Alt">
				
				</cfif>

		
				<CFIF Get_MC_APPR_FLAG.MC_APPR_FLAG EQ 2>

					<CFIF IsDefined("Get_Auth_User_Office.OFFICE_PRM_KEY")>

						<CFIF Get_Auth_User_Office.OFFICE_PRM_KEY EQ ALT_LAW_DEPT_OFFICE>

							<CFSET SignalColor = "gray">
					
					    <CFELSEIF Get_Auth_User_Office.OFFICE_PRM_KEY EQ 7
						OR
						Get_Auth_User_Office.OFFICE_PRM_KEY EQ 16>
					
							<CFIF ALT_LAW_DEPT_OFFICE EQ 7
							OR
							ALT_LAW_DEPT_OFFICE EQ 16>
					
								<CFSET SignalColor = "gray">
					
							<CFELSE>
					
								<CFSET SignalColor = "maroon">
					
							</CFIF>
					
						<CFELSE>
					
							<CFSET SignalColor = "maroon">
					
						</cfif>
					
					<CFELSE>
					
						<CFSET SignalColor = "maroon">
					
					</cfif>



					<CFOUTPUT>
					<span style="font-size:9pt; font-weight:bold; background:#SignalColor#; text-align:center; color:white; width:13; height:10; padding-left:1px; border: 1px solid white">D</span>
					&nbsp;<span id="ApprDisapprStatusDiv_#This_CurrentRow#" style="font-size:8pt; font-weight:bold; background:khaki; padding:3pt">New&nbsp;Case&nbsp;Record&nbsp;Disapproved</span>
					</cfoutput>
					
					<CFSET MCApprovePosTop = "-5pt">
					<p>
					
<!--- From <CFIF Get_MC_APPR_FLAG.MC_APPR_FLAG EQ 2> --->	
				<CFELSE>

					<CFIF IsDefined("Get_Auth_User_Office.OFFICE_PRM_KEY")>
					
						<CFIF Get_Auth_User_Office.OFFICE_PRM_KEY EQ ALT_LAW_DEPT_OFFICE>
					
							<CFSET SignalColor = "gray">
					
					    <CFELSEIF Get_Auth_User_Office.OFFICE_PRM_KEY EQ 7
						OR
						Get_Auth_User_Office.OFFICE_PRM_KEY EQ 16>
					
							<CFIF ALT_LAW_DEPT_OFFICE EQ 7
							OR
							ALT_LAW_DEPT_OFFICE EQ 16>
					
								<CFSET SignalColor = "gray">
					
							<CFELSE>
					
								<CFSET SignalColor = "orange">
					
							</CFIF>
					
						<CFELSE>
					
							<CFSET SignalColor = "orange">
					
						</cfif>
					
					<CFELSE>
					
						<CFSET SignalColor = "maroon">
					
					</cfif>


					<CFOUTPUT>
					<span style="position:relative; font-size:9pt; font-weight:bold; background:#SignalColor#; text-align:center; color:white; width:13; height:10; padding-left:1px; border: 1px solid white; margin-right:3pt">N</span>
					</cfoutput>
					
					<CFSET MCApprovePosTop = "-13pt">
				
<!--- From CFELSE <CFIF Get_MC_APPR_FLAG.MC_APPR_FLAG EQ 2> --->		
				</cfif>


				<CFIF NOT (IsDefined("EarlierRptDate") 
				OR 
				ALT_LAW_DEPT_OFFICE_Flag EQ "yes")>

					<CFIF FormPrefix EQ "Alt">
						<CFSET ApproveAttn = Alt_Title>
					<CFELSEIF FormPrefix EQ "MC">
						<CFSET ApproveAttn = "MC">
					</cfif>
					
					<CFOUTPUT>
					
					<span id="ApprDisapprLinkDiv_#This_CurrentRow#" style="position:absolute; left:31pt; font-size:8pt; font-weight:bold; background:white; color:maroon; border:thin solid maroon; padding:3pt; margin-bottom:-5pt">#ApproveAttn#:&nbsp;<a href="" onClick="setMCEmailForm('#FormPrefix#', 1, #This_CurrentRow#); return false">Approve</a>&nbsp;/&nbsp;<a href="" onClick="setMCEmailForm('#FormPrefix#', 2, #This_CurrentRow#); return false">Disapprove</a>&nbsp;New&nbsp;Case</span>
					
					</cfoutput>


					<CFIF IsDefined("Get_Auth_User_Office.OFFICE_PRM_KEY")>
					
						<CFIF Get_Auth_User_Office.OFFICE_PRM_KEY EQ ALT_LAW_DEPT_OFFICE>
					
							<span style="position:absolute; font-size:8pt; font-weight:bold; background:ffd5aa; padding:3pt; margin-left:1pt; margin-top:-2pt">New&nbsp;Case&nbsp;Record&nbsp;Pending&nbsp;MC&nbsp;Approval</span>
					
					    <CFELSEIF Get_Auth_User_Office.OFFICE_PRM_KEY EQ 7
						OR
						Get_Auth_User_Office.OFFICE_PRM_KEY EQ 16>
					
							<CFIF ALT_LAW_DEPT_OFFICE EQ 7
							OR
							ALT_LAW_DEPT_OFFICE EQ 16>
					
								<span style="position:absolute; font-size:8pt; font-weight:bold; background:ffd5aa; padding:3pt; margin-left:1pt; margin-top:-2pt">New&nbsp;Case&nbsp;Record&nbsp;Pending&nbsp;MC&nbsp;Approval</span>
					
							</CFIF>
					
						</cfif>
					
					</cfif>
					
<!--- Close <CFIF NOT (IsDefined("EarlierRptDate") OR ALT_LAW_DEPT_OFFICE_Flag EQ "yes")> --->
                </cfif>

<!--- From <CFIF GetMC.RecordCount EQ 1  --->
			<CFELSEIF Get_MC_APPR_FLAG.MC_APPR_FLAG EQ 2>

				<CFIF IsDefined("Get_Auth_User_Office.OFFICE_PRM_KEY")>

					<CFIF Get_Auth_User_Office.OFFICE_PRM_KEY EQ ALT_LAW_DEPT_OFFICE>

						<CFSET SignalColor = "gray">
				
				    <CFELSEIF Get_Auth_User_Office.OFFICE_PRM_KEY EQ 7
					OR
					Get_Auth_User_Office.OFFICE_PRM_KEY EQ 16>
				
						<CFIF ALT_LAW_DEPT_OFFICE EQ 7
						OR
						ALT_LAW_DEPT_OFFICE EQ 16>
				
							<CFSET SignalColor = "gray">
				
						<CFELSE>
				
							<CFSET SignalColor = "maroon">
				
						</CFIF>
				
					<CFELSE>
				
						<CFSET SignalColor = "maroon">
				
					</cfif>
				
				<CFELSE>
				
					<CFSET SignalColor = "maroon">
				
				</cfif>


				<CFOUTPUT>
				<span style="font-size:9pt; font-weight:bold; background:#SignalColor#; text-align:center; color:white; width:13; height:10; padding-left:1px; border: 1px solid white">D</span>&nbsp;<span id="ApprDisapprStatusDiv_#This_CurrentRow#" style="position:absolute; font-size:8pt; font-weight:bold; background:ffd5aa; padding:3pt; margin-left:1pt; margin-top:-2pt">New&nbsp;Case&nbsp;Record&nbsp;Disapproved</span>
				
				</cfoutput>
				
			<CFELSE>


				<CFIF IsDefined("Get_Auth_User_Office.OFFICE_PRM_KEY")>
					
					<CFIF Get_Auth_User_Office.OFFICE_PRM_KEY EQ ALT_LAW_DEPT_OFFICE>

						<CFSET SignalColor = "gray">
				
				    <CFELSEIF Get_Auth_User_Office.OFFICE_PRM_KEY EQ 7
					OR
					Get_Auth_User_Office.OFFICE_PRM_KEY EQ 16>
				
						<CFIF ALT_LAW_DEPT_OFFICE EQ 7
						OR
						ALT_LAW_DEPT_OFFICE EQ 16>
				
							<CFSET SignalColor = "gray">
				
						<CFELSE>
				
							<CFSET SignalColor = "orange">
				
						</CFIF>
				
					<CFELSE>
				
						<CFSET SignalColor = "orange">
				
					</cfif>
				
				<CFELSE>
				
					<CFSET SignalColor = "orange">
				
				</cfif>
				


				<CFOUTPUT>
				<span style="position:relative; font-size:9pt; font-weight:bold; background:#SignalColor#; text-align:center; color:white; width:13; height:10; padding-left:1px; border: 1px solid white">N</span> <span style="position:absolute; font-size:8pt; font-weight:bold; background:ffd5aa; padding:3pt; margin-left:1pt; margin-top:-2pt">New&nbsp;Case&nbsp;Record&nbsp;Pending&nbsp;MC&nbsp;Approval</span>
				</cfoutput>
			
<!--- From <CFIF GetMC.RecordCount EQ 1  --->	
			</cfif>


			<CFIF GetMC.CONTINGENT_LIAB_CONCUR GE 1 
			AND 
			GetMC.CONTINGENT_LIAB_CONCUR LT 9
			AND NOT 
			(
			GetMC.CONTINGENT_LIAB_CONCUR EQ 2 
			AND 
			Get_MC_APPR_FLAG.ALT_APPR_FLAG EQ 1
			)>

				<CFOUTPUT>
				<div id="DisapprovalCommentDiv_#This_CurrentRow#" style="display:none; background:ffd5aa; padding:5pt; width:70%">
				</cfoutput>
				<p>
				To <b>Disapprove</b> this Case Record, type your Comment, if any, in the space below. (It will appear in the e-mail message sent automatically to the assigned Law Department counsel.)
				<br>
				Then click the <b>Disapprove</b> button.
				<br>
				<CFOUTPUT>
				<form name="EmailForm_#This_CurrentRow#" METHOD="POST" ACTION="SendEmailFromMC.cfm" onReset="hideMCEmailForm(#This_CurrentRow#)">
				</cfoutput>
				
				<CFOUTPUT>
				<textarea name="DisapprovalComment" rows="3" cols="50" style="font-family:arial; font-size:10pt; margin-top:-10pt; margin-bottom:5pt"></textarea>
				</cfoutput>
				
				<CFOUTPUT>
				<input type="hidden" name="CASE_REC_ID_SEQUENCE" value="#CASE_REC_ID_SEQUENCE#">
				<input type="hidden" name="RecID" value="#PRIMARYKEY#">
				<input type="hidden" name="#FormPrefix#_Approval_Flag">
				<input type="hidden" name="CASE_NAME" value="#CASE_NAME#">
				<input type="hidden" name="CASE_NUMBER" value="#CASE_NUMBER#">
				<input type="hidden" name="COUNSEL_LAW_DEPT" value="#COUNSEL_LAW_DEPT#">
				<input type="hidden" name="COCOUNSEL_LAW_DEPT" value="#COCOUNSEL_LAW_DEPT#">
				<input type="hidden" name="RespondingUser_Id" value="#RespondingUser_Id#">
				</cfoutput>
				
				<input TYPE="SUBMIT" VALUE="Disapprove">
				
				<input type="RESET" value="Reset" style="margin-left:30pt">
				
				</form>
				
				</div>
			
<!--- Close <CFIF GetMC.CONTINGENT_LIAB_CONCUR GE 1 --->	
			</cfif>
				
<!--- Close <CFIF Get_MC_APPR_FLAG.RecordCount EQ 1> --->
		</cfif>


		<CFIF
		(
		DATE_LAST_UPDATE NEQ ""
		OR
		(DATE_LAST_UPDATE EQ "" AND Get_MC_APPR_FLAG_Approved.RecordCount EQ 1)
		)>


			<CFIF Get_MC_APPR_FLAG_Approved.RecordCount EQ 1 
			OR 
			Get_Case_WithoutChecklist.RecordCount GT 0>
            
			
				<CFSET This_CONCUR_MC = CLRC_Query_Name & ".CONCUR_MC">
				
				<CFSET This_CONCUR_ALT = CLRC_Query_Name & ".CONCUR_ALT">
				
				<CFIF Evaluate(This_CONCUR_MC) NEQ 1>
				
					<CFIF GetMC.RecordCount EQ 1 
					AND 
					GetMC.CONTINGENT_LIAB_CONCUR GE 1 
					AND 
					GetMC.CONTINGENT_LIAB_CONCUR LT 9
					AND NOT 
					(
					IsDefined("EarlierRptDate") 
					OR 
					ALT_LAW_DEPT_OFFICE_Flag EQ "yes"
					)
					AND NOT 
					(
					GetMC.CONTINGENT_LIAB_CONCUR EQ 2 
					AND 
					Evaluate(This_CONCUR_ALT) EQ 1
					)>
					
					
						<CFIF IsDefined("Get_Auth_User_Office.OFFICE_PRM_KEY")>
						
							<CFIF Get_Auth_User_Office.OFFICE_PRM_KEY EQ ALT_LAW_DEPT_OFFICE>
						
								<CFSET SignalColor = "gray">
						
						    <CFELSEIF Get_Auth_User_Office.OFFICE_PRM_KEY EQ 7
							OR
							Get_Auth_User_Office.OFFICE_PRM_KEY EQ 16>
						
								<CFIF ALT_LAW_DEPT_OFFICE EQ 7
								OR
								ALT_LAW_DEPT_OFFICE EQ 16>
						
									<CFSET SignalColor = "gray">
						
								<CFELSE>
						
									<CFSET SignalColor = "green">
						
								</CFIF>
						
							<CFELSE>
						
								<CFSET SignalColor = "green">
						
							</cfif>
						
						<CFELSE>
						
							<CFSET SignalColor = "green">
						
						</cfif>
	


						<CFOUTPUT>
                        
						<span style="font-size:9pt; font-weight:bold; background:#SignalColor#; text-align:center; color:white; width:13; height:10; padding-left:1px; border: 1px solid white">U</span><span id="MCConcurLinkDiv_#This_CurrentRow#" style="position:absolute; font-size:8pt; font-weight:bold; background:yellow; color:maroon; border:thin solid maroon; padding:3pt; margin:3pt; margin-top:-3pt">Approve for Current Report:<br>
						
						
						<CFIF GetMC.CONTINGENT_LIAB_CONCUR EQ 1>
                        
							<a href="" onClick="setConcurrenceForm(1, #This_CurrentRow#); return false">MC</a>
						
						
						<!--- Query Find_Office_Concur in CheckUserAuth.cfm: --->
                        
                        
						<!---                        
                        <CFELSEIF Find_Office_Concur.RecordCount GT 0>
                        --->
                        
						<CFELSEIF IsDefined("Find_Office_Concur.RecordCount")
						AND
						Find_Office_Concur.RecordCount GT 0>
                        
							<span style="color:gray">MC</span>
						
						</cfif>

<!---
						<CFIF Find_Office_Concur.RecordCount GT 0>
--->

						<CFIF IsDefined("Find_Office_Concur.RecordCount")
						AND
						Find_Office_Concur.RecordCount GT 0>


						
							<CFIF Evaluate(This_CONCUR_ALT) NEQ 1>
							
								<span style="color:black">/</span>
								
								<CFIF GetMC.CONTINGENT_LIAB_CONCUR GT 1 
								AND 
								GetMC.CONTINGENT_LIAB_CONCUR LT 9>
                                
									<a href="" onClick="setConcurrenceForm(2, #This_CurrentRow#); return false">
								
									<CFOUTPUT>
									#Alt_Title#
									</cfoutput>
									
									</a>
								
								<CFELSE>
								
									<span style="color:gray">
									<CFOUTPUT>
									#Alt_Title#
									</cfoutput>
									</span>
									
								</cfif>
								
							</cfif>
								
						</cfif>
								
						</span>

						</cfoutput>


						<CFOUTPUT>
						<form name="ConcurrenceForm_#This_CurrentRow#" METHOD="POST" onSubmit="return checkSHORT_TERM_LIABILITY(this)" ACTION="Concur.Action.cfm">
						<input type="hidden" name="ConcurUser">
						<input type="hidden" name="RespondingUser_Id" value="#RespondingUser_Id#">
						<input type="hidden" name="RecID" value="#PRIMARYKEY#">
						
						
						<CFIF IsDefined("PrevReportDate_Parm") 
						AND 
						IsDefined("ThisReportDate_Parm")>
						
							<input type="hidden" name="RecordDisplay_Parm" value="#RecordDisplay_Parm#">
							<input type="hidden" name="ThisReportDate_Parm" value="#ThisReportDate_Parm#">
							<input type="hidden" name="PrevReportDate_Parm" value="#PrevReportDate_Parm#">
						
						</cfif>
			
            			
						<CFSET This_SHORT_TERM_LIABILITY = CLRC_Query_Name & ".SHORT_TERM_LIABILITY">
						

						<input type="hidden" name="SHORT_TERM_LIABILITY" value="#Evaluate(This_SHORT_TERM_LIABILITY)#">
						
						</form>
						</cfoutput>
						
					<CFELSE>


						<CFOUTPUT>
						<div id="MCUpd_#This_CurrentRow#">
						</cfoutput>


						<CFIF IsDefined("Get_Auth_User_Office.OFFICE_PRM_KEY")>
						
							<CFIF Get_Auth_User_Office.OFFICE_PRM_KEY EQ ALT_LAW_DEPT_OFFICE>
						
								<CFSET SignalColor = "gray">
						
						    <CFELSEIF Get_Auth_User_Office.OFFICE_PRM_KEY EQ 7
							OR
							Get_Auth_User_Office.OFFICE_PRM_KEY EQ 16>
						
								<CFIF ALT_LAW_DEPT_OFFICE EQ 7
								OR
								ALT_LAW_DEPT_OFFICE EQ 16>
						
									<CFSET SignalColor = "gray">
						
								<CFELSE>
						
									<CFSET SignalColor = "green">
						
								</CFIF>
						
							<CFELSE>
						
								<CFSET SignalColor = "green">
						
							</cfif>
						
						<CFELSE>
						
							<CFSET SignalColor = "green">
						
						</cfif>
						
						
						<CFOUTPUT>
						<span style="font-size:9pt; font-weight:bold; background:#SignalColor#; text-align:center; color:white; width:13; height:10; padding-left:1px; border: 1px solid white">U</span> <span style="position:absolute; font-size:8pt; font-weight:bold; background:bfdfff; padding:3pt; margin-left:1pt; margin-top:-2pt">Updated&nbsp;Case&nbsp;pending&nbsp;MC&nbsp;approval</span>
						
						</div>
						
						</cfoutput>
						
<!--- Close <CFIF GetMC.RecordCount EQ 1  --->
					</cfif>

<!--- From <CFIF Evaluate(This_CONCUR_MC) NEQ 1> --->
				<CFELSE>

					<CFOUTPUT>
					
					<div id="MCUpd_#This_CurrentRow#" style="position:absolute; font-size:8pt; background:bfdfff; padding:3pt"><img src="checkmark.black.pct66.gif" width="13" height="13" align="baseline" alt="Checkmark image">&nbsp;<b>MC&nbsp;has&nbsp;approved&nbsp;for&nbsp;Current&nbsp;Report</b></div>
					
					</cfoutput>
					
					<CFSET MCConcurFlag = "yes">
					
<!--- Close <CFIF Evaluate(This_CONCUR_MC) NEQ 1> --->
				</cfif>


<!--- Close <CFIF Get_MC_APPR_FLAG_Approved.RecordCount EQ 1 OR Get_Case_WithoutChecklist.RecordCount EQ 1>:
--->
			</cfif>

<!--- Close <CFIF DATE_LAST_UPDATE EQ "">:
--->
		</cfif>


		</td>


<!--- Close <CFIF FINALIZED_FLAG EQ 1> --->
	</cfif>


	<td align="right">
	
	<CFOUTPUT>
    
	<span id="Alt_Appr_#This_CurrentRow#" RecordTableLinkRows.cfm at 914 style="position:relative; font-size:8pt; font-weight:bold; padding:3pt; background:khaki; margin-left:5pt; margin-right:20pt">
	
	<CFIF IsDefined("This_CONCUR_ALT") 
	AND 
	IsDefined(This_CONCUR_ALT) 
	AND 
	Evaluate(This_CONCUR_ALT) EQ 1>
	
		#Alt_Title#&nbsp;has&nbsp;Approved
	
	<CFELSEIF Get_MC_APPR_FLAG.RecordCount EQ 1>
	
		<CFIF Get_MC_APPR_FLAG.ALT_APPR_FLAG EQ 1>
			#Alt_Title#&nbsp;has&nbsp;Approved
		<CFELSEIF Get_MC_APPR_FLAG.ALT_APPR_FLAG EQ 2>
			#Alt_Title#&nbsp;has&nbsp;Disapproved
		</cfif>
	
	</cfif>
	
	</span>
	
	</cfoutput>
	
<!--- After MC/Alt approval of new or updated record, don't display Edit Record link: --->


<!---
<CFOUTPUT>

FINALIZED_FLAG = #FINALIZED_FLAG#

<CFIF IsDefined("EarlierRptDate")>

EarlierRptDate = #EarlierRptDate#

<CFELSE>

EarlierRptDate NOT DEFINED

</CFIF>


ALT_LAW_DEPT_OFFICE_Flag = #ALT_LAW_DEPT_OFFICE_Flag#

<CFIF IsDefined("This_CONCUR_ALT")>

"This_CONCUR_ALT" = "#This_CONCUR_ALT#"


	<CFIF IsDefined(This_CONCUR_ALT)>
	Evaluate(This_CONCUR_ALT) = #Evaluate(This_CONCUR_ALT)#
	<CFELSE>
	This_CONCUR_ALT NOT DEFINED
	</CFIF>


<CFELSE>

"This_CONCUR_ALT" NOT DEFINED

</CFIF>




<CFIF IsDefined("This_CONCUR_MC")>

"This_CONCUR_MC" = "#This_CONCUR_MC#"

	<CFIF IsDefined(This_CONCUR_MC)>
	Evaluate(This_CONCUR_MC) = #Evaluate(This_CONCUR_MC)#
	<CFELSE>
	This_CONCUR_MC NOT DEFINED
	</CFIF>

<CFELSE>

"This_CONCUR_MC" NOT DEFINED

</CFIF>




<CFIF IsDefined("CONTINGENT_LIAB_GetRecord_PrevRpt.RecordCount")>

CONTINGENT_LIAB_GetRecord_PrevRpt.RecordCount = #CONTINGENT_LIAB_GetRecord_PrevRpt.RecordCount#

<CFELSE>

CONTINGENT_LIAB_GetRecord_PrevRpt.RecordCount NOT DEFINED

</CFIF>


<CFIF IsDefined("Get_MC_APPR_FLAG_Approved.RecordCount")>

Get_MC_APPR_FLAG_Approved.RecordCount = #Get_MC_APPR_FLAG_Approved.RecordCount#

<CFELSE>

Get_MC_APPR_FLAG_Approved.RecordCount NOT DEFINED

</CFIF>


<CFIF IsDefined("Get_Indiv_User.RecordCount")>

Get_Indiv_User.RecordCount = #Get_Indiv_User.RecordCount#

<CFELSE>

Get_Indiv_User.RecordCount NOT DEFINED

</CFIF>


<CFIF IsDefined("Get_Auth_User_Office.RecordCount")>

<!---
AND Get_Auth_User_Office.RecordCount EQ 1
--->

Get_Auth_User_Office.RecordCount = #Get_Auth_User_Office.RecordCount#

<CFELSE>

Get_Auth_User_Office.RecordCount NOT DEFINED




</CFIF>


</CFOUTPUT>
--->




<!---
Update.20100608.b:
Admin user (Check_Auth_User_A.RecordCount EQ 1) or Manager (Get_Auth_User_Office.RecordCount) gets Edit link even after MC approval or Alt approval. Indiv user (Get_Indiv_User.RecordCount EQ 1) gets Edit link only if no approval (MC or Alt).
--->

	<CFIF FINALIZED_FLAG NEQ 1
	AND NOT
	(
	IsDefined("EarlierRptDate") 
	OR 
	ALT_LAW_DEPT_OFFICE_Flag EQ "yes"
	)
	AND
	(
	(
	(
	IsDefined("Get_Auth_User_Office.RecordCount") 
	AND 
	Get_Auth_User_Office.RecordCount EQ 1
	)
	OR
	(
	IsDefined("Check_Auth_User_A.RecordCount") 
	AND 
	Check_Auth_User_A.RecordCount EQ 1
	)
	)
	OR
	(
	(
	IsDefined("Get_Indiv_User.RecordCount") 
	AND 
	Get_Indiv_User.RecordCount EQ 1
	)
	AND NOT
	(
	(
	IsDefined("This_CONCUR_ALT") 
	AND 
	IsDefined(This_CONCUR_ALT) 
	AND 
	Evaluate(This_CONCUR_ALT) EQ 1
	)
	OR
	(
	IsDefined("This_CONCUR_MC") 
	AND 
	IsDefined(This_CONCUR_MC) 
	AND 
	Evaluate(This_CONCUR_MC) EQ 1
	)
	)
	)
	)>
	
	
	
		<CFIF IsDefined("TextHighlight")
		AND
		TextHighlight EQ "Disabled">
		
			<CFSET Edit_TextHighlightParm = "&TextHighlight=Disabled">
		
		<CFELSE>
		
			<CFSET Edit_TextHighlightParm = "">
		
		</CFIF>
	
	
		<CFOUTPUT>
		<span id="EditRecLink_#This_CurrentRow#" style="background:CCFFCC; padding:3pt; padding-bottom:5pt; margin-top:10pt; font-size:8pt; font-weight:bold; text-align:right">
		<a href="EditRecord.cfm?RecIDParm=#PRIMARYKEY#&RowColorParm=#RowColor##SelectedLDOffice_Parm##RecordDisplay_Parm##URL_ThisReportDate_Parm##URL_PrevReportDate_Parm##Edit_TextHighlightParm#"><img src="edit.pencil.gif" width="11" height="11" align="bottom" border="0" alt="Edit Icon"></a>&nbsp;<a href="EditRecord.cfm?RecIDParm=#PRIMARYKEY#&RowColorParm=#RowColor##SelectedLDOffice_Parm##RecordDisplay_Parm##URL_ThisReportDate_Parm##URL_PrevReportDate_Parm##Edit_TextHighlightParm#">Edit&nbsp;This&nbsp;Case&nbsp;Record</a>
		</span>
		</cfoutput>
		
	</cfif>

	</td>

<!--- Close <CFIF DATE_LAST_UPDATE EQ ""  --->
</cfif>

</tr>

<tr style="height:10pt">


<td colspan="2" style="text-align:right">


<CFINCLUDE TEMPLATE="DetermineThresholdStatus.cfm">


<CFIF ThresholdStatus EQ "Below">

	<CFSET BelowThresholdLineMarginTop = "5pt">

	<CFOUTPUT>
	<div style="text-align:left; margin-left:25pt; margin-top:#BelowThresholdLineMarginTop#; margin-bottom:10pt">
	</CFOUTPUT>

	<span style="font-size:12pt; font-weight:bold; text-align:center; margin-right:4pt; margin-left:2pt">&times;</span>

<!---
	<span style="position:relative; font-style:italic; font-size:8pt">Max Reasonable Payout below reporting threshold</span>
--->


	<span style="position:relative; font-style:italic; font-size:8pt">Most Likely Payout below reporting threshold</span>



	</div>

</cfif>

<CFOUTPUT>

<CFIF Check_Auth_User_A.RecordCount EQ 1>

	<CFIF FINALIZED_FLAG NEQ 1>
	
		<CFIF 
		(
		IsDefined("This_CONCUR_ALT") 
		AND 
		IsDefined(This_CONCUR_ALT) 
		AND 
		Evaluate(This_CONCUR_ALT) EQ 1
		)
		OR
		(
		IsDefined("This_CONCUR_MC") 
		AND 
		IsDefined(This_CONCUR_MC) 
		AND 
		Evaluate(This_CONCUR_MC) EQ 1
		)>
		
			<span class="RecordLink" id="UndoApprLink_#This_CurrentRow#" style="font-size:8pt; font-weight:bold; background:bfdfff; padding:3pt; padding-top:7pt; margin-bottom:5pt; margin-right:12pt">
			<a href="EditRecord.Action.cfm?UndoApprFlag=UndoAppr&RecIDParm=#PRIMARYKEY##SelectedLDOffice_Parm#">Undo Approvals</a></span>
			
		</cfif>
		
		<span class="RecordLink" id="LockLink_#This_CurrentRow#" style="font-size:8pt; font-weight:bold; background:khaki; padding:3pt; margin-bottom:5pt">
		
		<a href="EditRecord.Action.cfm?LockFlag=Lock&RecIDParm=#PRIMARYKEY##SelectedLDOffice_Parm##URL_ThisReportDate_Parm##URL_PrevReportDate_Parm##RecordDisplay_Parm#"><img src="Padlock.gif" width="12" height="15" align="bottom" border="0" alt="Padlock Icon" style="margin-bottom:-2px"></a>&nbsp;<a href="EditRecord.Action.cfm?LockFlag=Lock&RecIDParm=#PRIMARYKEY##SelectedLDOffice_Parm##URL_ThisReportDate_Parm##URL_PrevReportDate_Parm##RecordDisplay_Parm#">Lock This Record</a>
		
		</span>
		
<!--- From <CFIF FINALIZED_FLAG NEQ 1> --->
	<CFELSE>

		<span class="RecordLink" id="LockLink_#This_CurrentRow#" style="font-size:8pt; font-weight:bold; background:khaki; padding:3pt; margin-bottom:5pt">
		
		<a href="EditRecord.Action.cfm?LockFlag=Lock&RecIDParm=#PRIMARYKEY##SelectedLDOffice_Parm##URL_ThisReportDate_Parm##URL_PrevReportDate_Parm##RecordDisplay_Parm#"><img src="Padlock.unlock.gif" width="12" height="15" align="bottom" border="0" alt="Padlock Icon" style="margin-bottom:-2px"></a>&nbsp;<a href="EditRecord.Action.cfm?LockFlag=UNLock&RecIDParm=#PRIMARYKEY##SelectedLDOffice_Parm##URL_ThisReportDate_Parm##URL_PrevReportDate_Parm##RecordDisplay_Parm#">UNLock This Record</a>
		
		</span>

<!--- Close <CFIF FINALIZED_FLAG NEQ 1> --->
	</cfif>

&nbsp;&nbsp;&nbsp;

<!--- Close <CFIF Check_Auth_User_A.RecordCount EQ 1> --->
</cfif>


<CFIF NOT (IsDefined("CLRC_Query_Name") 
AND 
CLRC_Query_Name EQ "Get_Single_Record")>

	<span class="RecordLink" id="CopyNewWindowLink_#This_CurrentRow#" style="font-size:8pt; font-weight:bold; background:ccccff; padding:3pt; margin-bottom:5pt"><a href="" onClick="writeNewWindow(#This_CurrentRow#); return false"><img src="copy.b.gif" width="15" height="13" align="bottom" border="0" alt="Copy Icon"></a>&nbsp;<a href="" onClick="writeNewWindow(#This_CurrentRow#); return false">Copy to New Window</a></span>

</cfif>

</cfoutput>

</td>
</tr>



