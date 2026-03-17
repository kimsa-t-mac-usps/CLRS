# Test Script: IE Compatibility Mode OFF
# Contingent Liabilities and Receivables (CLRS) Application

| Field               | Value                                                    |
|---------------------|----------------------------------------------------------|
| Document ID         | TS-CLRS-IECOMPAT-001                                     |
| Version             | 1.0                                                      |
| Date                | 2026-03-12                                               |
| Related Test Plan   | TP-CLRS-IECOMPAT-001                                     |
| Prepared By         | (enter name)                                             |

---

## How to Use This Script

1. **Pre-condition**: Ensure Compatibility View is OFF in the browser under test.
2. Execute each test case in order.
3. Record **Actual Result**, **Pass/Fail**, **Tester**, and **Date** in the result columns.
4. Attach screenshots for any Fail result.
5. Repeat the full script for each browser in the test matrix.

### Browser Under Test (fill in per execution run)

| Field            | Value        |
|------------------|--------------|
| Browser Name     |              |
| Browser Version  |              |
| OS               |              |
| Compat View      | OFF          |

---

## TS-01: Authentication and Single Sign-On

### TS-01.01 — MFA Cookie Redirect

| Field            | Detail |
|------------------|--------|
| Priority         | P1 — Critical |
| Pre-condition    | User is logged into Windows domain. No `_mfa.authenticated_clrs` cookie exists (clear cookies first). |

| Step | Action | Expected Result |
|------|--------|-----------------|
| 1 | Clear all browser cookies for the application domain. | Cookies cleared. |
| 2 | Navigate to `index.cfm`. | Browser redirects to SAML MFA authentication page. |
| 3 | Complete MFA challenge. | Redirect back to application; `_mfa.authenticated_clrs` cookie is set. |
| 4 | Navigate to `index.cfm` again. | Page loads without MFA prompt; redirects to `Report.full.cfm`. |

| Actual Result | Pass/Fail | Tester | Date | Notes |
|---------------|-----------|--------|------|-------|
|               |           |        |      |       |

### TS-01.02 — Windows Integrated Auth (SSO)

| Field            | Detail |
|------------------|--------|
| Priority         | P1 — Critical |
| Pre-condition    | User is logged into Windows domain. MFA cookie exists. |

| Step | Action | Expected Result |
|------|--------|-----------------|
| 1 | Navigate to `Report.full.cfm`. | Page loads. No login dialog appears. User identity extracted from `cgi.auth_user`. |
| 2 | Verify banner or page header shows user context (office, authorization level). | Correct user/office displayed. |

| Actual Result | Pass/Fail | Tester | Date | Notes |
|---------------|-----------|--------|------|-------|
|               |           |        |      |       |

---

## TS-02: Application Entry and Redirects

### TS-02.01 — Index Redirect

| Field            | Detail |
|------------------|--------|
| Priority         | P1 — Critical |
| Pre-condition    | Authenticated user. |

| Step | Action | Expected Result |
|------|--------|-----------------|
| 1 | Navigate to `index.cfm`. | Redirect to `Report.full.cfm`. No JavaScript errors in console. |
| 2 | Check browser address bar. | URL ends with `Report.full.cfm`. |

| Actual Result | Pass/Fail | Tester | Date | Notes |
|---------------|-----------|--------|------|-------|
|               |           |        |      |       |

### TS-02.02 — Report.cfm Redirect with Query String

| Field            | Detail |
|------------------|--------|
| Priority         | P2 — High |
| Pre-condition    | Authenticated user. |

| Step | Action | Expected Result |
|------|--------|-----------------|
| 1 | Navigate to `Report.cfm?RecIDParm=12345`. | Redirect to `Report.full.cfm?RecIDParm=12345`. |
| 2 | Navigate to `Report.cfm?RecIDParm=12345#SectionA`. | Redirect preserves both query string and hash fragment. |

| Actual Result | Pass/Fail | Tester | Date | Notes |
|---------------|-----------|--------|------|-------|
|               |           |        |      |       |

---

## TS-03: Report Viewing

### TS-03.01 — Full Report Rendering

| Field            | Detail |
|------------------|--------|
| Priority         | P1 — Critical |
| Pre-condition    | Authenticated user (Admin level). Cases exist in database. |

