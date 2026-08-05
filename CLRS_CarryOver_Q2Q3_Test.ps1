<#
.SYNOPSIS
    CLRS District/Division Carry-Over Validation Script
    Tests FY2026 Q2 → Q3 carry-over fix for District and Division dropdowns.

.DESCRIPTION
    Validates that the required fallback logic is present in the 4 modified files
    so that District and Division values carry over from Q2 to Q3 when the bulk
    load does not copy those columns. HQ Department works correctly (AREA_NAME
    is copied by the bulk load) so it is tested as a baseline comparison.

    Root Cause: Bulk load creates new Q3 records but does not copy:
      - DIST_PERF_CLUSTER_CODE
      - DIST_PERF_CLUSTER_NAME
      - DIVISION_CODE
      - DIVISION_NAME

    Required Fix (4 files):
      1. EditRecord.cfm         - PrevReportDate fallback when URL param missing
      2. EditRecord.ptB.cfm     - District/Division fallback to previous quarter
      3. areas.districts.dropdown.FromTable.cfm - SELECTED match by CODE or NAME
      4. Report.ptC.cfm         - Display fallback from previous quarter

.USAGE
    .\CLRS_CarryOver_Q2Q3_Test.ps1
    .\CLRS_CarryOver_Q2Q3_Test.ps1 -BasePath "X:\web\inetpub\wwwroot2\ClientService\ContingentLiabilities\V1.0"

.DATE    June 10, 2026
#>

param(
    [string]$BasePath = "t:\web\inetpub\wwwroot2\ClientService\ContingentLiabilities\V1.0"
)

#region ---- Helpers ---------------------------------------------------------
$PassCount = 0
$FailCount = 0
$WarnCount = 0

function Write-Pass($msg) {
    Write-Host "  [PASS] $msg" -ForegroundColor Green
    $script:PassCount++
}
function Write-Fail($msg) {
    Write-Host "  [FAIL] $msg" -ForegroundColor Red
    $script:FailCount++
}
function Write-Warn($msg) {
    Write-Host "  [WARN] $msg" -ForegroundColor Yellow
    $script:WarnCount++
}
function Write-Section($title) {
    Write-Host "`n================================================================" -ForegroundColor Cyan
    Write-Host "  $title" -ForegroundColor Cyan
    Write-Host "================================================================" -ForegroundColor Cyan
}
function Write-Info($msg) {
    Write-Host "  [INFO] $msg" -ForegroundColor Gray
}
#endregion

Write-Host ""
Write-Host "================================================================" -ForegroundColor White
Write-Host "  CLRS District/Division Carry-Over Fix Validation" -ForegroundColor White
Write-Host "  FY2026 Q2 -> Q3 Quarterly Transition" -ForegroundColor White
Write-Host "  Base Path: $BasePath" -ForegroundColor White
Write-Host "  Date: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')" -ForegroundColor White
Write-Host "================================================================" -ForegroundColor White

#region ---- Verify Files Exist ----------------------------------------------
Write-Section "PRE-CHECK: Required Files Exist"

$requiredFiles = @(
    "EditRecord.cfm",
    "EditRecord.ptB.cfm",
    "areas.districts.dropdown.FromTable.cfm",
    "Report.ptC.cfm",
    "components\clrsFunctions.cfc"
)

$allExist = $true
foreach ($f in $requiredFiles) {
    $path = Join-Path $BasePath $f
    if (Test-Path $path) {
        Write-Pass "$f exists"
    } else {
        Write-Fail "$f NOT FOUND at $path"
        $allExist = $false
    }
}

if (-not $allExist) {
    Write-Host "`n  ABORTING: Required files missing. Cannot continue." -ForegroundColor Red
    exit 1
}
#endregion

#region ---- TEST 1: EditRecord.cfm - PrevReportDate Fallback ----------------
Write-Section "TEST 1: EditRecord.cfm - PrevReportDate URL Parameter Fallback"

$editRecordCfm = Get-Content (Join-Path $BasePath "EditRecord.cfm") -Raw

