<cfinclude template="MfaCookieCheck.cfm">

<CFIF FormField EQ "Assessment Amount">
<!---
	<CFSET InstrucAmtDivMargBottom = "margin-bottom:-15pt">
--->
	<CFSET InstrucAmtDivMargBottom = "margin-bottom:-5pt">
<CFELSE>
	<CFSET InstrucAmtDivMargBottom = "">
</cfif>
<CFOUTPUT>
<div style="font-family:verdana; font-size:7.5pt; font-style:italic; width:100%; #InstrucAmtDivMargBottom#">
</CFOUTPUT>


<CFIF FormField EQ "Assessment Amount">

<b>Most Likely Payout must be less than or equal to Maximum Reasonable Payout.</b>
<br />
If there is only <b>one</b> Damages Assessment amount, 
<br />
enter it as <b>both</b> the Most Likely Payout and the Maximum Reasonable Payout.
<br>

</CFIF>

Enter 

<CFIF FormField EQ "Amount Sought">
amount(s) 
<CFELSEIF FormField EQ "Assessment Amount">
amounts
</cfif>

with up to one decimal place and no comma. 
<br>
If less than $1 Million, use decimal amount. E.g., for <b>$400,000</b>, use <b><u>0</u>.4</b>

</div>



