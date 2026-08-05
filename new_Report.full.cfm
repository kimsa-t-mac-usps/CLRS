<cfinclude template="cfswitch.serveraddr_id.cfm">
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="stylesheet.css">
    <title>
        <cfoutput>#ServerID#</cfoutput>
        <cfif NOT structKeyExists(variables, "EarlierRptDate")>DRAFT</cfif>
        CONFIDENTIAL Law Department Contingent Liabilities
    </title>
</head>
<body>
<cfinclude template="MfaCookieCheck.cfm">

<cfscript>
    // Determine the Record ID from form or URL parameter
    if (structKeyExists(form, "RecID") AND form.RecID NEQ "") {
        thisRecID = form.RecID;
    } else if (structKeyExists(variables, "RecIDParm")) {
        thisRecID = RecIDParm;
    }

    // Build report date parameter string
    if (structKeyExists(variables, "EarlierRptDate")) {
        rptDateParm = "?EarlierRptDate=" & EarlierRptDate;
    } else {
        rptDateParm = "";
    }
</cfscript>

<!--- Routine for highlighting text differences since previous Quarter report --->
<cfinclude template="string_compare.routine.cfm">

<cfscript>
    RptDateToFmt = ThisReportDate;
</cfscript>
<cfinclude template="RptDateFYQFmt.cfm">

<!--- Contains link to stylesheet; contains various JavaScript routines and functions --->
<cfinclude template="Report.topjs.cfm">

<!--- Check whether user authorized to access CL system and scope of authorization --->
<cfinclude template="CheckUserAuth.cfm">

<!--- Top part of Report page: banner heading, queries for cases based on authorization --->
<cfinclude template="Report.ptA.cfm">

<!--- Green box in upper-right: Links to New Case form, Protocol, Report format, etc. --->
<cfinclude template="TopRightLinksDiv.cfm">

<!--- Form with parms to return to Report.full.cfm after selecting Report scope option --->
<cfinclude template="ReturnForm.cfm">

<cfscript>
    // Helper flags to reduce repetitive isDefined checks
    isCorpFinFormat = (structKeyExists(form, "CorpFinFormat") AND form.CorpFinFormat EQ "CorpFinFormat");
    isFrontOffcReviewFormat = (structKeyExists(form, "FrontOffcReviewFormat") AND form.FrontOffcReviewFormat EQ "FrontOffcReviewFormat");
    isCorpFinFormat_STL = (structKeyExists(form, "CorpFinFormat_STL") AND form.CorpFinFormat_STL EQ "CorpFinFormat_STL");
    isSpecialFormat = (isCorpFinFormat OR isFrontOffcReviewFormat OR isCorpFinFormat_STL);

    isIndexOnly = (structKeyExists(form, "IndexOnly") AND form.IndexOnly EQ "IndexOnly");
    hasSelectedPC = structKeyExists(variables, "SelectedPC");
    hasSelectedDiv = structKeyExists(variables, "SelectedDiv");
    hasSelectedHQDept = structKeyExists(variables, "SelectedHQDept");

    currentCount = CONTINGENT_LIAB_GetRecord_Current_Count.Current_Count;
    exceedsCutoff = (currentCount GT IndexOnlyCaseCountCutoff);
</cfscript>

<cfscript>
    // Determine previous report date parameter
    if (
        (isIndexOnly OR (exceedsCutoff AND NOT isIndexOnly AND NOT hasSelectedPC AND NOT hasSelectedDiv AND NOT hasSelectedHQDept))
        AND ThisReportDate NEQ EarliestReportDate
        AND PrevReportDate NEQ ""
    ) {
        PrevReportDate_Parm = dateFormat(PrevReportDate, "mm/dd/yyyy");
    } else {
        PrevReportDate_Parm = "";
    }

    ThisReportDate_Parm = dateFormat(ThisReportDate, "mm/dd/yyyy");
</cfscript>

<cfif currentCount EQ 0>

    <b>[No Records found.]</b>

