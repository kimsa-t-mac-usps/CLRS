<cfinclude template="MfaCookieCheck.cfm">

<!---
Included in:

Report.ptB.cfm
Report.ptD.cfm
EditRecord.ptC.cfm

--->

<!---
NOTES: 
-- Status Code range 11-30 reserved for Codes for cases to be removed from report
-- "CFSET Status_Code_Order" in application.cfm
--->

<CFSWITCH EXPRESSION="#Status_Code_Var#">

<CFCASE VALUE="1">
	<CFSET Status_Code_Label = "New This Quarter1">
    <CFSET HideShowButton_String = "">
</cfcase>

<CFCASE VALUE="2">
	<CFSET Status_Code_Label = "No Change Since Last Report">
    <CFSET HideShowButton_String = "No Change">
</cfcase>


<!--- Dropped status_code 3, which is now split between 7 (chg in liab assessment) and 4 (chg in damages assessment) --->

<!---<CFCASE VALUE="3">
	<CFSET Status_Code_Label = "Change in Damages Assessment or Amount Sought (Still Meets Threshold)">
    <CFSET HideShowButton_String = "Update">
</cfcase>--->


<!---
3/27/08 Status Code 4 added and used only as workaround for CILO cases not previously entered in this system, where below reporting threshold
--->
<!--- 3/4/09 Added status_code 4: Dropped status_code 3, which is now split between 7 (chg in liab assessment) and 4 (chg in damages assessment) --->
<CFCASE VALUE="4">

	<CFSET Status_Code_Label = 'Change in Damages Assessment or Amount Sought (Still Meets Threshold)'>
	<!---<CFSET Status_Code_Label = '<span id="StillMeetsThresholdNote">' & Status_Code_Label & '</span>'>--->

    <CFSET HideShowButton_String = "">

</cfcase>


<CFCASE VALUE="5">
	<CFSET Status_Code_Label = "Settlement, Not Yet Final and Paid">
    <CFSET HideShowButton_String = "Update">
</cfcase>

<CFCASE VALUE="6">
	<CFSET Status_Code_Label = "Unfavorable Decision, Not Yet Final and Paid">
    <CFSET HideShowButton_String = "Update">
</cfcase>


<CFCASE VALUE="7">
	<CFSET Status_Code_Label = "Change in Liability Assessment">
    <CFSET HideShowButton_String = "Update">
</cfcase>


<CFCASE VALUE="8">


<!--- Added "or Revision in Text" -- At request of Maria Valentin (Bob Sindermann 3/30/2015) --->
	<CFSET Status_Code_Label = "Additional Facts or Revision in Text">
    <CFSET HideShowButton_String = "Update">
</cfcase>


<CFCASE VALUE="9">


<!--- Added "or Maximum Reasonable Payout" -- At request of Maria Valentin (Bob Sindermann 3/30/2015) --->
    
	<CFSET Status_Code_Label = "Revised Most Likely Payout or Maximum Reasonable Payout">
    <CFSET HideShowButton_String = "Update">
</cfcase>


<CFCASE VALUE="10">
	<CFSET Status_Code_Label = "[Unused]">
    <CFSET HideShowButton_String = "">
</cfcase>

<!---
NOTE: Status Code range 11-30 reserved for Codes for cases to be removed from report
--->

<CFCASE VALUE="11">
	<CFSET Status_Code_Label = "Favorable Decision">
    <CFSET HideShowButton_String = "Remove">
</cfcase>

<CFCASE VALUE="12">
	<CFSET Status_Code_Label = "Unfavorable Decision, Final and Paid">
    <CFSET HideShowButton_String = "Remove">
</cfcase>

<CFCASE VALUE="13">
	<CFSET Status_Code_Label = "Settlement, Final and Paid">
    <CFSET HideShowButton_String = "Remove">
</cfcase>

<CFCASE VALUE="14">
	<CFSET Status_Code_Label = "Withdrawn">
    <CFSET HideShowButton_String = "Remove">
</cfcase>

<CFCASE VALUE="15">
	<CFSET Status_Code_Label = "Reassessed; No Longer Meets Threshold">
    <CFSET HideShowButton_String = "Remove">
</cfcase>



<CFDEFAULTCASE>
	<CFSET Status_Code_Label = "[Unspecified]">
</CFDEFAULTCASE>

</cfswitch>


<!---
Either
<CFSET StatusCodeText = Status_Code_Label>
Or
<CFSET PrevStatusCodeText = Status_Code_Label>

--->