# T1.1: Check if PrevReportDate_Parm has a fallback when URL param is missing
# The fix should add logic like:
#   CFIF NOT IsDefined("url.PrevReportDate_Parm") OR url.PrevReportDate_Parm EQ ""
#     CFSET url.PrevReportDate_Parm = PrevReportDate
#   /CFIF
$hasPrevDateFallback = $false

if ($editRecordCfm -match 'IsDefined\("url\.PrevReportDate_Parm"\).*PrevReportDate') {
    $hasPrevDateFallback = $true
} elseif ($editRecordCfm -match 'PrevReportDate_Parm.*=.*PrevReportDate[^_]') {
    $hasPrevDateFallback = $true
} elseif ($editRecordCfm -match 'NOT\s+IsDefined\("url\.PrevReportDate_Parm"') {
    $hasPrevDateFallback = $true
}

if ($hasPrevDateFallback) {
    Write-Pass "EditRecord.cfm: PrevReportDate_Parm fallback logic present"
} else {
    Write-Fail "EditRecord.cfm: NO fallback when url.PrevReportDate_Parm is missing"
    Write-Info "  Without this fix, getPrevReptRecord() will error when PrevReportDate_Parm"
    Write-Info "  is not in the URL (e.g., navigating from report listing or bookmarks)."
    Write-Info "  FIX: Add before cfinvoke getPrevReptRecord:"
    Write-Info "    <CFIF NOT IsDefined('url.PrevReportDate_Parm') OR url.PrevReportDate_Parm EQ ''>"
    Write-Info "       <CFSET url.PrevReportDate_Parm = PrevReportDate>"
    Write-Info "    </CFIF>"
}

# T1.2: Verify getPrevReptRecord is called with proper parameter
if ($editRecordCfm -match 'cfinvoke.*getPrevReptRecord.*returnvariable="GetRecord_PrevRpt"') {
    Write-Pass "EditRecord.cfm: getPrevReptRecord invocation present"
} else {
    Write-Fail "EditRecord.cfm: getPrevReptRecord invocation NOT FOUND"
}

# T1.3: Verify PrevReportDate is computed from DB
if ($editRecordCfm -match 'Get_PrevReportDate\.DATE_REPORT_PREV') {
    Write-Pass "EditRecord.cfm: PrevReportDate computed from DB query"
} else {
    Write-Fail "EditRecord.cfm: PrevReportDate DB query not found"
}
#endregion

#region ---- TEST 2: EditRecord.ptB.cfm - District Fallback ------------------
Write-Section "TEST 2: EditRecord.ptB.cfm - District/Division Fallback to Previous Quarter"

$editPtBCfm = Get-Content (Join-Path $BasePath "EditRecord.ptB.cfm") -Raw

# T2.1: Check if District falls back to previous quarter when current is empty
# Expected fix pattern:
#   <CFIF Len(Trim(DIST_PERF_CLUSTER_CODE)) EQ 0 AND Len(Trim(prev_dist_perf_cluster_code)) GT 0>
#     <CFSET This_DIST_PERF_CLUSTER_CODE = prev_dist_perf_cluster_code>
#   </CFIF>
$hasDistrictFallback = $false

if ($editPtBCfm -match 'This_DIST_PERF_CLUSTER_CODE\s*=\s*prev_dist_perf_cluster_code') {
    $hasDistrictFallback = $true
} elseif ($editPtBCfm -match 'Len\(Trim\(DIST_PERF_CLUSTER_CODE\)\)\s*(EQ\s*0|LT\s*1).*prev_dist') {
    $hasDistrictFallback = $true
} elseif ($editPtBCfm -match 'DIST_PERF_CLUSTER_CODE\s*EQ\s*"".*prev_dist') {
    $hasDistrictFallback = $true
}