<cfelse>

    <cfscript>
        Old_CASE_TYPE_Label = "";
        Old_ASSESSMENT_PROBABILITY_Label = "";
        Old_CLAIM_CATEGORY_Label = "";
        ASSESSMENT_PROBABILITY_Label_Count = 1;
    </cfscript>

    <cfif currentCount GT 1>

        <cfscript>
            This_Current_IndexRow = 0;
            This_CurrentRow = 0;
        </cfscript>

        <cfif NOT isSpecialFormat>

            <cfif exceedsCutoff>

                <div id="IndexReportBlueBox" style="font-weight:bold; background:#bfdfff; padding:5pt; margin-bottom:10pt; font-size:10pt; width:50%">

                <cfif isIndexOnly OR (NOT isIndexOnly AND NOT hasSelectedPC AND NOT hasSelectedDiv AND NOT hasSelectedHQDept)>

                    <cfscript>
                        IndexOnlyDirectionsDiv_Display = "yes";
                    </cfscript>

                    <span id="IndexOnlyLink" style="color:gray">[Index&#8209;Only]</span>&nbsp;&nbsp;/&nbsp;&nbsp;<span id="FullReportLink"><a href="javascript: setIndexOnly('FullReport')">Index&nbsp;+&nbsp;Case&nbsp;Reports</a></span>

                <cfelse>

                    <span id="IndexOnlyLink"><a href="javascript: setIndexOnly('IndexOnly')">Index&#8209;Only</a></span>&nbsp;&nbsp;/&nbsp;&nbsp;<span id="FullReportLink" style="color:gray">[Index&nbsp;+&nbsp;Case&nbsp;Reports]</span>

                </cfif>

                </div>

                <cfif structKeyExists(variables, "IndexOnlyDirectionsDiv_Display") AND IndexOnlyDirectionsDiv_Display EQ "yes">

                    <div id="IndexOnlyDirectionsDiv" style="font-weight:normal; font-size:8pt; font-family:verdana; padding:5pt; margin-top:5pt; margin-bottom:20pt; background:#ffd5aa; width:50%">
                        This is <b>Index-Only Display:</b> Click a case name below; the case report will appear in a new window. You can toggle between this window and the new window.
                        <p style="margin-top:5pt">
                        For the <b>Index and all Case Reports</b>, click "Index&nbsp;+&nbsp;Case&nbsp;Reports," above.
                        </p>
                        <p style="margin-top:5pt">
                        <input type="checkbox" name="TextHighlightingDisable" id="TextHighlightingDisable" value="yes" style="float:left">
                        <b>Turn off text highlighting</b> in Facts&nbsp;/&nbsp;Positions narrative [for faster display of Case Reports]
                        </p>
                        <cfinclude template="Warning.Banner.cfm">
                    </div>

                <cfelse>

                    <div style="margin-top:20pt; margin-bottom:20pt; width:50%">
                        &nbsp;
                        <cfinclude template="Warning.Banner.cfm">
                    </div>

                </cfif>

            </cfif><!--- exceedsCutoff --->

        </cfif><!--- NOT isSpecialFormat --->

        <!--- Display Index of retrieved cases --->
        <cfinclude template="Report.TopIndexDiv.cfm">

    </cfif><!--- currentCount GT 1 --->

    <!--- Full case report display (excluded for STL, Index-Only, or large count without filters) --->
    <cfif NOT isCorpFinFormat_STL
        AND NOT isIndexOnly
        AND NOT (exceedsCutoff AND NOT isIndexOnly AND NOT hasSelectedPC AND NOT hasSelectedDiv AND NOT hasSelectedHQDept)>

        <cfscript>
            RowNum = 0;
            Old_CASE_TYPE_Label = "";
            Old_ASSESSMENT_PROBABILITY_Label = "";
            Old_CLAIM_CATEGORY_Label = "";
            HeaderParm = "Body";
            Case_Type_List = "Liabilities,Receivables";
        </cfscript>

        <!--- Set assessment cutoff and current/removed lists based on report format --->
        <cfif isSpecialFormat>
            <cfscript>
                Assess_Cutoff_List_Reverse = "TenMillionAndAbove,NewTenMillionAndAbove";
                Assess_Cutoff_List = "NewTenMillionAndAbove,TenMillionAndAbove";
                Current_Removed_List = "New,Removed,Current";
            </cfscript>
        <cfelse>
            <cfscript>
                Assess_Cutoff_List_Reverse = "UnderTenMillion,TenMillionAndAbove";
                Assess_Cutoff_List = "TenMillionAndAbove,UnderTenMillion";
            </cfscript>
        </cfif>

        <cfscript>
            Last_CLRC_Query_Name = "";
            QueryNamePrefix = "MainReport";
        </cfscript>

        <cfinclude template="cfloop.cur_rem.casetype.assesscutoff.recct.cfm">

        <!--- Has INCLUDEs for Report.ptB.cfm - Report.ptE.cfm --->
        <cfinclude template="cfloop.cur_rem.casetype.assesscutoff.output.cfm">

        <!--- Addendum section for special format reports --->
        <cfif isSpecialFormat>
            <cfscript>
                Case_Type_List = "Liabilities,Receivables";
                Current_Removed_List = "New,Removed,Current";
                Assess_Cutoff_List = "MostLikelyUnderTenMillion_MaxReasonableOverOneMillion";
                Last_CLRC_Query_Name = "";
                QueryNamePrefix = "Addendum";
            </cfscript>

            <cfinclude template="cfloop.cur_rem.casetype.assesscutoff.recct.cfm">

            <cfscript>
                Assess_Cutoff_List = "MostLikelyUnderTenMillion_MaxReasonableOverOneMillion";
            </cfscript>

            <cfinclude template="cfloop.cur_rem.casetype.assesscutoff.output.cfm">
        </cfif>

    </cfif><!--- NOT STL / NOT IndexOnly / NOT large unfiltered --->

</cfif><!--- currentCount EQ 0 --->

</body>
</html>