| Step | Action | Expected Result |
|------|--------|-----------------|
| 1 | Open `Report.full.cfm`. | Report page loads fully. No layout breaks, overlapping text, or missing sections. |
| 2 | Scroll through entire report. | All case rows display with alternating row colors. All table headers visible. |
| 3 | Open browser Developer Tools (F12) > Console tab. | No JavaScript errors. |

| Actual Result | Pass/Fail | Tester | Date | Notes |
|---------------|-----------|--------|------|-------|
|               |           |        |      |       |

### TS-03.02 — Report Format Switching: Corp Finance

| Field            | Detail |
|------------------|--------|
| Priority         | P2 — High |
| Pre-condition    | Full report is loaded. |

| Step | Action | Expected Result |
|------|--------|-----------------|
| 1 | Click "Report for Corp Finance" link. | Page reloads in Corp Finance format. Layout intact. |
| 2 | Click "Front Office Version" link. | Page reloads in Front Office Review format. |
| 3 | Click "Report for Law Dept" link. | Returns to default Law Department report view. |
| 4 | Click "Short-term Liabilities Only" link (if visible). | Report filters to short-term liabilities only. |

| Actual Result | Pass/Fail | Tester | Date | Notes |
|---------------|-----------|--------|------|-------|
|               |           |        |      |       |

### TS-03.03 — Report Top Index Navigation

| Field            | Detail |
|------------------|--------|
| Priority         | P2 — High |
| Pre-condition    | Full report with multiple case categories loaded. |

| Step | Action | Expected Result |
|------|--------|-----------------|
| 1 | Click a case category link in the top index section. | Browser scrolls to the correct section anchor. |
| 2 | Click a case name link to open individual case report. | Single case report page opens correctly. |

| Actual Result | Pass/Fail | Tester | Date | Notes |
|---------------|-----------|--------|------|-------|
|               |           |        |      |       |

---

## TS-04: Add New Case (InsertRecord)

### TS-04.01 — Page Load and Layout

| Field            | Detail |
|------------------|--------|
| Priority         | P1 — Critical |
| Pre-condition    | Authenticated user with authorization to add cases. |

| Step | Action | Expected Result |
|------|--------|-----------------|
| 1 | Navigate to `InsertRecord.cfm`. | Page loads with all form fields visible. Background color is linen. No layout breaks. |
| 2 | Verify meta tag `<meta http-equiv="X-UA-Compatible" content="IE=edge">` is present (View Source). | Tag present and not commented out. |
| 3 | Verify all dropdowns (Law Dept Office, District, Area) are populated. | Dropdowns contain expected options. |

| Actual Result | Pass/Fail | Tester | Date | Notes |
|---------------|-----------|--------|------|-------|
|               |           |        |      |       |

### TS-04.02 — Date Field Validation

| Field            | Detail |
|------------------|--------|
| Priority         | P1 — Critical |
| Pre-condition    | InsertRecord.cfm is open. |

| Step | Action | Expected Result |
|------|--------|-----------------|
| 1 | Leave Date Filed empty and do not check N/A or Unknown. Click Submit. | Alert: date validation message appears. Focus moves to Date Filed field. |
| 2 | Enter an invalid date (e.g., "13/45/2025"). Click Submit. | Alert: invalid date message. |
| 3 | Enter a valid date (e.g., "03/15/2025"). | No alert. Field accepts the value. |
| 4 | Check "N/A" for Date Filed AND enter a date value. Click Submit. | Alert: conflict message about N/A with date value entered. |

| Actual Result | Pass/Fail | Tester | Date | Notes |
|---------------|-----------|--------|------|-------|
|               |           |        |      |       |

### TS-04.03 — Amount Field Validation

| Field            | Detail |
|------------------|--------|
| Priority         | P1 — Critical |
| Pre-condition    | InsertRecord.cfm is open. |

| Step | Action | Expected Result |
|------|--------|-----------------|
| 1 | Enter non-numeric text in Amount Sought (e.g., "abc"). Tab out of field. | Alert: "Amount Sought must be numeric value..." |
| 2 | Enter value with dollar sign (e.g., "$1000"). Tab out. | Alert: must be without dollar sign or comma. |
| 3 | Enter value with comma (e.g., "1,000"). Tab out. | Alert: must be without comma. |
| 4 | Enter valid amount (e.g., "1500.5"). Tab out. | No alert. Value accepted. |
| 5 | Enter ".5" in Amount Sought. Tab out. | Value automatically corrected to "0.5". No alert. |
| 6 | Repeat steps 1–5 for Damages Assessment (Most Likely Payout) field. | Same behavior. |
| 7 | Repeat steps 1–5 for Maximum Reasonable Payout field. | Same behavior. |

