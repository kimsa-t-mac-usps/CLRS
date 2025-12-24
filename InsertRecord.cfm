<cfinclude template="MfaCookieCheck.cfm">

<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<!---<meta http-equiv="X-UA-Compatible" content="IE=edge">--->
<title>CONFIDENTIAL Law Department Contingent Liabilities: Add New Case</title>

<style>

/*
FFFFCC
*/

body {font-family:arial,sans-serif;font-size:10pt; background:linen}

div.quesSet {margin-top:5pt; margin-bottom:5pt; padding:5pt}

td {font-family:arial,sans-serif;font-size:10pt}
td.header {font-family:arial,sans-serif;font-size:8pt}
textarea {font-family:arial,sans-serif;font-size:10pt}
th {font-family:arial,sans-serif;font-size:10pt; font-weight:bold; width:10%; align:right}

A:hover {background:black; color:white; text-decoration:none; font-family:arial; font-size:10pt; font-weight:bold}
A:active {background:white; color:black; text-decoration:none; font-family:arial; font-size:10pt; font-weight:bold}

</style>


<CFSET ThisPage = "InsertRecord">
<CFINCLUDE TEMPLATE="CheckUserAuth.cfm">

<!---
Check CONTINGENT_LIAB_BLOCK_NEW flag in BUSINESSSERVUSERS table for dummy user surname "Contingent Liabilities" (WHERE USERPRMKEY = 13). System blocks users from entering new cases if flag = "Y"
--->
<CFQUERY NAME="Check_CONTINGENT_LIAB_BLOCK_NEW" DATASOURCE="contliab">

SELECT CONTINGENT_LIAB_BLOCK_NEW

FROM BUSINESSSERVUSERS

WHERE USERPRMKEY = 13

AND
CONTINGENT_LIAB_BLOCK_NEW IS NOT NULL

</cfquery>


<CFIF Check_CONTINGENT_LIAB_BLOCK_NEW.RecordCount EQ 1
AND
Check_CONTINGENT_LIAB_BLOCK_NEW.CONTINGENT_LIAB_BLOCK_NEW EQ "Y"
AND
Check_Auth_User_A.RecordCount NEQ 1>

	<script language="javascript">
	location.href = "UnavailableForNewCases.cfm"
	</script>

</cfif>



<script language="JavaScript" src="calendar5.js"></script>

<script language="javascript">

returnFalseFlag = true;

datePattern_Yr2Digit = /^\d{1,2}\/\d{1,2}\/\d{2}$/

datePattern_Yr4Digit = /^\d{1,2}\/\d{1,2}\/\d{4}$/

/*
moneyPattern = /^\d+|[.]?$/
moneyPattern = /^\d+$/
moneyDecimal = /^\.?$/
moneyPattern_Exclude = /^\D+$/
*/


moneyPattern = /^\d+\.?\d?$/



