# Test Plan: IE Compatibility Mode OFF
# Contingent Liabilities and Receivables (CLRS) Application

| Field               | Value                                                    |
|---------------------|----------------------------------------------------------|
| Document ID         | TP-CLRS-IECOMPAT-001                                     |
| Version             | 1.0                                                      |
| Date                | 2026-03-12                                               |
| Project             | ClientService / ContingentLiabilities / V1.0             |
| Prepared By         | (enter name)                                             |
| Reviewed By         | (enter name)                                             |
| Approved By         | (enter name)                                             |

---

## 1. Purpose

Validate that the CLRS web application functions correctly when IE Compatibility View is turned **OFF** across all supported browsers, and confirm that no critical workflow depends on legacy IE Compatibility Mode rendering.

## 2. Objectives

| # | Objective                                                                                   |
|---|--------------------------------------------------------------------------------------------|
| 1 | Confirm all pages render correctly with Compatibility View OFF.                            |
| 2 | Confirm all form submissions (Add, Edit, Upload) complete without errors.                  |
| 3 | Confirm all client-side JavaScript validations fire correctly.                             |
| 4 | Confirm report generation and navigation work without layout or redirect failures.         |
| 5 | Confirm file upload functionality works without browser-mode dependencies.                 |
| 6 | Confirm MFA / Single Sign-On authentication flow is unaffected.                            |
| 7 | Identify any remaining code or documentation that conflicts with the Compatibility OFF policy. |

## 3. Scope

### 3.1 In Scope

| Area                        | Pages / Components                                                  |
|-----------------------------|---------------------------------------------------------------------|
| Authentication              | MfaCookieCheck.cfm, CheckUserAuth.cfm, application.cfm (SSO)       |
| Add New Case                | InsertRecord.cfm, InsertRecord.Action.cfm                          |
| Edit Existing Case          | EditRecord.cfm, EditRecord.Action.cfm, EditRecord.ptA–ptE.cfm     |
| Report View                 | index.cfm, Report.cfm, Report.full.cfm, Report.ptA–ptE.cfm        |
| Report Formats              | Corp Finance, Front Office, Short-term Liabilities (via ReturnForm) |
| Spreadsheet Generation      | Spreadsheet.CL.cfm, Spreadsheet.Areas.Districts.cfm                |
| File Upload                 | AttachFile.cfm, AttachFile.uploadfileaction.cfm, SaveSelectFile.cfm |
| Legacy Compat Instructions  | ChgCompatView.htm, fcn.infoChgCompatView.js                        |
| Email Notifications         | EditRecord.cfmail.cfm, email.cfmail.nocases.cfm                    |

### 3.2 Out of Scope

- Database schema or stored procedure changes.
- Server-side ColdFusion engine or JVM configuration.
- Non-CLRS applications on the same server.

## 4. Test Environment

| Item              | Requirement                                                        |
|-------------------|--------------------------------------------------------------------|
| Browser 1         | Microsoft Edge (latest stable) — IE Mode OFF                      |
| Browser 2         | Microsoft Edge IE Mode (if enterprise policy mandates IE testing)  |
| Browser 3         | Google Chrome (latest stable)                                      |
| Operating System  | Windows 10 or later                                                |
| Server            | ColdFusion 2018+ on IIS, matching DEV/TEST environment             |
| Authentication    | Windows Integrated Auth (IIS) + MFA cookie (SAML)                  |
| Network           | Internal network with access to application server                 |
| Test Data         | At least 3 existing case records; 1 finalized, 1 draft, 1 closed  |

## 5. Entry Criteria

- Application deployed to test environment.
- User accounts with Admin (A) and Individual (I) authorization levels available.
- Compatibility View is confirmed OFF in all test browsers.
- Test data (cases) is seeded in the database.

## 6. Exit Criteria

- All Priority 1 (Critical) test cases pass in at least two browsers.
- All Priority 2 (High) test cases pass or have documented workarounds.
- No unresolved Severity 1 defects.
- Test Script sign-off sheet completed by QA lead.

## 7. Test Strategy

### 7.1 Functional Testing
Execute the full Test Script (TS-CLRS-IECOMPAT-001) covering:
- Authentication and redirect flows
- Form submission (Add / Edit / Confirm No Change)
- Client-side validation (dates, amounts, required fields)
- Report rendering and format switching
- File upload and attachment display
- Email notification triggering

### 7.2 UI / Layout Testing
- Visual comparison of each page in all three browsers.
- Check for broken CSS, misaligned tables, missing elements, or overlapping divs.
- Verify `<nobr>`, `&nbsp;`, and inline styles render consistently.

### 7.3 Compatibility Regression
- Verify that the `X-UA-Compatible` meta tag (where present) does not cause adverse effects.
- Verify pages without the meta tag still render correctly.

### 7.4 Negative Testing
- Attempt to submit forms with invalid data (empty required fields, non-numeric amounts, malformed dates).
- Confirm alert dialogs and focus behavior work as expected.

## 8. Risk Assessment

| Risk                                              | Likelihood | Impact | Mitigation                                           |
|---------------------------------------------------|------------|--------|------------------------------------------------------|
| EditRecord.cfm missing IE=edge meta tag           | High       | Medium | Uncomment or add meta tag before production release   |
| PROD_InsertRecord.cfm has commented-out meta tag  | High       | Medium | Align with InsertRecord.cfm (uncomment)               |
| ChgCompatView.htm instructs enabling Compat View  | Medium     | High   | Remove or replace content before user access           |
| JavaScript `eval()` usage in form validation      | Medium     | Low    | Monitor for runtime errors; refactor if failures found |
| Report redirect pages lack browser mode control   | Low        | Low    | Add meta tag or rely on server-level HTTP header       |

## 9. Deliverables

| Deliverable                     | Document ID              |
|---------------------------------|--------------------------|
| This Test Plan                  | TP-CLRS-IECOMPAT-001     |
| Test Script (detailed steps)    | TS-CLRS-IECOMPAT-001     |
| Test Report (results summary)   | TEST_REPORT_IE_COMPAT_MODE_OFF.md (existing) |
| Defect Log                      | (to be created per defect tracking system)    |

## 10. Schedule

| Phase                 | Target Date   |
|-----------------------|---------------|
| Test Plan approval    | 2026-03-14    |
| Test environment ready| 2026-03-17    |
| Test execution start  | 2026-03-18    |
| Test execution end    | 2026-03-21    |
| Defect resolution     | 2026-03-28    |
| Retest / Regression   | 2026-03-31    |
| Final sign-off        | 2026-04-02    |

## 11. Roles and Responsibilities

| Role              | Responsibility                                        |
|-------------------|-------------------------------------------------------|
| QA Lead           | Approve test plan, review results, final sign-off     |
| Tester            | Execute test script, log defects, capture evidence    |
| Developer         | Fix defects, provide builds for retest                |
| Project Manager   | Track schedule, escalate blockers                     |

## 12. Approvals

| Name | Role | Signature | Date |
|------|------|-----------|------|
|      |      |           |      |
|      |      |           |      |
|      |      |           |      |
