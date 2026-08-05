# CLRS - District/Division Quarterly Carry-Over Fix
## Test Plan & Test Cases

**Document Version:** 1.0  
**Date:** May 13, 2026  
**Author:** CLRS Development Team  
**Ticket:** District/Division data not carrying over between quarters  

---

## 1. Change Summary

### Problem Statement
When new quarterly case records are bulk-loaded (e.g., FY2026 Q1 → Q2), the District and Division dropdown selections are not carried over to the new quarter's records. The HQ Department field works correctly.

### Root Cause
The bulk load process creates new quarter records but does not copy the `DIST_PERF_CLUSTER_CODE`, `DIST_PERF_CLUSTER_NAME`, `DIVISION_CODE`, and `DIVISION_NAME` columns from the previous quarter. The application had no fallback logic to retrieve these values.

### Fix Applied
Added fallback logic in 4 files so the application retrieves District and Division values from the previous quarter's record when the current quarter's values are empty.

### Files Modified

| # | File | Change Description |
|---|------|-------------------|
| 1 | `EditRecord.cfm` | Added PrevReportDate fallback when URL parameter is missing |
| 2 | `EditRecord.ptB.cfm` | Added RecordCount safety check; Division dropdown falls back to previous quarter value |
| 3 | `areas.districts.dropdown.FromTable.cfm` | Fixed Division SELECTED comparison to check both NAME and DIVISION_CODE columns |
| 4 | `Report.ptC.cfm` | Added District and Division display fallback from previous quarter; fixed row alignment with min-height; added guard for earliest quarter |

---

## 2. Test Environment

| Environment | Purpose | URL |
|-------------|---------|-----|
| DEV | Development and initial testing | [Dev Server URL] |
| CAT | Customer Acceptance Testing | [CAT Server URL] |
| PROD | Production | [Prod Server URL] |

### Prerequisites
- Access to CLRS application with edit permissions
- Cases loaded for FY2026 Q2 via bulk load from Q1
- At least one case with District value set in Q1
- At least one case with Division value set in Q1
- At least one case with HQ Dept value set in Q1
- At least one case with "MULTIPLE Districts" / "MULTIPLE Divisions"

---

## 3. Test Scope

### In Scope
- Report (read-only) view: District/Division/HQ display and alignment
- Edit form: Dropdown pre-selection for District, Division, HQ Dept
- Carry-over from Q1 to Q2 for bulk-loaded records
- "Previously reported as" message logic
- Visual alignment of District/Division/HQ rows

### Out of Scope
- Bulk load process itself (external to ColdFusion code)
- Database schema changes (none required)
- New record insertion (InsertRecord.cfm — unchanged)

---

## 4. Risk Assessment

| Risk | Likelihood | Impact | Mitigation |
|------|-----------|--------|------------|
| Already-updated cases affected | None | N/A | All fallbacks only activate when value is empty |
| Earliest quarter error | None | N/A | Guard added to prevent access to non-existent previous record |
| Regression in dropdown selection | Low | Medium | Testing covers multiple case types |
| Rollback needed | Low | Low | Replace 4 files with backups (instant rollback) |

---

## 5. Deployment Steps

### Pre-Deployment
1. Backup the following 4 files on target server:
   - `EditRecord.cfm`
   - `EditRecord.ptB.cfm`
   - `areas.districts.dropdown.FromTable.cfm`
   - `Report.ptC.cfm`
2. Confirm backups are accessible for rollback

### Deployment
3. Copy all 4 updated files to the target server simultaneously
4. No ColdFusion restart required (cfm files are picked up immediately)
5. No database changes required

### Post-Deployment
6. Execute Test Cases (Section 6)
7. Verify no errors in ColdFusion logs

### Rollback Plan
- Copy the 4 backup files back to the server
- Immediate effect, no restart needed

---

## 6. Test Cases

---