| Actual Result | Pass/Fail | Tester | Date | Notes |
|---------------|-----------|--------|------|-------|
|               |           |        |      |       |

### TS-04.04 — Unknown Checkbox Interaction

| Field            | Detail |
|------------------|--------|
| Priority         | P2 — High |
| Pre-condition    | InsertRecord.cfm is open. |

| Step | Action | Expected Result |
|------|--------|-----------------|
| 1 | Check "Unknown" for Damages Assessment. | Unknown checkbox is checked. |
| 2 | Enter a value in Most Likely Payout field. Click Submit. | Alert: conflict — Unknown checked but value entered. |
| 3 | Click inside the Payout field (to trigger clearUnknown). | Unknown checkbox is un-checked. |

| Actual Result | Pass/Fail | Tester | Date | Notes |
|---------------|-----------|--------|------|-------|
|               |           |        |      |       |

### TS-04.05 — Successful Form Submission

| Field            | Detail |
|------------------|--------|
| Priority         | P1 — Critical |
| Pre-condition    | InsertRecord.cfm is open. All required fields populated with valid data. |

| Step | Action | Expected Result |
|------|--------|-----------------|
| 1 | Fill in all required fields: Case Name, Date Filed, Amount Sought, Damages Assessment, Law Dept Office, Counsel, District, Assessment Probability, Short-term Liability, Facts/Positions, Forum, Client. | All fields accept input. |
| 2 | Click Submit. | Form posts to `InsertRecord.Action.cfm`. No JavaScript errors. |
| 3 | Verify confirmation or redirect after insert. | New case is created. No server error page. |

| Actual Result | Pass/Fail | Tester | Date | Notes |
|---------------|-----------|--------|------|-------|
|               |           |        |      |       |

### TS-04.06 — Field Grievance Logic

| Field            | Detail |
|------------------|--------|
| Priority         | P2 — High |
| Pre-condition    | InsertRecord.cfm is open. |

| Step | Action | Expected Result |
|------|--------|-----------------|
| 1 | Select "Yes" for Field Grievance radio button. Leave GATS Number empty. Click Submit. | Alert: must enter National GATS Number. |
| 2 | Enter a GATS Number. Click Submit. | No alert for this field. Form proceeds to next validation. |

| Actual Result | Pass/Fail | Tester | Date | Notes |
|---------------|-----------|--------|------|-------|
|               |           |        |      |       |

---

## TS-05: Edit Existing Case (EditRecord)

### TS-05.01 — Page Load and Layout

| Field            | Detail |
|------------------|--------|
| Priority         | P1 — Critical |
| Pre-condition    | Authenticated user. At least one editable (non-finalized) case exists. |

| Step | Action | Expected Result |
|------|--------|-----------------|
| 1 | Open `EditRecord.cfm` for a known case (pass RecIDParm or navigate from report). | Edit form loads with case data pre-populated. No layout breaks. |
| 2 | Verify all dropdowns, radio buttons, and text areas display correctly. | All fields visible and properly aligned. |
| 3 | Check browser console (F12). | No JavaScript errors on page load. |

| Actual Result | Pass/Fail | Tester | Date | Notes |
|---------------|-----------|--------|------|-------|
|               |           |        |      |       |

### TS-05.02 — Edit and Submit Update

| Field            | Detail |
|------------------|--------|
| Priority         | P1 — Critical |
| Pre-condition    | EditRecord.cfm is loaded for a non-finalized case. |

| Step | Action | Expected Result |
|------|--------|-----------------|
| 1 | Modify the Facts/Positions text area (triggers `updFactsFlagArray` tracking). | Text area accepts changes. |
| 2 | Change Assessment Amount to a new valid value. | Field accepts value. |
| 3 | Click "Submit This Update". | `checkupdFactsFlagArray()` validation runs. Form posts to `EditRecord.Action.cfm`. |
| 4 | Verify confirmation or redirect after update. | Record updated. No server error. |
| 5 | Re-open the same case in EditRecord. | Changed values are persisted. |