if ($hasDistrictFallback) {
    Write-Pass "EditRecord.ptB.cfm: District dropdown falls back to previous quarter value"
} else {
    Write-Fail "EditRecord.ptB.cfm: District dropdown has NO fallback to previous quarter"
    Write-Info "  Current code: <CFSET This_DIST_PERF_CLUSTER_CODE = DIST_PERF_CLUSTER_CODE>"
    Write-Info "  This only uses the current record's value (empty after bulk load)."
    Write-Info "  FIX: After setting This_DIST_PERF_CLUSTER_CODE, add:"
    Write-Info "    <CFIF Len(Trim(This_DIST_PERF_CLUSTER_CODE)) EQ 0 AND Len(Trim(prev_dist_perf_cluster_code)) GT 0>"
    Write-Info "       <CFSET This_DIST_PERF_CLUSTER_CODE = prev_dist_perf_cluster_code>"
    Write-Info "    </CFIF>"
}

# T2.2: Check if Division falls back to previous quarter when current is empty
$hasDivisionFallback = $false

if ($editPtBCfm -match 'This_Division_Code\s*=\s*prev_DIVISION_CODE') {
    $hasDivisionFallback = $true
} elseif ($editPtBCfm -match 'Len\(Trim\(DIVISION_CODE\)\)\s*(EQ\s*0|LT\s*1).*prev_DIVISION') {
    $hasDivisionFallback = $true
} elseif ($editPtBCfm -match 'DIVISION_CODE\s*EQ\s*"".*prev_DIVISION') {
    $hasDivisionFallback = $true
}

if ($hasDivisionFallback) {
    Write-Pass "EditRecord.ptB.cfm: Division dropdown falls back to previous quarter value"
} else {
    Write-Fail "EditRecord.ptB.cfm: Division dropdown has NO fallback to previous quarter"
    Write-Info "  Current code: <CFSET This_Division_Code = DIVISION_CODE>"
    Write-Info "  FIX: After setting This_Division_Code, add:"
    Write-Info "    <CFIF Len(Trim(This_Division_Code)) EQ 0 AND Len(Trim(prev_DIVISION_CODE)) GT 0>"
    Write-Info "       <CFSET This_Division_Code = prev_DIVISION_CODE>"
    Write-Info "    </CFIF>"
}

# T2.3: Verify prev values are loaded from GetRecord_PrevRpt
if ($editPtBCfm -match 'prev_dist_perf_cluster_code\s*=\s*GetRecord_PrevRpt\.DIST_PERF_CLUSTER_CODE') {
    Write-Pass "EditRecord.ptB.cfm: Previous quarter District value is loaded"
} else {
    Write-Fail "EditRecord.ptB.cfm: prev_dist_perf_cluster_code assignment not found"
}

if ($editPtBCfm -match 'prev_DIVISION_CODE\s*=\s*GetRecord_PrevRpt\.DIVISION_CODE') {
    Write-Pass "EditRecord.ptB.cfm: Previous quarter Division value is loaded"
} else {
    Write-Fail "EditRecord.ptB.cfm: prev_DIVISION_CODE assignment not found"
}

# T2.4: Safety check - GetRecord_PrevRpt.RecordCount should be checked before use
if ($editPtBCfm -match 'GetRecord_PrevRpt\.RecordCount\s*(GT|GTE|GE)\s*[01]') {
    Write-Pass "EditRecord.ptB.cfm: RecordCount safety check on GetRecord_PrevRpt"
} else {
    Write-Warn "EditRecord.ptB.cfm: No RecordCount check before accessing GetRecord_PrevRpt"
    Write-Info "  If no previous quarter record exists, accessing columns will error."
}
#endregion

#region ---- TEST 3: areas.districts.dropdown.FromTable.cfm ------------------
Write-Section "TEST 3: areas.districts.dropdown.FromTable.cfm - SELECTED Match Logic"

$dropCfm = Get-Content (Join-Path $BasePath "areas.districts.dropdown.FromTable.cfm") -Raw

# T3.1: District - check that SELECTED comparison handles both CODE and NAME
# The issue: When fallback value comes from NAME column (not CODE), the match fails
# Fix: Check if This_DIST_PERF_CLUSTER_CODE matches EITHER the code OR the name
$districtMatchesBothCodeAndName = $false