function checkHQ_AREA_NAME(thisHQ_AREA_NAME) {

thisHQ_AREA_NAME = thisHQ_AREA_NAME.options[thisHQ_AREA_NAME.selectedIndex].value;


if (thisHQ_AREA_NAME.substring(6) == "HQ Labor Relations") {
	Unions_Selected_Row.style.display = "inline";
/*
	HQ_AREA_NAME.style.marginBottom = "-15pt";
*/
}

else Unions_Selected_Row.style.display = "none";

}






				function checkAmtAsTyped(amtFieldName, amtFieldLabel) {
					validateAmtField(amtFieldName, amtFieldLabel);
					if (returnFalseFlag == false) {
						var clickUnk = (amtFieldLabel == "Damages Assessment") ? '"Unknown."' : '"Unknown"  or "N/A."';
						alert('"' + amtFieldLabel + '" must be numeric value with up to one decimal place and without dollar sign or comma. If no numeric value, leave "' + amtFieldLabel + '" blank, and click ' + clickUnk);
						var thisAmtField = "CaseForm." + amtFieldName;
						eval(thisAmtField).focus();
					}
				}

				function validateAmtField(amtFieldName, amtFieldLabel) {
					returnFalseFlag = true;
					var thisAmtField = "CaseForm." + amtFieldName;
					var thisAmtField_value = eval(thisAmtField).value;
					if (thisAmtField_value.substring(0,1) == ".") {
						thisAmtField_value = "0" + thisAmtField_value;
						eval(thisAmtField).value = thisAmtField_value;
					}

					if (!moneyPattern.test(eval(thisAmtField).value)) {
						if (eval(thisAmtField).value != "") {
							returnFalseFlag = false;
						}
					}
				}

				function checkDateAsTyped() {
					validateDateField();
					if (returnFalseFlag == false) {
						alert('"Date Filed" must be a Date value: mm/dd/yyyy. If no Date, leave "Date Filed" blank, and click "Unknown" or "N/A."');
						CaseForm.DATE_FILED.focus();
					}
				}

				function validateDateField() {
					returnFalseFlag = true;
					if (!(datePattern_Yr2Digit.test(CaseForm.DATE_FILED.value) || datePattern_Yr4Digit.test(CaseForm.DATE_FILED.value))) {
						if (CaseForm.DATE_FILED.value != "") {
							CaseForm.DATE_FILED.focus();
							returnFalseFlag = false;
						}
					}
				}

				function clearUnknown(fieldName) {
					var thisUnkFormField = "CaseForm." + fieldName + "_UNKNOWN";
					if (eval(thisUnkFormField).length) {
						for (var i = 0; i < eval(thisUnkFormField).length; i++) eval(thisUnkFormField)[i].checked = false;
					} else {
						if (eval(thisUnkFormField)) eval(thisUnkFormField).checked = false;
					}
				}

				function showUnionsSelected(thisForm) {
					var thisUnions_Selected = "";
					if (thisForm.Unions_Selected) {
						if (thisForm.Unions_Selected.length) {
							for (var i = 0; i < thisForm.Unions_Selected.length; i++) {
								if (thisForm.Unions_Selected[i].checked) {
									if (thisUnions_Selected == "") thisUnions_Selected = thisForm.Unions_Selected[i].value;
									else thisUnions_Selected = thisUnions_Selected + "," + thisForm.Unions_Selected[i].value;
								}
							}
						} else {
							if (thisForm.Unions_Selected.value) thisUnions_Selected = thisForm.Unions_Selected.value;
						}
					}
					thisForm.Unions_Selected_ALL.value = thisUnions_Selected;
					return true;
				}

				function checkSelected(CaseForm) {
					showUnionsSelected(CaseForm);

					if (CaseForm.FIELD_GRIEVANCE_FLAG[0].checked && CaseForm.NATL_GATS_NUMBER.value == "") {
						alert("You have checked 'Yes,' indicating this is a Field Grievance pending resolution of a national-level case.\n\nPlease enter the GATS Number of the national-level case.");
						CaseForm.NATL_GATS_NUMBER.focus();
						return false;
					}

					if (CaseForm.LM_MATTER_NUMBER.value.length > 11) {
						alert("LawManager Matter Number must be no longer than 11 characters.");
						CaseForm.LM_MATTER_NUMBER.focus();
						return false;
					}

					validateDateField();

					var DATE_FILED_UNKNOWN_Option = -1;
					if (CaseForm.DATE_FILED_UNKNOWN && CaseForm.DATE_FILED_UNKNOWN.length) {
						for (var i = 0; i < CaseForm.DATE_FILED_UNKNOWN.length; i++) {
							if (CaseForm.DATE_FILED_UNKNOWN[i].checked) { DATE_FILED_UNKNOWN_Option = i; break; }
						}
					}

					if (DATE_FILED_UNKNOWN_Option == -1) {
						if (CaseForm.DATE_FILED.value == "") {
							alert("Please enter Date Filed or check 'N/A' or 'Unknown.'");
							focusField = "CaseForm.DATE_FILED";
							returnFalseFlag = false;
						}
					} else {
						if (CaseForm.DATE_FILED.value != "") {
							alert("For Date Filed, 'N/A' or 'Unknown' is checked, but Date Filed value is also entered. Please correct: Click inside Date Filed field to un-check 'N/A' and 'Unknown.' Then if there is no Date Filed value, erase the value entered in Date Filed field and re-check 'N/A' or 'Unknown.'");
							focusField = "CaseForm.DATE_FILED";
							returnFalseFlag = false;
						}
					}

					var AMOUNT_SOUGHT_UNKNOWN_Option = -1;
					if (CaseForm.AMOUNT_SOUGHT_UNKNOWN && CaseForm.AMOUNT_SOUGHT_UNKNOWN.length) {
						for (var i = 0; i < CaseForm.AMOUNT_SOUGHT_UNKNOWN.length; i++) {
							if (CaseForm.AMOUNT_SOUGHT_UNKNOWN[i].checked) { AMOUNT_SOUGHT_UNKNOWN_Option = i; break; }
						}
					}

if (AMOUNT_SOUGHT_UNKNOWN_Option == -1) {

if (CaseForm.AMOUNT_SOUGHT.value == "") {

	alert("Please enter Amount Sought or check 'N/A' or 'Unknown.'");
	focusField = "CaseForm.AMOUNT_SOUGHT";
	returnFalseFlag = false;
}

}

else {

if (CaseForm.AMOUNT_SOUGHT.value != "") {

	alert("For Amount Sought, 'N/A' or 'Unknown' is checked, but Amount Sought value is also entered. Please correct: Click inside Amount Sought field to un-check 'N/A' and 'Unknown.' Then if there is no Amount Sought value, erase the value entered in Amount Sought field and re-check 'N/A' or 'Unknown.'");
	focusField = "CaseForm.AMOUNT_SOUGHT";
	returnFalseFlag = false;
}


}



/*
if (CaseForm.ASSESSMENT_AMOUNT.value == "" && CaseForm.ASSESSMENT_AMOUNT_UNKNOWN.checked == false) {
	alert("Please enter the Assessment Amount or check 'Unknown.'");
	focusField = "CaseForm.ASSESSMENT_AMOUNT";
	returnFalseFlag = false;
	}
*/


ASSESSMENT_AMOUNT_UNKNOWN_Option = -1;

if (CaseForm.ASSESSMENT_AMOUNT_UNKNOWN && CaseForm.ASSESSMENT_AMOUNT_UNKNOWN.checked) 	ASSESSMENT_AMOUNT_UNKNOWN_Option = 0;


					if (ASSESSMENT_AMOUNT_UNKNOWN_Option == -1) {
						if (CaseForm.ASSESSMENT_AMOUNT.value == "") {
							alert("Please enter both Most Likely Payout and Maximum Reasonable Payout or check 'Unknown.'");
							focusField = "CaseForm.ASSESSMENT_AMOUNT";
							returnFalseFlag = false;
						}
						if (CaseForm.ASSESSMENT_AMOUNT_UPPER.value == "") {
							alert("Please enter both Most Likely Payout and Maximum Reasonable Payout or check 'Unknown.'");
							focusField = "CaseForm.ASSESSMENT_AMOUNT_UPPER";
							returnFalseFlag = false;
						}
						if (CaseForm.ASSESSMENT_AMOUNT.value != "" && CaseForm.ASSESSMENT_AMOUNT_UPPER.value != "") {
							if (parseFloat(CaseForm.ASSESSMENT_AMOUNT.value) > parseFloat(CaseForm.ASSESSMENT_AMOUNT_UPPER.value)) {
								alert("Most Likely Payout must be less than or equal to Maximum Reasonable Payout.\n\nPlease revise.");
								focusField = "CaseForm.ASSESSMENT_AMOUNT";
								returnFalseFlag = false;
							}
						}
					} else {
						if (CaseForm.ASSESSMENT_AMOUNT.value != "") {
							alert("For Damages Assessment, 'Unknown' is checked, but Most Likely Payout value is also entered. Please correct: Click inside Most Likely Payout field to un-check 'Unknown.' Then if there is no Damages Assessment value, erase the value entered in Most Likely Payout field and re-check 'Unknown.'");
							focusField = "CaseForm.ASSESSMENT_AMOUNT";
							returnFalseFlag = false;
						}
						if (CaseForm.ASSESSMENT_AMOUNT_UPPER.value != "") {
							alert("For Damages Assessment, 'Unknown' is checked, but Maximum Reasonable Payout value is also entered. Please correct: Click inside Maximum Reasonable Payout field to un-check 'Unknown.' Then if there is no Damages Assessment value, erase the value entered in Maximum Reasonable Payout field and re-check 'Unknown.'");
							focusField = "CaseForm.ASSESSMENT_AMOUNT_UPPER";
							returnFalseFlag = false;
						}
					}

					var SHORT_TERM_LIABILITY_Option = -1;
					if (CaseForm.SHORT_TERM_LIABILITY && CaseForm.SHORT_TERM_LIABILITY.length) {
						for (var i = 0; i < CaseForm.SHORT_TERM_LIABILITY.length; i++) {
							if (CaseForm.SHORT_TERM_LIABILITY[i].checked) { SHORT_TERM_LIABILITY_Option = i; break; }
						}
					}

					if (SHORT_TERM_LIABILITY_Option == -1) {
						alert("Please select Estimated Time to Resolution.");
						CaseForm.SHORT_TERM_LIABILITY[0].focus();
						return false;
					}

					if (CaseForm.DIST_PERF_CLUSTER_CODE.value == "0" && CaseForm.HQ_AREA_NAME.value == "0") { alert("Please select a District or HQ Department."); focusField = "CaseForm.DIST_PERF_CLUSTER_CODE"; returnFalseFlag = false; }
					if (CaseForm.COUNSEL_LAW_DEPT.value == "0") { alert("Please select Law Dept Counsel."); focusField = "CaseForm.COUNSEL_LAW_DEPT"; returnFalseFlag = false; }
					if (CaseForm.LAW_DEPT_OFFICE.value == "0") { alert("Please select Law Dept Reporting Office."); focusField = "CaseForm.LAW_DEPT_OFFICE"; returnFalseFlag = false; }
					if (CaseForm.FACTS_POSITIONS_LONG.value == "") { alert("Please enter the narrative in the Facts / Positions section."); focusField = "CaseForm.FACTS_POSITIONS_LONG"; returnFalseFlag = false; }
					if (CaseForm.FORUM.value == "") { alert("In the Case Evaluation Checklist: Please enter the Forum in which the case is filed."); focusField = "CaseForm.FORUM"; returnFalseFlag = false; }
					if (CaseForm.CLIENT.value == "") { alert("In the Case Evaluation Checklist: Please enter the Client for this case."); focusField = "CaseForm.CLIENT"; returnFalseFlag = false; }

					checkLDOffcAltLDOffc();
					if (returnFalseFlag == false) { CaseForm.action = ""; if (focusField && focusField != "") eval(focusField).focus(); return false; }
					else return checkClaimCategorySelected();
				}

				function checkClaimCategorySelected() {
					var CLAIM_CATEGORY_Option = -1;
					if (CaseForm.CLAIM_CATEGORY) {
						for (var i = 0; i < CaseForm.CLAIM_CATEGORY.length; i++) { if (CaseForm.CLAIM_CATEGORY[i].checked) { CLAIM_CATEGORY_Option = i; break; } }
						if (CLAIM_CATEGORY_Option == -1) { alert("Please select a Category."); CaseForm.CLAIM_CATEGORY[0].focus(); return false; }
						else return checkASSESSMENT_PROBABILITY_Selected();
					} else return false;
				}

				function checkASSESSMENT_PROBABILITY_Selected() {
					var ASSESSMENT_PROBABILITY_Option = -1;
					if (CaseForm.ASSESSMENT_PROBABILITY) {
						for (var i = 0; i < CaseForm.ASSESSMENT_PROBABILITY.length; i++) { if (CaseForm.ASSESSMENT_PROBABILITY[i].checked) { ASSESSMENT_PROBABILITY_Option = i; break; } }
						if (ASSESSMENT_PROBABILITY_Option == -1) { alert("Please select a Probability."); CaseForm.ASSESSMENT_PROBABILITY[0].focus(); return false; }
						else { CaseForm.action = "InsertRecord.Action.cfm"; return true; }
					} else return false;
				}

				function checkLDOffcAltLDOffc() {
					if (CaseForm.LAW_DEPT_OFFICE.options[CaseForm.LAW_DEPT_OFFICE.selectedIndex].value != 0 && CaseForm.LAW_DEPT_OFFICE.options[CaseForm.LAW_DEPT_OFFICE.selectedIndex].value == CaseForm.ALT_LAW_DEPT_OFFICE.options[CaseForm.ALT_LAW_DEPT_OFFICE.selectedIndex].value) { alert("Law Dept Reporting Office and Alternate Law Dept Office must be different. Please change your selection(s)."); returnFalseFlag = false; }
				}

				function showDeterminingProbabilityDiv() { DeterminingProbabilityHeader.innerHTML = "<b>Assessment: Determining Probability</b>"; DeterminingProbabilityBox.style.background = "bfdfff"; DeterminingProbabilityBox.style.padding = "3pt"; DeterminingProbabilityBox.style.width = "100%"; DeterminingProbabilityDiv.style.display = "inline"; }
				function showFactsPositionsDiv() { FactsPositionsHeader.innerHTML = "<b>Facts/Positions: What to Include in Your Case Narrative</b>"; FactsPositionsBox.style.background = "ffd5aa"; FactsPositionsBox.style.padding = "3pt"; FactsPositionsBox.style.width = "100%"; FactsPositionsDiv.style.display = "inline"; }
			</script>

			<cfset ChecklistAnswerOptionsList = "1,2,0,9">
			<cfset ChecklistAnswerOptionsLabels = "Yes,No,Not Applicable,Unknown At This Time">
		</head>

		<body>
			<h2>
				<small><small>ATTORNEY WORK PRODUCT<br>U.S. Postal Service Law Department<br>Contingent Liabilities and Receivables</small></small>
				<p>Add New Case</p>
			</h2>

			<cfif IsDefined("Get_Indiv_User.PRIMARYKEY")>
				<cfquery name="Check_Atty" datasource="contliab">
					SELECT LAWDEPARTMENT.PRIMARYKEY, ldoffices.OFFICE_PRM_KEY
					FROM LAWDEPARTMENT, ldoffices
					WHERE LAWDEPARTMENT.OFFICE = ldoffices.OFFICE
					AND PRIMARYKEY = #Get_Indiv_User.PRIMARYKEY#
					AND (TITLE LIKE 'Deputy Managing%' OR title LIKE 'Attorney%' OR title LIKE 'Chief%' OR title LIKE 'Senior Counsel%' OR title LIKE 'Senior Litigation%' OR title LIKE 'Program Manager%' OR title LIKE 'Executive Program%')
				</cfquery>
				<cfif Check_Atty.RecordCount EQ 1>
					<cfset DefaultCounsel = Check_Atty.PRIMARYKEY>
					<cfset DefaultOffice = Check_Atty.OFFICE_PRM_KEY>
				</cfif>
			</cfif>

			<cfif AuthorizedFlag EQ "Yes">
				<div style="position: absolute; top: 20; right: 60; background:FFD5AA; padding:5pt; text-align:center">
					<p style="margin-top:3pt"><a href="Report.cfm"><b>Current Report</b></a></p>
				</div>
			</cfif>

			<blockquote>
				<div style="background:ccffcc; padding:10pt; width:75%"><cfinclude template="Instruc.Form.Requirements.cfm"></div>
			</blockquote>

			<cfquery name="EeList" datasource="contliab">SELECT * FROM VIEW_CONTING_EE_LIST</cfquery>

			<cfquery name="LDOffices" datasource="contliab">
				select DISTINCT office, OFFICE_PRM_KEY, DELETE_FLAG
				from ldoffices
				where trim(office) NOT LIKE 'Select%'
				  AND trim(office) NOT LIKE 'Law Department%'
				  AND trim(office) NOT LIKE '%List'
				  AND (OFFICE NOT LIKE 'Directories%'
					   AND OFFICE NOT LIKE '%Atlanta%'
					   AND OFFICE NOT LIKE '%Facilities%'
					   AND OFFICE NOT LIKE '%Environmental%'
					   AND OFFICE NOT LIKE '%General Counsel, HQ%'
					   AND OFFICE NOT LIKE '%Business Services%'
					   AND OFFICE NOT LIKE '%HQ Integration%')
				  AND DELETE_FLAG IS NULL
				order by office
			</cfquery>

			<cfform name="CaseForm" method="post" action="InsertRecord.Action.cfm">
				<table cellpadding="5" cellspacing="5" width="100%" style="margin-top:5pt" border="0">
					<tr>
						<th align="right" valign="top">Case Name</th>
						<td><cfinput type="text" name="CASE_NAME" size="65" maxlength="254" required="yes" message="Please enter the Case Name."></td>
					</tr>

					<tr>
						<th align="right" valign="top">Case Number</th>
						<td><input type="text" name="CASE_NUMBER" size="65" maxlength="254"></td>
					</tr>

					<tr>
						<th align="right" valign="top">Matter Number<div style="font-size:8pt; font-weight:normal; font-style:italic">(LawManager)</div></th>
						<td>
							<input type="text" name="LM_MATTER_NUMBER" size="65" maxlength="254">
							<div style="font-family:verdana; font-size:7.5pt; font-style:italic">Up to 11 characters. Leave blank if not applicable.</div>
						</td>
					</tr>

					<tr>
						<th align="right" valign="top">Case Type</th>
						<td><input type="radio" name="CASE_TYPE" value="1" checked> Liability &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="radio" name="CASE_TYPE" value="2"> Receivable</td>
					</tr>

					<tr>
						<th align="right" valign="top">Category</th>
						<td>
							<cfloop index="CLAIM_CATEGORY_Index" from="1" to="#ListLen(CLAIM_CATEGORY_Labels)#">
								<cfoutput><input type="radio" name="CLAIM_CATEGORY" value="#CLAIM_CATEGORY_Index#">&nbsp;#ListGetAt(CLAIM_CATEGORY_Labels, CLAIM_CATEGORY_Index)#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</cfoutput>
							</cfloop>
						</td>
					</tr>

					<tr>
						<th align="right" valign="top" style="padding-top:15pt; padding-bottom:15pt">District /<p style='margin-top:3pt'>Division /<p style='margin-top:3pt'>HQ&nbsp;Dept</th>
						<td style="padding-top:15pt; padding-bottom:15pt">
							<cfselect name="DIST_PERF_CLUSTER_CODE" style="font-family:arial; font-size:9pt; margin-top:2pt; margin-bottom:5pt; padding-bottom:1; background:khaki" size="1">
								<option value="0" style="color:white;background:maroon">Select a District . . .
								<cfinclude template="areas.districts.dropdown.FromTable.cfm">
							</cfselect>

							<cfif Get_Divisions.RecordCount GT 0>
								<cfset DropdownList = "Division">
								<br />
								<select name="DIVISION_CODE" style="font-family:arial; font-size:9pt; margin-top:2pt; margin-bottom:5pt; padding-bottom:1; background:khaki" size="1">
									<option value="0" style="color:white;background:maroon">Select a Division . . .
									<cfinclude template="areas.districts.dropdown.FromTable.cfm">
								</select>
							</cfif>

							<br>
							<select name="HQ_AREA_NAME" style="font-family:arial; font-size:9pt; margin-top:0pt; margin-bottom:5pt; padding-bottom:1; background:khaki" size="1" onChange="checkHQ_AREA_NAME(this)">
								<option value="0" style="color:white;background:maroon">Select a Headquarters Department . . .
								<cfinclude template="hq.dept.dropdown.FromTable.cfm">
							</select>
						</td>
					</tr>

					<tr id="Unions_Selected_Row" style="display:none; color:maroon">
						<th align="right" valign="top">Union(s)
							<div style="color:white; background:maroon; font-size:8pt; font-style:italic; padding:2pt">Select all that apply</div>
						</th>
						<td valign="top">
							<div style="background:ffffcc; width:70%; padding:5pt">
								<div id="Unions_List_Div" style="margin-bottom:10pt">
									<cfloop index="Unions_List_Loop_Index" from="1" to="#Unions_List_Loop_Max#">
										<cfset Unions_List_Loop_Start = ((Unions_List_Loop_Index - 1) * Unions_List_BreakPt) + 1>
										<cfset Unions_List_Loop_End = Unions_List_Loop_Index * Unions_List_BreakPt>
										<cfif Unions_List_Loop_End GT ListLen(Unions_List)>
											<cfset Unions_List_Loop_End = ListLen(Unions_List)>
										</cfif>
										<cfset Unions_List_Span_LeftOffset = (Unions_List_Loop_Index - 1) * Unions_List_Span_Width>
										<cfoutput><span id="Unions_List_Span_#Unions_List_Loop_Index#" style="width:#Unions_List_Span_Width#%; left:#Unions_List_Span_LeftOffset#pt; vertical-align:top"></span></cfoutput>
										<cfloop index="Unions_List_Index" from="#Unions_List_Loop_Start#" to="#Unions_List_Loop_End#">
											<cfoutput><input type="checkbox" name="Unions_Selected" value="#ListGetAt(Unions_List, Unions_List_Index)#">#ListGetAt(Unions_List, Unions_List_Index)#</cfoutput>
											<br />
										</cfloop>
									</cfloop>
									<input type="hidden" name="Unions_Selected_ALL" />
								</div>
							</div>
						</td>
					</tr>

					<tr>
						<th align="right" valign="top">Date Filed</th>
						<td>
							<input type="text" name="DATE_FILED" size="10" maxlength="10" style="width:60pt; height:14pt; text-align:right" value="" onClick="clearUnknown(this.name)" onBlur="checkDateAsTyped()">
							<img src="cal.gif" alt="Display Calendar" onClick="javascript:cal1.popup();">
							<small><i>(mm/dd/yyyy)</i></small>

							<cfloop index="DATE_FILED_UNKNOWN_Index" from="1" to="#ListLen(Unknown_NA_List)#">&nbsp;&nbsp;<cfoutput><input type="radio" name="DATE_FILED_UNKNOWN" value="#DATE_FILED_UNKNOWN_Index#">#ListGetAt(Unknown_NA_List, DATE_FILED_UNKNOWN_Index)#</cfoutput></cfloop>
						</td>
					</tr>

					<tr>
						<th align="right" valign="top">Amount Sought</th>
						<td>
							$<cfinput type="text" name="AMOUNT_SOUGHT" size="6" maxlength="8" style="width:38pt; height:14pt; text-align:right" onClick="clearUnknown(this.name)" onBlur="checkAmtAsTyped(this.name, 'Amount Sought')">&nbsp;Million
							<span id="AMOUNT_SOUGHT_RangeLink" style="margin-left:10pt; font-size:8pt; color:maroon">[<a href="" style="text-decoration:none" onClick="document.getElementById('AMOUNT_SOUGHT_HighEnd').style.display='inline'; document.getElementById('AMOUNT_SOUGHT_RangeLink').style.display='none'; return false">Range</a>]</span>
							<span id="AMOUNT_SOUGHT_HighEnd" style="margin-left:10pt; display:none"><b>High End:</b> $<cfinput type="text" name="AMOUNT_SOUGHT_UPPER" size="6" maxlength="8" style="width:38pt; height:14pt; text-align:right" onBlur="checkAmtAsTyped(this.name, 'Amount Sought / High End')">&nbsp;Million</span>

							<cfloop index="AMOUNT_SOUGHT_UNKNOWN_Index" from="1" to="#ListLen(Unknown_NA_List)#"><cfoutput><input type="radio" name="AMOUNT_SOUGHT_UNKNOWN" style="margin-left:15pt" value="#AMOUNT_SOUGHT_UNKNOWN_Index#">#ListGetAt(Unknown_NA_List, AMOUNT_SOUGHT_UNKNOWN_Index)#</cfoutput></cfloop>
							<cfset FormField = "Amount Sought">
							<cfinclude template="Instruc.Amount.cfm">
						</td>
					</tr>

					<tr>
						<th align="right" valign="top">Liability Assessment</th>
						<td><cfinput type="radio" name="ASSESSMENT_PROBABILITY" required="yes" message="Please select a choice for Liability Assessment." value="1">&nbsp;Probable&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<cfinput type="radio" name="ASSESSMENT_PROBABILITY" required="yes" message="Please select a choice for Liability Assessment." value="2">&nbsp;Reasonably Possible&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<cfinput type="radio" name="ASSESSMENT_PROBABILITY" required="yes" message="Please select a choice for Liability Assessment." value="3">&nbsp;Remote</td>
					</tr>

					<tr>
						<th align="right" valign="top">Damages Assessment</th>
						<td>
							<li><b>Most Likely Payout</b> $<cfinput type="text" name="ASSESSMENT_AMOUNT" size="6" maxlength="8" style="width:38pt; height:14pt; text-align:right" onClick="clearUnknown(this.name)" onBlur="checkAmtAsTyped(this.name, 'Damages Assessment')">&nbsp;Million
							<span id="ASSESSMENT_AMOUNT_RangeLink" style="margin-left:10pt; font-size:8pt; color:maroon">[<a href="" style="text-decoration:none" onClick="document.getElementById('ASSESSMENT_AMOUNT_HighEnd').style.display='inline'; document.getElementById('ASSESSMENT_AMOUNT_RangeLink').style.display='none'; return false">Range</a>]</span>
							<span id="ASSESSMENT_AMOUNT_HighEnd" style="margin-left:10pt; display:none"><b>High End:</b> $<cfinput type="text" name="ASSESSMENT_AMT_HIGH_END" size="6" maxlength="8" style="width:38pt; height:14pt; text-align:right" onBlur="checkAmtAsTyped(this.name, 'Most Likely Payout / High End')">&nbsp;Million</span>

							<span id="ASSESSMENT_AMOUNT_Most_Likely_UNKNOWN"><cfloop index="ASSESSMENT_AMT_Most_Likely_UNKNOWN_Index" from="1" to="1"><cfoutput><input type="radio" style="margin-left:15pt" name="ASSESSMENT_AMOUNT_UNKNOWN" value="#ASSESSMENT_AMT_Most_Likely_UNKNOWN_Index#">#ListGetAt(Unknown_NA_List, ASSESSMENT_AMT_Most_Likely_UNKNOWN_Index)#</cfoutput></cfloop></span>

							<p style="margin-top:8pt"></p>
							<li><b>Maximum Reasonable Payout</b> $<cfinput type="text" name="ASSESSMENT_AMOUNT_UPPER" size="6" maxlength="8" style="width:38pt; height:14pt; text-align:right" onBlur="checkAmtAsTyped(this.name, 'Maximum Reasonable Payout')">&nbsp;Million
							<span id="ASSESSMENT_AMOUNT_UPPER_RangeLink" style="margin-left:10pt; font-size:8pt; color:maroon">[<a href="" style="text-decoration:none" onClick="document.getElementById('ASSESSMENT_AMOUNT_UPPER_HighEnd').style.display='inline'; document.getElementById('ASSESSMENT_AMOUNT_UPPER_RangeLink').style.display='none'; return false">Range</a>]</span>
							<span id="ASSESSMENT_AMOUNT_UPPER_HighEnd" style="margin-left:10pt; display:none"><b>High End:</b> $<cfinput type="text" name="ASSESSMENT_AMT_UPPER_HIGH_END" size="6" maxlength="8" style="width:38pt; height:14pt; text-align:right" onBlur="checkAmtAsTyped(this.name, 'Most Likely Payout / High End')">&nbsp;Million</span>

							<span id="ASSESSMENT_AMT_MAX_UNKNOWN"><cfloop index="ASSESSMENT_AMT_MAX_UNKNOWN_Index" from="1" to="1"><cfoutput><input type="radio" style="margin-left:15pt" name="ASSESSMENT_AMT_MAX_UNKNOWN" value="#ASSESSMENT_AMT_MAX_UNKNOWN_Index#">#ListGetAt(Unknown_NA_List, ASSESSMENT_AMT_MAX_UNKNOWN_Index)#</cfoutput></cfloop></span>

							<p style="margin-top:5pt"></p>
							<cfset FormField = "Assessment Amount">
							<cfinclude template="Instruc.Amount.cfm">
							<input type="hidden" name="STATUS_CODE_SELECTED" value="1">
						</td>
					</tr>

					<tr>
						<th align="right" valign="top">Estimated Time to Resolution</th>
						<td>
							<cfset Estimated_Time_Resolution_ValueList_Ct = 1>
							<cfloop index="SHORT_TERM_LIABILITY_Index" list="#Estimated_Time_Resolution_ValueList#">
								<cfoutput><input type="radio" name="SHORT_TERM_LIABILITY" value="#SHORT_TERM_LIABILITY_Index#">&nbsp;#ListGetAt(Estimated_Time_Resolution_LabelList, Estimated_Time_Resolution_ValueList_Ct)#<br /></cfoutput>
								<cfset Estimated_Time_Resolution_ValueList_Ct = Estimated_Time_Resolution_ValueList_Ct + 1>
							</cfloop>
						</td>
					</tr>

					<tr>
						<th align="right" valign="top" style="padding-top:10pt">If&nbsp;Field&nbsp;Grievance, held in abeyance?</th>
						<td style="padding-top:10pt">
							<b>If this is a field grievance,</b> is it being held in abeyance pending resolution of a national-level dispute?<br />
							<cfloop index="YesNo_List_Index" list="#YesNo_List#">
								<cfoutput>
									<input type="radio" name="FIELD_GRIEVANCE_FLAG" value="#YesNo_List_Index#">
									<cfif YesNo_List_Index EQ "Y">Yes &nbsp;<b>>>></b>&nbsp;<i>Enter GATS Number of National-level Case:</i>
										<input type="text" name="NATL_GATS_NUMBER" size="40" maxlength="520" value="">
									<cfelseif YesNo_List_Index EQ "N">No
									<cfelseif YesNo_List_Index EQ "0">N/A
									</cfif>
								</cfoutput>
								<br />
							</cfloop>
						</td>
					</tr>

					<tr>
						<th align="right" valign="top" style="padding-top:10pt">Law Dept Counsel</th>
						<td style="padding-top:10pt">
							<cfselect name="COUNSEL_LAW_DEPT" style="font-family:arial; font-size:9pt; margin-top:0pt; margin-bottom:5pt; padding-bottom:1; background:BFDFFF" size="1" required="yes" message="Please select Law Dept Counsel.">
								<option value="0" style="color:white;background:6495ED">Select an attorney . . .
								<cfoutput query="EeList">
									<cfif IsDefined("DefaultCounsel")>
										<cfif PRIMARYKEY EQ Check_Atty.PRIMARYKEY>
											<option value="#PRIMARYKEY#" selected>#Trim(LASTNAME)#, #Trim(FIRSTNAME)#
										<cfelse>
											<option value="#PRIMARYKEY#">#Trim(LASTNAME)#, #Trim(FIRSTNAME)#
										</cfif>
									<cfelse>
										<option value="#PRIMARYKEY#">#Trim(LASTNAME)#, #Trim(FIRSTNAME)#
									</cfif>
								</cfoutput>
							</cfselect>
						</td>
					</tr>

					<tr>
						<th align="right" valign="top">Law Dept Co‑Counsel</th>
						<td>
							<select name="COCOUNSEL_LAW_DEPT" style="font-family:arial; font-size:9pt; margin-top:0pt; margin-bottom:5pt; padding-bottom:1; background:FFD5AA" size="1">
								<option value="0" style="color:white;background:chocolate">Select an employee . . .
								<cfoutput query="EeList">
									<option value="#PRIMARYKEY#">#Trim(LASTNAME)#, #Trim(FIRSTNAME)#
								</cfoutput>
							</select>
						</td>
					</tr>

					<tr>
						<th align="right" valign="top">Law Dept Reporting Office</th>
						<td>
							<cfselect name="LAW_DEPT_OFFICE" style="font-family:arial; font-size:9pt; margin-top:0pt; margin-bottom:5pt; padding-bottom:1; background:CCFFCC" size="1" required="yes" message="Please select Law Dept Reporting Office.">
								<option value="0" style="color:white;background:green">Select an office . . .
								<cfoutput query="LDOffices">
									<cfset TrimOFFICE = Trim(OFFICE)>
									<cfif Left(TrimOFFICE, 9) EQ "Southeast">
										<cfset TrimOFFICE = "Southeast">
									</cfif>
									<cfif IsDefined("DefaultOffice")>
										<cfif (IsDefined("Check_Atty.OFFICE_PRM_KEY") AND (OFFICE_PRM_KEY EQ Check_Atty.OFFICE_PRM_KEY OR (OFFICE_PRM_KEY EQ 5 AND Check_Atty.OFFICE_PRM_KEY EQ 2)) OR (IsDefined("Get_Auth_User_Office.OFFICE_PRM_KEY") AND OFFICE_PRM_KEY EQ Get_Auth_User_Office.OFFICE_PRM_KEY))>
											<option value="#OFFICE_PRM_KEY#" selected>#TrimOFFICE#
										<cfelse>
											<option value="#OFFICE_PRM_KEY#">#TrimOFFICE#
										</cfif>
									<cfelse>
										<option value="#OFFICE_PRM_KEY#">#TrimOFFICE#
									</cfif>
								</cfoutput>
							</cfselect>
						</td>
					</tr>

					<tr>
						<th align="right" valign="top">Alternate Law Dept Office<div style="font-size:8pt; font-weight:normal; font-style:italic">(Read-only access)</div></th>
						<td>
							<cfselect name="ALT_LAW_DEPT_OFFICE" style="font-family:arial; font-size:9pt; margin-top:0pt; margin-bottom:5pt; padding-bottom:1; background:66ccff" size="1">
								<option value="0" style="color:white; background:0099cc">Select an office . . .
								<cfoutput query="LDOffices">
									<cfset TrimOFFICE = Trim(OFFICE)>
									<cfif Left(TrimOFFICE, 9) EQ "Southeast">
										<cfset TrimOFFICE = "Southeast">
									</cfif>
									<option value="#OFFICE_PRM_KEY#">#TrimOFFICE#
								</cfoutput>
							</cfselect>
						</td>
					</tr>

					<tr>
						<th align="right" valign="top">Other Representative for USPS<div style="font-size:8pt; font-style:italic; font-weight:normal">(Non-Law Department)</div></th>
						<td><input type="text" name="COUNSEL_OTHER" size="65" maxlength="254"></td>
					</tr>

					<tr>
						<th align="right" valign="top">Facts / Positions<div style="font-size:8pt; font-style:italic; font-weight:normal">(Facts and status at the current time only)</div></th>
						<td><textarea name="FACTS_POSITIONS_LONG" rows="20" cols="70"></textarea></td>
					</tr>

					<tr>
						<th align="right" valign="top">Comment / Notes<div style="font-size:8pt; font-style:italic; font-weight:normal">(For Law Dept use only; 3,500 character limit)</div></th>
						<td><textarea name="COMMENT_GENERAL" rows="6" cols="50"></textarea></td>
					</tr>

					<tr>
						<td colspan="2">
							<hr>
							<h3>Case Evaluation Checklist</h3>
							<b>Forum</b>&nbsp;&nbsp;<input type="text" name="FORUM" size="65" maxlength="254"><p>
							<b>Client</b>&nbsp;&nbsp;<input type="text" name="CLIENT" size="65" maxlength="254"><p>

							<cfset StartQues_Arb = 19>
							<cfset EndQues_Arb = 20>
							<cfset StartQues_Tort = 21>
							<cfset EndQues_Tort = 32>
							<cfset StartQues_TortDeath = 33>
							<cfset EndQues_TortDeath = 37>

							<cfloop query="Get_ChecklistQues">
								<cfif SORTORDER EQ StartQues_Arb>
									<div class="quesSet" style="background:bfdfff"><cfoutput><i><b>If this is a national arbitration, Questions #StartQues_Arb# - #EndQues_Arb# must be answered.</b></i></cfoutput><p>
								<cfelseif SORTORDER EQ StartQues_Tort>
									<div class="quesSet" style="background:ccffcc"><cfoutput><i><b>If this is a tort matter, Questions #StartQues_Tort# - #EndQues_Tort# must be answered.</b></i></cfoutput><p>
								<cfelseif SORTORDER EQ StartQues_TortDeath>
									<div class="quesSet" style="background:ffd5aa"><cfoutput><i><b>If this is a tort death matter, Questions #StartQues_TortDeath# - #EndQues_TortDeath# must be answered.</b></i></cfoutput><p>
								</cfif>

								<cfoutput><b>#QUESNUM_TRIM#.</b> #QUESTEXT_TRIM#</cfoutput>

								<blockquote>
									<cfset ChecklistAnswerOptionsLabels_Counter = 0>
									<cfloop index="ChecklistAnswerOptionsList_Index" list="#ChecklistAnswerOptionsList#">
										<cfset ChecklistAnswerOptionsLabels_Counter = ChecklistAnswerOptionsLabels_Counter + 1>
										<cfif SORTORDER LT 19>
											<cfoutput><cfinput type="radio" name="ChecklistResponse_#QUESNUM_TRIM#" value="#ChecklistAnswerOptionsList_Index#" required="Yes" message="Please select an answer for Checklist Question #QUESNUM_TRIM#.">#ListGetAt(ChecklistAnswerOptionsLabels, ChecklistAnswerOptionsLabels_Counter)#<br></cfoutput>
										<cfelse>
											<cfoutput><cfinput type="radio" name="ChecklistResponse_#QUESNUM_TRIM#" value="#ChecklistAnswerOptionsList_Index#">#ListGetAt(ChecklistAnswerOptionsLabels, ChecklistAnswerOptionsLabels_Counter)#<br></cfoutput>
										</cfif>
									</cfloop>
								</blockquote>

								<cfif SORTORDER EQ EndQues_Arb OR SORTORDER EQ EndQues_Tort OR SORTORDER EQ EndQues_TortDeath>
									</div>
								</cfif>
							</cfloop>
						</td>
					</tr>

					<tr>
						<td></td>
						<td><input type="submit" value="Submit" onClick="return checkSelected(CaseForm)"></td>
					</tr>
				</table>
			</cfform>

			<script language="JavaScript">var cal1 = new calendar5(document.CaseForm.DATE_FILED);</script>
		</body>
	</html>



