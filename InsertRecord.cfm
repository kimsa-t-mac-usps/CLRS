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

if (amtFieldLabel == "Damages Assessment") clickUnk = '"Unknown."'
else clickUnk = '"Unknown"  or "N/A."'

alert('"' + amtFieldLabel + '"' + ' must be numeric value with up to one decimal place and without dollar sign or comma. If no numeric value, leave "' + amtFieldLabel + '" blank, and click ' + clickUnk);

thisAmtField = "CaseForm." + amtFieldName;

eval(thisAmtField).focus();

}

}


function validateAmtField(amtFieldName, amtFieldLabel) {

returnFalseFlag = true;

thisAmtField = "CaseForm." + amtFieldName;

thisAmtField_value = eval(thisAmtField).value

if (thisAmtField_value.substring(0,1) == ".") {

	thisAmtField_value = "0" + thisAmtField_value;
	eval(thisAmtField).value = thisAmtField_value;

}


/*
if (moneyPattern.test(eval(thisAmtField).value) && moneyDecimal.test(eval(thisAmtField).value))  {
*/

if (moneyPattern.test(eval(thisAmtField).value)) {
/*
alert("Value OK");
*/
/*
return true;
*/
}

else {


if (eval(thisAmtField).value != "") {
/*
alert(amtFieldLabel + " Value INVALID")
*/
/*
return false;
*/

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

if (datePattern_Yr2Digit.test(CaseForm.DATE_FILED.value)
|| datePattern_Yr4Digit.test(CaseForm.DATE_FILED.value)) {
/*
alert("Date Filed OK");
*/
/*
return true;
*/
}

else {

if (CaseForm.DATE_FILED.value != "") {
/*
alert("Date Filed INVALID")
*/
CaseForm.DATE_FILED.focus();
/*
return false;
*/
returnFalseFlag = false;
}

}

}



function clearUnknown(fieldName) {


thisUnkFormField = "CaseForm." + fieldName + "_UNKNOWN";

/*
alert("thisUnkFormField = " + thisUnkFormField);
alert("eval(thisUnkFormField).length = " + eval(thisUnkFormField).length);
*/


if (eval(thisUnkFormField).length) {

for (i=0; i < eval(thisUnkFormField).length; i++) eval(thisUnkFormField)[i].checked = false;

}

else {

if (eval(thisUnkFormField)) eval(thisUnkFormField).checked = false;

}



}








function showUnionsSelected(thisForm) {


//	alert("In showUnionsSelected");

	thisUnions_Selected = "";
	

// Concatenate Unions_Selected values


	if (thisForm.Unions_Selected) {
	
	
		if (thisForm.Unions_Selected.length) {

			for (i=0; i<thisForm.Unions_Selected.length; i++) {

				if (thisForm.Unions_Selected[i].checked) {
		
//					thisUnions_Selected = thisForm.Unions_Selected[i].value;

					if (thisUnions_Selected == "") thisUnions_Selected = thisForm.Unions_Selected[i].value;

					else thisUnions_Selected = thisUnions_Selected + "," + thisForm.Unions_Selected[i].value;
				
//					alert("thisUnions_Selected = " + thisUnions_Selected);

				}
		
			}

		}

		else {
		
			if (thisForm.Unions_Selected.value) thisUnions_Selected = thisForm.Unions_Selected.value;

		}

	}




//	alert("At end: thisUnions_Selected = " + thisUnions_Selected);


	thisForm.Unions_Selected_ALL.value = thisUnions_Selected;


//	alert("thisForm.Unions_Selected_ALL = " + thisForm.Unions_Selected_ALL.value);


	return true;


}






function checkSelected(CaseForm) {

/*
return validateDateField();
returnFalseFlag = true;
*/

// alert("In checkSelected");

showUnionsSelected(CaseForm); 




if (CaseForm.FIELD_GRIEVANCE_FLAG[0].checked && CaseForm.NATL_GATS_NUMBER.value == "") {

	alert("You have checked 'Yes,' indicating this is a Field Grievance pending resolution of a national-level case."
	+ "\r\n \r\n" +
	"Please enter the GATS Number of the national-level case.");
	CaseForm.NATL_GATS_NUMBER.focus();
	return false;

}






if (CaseForm.LM_MATTER_NUMBER.value.length > 11) {

	alert("LawManager Matter Number must be no longer than 11 characters.");
	CaseForm.LM_MATTER_NUMBER.focus();
	return false;

}



validateDateField();


<!---
if (CaseForm.DATE_FILED.value == "" && CaseForm.DATE_FILED_UNKNOWN.checked == false) {
	alert("Please enter Date Filed or check 'N/A' or 'Unknown.'");
	focusField = "CaseForm.DATE_FILED";
	returnFalseFlag = false;
	}
--->

DATE_FILED_UNKNOWN_Option = -1;

if (CaseForm.DATE_FILED_UNKNOWN && CaseForm.DATE_FILED_UNKNOWN.length) {

for (i=0; i<CaseForm.DATE_FILED_UNKNOWN.length; i++) {

	if (CaseForm.DATE_FILED_UNKNOWN[i].checked) {
		DATE_FILED_UNKNOWN_Option = i;
		break;
	}

}

}


if (DATE_FILED_UNKNOWN_Option == -1) {

if (CaseForm.DATE_FILED.value == "") {

	alert("Please enter Date Filed or check 'N/A' or 'Unknown.'");
	focusField = "CaseForm.DATE_FILED";
	returnFalseFlag = false;
}

}

else {

if (CaseForm.DATE_FILED.value != "") {

	alert("For Date Filed, 'N/A' or 'Unknown' is checked, but Date Filed value is also entered. Please correct: Click inside Date Filed field to un-check 'N/A' and 'Unknown.' Then if there is no Date Filed value, erase the value entered in Date Filed field and re-check 'N/A' or 'Unknown.'");
	focusField = "CaseForm.DATE_FILED";
	returnFalseFlag = false;
}


}




AMOUNT_SOUGHT_UNKNOWN_Option = -1;

if (CaseForm.AMOUNT_SOUGHT_UNKNOWN && CaseForm.AMOUNT_SOUGHT_UNKNOWN.length) {

for (i=0; i<CaseForm.AMOUNT_SOUGHT_UNKNOWN.length; i++) {

	if (CaseForm.AMOUNT_SOUGHT_UNKNOWN[i].checked) {
		AMOUNT_SOUGHT_UNKNOWN_Option = i;
		break;
	}

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
		alert("Most Likely Payout must be less than or equal to Maximum Reasonable Payout."
		+ "\r\n \r\n" +
		"Please revise.");
		focusField = "CaseForm.ASSESSMENT_AMOUNT";
		returnFalseFlag = false;
	}

}






}

else {

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




SHORT_TERM_LIABILITY_Option = -1;

if (CaseForm.SHORT_TERM_LIABILITY && CaseForm.SHORT_TERM_LIABILITY.length) {

for (i=0; i<CaseForm.SHORT_TERM_LIABILITY.length; i++) {

	if (CaseForm.SHORT_TERM_LIABILITY[i].checked) {
		SHORT_TERM_LIABILITY_Option = i;
		break;
	}

}

}


if (SHORT_TERM_LIABILITY_Option == -1) {

	alert("Please select Estimated Time to Resolution.");
/*
	focusField = "CaseForm.SHORT_TERM_LIABILITY[0]";
	returnFalseFlag = false;
*/

/* Must hard-code the focus, probably because eval of CaseForm.SHORT_TERM_LIABILITY[0] doesn't work: */
	CaseForm.SHORT_TERM_LIABILITY[0].focus();
	return false;


}





if (CaseForm.DIST_PERF_CLUSTER_CODE.value == "0" && CaseForm.HQ_AREA_NAME.value == "0") {
	alert("Please select a District or HQ Department.");
	focusField = "CaseForm.DIST_PERF_CLUSTER_CODE";
	returnFalseFlag = false;
	}


if (CaseForm.COUNSEL_LAW_DEPT.value == "0") {
	alert("Please select Law Dept Counsel.");
	focusField = "CaseForm.COUNSEL_LAW_DEPT";
	returnFalseFlag = false;
	}

if (CaseForm.LAW_DEPT_OFFICE.value == "0") {
	alert("Please select Law Dept Reporting Office.");
	focusField = "CaseForm.LAW_DEPT_OFFICE";
	returnFalseFlag = false;
	}

if (CaseForm.FACTS_POSITIONS_LONG.value == "") {
	alert("Please enter the narrative in the Facts / Positions section.");
	focusField = "CaseForm.FACTS_POSITIONS_LONG";
	returnFalseFlag = false;
	}

if (CaseForm.FORUM.value == "") {
	alert("In the Case Evaluation Checklist: Please enter the Forum in which the case is filed.");
	focusField = "CaseForm.FORUM";
	returnFalseFlag = false;
	}

if (CaseForm.CLIENT.value == "") {
	alert("In the Case Evaluation Checklist: Please enter the Client for this case.");
	focusField = "CaseForm.CLIENT";
	returnFalseFlag = false;
	}


/*
alert("returnFalseFlag = " + returnFalseFlag);
*/



checkLDOffcAltLDOffc();

if (returnFalseFlag==false) {
CaseForm.action = "";

if (focusField && focusField != "") eval(focusField).focus();

return false;
}

/*
else return checkASSESSMENT_PROBABILITY_Selected();
*/

else return checkClaimCategorySelected();

}


function checkClaimCategorySelected() {

CLAIM_CATEGORY_Option = -1;

if (CaseForm.CLAIM_CATEGORY) {

for (i=0; i<CaseForm.CLAIM_CATEGORY.length; i++) {

	if (CaseForm.CLAIM_CATEGORY[i].checked) {
		CLAIM_CATEGORY_Option = i;
		break;
	}

}

if (CLAIM_CATEGORY_Option == -1) {

	alert("Please select a Category.")
	CaseForm.CLAIM_CATEGORY[0].focus();
	return false;

}

else return checkASSESSMENT_PROBABILITY_Selected();

}

else return false;

}


function checkASSESSMENT_PROBABILITY_Selected() {

ASSESSMENT_PROBABILITY_Option = -1;

if (CaseForm.ASSESSMENT_PROBABILITY) {

for (i=0; i<CaseForm.ASSESSMENT_PROBABILITY.length; i++) {

	if (CaseForm.ASSESSMENT_PROBABILITY[i].checked) {
		ASSESSMENT_PROBABILITY_Option = i;
		break;
	}

}

if (ASSESSMENT_PROBABILITY_Option == -1) {

	alert("Please select a Probability.")
	CaseForm.ASSESSMENT_PROBABILITY[0].focus();
	return false;

}

else {
CaseForm.action = "InsertRecord.Action.cfm";
return true;
}

}

else return false;

}


function checkLDOffcAltLDOffc() {

if (CaseForm.LAW_DEPT_OFFICE.options[CaseForm.LAW_DEPT_OFFICE.selectedIndex].value != 0 && CaseForm.LAW_DEPT_OFFICE.options[CaseForm.LAW_DEPT_OFFICE.selectedIndex].value == CaseForm.ALT_LAW_DEPT_OFFICE.options[CaseForm.ALT_LAW_DEPT_OFFICE.selectedIndex].value) {
	alert("Law Dept Reporting Office and Alternate Law Dept Office must be different. Please change your selection(s).");
	returnFalseFlag = false;
	}

}



function showDeterminingProbabilityDiv() {

DeterminingProbabilityHeader.innerHTML = "<b>Assessment: Determining Probability</b>";

DeterminingProbabilityBox.style.background = "bfdfff";
DeterminingProbabilityBox.style.padding = "3pt";
DeterminingProbabilityBox.style.width="100%";

DeterminingProbabilityDiv.style.display = "inline";

}

function showFactsPositionsDiv() {

FactsPositionsHeader.innerHTML = "<b>Facts/Positions: What to Include in Your Case Narrative</b>";

FactsPositionsBox.style.background = "ffd5aa";
FactsPositionsBox.style.padding = "3pt";
FactsPositionsBox.style.width="100%";

FactsPositionsDiv.style.display = "inline";

}

</script>



<CFSET ChecklistAnswerOptionsList = "1,2,0,9">
<CFSET ChecklistAnswerOptionsLabels = "Yes,No,Not Applicable,Unknown At This Time">


</head>


<!---
<body onLoad="CaseForm.CASE_NAME.focus()">
--->

<body>

<h2>

<!---
<span style="color:red">TESTING ONLY</span>
<br>
--->

<small><small>
ATTORNEY WORK PRODUCT
<br>
U.S. Postal Service Law Department
<br>
Contingent Liabilities and Receivables
</small></small>
<p>
Add New Case

<!---
<span style="color:maroon; font-size:10pt">(Revised February 2009)</span>
--->

</h2>

<!---
<CFSET ThisPage = "InsertRecord">
<CFINCLUDE TEMPLATE="CFINCLUDEs/CheckUserAuth.cfm">
--->

<CFIF IsDefined("Get_Indiv_User.PRIMARYKEY")>

<CFQUERY NAME="Check_Atty" DATASOURCE="contliab">
SELECT LAWDEPARTMENT.PRIMARYKEY, ldoffices.OFFICE_PRM_KEY
FROM LAWDEPARTMENT, ldoffices
WHERE LAWDEPARTMENT.OFFICE = ldoffices.OFFICE
AND PRIMARYKEY = #Get_Indiv_User.PRIMARYKEY#
AND (TITLE LIKE 'Deputy Managing%'
OR title LIKE 'Attorney%'
OR title LIKE 'Chief%'
OR title LIKE 'Senior Counsel%'
OR title LIKE 'Senior Litigation%'
OR title LIKE 'Program Manager%'
OR title LIKE 'Executive Program%')

</cfquery>

<CFIF Check_Atty.RecordCount EQ 1>
	<CFSET DefaultCounsel = Check_Atty.PRIMARYKEY>
	<CFSET DefaultOffice = Check_Atty.OFFICE_PRM_KEY>
</cfif>

</cfif>

<CFIF AuthorizedFlag EQ "Yes">
<div style="position: absolute; top: 20; right: 60; background:FFD5AA; padding:5pt; text-align:center">
<p style="margin-top:3pt">
<a href="Report.full.cfm"><b>Current Report</b></a>
</div>
</cfif>

<!---
<CFINCLUDE TEMPLATE="CFINCLUDEs/areas.districts.arrays.cfm">
--->



<!--- For Report Date on or after 9/30/2011 (PostRedesignReportDate), use Redesign list of Areas, Districts: --->
<CFIF IsDefined("RptDate")>

	<CFSET ThisReportDateCompare = DateCompare(RptDate, PostRedesignReportDate)>

<CFELSE>

	<CFSET ThisReportDateCompare = DateCompare(ThisReportDate, PostRedesignReportDate)>

</CFIF>


<!---
<CFIF ThisReportDateCompare GE 0>

	<CFINCLUDE TEMPLATE="CFINCLUDEs/areas.districts.arrays.cfm">

<CFELSE>

	<CFINCLUDE TEMPLATE="CFINCLUDEs/areas.districts.arrays.20090617.cfm">

</CFIF>
--->


<blockquote>

<div style="background:ccffcc; padding:10pt; width:75%">


<CFINCLUDE TEMPLATE="Instruc.Form.Requirements.cfm">

</div>

</blockquote>



<CFQUERY NAME="EeList" DATASOURCE="contliab">
SELECT *
FROM VIEW_CONTING_EE_LIST
</cfquery>


<CFQUERY NAME="LDOffices" DATASOURCE="contliab">

<!---
SELECT *
FROM VIEW_CONTING_LDOFFICES_EXCL
where DELETE_FLAG IS NULL
--->

<!---
select office, OFFICE_PRM_KEY, DELETE_FLAG
from ldoffices
where OFFICE_PRM_KEY IN (SELECT OFFICE_PRM_KEY FROM VIEW_CONTING_LDOFFICES_INIT)
AND
(
OFFICE NOT LIKE '%Atlanta%'
AND
OFFICE NOT LIKE '%Facilities%'
AND
OFFICE NOT LIKE '%Environmental%'
AND
OFFICE NOT LIKE '%General Counsel, HQ%'
AND
OFFICE NOT LIKE '%Business Services%'
AND
OFFICE NOT LIKE '%HQ Integration%'
)


AND
DELETE_FLAG IS NULL


order by office
--->




select DISTINCT office, OFFICE_PRM_KEY, DELETE_FLAG
from ldoffices
where 

trim(office) NOT LIKE 'Select%' 

AND 
trim(office) NOT LIKE 'Law Department%' 

AND 
trim(office) NOT LIKE '%List' 



AND
(
OFFICE NOT LIKE 'Directories%'
AND
OFFICE NOT LIKE '%Atlanta%'
AND
OFFICE NOT LIKE '%Facilities%'
AND
OFFICE NOT LIKE '%Environmental%'
AND
OFFICE NOT LIKE '%General Counsel, HQ%'
AND
OFFICE NOT LIKE '%Business Services%'
AND
OFFICE NOT LIKE '%HQ Integration%'
)


AND
DELETE_FLAG IS NULL


order by office


</cfquery>



<!---
<cfform name="CaseForm" METHOD="POST" ACTION="InsertRecord.Action.cfm" onSubmit="return validateDateField()">
--->

<!---
OnSubmit does not work right in CF 8; shifted function to onClick of Submit button:
<cfform name="CaseForm" METHOD="POST" ACTION="InsertRecord.Action.cfm" onSubmit="return checkFieldGriev(this)">
--->


<cfform name="CaseForm" METHOD="POST" ACTION="InsertRecord.Action.cfm">

<table cellpadding="5" cellspacing="5" width="100%" style="margin-top:5pt" border=0>

<tr>

<th align="right" valign="top">
Case Name
</th>

<td>
<cfinput type="text" name="CASE_NAME" size="65"  maxlength="254" required="yes" message="Please enter the Case Name.">
</td>

</tr>

<tr>

<th align="right" valign="top">
Case Number
</th>

<td>
<input type="text" name="CASE_NUMBER" size="65"  maxlength="254">
</td>

</tr>



<tr>

<th align="right" valign="top">
<!---
<span style="color:red; font-size:9pt">[NEW]</span>&nbsp;
--->

Matter Number

<div style="font-size:8pt; font-weight:normal; font-style:italic">
(LawManager)
</div>

</th>

<td>
<input type="text" name="LM_MATTER_NUMBER" size="65"  maxlength="254">

<div style="font-family:verdana; font-size:7.5pt; font-style:italic">

Up to 11 characters. Leave blank if not applicable.

</div>

</td>

</tr>




<tr>

<th align="right" valign="top">
Case Type
</th>

<td>
<input type="radio" name="CASE_TYPE" value="1"  CHECKED>&nbsp;Liability&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="CASE_TYPE" value="2">&nbsp;Receivable
</td>

</tr>

<tr>

<th align="right" valign="top">
Category
</th>

<td>

<!---
<cfinput type="radio" name="CLAIM_CATEGORY" required="yes" message="Please select a Category." value="1">&nbsp;Business&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="CLAIM_CATEGORY" value="2">&nbsp;Labor&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="CLAIM_CATEGORY" value="3">&nbsp;Tort
--->

<CFLOOP INDEX="CLAIM_CATEGORY_Index" FROM="1" TO="#ListLen(CLAIM_CATEGORY_Labels)#">

<CFOUTPUT>
<input type="radio" name="CLAIM_CATEGORY" value="#CLAIM_CATEGORY_Index#">&nbsp;#ListGetAt(CLAIM_CATEGORY_Labels, CLAIM_CATEGORY_Index)#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</cfoutput>

</cfloop>




</td>

</tr>

<tr>

<th align="right" valign="top" style="padding-top:15pt; padding-bottom:15pt">
<!---
<span style="color:red; font-size:9pt">[NEW]</span>&nbsp;
--->

District /
<p style='margin-top:3pt'>
Division /
<p style='margin-top:3pt'>
HQ&nbsp;Dept

</th>

<td style="padding-top:15pt; padding-bottom:15pt">


<CFSELECT NAME="DIST_PERF_CLUSTER_CODE" style="font-family:arial; font-size:9pt; margin-top:2pt; margin-bottom:5pt; padding-bottom:1; background:khaki" SIZE="1">

<option value="0" style="color:white;background:maroon">Select a District . . .

<CFINCLUDE TEMPLATE="areas.districts.dropdown.FromTable.cfm">

</cfselect>


<!---
<div style="position:absolute; left:325pt; font-family:verdana; font-size:7.5pt; color:maroon; margin-top:2pt; margin-bottom:-13pt">
--->

<!---
padding-top:10pt;
--->


<!---
<div style="position:absolute; left:370pt; font-family:verdana; font-size:7.5pt; color:maroon; background:ffd5aa; margin-top:-2pt; margin-bottom:-13pt; padding:5pt; font-weight:bold">
Select the District / Division
<br>
or HQ Department
<br>
from which the case arose.
</div>
--->

<!---
</div>
--->



<CFIF Get_Divisions.RecordCount GT 0>

	<CFSET DropdownList = "Division">

	<br />
    

	<SELECT NAME="DIVISION_CODE" style="font-family:arial; font-size:9pt; margin-top:2pt; margin-bottom:5pt; padding-bottom:1; background:khaki" SIZE="1">

	<option value="0" style="color:white;background:maroon">Select a Division . . .

	<CFINCLUDE TEMPLATE="areas.districts.dropdown.FromTable.cfm">

	</select>

</CFIF>



<br>

<SELECT NAME="HQ_AREA_NAME" style="font-family:arial; font-size:9pt; margin-top:0pt; margin-bottom:5pt; padding-bottom:1; background:khaki" SIZE="1" onChange="checkHQ_AREA_NAME(this)">

<option value="0" style="color:white;background:maroon">Select a Headquarters Department . . .

<CFINCLUDE TEMPLATE="hq.dept.dropdown.FromTable.cfm">

</select>


</td>

</tr>








<tr id="Unions_Selected_Row" style="display:none; color:maroon">



<th align="right" valign="top">
Union(s)

<div style="color:white; background:maroon; font-size:8pt; font-style:italic; padding:2pt">
Select all that apply
</div>

</th>

<td valign="top">


<div style="background:ffffcc; width:70%; padding:5pt">



<!---
<CFSET Unions_List_ColLen_Max = 5>

<CFSET Unions_List_Width_TotalPct = 65>

<CFSET Unions_List_Loop_Max = Ceiling(ListLen(Unions_List) / Unions_List_ColLen_Max)>

<CFSET Unions_List_BreakPt =  Ceiling(ListLen(Unions_List) / Unions_List_Loop_Max)>

<CFSET Unions_List_Span_Width = Unions_List_Width_TotalPct / Unions_List_Loop_Max>
--->

<!---
<CFOUTPUT>
Unions_List_Loop_Max = #Unions_List_Loop_Max#
<br />
Unions_List_BreakPt = #Unions_List_BreakPt#
<br />
Unions_List_Span_Width = #Unions_List_Span_Width#
<p>
</CFOUTPUT>
--->


<div id="Unions_List_Div" style="margin-bottom:10pt">



<CFLOOP INDEX="Unions_List_Loop_Index" FROM="1" TO="#Unions_List_Loop_Max#">

<CFSET Unions_List_Loop_Start = ((Unions_List_Loop_Index - 1) * Unions_List_BreakPt) + 1>

<CFSET Unions_List_Loop_End = Unions_List_Loop_Index * Unions_List_BreakPt>

<CFIF Unions_List_Loop_End GT ListLen(Unions_List)>
	<CFSET Unions_List_Loop_End = ListLen(Unions_List)>
</CFIF>

<CFSET Unions_List_Span_LeftOffset = (Unions_List_Loop_Index - 1) * Unions_List_Span_Width>


<CFOUTPUT>
<span id="Unions_List_Span_#Unions_List_Loop_Index#" style="width:#Unions_List_Span_Width#%; left:#Unions_List_Span_LeftOffset#pt; vertical-align:top">
</cfoutput>


<CFLOOP INDEX="Unions_List_Index" FROM="#Unions_List_Loop_Start#" TO="#Unions_List_Loop_End#">

<CFOUTPUT>
<input type="checkbox" name="Unions_Selected" value="#ListGetAt(Unions_List, Unions_List_Index)#">#ListGetAt(Unions_List, Unions_List_Index)#
</CFOUTPUT>

<br />

</CFLOOP>


</span>


</CFLOOP>



<input type="hidden" name="Unions_Selected_ALL" />


</div id="Unions_List_Div">


</div>


</td>


</tr>


















<tr>

<th align="right" valign="top">
Date Filed
</th>

<td>

<input type="text" name="DATE_FILED" size="10" maxlength="10" style="width:60pt; height:14pt; text-align:right" value="" onClick="clearUnknown(this.name)" onBlur="checkDateAsTyped()">


<!---
<input type="text" name="DATE_FILED" size="10" maxlength="10" style="width:60pt;height:14pt" value="" onClick="clearUnknown()">
--->

<img src="cal.gif" alt="Display Calendar" onClick="javascript:cal1.popup();">

<small><i>(mm/dd/yyyy)</i></small>



<CFLOOP INDEX="DATE_FILED_UNKNOWN_Index" FROM="1" TO="#ListLen(Unknown_NA_List)#">

&nbsp;&nbsp;

<CFOUTPUT>
<input type="radio" name="DATE_FILED_UNKNOWN" value="#DATE_FILED_UNKNOWN_Index#">#ListGetAt(Unknown_NA_List, DATE_FILED_UNKNOWN_Index)#
</cfoutput>

</cfloop>




</td>

</tr>

<tr>

<th align="right" valign="top">
Amount Sought
</th>

<td>
$<cfinput type="text" name="AMOUNT_SOUGHT" size="6" maxlength="8" style="width:38pt; height:14pt; text-align:right"  onClick="clearUnknown(this.name)" onBlur="checkAmtAsTyped(this.name, 'Amount Sought')">&nbsp;Million


<span id="AMOUNT_SOUGHT_RangeLink" style="margin-left:10pt; font-size:8pt; color:maroon">
[<a href="" style="text-decoration:none" onClick="document.getElementById('AMOUNT_SOUGHT_HighEnd').style.display='inline'; document.getElementById('AMOUNT_SOUGHT_RangeLink').style.display='none'; return false">Range</a>]
</span>

<span id="AMOUNT_SOUGHT_HighEnd" style="margin-left:10pt; display:none">
<b>High End:</b> $<cfinput type="text" name="AMOUNT_SOUGHT_UPPER" size="6" maxlength="8" style="width:38pt; height:14pt; text-align:right" onBlur="checkAmtAsTyped(this.name, 'Amount Sought / High End')">&nbsp;Million
</span>



<CFLOOP INDEX="AMOUNT_SOUGHT_UNKNOWN_Index" FROM="1" TO="#ListLen(Unknown_NA_List)#">

<CFOUTPUT>
<input type="radio" name="AMOUNT_SOUGHT_UNKNOWN" style="margin-left:15pt" value="#AMOUNT_SOUGHT_UNKNOWN_Index#">#ListGetAt(Unknown_NA_List, AMOUNT_SOUGHT_UNKNOWN_Index)#
</cfoutput>

</cfloop>

<!---
<div style="font-family:verdana; font-size:7.5pt; font-style:italic">
Enter amount(s) with up to one decimal place and no comma.
<br>
If less than $1 Million, use decimal amount. E.g., for <b>$400,000</b>, use <b><u>0</u>.4</b>
</div>
--->

<CFSET FormField = "Amount Sought">
<CFINCLUDE TEMPLATE="Instruc.Amount.cfm">


</td>

</tr>

<tr>

<th align="right" valign="top">
<!---
<a href="#DeterminingProbabilityBkMark" onClick="showDeterminingProbabilityDiv()"><img src="info.darkgreen.gif" width="28" height="18" border="0" style="vertical-align:middle; margin-right:5pt" alt="Click for details"></a>
--->

<!---
<span style="color:red; font-size:9pt">[NEW]</span>&nbsp;
--->

Liability Assessment

</th>

<td>
<cfinput type="radio" name="ASSESSMENT_PROBABILITY" required="yes" message="Please select a choice for Liability Assessment." value="1">&nbsp;Probable&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<cfinput type="radio" name="ASSESSMENT_PROBABILITY" required="yes" message="Please select a choice for Liability Assessment." value="2">&nbsp;Reasonably Possible&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<cfinput type="radio" name="ASSESSMENT_PROBABILITY" required="yes" message="Please select a choice for Liability Assessment." value="3">&nbsp;Remote
</td>

</tr>

<tr>

<th align="right" valign="top">

<!---
<span style="color:red; font-size:9pt">[NEW]</span>&nbsp;
--->

Damages
Assessment

</th>

<td>

<li><b>Most Likely Payout</b> $<cfinput type="text" name="ASSESSMENT_AMOUNT" size="6" maxlength="8" style="width:38pt; height:14pt; text-align:right" onClick="clearUnknown(this.name)" onBlur="checkAmtAsTyped(this.name, 'Damages Assessment')">&nbsp;Million


<span id="ASSESSMENT_AMOUNT_RangeLink" style="margin-left:10pt; font-size:8pt; color:maroon">
[<a href="" style="text-decoration:none" onClick="document.getElementById('ASSESSMENT_AMOUNT_HighEnd').style.display='inline'; document.getElementById('ASSESSMENT_AMOUNT_RangeLink').style.display='none'; return false">Range</a>]
</span>

<span id="ASSESSMENT_AMOUNT_HighEnd" style="margin-left:10pt; display:none">
<b>High End:</b> $<cfinput type="text" name="ASSESSMENT_AMT_HIGH_END" size="6" maxlength="8" style="width:38pt; height:14pt; text-align:right" onBlur="checkAmtAsTyped(this.name, 'Most Likely Payout / High End')">&nbsp;Million
</span>




<span id="ASSESSMENT_AMOUNT_Most_Likely_UNKNOWN">

<CFLOOP INDEX="ASSESSMENT_AMT_Most_Likely_UNKNOWN_Index" FROM="1" TO="1">

<CFOUTPUT>

<input type="radio" style="margin-left:15pt" name="ASSESSMENT_AMOUNT_UNKNOWN" value="#ASSESSMENT_AMT_Most_Likely_UNKNOWN_Index#">#ListGetAt(Unknown_NA_List, ASSESSMENT_AMT_Most_Likely_UNKNOWN_Index)#

</cfoutput>

</cfloop>

</span>

<p style="margin-top:8pt">

<li><b>Maximum Reasonable Payout</b> $<cfinput type="text" name="ASSESSMENT_AMOUNT_UPPER" size="6" maxlength="8" style="width:38pt; height:14pt; text-align:right" onBlur="checkAmtAsTyped(this.name, 'Maximum Reasonable Payout')">&nbsp;Million



<span id="ASSESSMENT_AMOUNT_UPPER_RangeLink" style="margin-left:10pt; font-size:8pt; color:maroon">
[<a href="" style="text-decoration:none" onClick="document.getElementById('ASSESSMENT_AMOUNT_UPPER_HighEnd').style.display='inline'; document.getElementById('ASSESSMENT_AMOUNT_UPPER_RangeLink').style.display='none'; return false">Range</a>]
</span>

<span id="ASSESSMENT_AMOUNT_UPPER_HighEnd" style="margin-left:10pt; display:none">
<b>High End:</b> $<cfinput type="text" name="ASSESSMENT_AMT_UPPER_HIGH_END" size="6" maxlength="8" style="width:38pt; height:14pt; text-align:right" onBlur="checkAmtAsTyped(this.name, 'Most Likely Payout / High End')">&nbsp;Million
</span>


<span id="ASSESSMENT_AMT_MAX_UNKNOWN">

<CFLOOP INDEX="ASSESSMENT_AMT_MAX_UNKNOWN_Index" FROM="1" TO="1">

<CFOUTPUT>

<input type="radio" style="margin-left:15pt" name="ASSESSMENT_AMT_MAX_UNKNOWN" value="#ASSESSMENT_AMT_MAX_UNKNOWN_Index#">#ListGetAt(Unknown_NA_List, ASSESSMENT_AMT_MAX_UNKNOWN_Index)#

</cfoutput>

</cfloop>

</span>


<p style="margin-top:5pt">


<CFSET FormField = "Assessment Amount">
<CFINCLUDE TEMPLATE="Instruc.Amount.cfm">


<!---
<input type="hidden" name="STATUS_CODE" value="1">
--->

<input type="hidden" name="STATUS_CODE_SELECTED" value="1">

</td>

</tr>


<tr>

<th align="right" valign="top">

<!---
<span style="color:red; font-size:9pt">[NEW]</span>&nbsp;
--->

Estimated
Time to Resolution

</th>

<td>

<CFSET Estimated_Time_Resolution_ValueList_Ct = 1>

<CFLOOP INDEX="SHORT_TERM_LIABILITY_Index" LIST="#Estimated_Time_Resolution_ValueList#">

<CFOUTPUT>

<input type="radio" name="SHORT_TERM_LIABILITY" value="#SHORT_TERM_LIABILITY_Index#">&nbsp;#ListGetAt(Estimated_Time_Resolution_LabelList, Estimated_Time_Resolution_ValueList_Ct)#
<br />

</cfoutput>

<CFSET Estimated_Time_Resolution_ValueList_Ct = Estimated_Time_Resolution_ValueList_Ct + 1>

</cfloop>



<tr>


<CFOUTPUT>
<th align="right" valign="top" style="padding-top:10pt">
</CFOUTPUT>

<!---
<span style="color:red; font-size:9pt">[NEW]</span>
--->

If&nbsp;Field&nbsp;Grievance, held in abeyance?


<td style="padding-top:10pt">

<b>If this is a field grievance,</b> is it being held in abeyance pending resolution of a national-level dispute?

<br />


<CFLOOP INDEX="YesNo_List_Index" LIST="#YesNo_List#">


<CFOUTPUT>
<input type="radio" name="FIELD_GRIEVANCE_FLAG" value="#YesNo_List_Index#">

<CFIF YesNo_List_Index EQ "Y">
Yes

&nbsp;<b>>>></b>&nbsp;

<i><i>Enter GATS Number of National-level Case:</i></i>

<input type="text" name="NATL_GATS_NUMBER" size="40"  maxlength="520" value="">


<CFELSEIF YesNo_List_Index EQ "N">
No

<CFELSEIF YesNo_List_Index EQ "0">
N/A

</cfif>

</CFOUTPUT>

<br />

</CFLOOP>

<!---
&nbsp;<b>>>></b>&nbsp;

<i><i>Enter GATS Number of National-level Case:</i></i>

<input type="text" name="NATL_GATS_NUMBER" size="40"  maxlength="520" value="">
--->


<tr>

<th align="right" valign="top" style="padding-top:10pt">
Law Dept Counsel
</th>

<td style="padding-top:10pt">

<CFSELECT NAME="COUNSEL_LAW_DEPT" style="font-family:arial; font-size:9pt; margin-top:0pt; margin-bottom:5pt; padding-bottom:1; background:BFDFFF" SIZE="1" required="yes" message="Please select Law Dept Counsel.">

<option value="0" style="color:white;background:6495ED">Select an attorney . . .

<CFOUTPUT QUERY="EeList">

<CFIF IsDefined("DefaultCounsel")>

<CFIF PRIMARYKEY EQ Check_Atty.PRIMARYKEY>
	<option value="#PRIMARYKEY#" SELECTED>#Trim(LASTNAME)#, #Trim(FIRSTNAME)#
<CFELSE>
	<option value="#PRIMARYKEY#">#Trim(LASTNAME)#, #Trim(FIRSTNAME)#
</cfif>

<CFELSE>
<option value="#PRIMARYKEY#">#Trim(LASTNAME)#, #Trim(FIRSTNAME)#

</cfif>

</cfoutput>

</cfselect>

</td>

</tr>

<tr>

<th align="right" valign="top">
Law Dept Co&#8209;Counsel
</th>

<td>

<SELECT NAME="COCOUNSEL_LAW_DEPT" style="font-family:arial; font-size:9pt; margin-top:0pt; margin-bottom:5pt; padding-bottom:1; background:FFD5AA" SIZE="1">

<option value="0" style="color:white;background:chocolate">Select an employee . . .

<CFOUTPUT QUERY="EeList">
<option value="#PRIMARYKEY#">#Trim(LASTNAME)#, #Trim(FIRSTNAME)#
</cfoutput>

</select>

</td>

</tr>

<tr>

<th align="right" valign="top">
Law Dept Reporting Office
</th>

<td>


<CFSELECT NAME="LAW_DEPT_OFFICE" style="font-family:arial; font-size:9pt; margin-top:0pt; margin-bottom:5pt; padding-bottom:1; background:CCFFCC" SIZE="1" required="yes" message="Please select Law Dept Reporting Office.">

<option value="0" style="color:white;background:green">Select an office . . .

<CFOUTPUT QUERY="LDOffices">

<CFSET TrimOFFICE = Trim(OFFICE)>

<CFIF Left(TrimOFFICE, 9) EQ "Southeast">
	<CFSET TrimOFFICE = "Southeast">
</cfif>

<CFIF IsDefined("DefaultOffice")>

<!--- Atlanta PRM_KEY = 2; Memphis = 5
--->

<CFIF (IsDefined("Check_Atty.OFFICE_PRM_KEY") AND (OFFICE_PRM_KEY EQ Check_Atty.OFFICE_PRM_KEY OR (OFFICE_PRM_KEY EQ 5 AND Check_Atty.OFFICE_PRM_KEY EQ 2)) OR (IsDefined("Get_Auth_User_Office.OFFICE_PRM_KEY") AND OFFICE_PRM_KEY EQ Get_Auth_User_Office.OFFICE_PRM_KEY))>

	<option value="#OFFICE_PRM_KEY#" SELECTED>#TrimOFFICE#
<CFELSE>
	<option VALUE="#OFFICE_PRM_KEY#">#TrimOFFICE#
</cfif>

<CFELSE>
<option VALUE="#OFFICE_PRM_KEY#">#TrimOFFICE#

</cfif>

</cfoutput>


</cfselect>

</div>

</td>

</tr>

<tr>

<th align="right" valign="top">
Alternate Law Dept Office

<div style="font-size:8pt; font-weight:normal; font-style:italic">
(Read-only access)
</div>

</th>

<td>


<CFSELECT NAME="ALT_LAW_DEPT_OFFICE" style="font-family:arial; font-size:9pt; margin-top:0pt; margin-bottom:5pt; padding-bottom:1; background:66ccff" SIZE="1">

<option value="0" style="color:white; background:0099cc">Select an office . . .

<CFOUTPUT QUERY="LDOffices">

<CFSET TrimOFFICE = Trim(OFFICE)>

<CFIF Left(TrimOFFICE, 9) EQ "Southeast">
	<CFSET TrimOFFICE = "Southeast">
</cfif>

<!---
<CFIF IsDefined("DefaultOffice")>

<CFIF (IsDefined("Check_Atty.OFFICE_PRM_KEY") AND (OFFICE_PRM_KEY EQ Check_Atty.OFFICE_PRM_KEY OR (OFFICE_PRM_KEY EQ 5 AND Check_Atty.OFFICE_PRM_KEY EQ 2)) OR (IsDefined("Get_Auth_User_Office.OFFICE_PRM_KEY") AND OFFICE_PRM_KEY EQ Get_Auth_User_Office.OFFICE_PRM_KEY))>

	<option value="#OFFICE_PRM_KEY#" SELECTED>#TrimOFFICE#
<CFELSE>
	<option VALUE="#OFFICE_PRM_KEY#">#TrimOFFICE#
</cfif>

<CFELSE>
<option VALUE="#OFFICE_PRM_KEY#">#TrimOFFICE#

</cfif>
--->

<option VALUE="#OFFICE_PRM_KEY#">#TrimOFFICE#


</cfoutput>


</cfselect>

</div>

</td>

</tr>

<tr>

<th align="right" valign="top">
Other Representative for USPS

<div style="font-size:8pt; font-style:italic; font-weight:normal">
(Non-Law Department)
</div>

</th>

<td>
<input type="text" name="COUNSEL_OTHER" size="65"  maxlength="254">
</td>

</tr>

<tr>

<th align="right" valign="top">
<!---
<a href="#FactsPositionsHeaderBkMark" onClick="showFactsPositionsDiv()"><img src="info.darkgreen.gif" width="28" height="18" border="0" style="vertical-align:middle; margin-right:5pt" alt="Click for details"></a>
--->

Facts / Positions

<div style="font-size:8pt; font-style:italic; font-weight:normal">
(Facts and status at the current time only)
</div>

</th>

<td>
<textarea name="FACTS_POSITIONS_LONG" rows="20" cols="70"></textarea>
</td>

</tr>








<tr>

<th align="right" valign="top">
Comment / Notes

<div style="font-size:8pt; font-style:italic; font-weight:normal">
(For Law Dept use only; 3,500 character limit)
</div>

</th>

<td>
<textarea name="COMMENT_GENERAL" rows="6" cols="50"></textarea>
</td>

</tr>

<tr>
<td colspan="2">
<hr>


<h3>Case Evaluation Checklist</h3>

<b>Forum</b>&nbsp;&nbsp;<input type="text" name="FORUM" size="65"  maxlength="254">
<p>
<b>Client</b>&nbsp;&nbsp;<input type="text" name="CLIENT" size="65"  maxlength="254">
<p>

<!---
<CFQUERY NAME="Get_ChecklistQues" DATASOURCE="contliab">
SELECT TRIM(QUESNUM) AS QUESNUM_TRIM, QUESTEXT, SORTORDER
FROM PCESSURVEYQUES
WHERE SURVEY LIKE 'Conting Liability Checklist%'
ORDER BY SORTORDER
</cfquery>
--->

<!---
<CFQUERY NAME="Get_ChecklistQues" DATASOURCE="contliab">
SELECT *
FROM VIEW_CONTING_GET_CHECKLISTQUES
</cfquery>
--->

<CFSET StartQues_Arb = 19>
<CFSET EndQues_Arb = 20>

<CFSET StartQues_Tort = 21>
<CFSET EndQues_Tort = 32>

<CFSET StartQues_TortDeath = 33>
<CFSET EndQues_TortDeath = 37>

<CFLOOP QUERY="Get_ChecklistQues">

<!---
<CFSET TrimQUESNUM = Trim(QUESNUM)>
--->

<CFIF SORTORDER EQ StartQues_Arb>

<div class="quesSet" style="background:bfdfff">
<CFOUTPUT>
<i><b>If this is a national arbitration, Questions #StartQues_Arb# - #EndQues_Arb# must be answered.</b></i>
</cfoutput>

<p>

<CFELSEIF SORTORDER EQ StartQues_Tort>

<div class="quesSet" style="background:ccffcc">
<CFOUTPUT>
<i><b>If this is a tort matter, Questions #StartQues_Tort# - #EndQues_Tort# must be answered.</b></i>
</cfoutput>

<p>

<CFELSEIF SORTORDER EQ StartQues_TortDeath>

<div class="quesSet" style="background:ffd5aa">
<CFOUTPUT>
<i><b>If this is a tort death matter, Questions #StartQues_TortDeath# - #EndQues_TortDeath# must be answered.</b></i>
</cfoutput>

<p>

</cfif>


<CFOUTPUT>
<!---
<b>#QUESNUM_TRIM#.</b> #Trim(QUESTEXT)#
--->

<b>#QUESNUM_TRIM#.</b> #QUESTEXT_TRIM#

</cfoutput>

<!---
<blockquote>
<CFOUTPUT>
<input type="radio" name="ChecklistResponse_#TrimQUESNUM#" value="1">Yes<br>
<input type="radio" name="ChecklistResponse_#TrimQUESNUM#" value="2">No<br>
<input type="radio" name="ChecklistResponse_#TrimQUESNUM#" value="0">Not Applicable<br>
<input type="radio" name="ChecklistResponse_#TrimQUESNUM#" value="9">Unknown At This Time
</cfoutput>
</blockquote>
--->

<blockquote>

<CFSET ChecklistAnswerOptionsLabels_Counter = 0>




<CFLOOP INDEX="ChecklistAnswerOptionsList_Index" LIST="#ChecklistAnswerOptionsList#">

<CFSET ChecklistAnswerOptionsLabels_Counter = ChecklistAnswerOptionsLabels_Counter + 1>

<CFIF SORTORDER LT 19>

<CFOUTPUT>
<CFINPUT type="radio" name="ChecklistResponse_#QUESNUM_TRIM#" value="#ChecklistAnswerOptionsList_Index#" required="Yes" message="Please select an answer for Checklist Question #QUESNUM_TRIM#.">#ListGetAt(ChecklistAnswerOptionsLabels, ChecklistAnswerOptionsLabels_Counter)#<br>
</cfoutput>

<CFELSE>

<CFOUTPUT>
<CFINPUT type="radio" name="ChecklistResponse_#QUESNUM_TRIM#" value="#ChecklistAnswerOptionsList_Index#">#ListGetAt(ChecklistAnswerOptionsLabels, ChecklistAnswerOptionsLabels_Counter)#<br>
</cfoutput>

</cfif>

</cfloop>

</blockquote>


<CFIF SORTORDER EQ EndQues_Arb OR SORTORDER EQ EndQues_Tort OR SORTORDER EQ EndQues_TortDeath>
</div>
</cfif>

</cfloop>

</td>

</tr>

<tr>

<!---
<td colspan="2">
<div align="center" style="margin-top:30pt"><center><input TYPE="SUBMIT" VALUE="Submit"></div>
</td>
--->

<td>
</td>

<td>

<!---
<input TYPE="SUBMIT" VALUE="Submit" onClick="return showUnionsSelected(this); return checkSelected()">
--->


<input TYPE="SUBMIT" VALUE="Submit" onClick="return checkSelected(CaseForm)">



</td>

</tr>

</table>

</cfform>


<script language="JavaScript">
var cal1 = new calendar5(document.CaseForm.DATE_FILED);
</script>

</body>


</html>