### TC-01: MULTIPLE Districts + MULTIPLE Divisions (Report View)
**Case Name:** A - Greensboro NDC Line H  
**Priority:** High  
**Precondition:** Case has "MULTIPLE Districts" and/or "MULTIPLE Divisions" set in Q1

| Step | Action | Expected Result | Pass/Fail |
|------|--------|-----------------|-----------|
| 1 | Navigate to Q1 Report view for this case | Page loads without error | |
| 2 | Note District value displayed | District value shown (e.g., MULTIPLE Districts) | |
| 3 | Note Division value displayed | Division value shown (e.g., MULTIPLE Divisions) | |
| 4 | Navigate to Q2 Report view for same case | Page loads without error | |
| 5 | Verify District displays | Same value as Q1 — NOT showing only "[Previously reported as]" | |
| 6 | Verify Division displays | Same value as Q1 — NOT showing only "[Previously reported as]" | |
| 7 | Verify HQ Dept displays | Same value as Q1 (if applicable) | |
| 8 | Verify no "Previously reported as" | Message does NOT appear when value is unchanged from Q1 | |
| 9 | Verify row alignment | District, Division, and HQ Dept labels align with their values | |

---

### TC-02: Single District + Single Division (Report View)
**Case Name:** A - Lead Clerks TACS CASE Baltimore Bid Cluster  
**Priority:** High  
**Precondition:** Case has a specific district (e.g., Baltimore) and division set in Q1

| Step | Action | Expected Result | Pass/Fail |
|------|--------|-----------------|-----------|
| 1 | Navigate to Q1 Report view | District and Division values display correctly | |
| 2 | Navigate to Q2 Report view | Page loads without error | |
| 3 | Verify District carries over | District displays same value as Q1 | |
| 4 | Verify Division carries over | Division displays same value as Q1 | |
| 5 | Verify no spurious "Previously reported as" | Message only appears if value actually changed | |
| 6 | Verify alignment | All three rows aligned properly | |

---

### TC-03: Edit Form Dropdown Pre-Selection
**Case Name:** A - MVS Fuel Stop Non Compliance  
**Priority:** High  
**Precondition:** Case has District and Division set in Q1; Q2 record created by bulk load

| Step | Action | Expected Result | Pass/Fail |
|------|--------|-----------------|-----------|
| 1 | Open Q2 Edit form for this case | Page loads without error | |
| 2 | Check District dropdown | Pre-selected with Q1's district value (not "Select a District...") | |
| 3 | Check Division dropdown | Pre-selected with Q1's division value (not "Select a Division...") | |
| 4 | Check HQ Dept dropdown | Pre-selected with Q1's HQ value (not "Select a Headquarters...") | |
| 5 | Click "Submit This Update" without changes | Save succeeds, no error | |
| 6 | Re-open Report view | District, Division, HQ Dept values all display correctly | |

---

### TC-04: Different Area/Region Case
**Case Name:** A ISC-JFK (NYISC) Cafeteria  
**Priority:** Medium  
**Precondition:** Case likely in New York Metro area

| Step | Action | Expected Result | Pass/Fail |
|------|--------|-----------------|-----------|
| 1 | Open Q1 Report view | District value displays with area name in parentheses | |
| 2 | Open Q2 Report view | District carries over with same formatting | |
| 3 | Verify Division carries over | Division matches Q1 | |
| 4 | Open Q2 Edit form | Dropdowns pre-selected correctly | |
| 5 | Verify alignment | Rows stay aligned even if one field is empty | |

---

### TC-05: Named District Case
**Case Name:** A- Connecticut District-Non-Compliance 204B MOU  
**Priority:** High  
**Precondition:** Case has "Connecticut" district set in Q1

| Step | Action | Expected Result | Pass/Fail |
|------|--------|-----------------|-----------|
| 1 | Open Q1 Report view | District: Connecticut District | |
| 2 | Open Q2 Report view | District: Connecticut District — carried over | |
| 3 | Verify no "Previously reported as" | Not shown (value unchanged) | |
| 4 | Open Q2 Edit form | District dropdown: "Connecticut District" selected | |
| 5 | Division and HQ carry over | Values match Q1 | |

