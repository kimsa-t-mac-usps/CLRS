<cfinclude template="MfaCookieCheck.cfm">

<!------------------------- Report.ptE.cfm --------------------------->
<!---------------------------------------------------------------------------->
<!--- KS1 --->
	<!---<CFOUTPUT>
		Program = "Report.ptE.cfm at 4"
	</CFOUTPUT>--->
<!---
Query CONTINGENT_LIAB_GetRecord_PrevRpt in Report.cfm
--->



<!--- Junk char  = open single quote: --->
<!--- Junk char  = close single quote: --->
<!--- Junk char  = open double quote: --->
<!--- Junk char  = close double quote: --->

<!--- Junk char  = dash: --->



<tr>

<th align="right" valign="top">
Law Dept Counsel
</th>

<td>

<CFIF COUNSEL_LAW_DEPT EQ "" OR COUNSEL_LAW_DEPT EQ 0>
	_____

<CFELSE>

	<CFSET ThisCOUNSEL_LAW_DEPT = COUNSEL_LAW_DEPT>


	<CFQUERY NAME="EeList_COUNSEL_LAW_DEPT" DATASOURCE="contliab">
	SELECT LASTNAME, FIRSTNAME, SEPARATFLG
	FROM lawdepartment
	WHERE PRIMARYKEY = #ThisCOUNSEL_LAW_DEPT#
	</cfquery>


	<CFSET NewList = Trim(EeList_COUNSEL_LAW_DEPT.LASTNAME) & ", " & Trim(EeList_COUNSEL_LAW_DEPT.FIRSTNAME)>


	<CFIF STATUS_CODE EQ 1 OR STATUS_CODE_SELECTED EQ "1">

		<CFIF ThisReportDate NEQ EarliestReportDate AND PrevReportDate NEQ "">

			<CFSET Prev_ThisCOUNSEL_LAW_DEPT = CONTINGENT_LIAB_GetRecord_PrevRpt.COUNSEL_LAW_DEPT>

			<CFIF Prev_ThisCOUNSEL_LAW_DEPT NEQ "" AND Prev_ThisCOUNSEL_LAW_DEPT NEQ 0>

				<CFQUERY NAME="Prev_EeList_COUNSEL_LAW_DEPT" DATASOURCE="contliab">
				SELECT LASTNAME, FIRSTNAME
				FROM lawdepartment
				WHERE PRIMARYKEY = #Prev_ThisCOUNSEL_LAW_DEPT#
				</cfquery>

				<CFSET OldList = Trim(Prev_EeList_COUNSEL_LAW_DEPT.LASTNAME) & ", " & Trim(Prev_EeList_COUNSEL_LAW_DEPT.FIRSTNAME)>

			<CFELSE>

				<CFSET OldList = "">

			</cfif>

		</cfif>


		<CFINCLUDE TEMPLATE="textcompare.cfm">

	<CFELSE>

		<CFOUTPUT>
		#NewList#
		</cfoutput>


		<CFIF EeList_COUNSEL_LAW_DEPT.SEPARATFLG EQ 'S'>
        
        		<strong>[Former Employee]&nbsp;<span class='ClickEdit'>Click "Edit This Case Record" to update</span></strong>
        
        </CFIF>


	</cfif>

</cfif>

</td>

</tr>

<CFIF COCOUNSEL_LAW_DEPT NEQ "" AND COCOUNSEL_LAW_DEPT NEQ 0>

	<tr>
	
	<th align="right" valign="top">
	Law Dept Co-Counsel
	</th>
	
	<td>
	
	<CFSET ThisCOCOUNSEL_LAW_DEPT = COCOUNSEL_LAW_DEPT>
	
	<CFQUERY NAME="EeList_COCOUNSEL_LAW_DEPT" DATASOURCE="contliab">
	SELECT LASTNAME, FIRSTNAME
	FROM lawdepartment
	WHERE PRIMARYKEY = #ThisCOCOUNSEL_LAW_DEPT#
	</cfquery>
	
	
	<CFSET NewList = Trim(EeList_COCOUNSEL_LAW_DEPT.LASTNAME) & ", " & Trim(EeList_COCOUNSEL_LAW_DEPT.FIRSTNAME)>
	
	<CFIF STATUS_CODE EQ 1 
	OR 
	STATUS_CODE_SELECTED EQ "1">
	
		<CFIF ThisReportDate NEQ EarliestReportDate 
		AND 
		PrevReportDate NEQ "">
		
			<CFSET Prev_ThisCOCOUNSEL_LAW_DEPT = CONTINGENT_LIAB_GetRecord_PrevRpt.COCOUNSEL_LAW_DEPT>
			
			<CFIF Prev_ThisCOCOUNSEL_LAW_DEPT NEQ "" 
			AND 
			Prev_ThisCOCOUNSEL_LAW_DEPT NEQ 0>
			
				<CFQUERY NAME="Prev_EeList_COCOUNSEL_LAW_DEPT" DATASOURCE="contliab">
				SELECT LASTNAME, FIRSTNAME
				FROM lawdepartment
				WHERE PRIMARYKEY = #Prev_ThisCOCOUNSEL_LAW_DEPT#
				</cfquery>
				
				<CFSET OldList = Trim(Prev_EeList_COCOUNSEL_LAW_DEPT.LASTNAME) & ", " & Trim(Prev_EeList_COCOUNSEL_LAW_DEPT.FIRSTNAME)>
			
			<CFELSE>
			
				<CFSET OldList = "">
			
			</cfif>
		
		</cfif>
	

		<CFINCLUDE TEMPLATE="textcompare.cfm">


	<CFELSE>

		<CFOUTPUT>
		#NewList#
		</cfoutput>

	</cfif>


	</td>

	</tr>

