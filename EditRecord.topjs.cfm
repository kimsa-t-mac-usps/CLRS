<cfinclude template="MfaCookieCheck.cfm">

<script language="JavaScript">


returnFalseFlag = true;


updFactsFlagArray = new Array();

chgFieldList = new Array();

thisChgFieldString = "";


datePattern_Yr2Digit = /\d{1,2}\/\d{1,2}\/\d{2}$/

datePattern_Yr4Digit = /\d{1,2}\/\d{1,2}\/\d{4}$/

/*
moneyPattern = /\d+/
moneyPattern_Exclude = /\D+/
*/

moneyPattern = /^\d+\.?\d?$/

removeConf = "";

/*
prevButtonValue = 0;
*/


function uncheckNoChange(checkboxValue) {


if (checkboxValue != 2) CaseForm_1.STATUS_CODE[0].checked = false;
	
else {

	if (checkboxValue == 2) {

		for (i=1; i<CaseForm_1.STATUS_CODE.length; i++) {
			if (CaseForm_1.STATUS_CODE[i].checked) {
				CaseForm_1.STATUS_CODE[0].checked = false;
			}
		}
	
	}
	
}
	
/*
hideShowButton('#HideShowButton_String#', #CONTINGENT_LIAB_GetRecord.CurrentRow#, this.value)



	if (thisForm.STATUS_CODE && thisForm.STATUS_CODE.value == 1) thisSTATUS_CODE = thisForm.STATUS_CODE.value

	else {

	for (i=0; i<CaseForm_1.STATUS_CODE.length; i++) {
		if (CaseForm_1.STATUS_CODE[i].checked) {
		
			thisSTATUS_CODE = CaseForm_1.STATUS_CODE[i].value;




function clearUnknown(formNumber, fieldName, fieldLabel) {

if (document.getElementById("STATUS_CODE_2")) document.getElementById("STATUS_CODE_2").checked = false;


thisFormField = "CaseForm_" + formNumber + "." + fieldName + "_UNKNOWN";

if (eval(thisFormField).length) {

	for (i=0; i < eval(thisFormField).length; i++) eval(thisFormField)[i].checked = false;

}

else {

if (eval(thisFormField)) eval(thisFormField).checked = false;

}

promptUpdateFacts(fieldLabel);

}
*/	
	
	
	
}









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


function checkStatusCodePayoutInfo(thisForm) {

/*
alert("In checkStatusCodePayoutInfo");
*/

if (returnFalseFlag == false) fcnRemoveConf = false;
else fcnRemoveConf = true;


	if (thisForm.STATUS_CODE && thisForm.STATUS_CODE.value == 1) thisSTATUS_CODE = thisForm.STATUS_CODE.value

	else {

	for (i=0; i<thisForm.STATUS_CODE.length; i++) {
		if (thisForm.STATUS_CODE[i].checked) {
		
			thisSTATUS_CODE = thisForm.STATUS_CODE[i].value;


		if (thisSTATUS_CODE == 4) {
		
			if (thisForm.ASSESSMENT_AMOUNT_UPPER.value < 1) {
	
			//alert('Selected Status option says "Still Meets Threshold," but Max Reasonable Payout (' + thisForm.ASSESSMENT_AMOUNT_UPPER.value + ' Million)' + '\r\n' + 'is BELOW reporting threshold of $1 Million.' + '\r\n \r\n' + 'Please revise Max Reasonable Payout or change Status option to "Reassessed; No Longer Meets Threshold."');

			thisForm.ASSESSMENT_AMOUNT_UPPER.focus();

			document.getElementById("StillMeetsThresholdNote").style.background = "maroon"; 
			
			document.getElementById("StillMeetsThresholdNote").style.color = "white"; 
			
			document.getElementById("StillMeetsThresholdNote").style.padding = "2pt";

			document.getElementById("StillMeetsThresholdNote").style.fontWeight = "bold";

			returnFalseFlag = false;

			fcnRemoveConf = false;

			return false;
		
			}

		}







		}

	}

	}


//	alert("thisSTATUS_CODE = " + thisSTATUS_CODE);



//	if (thisForm.ASSESSMENT_AMOUNT_UPPER && thisForm.ASSESSMENT_AMOUNT_UPPER.value) {
//		alert("thisForm.ASSESSMENT_AMOUNT_UPPER.value = " + thisForm.ASSESSMENT_AMOUNT_UPPER.value);
	
/*
	if (thisForm.ASSESSMENT_AMOUNT_UPPER.value > 1) {
		alert("thisForm.ASSESSMENT_AMOUNT_UPPER.value > 1");
		
		thisForm.ASSESSMENT_AMOUNT_UPPER.focus();
				
		}
		
	else
*/

/*
	if (thisForm.ASSESSMENT_AMOUNT_UPPER.value < 1) {
	
		if (thisSTATUS_CODE == 4) {
		
			alert('Selected Status option states "Still Meets Threshold," but Max Reasonable Payout (' + thisForm.ASSESSMENT_AMOUNT_UPPER.value + ' Million),' + '\r\n' + 'is BELOW reporting threshold of $1 Million.' + '\r\n \r\n' + 'Please revise Max Reasonable Payout or change Status option to "Reassessed; No Longer Meets Threshold."');

			thisForm.ASSESSMENT_AMOUNT_UPPER.focus();

			document.getElementById("StillMeetsThresholdNote").style.background = "maroon"; 
			
			document.getElementById("StillMeetsThresholdNote").style.color = "white"; 
			
			document.getElementById("StillMeetsThresholdNote").style.padding = "2pt";

			document.getElementById("StillMeetsThresholdNote").style.fontWeight = "bold";

			returnFalseFlag = false;

			fcnRemoveConf = false;

			return false;
		
		}

	}
*/



	/* If Status Code = Favorable, Unfavorable, Settlement, Withdrawn and not Reassessed: 
	if (thisSTATUS_CODE > 10 && thisSTATUS_CODE < 15) {
	*/


	/* If Status Code = 12 Unfavorable, 13 Settlement Final and Paid: */
	if (thisSTATUS_CODE == 12 || thisSTATUS_CODE == 13) {


		alertString = "";
		alertStringPayoutDate = "";
		alertStringPayoutAmount = "";
	
/*	
	alert("thisForm.PAYOUT_DATE.value = '" + thisForm.PAYOUT_DATE.value + "'");
	alert("thisForm.PAYOUT_DATE_NA.checked = " + thisForm.PAYOUT_DATE_NA.checked);
*/

		if (thisForm.PAYOUT_DATE.value == "" &&
			thisForm.PAYOUT_DATE_NA.checked == false) {
			

			alertStringPayoutDate = 'Please specify Payout Date or check "None or N/A."'; 

			thisFormFocusField = "thisForm.PAYOUT_DATE";
			fcnRemoveConf = false;
			
			}


		if (thisForm.PAYOUT_AMOUNT.value == "" &&
			thisForm.PAYOUT_LT_100K.checked == false &&
			thisForm.PAYOUT_NA.checked == false) {
			
/*

			alertString = 'Please specify Payout Amount or check "Less than $100,000" or "None or N/A."');

*/

			alertStringPayoutAmount = 'Please specify Payout Amount or check "Less than $100,000" or "None or N/A."';

			thisFormFocusField = "thisForm.PAYOUT_AMOUNT";
			fcnRemoveConf = false;
			
			}



		if (alertStringPayoutAmount != "") {
				
			alertString = alertStringPayoutAmount;

			if (alertStringPayoutDate != "") {
				alertString = alertString + '\r\n \r\n' + 'ALSO: ' + alertStringPayoutDate;
				fcnRemoveConf = false;
				}

		}

		else {
		
			if (alertStringPayoutDate != "") {
				alertString = alertStringPayoutDate;
				fcnRemoveConf = false;
				}

		}

		
/*
alert("fcnRemoveConf = " + fcnRemoveConf);
*/
	
		if (fcnRemoveConf == false) {

			alert(alertString);
			returnFalseFlag = false;

			eval(thisFormFocusField).focus();
			
			return false;
		
		}
		
		else return true;
	
	/* Close if (thisSTATUS_CODE > 10 && thisSTATUS_CODE < 15) */	
	}


}