if ($dropCfm -match 'This_DIST_PERF_CLUSTER_CODE\s+EQ\s+This_District_Code' -and
    $dropCfm -match 'This_DIST_PERF_CLUSTER_CODE\s+EQ\s+This_District_Name') {
    $districtMatchesBothCodeAndName = $true
}

if ($districtMatchesBothCodeAndName) {
    Write-Pass "District SELECTED: Matches by both CODE and NAME"
} else {
    # Check current logic
    if ($dropCfm -match 'This_DIST_PERF_CLUSTER_CODE\s+EQ\s+This_District_Code') {
        Write-Warn "District SELECTED: Only matches by CODE (not NAME)"
        Write-Info "  If prev quarter stored the NAME in DIST_PERF_CLUSTER_CODE, dropdown won't pre-select."
        Write-Info "  FIX: Change comparison to:"
        Write-Info "    (This_DIST_PERF_CLUSTER_CODE EQ This_District_Code OR This_DIST_PERF_CLUSTER_CODE EQ This_District_Name)"
    } else {
        Write-Fail "District SELECTED: Comparison logic not found at all"
    }
}

# T3.2: Division - check SELECTED comparison handles both CODE and NAME
$divisionMatchLogic = $false

if ($dropCfm -match 'This_Division_Code\s+EQ\s+DIVISION_CODE' -or
    $dropCfm -match 'This_Division_Code\s+EQ\s+NAME' -or
    $dropCfm -match 'SelectedPC\s+EQ\s+This_Division_Name') {
    $divisionMatchLogic = $true
}

if ($divisionMatchLogic) {
    Write-Pass "Division SELECTED: Match logic present (CODE or NAME)"
} else {
    Write-Fail "Division SELECTED: Match logic not found"
}

# T3.3: Check Division value attribute in <option> uses proper fallback
if ($dropCfm -match 'value="#Division_code#"' -or $dropCfm -match 'value="#DIVISION_CODE#"') {
    Write-Pass "Division <option> value uses DIVISION_CODE column"
} else {
    Write-Warn "Division <option> value attribute may not match expected format"
}
#endregion

#region ---- TEST 4: Report.ptC.cfm - Display Fallback -----------------------
Write-Section "TEST 4: Report.ptC.cfm - District/Division Display Fallback"

$reportPtCCfm = Get-Content (Join-Path $BasePath "Report.ptC.cfm") -Raw

# T4.1: District display has fallback from previous quarter
$hasReportDistrictFallback = $false

if ($reportPtCCfm -match 'This_DIST_PERF_CLUSTER_NAME\s*=\s*CONTINGENT_LIAB_GetRecord_PrevRpt\.DIST_PERF_CLUSTER_NAME') {
    $hasReportDistrictFallback = $true
} elseif ($reportPtCCfm -match 'DIST_PERF_CLUSTER_NAME\s*EQ\s*"".*PrevRpt') {
    $hasReportDistrictFallback = $true
} elseif ($reportPtCCfm -match 'Len\(Trim\(DIST_PERF_CLUSTER_NAME\)\)\s*EQ\s*0.*PrevRpt') {
    $hasReportDistrictFallback = $true
}

if ($hasReportDistrictFallback) {
    Write-Pass "Report.ptC.cfm: District display falls back to previous quarter"
} else {
    Write-Warn "Report.ptC.cfm: District display may NOT fall back to previous quarter"
    Write-Info "  Current code sets: This_DIST_PERF_CLUSTER_NAME = DIST_PERF_CLUSTER_NAME"
    Write-Info "  If current record is empty, district will show blank in report."
    Write-Info "  FIX: After setting This_DIST_PERF_CLUSTER_NAME, add:"
    Write-Info "    <CFIF Len(Trim(This_DIST_PERF_CLUSTER_NAME)) EQ 0"
    Write-Info "         AND IsDefined('CONTINGENT_LIAB_GetRecord_PrevRpt.DIST_PERF_CLUSTER_NAME')"
    Write-Info "         AND CONTINGENT_LIAB_GetRecord_PrevRpt.DIST_PERF_CLUSTER_NAME NEQ ''>"
    Write-Info "       <CFSET This_DIST_PERF_CLUSTER_NAME = CONTINGENT_LIAB_GetRecord_PrevRpt.DIST_PERF_CLUSTER_NAME>"
    Write-Info "    </CFIF>"
}