<!--- Close <CFIF COCOUNSEL_LAW_DEPT NEQ "" AND COCOUNSEL_LAW_DEPT NEQ 0> --->
</cfif>

<tr>

<th align="right" valign="top">
Law Dept Reporting Office
</th>

<td>

<CFIF LAW_DEPT_OFFICE EQ "" 
OR 
LAW_DEPT_OFFICE EQ 0>

	<span style="color:red; font-weight:bold">[None Selected]</span>&nbsp;<span class="ClickEdit">Click "Edit This Case Record" to select</span>

<CFELSE>

	<CFSET ThisLAW_DEPT_OFFICE = LAW_DEPT_OFFICE>
	
	<CFQUERY NAME="LDOffices_LAW_DEPT_OFFICE" DATASOURCE="contliab">
	SELECT OFFICE
	FROM ldoffices
	WHERE
	
	<!--- Include LAW_DEPT_OFFICE (OFFICE_PRM_KEY in LDOFFICES) for both Northeast Windsor (16) and New York (former code 7) --->
	<CFIF ThisLAW_DEPT_OFFICE EQ 7
	OR
	ThisLAW_DEPT_OFFICE EQ 16>
	
		OFFICE_PRM_KEY = 16
	
	<CFELSE>
	
		OFFICE_PRM_KEY = #ThisLAW_DEPT_OFFICE#
	
	</CFIF>
	
	
	<CFIF ThisReportDateCompare GE 0>

		AND
		DELETE_FLAG IS NULL

	</cfif>
	
	</CFQUERY>
	
	
	<CFIF LDOffices_LAW_DEPT_OFFICE.RecordCount GT 0>
	
		<CFSET TrimLDOffices_LAW_DEPT_OFFICE_OFFICE = Trim(LDOffices_LAW_DEPT_OFFICE.OFFICE)>
	
	<CFELSE>
	
		<CFSET TrimLDOffices_LAW_DEPT_OFFICE_OFFICE = '<span style="color:red; font-weight:bold">[None Selected]</span>&nbsp;<span class="ClickEdit">Click "Edit This Case Record" to select</span>'>
	
	</CFIF>
	
	
	<CFIF Left(TrimLDOffices_LAW_DEPT_OFFICE_OFFICE, 9) EQ "Southeast">
		<CFSET TrimLDOffices_LAW_DEPT_OFFICE_OFFICE = "Southeast">
	</cfif>
	
	
	<CFSET NewList = TrimLDOffices_LAW_DEPT_OFFICE_OFFICE>
	
	<CFIF STATUS_CODE EQ 1 
	OR 
	STATUS_CODE_SELECTED EQ "1">
	
		<CFIF ThisReportDate NEQ EarliestReportDate 
		AND 
		PrevReportDate NEQ "">
		
			<CFSET Prev_ThisLAW_DEPT_OFFICE = CONTINGENT_LIAB_GetRecord_PrevRpt.LAW_DEPT_OFFICE>
			
			<CFIF Prev_ThisLAW_DEPT_OFFICE NEQ "" 
			AND 
			Prev_ThisLAW_DEPT_OFFICE NEQ 0>
			
				<CFQUERY NAME="Prev_LDOffices_LAW_DEPT_OFFICE" DATASOURCE="contliab">
				SELECT OFFICE
				FROM ldoffices
				WHERE
			
				<!--- Include LAW_DEPT_OFFICE (OFFICE_PRM_KEY in LDOFFICES) for both Northeast Windsor (16) and New York (former code 7) --->
				<CFIF Prev_ThisLAW_DEPT_OFFICE EQ 7
				OR
				Prev_ThisLAW_DEPT_OFFICE EQ 16>
				
					OFFICE_PRM_KEY = 16
				
				<CFELSE>
				
					OFFICE_PRM_KEY = #Prev_ThisLAW_DEPT_OFFICE#
				
				</CFIF>
				
				</CFQUERY>
	
	
				<CFSET TrimPrev_LDOffices_LAW_DEPT_OFFICE_OFFICE = Trim(Prev_LDOffices_LAW_DEPT_OFFICE.OFFICE)>
				
				
				<CFIF Left(TrimPrev_LDOffices_LAW_DEPT_OFFICE_OFFICE, 9) EQ "Southeast">
					<CFSET TrimPrev_LDOffices_LAW_DEPT_OFFICE_OFFICE = "Southeast">
				</cfif>
				
				
				<CFSET OldList = TrimPrev_LDOffices_LAW_DEPT_OFFICE_OFFICE>
				
			<CFELSE>
				
				<CFSET OldList = "">
				
			</cfif>
	
		</cfif>


		<CFINCLUDE TEMPLATE="textcompare.cfm">


	<CFELSE>

		<CFOUTPUT>
		#NewList#
		</cfoutput>

	</cfif>

