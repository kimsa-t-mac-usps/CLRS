<cfinclude template="MfaCookieCheck.cfm">


<!--- This file contains link to stylesheeet and has various JavaScript routines and functions used throughout --->

<link rel="stylesheet" type="text/css" href="stylesheet.css">


<script language="javascript">

// Var ALL used in Copy to New Window call and function 
ALL = "ALL";


// Var RecCt set in Report.ptA.cfm 



n = 0;

grayLettersArray = new Array ("N", "D", "U");
grayLettersArrayLen = grayLettersArray.length;




<CFIF IsDefined("RptDateParm") AND RptDateParm NEQ "">

	parmConnector = "&";

<CFELSE>

	parmConnector = "?";

</CFIF>







<!---
<CFIF (IsDefined("Form.IndexOnly") AND Form.IndexOnly EQ "IndexOnly")
OR
(CONTINGENT_LIAB_GetRecord_Current_Count.Current_Count GT 10 AND NOT IsDefined("Form.IndexOnly"))>
--->

function openCLCaseWindow(prKey, thisRptDate, prevRptDate) {


if (document.getElementById("TextHighlightingDisable").checked) {

	textHighlightParm = "&TextHighlight=Disabled";

}

else {

	textHighlightParm = "";

}



<CFOUTPUT>
CLCaseWindow = window.open("Get_Single_Record.cfm?PRIMARYKEY=" + prKey + "&ThisReportDate_Parm=" + thisRptDate + "&PrevReportDate_Parm=" + prevRptDate + textHighlightParm, "CLWindow_#SingleRecWindowName_String#", "toolbar=yes, location=yes, menubar=yes, scrollbars=yes, resizable=yes, status=yes")
</CFOUTPUT>

<!---
CLCaseWindow.document.title = caseName;
--->

CLCaseWindow.focus();

}

<!---
</cfif>
--->

function checkSHORT_TERM_LIABILITY(thisForm) {

alert("In checkSHORT_TERM_LIABILITY()");

<!---
if (thisForm.SHORT_TERM_LIABILITY.value != 1 && thisForm.SHORT_TERM_LIABILITY.value != 2) {
	alert('Please Edit This Case Record to specify "Yes" or "No" for Short-term Liability');
	return false;
}
--->

if (thisForm.SHORT_TERM_LIABILITY.value != 2 && thisForm.SHORT_TERM_LIABILITY.value != 100 && thisForm.SHORT_TERM_LIABILITY.value != 200) {
	alert('Please Edit This Case Record to specify "Yes" or "No" for Short-term Liability');
	return false;
}



else return true;

}

function rotate() {

if (document.getElementById("GrayLetters")) {
GrayLetters.innerHTML = grayLettersArray[n];
(n == (grayLettersArrayLen - 1)) ? n = 0 : n++;
window.setTimeout("rotate()", 1000);
}

}

function setRptSelect(thisSelect_Earlier_RptDate) {

selectedDate = thisSelect_Earlier_RptDate.options[thisSelect_Earlier_RptDate.selectedIndex].value;

if (selectedDate == LatestRptDate) location.href='Report.full.cfm';
else location.href='Report.full.cfm?EarlierRptDate=' + selectedDate;

}



function setMgmtSchedSelect(thisSelect_Quarter_RptDate) {

selectedDate = thisSelect_Quarter_RptDate.options[thisSelect_Quarter_RptDate.selectedIndex].value;

location.href='Spreadsheet.MgmtSched.cfm?RptDate=' + selectedDate;

}