function checkAmtAsTyped(amtFieldName, amtFieldLabel, formNumber) {

thisForm = "CaseForm_" + formNumber;

validateAmtField(amtFieldName, amtFieldLabel, formNumber);

if (returnFalseFlag == false) {

if (amtFieldLabel == "Damages Assessment") clickUnk = '"Unknown."'
else clickUnk = '"Unknown"  or "N/A."'

alert(amtFieldLabel + ' must be numeric value with up to one decimal place and without dollar sign or comma. If no numeric value, leave ' + amtFieldLabel + ' blank, and click ' + clickUnk);

thisAmtField = thisForm + "." + amtFieldName;

eval(thisAmtField).focus();

}

}


function validateAmtField(amtFieldName, amtFieldLabel, formNumber) {

returnFalseFlag = true;

thisForm = "CaseForm_" + formNumber;

thisAmtField = thisForm + "." + amtFieldName;


thisAmtField_value = eval(thisAmtField).value

if (thisAmtField_value.substring(0,1) == ".") {

	thisAmtField_value = "0" + thisAmtField_value;
	eval(thisAmtField).value = thisAmtField_value;

}


/*
if (moneyPattern.test(eval(thisAmtField).value) && !moneyPattern_Exclude.test(eval(thisAmtField).value)) {
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

if (amtFieldLabel == "Damages Assessment") clickUnk = '"Unknown."'
else clickUnk = '"Unknown"  or "N/A."'

alert(amtFieldLabel + ' must be numeric value with up to one decimal place and without dollar sign or comma. If no numeric value, leave ' + amtFieldLabel + ' blank, and click ' + clickUnk);

eval(thisAmtField).focus();

returnFalseFlag = false;
}

}

}




function checkDateAsTyped(formNumber) {

validateDateField(formNumber);

if (returnFalseFlag == false) {

thisForm = "CaseForm_" + formNumber;

alert('Date Filed must be a Date value: mm/dd/yyyy. If no Date, leave Date Filed blank, and click "Unknown" or "N/A."');

<!---
eval(thisForm).DATE_FILED.focus();
--->

document.getElementById("DATE_FILED").focus();


}

}


function validateDateField(formNumber) {

returnFalseFlag = true;

thisForm = "CaseForm_" + formNumber;

if (datePattern_Yr2Digit.test(eval(thisForm).DATE_FILED.value)
|| datePattern_Yr4Digit.test(eval(thisForm).DATE_FILED.value)) {
/*
alert("Date Filed OK");
*/
/*
return true;
*/
}

else {

if (eval(thisForm).DATE_FILED.value != "") {
/*
alert("Date Filed INVALID")
*/
eval(thisForm).DATE_FILED.focus();
/*
return false;
*/
returnFalseFlag = false;
}

}

}



function clearUnknown(formNumber, fieldName, fieldLabel) {

if (document.getElementById("STATUS_CODE_2")) document.getElementById("STATUS_CODE_2").checked = false;


thisFormField = "CaseForm_" + formNumber + "." + fieldName + "_UNKNOWN";

if (eval(thisFormField).length) {

	for (i=0; i < eval(thisFormField).length; i++) eval(thisFormField)[i].checked = false;

}

else {

if (eval(thisFormField)) eval(thisFormField).checked = false;

}

promptUpdateFacts(fieldLabel);

}