<!--- Close CFELSE <CFIF LAW_DEPT_OFFICE EQ ""  --->
</cfif>

</td>

</tr>



<!---
<tr>

<th>

<p>


In Report.ptE.cfm at 309:<br />

</th>


<td>

<CFIF IsDefined("Get_Single_Record.RecordCount")
AND
Get_Single_Record.RecordCount GT 0>

	<CFOUTPUT>
	Get_Single_Record.RecordCount = #Get_Single_Record.RecordCount#
	</CFOUTPUT>

<CFELSE>

	Get_Single_Record.RecordCount NOT DEFINED

</CFIF>



<CFIF IsDefined("MC_Name")>

	<CFOUTPUT>
	MC_Name = "#MC_Name#"
	</CFOUTPUT>
    
<CFELSE>

	MC_Name NOT DEFINED
    
</CFIF>        

<p>

</td>

</tr>
--->


<CFIF 
(
(
IsDefined("Get_Single_Record.RecordCount")
AND
Get_Single_Record.MC_Name NEQ ""
)
OR
IsDefined("MC_Name")
)
AND
CONCUR_MC NEQ "">


	<tr>

	<th align="right" valign="top">
	Approved by Managing Counsel
	</th>

	<td>


	<CFOUTPUT>


	<CFIF IsDefined("Get_Single_Record.RecordCount")
	AND
	Get_Single_Record.MC_Name NEQ "">

		#Get_Single_Record.MC_Name#

<!---
<br />
#DateFormat(Get_Single_Record.Concur_MC_Date, "m/d/yyyy")#
--->

	<CFELSEIF IsDefined("MC_Name")>

		#MC_Name#

	</CFIF>


	</CFOUTPUT>


	</td>


	</tr>


</CFIF>




<CFIF ALT_LAW_DEPT_OFFICE NEQ "" 
AND 
ALT_LAW_DEPT_OFFICE NEQ 0>

	<!---KS 120823 <CFOUTPUT>
	<tr id="ALT_LAW_DEPT_OFFICE_#This_CurrentRow#">
	</cfoutput>--->
	
	<th align="right" valign="top">
	Alternate Law Dept Office
	</th>
	
	<td>
	
	
	<CFSET ThisALT_LAW_DEPT_OFFICE = ALT_LAW_DEPT_OFFICE>
	
	<CFQUERY NAME="LDOffices_ALT_LAW_DEPT_OFFICE" DATASOURCE="contliab">
	SELECT OFFICE
	FROM ldoffices
	WHERE
	
	<!--- Include LAW_DEPT_OFFICE (OFFICE_PRM_KEY in LDOFFICES) for both Northeast Windsor (16) and New York (former code 7) --->
	<CFIF ThisALT_LAW_DEPT_OFFICE EQ 7
	OR
	ThisALT_LAW_DEPT_OFFICE EQ 16>
	
		OFFICE_PRM_KEY = 16
	
	<CFELSE>
	
		OFFICE_PRM_KEY = #ThisALT_LAW_DEPT_OFFICE#
	
	</CFIF>
	
		
	<CFIF ThisReportDateCompare GE 0>
    
		AND
		DELETE_FLAG IS NULL
	
    </cfif>
	
	</CFQUERY>



	<CFIF LDOffices_ALT_LAW_DEPT_OFFICE.RecordCount GT 0>
	
		<CFSET TrimLDOffices_ALT_LAW_DEPT_OFFICE_OFFICE = Trim(LDOffices_ALT_LAW_DEPT_OFFICE.OFFICE)>
	
	<CFELSE>
	
		<CFSET TrimLDOffices_ALT_LAW_DEPT_OFFICE_OFFICE = '<span style="color:red; font-weight:bold">[None Selected]</span>&nbsp;<span class="ClickEdit">Click "Edit This Case Record" to select</span>'>
	
	</CFIF>
	
	
	<CFIF Left(TrimLDOffices_ALT_LAW_DEPT_OFFICE_OFFICE, 9) EQ "Southeast">
		<CFSET TrimLDOffices_ALT_LAW_DEPT_OFFICE_OFFICE = "Southeast">
	</cfif>
	
	
	<CFSET NewList = TrimLDOffices_ALT_LAW_DEPT_OFFICE_OFFICE>
	
	
	<CFIF STATUS_CODE EQ 1 
	OR 
	STATUS_CODE_SELECTED EQ "1">
	
		<CFIF ThisReportDate NEQ EarliestReportDate 
		AND 
		PrevReportDate NEQ "">
	
			<CFSET Prev_ThisALT_LAW_DEPT_OFFICE = CONTINGENT_LIAB_GetRecord_PrevRpt.ALT_LAW_DEPT_OFFICE>
			
			<CFIF Prev_ThisALT_LAW_DEPT_OFFICE NEQ "" 
			AND 
			Prev_ThisALT_LAW_DEPT_OFFICE NEQ 0>
			
				<CFQUERY NAME="Prev_LDOffices_ALT_LAW_DEPT_OFFICE" DATASOURCE="contliab">
				SELECT OFFICE
				FROM ldoffices
				WHERE
				
				<!--- Include LAW_DEPT_OFFICE (OFFICE_PRM_KEY in LDOFFICES) for both Northeast Windsor (16) and New York (former code 7) --->
				<CFIF Prev_ThisALT_LAW_DEPT_OFFICE EQ 7
				OR
				Prev_ThisALT_LAW_DEPT_OFFICE EQ 16>
				
					OFFICE_PRM_KEY = 16
				
				<CFELSE>
				
					OFFICE_PRM_KEY = #Prev_ThisALT_LAW_DEPT_OFFICE#
				
				</CFIF>
				
				
				</CFQUERY>
				
				
				<CFSET TrimPrev_LDOffices_ALT_LAW_DEPT_OFFICE_OFFICE = Trim(Prev_LDOffices_ALT_LAW_DEPT_OFFICE.OFFICE)>
				
				<CFIF Left(TrimPrev_LDOffices_ALT_LAW_DEPT_OFFICE_OFFICE, 9) EQ "Southeast">
					<CFSET TrimPrev_LDOffices_ALT_LAW_DEPT_OFFICE_OFFICE = "Southeast">
				</cfif>
				
				
				<CFSET OldList = TrimPrev_LDOffices_ALT_LAW_DEPT_OFFICE_OFFICE>
				
			<CFELSE>
				
				<CFSET OldList = "">
				
			</cfif>

