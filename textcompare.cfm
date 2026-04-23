<cfinclude template="MfaCookieCheck.cfm">

<!---
<CFOUTPUT>
OldList = "#OldList#"
<p>
NewList = "#NewList#"
<p>
</cfoutput>
--->


<!---
<CFIF IsDefined("Status_Compare_Flag")>
	<CFOUTPUT>
	Status_Compare_Flag = #Status_Compare_Flag#
    <br />
	</CFOUTPUT>
    
<CFELSE>
Status_Compare_Flag NOT DEFINED.
<br />
</CFIF>
--->



<CFSET DiffFlag = "no">


<CFSET ThisNewList = NewList>
<CFSET ThisNewList = Replace(ThisNewList, "  ", " ", "ALL")>
<CFSET ThisNewList = Replace(ThisNewList, "  ", " ", "ALL")>

<CFSET ThisNewList = Replace(ThisNewList,"\", "", "ALL")>
<CFSET ThisNewList = Replace(ThisNewList, "''''", "'", "ALL")>
<CFSET ThisNewList = Replace(ThisNewList, "''", "'", "ALL")>
<CFSET ThisNewList = Replace(ThisNewList, "''", "'", "ALL")>

<!---
<CFIF UpdateNeededFlag EQ "yes" AND NewList DOES NOT CONTAIN "[Yes or No]">
--->


<CFIF IsDefined("UpdateNeededFlag") 
AND 
UpdateNeededFlag EQ "yes" 
AND 
NewList DOES NOT CONTAIN "[Yes or No]" 
AND 
NewList DOES NOT CONTAIN "[Unspecified]">


<!---
ThisNewList =
--->


	<CFOUTPUT>
	#ThisNewList# 
	</cfoutput>

<CFELSE>

	<CFIF ThisReportDate EQ EarliestReportDate 
	OR 
	(
	IsDefined("Status_Compare_Flag") 
	AND 
	Status_Compare_Flag EQ "yes" AND OldList EQ ""
	)>

<!---
ThisNewList =
--->

		<CFOUTPUT>
		#ThisNewList#
		</cfoutput>

	<CFELSE>

		<CFSET ThisOldList = REReplace(OldList, "&quot;", """", "ALL")>
		<CFSET ThisOldList = Replace(ThisOldList, "   ", " ", "ALL")>
		<CFSET ThisOldList = Replace(ThisOldList, "  ", " ", "ALL")>
		<CFSET ThisOldList = Replace(ThisOldList,"\", "", "ALL")>
		<CFSET ThisOldList = Replace(ThisOldList, "''''", "'", "ALL")>
		<CFSET ThisOldList = Replace(ThisOldList, "''", "'", "ALL")>
		<CFSET ThisOldList = Replace(ThisOldList, "''", "'", "ALL")>


<!---<CFOUTPUT>
Compare(ThisOldList, ThisNewList) = #Compare(ThisOldList, ThisNewList)#
<br />
</CFOUTPUT>--->



		<CFIF Compare(ThisOldList, ThisNewList) NEQ 0>

			<CFSET DiffFlag = "yes">


<!---<CFOUTPUT>
<p>
At 103: DiffFlag = "#DiffFlag#"
<p>
</CFOUTPUT>--->



			<CFSET ThisOldList = JSStringFormat(ThisOldList)>
			<CFSET ThisOldList = Replace(ThisOldList, "\r\n", "<br>", "ALL")>
			<CFSET ThisOldList = Replace(ThisOldList, "<br>", "<br>", "ALL")>
			<CFSET ThisOldList = Replace(ThisOldList,"\", "", "ALL")>
			<CFSET ThisOldList = Replace(ThisOldList, "''''", "'", "ALL")>
			<CFSET ThisOldList = Replace(ThisOldList, "''", "'", "ALL")>
			<CFSET ThisOldList = Replace(ThisOldList, "''", "'", "ALL")>

			<CFSET OldArray = ListToArray(ThisOldList, " ")>

			<CFSET ThisNewList = JSStringFormat(ThisNewList)>
			<CFSET ThisNewList = Replace(ThisNewList, "\r\n", "<br>", "ALL")>
			<CFSET ThisNewList = Replace(ThisNewList, "<br><br>", "<br><br>", "ALL")>
			<CFSET ThisNewList = Replace(ThisNewList,"\", "", "ALL")>
			<CFSET ThisNewList = Replace(ThisNewList, "''''", "'", "ALL")>
			<CFSET ThisNewList = Replace(ThisNewList, "''", "'", "ALL")>
			<CFSET ThisNewList = Replace(ThisNewList, "''", "'", "ALL")>

			<CFSET NewArray = ListToArray(ThisNewList, " ")>

			<CFSET NewListExtraLength = 0>

			<CFSET CrxList = "">

			<CFSET OldArrayLen = ArrayLen(OldArray)>
			<CFSET NewArrayLen = ArrayLen(NewArray)>


<!---<CFOUTPUT>
<p>
OldArrayLen = #OldArrayLen#
<p>
NewArrayLen = #NewArrayLen#
<p>
</cfoutput>--->



			<CFIF NewArrayLen LT OldArrayLen 
			OR 
			(
			OldArrayLen EQ 0 
			AND 
			NewArrayLen GT 0
			) 
			OR 
			(
			OldArrayLen EQ 1 
			AND 
			NewArrayLen EQ 1
			)>

				<CFSET ThisNewList = "<strong>" & ThisNewList & "</strong>">

			<CFELSE>

				<CFSET StartCrx = 0>
				<CFSET EndCrx = 0>
				<CFSET NewArrayIndex = 0>

				<CFLOOP INDEX="OldArrayIndex" FROM="1" TO="#OldArrayLen#">

<!---<CFOUTPUT>
<script language="javascript">
alert("Outer Loop: StartCrx = #StartCrx#; EndCrx = #EndCrx#; NewArrayIndex = #NewArrayIndex#")
</script>
</cfoutput>--->






					<CFIF NewArrayIndex EQ 0>
					
                    	<CFSET NewArrayComparIndex = OldArrayIndex>
					
                    <CFELSE>

						<CFIF NewArrayIndex LT NewArrayLen>
							<CFSET NewArrayIndex = NewArrayIndex + 1>
						</cfif>
	
						<CFSET NewArrayComparIndex = NewArrayIndex> 
					
                    </cfif>




<!---
<CFOUTPUT>
<p>
Outer Loop: 
<br />
StartCrx = #StartCrx#
<br />
EndCrx = #EndCrx#
<br />
NewArrayIndex = #NewArrayIndex#
<br />
NewArrayComparIndex = #NewArrayComparIndex#
<p>
</cfoutput>
--->



<!---
<CFOUTPUT>
<script language="javascript">
alert("OldArray[#OldArrayIndex#] = #OldArray[OldArrayIndex]#; NewArray[#NewArrayComparIndex#] = #NewArray[NewArrayComparIndex]#")
</script>
</cfoutput>
--->



<!---<CFOUTPUT>
<p>
OldArray[#OldArrayIndex#] = #OldArray[OldArrayIndex]#
<br />
NewArray[#NewArrayComparIndex#] = #NewArray[NewArrayComparIndex]#
<p>
</cfoutput>--->



                    <CFSET PhraseFlag = "">

					<CFIF OldArray[OldArrayIndex] NEQ NewArray[NewArrayComparIndex]>

<!---
<CFIF (NewArray[NewArrayComparIndex] CONTAINS "<br>")>

<CFOUTPUT>
<script language="javascript">
alert("NewArray[#NewArrayComparIndex#] = '#NewArray[NewArrayComparIndex]#'")
</script>
</cfoutput>

</cfif>
--->

<!---
<CFSET PunctuationList = ListAppend(PunctuationList, '"')>
<CFSET PunctuationList = ListAppend(PunctuationList, "'")>
<CFSET PunctuationList = ListAppend(PunctuationList, ".")>
<CFSET PunctuationList = ListAppend(PunctuationList, ";")>
<CFSET PunctuationList = ListAppend(PunctuationList, "/")>
<CFSET PunctuationList = ListAppend(PunctuationList, "\")>
--->

	                   	<CFSET OldArrayString = OldArray[OldArrayIndex]>


<!---<CFOUTPUT>
<br>
OldArrayString Before: |#OldArrayString#|
</cfoutput>--->


                    	<CFSET OldArrayString = ReplaceList(OldArrayString, PunctuationList, BlankList)>
                    	<CFSET OldArrayString = Replace(OldArrayString, ",", "")>

<!---
<CFOUTPUT>
<br>
OldArrayString After: |#OldArrayString#|
<br>
</cfoutput>
--->

                    	<CFSET NewArrayString = NewArray[NewArrayComparIndex]>

<!---
<CFOUTPUT>
<br>
NewArrayString Before: |#NewArrayString#|
</cfoutput>
--->

                    	<CFSET NewArrayString = ReplaceList(NewArrayString, PunctuationList, BlankList)>
                    	<CFSET NewArrayString = Replace(NewArrayString, ",", "")>

<!---
<CFOUTPUT>
<br>
NewArrayString After: |#NewArrayString#|
<br>
</cfoutput>
--->


<!---
<CFIF OldArrayString NEQ NewArrayString>
	Old, New different
	<br>
<CFELSE>
	Old, New SAME
	<br>
</cfif>
--->


                    	<CFIF NewArrayString NEQ OldArrayString>

                    		<CFIF StartCrx EQ 0>

                    			<CFSET StartCrx = NewArrayComparIndex>

<!---
<CFOUTPUT>
<script language="javascript">
alert("StartCrx = #StartCrx#")
</script>
</cfoutput>
--->


<!---
<CFOUTPUT>
StartCrx = #StartCrx#
<br />
</cfoutput>
--->


                    		</cfif>

<!---
<CFSET NewArrayIndexStart = NewArrayComparIndex + 1>
--->

							<CFLOOP INDEX="NewArrayIndex" FROM="#(NewArrayComparIndex + 1)#" TO="#NewArrayLen#">

                    			<CFIF OldArray[OldArrayIndex] NEQ NewArray[NewArrayIndex]>
                    				<CFSET EndCrx = NewArrayIndex>

<!---
<CFOUTPUT>
<script language="javascript">
alert("Inner Loop: EndCrx = #EndCrx#")
</script>
</cfoutput>
--->


                    			<CFELSE>

<!---
<CFOUTPUT>
<script language="javascript">
alert("Inner Loop: Match; EndCrx = #EndCrx#")
</script>
</cfoutput>
--->

									<CFLOOP INDEX="PhraseWordIndex" FROM="1" TO="2">
	
										<CFSET OldArrayIndexLookAhead = OldArrayIndex + PhraseWordIndex>
										<CFSET NewArrayIndexLookAhead = NewArrayIndex + PhraseWordIndex>
	
										<CFIF OldArrayIndexLookAhead LE OldArrayLen AND NewArrayIndexLookAhead LE NewArrayLen>
	
											<CFIF OldArray[OldArrayIndexLookAhead] EQ NewArray[NewArrayIndexLookAhead]>
		
												<CFSET PhraseFlag = "PhraseMatch">
		
											</cfif>
	
										<CFELSE>
	
											<CFSET PhraseFlag = "PhraseMatch">
	
										</cfif>
	
									</cfloop>



									<CFIF IsDefined("PhraseFlag") AND PhraseFlag EQ "PhraseMatch">

										<CFIF EndCrx EQ 0>
											<CFSET EndCrx = NewArrayIndex - 1>
										</cfif>
	
										<CFSET CrxList = ListAppend(CrxList, "#StartCrx#,#EndCrx#", ";")>

<!---
<CFOUTPUT>
<script language="javascript">
alert("CrxList = #CrxList#")
</script>
</cfoutput>
--->

<!---
<CFOUTPUT>
CrxList = #CrxList#
<br />
</cfoutput>
--->


										<CFSET StartCrx = 0>
										<CFSET EndCrx = 0>

<!---
<CFOUTPUT>
<script language="javascript">
alert("StartCrx = #StartCrx#; EndCrx = #EndCrx#")
</script>
</cfoutput>
--->


										<CFBREAK>
	
									</cfif>
	
								</cfif>

							</cfloop>


							<CFIF NewArrayIndex GT NewArrayLen>
								<CFSET NewArrayIndex = StartCrx>
							</cfif>

<!--- Close <CFIF NewArrayString NEQ OldArrayString> --->
						</cfif>


<!---
<CFOUTPUT>
<script language="javascript">
alert("After Inner Loop: NewArrayIndex = #NewArrayIndex#")
</script>
</cfoutput>
--->

					<CFELSEIF StartCrx GT 0>
                    
						<CFSET EndCrx = NewArrayIndex - 1>
						<CFSET CrxList = ListAppend(CrxList, "#StartCrx#,#EndCrx#", ";")>

<!---
	<CFOUTPUT>
	<script language="javascript">
	alert("CrxList = #CrxList#")
	</script>
	</cfoutput>
--->

						<CFSET StartCrx = 0>
						<CFSET EndCrx = 0>

<!---
	<CFOUTPUT>
	<script language="javascript">
	alert("StartCrx = #StartCrx#; EndCrx = #EndCrx#")
	</script>
	</cfoutput>
--->

					</cfif>

				</cfloop>

<!--- If text was completely replaced:
--->
				<CFIF CrxList EQ "" AND EndCrx EQ NewArrayLen>
					<CFSET CrxList = ListAppend(CrxList, "#StartCrx#,#EndCrx#", ";")>
				</cfif>


<!---<CFOUTPUT>
<b>
CrxList = "#CrxList#"</b>
<p>
</cfoutput>--->


				<CFIF CrxList NEQ "">

<!---
<CFOUTPUT>
<b>CrxList = "#CrxList#"</b>
<p>
</cfoutput>
--->

					<CFSET CrxArray = ListToArray(CrxList, ";")>
					<CFSET CrxArrayLen = ArrayLen(CrxArray)>

					<CFLOOP INDEX="CrxArrayIndex" FROM="1" TO="#CrxArrayLen#">

						<CFSET StartCrx = ListGetAt(CrxArray[CrxArrayIndex], 1)>

<!---
<CFOUTPUT>
StartCrx = #StartCrx#
<br>
</cfoutput>
--->

						<CFSET NewStartCrxVal = "<strong>" & ListGetAt(ThisNewList, StartCrx, " ")>

<!---
<CFOUTPUT>
NewStartCrxVal = "#NewStartCrxVal#"
<br />
</CFOUTPUT>
--->



						<CFSET ThisNewList = ListSetAt(ThisNewList, StartCrx, "#NewStartCrxVal#", " ")>

						<CFSET EndCrx = ListGetAt(CrxArray[CrxArrayIndex], 2)>

<!---
<CFOUTPUT>
EndCrx = #EndCrx#
<p>
</cfoutput>
--->

						<CFSET NewEndCrxVal = ListGetAt(ThisNewList, EndCrx, " ") & "</strong>">

<!---
<CFOUTPUT>
NewEndCrxVal = "#NewEndCrxVal#"
<br />
</CFOUTPUT>
--->



						<CFSET ThisNewList = ListSetAt(ThisNewList, EndCrx, "#NewEndCrxVal#", " ")>

						<CFSET NewListExtraLength = NewListExtraLength + (EndCrx - StartCrx) + 1>

					</cfloop>


<!---
<CFOUTPUT>

ListLen(ThisNewList, " ") = #ListLen(ThisNewList, " ")#
<br />

ListLen(ThisOldList, " ") = #ListLen(ThisOldList, " ")#
<br />

NewListExtraLength = #NewListExtraLength#
<br />

</CFOUTPUT>
--->



					<CFIF ListLen(ThisNewList, " ") GT (ListLen(ThisOldList, " ") + NewListExtraLength)>

						<CFSET NewStartCrxPos = ListLen(ThisOldList, " ") + NewListExtraLength + 1>

						<CFSET NewStartCrxVal = "<strong>" & ListGetAt(ThisNewList, NewStartCrxPos, " ")>

						<CFSET ThisNewList = ListSetAt(ThisNewList, NewStartCrxPos, NewStartCrxVal, " ")>


<!---<CFSET NewEndCrxVal = ListLast(NewList, " ") & "</strong>">
<CFSET NewList = ListSetAt(NewList, NewEndCrxPos, "#NewEndCrxVal#", " ")>--->


						<CFSET ThisNewList = ThisNewList & "</strong>">

					</cfif>


<!--- From <CFIF CrxList NEQ ""> --->
				<CFELSE>
<!--- If new text not equal to old, but no changes found within old version, assume new text added at end: --->

					<CFIF NewArrayLen GT 1>
                   
	                    <CFIF ListLen(ThisNewList, " ") EQ ListLen(ThisOldList, " ")>
							<CFSET NewStartCrxPos = ListLen(ThisNewList, " ")>                    
						<CFELSE>
							<CFSET NewStartCrxPos = ListLen(ThisOldList, " ") + 1>
						</CFIF>

					<CFELSE>

						<CFSET NewStartCrxPos = 1>

					</cfif>
                    
<!---                
<!---  Added to stop error message for user JPT --->                    
					<CFSET NewStartCrxPos = NewStartCrxPos - 1>
<!---  Added to stop error message for user JPT --->                      
--->


					<CFSET NewStartCrxVal = "<strong>" & ListGetAt(ThisNewList, NewStartCrxPos, " ")>


					<CFSET ThisNewList = ListSetAt(ThisNewList, NewStartCrxPos, NewStartCrxVal, " ")>


					<CFSET ThisNewList = ThisNewList & "</strong>">


<!--- Close <CFIF CrxList NEQ ""> --->
				</cfif>
	


<!--- Close <CFIF NewArrayLen LT OldArrayLen>: --->
			</cfif>


			<CFIF IsDefined("Form.CorpFinFormat") 
			AND 
			Form.CorpFinFormat EQ "CorpFinFormat" 
			AND NOT 
			(
			IsDefined("Form.CorpFinFormatFrontOffcVersion") 
			AND 
			Form.CorpFinFormatFrontOffcVersion EQ "CorpFinFormatFrontOffcVersion"
			)>

				<CFSET ThisNewList = RedBoldToggleSpan & ThisNewList & "</span>">

			</cfif>



<!---
ThisNewList =
--->

			<CFOUTPUT>
			#ThisNewList#
			</cfoutput>

<!--- From <CFIF Compare(ThisOldList, ThisNewList) NEQ 0> --->
		<CFELSE>


			<CFIF IsDefined("Form.CorpFinFormat") 
			AND 
			Form.CorpFinFormat EQ "CorpFinFormat" 
			AND NOT 
			(
			IsDefined("Form.CorpFinFormatFrontOffcVersion") 
			AND 
			Form.CorpFinFormatFrontOffcVersion EQ "CorpFinFormatFrontOffcVersion"
			)>

				<CFSET ThisOldList = RedBoldToggleSpan & ThisOldList & "</span>">

			</cfif>


<!---
ThisOldList =
--->

			<CFOUTPUT>
			#ThisOldList# 
			</cfoutput>

<!---
<br>
[No Changes]
--->

<!--- Close <!--- From <CFIF Compare(ThisOldList, ThisNewList) NEQ 0> ---> --->
		</cfif>

<!--- Close <CFIF ThisReportDate EQ EarliestReportDate OR (IsDefined("Status_Compare_Flag") AND Status_Compare_Flag EQ "yes" AND OldList EQ "")> --->
	</cfif>


<!--- Close <CFIF IsDefined("UpdateNeededFlag") AND UpdateNeededFlag EQ "yes" AND NewList DOES NOT CONTAIN "[Yes or No]" AND NewList DOES NOT CONTAIN "[Unspecified]"> --->
</cfif>

<!---
<CFOUTPUT>
<p>
DiffFlag = "#DiffFlag#"
<p>
</CFOUTPUT>
--->