| Actual Result | Pass/Fail | Tester | Date | Notes |
|---------------|-----------|--------|------|-------|
|               |           |        |      |       |

### TS-05.03 — Confirm No Change

| Field            | Detail |
|------------------|--------|
| Priority         | P2 — High |
| Pre-condition    | EditRecord.cfm is loaded. No fields modified. |

| Step | Action | Expected Result |
|------|--------|-----------------|
| 1 | Without changing any fields, click "Confirm No Change". | Form submits successfully with no-change action. No JavaScript errors. |
| 2 | Verify the case record is unchanged in the report. | No data modified. |

| Actual Result | Pass/Fail | Tester | Date | Notes |
|---------------|-----------|--------|------|-------|
|               |           |        |      |       |

### TS-05.04 — Status Code Selection

| Field            | Detail |
|------------------|--------|
| Priority         | P2 — High |
| Pre-condition    | EditRecord.cfm is loaded for a case with Status Code options. |

| Step | Action | Expected Result |
|------|--------|-----------------|
| 1 | Select one or more Status Code checkboxes. | Checkboxes respond to clicks. |
| 2 | Click "Submit This Update". | `showStatusCodeSelected()` concatenates values into hidden field. Form posts successfully. |
| 3 | Verify saved Status Code on re-open. | Selected values persisted. |

| Actual Result | Pass/Fail | Tester | Date | Notes |
|---------------|-----------|--------|------|-------|
|               |           |        |      |       |

### TS-05.05 — Calendar Popup (Date Picker)

| Field            | Detail |
|------------------|--------|
| Priority         | P2 — High |
| Pre-condition    | EditRecord.cfm is loaded. |

| Step | Action | Expected Result |
|------|--------|-----------------|
| 1 | Click the calendar icon next to Date Filed. | Calendar popup (calendar5.js) opens in a new small window. |
| 2 | Select a date. | Date value populates in the Date Filed field. Popup closes. |
| 3 | Repeat for Payout Date field. | Same behavior. |

| Actual Result | Pass/Fail | Tester | Date | Notes |
|---------------|-----------|--------|------|-------|
|               |           |        |      |       |

---

## TS-06: File Upload

### TS-06.01 — Upload Spreadsheet Attachment

| Field            | Detail |
|------------------|--------|
| Priority         | P1 — Critical |
| Pre-condition    | Case exists. User has upload permission. AttachFile.cfm is accessible. |

| Step | Action | Expected Result |
|------|--------|-----------------|
| 1 | Open `AttachFile.cfm` for a case (from Edit page or report link). | Upload form loads. Browse button visible. |
| 2 | Click Browse. Select a valid .xls file from local machine. | File name appears in the file input. Attach button becomes visible. |
| 3 | Click the Attach/Upload button. | File uploads via `AttachFile.uploadfileaction.cfm`. Confirmation displayed. |
| 4 | Verify the uploaded file link appears on the page. | "Spreadsheet attached" hyperlink visible with correct file name. |
| 5 | Click the spreadsheet link. | File opens in new tab/window. |

| Actual Result | Pass/Fail | Tester | Date | Notes |
|---------------|-----------|--------|------|-------|
|               |           |        |      |       |

### TS-06.02 — Replace Existing Attachment

| Field            | Detail |
|------------------|--------|
| Priority         | P2 — High |
| Pre-condition    | Case already has an uploaded spreadsheet. |

| Step | Action | Expected Result |
|------|--------|-----------------|
| 1 | Open AttachFile.cfm with `FileReplace=yes`. | Replace instructions are displayed. |
| 2 | Browse and select a replacement .xls file. | File name appears. |
| 3 | Click Attach. | Old file replaced. New file link displayed with updated timestamp. |

| Actual Result | Pass/Fail | Tester | Date | Notes |
|---------------|-----------|--------|------|-------|
|               |           |        |      |       |

---

## TS-07: Spreadsheet Generation

### TS-07.01 — Generate Case List Spreadsheet

| Field            | Detail |
|------------------|--------|
| Priority         | P2 — High |
| Pre-condition    | Authenticated admin user. |

| Step | Action | Expected Result |
|------|--------|-----------------|
| 1 | From the report page, click the "Case List" spreadsheet link. | `Spreadsheet.CL.cfm` loads and generates spreadsheet. |
| 2 | Spreadsheet opens in a new window or downloads. | File opens correctly. Data matches report. |

