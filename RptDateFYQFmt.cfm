<cfinclude template="MfaCookieCheck.cfm">
<CFSET RptDateToFmt_CalYear = DatePart("yyyy", RptDateToFmt)>


<CFSET RptDateToFmt_CalQuarter = DatePart("q", RptDateToFmt)>

<CFSET RptDateToFmt_CalQuarter_Num = LSParseNumber(RptDateToFmt_CalQuarter)>

<CFIF RptDateToFmt_CalQuarter_Num EQ 4>
	<CFSET RptDateToFmt_CalQuarter_Num = 0>
</cfif>

<CFSET RptDateToFmt_FYQuarter = RptDateToFmt_CalQuarter_Num + 1>


<!---
<CFOUTPUT>
<p>
RptDateFYQFmt.cfm at 17: 

<br />
RptDateToFmt = "#RptDateToFmt#"

<br />
RptDateToFmt_CalYear = "#RptDateToFmt_CalYear#"
<br />
RptDateToFmt_CalQuarter = "#RptDateToFmt_CalQuarter#"
<br />
RptDateToFmt_CalQuarter_Num = "#RptDateToFmt_CalQuarter_Num#"
<br />

RptDateToFmt_FYQuarter = "#RptDateToFmt_FYQuarter#"

<br />



<p>


</CFOUTPUT>
--->







<!--- For End of Year report --->
<CFIF RptDateToFmt GT "10/1/#RptDateToFmt_CalYear#" AND RptDateToFmt LT "12/1/#RptDateToFmt_CalYear#">

	<CFSET RptDateFmtString = "FY " & RptDateToFmt_CalYear & ", End of Year">

	<CFSET SingleRecWindowName_String = "FY" & RptDateToFmt_CalYear & "EOY">

	<CFSET ReportDate_String = "FY" & RptDateToFmt_CalYear & " EOY">

	<CFSET RptDateToFmt_FY = RptDateToFmt_CalYear + 1>

<!--- For Quarter report --->
<CFELSE>


	<CFIF RptDateToFmt LT "10/1/#RptDateToFmt_CalYear#">
		<CFSET RptDateToFmt_FY = RptDateToFmt_CalYear>
	<CFELSE>
		<CFSET RptDateToFmt_FY = RptDateToFmt_CalYear + 1>
	</cfif>


<!---
<CFOUTPUT>
<p>
RptDateToFmt_FY = "#RptDateToFmt_FY#"
<p>
</CFOUTPUT>
--->





	<CFSWITCH EXPRESSION="#RptDateToFmt_FYQuarter#">

		<CFCASE VALUE="1">
			<CFSET RptDateToFmt_FYQuarter_Roman = "I">
		</cfcase>

		<CFCASE VALUE="2">
			<CFSET RptDateToFmt_FYQuarter_Roman = "II">
		</cfcase>

		<CFCASE VALUE="3">
			<CFSET RptDateToFmt_FYQuarter_Roman = "III">
		</cfcase>

		<CFCASE VALUE="4">
			<CFSET RptDateToFmt_FYQuarter_Roman = "IV">
		</cfcase>

	</cfswitch>


	<CFSET RptDateFmtString = "FY " & RptDateToFmt_FY & ", Quarter " & RptDateToFmt_FYQuarter_Roman>

<!--- 
Crx 4/17/2018: Chg CalYear to FY, was giving incorrect date for previous quarter

	<CFSET SingleRecWindowName_String = "FY" & RptDateToFmt_CalYear & "Q" & RptDateToFmt_FYQuarter_Roman>
	<CFSET ReportDate_String = "FY" & RptDateToFmt_CalYear & " Q" & RptDateToFmt_FYQuarter>
--->


	<CFSET SingleRecWindowName_String = "FY" & RptDateToFmt_FY & "Q" & RptDateToFmt_FYQuarter_Roman>
	<CFSET ReportDate_String = "FY" & RptDateToFmt_FY & " Q" & RptDateToFmt_FYQuarter>



</cfif>



<!---
<CFOUTPUT>
<p>
#RptDateToFmt_FY#, Quarter #RptDateToFmt_FYQuarter#
<p>
</CFOUTPUT>


<cfabort>
--->