function setRptSelectOption(thisSelect_Option, optionTypeParm) {


<!---
	<SELECT NAME="Select_DIVISION_CODE" style="font-family:verdana; font-size:7.5pt; margin-left:-2pt; margin-top:-2pt; margin-bottom:-2pt; background:khaki" SIZE="1" onChange="(this, 'SelectedDiv')">
--->

<!---
alert("thisSelect_Option.options[thisSelect_Option.selectedIndex] = '" + thisSelect_Option.options[thisSelect_Option.selectedIndex] + "'");
--->


selectedOption = thisSelect_Option.options[thisSelect_Option.selectedIndex].value;
<<<<<<< HEAD

=======
>>>>>>> working-branch
//selectedOption = selectedOption.replaceAll(/&/g,"%26");

// alert("Report.topjs.cfm at 148: selectedOption = '" + selectedOption + "'");




if (selectedOption == 0) return false;
else {


locationHrefFile = 'Report.full.cfm'

<CFIF IsDefined("RptDateParm") AND RptDateParm NEQ "">

	<CFOUTPUT>
	+ '#RptDateParm#';
	</CFOUTPUT>

	parmConnector = "&";

<CFELSE>

	parmConnector = "?";

</CFIF>


if (selectedOption == "FULL") location.href = locationHrefFile;

/*
else location.href = locationHrefFile + parmConnector + 'SelectedPC=' + selectedPC;
*/

else {

	if (selectedOption == "FULL_LR") 
	
		location.href = locationHrefFile + parmConnector + "SelectedHQDept=6X // HQ Labor Relations";

	else {

		if (optionTypeParm == "SelectedUnion")

			location.href = locationHrefFile + parmConnector + "SelectedHQDept=6X // HQ Labor Relations" + "&" + optionTypeParm + "=" + selectedOption;

		else location.href = locationHrefFile + parmConnector + optionTypeParm + "=" + selectedOption;

	}

}

}

}





function setRptSelectPC(thisSelect_PC) {

selectedPC = thisSelect_PC.options[thisSelect_PC.selectedIndex].value;

if (selectedPC == 0) return false;
else {

<!---
	if (selectedPC == "ALL") location.href='Report.cfm'
	else location.href='Report.cfm' +

	<CFIF IsDefined("EarlierRptDate")>
		<CFOUTPUT>
		'?EarlierRptDate=#EarlierRptDate#&SelectedPC='
		</cfoutput>
	<CFELSE>
		'?SelectedPC='
	</cfif>

	+ selectedPC;
--->



locationHrefFile = 'Report.full.cfm'

<CFIF IsDefined("RptDateParm") AND RptDateParm NEQ "">

	<CFOUTPUT>
	+ '#RptDateParm#';
	</CFOUTPUT>

	parmConnector = "&";

<CFELSE>

	parmConnector = "?";

</CFIF>


if (selectedPC == "ALL") location.href = locationHrefFile;
else location.href = locationHrefFile + parmConnector + 'SelectedPC=' + selectedPC;



}

}


function setRptSelectHQDept(thisSelect_HQDept) {

selectedHQDept = thisSelect_HQDept.options[thisSelect_HQDept.selectedIndex].value;

if (selectedHQDept == 0) return false;
else {

<!---
	if (selectedHQDept == "ALL") location.href='Report.cfm'
	else location.href='Report.cfm' +

	<CFIF IsDefined("EarlierRptDate")>
		<CFOUTPUT>
		'?EarlierRptDate=#EarlierRptDate#&SelectedHQDept='
		</cfoutput>
	<CFELSE>
		'?SelectedHQDept='
	</cfif>

	+ selectedHQDept;
--->


locationHrefFile = 'Report.full.cfm'

<CFIF IsDefined("RptDateParm") AND RptDateParm NEQ "">

	<CFOUTPUT>
	+ '#RptDateParm#';
	</CFOUTPUT>

	parmConnector = "&";

<CFELSE>

	parmConnector = "?";

</CFIF>

<!---
if (selectedHQDept != "ALL") location.href = locationHrefFile + parmConnector + 'SelectedHQDept=' + selectedHQDept;
--->


if (selectedHQDept == "ALL") location.href = locationHrefFile;
else location.href = locationHrefFile + parmConnector + 'SelectedHQDept=' + selectedHQDept;



}

}


function setConcurrenceForm(thisConcurUser, currentRow) {

thisConcurrenceForm = "ConcurrenceForm_" + currentRow;
if (document.getElementById(thisConcurrenceForm)) eval(thisConcurrenceForm).ConcurUser.value = thisConcurUser;

<!---
if (eval(thisConcurrenceForm).SHORT_TERM_LIABILITY.value != 1 && eval(thisConcurrenceForm).SHORT_TERM_LIABILITY.value != 2) {
	alert('Please click "Edit This Case Record" to specify "Yes" or "No" for Short-term Liability');
	}
--->

if (eval(thisConcurrenceForm).SHORT_TERM_LIABILITY.value != 2 && eval(thisConcurrenceForm).SHORT_TERM_LIABILITY.value != 100 && eval(thisConcurrenceForm).SHORT_TERM_LIABILITY.value != 200) {
	alert('Please click "Edit This Case Record" to specify "Yes" or "No" for Short-term Liability');
	}


else eval(thisConcurrenceForm).submit();

}