# T4.2: Division display has fallback from previous quarter
$hasReportDivisionFallback = $false

if ($reportPtCCfm -match 'This_DIVISION_NAME\s*=\s*CONTINGENT_LIAB_GetRecord_PrevRpt\.DIVISION_NAME') {
    $hasReportDivisionFallback = $true
} elseif ($reportPtCCfm -match 'This_DIVISION_CODE\s*=\s*CONTINGENT_LIAB_GetRecord_PrevRpt\.DIVISION_CODE') {
    $hasReportDivisionFallback = $true
}

if ($hasReportDivisionFallback) {
    Write-Pass "Report.ptC.cfm: Division display falls back to previous quarter"
} else {
    Write-Warn "Report.ptC.cfm: Division display may NOT fall back to previous quarter"
    Write-Info "  Similar fix needed for Division as described for District above."
}

# T4.3: "Previously reported as" logic exists
if ($reportPtCCfm -match 'Previously reported as') {
    Write-Pass "Report.ptC.cfm: 'Previously reported as' message logic exists"
} else {
    Write-Fail "Report.ptC.cfm: 'Previously reported as' logic not found"
}

# T4.4: Earliest quarter guard (prevents error when no previous record)
if ($reportPtCCfm -match 'EarliestReportDate' -or $reportPtCCfm -match 'PrevReportDate\s*NEQ\s*""') {
    Write-Pass "Report.ptC.cfm: Earliest quarter guard present"
} else {
    Write-Warn "Report.ptC.cfm: No guard for earliest quarter (may error if no previous record)"
}

# T4.5: RecordCount check before accessing PrevRpt columns
if ($reportPtCCfm -match 'CONTINGENT_LIAB_GetRecord_PrevRpt\.RecordCount') {
    Write-Pass "Report.ptC.cfm: RecordCount check on PrevRpt query"
} else {
    Write-Warn "Report.ptC.cfm: No RecordCount check on CONTINGENT_LIAB_GetRecord_PrevRpt"
}
#endregion

#region ---- TEST 5: Comparison - HQ Department (Working Control) ------------
Write-Section "TEST 5: HQ Department Carry-Over (Working - Baseline Comparison)"

$editPtBCfm_content = Get-Content (Join-Path $BasePath "EditRecord.ptB.cfm") -Raw

# T5.1: HQ Dept uses AREA_NAME which IS copied by bulk load
if ($editPtBCfm_content -match 'This_HQ_AREA_NAME\s*=\s*AREA_NAME') {
    Write-Pass "HQ Dept: Uses AREA_NAME column (copied by bulk load - works correctly)"
} else {
    Write-Warn "HQ Dept: AREA_NAME assignment not found in expected form"
}

# T5.2: Explain WHY HQ works and District/Division don't
Write-Info ""
Write-Info "WHY HQ DEPARTMENT WORKS BUT DISTRICT/DIVISION DON'T:"
Write-Info "  - HQ Department: stored in AREA_NAME column -> COPIED during bulk load"
Write-Info "  - District:      stored in DIST_PERF_CLUSTER_CODE/NAME -> NOT copied"
Write-Info "  - Division:      stored in DIVISION_CODE/NAME -> NOT copied"
Write-Info ""
Write-Info "The fix adds application-level fallback to read from previous quarter"
Write-Info "when the current quarter's District/Division columns are empty."
#endregion

#region ---- TEST 6: Component Function Validation ---------------------------
Write-Section "TEST 6: getPrevReptRecord Component Function"

$cfcPath = Join-Path $BasePath "components\clrsFunctions.cfc"
$cfcContent = Get-Content $cfcPath -Raw