---

### TC-06: Already-Updated Case (No Regression)
**Case Name:** Any case already edited and saved in Q2  
**Priority:** High  
**Precondition:** Case has been manually updated in Q2 (District/Division already saved)

| Step | Action | Expected Result | Pass/Fail |
|------|--------|-----------------|-----------|
| 1 | Open Q2 Report view | District and Division show the user-saved Q2 values | |
| 2 | Verify values are NOT overwritten by Q1 fallback | Displays current Q2 values, not Q1 values | |
| 3 | Open Q2 Edit form | Dropdowns show current Q2 selections | |
| 4 | Save without changes | No data corruption | |

---

### TC-07: District Changed Between Quarters
**Case Name:** Any case where user changed District in Q2  
**Priority:** Medium  
**Precondition:** Q1 had one district, user changed to different district in Q2

| Step | Action | Expected Result | Pass/Fail |
|------|--------|-----------------|-----------|
| 1 | Open Q2 Report view | New district value displayed | |
| 2 | Verify "Previously reported as" message | Shows "[Previously reported as: {Q1 district}]" | |
| 3 | Open Q2 Edit form | New district pre-selected in dropdown | |

---

### TC-08: HQ-Only Case (No District/Division)
**Case Name:** Any HQ-only case  
**Priority:** Medium  
**Precondition:** Case has HQ Dept set but no District or Division

| Step | Action | Expected Result | Pass/Fail |
|------|--------|-----------------|-----------|
| 1 | Open Q2 Report view | HQ Dept displays correctly | |
| 2 | Verify District row | Empty but row maintains height (no collapse) | |
| 3 | Verify Division row | Empty but row maintains height (no collapse) | |
| 4 | Verify alignment | All three label rows align with data side | |

---

### TC-09: Earliest Quarter (No Previous Data)
**Case Name:** Any case viewed in the earliest available quarter  
**Priority:** Medium  
**Precondition:** Navigate to the first quarter in the system

| Step | Action | Expected Result | Pass/Fail |
|------|--------|-----------------|-----------|
| 1 | Open Report view for earliest quarter | Page loads without error | |
| 2 | Verify no "Previously reported as" | Message does not appear | |
| 3 | Verify no ColdFusion error | No variable undefined errors | |

---

### TC-10: Bulk Report (Multiple Cases Listed)
**Case Name:** N/A — full report listing  
**Priority:** Medium  
**Precondition:** Generate report showing multiple Q2 cases

| Step | Action | Expected Result | Pass/Fail |
|------|--------|-----------------|-----------|
| 1 | Run quarterly report for Q2 | Report generates without error | |
| 2 | Spot-check 5+ cases | District and Division values display correctly | |
| 3 | Verify alignment across all cases | Consistent row spacing throughout report | |

---

## 7. Test Results Summary

| Test Case | CAT Result | CAT Date | PROD Result | PROD Date | Tester |
|-----------|-----------|----------|-------------|-----------|--------|
| TC-01 | | | | | |
| TC-02 | | | | | |
| TC-03 | | | | | |
| TC-04 | | | | | |
| TC-05 | | | | | |
| TC-06 | | | | | |
| TC-07 | | | | | |
| TC-08 | | | | | |
| TC-09 | | | | | |
| TC-10 | | | | | |

---

## 8. Sign-Off

| Role | Name | Date | Signature |
|------|------|------|-----------|
| Developer | | | |
| Tester | | | |
| CAT Approver | | | |
| Production Approver | | | |

---

## 9. Appendix: Commit History

| Commit | Date | Description |
|--------|------|-------------|
| `f7aa193` | May 8, 2026 | Fix District/Division data carry-over between quarters and alignment |
| `0444be6` | May 13, 2026 | Add District fallback from previous quarter in Report view |