function hideOrShowLinksDivs() {

<CFIF IsDefined("Form.CorpFinFormat") AND Form.CorpFinFormat EQ "CorpFinFormat">

hideDivsLinks();
hideAllChecklists();

<CFELSEIF IsDefined("Form.CorpFinFormat") AND Form.CorpFinFormat EQ "">

showDivsLinks();
showAllChecklists();

</cfif>

}

function hideAllChecklists() {

for (j=1; j<=RecCt; j++) {

thisCaseEvaluationChecklistHeader = "CaseEvaluationChecklistHeader_"  + j;
thisCaseEvaluationChecklist = "CaseEvaluationChecklist_" + j;

if (document.getElementById(thisCaseEvaluationChecklist)) {
	eval(thisCaseEvaluationChecklistHeader).style.display = "none";
	eval(thisCaseEvaluationChecklist).style.display = "none";

}

}

}

function hideDivsLinks() {

<CFIF NOT IsDefined("SelectedHQDept")
AND 
NOT IsDefined("SelectedUnion")
AND 
NOT IsDefined("SelectedCategory")>

	if (CaseRecordsRptHeader) CaseRecordsRptHeader.style.display = "none";

<CFELSE>
	
	if (BackToFullReportLink) BackToFullReportLink.style.display = "none";

</cfif>


DocBody.style.background = "white";

if (document.getElementById("IndexKey")) IndexKey.style.display = "none";

for (i=1; i<=RecCt; i++) {

<!--- For protocol changes 2/09, now displaying "Estimated Time to Resolution" (formerly hiding Short-term Liability Y/N): --->
<!---
thisSHORT_TERM_LIABILITY = "SHORT_TERM_LIABILITY_" + i;

if (document.getElementById(thisSHORT_TERM_LIABILITY))
eval(thisSHORT_TERM_LIABILITY).style.display = "none";
--->

thisALT_LAW_DEPT_OFFICE = "ALT_LAW_DEPT_OFFICE_" + i;

if (document.getElementById(thisALT_LAW_DEPT_OFFICE))
eval(thisALT_LAW_DEPT_OFFICE).style.display = "none";

thisCopyNewWindowLink = "CopyNewWindowLink_" + i;

if (document.getElementById(thisCopyNewWindowLink))
eval(thisCopyNewWindowLink).style.display = "none";


thisEditRecLinkDiv = "EditRecLink_" + i;

if (document.getElementById(thisEditRecLinkDiv))
eval(thisEditRecLinkDiv).style.display = "none";

thisUpdReceivedCheckDiv = "UpdReceivedCheck_" + i;
if (document.getElementById(thisUpdReceivedCheckDiv)) eval(thisUpdReceivedCheckDiv).style.display = "none";

thisRecLockedDiv = "RecLocked_" + i;
if (document.getElementById(thisRecLockedDiv)) eval(thisRecLockedDiv).style.display = "none";

thisLockLinkDiv = "LockLink_" + i;
if (document.getElementById(thisLockLinkDiv)) eval(thisLockLinkDiv).style.display = "none";

thisMCUpdDiv = "MCUpd_" + i;
if (document.getElementById(thisMCUpdDiv)) eval(thisMCUpdDiv).style.display = "none";

thisAlt_ApprDiv = "Alt_Appr_" + i;
if (document.getElementById(thisAlt_ApprDiv)) eval(thisAlt_ApprDiv).style.display = "none";

thisUndoApprLinkDiv = "UndoApprLink_" + i;
if (document.getElementById(thisUndoApprLinkDiv)) eval(thisUndoApprLinkDiv).style.display = "none";

thisCaseEvaluationChecklist = "CaseEvaluationChecklist_" + i;
if (document.getElementById(thisCaseEvaluationChecklist)) eval(thisCaseEvaluationChecklist).style.background = "white";

thisRecTable = "RecTable_" + i;
if (document.getElementById(thisRecTable)) eval(thisRecTable).style.background = "white";

thisTableBorderDiv = "TableBorder_" + i;
if (document.getElementById(thisTableBorderDiv)) eval(thisTableBorderDiv).style.border = "none";

}

}