function checkDateFiledAmtConflict(formName) {

/*
alert("Start checkDateFiledAmtConflict: returnFalseFlag = " + returnFalseFlag);
*/

var checkDateFiledAmtConflict_returnFalseFlag;

<!---
if (eval(formName).DIST_PERF_CLUSTER_CODE.value == "0" && eval(formName).HQ_AREA_NAME.value == "0") {
	alert("Please select a District, Division, or HQ Department.");
--->


if (eval(formName).DIST_PERF_CLUSTER_CODE.value == "0" && eval(formName).DIVISION_CODE.value == "0" && eval(formName).HQ_AREA_NAME.value == "0") {
	alert("Please select a District, Division, or HQ Department.");


	
/*	
	focusField = formName + ".DIST_PERF_CLUSTER_CODE";
*/

	eval(formName).DIST_PERF_CLUSTER_CODE.focus();
	var checkDateFiledAmtConflict_returnFalseFlag = false;
	
	}



DATE_FILED_UNKNOWN_Option = -1;

if (eval(formName).DATE_FILED_UNKNOWN && eval(formName).DATE_FILED_UNKNOWN.length) {

for (i=0; i < eval(formName).DATE_FILED_UNKNOWN.length; i++) {

	if (eval(formName).DATE_FILED_UNKNOWN[i].checked) {
		DATE_FILED_UNKNOWN_Option = i;
		break;
	}

}

}


if (DATE_FILED_UNKNOWN_Option == -1) {

if (eval(formName).DATE_FILED.value == "") {

	alert("Please enter Date Filed or check 'N/A' or 'Unknown.'");
/*
	focusField = formName + ".DATE_FILED";
*/

	eval(formName).DATE_FILED.focus();
	var checkDateFiledAmtConflict_returnFalseFlag = false;
}

}

else {

if (eval(formName).DATE_FILED.value != "") {

	alert("For Date Filed, 'N/A' or 'Unknown' is checked, but Date Filed value is also entered. Please correct: Click inside Date Filed field to un-check 'N/A' and 'Unknown.' Then if there is no Date Filed value, erase the value entered in Date Filed field and re-check 'N/A' or 'Unknown.'");
/*
	focusField = eval(formName) + ".DATE_FILED";
*/

	eval(formName).DATE_FILED.focus();
	var checkDateFiledAmtConflict_returnFalseFlag = false;
}


}


AMOUNT_SOUGHT_UNKNOWN_Option = -1;

if (eval(formName).AMOUNT_SOUGHT_UNKNOWN && eval(formName).AMOUNT_SOUGHT_UNKNOWN.length) {

for (i=0; i<eval(formName).AMOUNT_SOUGHT_UNKNOWN.length; i++) {

	if (eval(formName).AMOUNT_SOUGHT_UNKNOWN[i].checked) {
		AMOUNT_SOUGHT_UNKNOWN_Option = i;
		break;
	}

}

}


if (AMOUNT_SOUGHT_UNKNOWN_Option == -1) {

if (eval(formName).AMOUNT_SOUGHT.value == "") {

	alert("Please enter Amount Sought or check 'N/A' or 'Unknown.'");
/*
	focusField = formName + ".AMOUNT_SOUGHT";
*/

	eval(formName).AMOUNT_SOUGHT.focus();
	var checkDateFiledAmtConflict_returnFalseFlag = false;
}

}

else {

if (eval(formName).AMOUNT_SOUGHT.value != "") {

	alert("For Amount Sought, 'N/A' or 'Unknown' is checked, but Amount Sought value is also entered. Please correct: Click inside Amount Sought field to un-check 'N/A' and 'Unknown.' Then if there is no Amount Sought value, erase the value entered in Amount Sought field and re-check 'N/A' or 'Unknown.'");
/*
	focusField = formName + ".AMOUNT_SOUGHT";
*/

	eval(formName).AMOUNT_SOUGHT.focus();
	var checkDateFiledAmtConflict_returnFalseFlag = false;
}


}



ASSESSMENT_AMOUNT_UNKNOWN_Option = -1;

if (eval(formName).ASSESSMENT_AMOUNT_UNKNOWN && eval(formName).ASSESSMENT_AMOUNT_UNKNOWN.checked) 		ASSESSMENT_AMOUNT_UNKNOWN_Option = 0;


if (ASSESSMENT_AMOUNT_UNKNOWN_Option == -1) {

	if (eval(formName).ASSESSMENT_AMOUNT.value == "") {
		alert("Please enter both Most Likely Payout and Maximum Reasonable Payout or check 'Unknown.'");
		eval(formName).ASSESSMENT_AMOUNT.focus();
		var checkDateFiledAmtConflict_returnFalseFlag = false;
	}

<!---
	if (eval(formName).ASSESSMENT_AMOUNT_UPPER.value == "") {
		alert("Please enter both Most Likely Payout and Maximum Reasonable Payout or check 'Unknown.'");
		eval(formName).ASSESSMENT_AMOUNT_UPPER.focus();
		var checkDateFiledAmtConflict_returnFalseFlag = false;
	}
--->



	if (eval(formName).ASSESSMENT_AMOUNT_UPPER.value == "" && eval(formName).ASSESSMENT_AMT_MAX_UNKNOWN.checked == false)
	
	{
		alert("Please enter both Most Likely Payout and Maximum Reasonable Payout or check 'Unknown.'");
		eval(formName).ASSESSMENT_AMOUNT_UPPER.focus();
		var checkDateFiledAmtConflict_returnFalseFlag = false;
	}




	if (eval(formName).ASSESSMENT_AMOUNT.value != "" && eval(formName).ASSESSMENT_AMOUNT_UPPER.value != "") {

		if (parseFloat(eval(formName).ASSESSMENT_AMOUNT.value) > parseFloat(eval(formName).ASSESSMENT_AMOUNT_UPPER.value)) {
			alert("Most Likely Payout must be less than or equal to Maximum Reasonable Payout."
			+ "\r\n \r\n" +
			"Please revise.");
			eval(formName).ASSESSMENT_AMOUNT.focus();
			var checkDateFiledAmtConflict_returnFalseFlag = false;
		}

	}

// Close if (ASSESSMENT_AMOUNT_UNKNOWN_Option == -1) 
}

PAYOUT_LT_100K_Option = -1; 	
PAYOUT_NA_Option = -1;


if (eval(formName).PAYOUT_LT_100K && eval(formName).PAYOUT_LT_100K.checked) PAYOUT_LT_100K_Option = 0;


if (PAYOUT_LT_100K_Option == -1) {
	if (eval(formName).PAYOUT_NA && eval(formName).PAYOUT_NA.checked) PAYOUT_NA_Option = 0;
}

if (PAYOUT_LT_100K_Option == 0 || PAYOUT_NA_Option == 0) {

if (eval(formName).PAYOUT_AMOUNT.value != "") {

alert("For Payout Amount, 'Less than $100,000' or 'None or N/A' is checked,"
+ "\r\n" +
"but Payout Amount is not blank."
+ "\r\n \r\n" +
"Please correct -- "
+ "\r\n \r\n" +
"Either (1) enter a Payout Amount and un-check both 'Less than $100,000' and 'None or N/A,'"
+ "\r\n \r\n" +
"or (2) leave Payout Amount blank and check either 'Less than $100,000' or 'None or N/A.'");

	newFieldList = chgFieldList.push("Payout Amount");
/*
	focusField = formName + ".PAYOUT_AMOUNT";
*/

	eval(formName).PAYOUT_AMOUNT.focus();
	var checkDateFiledAmtConflict_returnFalseFlag = false;

}

}



PAYOUT_DATE_NA_Option = -1;

if (eval(formName).PAYOUT_DATE_NA && eval(formName).PAYOUT_DATE_NA.checked) PAYOUT_DATE_NA_Option = 0;

if (PAYOUT_DATE_NA_Option == 0) {

if (eval(formName).PAYOUT_DATE.value != "") {

alert("For Payout Date, 'None or N/A' is checked,"
+ "\r\n" +
"but Payout Date is not blank."
+ "\r\n \r\n" +
"Please correct -- "
+ "\r\n \r\n" +
"Either (1) enter a Payout Date and un-check 'None or N/A,'"
+ "\r\n \r\n" +
"or (2) leave Payout Date blank and check 'None or N/A.'");

	newFieldList = chgFieldList.push("Payout Date");
/*
	focusField = formName + ".PAYOUT_AMOUNT";
*/

	eval(formName).PAYOUT_DATE.focus();
	var checkDateFiledAmtConflict_returnFalseFlag = false;

}

}


/*
returnFalseFlag = checkDateFiledAmtConflict_returnFalseFlag;
*/

/*
alert("End checkDateFiledAmtConflict: checkDateFiledAmtConflict_returnFalseFlag = " + checkDateFiledAmtConflict_returnFalseFlag);
*/

if (checkDateFiledAmtConflict_returnFalseFlag == false) return false;
else return true;



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


function checkRemoteProb(thisForm) {

	for (i=0; i<thisForm.ASSESSMENT_PROBABILITY.length; i++) {
	if (thisForm.ASSESSMENT_PROBABILITY[i].checked) thisASSESSMENT_PROBABILITY = thisForm.ASSESSMENT_PROBABILITY[i].value;
	}
/*
alert("thisASSESSMENT_PROBABILITY = " + thisASSESSMENT_PROBABILITY);
*/

	if (thisForm.STATUS_CODE && thisForm.STATUS_CODE.value == 1) thisSTATUS_CODE = thisForm.STATUS_CODE.value

	else {

	for (i=0; i<thisForm.STATUS_CODE.length; i++) {
		if (thisForm.STATUS_CODE[i].checked) thisSTATUS_CODE = thisForm.STATUS_CODE[i].value;
	}

	}


}

function checkAssessedProb(thisForm) {

	for (i=0; i<thisForm.ASSESSMENT_PROBABILITY.length; i++) {
	if (thisForm.ASSESSMENT_PROBABILITY[i].checked) thisASSESSMENT_PROBABILITY = thisForm.ASSESSMENT_PROBABILITY[i].value;
	}

	if (thisForm.STATUS_CODE && thisForm.STATUS_CODE.value == 1) thisSTATUS_CODE = thisForm.STATUS_CODE.value

	else {

	for (i=0; i<thisForm.STATUS_CODE.length; i++) {
		if (thisForm.STATUS_CODE[i].checked) thisSTATUS_CODE = thisForm.STATUS_CODE[i].value;
	}

	}


/*
	alert("thisASSESSMENT_PROBABILITY = " + thisASSESSMENT_PROBABILITY);
*/
	if (thisASSESSMENT_PROBABILITY != thisForm.ASSESSMENT_PROBABILITY_Orig.value) {

	newFieldList = chgFieldList.push("Liability Assessment");

/*
	returnFalseFlag = false;
*/

	return false;

	}

	else return true;


}


function showStatusCodeSelected(thisForm) {

// alert("thisForm.STATUS_CODE = " + thisForm.STATUS_CODE.value);

// alert("In showStatusCodeSelected()");

/*
if (CaseForm_1.STATUS_CODE.length) {

 alert("CaseForm_1.STATUS_CODE.length = " + CaseForm_1.STATUS_CODE.length);

}

else  alert("CaseForm_1.STATUS_CODE.length NOT DEFINED");
*/

/*
if (thisForm.STATUS_CODE) {

	alert("thisForm.STATUS_CODE defined");

	if (thisForm.STATUS_CODE.length) {

		 alert("thisForm.STATUS_CODE.length = " + thisForm.STATUS_CODE.length);

	}

	else  alert("thisForm.STATUS_CODE.length NOT DEFINED");

}

else  alert("thisForm.STATUS_CODE NOT DEFINED");
*/


	if (thisForm.STATUS_CODE && thisForm.STATUS_CODE.value == 1) {
		
		thisSTATUS_CODE = thisForm.STATUS_CODE.value
		
//		alert("thisSTATUS_CODE = " + thisSTATUS_CODE);
		
	}		

	else {
	
		thisSTATUS_CODE = "";
	

// Concatenate STATUS_CODE values

		for (i=0; i<thisForm.STATUS_CODE.length; i++) {

			if (thisForm.STATUS_CODE[i].checked) {
		
//				thisSTATUS_CODE = thisForm.STATUS_CODE[i].value;

				if (thisSTATUS_CODE == "") thisSTATUS_CODE = thisForm.STATUS_CODE[i].value;

				else thisSTATUS_CODE = thisSTATUS_CODE + "," + thisForm.STATUS_CODE[i].value;
				
//				alert("thisSTATUS_CODE = " + thisSTATUS_CODE);

			}
		
		}

	}
	

//	alert("At end: thisSTATUS_CODE = " + thisSTATUS_CODE);


	thisForm.STATUS_CODE_SELECTED_ALL.value = thisSTATUS_CODE;


//	alert("thisForm.STATUS_CODE_SELECTED_ALL = " + thisForm.STATUS_CODE_SELECTED_ALL.value);



	showUnionsSelected(thisForm); 



	return true;


}





function showUnionsSelected(thisForm) {


//	alert("1: In showUnionsSelected");

	thisUnions_Selected = "";
	

// Concatenate Unions_Selected values


//	if (thisForm.Unions_Selected.length) alert("2: thisForm.Unions_Selected.length Defined");

//	if (thisForm.Unions_Selected) alert("3: thisForm.Unions_Selected Defined");

//	else alert("4: thisForm.Unions_Selected NOT Defined");


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






function checkupdFactsFlagArray(thisForm, formName) {

newFieldList = "";


<!--- Comment_Gen_Char_Limit defined in application.cfm --->

<CFOUTPUT>
if (thisForm.COMMENT_GENERAL.value.length > #Comment_Gen_Char_Limit#) {

	alert("The text in the Comment / Notes box is too long." + "\r\n\r\n" + "Please make it shorter than the #Comment_Gen_Char_Limit#-character limit.");
	if (document.getElementById("COMMENT_GENERAL")) document.getElementById("COMMENT_GENERAL").focus();
	return false;

}
</cfoutput>




if (!thisForm.STATUS_CODE || (thisForm.STATUS_CODE && !thisForm.STATUS_CODE.checked && !thisForm.STATUS_CODE.length && !thisForm.STATUS_CODE.value)) {

	alert("Please check one or more choices for \"Change in Status\" as appropriate.");
	if (document.getElementById("STATUS_CODE_2")) document.getElementById("STATUS_CODE_2").focus();
	return false;

}

if (thisForm.FIELD_GRIEVANCE_FLAG && thisForm.FIELD_GRIEVANCE_FLAG[0].checked && thisForm.NATL_GATS_NUMBER && thisForm.NATL_GATS_NUMBER.value == "") {

	alert("You have checked \"Yes,\" indicating this is a Field Grievance pending resolution of a national-level case."
	+ "\r\n \r\n" +
	"Please enter the GATS Number of the national-level case.");
	thisForm.NATL_GATS_NUMBER.focus();
	return false;

}


if (thisForm.LM_MATTER_NUMBER.value.length > 11) {

	alert("LawManager Matter Number must be no longer than 11 characters.");
	thisForm.LM_MATTER_NUMBER.focus();
	return false;
	
}


checkupdFactsFlagArray_returnFalseFlag = checkDateFiledAmtConflict(formName);

if (checkupdFactsFlagArray_returnFalseFlag == false) return false;

else {


/*
alert("updFactsFlagArray.length = " + updFactsFlagArray.length);
*/


if (updFactsFlagArray.length > 0) {

	updFactsFlagArray.length = 0;
	chgFieldList.length = 0;

	checkupdFactsFlagArray_returnFalseFlag = checkAssessedProb(thisForm);

/*
alert("After checkAssessedProb: returnFalseFlag = " + returnFalseFlag);
*/


	if (thisForm.AMOUNT_SOUGHT.value != thisForm.AMOUNT_SOUGHT_Orig.value) {
	newFieldList = chgFieldList.push("Amount Sought");
/*
	alert("chgFieldList.join(', ') = '" + chgFieldList.join(', ') + "'");
*/
	checkupdFactsFlagArray_returnFalseFlag = false;
	}


/*
alert("After if (thisForm.AMOUNT_SOUGHT.value != thisForm.AMOUNT_SOUGHT_Orig.value): checkupdFactsFlagArray_returnFalseFlag = " + checkupdFactsFlagArray_returnFalseFlag);
*/



	if (thisForm.ASSESSMENT_AMOUNT.value != thisForm.ASSESSMENT_AMOUNT_Orig.value) {
	newFieldList = chgFieldList.push("Most Likely Payout");

	checkupdFactsFlagArray_returnFalseFlag = false;
	}

/*
alert("After if (thisForm.ASSESSMENT_AMOUNT.value != thisForm.ASSESSMENT_AMOUNT_Orig.value): checkupdFactsFlagArray_returnFalseFlag = " + checkupdFactsFlagArray_returnFalseFlag);
*/


	if (thisForm.ASSESSMENT_AMOUNT_UPPER.value != thisForm.ASSESSMENT_AMOUNT_UPPER_Orig.value) {
	newFieldList = chgFieldList.push("Maximum Reasonable Payout ");

	checkupdFactsFlagArray_returnFalseFlag = false;
	}

/*
alert("After if (thisForm.ASSESSMENT_AMOUNT_UPPER.value != thisForm.ASSESSMENT_AMOUNT_UPPER_Orig.value): checkupdFactsFlagArray_returnFalseFlag = " + checkupdFactsFlagArray_returnFalseFlag);
*/



/*
alert("thisForm.PAYOUT_AMOUNT.value = " + thisForm.PAYOUT_AMOUNT.value);
alert("thisForm.PAYOUT_AMOUNT_Orig.value = " + thisForm.PAYOUT_AMOUNT_Orig.value);
*/

	if (thisForm.PAYOUT_AMOUNT.value != thisForm.PAYOUT_AMOUNT_Orig.value) {
	newFieldList = chgFieldList.push("Payout Amount");

	checkupdFactsFlagArray_returnFalseFlag = false;
	}

/*
alert("After if (thisForm.PAYOUT_AMOUNT.value != thisForm.PAYOUT_AMOUNT_Orig.value): checkupdFactsFlagArray_returnFalseFlag = " + checkupdFactsFlagArray_returnFalseFlag);
*/


/*
alert("thisForm.PAYOUT_DATE.value = " + thisForm.PAYOUT_DATE.value);
alert("thisForm.PAYOUT_DATE_Orig.value = " + thisForm.PAYOUT_DATE_Orig.value);
*/

	if (thisForm.PAYOUT_DATE.value != thisForm.PAYOUT_DATE_Orig.value) {
	newFieldList = chgFieldList.push("Payout Date or Date Finalized");

	checkupdFactsFlagArray_returnFalseFlag = false;
	}

/*
alert("After if (thisForm.PAYOUT_DATE.value != thisForm.PAYOUT_DATE_Orig.value): checkupdFactsFlagArray_returnFalseFlag = " + checkupdFactsFlagArray_returnFalseFlag);
*/


/*
alert("After if (thisForm.PAYOUT_AMOUNT/DATE: checkupdFactsFlagArray_returnFalseFlag = " + checkupdFactsFlagArray_returnFalseFlag);
*/



	if (thisForm.STATUS_CODE && thisForm.STATUS_CODE.value == 1) thisSTATUS_CODE = thisForm.STATUS_CODE.value

	else {

	for (i=0; i<thisForm.STATUS_CODE.length; i++) {
		if (thisForm.STATUS_CODE[i].checked) thisSTATUS_CODE = thisForm.STATUS_CODE[i].value;
	}

	}

	if (!thisForm.STATUS_CODE_SELECTED_Orig || thisSTATUS_CODE != thisForm.STATUS_CODE_SELECTED_Orig.value) {

/*
	alert("thisSTATUS_CODE = '" + thisSTATUS_CODE + "'");
	alert("thisForm.STATUS_CODE_Orig.value = '" + thisForm.STATUS_CODE_Orig.value + "'");
*/
	newFieldList = chgFieldList.push("Change in Status");
/*
	alert("chgFieldList.join(', ') = '" + chgFieldList.join(', ') + "'");
*/
	checkupdFactsFlagArray_returnFalseFlag = false;
	}

/*
alert("After if (!thisForm.STATUS_CODE_Orig || thisSTATUS_CODE != thisForm.STATUS_CODE_Orig.value): checkupdFactsFlagArray_returnFalseFlag = " + checkupdFactsFlagArray_returnFalseFlag);
*/






/* Close if (updFactsFlagArray.length > 0) */
}


/*
updFactsFlagArray.length = 0;
chgFieldList.length = 0;
*/

/*
alert("AFTER IFs: chgFieldList.join(', ') = '" + chgFieldList.join(', ') + "'");
*/

/*
alert("After Close if (updFactsFlagArray.length > 0): checkupdFactsFlagArray_returnFalseFlag = " + checkupdFactsFlagArray_returnFalseFlag);
*/


if (checkupdFactsFlagArray_returnFalseFlag == false) {

/*
alert("After 'if (checkupdFactsFlagArray_returnFalseFlag == false)'");
*/

if (!(thisForm.STATUS_CODE && thisForm.STATUS_CODE.value == 1)) {
/*
alert("After 'if (!thisForm.STATUS_CODE)'");
*/
if (thisForm.STATUS_CODE[0].checked) thisForm.STATUS_CODE[1].checked = true;


/*
alert("chgFieldList.length = " + chgFieldList.length);
*/


if (chgFieldList.length > 0) thisChgFieldString = chgFieldList.join("' and '");
else thisChgFieldString = "";

if (thisChgFieldString.indexOf("Status") == -1) {

	if (thisChgFieldString == "") thisChgFieldString = "Status";
	else thisChgFieldString = thisChgFieldString + "' and 'Status";
}

thisChgFieldString = "'" + thisChgFieldString + "'";

alert("Please update the 'Facts / Positions' narrative to explain the change in " +
thisChgFieldString + ". Then click the Submit button.");

thisForm.FACTS_POSITIONS_LONG.focus();


updFactsFlagArray.length = 0;
chgFieldList.length = 0;

/*
return false;
*/

checkupdFactsFlagArray_returnFalseFlag = false;

/*
alert("Before Close if (!(thisForm.STATUS_CODE && thisForm.STATUS_CODE.value == 1))): checkupdFactsFlagArray_returnFalseFlag = " + checkupdFactsFlagArray_returnFalseFlag);
*/


/* Close if (!(thisForm.STATUS_CODE && thisForm.STATUS_CODE.value == 1)) */
}

/* Close if (returnFalseFlag == false) */
}

/*
else {
*/


/*
alert("After if (checkupdFactsFlagArray_returnFalseFlag == false)");
*/

/*
alert("returnFalseFlag = " + returnFalseFlag);
*/

/*
alert("At 877: checkupdFactsFlagArray_returnFalseFlag = " + checkupdFactsFlagArray_returnFalseFlag);
*/

if (checkupdFactsFlagArray_returnFalseFlag == false) return false;

else {




checkRemoteProb(thisForm);

checkupdFactsFlagArray_returnFalseFlag = checkLDOffcAltLDOffc(thisForm);

/*
alert("After checkLDOffcAltLDOffc: checkupdFactsFlagArray_returnFalseFlag = " + checkupdFactsFlagArray_returnFalseFlag);
*/

if (checkupdFactsFlagArray_returnFalseFlag == false) return false;

else {

/*
alert("At call to checkStatusCodeSelected");
*/

checkupdFactsFlagArray_returnFalseFlag = checkStatusCodeSelected(thisForm);

/*
alert("After checkStatusCodeSelected: checkupdFactsFlagArray_returnFalseFlag = " + checkupdFactsFlagArray_returnFalseFlag);
*/



if (checkupdFactsFlagArray_returnFalseFlag == false) {
	thisForm.STATUS_CODE[0].focus();
	return false;
	}

else {


checkupdFactsFlagArray_returnFalseFlag = checkSHORT_TERM_LIABILITY_Selected(thisForm);

/*
alert("After checkSHORT_TERM_LIABILITY_Selected: checkupdFactsFlagArray_returnFalseFlag = " + checkupdFactsFlagArray_returnFalseFlag);
*/



if (checkupdFactsFlagArray_returnFalseFlag == false) {
	thisForm.SHORT_TERM_LIABILITY[0].focus();
	return false;
	}

else {




checkupdFactsFlagArray_returnFalseFlag = checkStatusCodePayoutInfo(thisForm);

/*
alert("After checkStatusCodePayoutInfo: checkupdFactsFlagArray_returnFalseFlag = " + checkupdFactsFlagArray_returnFalseFlag);
*/

if (checkupdFactsFlagArray_returnFalseFlag == false) return false;

else return true;

}


/* Close if (checkupdFactsFlagArray_returnFalseFlag == false) */
}


/* Close if (checkupdFactsFlagArray_returnFalseFlag == false) */
}


/* Close if (checkupdFactsFlagArray_returnFalseFlag == false) */
}

/* Close if (checkupdFactsFlagArray_returnFalseFlag == false) */
}


if (checkupdFactsFlagArray_returnFalseFlag  == false) return false;
else return true;





}


function checkSHORT_TERM_LIABILITY_Selected(thisForm) {

/*
alert('In checkSHORT_TERM_LIABILITY_Selected()');
*/

SHORT_TERM_LIABILITY_SelectedFlag = false;

for (i=0; i<thisForm.SHORT_TERM_LIABILITY.length; i++) {
		if (thisForm.SHORT_TERM_LIABILITY[i].checked) {

			SHORT_TERM_LIABILITY_SelectedFlag = true;
			
			if (thisForm.SHORT_TERM_LIABILITY[i].value != thisForm.SHORT_TERM_LIABILITY_Orig.value)
			{
				if (document.getElementById("STATUS_CODE_2")) document.getElementById("STATUS_CODE_2").checked = false;
				
				
				for (j=0; j<thisForm.SHORT_TERM_LIABILITY.length; j++) {
				
					thisJ_STLChgDiv = "SHORT_TERM_LIABILITY_Chg_Div_" + thisForm.SHORT_TERM_LIABILITY[j].value;
					
					if (document.getElementById(thisJ_STLChgDiv)) document.getElementById(thisJ_STLChgDiv).style.display = "none";
				
				}
				
				
				thisSTLChgDiv = "SHORT_TERM_LIABILITY_Chg_Div_" + thisForm.SHORT_TERM_LIABILITY[i].value;
				eval(thisSTLChgDiv).style.display = "inline";
			}	
		
			else {
			
				for (j=0; j<thisForm.SHORT_TERM_LIABILITY.length; j++) {
			
				thisJ_STLChgDiv = "SHORT_TERM_LIABILITY_Chg_Div_" + thisForm.SHORT_TERM_LIABILITY[j].value;
					
				if (document.getElementById(thisJ_STLChgDiv)) document.getElementById(thisJ_STLChgDiv).style.display = "none";
				
				}
		
			
			}
		
			
			break;

		}
		
	}


if (SHORT_TERM_LIABILITY_SelectedFlag == false) {
	alert('Please select a choice for "Estimated Time to Resolution"');
	return false;
	}
	
else return true;

}




function checkStatusCodeSelected(thisForm) {

statusCodeSelectedFlag = false;

if (thisForm.STATUS_CODE && thisForm.STATUS_CODE.value == 1) statusCodeSelectedFlag = true;

else {

for (i=0; i<thisForm.STATUS_CODE.length; i++) {
		if (thisForm.STATUS_CODE[i].checked) {
			statusCodeSelectedFlag = true;
			break;
			}
		
	}

}

if (statusCodeSelectedFlag == false) {
	alert("Please check one or more choices for \"Change in Status\" as appropriate.");
	return false;
	}
	
else return true;


}



function checkLDOffcAltLDOffc(thisForm) {

if (thisForm.LAW_DEPT_OFFICE.options[thisForm.LAW_DEPT_OFFICE.selectedIndex].value != 0 && thisForm.LAW_DEPT_OFFICE.options[thisForm.LAW_DEPT_OFFICE.selectedIndex].value == thisForm.ALT_LAW_DEPT_OFFICE.options[thisForm.ALT_LAW_DEPT_OFFICE.selectedIndex].value) {
	alert("Law Dept Reporting Office and Alternate Law Dept Office must be different. Please change your selection(s).");
	
/*	
	returnFalseFlag = false;
*/

	return false;
	
	}
	
else return true;	

}

function clearupdFactsFlagArray() {

updFactsFlagArray.length = 0;
chgFieldList.length = 0;


returnFalseFlag = true;

}

function promptUpdateFacts(fieldClicked) {

if (document.getElementById("STATUS_CODE_2")) document.getElementById("STATUS_CODE_2").checked = false;

alert("For any change in '" + fieldClicked + ",' please update the 'Facts / Positions' narrative accordingly.");


newFFArray = updFactsFlagArray.push(fieldClicked);

/*
alert("updFactsFlagArray.length = " + updFactsFlagArray.length);
*/

}

function promptMCApproval() {

alert('Enter "MC Comment," if any, then click "Submit This Update" button at end of page.');
CaseForm_1.MC_COMMENT.focus();

}

function showCaseEvaluationChecklistDiv(caseNum) {

thisCaseEvaluationChecklistHeader = "CaseEvaluationChecklistHeader_"  + caseNum;
thisCaseEvaluationChecklist = "CaseEvaluationChecklist_" + caseNum;


if (document.getElementById(thisCaseEvaluationChecklist)) {

	eval(thisCaseEvaluationChecklistHeader).innerHTML = '<b>Case Evaluation Checklist</b><br><span style="font-weight:normal; color:maroon">[Update as needed and click <b>Update Checklist button</b> at bottom.]</span>';
	eval(thisCaseEvaluationChecklistHeader).style.background = "";
	eval(thisCaseEvaluationChecklist).style.display = "inline";

}

}

function hideShowButton(button, recordNum, buttonValue) {

/*
alert("buttonValue = " + buttonValue);
alert("prevButtonValue = " + prevButtonValue);
alert("CaseForm_1.STATUS_CODE[0].value = " + CaseForm_1.STATUS_CODE[0].value);
alert("CaseForm_1.STATUS_CODE[1].value = " + CaseForm_1.STATUS_CODE[1].value);
*/

/* Un-check "No Change Since Last Report" if any other Status checked: */
if (buttonValue != 2) CaseForm_1.STATUS_CODE[0].checked = false;



chgRemoveFlag = "no";



if (prevButtonValue == 0) prevButtonValue = buttonValue;
else {

/* Allow Update for change from one "Remove" status to another: */
	if (prevButtonValue != buttonValue && prevButtonValue > 10 && prevButtonValue <= 15 && buttonValue > 10 && buttonValue <= 15) {
	 	chgRemoveFlag = "yes";
		prevButtonValue = buttonValue;

	}
	
}


/*
alert("chgRemoveFlag = '" + chgRemoveFlag + "'");
*/


if (button == "No Change" || button == "Remove" || button == "Update") {

	thisButtonNoChange = "ButtonNoChange_" + recordNum;
	thisButtonRemove = "ButtonRemove_" + recordNum;
	thisButtonUpdate = "ButtonUpdate_" + recordNum;
	thisclickRemoveSpan = "clickRemoveSpan_" + recordNum;
	thisclickRemoveSpanAlso = "clickRemoveSpanAlso_" + recordNum;
	thisprevRptLineDiv = "prevRptLine_" + recordNum;
	thisPayout_Amt = "Payout_Amt_" + recordNum;
	thisPayout_Date = "Payout_Date_" + recordNum;

}




if (button == "No Change") {

/*	thisButtonNoChange = "ButtonNoChange_" + recordNum; */
	if (document.getElementById(thisButtonNoChange)) eval(thisButtonNoChange).style.display = "inline";

/*	thisButtonRemove = "ButtonRemove_" + recordNum; */
	if (document.getElementById(thisButtonRemove)) eval(thisButtonRemove).style.display = "none";

/*	thisButtonUpdate = "ButtonUpdate_" + recordNum; */
	if (document.getElementById(thisButtonUpdate)) eval(thisButtonUpdate).style.display = "inline";

/*	thisclickRemoveSpan = "clickRemoveSpan_" + recordNum; */
	if (document.getElementById(thisclickRemoveSpan)) eval(thisclickRemoveSpan).style.display = "none";

/*	thisprevRptLineDiv = "prevRptLine_" + recordNum; */
	if (document.getElementById(thisprevRptLineDiv)) eval(thisprevRptLineDiv).style.display = "none";

	if (document.getElementById(thisPayout_Date)) eval(thisPayout_Date).style.display = "none";
	if (document.getElementById(thisPayout_Amt)) eval(thisPayout_Amt).style.display = "none";


}

else {

if (button == "Remove") {

/*	thisButtonNoChange = "ButtonNoChange_" + recordNum; */
	if (document.getElementById(thisButtonNoChange)) eval(thisButtonNoChange).style.display = "none";

/*	thisButtonRemove = "ButtonRemove_" + recordNum; */
	if (document.getElementById(thisButtonRemove)) eval(thisButtonRemove).style.display = "inline";

/*	thisButtonUpdate = "ButtonUpdate_" + recordNum; */
	if (document.getElementById(thisButtonUpdate)) {
	

		if (chgRemoveFlag == "yes") {
			eval(thisButtonUpdate).style.display = "inline";
			eval(thisclickRemoveSpanAlso).style.display = "none";
		}
		
		else {
			eval(thisButtonUpdate).style.display = "none";
			eval(thisclickRemoveSpanAlso).style.display = "inline";
		}

/*
		eval(thisButtonUpdate).style.display = "none";
*/

	}

/*	thisprevRptLineDiv = "prevRptLine_" + recordNum; */
	if (document.getElementById(thisprevRptLineDiv)) eval(thisprevRptLineDiv).style.display = "none";

/*	thisclickRemoveSpan = "clickRemoveSpan_" + recordNum; */

/*	thisPayout_Amt = "Payout_Amt_" + recordNum; */
/*	thisPayout_Date = "Payout_Date_" + recordNum; */

/* Check for Status Code Unfavorable Decision (12) or Settlement Final and Paid (13): */
	if (buttonValue == 12 || buttonValue == 13) {
		if (document.getElementById(thisclickRemoveSpan)) eval(thisclickRemoveSpan).style.display = "block";
		if (document.getElementById(thisPayout_Amt)) eval(thisPayout_Amt).style.display = "inline";
		if (document.getElementById(thisPayout_Date)) eval(thisPayout_Date).style.display = "inline";
		}
	else {
		if (document.getElementById(thisclickRemoveSpan)) eval(thisclickRemoveSpan).style.display = "none";
		if (document.getElementById(thisPayout_Date)) eval(thisPayout_Date).style.display = "none";
		if (document.getElementById(thisPayout_Amt)) eval(thisPayout_Amt).style.display = "none";
		}


	if (chgRemoveFlag == "yes") {
		if (document.getElementById(thisclickRemoveSpanAlso)) eval(thisclickRemoveSpanAlso).style.display = "none";
		}
		
	else {
		if (document.getElementById(thisclickRemoveSpanAlso)) eval(thisclickRemoveSpanAlso).style.display = "inline";
		}


}

else {

if (button == "Update") {

/*	thisButtonNoChange = "ButtonNoChange_" + recordNum; */
	if (document.getElementById(thisButtonNoChange)) eval(thisButtonNoChange).style.display = "none";

/*	thisButtonRemove = "ButtonRemove_" + recordNum; */
	if (document.getElementById(thisButtonRemove)) eval(thisButtonRemove).style.display = "none";

/*	thisButtonUpdate = "ButtonUpdate_" + recordNum; */
	if (document.getElementById(thisButtonUpdate)) eval(thisButtonUpdate).style.display = "inline";

/*	thisclickRemoveSpan = "clickRemoveSpan_" + recordNum; */
	if (document.getElementById(thisclickRemoveSpan)) eval(thisclickRemoveSpan).style.display = "none";

/*	thisprevRptLineDiv = "prevRptLine_" + recordNum; */
	if (document.getElementById(thisprevRptLineDiv)) eval(thisprevRptLineDiv).style.display = "inline";

	if (document.getElementById(thisPayout_Date)) eval(thisPayout_Date).style.display = "none";
	if (document.getElementById(thisPayout_Amt)) eval(thisPayout_Amt).style.display = "none";


}

}

}

}


function confirmDelete() {

if (!confirm("This will delete this record from the Report." +
"\r\n \r\n" +
"Are you sure you want to do this?")) return false;

}


function removeConfirm(thisForm) {

if (confirm("Are you sure you want to remove this Case Record from future reports?"))  removeConf = true
else removeConf = false;

if (removeConf == false) return false

else {

	return checkStatusCodePayoutInfo(thisForm);

}


}


function UNremoveConfirm() {

if (confirm("Are you sure you want to restore this Case Record for future reports?"))  UNremoveConf = true
else UNremoveConf = false;

if (UNremoveConf==false) return false

}



</script>