<!--- Close <CFIF ThisReportDate NEQ EarliestReportDate  --->				
		</cfif>
			
			
		<CFINCLUDE TEMPLATE="textcompare.cfm">


<!--- From <CFIF STATUS_CODE EQ 1 --->
	<CFELSE>
		
		<CFOUTPUT>
		#NewList#
		</cfoutput>

<!--- Close <CFIF STATUS_CODE EQ 1  --->		
	</cfif>
		
		
	</td>
	
	</tr>

<!--- Close <CFIF ALT_LAW_DEPT_OFFICE NEQ ""  --->
</cfif>


<CFIF Trim(COUNSEL_OTHER) NEQ "">

	<tr>

	<th align="right" valign="top">
	Other Representative for USPS
	</th>
	
	<td>
	
	<CFSET NewList = Trim(COUNSEL_OTHER)>
	
	<CFIF STATUS_CODE EQ 1 OR STATUS_CODE_SELECTED EQ "1">
	
		<CFIF ThisReportDate NEQ EarliestReportDate AND PrevReportDate NEQ "">
			<CFSET OldList = Trim(CONTINGENT_LIAB_GetRecord_PrevRpt.COUNSEL_OTHER)>
		</cfif>
	
		<CFINCLUDE TEMPLATE="textcompare.cfm">
	
	<CFELSE>
	
		<CFOUTPUT>
		#NewList#
		</cfoutput>
	
	</cfif>
	
	</td>
	
	</tr>

</cfif>


<tr>

<th align="right" valign="top">
Facts / Positions 

<br />


<!---
<CFOUTPUT>

TurnOffTextHighlight = "#TurnOffTextHighlight#"
<br />
CASE_NAME = "#CASE_NAME#"
<br />
ListFind(TurnOffTextHighlight, CASE_NAME) = #ListFind(TurnOffTextHighlight, CASE_NAME)#
<p>

</CFOUTPUT>


<CFABORT>
--->



<CFIF
STATUS_CODE NEQ 1
AND
DATE_LAST_UPDATE NEQ ""
AND
(
(
IsDefined("TurnOffTextHighlight")
AND
ListFind(TurnOffTextHighlight, CASE_NAME) EQ 0
)
OR
NOT IsDefined("TurnOffTextHighlight")
)
AND NOT
(
IsDefined("TextHighlight")
AND
TextHighlight EQ "Disabled"
)>


	<div class="NarrDeletion_Note" style="font-size:8pt; font-weight:normal; background:linen; width:140pt; margin-top:5pt; padding:2pt">
    
	Highlighting any revisions made since
	<br />
	Report for
	
	<CFOUTPUT>
	#PrevRptDate_String#:
	</CFOUTPUT>
	
	<div style="margin-top:2pt">
	<span style="color:red; font-weight:bold">New text</span> and <i><b>[deletion]</b></i>
	</div>
	
	</div class="NarrDeletion_Note">

<CFELSEIF
(
IsDefined("TextHighlight")
AND
TextHighlight EQ "Disabled"
)
OR
(
IsDefined("TurnOffTextHighlight")
AND
ListFind(TurnOffTextHighlight, CASE_NAME) GT 0
)>

	<div class="NarrDeletion_Note" style="font-size:8pt; font-weight:bold; background:khaki; width:125pt; margin-top:0pt; padding:2pt; text-align:center">

	[Text highlighting turned off]

	</div class="NarrDeletion_Note">

</CFIF>

</th>


<td>