function showAllChecklists() {

for (j=1; j<=RecCt; j++) {

thisCaseEvaluationChecklistHeader = "CaseEvaluationChecklistHeader_"  + j;
/*
thisCaseEvaluationChecklist = "CaseEvaluationChecklist_" + j;
*/

if (document.getElementById(thisCaseEvaluationChecklistHeader)) {
	eval(thisCaseEvaluationChecklistHeader).style.display = "inline";
/*
	eval(thisCaseEvaluationChecklist).style.display = "inline";
*/

}

}

}

function showDivsLinks() {

CaseRecordsRptHeader.style.display = "inline";

/*
DocBody.style.background = "white";
*/

for (i=1; i<=RecCt; i++) {

thisALT_LAW_DEPT_OFFICE = "ALT_LAW_DEPT_OFFICE_" + i;

if (document.getElementById(thisALT_LAW_DEPT_OFFICE))
eval(thisALT_LAW_DEPT_OFFICE).style.display = "inline";

thisCopyNewWindowLink = "CopyNewWindowLink_" + i;

if (document.getElementById(thisCopyNewWindowLink))
eval(thisCopyNewWindowLink).style.display = "inline";


thisEditRecLinkDiv = "EditRecLink_" + i;

if (document.getElementById(thisEditRecLinkDiv))
eval(thisEditRecLinkDiv).style.display = "inline";

thisUpdReceivedCheckDiv = "UpdReceivedCheck_" + i;

if (document.getElementById(thisUpdReceivedCheckDiv)) eval(thisUpdReceivedCheckDiv).style.display = "inline";

thisRecLockedDiv = "RecLocked_" + i;

if (document.getElementById(thisRecLockedDiv)) eval(thisRecLockedDiv).style.display = "inline";

/*
thisCaseEvaluationChecklist = "CaseEvaluationChecklist_" + i;

if (document.getElementById(thisCaseEvaluationChecklist)) eval(thisCaseEvaluationChecklist).style.background = "white";
*/

/*
thisRecTable = "RecTable_" + i;
eval(thisRecTable).style.background = "white";
*/

/*
thisTableBorderDiv = "TableBorder_" + i;
eval(thisTableBorderDiv).style.border = "thin solid maroon";
*/

}

<CFIF IsDefined("Form.MaroonBorderList") AND Form.MaroonBorderList NEQ "">

<CFOUTPUT>
maroonBorderArray = new Array (#Form.MaroonBorderList#);
</cfoutput>

for (j=0; j<maroonBorderArray.length; j++) {

thisTableBorderDiv = "TableBorder_" + maroonBorderArray[j];
if (document.getElementById(thisTableBorderDiv)) eval(thisTableBorderDiv).style.border = "thin solid maroon";

}

</cfif>

}



function hideShowIndexCaseNum() {


if (document.getElementById("HideShowIndexCaseNumLabel")) {

	if (HideShowIndexCaseNumLabel.innerHTML == "Show Case Numbering") {

		HideShowIndexCaseNumLabel.innerHTML = "Hide Case Numbering";

		for (j=1; j<=total_This_Current_IndexRow; j++) {

			thisIndex_CaseNum = "Index_CaseNum_"  + j;

			if (document.getElementById(thisIndex_CaseNum)) eval(thisIndex_CaseNum).style.display = "inline";

			thisTopIndex_Gray = "TopIndex_Gray_" + j;

			if (document.getElementById(thisTopIndex_Gray)) eval(thisTopIndex_Gray).style.display = "none";

			thisReport_Body_CaseNum = "Report_Body_CaseNum_"  + j;

			if (document.getElementById(thisReport_Body_CaseNum)) eval(thisReport_Body_CaseNum).style.display = "inline";

		}

	}

	else {

		HideShowIndexCaseNumLabel.innerHTML = "Show Case Numbering";

		for (j=1; j<=total_This_Current_IndexRow; j++) {

			thisIndex_CaseNum = "Index_CaseNum_"  + j;

			if (document.getElementById(thisIndex_CaseNum)) eval(thisIndex_CaseNum).style.display = "none";

			thisTopIndex_Gray = "TopIndex_Gray_" + j;

			if (document.getElementById(thisTopIndex_Gray)) eval(thisTopIndex_Gray).style.display = "inline";

			thisReport_Body_CaseNum = "Report_Body_CaseNum_"  + j;

			if (document.getElementById(thisReport_Body_CaseNum)) eval(thisReport_Body_CaseNum).style.display = "none";

		}

	}

}

}




function hideShowIndexLink() {

if (document.getElementById("HideShowIndexLabel")) {
	if (HideShowIndexLabel.innerHTML == "Show Index") {
		HideShowIndexLabel.innerHTML = "Hide Index";
		if (document.getElementById("TopIndex")) {
		/*
		TopIndex.style.display = "inline";
		*/

		TopIndex.style.border = "thin solid green";
		TopIndex.innerHTML = OrigTopIndex_innerHTML;
		TopIndex.style.pageBreakAfter = "always";

		}

		}

	else {
		HideShowIndexLabel.innerHTML = "Show Index";
		if (document.getElementById("TopIndex")) {
/*
		TopIndex.style.display = "none";
*/
		OrigTopIndex_innerHTML = TopIndex.innerHTML;
		TopIndex.style.border = "none";
		TopIndex.innerHTML = "";
		TopIndex.style.pageBreakAfter = "auto";
		
		if (document.getElementById("IndexReportBlueBox")) IndexReportBlueBox.style.display = "none";

		}
		}

	}

}

function hideMCEmailForm(currentRow) {

thisMCEmailForm_Div = "DisapprovalCommentDiv_" + currentRow;
if (document.getElementById(thisMCEmailForm_Div)) eval(thisMCEmailForm_Div).style.display = "none";

thisMCApprDisapprLinkDiv = "ApprDisapprLinkDiv_" + currentRow;
if (document.getElementById(thisMCApprDisapprLinkDiv)) eval(thisMCApprDisapprLinkDiv).style.display = "inline";

thisMCApprDisapprStatusDiv = "ApprDisapprStatusDiv_" + currentRow;
if (document.getElementById(thisMCApprDisapprStatusDiv)) eval(thisMCApprDisapprStatusDiv).style.display = "inline";

}

function setMCEmailForm(formPrefix, appr_Flag, currentRow) {

thisApprDisapprLinkDiv = "ApprDisapprLinkDiv_" + currentRow;
if (document.getElementById(thisApprDisapprLinkDiv)) eval(thisApprDisapprLinkDiv).style.display = "none";

thisApprDisapprStatusDiv = "ApprDisapprStatusDiv_" + currentRow;
if (document.getElementById(thisApprDisapprStatusDiv)) eval(thisApprDisapprStatusDiv).style.display = "none";

thisEmailForm = "EmailForm_" + currentRow;

if (formPrefix == "MC") {
if (document.getElementById(thisEmailForm)) eval(thisEmailForm).MC_Approval_Flag.value = appr_Flag;
}

else {
if (formPrefix == "Alt") {
if (document.getElementById(thisEmailForm)) eval(thisEmailForm).Alt_Approval_Flag.value = appr_Flag;
}
}

if (appr_Flag == 2) {
	thisEmailForm_Div = "DisapprovalCommentDiv_" + currentRow;
	eval(thisEmailForm_Div).style.display = "inline";
	eval(thisEmailForm).DisapprovalComment.focus();
	}

else {
if (appr_Flag == 1) eval(thisEmailForm).submit();
}

}

function showCaseEvaluationChecklistDiv(caseNum) {

thisCaseEvaluationChecklistHeader = "CaseEvaluationChecklistHeader_"  + caseNum;
thisCaseEvaluationChecklist = "CaseEvaluationChecklist_" + caseNum;

if (document.getElementById(thisCaseEvaluationChecklist)) {
	eval(thisCaseEvaluationChecklistHeader).innerHTML = "<b>Case Evaluation Checklist</b>";
	eval(thisCaseEvaluationChecklist).style.display = "inline";
}

}

function writeNewWindowInit() {



newCaseWindow.document.write("<head><style>");
/*
newCaseWindow.document.write("span.RecordLink {display:none}");
*/
newCaseWindow.document.write("td {font-family:arial,sans-serif;font-size:10pt; vertical-align:top}");
newCaseWindow.document.write("th {font-family:arial,sans-serif;font-size:10pt; font-weight:bold; width:30%; align:right}");

// Highlight styles from string_compare.routine.cfm

newCaseWindow.document.write("span.Highlight {font-weight:bold; color:red}");

newCaseWindow.document.write("span.Highlight_6 {font-weight:bold; color:red}");

newCaseWindow.document.write("span.Highlight_7 {font-weight:bold; color:red}");

newCaseWindow.document.write("span.Highlight_8 {font-weight:bold; color:red}");

newCaseWindow.document.write("span.Highlight_9 {font-weight:bold; color:red}");

newCaseWindow.document.write("span.Highlight_192 {font-weight:bold; color:red}");

newCaseWindow.document.write("span.Highlight_295 {font-weight:bold; color:red}");




newCaseWindow.document.write("strong {font-weight:bold; color:red}");

newCaseWindow.document.write("</style>");

newCaseWindow.document.write("<link rel='stylesheet' type='text/css' href='stylesheet.css'>");

newCaseWindow.document.write("</head>");

newCaseWindow.document.write("<body style='font-family:arial; font-size:10pt'>");
newCaseWindow.document.write("<div style='background:ffd5aa; padding:3pt; padding-bottom:-20pt; margin-bottom:15pt; font-size:8pt'><div style='text-align:center; margin-bottom:-10pt'><b>NOTE: Saving This Document From the Browser Window</b></div><ul><li>To save this as a Word document, click <b>File</b> > <b>Save As</b>.<li>Then select <b>Save As Type</b> > <b>Text File (.txt)</b>.<li>Then enter a file name ending with <b>.doc</b>.<li>Select an appropriate File Folder, and click the <b>Save</b> button.<li>You can then open the saved document in Word.</ul></div>");

newCaseWindow.document.title = "COPY: DRAFT CONFIDENTIAL Law Department Contingent Liabilities";

}


function writeNewWindow(caseNum) {

/* Does not work:
if (!newCaseWindow) alert("No newCaseWindow")
*/

/*
if (newCaseWindow.closed || newCaseWindowOpen == false) {
*/

/*
var newCaseWindow = null;
*/

if (newCaseWindow == null || newCaseWindow.closed || newCaseWindowOpen == false) {

<CFOUTPUT>
newCaseWindow = window.open ("", "newWin_#SingleRecWindowName_String#", "toolbar=yes, menubar=yes, scrollbars=yes, resizable=yes");
</CFOUTPUT>

newCaseWindowOpen = true;

/* Browser seems to require setTimeout pause to ensure against "Access denied" error when try to write to new window:
*/

/*
setTimeout("writeNewWindowInit()",500)
*/

/* Deleted setTimeout because writeNewWindowInit() was not performing document.write
*/
/*
writeNewWindowInit();
*/
/*
setTimeout("writeNewWindowInit()",500);
*/
setTimeout("writeNewWindowInit(); finishWriteNewWindow(" + caseNum + ")",500);

}

else finishWriteNewWindow(caseNum);


}

function finishWriteNewWindowALLLoop() {

for (i=1; i<=RecCt; i++) {

//	if (i > 1) newCaseWindow.document.write("<div class='CaseEndPageBreak'></div>");

	if (i > 1) newCaseWindow.document.write("&#12;");

	finishWriteNewWindow(i);

}



}

function finishWriteNewWindow(caseNum) {
/*
alert("caseNum = '" + caseNum + "'");
*/
if (caseNum == ALL) finishWriteNewWindowALLLoop()

else {

thisCaseRec = "TableBorder_" + caseNum;

/*
newCaseWindow.document.write(document.getElementById(thisCaseRec).outerHTML);
newCaseWindow.document.write("<p>");
*/



/*
alert("'" + eval(thisCaseRec).innerHTML + "'");
*/

thisMCApprDisapprStatusDiv = "MCApprDisapprStatusDiv_" + caseNum;

if (document.getElementById(thisMCApprDisapprStatusDiv)) {
thisMCApprDisapprStatusDivOrigHTML = document.getElementById(thisMCApprDisapprStatusDiv).innerHTML;
document.getElementById(thisMCApprDisapprStatusDiv).innerHTML = "";
}

thisMCDisapprovalCommentDiv = "MCDisapprovalCommentDiv_" + caseNum;

if (document.getElementById(thisMCDisapprovalCommentDiv)) {
thisMCDisapprovalCommentDivOrigHTML = document.getElementById(thisMCDisapprovalCommentDiv).innerHTML;
document.getElementById(thisMCDisapprovalCommentDiv).innerHTML = "";
}

thisMCApprDisapprLinkDiv = "MCApprDisapprLinkDiv_" + caseNum;

if (document.getElementById(thisMCApprDisapprLinkDiv)) {
thisMCApprDisapprLinkDivOrigHTML = document.getElementById(thisMCApprDisapprLinkDiv).innerHTML;
document.getElementById(thisMCApprDisapprLinkDiv).innerHTML = "";
}


thisCopyNewWindowLink = "CopyNewWindowLink_" + caseNum;

if (document.getElementById(thisCopyNewWindowLink)) {
thisCopyNewWindowLinkOrigHTML = document.getElementById(thisCopyNewWindowLink).innerHTML;
document.getElementById(thisCopyNewWindowLink).innerHTML = "";
}

thisUpdateNeededLink = "UpdateNeededLink_" + caseNum;

if (document.getElementById(thisUpdateNeededLink)) {

thisUpdateNeededLinkOrigHTML = document.getElementById(thisUpdateNeededLink).innerHTML;

document.getElementById(thisUpdateNeededLink).innerHTML = "";

}


thisEditRecLink = "EditRecLink_" + caseNum;

if (document.getElementById(thisEditRecLink)) {

thisEditRecLinkOrigHTML = document.getElementById(thisEditRecLink).innerHTML;

document.getElementById(thisEditRecLink).innerHTML = "";

}

thisCaseEvaluationChecklistHeader = "CaseEvaluationChecklistHeader_"  + caseNum;
thisCaseEvaluationChecklist = "CaseEvaluationChecklist_" + caseNum;

if (document.getElementById(thisCaseEvaluationChecklistHeader)) {

thisCaseEvaluationChecklistHeaderOrigHTML = document.getElementById(thisCaseEvaluationChecklistHeader).innerHTML;

if ( !document.getElementById(thisCaseEvaluationChecklist) || document.getElementById(thisCaseEvaluationChecklist).style.display == "none" ) {
	document.getElementById(thisCaseEvaluationChecklistHeader).innerHTML = "";
	}
else {
	document.getElementById(thisCaseEvaluationChecklistHeader).innerHTML = "<b>Case Evaluation Checklist</b>";
}

}


if (document.getElementById(thisCaseEvaluationChecklist)) {

if (document.getElementById(thisCaseEvaluationChecklist).style.display == "none") {

thisCaseEvaluationChecklistOrigHTML = document.getElementById(thisCaseEvaluationChecklist).innerHTML;

document.getElementById(thisCaseEvaluationChecklist).innerHTML = "";

}

}

/*
newCaseWindow.document.write(eval(thisCaseRec).outerHTML);
*/


newCaseWindow.document.write(document.getElementById(thisCaseRec).outerHTML);
newCaseWindow.document.write("<p>");


if (document.getElementById(thisMCApprDisapprStatusDiv)) document.getElementById(thisMCApprDisapprStatusDiv).innerHTML = thisMCApprDisapprStatusDivOrigHTML;

if (document.getElementById(thisMCDisapprovalCommentDiv)) document.getElementById(thisMCDisapprovalCommentDiv).innerHTML = thisMCDisapprovalCommentDivOrigHTML;

if (document.getElementById(thisMCApprDisapprLinkDiv)) document.getElementById(thisMCApprDisapprLinkDiv).innerHTML = thisMCApprDisapprLinkDivOrigHTML;

if (document.getElementById(thisCopyNewWindowLink))
document.getElementById(thisCopyNewWindowLink).innerHTML = thisCopyNewWindowLinkOrigHTML;

if (document.getElementById(thisEditRecLink))
document.getElementById(thisEditRecLink).innerHTML = thisEditRecLinkOrigHTML;

if (document.getElementById(thisUpdateNeededLink))
document.getElementById(thisUpdateNeededLink).innerHTML = thisUpdateNeededLinkOrigHTML;

if (document.getElementById(thisCaseEvaluationChecklist))
document.getElementById(thisCaseEvaluationChecklist).innerHTML = thisCaseEvaluationChecklistOrigHTML;

if (document.getElementById(thisCaseEvaluationChecklistHeader))
document.getElementById(thisCaseEvaluationChecklistHeader).innerHTML = thisCaseEvaluationChecklistHeaderOrigHTML;

}

newCaseWindow.focus();


}

function setIndexOnly(indexOnlyParm) {

ReturnForm.IndexOnly.value = indexOnlyParm;

<CFIF IsDefined("SelectedCategory")
AND
SelectedCategory NEQ "ALL">

<!---
<CFOUTPUT>
ReturnForm.action = ReturnForm.action + "?SelectedCategory=#SelectedCategory#";
</CFOUTPUT>
--->


<CFOUTPUT>
ReturnForm.action = ReturnForm.action + parmConnector + "SelectedCategory=#SelectedCategory#";
</CFOUTPUT>




</cfif>


ReturnForm.submit();

}


function setCorpFinFormat() {

ReturnForm.CorpFinFormat.value = "CorpFinFormat";
ReturnForm.CorpFinFormat_STL.value = "";
ReturnForm.CorpFinFormatFrontOffcVersion.value = "";
ReturnForm.FrontOffcReviewFormat.value = "";
ReturnForm.submit();

}

function setCorpFinFormat_STL() {

ReturnForm.CorpFinFormat.value = "CorpFinFormat";
ReturnForm.CorpFinFormat_STL.value = "CorpFinFormat_STL";
ReturnForm.CorpFinFormatFrontOffcVersion.value = "";
ReturnForm.FrontOffcReviewFormat.value = "";
ReturnForm.submit();

}

function setCorpFinFrontOffcFormat() {

ReturnForm.CorpFinFormat.value = "CorpFinFormat";
ReturnForm.CorpFinFormat_STL.value = "";
ReturnForm.CorpFinFormatFrontOffcVersion.value = "CorpFinFormatFrontOffcVersion";
ReturnForm.FrontOffcReviewFormat.value = "";
ReturnForm.submit();

}

function unsetCorpFinFormat() {

ReturnForm.CorpFinFormat.value = "";
ReturnForm.CorpFinFormat_STL.value = "";
ReturnForm.CorpFinFormatFrontOffcVersion.value = "";
ReturnForm.FrontOffcReviewFormat.value = "";
ReturnForm.submit();

}

function setFrontOffcReviewFormat() {

ReturnForm.CorpFinFormat.value = "";
ReturnForm.CorpFinFormat_STL.value = "";
ReturnForm.CorpFinFormatFrontOffcVersion.value = "";
ReturnForm.FrontOffcReviewFormat.value = "FrontOffcReviewFormat";
ReturnForm.submit();

}

function unsetFrontOffcReviewFormat() {

ReturnForm.CorpFinFormat.value = "";
ReturnForm.CorpFinFormat_STL.value = "";
ReturnForm.CorpFinFormatFrontOffcVersion.value = "";
ReturnForm.FrontOffcReviewFormat.value = "";
ReturnForm.submit();

}

function removeDRAFT() {

DRAFTHeader.style.display = "none";
removeDRAFTLink.style.display = "none";


// document.title = docTitle.substring(6);

// if (document.title.indexOf("DRAFT") > -1) {

// alert("document.title.indexOf('DRAFT') = " + document.title.indexOf("DRAFT"));

DRAFTStart = document.title.indexOf("DRAFT");
DRAFTEnd = DRAFTStart + 5;
WODraft = document.title.substring(DRAFTStart, DRAFTEnd);
// alert("WODraft = '" + WODraft + "'");
RevTitle = document.title.substring(0, DRAFTStart) + document.title.substring(DRAFTEnd + 1);
// alert("RevTitle = '" + RevTitle + "'");
document.title = RevTitle;

}

function setPrint() {

TopRightLinks.style.display = "none";

// hideDivsLinks();

window.print();

}


function openInfoChgCompatView() {

<!---
/*
if (pageParm && pageParm == "FAQ") {

	helpFileName = "FAQ.htm";
	helpFileWindow = "FAQWindow";

}

else {

	if (pageParm && pageParm == "HardCopy") {

		helpFileName = "HowToUse.htm#Hard Copy Version";
		helpFileWindow = "HowToUseWindow";

	}

	else {

		infoChgCompatViewFileName = "ChgCompatView.htm";
		infoChgCompatViewFileWindow = "ChgCompatViewWindow";

	}

}
*/


infoChgCompatViewFileName = "ChgCompatView.htm";
infoChgCompatViewFileWindow = "ChgCompatViewWindow";


newInfoChgCompatViewFileWindow = window.open(infoChgCompatViewFileName, infoChgCompatViewFileWindow, "height=600pt,width=500pt,scrollbars=yes,toolbar=yes,menubar=yes,resizable=yes");

newInfoChgCompatViewFileWindow.focus();
--->

}






</script>




