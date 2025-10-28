<cfinclude template="MfaCookieCheck.cfm">
<span class="ClickEdit" style="font-weight:bold">Revised June 2010</span>
<!---
<CFOUTPUT>
GetBaseTemplatePath() = "#GetBaseTemplatePath()#"
<br />
GetFileFromPath(GetBaseTemplatePath()) = "#GetFileFromPath(GetBaseTemplatePath())#"
<p>
</CFOUTPUT>
--->

<CFIF GetFileFromPath(GetBaseTemplatePath()) EQ "InsertRecord.cfm">

<p>
This Case Evaluation Checklist must be completed for every new case or claim <i><b>where damages may exceed $1 million</b></i>.
<p>
Please complete this form in its entirety. Click the <b>Submit button at the end</b> to submit it to your Managing Counsel for approval. Once approved, this case becomes part of the Law Department's Report to Corporate Finance if it meets the reporting threshold, as explained below. If the case does not meet the reporting threshold, this checklist form remains available in the online system for updating.

</CFIF>

<!--
https://lawdept.usps.gov/inhouse/framed/conting.liab.htm
-->
<p>
Here is a <b>summary of requirements</b> for reporting your case on this form. (See the <a href="https://lawdept.usps.gov/inhouse/conting.liab.htm" target="_blank">Contingent Liability Protocol</a> for further details.)

<div style="margin-top:25pt">

<div style="font-weight:bold; font-size:15pt; margin-bottom:10pt">
Liability Assessment
</div>

Select the likelihood of a loss, or liability, on the <b>Liability Assessment</b> line.
<ul>
<li><b>Probable</b> means an adverse arbitral, administrative, or judicial decision is likely (more than 50% likelihood).
<li><b>Reasonably Possible</b> means the chance of an adverse decision is less than probable, but more than remote.
<li><b>Remote</b> means the chance of an adverse decision is relatively slight (ten per cent or less).
</ul>
This Liability Assessment is made separately from the Damages Assessment. Be sure to explain the reasons for the Liability Assessment in the Facts/Positions section of this form.

</div>
<div style="margin-top:25pt">

<div style="font-weight:bold; font-size:15pt; margin-bottom:10pt">Damages Assessment</div>

For the Damages Assessment, enter both the <b>Most Likely Payout</b> and the <b>Maximum Reasonable Payout</b>.
<p>
<b><i>If there is only one Damages Assessment amount, enter it for both the Most Likely Payout and the Maximum Reasonable Payout.</i></b>
<p>

<div style="margin-top:25pt">

<div style="font-weight:bold; font-size:15pt; margin-bottom:10pt">Reporting Threshold</div>


The case will be included in the Report to Corporate Finance if it meets the reporting threshold:

<!--- changed 6/22/10: To Max Reasonable from Most Likely --->
<!---
if the Most Likely Payout is $1 million or more</b>.
--->

<!---
if the Maximum Reasonable Payout is $1 million or more</b>.
--->

<!--- changed 11/24/14: Adding Remote $10 million min --->

<li>Liability Assessment of <b>Probable or Reasonably Possible</b> with <b>Maximum Reasonable Payout</b> of <b>$1 million</b> or more, 
<i><b>or</b></i> 

<li>Liability Assessment of <b>Remote</b> with <b>Maximum Reasonable Payout</b> of <b>$10 million</b> or more.

</div>

<div style="margin-top:25pt">

<div style="font-weight:bold; font-size:15pt; margin-bottom:10pt">Facts/Positions</div>

Be sure to explain the rationale for both the Most Likely Payout and the Maximum Reasonable Payout in the Facts/Positions section of this form.

<p>

Divide the <b>narrative</b> in the <b>Facts/Positions</b> section into <b>three parts</b>:
<ol type=I>
<b><li>FACTS AND POSITIONS</b>. The facts of the case and the positions of the parties should be stated succinctly.
<p>
<b><li>ASSESSMENT OF LIABILITY</b>. The rationale for the assessment of an unfavorable result (Probable, Reasonably Possible, or Remote) must be explained.
<p>
<b><li>ASSESSMENT OF DAMAGES</b>. Estimates of the most likely amount of damages and the maximum reasonable amount of damages must be explained. A range of damages may be given. The rationale must be explained where different methodologies are reasonably possible.
</ol>
Be sure to explain the methodology and assumptions relied upon to determine the likelihood of an unfavorable result and to calculate maximum potential and most likely damages. Where damages are continuing, include an estimate of the increase per annum or per quarter. Also include settlement offers.

</div>