# T6.1: Function exists and queries correct columns
if ($cfcContent -match 'function\s+getPrevReptRecord') {
    Write-Pass "clrsFunctions.cfc: getPrevReptRecord function exists"
} else {
    Write-Fail "clrsFunctions.cfc: getPrevReptRecord function NOT FOUND"
}

# T6.2: Queries district columns
if ($cfcContent -match 'dist_perf_cluster_code' -and $cfcContent -match 'dist_perf_cluster_name') {
    Write-Pass "clrsFunctions.cfc: Queries DIST_PERF_CLUSTER_CODE and NAME"
} else {
    Write-Fail "clrsFunctions.cfc: Missing district columns in query"
}

# T6.3: Queries division columns
if ($cfcContent -match 'division_code' -and $cfcContent -match 'division_name') {
    Write-Pass "clrsFunctions.cfc: Queries DIVISION_CODE and DIVISION_NAME"
} else {
    Write-Fail "clrsFunctions.cfc: Missing division columns in query"
}

# T6.4: Uses parameterized query (SQL injection protection)
if ($cfcContent -match 'addparam.*cfsqltype') {
    Write-Pass "clrsFunctions.cfc: Uses parameterized queries (safe from SQL injection)"
} else {
    Write-Fail "clrsFunctions.cfc: May not use parameterized queries"
}

# T6.5: Filters by date AND case_rec_id_sequence
if ($cfcContent -match 'date_report\s*=\s*:reportDate' -and $cfcContent -match 'case_rec_id_sequence\s*=\s*:caseSeq') {
    Write-Pass "clrsFunctions.cfc: Filters by both date and case sequence ID"
} else {
    Write-Fail "clrsFunctions.cfc: Query filter may be incomplete"
}
#endregion

#region ---- SUMMARY ---------------------------------------------------------
Write-Host "`n================================================================" -ForegroundColor White
Write-Host "  TEST SUMMARY - District/Division Carry-Over Fix" -ForegroundColor White
Write-Host "================================================================" -ForegroundColor White
Write-Host "  PASS : $PassCount" -ForegroundColor Green
Write-Host "  FAIL : $FailCount" -ForegroundColor $(if ($FailCount -gt 0) { "Red" } else { "Green" })
Write-Host "  WARN : $WarnCount" -ForegroundColor $(if ($WarnCount -gt 0) { "Yellow" } else { "White" })
Write-Host "  TOTAL: $($PassCount + $FailCount + $WarnCount)"
Write-Host "================================================================" -ForegroundColor White

if ($FailCount -eq 0 -and $WarnCount -eq 0) {
    Write-Host "`n  ALL CHECKS PASSED - Carry-over fix appears fully implemented." -ForegroundColor Green
} elseif ($FailCount -gt 0) {
    Write-Host "`n  $FailCount FAILURE(S) DETECTED" -ForegroundColor Red
    Write-Host "  The carry-over fix is NOT fully implemented in the current code." -ForegroundColor Red
    Write-Host "  District and Division will NOT carry over from Q2 to Q3." -ForegroundColor Red
    Write-Host ""
    Write-Host "  REQUIRED ACTIONS:" -ForegroundColor Yellow
    Write-Host "    1. Add PrevReportDate_Parm fallback in EditRecord.cfm" -ForegroundColor Yellow
    Write-Host "    2. Add District/Division fallback logic in EditRecord.ptB.cfm" -ForegroundColor Yellow
    Write-Host "    3. Add CODE-or-NAME match in areas.districts.dropdown.FromTable.cfm" -ForegroundColor Yellow
    Write-Host "    4. Add display fallback in Report.ptC.cfm" -ForegroundColor Yellow
} else {
    Write-Host "`n  $WarnCount WARNING(S) - review items above for potential issues." -ForegroundColor Yellow
}

Write-Host ""
Write-Host "  Next Step: After code fixes are applied, re-run this script to confirm." -ForegroundColor White
Write-Host "  Then execute manual test cases from CLRS_District_Division_CarryOver_TestPlan.md" -ForegroundColor White
Write-Host ""
#endregion