| Actual Result | Pass/Fail | Tester | Date | Notes |
|---------------|-----------|--------|------|-------|
|               |           |        |      |       |

---

## TS-08: Email Notifications

### TS-08.01 — Assessment Change Email

| Field            | Detail |
|------------------|--------|
| Priority         | P2 — High |
| Pre-condition    | Edit a case and change the Assessment Amount. |

| Step | Action | Expected Result |
|------|--------|-----------------|
| 1 | Change Assessment Amount on EditRecord. Submit. | Update succeeds. |
| 2 | Check mail server log or recipient inbox. | Email sent via `EditRecord.cfmail.cfm` with assessment change details. |

| Actual Result | Pass/Fail | Tester | Date | Notes |
|---------------|-----------|--------|------|-------|
|               |           |        |      |       |

---

## TS-09: Legacy Compatibility View Guidance

### TS-09.01 — ChgCompatView.htm Content

| Field            | Detail |
|------------------|--------|
| Priority         | P3 — Medium |
| Pre-condition    | None. |

| Step | Action | Expected Result |
|------|--------|-----------------|
| 1 | Open `ChgCompatView.htm` directly in browser. | Page loads and displays content. |
| 2 | Review instructions on page. | **Expected for Compat OFF policy**: Page should NOT instruct users to add site to Compatibility View. |
| 3 | Document whether current content conflicts with Compat OFF policy. | Record finding. |

| Actual Result | Pass/Fail | Tester | Date | Notes |
|---------------|-----------|--------|------|-------|
|               |           |        |      |       |

### TS-09.02 — Compatibility View Popup Trigger

| Field            | Detail |
|------------------|--------|
| Priority         | P3 — Medium |
| Pre-condition    | Identify any page that calls `openInfoChgCompatView()`. |

| Step | Action | Expected Result |
|------|--------|-----------------|
| 1 | Trigger the link or button that calls `openInfoChgCompatView()`. | Popup window opens `ChgCompatView.htm`. |
| 2 | Verify whether this link should still be exposed to users. | **Expected**: Link should be removed or updated per Compat OFF policy. |

| Actual Result | Pass/Fail | Tester | Date | Notes |
|---------------|-----------|--------|------|-------|
|               |           |        |      |       |

---

## TS-10: Cross-Browser Layout Validation

### TS-10.01 — Visual Comparison Across Browsers

| Field            | Detail |
|------------------|--------|
| Priority         | P2 — High |
| Pre-condition    | All TS-01 through TS-09 steps have been executed in at least one browser. |

| Step | Action | Expected Result |
|------|--------|-----------------|
| 1 | Open `Report.full.cfm` in Edge, Chrome, and (if applicable) Edge IE Mode. | Layout is consistent across browsers. |
| 2 | Open `InsertRecord.cfm` in all three browsers. | Form layout matches. All fields aligned. |
| 3 | Open `EditRecord.cfm` in all three browsers. | Form layout matches. No broken elements. |
| 4 | Open `AttachFile.cfm` in all three browsers. | Upload area renders correctly. Browse button functional. |
| 5 | Capture screenshots of each page in each browser. | Attach to test evidence folder. |

| Actual Result | Pass/Fail | Tester | Date | Notes |
|---------------|-----------|--------|------|-------|
|               |           |        |      |       |

---

## Execution Summary

| Test Section | Total Cases | Passed | Failed | Blocked | Not Run |
|--------------|-------------|--------|--------|---------|---------|
| TS-01 Auth   |      2      |        |        |         |         |
| TS-02 Redirect |    2      |        |        |         |         |
| TS-03 Report |      3      |        |        |         |         |
| TS-04 Add    |      6      |        |        |         |         |
| TS-05 Edit   |      5      |        |        |         |         |
| TS-06 Upload |      2      |        |        |         |         |
| TS-07 Spreadsheet |  1    |        |        |         |         |
| TS-08 Email  |      1      |        |        |         |         |
| TS-09 Legacy |      2      |        |        |         |         |
| TS-10 Layout |      1      |        |        |         |         |
| **TOTAL**    |   **25**    |        |        |         |         |

## Sign-Off

| Name | Role | Signature | Date |
|------|------|-----------|------|
|      | QA Lead |        |      |
|      | Developer |      |      |
|      | Project Manager | |      |