<CFSET TrimFACTS_POSITIONS_LONG = Trim(FACTS_POSITIONS_LONG)>
<CFSET TrimFACTS_POSITIONS_LONG = Replace(TrimFACTS_POSITIONS_LONG,"\", "", "ALL")>
<CFSET TrimFACTS_POSITIONS_LONG = Replace(TrimFACTS_POSITIONS_LONG, "''''", "'", "ALL")>
<CFSET TrimFACTS_POSITIONS_LONG = Replace(TrimFACTS_POSITIONS_LONG, "''", "'", "ALL")>

<!--- Replace "box" chars with single quotes: --->
<!---
<CFSET TrimFACTS_POSITIONS_LONG = ReplaceList(TrimFACTS_POSITIONS_LONG, "s ,s ", "'s ,s' ")>
--->


<!--- Junk char  = open single quote: --->
<CFSET TrimFACTS_POSITIONS_LONG = Replace(TrimFACTS_POSITIONS_LONG, "", "'", "all")>

<!--- Junk char  = close single quote: --->
<CFSET TrimFACTS_POSITIONS_LONG = Replace(TrimFACTS_POSITIONS_LONG, "", "'", "all")>


<!---

$str = str_replace(chr(145), "'", $str);    // left single quote
$str = str_replace(chr(146), "'", $str);    // right single quote
$str = str_replace(chr(147), '"', $str);    // left double quote
$str = str_replace(chr(148), '"', $str);    // right double quote

--->

<!---
<CFSET TrimFACTS_POSITIONS_LONG = Replace(TrimFACTS_POSITIONS_LONG, chr(147), '"', 'all')>
<CFSET TrimFACTS_POSITIONS_LONG = Replace(TrimFACTS_POSITIONS_LONG, chr(148), '"', 'all')>
--->



<!--- Junk char  = open double quote: --->
<CFSET TrimFACTS_POSITIONS_LONG = Replace(TrimFACTS_POSITIONS_LONG, '', '"', 'all')>

<!--- Junk char  = close double quote: --->
<CFSET TrimFACTS_POSITIONS_LONG = Replace(TrimFACTS_POSITIONS_LONG, '', '"', 'all')>

<!--- Junk char  = dash: --->
<CFSET TrimFACTS_POSITIONS_LONG = Replace(TrimFACTS_POSITIONS_LONG, '', '-', 'all')>

<!--- Replace left and right curly double quotes with ditto marks --->
<CFSET TrimFACTS_POSITIONS_LONG = Replace(TrimFACTS_POSITIONS_LONG, chr(8220), chr(34), "ALL")>
<CFSET TrimFACTS_POSITIONS_LONG = Replace(TrimFACTS_POSITIONS_LONG, chr(8221), chr(34), "ALL")>

<!--- Replace left and right curly single quotes with straight apostrophe --->
<CFSET TrimFACTS_POSITIONS_LONG = Replace(TrimFACTS_POSITIONS_LONG, chr(8216), chr(39), "ALL")>
<CFSET TrimFACTS_POSITIONS_LONG = Replace(TrimFACTS_POSITIONS_LONG, chr(8217), chr(39), "ALL")>

<!---
<!--- Replace inverted question mark and "t" (probably from pasting text with bullet) with hyphen --->
<CFSET TrimFACTS_POSITIONS_LONG = Replace(TrimFACTS_POSITIONS_LONG, "¿t", "- ", "ALL")>
--->


<!--- Replace inverted question mark and "t" (probably from pasting text with bullet) with hyphen --->
<CFSET TrimFACTS_POSITIONS_LONG = Replace(TrimFACTS_POSITIONS_LONG, chr(191) & "t", "- ", "ALL")>


<!--- Replace inverted question mark with hyphen and spaces --->
<CFSET TrimFACTS_POSITIONS_LONG = Replace(TrimFACTS_POSITIONS_LONG, chr(191), " - ", "ALL")>


<!---
<CFOUTPUT>
#TrimFACTS_POSITIONS_LONG#
</CFOUTPUT>
--->



<CFIF 
(
NOT IsDefined("StringCompareMaxOffset")
)
OR
(
IsDefined("TextHighlight")
AND
TextHighlight EQ "Disabled"
)
OR
(
IsDefined("TurnOffTextHighlight")
AND
ListFind(TurnOffTextHighlight, CASE_NAME) GT 0
)>


	<!---<CFOUTPUT>
	#TrimFACTS_POSITIONS_LONG#
	</CFOUTPUT>
--->

<CFELSE>


	<CFIF ThisReportDate NEQ EarliestReportDate AND PrevReportDate NEQ "">
		<CFSET TrimFACTS_POSITIONS_LONG_PREV = Trim(CONTINGENT_LIAB_GetRecord_PrevRpt.FACTS_POSITIONS_LONG)>
	</cfif>


	<CFSET NewList = TrimFACTS_POSITIONS_LONG>


	<CFIF ThisReportDate NEQ EarliestReportDate AND PrevReportDate NEQ "">

		<CFSET TrimFACTS_POSITIONS_LONG_PREV = Trim(CONTINGENT_LIAB_GetRecord_PrevRpt.FACTS_POSITIONS_LONG)>
		<CFSET TrimFACTS_POSITIONS_LONG_PREV = Replace(TrimFACTS_POSITIONS_LONG_PREV,"\", "", "ALL")>
		<CFSET TrimFACTS_POSITIONS_LONG_PREV = Replace(TrimFACTS_POSITIONS_LONG_PREV, "''''", "'", "ALL")>
		<CFSET TrimFACTS_POSITIONS_LONG_PREV = Replace(TrimFACTS_POSITIONS_LONG_PREV, "''", "'", "ALL")>

<!--- Replace "box" chars with single quotes: --->
<!---
<CFSET TrimFACTS_POSITIONS_LONG_PREV = ReplaceList(TrimFACTS_POSITIONS_LONG_PREV, "s ,s ", "'s ,s' ")>
--->


<!--- Junk char  = open single quote: --->
		<CFSET TrimFACTS_POSITIONS_LONG_PREV = Replace(TrimFACTS_POSITIONS_LONG_PREV, "", "'", "all")>

<!--- Junk char  = close single quote: --->
		<CFSET TrimFACTS_POSITIONS_LONG_PREV = Replace(TrimFACTS_POSITIONS_LONG_PREV, "", "'", "all")>


<!---
<CFSET TrimFACTS_POSITIONS_LONG_PREV = Replace(TrimFACTS_POSITIONS_LONG_PREV, chr(147), '"', 'all')>
<CFSET TrimFACTS_POSITIONS_LONG_PREV = Replace(TrimFACTS_POSITIONS_LONG_PREV, chr(148), '"', 'all')>
--->


		<CFSET TrimFACTS_POSITIONS_LONG_PREV = Replace(TrimFACTS_POSITIONS_LONG_PREV, '', '"', 'all')>

		<CFSET TrimFACTS_POSITIONS_LONG_PREV = Replace(TrimFACTS_POSITIONS_LONG_PREV, '', '"', 'all')>


<!--- Junk char  = dash: --->
		<CFSET TrimFACTS_POSITIONS_LONG_PREV = Replace(TrimFACTS_POSITIONS_LONG_PREV, '', '-', 'all')>




<!---<CFOUTPUT>
TrimFACTS_POSITIONS_LONG_PREV = #TrimFACTS_POSITIONS_LONG_PREV#
</CFOUTPUT>
--->



		<CFSET OldList = TrimFACTS_POSITIONS_LONG_PREV>

	</cfif>


	<cfset string1 = replacenocase(OldList, "  ", " ", "all")>
	<cfset string2 = replacenocase(NewList, "  ", " ", "all")>


	<cfset string1 = replacenocase(OldList, "<br>", chr(10), "all")>
	<cfset string2 = replacenocase(NewList, "<br>", chr(10), "all")>


	<CFSET Len_string1 = len(string1)>
	<CFSET Len_string2 = len(string2)>

	<CFSET LenDiff_Str2_Str1 = Len_string2 - Len_string1>


<!--- Moved to string_compare.routine.cfm:--->
<!---<CFSET StringCompareMaxOffset = 1000>--->



<!---     function stringSimilarity(s1, s2, maxOffset): --->
	<cfset comparison_result = stringSimilarity(string1, string2, StringCompareMaxOffset)>

	<cfoutput>

<!---
Len_string1 = #Len_string1#
<br />
Len_string2 = #Len_string2#
<br />
LenDiff_Str2_Str1 = #LenDiff_Str2_Str1#
<br />
StringCompareMaxOffset = #StringCompareMaxOffset#
<p></p>
--->

	#replacenocase(comparison_result.s2, chr(10), "<br>", "all")#
	</cfoutput>


<!--- Close <CFIF NOT IsDefined("StringCompareMaxOffset")> --->
</cfif>



</td>

</tr>



<CFIF IsDefined("spreadsheet_flag")
AND
spreadsheet_flag EQ "S">

	<cfdirectory action="list"
	name="dirQuery"
	directory="#CFFILE_Destination_Dir#"
	sort="name, datelastmodified">
	
	
	<CFIF dirQuery.RecordCount GT 0>
	
		<CFSET This_CASE_REC_ID_SEQUENCE = CLRC_Query_Name & ".CASE_REC_ID_SEQUENCE">
	
		<CFLOOP QUERY="dirQuery">
	
			<CFIF name EQ "CL.Case." & Evaluate(This_CASE_REC_ID_SEQUENCE) & ".GC.xls">
	
				<tr>
				
				<th align="right" valign="top">
				
				<div style="margin-top:15pt; margin-bottom:15pt">
				
				Spreadsheet for
				<br />
				Supporting Calculations
				
				</div>
				
				</th>
				
				
				<td>
				
				<div style="margin-top:15pt; margin-bottom:15pt">
	
				<CFSET savedEasternTime = DateAdd("h", 1, dirQuery.DateLastModified)>
	
	    		<CFOUTPUT>
	
				<a href="#CFFILE_Uploads_Dir_Link##dirQuery.name#" class="formlink" target="_blank" style="font-weight:bold">Spreadsheet attached</a>
	
	        	for FY#RptDateToFmt_FY#, Quarter #RptDateToFmt_FYQuarter#
	
				<CFSET This_spreadsheet_by_displayname = CLRC_Query_Name & ".spreadsheet_by_displayname">
	
		        <div style="font-family:verdana; font-size:8pt; font-style:italic">
	            &middot; Saved #DateFormat(dirQuery.DateLastModified, "m/d/yy")# #TimeFormat(savedEasternTime, "h:mm:ss tt")# Eastern by #Evaluate(This_spreadsheet_by_displayname)#</div>
	
			    </CFOUTPUT>
	
				<cfbreak>
	
				</div>
	
				</td>
	
				</tr>
	
			</CFIF>
	
	    </CFLOOP>
	
<!--- Close 	<CFIF dirQuery.RecordCount GT 0> --->
	</CFIF>
	

<!--- Close <CFIF spreadsheet_flag EQ "S"> --->
</CFIF>




<CFIF NOT 
(
(
IsDefined("Form.CorpFinFormat") 
AND 
Form.CorpFinFormat EQ "CorpFinFormat"
)
OR
(
IsDefined("SelectedCategory") 
AND 
SelectedCategory CONTAINS "Non-HQ"
)
)>

	<CFSET TrimCOMMENT_GENERAL = Trim(COMMENT_GENERAL)>
	
	<CFIF TrimCOMMENT_GENERAL NEQ "">
	
		<tr>
		
		<th align="right" valign="top">
		Comment / Notes
		<br>
		<small>
		<i>(For Law Dept use only.
        
        <br />
		DO NOT EXCEED 
        
        <CFOUTPUT>
        #Comment_Gen_Char_Limit#
        </CFOUTPUT>
        
         CHARACTER LIMIT.)</i>
        <br />
        
        <CFIF Len(TrimCOMMENT_GENERAL) GT 2000>
        	<div style="color:red">
        <CFELSE>
	        <div>
        </CFIF>
        
        
		(Length at last update: 
        <CFOUTPUT>
        #Len(TrimCOMMENT_GENERAL)# characters)
		</CFOUTPUT>

		</div>


        </small>
		
		
		<CFIF DATE_LAST_UPDATE NEQ "">
		
			<div style="font-size:8pt; font-weight:normal; background:linen; width:140pt; margin-top:5pt; padding:2pt">
			Highlighting any revisions made since
			<br />
			Report for
			
			<CFOUTPUT>
			#PrevRptDate_String#:
			</CFOUTPUT>
			
			<div style="margin-top:2pt">
			<span style="color:red; font-weight:bold">New text</span> and <i><b>[deletion]</b></i>
			</div>
			
			</div>
		
		</CFIF>
		
		
		</th>
		
		<td>
		<CFSET TrimCOMMENT_GENERAL = Replace(TrimCOMMENT_GENERAL,"\", "", "ALL")>
		<CFSET TrimCOMMENT_GENERAL = Replace(TrimCOMMENT_GENERAL, "''''", "'", "ALL")>
		<CFSET TrimCOMMENT_GENERAL = Replace(TrimCOMMENT_GENERAL, "''", "'", "ALL")>
		
		<!--- Replace "box" chars with single and double quotes: --->
		<CFSET TrimCOMMENT_GENERAL = ReplaceList(TrimCOMMENT_GENERAL, "s ,s ", "'s ,s' ")>
		
		<!---
		<CFSET TrimCOMMENT_GENERAL = ReplaceList(TrimCOMMENT_GENERAL, ' , ', ' "," ')>
		--->
		
		<!---
		<CFSET TrimCOMMENT_GENERAL = ReplaceList(TrimCOMMENT_GENERAL, 'chr(147),chr(148)', '","')>
		--->
		
		
		<!--- Junk char  = open double quote: --->
		<CFSET TrimCOMMENT_GENERAL = Replace(TrimCOMMENT_GENERAL, '', '"', 'all')>
		
		<!--- Junk char  = close double quote: --->
		<CFSET TrimCOMMENT_GENERAL = Replace(TrimCOMMENT_GENERAL, '', '"', 'all')>
		
		
		<!--- Junk char  = dash: --->
		<CFSET TrimCOMMENT_GENERAL = Replace(TrimCOMMENT_GENERAL, '', '-', 'all')>
		
		
		
		<CFSET NewList = TrimCOMMENT_GENERAL>
		
		
		<CFIF ThisReportDate NEQ EarliestReportDate AND PrevReportDate NEQ "">
		
			<CFSET TrimCOMMENT_GENERAL_PREV = Trim(CONTINGENT_LIAB_GetRecord_PrevRpt.COMMENT_GENERAL)>
			<CFSET TrimCOMMENT_GENERAL_PREV = Replace(TrimCOMMENT_GENERAL_PREV,"\", "", "ALL")>
			<CFSET TrimCOMMENT_GENERAL_PREV = Replace(TrimCOMMENT_GENERAL_PREV, "''''", "'", "ALL")>
			<CFSET TrimCOMMENT_GENERAL_PREV = Replace(TrimCOMMENT_GENERAL_PREV, "''", "'", "ALL")>
			
			<!--- Replace "box" chars with single and double quotes: --->
			<CFSET TrimCOMMENT_GENERAL_PREV = ReplaceList(TrimCOMMENT_GENERAL_PREV, "s ,s ", "'s ,s' ")>
			
			<!---
			<CFSET TrimCOMMENT_GENERAL_PREV = ReplaceList(TrimCOMMENT_GENERAL_PREV, ' , ', ' "," ')>
			--->
			
			<!---
			<CFSET TrimCOMMENT_GENERAL_PREV = ReplaceList(TrimCOMMENT_GENERAL_PREV, 'chr(147),chr(148)', '","')>
			--->
			
			
			<!--- Junk char  = open double quote: --->
			<CFSET TrimCOMMENT_GENERAL_PREV = Replace(TrimCOMMENT_GENERAL_PREV, '', '"', 'all')>
			
			<!--- Junk char  = close double quote: --->
			<CFSET TrimCOMMENT_GENERAL_PREV = Replace(TrimCOMMENT_GENERAL_PREV, '', '"', 'all')>
			
			
			<!--- Junk char  = dash: --->
			<CFSET TrimCOMMENT_GENERAL_PREV = Replace(TrimCOMMENT_GENERAL_PREV, '', '-', 'all')>
			
			
			<CFSET OldList = TrimCOMMENT_GENERAL_PREV>
		
		</cfif>
		
		<CFINCLUDE TEMPLATE="textcompare.cfm">
		
		</td>
		
		</tr>
	
<!--- <CFIF TrimCOMMENT_GENERAL NEQ ""> --->
	</cfif>
	
</cfif>


<CFIF NOT 
(
IsDefined("Form.CorpFinFormat") 
AND 
Form.CorpFinFormat EQ "CorpFinFormat"
)>

	<tr>
	
	<th align="right" valign="top">
	<small><i>Latest Update Response
	<br>
	For Current Report
	</i></small>
	</th>
	<td>
	
	<CFIF DATE_LAST_UPDATE NEQ "">
    
		<CFOUTPUT>
		<small>Date: <i>#DateFormat(DATE_LAST_UPDATE, "m/d/yyyy")#</i></small>
		</cfoutput>
		
		<CFQUERY NAME="Get_Upd_User" DATASOURCE="contliab">
		SELECT EENAME AS TRIM_EENAME
		FROM LDEXTRA
		WHERE
		(
		UPPER(AD_USERID) LIKE UPPER('#Trim(LAST_UPDATE_USER_ID)#%')
		OR
		UPPER(AD_MAILNICKNAME) LIKE UPPER('#Trim(LAST_UPDATE_USER_ID)#%')
		)
		AND
		SEPDATE IS NULL
		</cfquery>
		
		<CFIF Get_Upd_User.RecordCount EQ 1>
        
			<br>
			<CFOUTPUT>
			<small>By: <i>#Get_Upd_User.TRIM_EENAME#</i>
			</cfoutput>
            
		</cfif>
		
	<CFELSE>
    
		<small><b>[None]</b></small>
	
	</cfif>
	
	</td>
	</tr>

</cfif>


<!---
<CFIF NOT 
(
IsDefined("Form.CorpFinFormat") 
AND 
Form.CorpFinFormat EQ "CorpFinFormat"
)>
--->



<CFIF NOT 
(
(
IsDefined("Form.CorpFinFormat") 
AND 
Form.CorpFinFormat EQ "CorpFinFormat"
)
OR
(
IsDefined("SelectedCategory") 
AND 
SelectedCategory CONTAINS "Non-HQ"
)
)>

	<CFINCLUDE TEMPLATE="Report.CEChecklist.cfm">

</cfif>


<!---
AND
Assess_Cutoff_List_Index EQ "Under5Million"
--->


<CFIF NOT
(
IsDefined("Form.CorpFinFormat") 
AND 
Form.CorpFinFormat EQ "CorpFinFormat"
AND
Assess_Cutoff_List_Index EQ "UnderTenMillion"
)>

	<tr>
	<td colspan="2" align="center">
	
	<CFIF IsDefined("Form.CorpFinFormat") AND Form.CorpFinFormat EQ "CorpFinFormat">
	
		<CFIF CLRC_Query_Name EQ Last_CLRC_Query_Name>
	
			<CFSET CLRC_Query_Name_Current_Row = CLRC_Query_Name & ".CurrentRow">
	
			<CFIF Evaluate(CLRC_Query_Name_Current_Row) NEQ Evaluate(Last_CLRC_Query_Name_RecCt)>
				<div class="CaseEndPageBreak"></div>
			</cfif>
	
		<CFELSE>
	
			<div class="CaseEndPageBreak"></div>
	
		</cfif>
	
	<!--- From <CFIF IsDefined("Form.CorpFinFormat") AND Form.CorpFinFormat EQ "CorpFinFormat"> --->
	<CFELSE>
	
		<hr style="width:75pt; color:lightgrey">
		<div class="CaseEndPageBreak"></div>
	
	</cfif>

</td>

</tr>

<!--- From <CFIF NOT (IsDefined("Form.CorpFinFormat") AND Form.CorpFinFormat EQ "CorpFinFormat"
AND
Assess_Cutoff_List_Index EQ "Under5Million")> --->
</cfif>



