# Test Plan: URL/Link Hardcode Replacement & New Server Verification

**Application:** Contingent Liabilities V1.0  
**Date:** March 25, 2026  
**Objective:** Verify all hardcoded URLs have been replaced with soft link variables and all links resolve correctly to the new dev server (`lawdept-dev.usps.gov`).

---

## 1. Centralized Base URL Configuration (application.cfm)

All soft link variables are defined in `application.cfm` (lines 280–283).

| Variable | Expected Value | Status |
|---|---|---|
| `This_Server_Base_URL` | `https://` + `CGI.SERVER_NAME` | [ ] Pass / [ ] Fail |
| `LawDept_Base_URL` | `https://lawdept-dev.usps.gov` | [ ] Pass / [ ] Fail |
| `LawDept1_Base_URL` | `https://lawdept-dev.usps.gov` | [ ] Pass / [ ] Fail |
| `LawManager_Base_URL` | `https://lawdept-dev.usps.gov/lmWeb` | [ ] Pass / [ ] Fail |

### Test Steps
1. Open `application.cfm` and confirm all four variables above are set to the expected values.
2. Confirm no hardcoded old server names remain (`lawdept.usps.gov`, `lawdept1.usps.gov`, `lawdept2.usps.gov`, `eagnmntwe1860`, `eagnmnss29c`, `56.207.31.151`).

---

## 2. Soft Link Usage Verification — Per File

### 2.1 checkUserAtty.cfm (line 324)
- **Link:** `#LawDept_Base_URL#/InHouse/conting.liab.htm`
- **Expected Resolved URL:** `https://lawdept-dev.usps.gov/InHouse/conting.liab.htm`
- **Test:** Log in as an authorized user. Confirm the "Contingent Liability Protocol and Reference Materials" link appears and navigates to the correct page.
- [ ] Link displayed correctly
- [ ] Link navigates to correct destination
- [ ] Page loads without errors

### 2.2 Instruc.Form.Requirements.cfm (line 26)
- **Link:** `#LawDept_Base_URL#/inhouse/conting.liab.htm`
- **Expected Resolved URL:** `https://lawdept-dev.usps.gov/inhouse/conting.liab.htm`
- **Test:** Open the Insert Record form. Confirm the "Contingent Liability Protocol" link in the instructions section is correct.
- [ ] Link displayed correctly
- [ ] Link navigates to correct destination
- [ ] Page loads without errors

### 2.3 TopRightLinksDiv.FromCF9..cfm (line 56)
- **Link:** `#LawDept_Base_URL#/inhouse/conting.liab.htm`
- **Expected Resolved URL:** `https://lawdept-dev.usps.gov/inhouse/conting.liab.htm`
- **Test:** Open the Report page. Confirm the "Contingent Liability Protocol" link in the top-right navigation is correct.
- [ ] Link displayed correctly
- [ ] Link navigates to correct destination
- [ ] Page loads without errors

### 2.4 TopRightLinksDiv.cfm (line 33)
- **Link:** `#LawDept_Base_URL#/inhouse/conting.liab.htm`
- **Expected Resolved URL:** `https://lawdept-dev.usps.gov/inhouse/contig.liab.htm`
- **Test:** Verify this alternate top-right links template renders the Protocol link correctly.
- [ ] Link displayed correctly
- [ ] Link navigates to correct destination
- [ ] Page loads without errors

### 2.5 EditRecord.ptB.cfm (line 116)
- **Link:** `#LawManager_Base_URL#/tabular.jsp?NB=MatterAllWS&QRY=|matter_key%3D[KEY]`
- **Expected Resolved URL:** `https://lawdept-dev.usps.gov/lmWeb/tabular.jsp?NB=MatterAllWS&QRY=|matter_key%3D[KEY]`
- **Test:** Open an existing case record for editing. Confirm the "LawManager" link next to the Matter Number is correct and opens LawManager.
- [ ] Link displayed correctly
- [ ] Link navigates to correct destination (LawManager)
- [ ] Page loads without errors

### 2.6 Report.ptC.cfm (lines 186, 228)
- **Link:** `#LawManager_Base_URL#/tabular.jsp?NB=MatterAllWS&QRY=|matter_key%3D[KEY]`
- **Expected Resolved URL:** `https://lawdept-dev.usps.gov/lmWeb/tabular.jsp?NB=MatterAllWS&QRY=|matter_key%3D[KEY]`
- **Test:** View the report. Confirm the "LawManager" links in the case detail section (Part C) are correct.
- [ ] First LawManager link (line 186) correct
- [ ] Second LawManager link (line 228) correct
- [ ] Links navigate to correct destination

### 2.7 Report.cfm (line 30)
- **Link:** `#This_Server_Base_URL#/ClientService/ContingentLiabilities/#ServerFolder#Report.full.cfm`
- **Expected Resolved URL:** `https://[SERVER_NAME]/ClientService/ContingentLiabilities/V1.0/Report.full.cfm`
- **Test:** Open Report.cfm. Confirm the JavaScript redirect to Report.full.cfm works and the URL resolves correctly.
- [ ] Redirect works
- [ ] Full report page loads
- [ ] Page loads without errors

### 2.8 EditRecord.cfmail.cfm (line 139)
- **Link:** `#This_Server_Base_URL#/InHouse/ContingentLiabilities/#ServerFolder#Report.cfm?RecIDParm=[ID]`
- **Expected Resolved URL:** `https://[SERVER_NAME]/InHouse/ContingentLiabilities/V1.0/Report.cfm?RecIDParm=[ID]`
- **Test:** Edit and save a case record. Check the confirmation email for the correct report link.
- [ ] Email sent successfully
- [ ] Link in email is correct
- [ ] Link in email navigates to correct report page

### 2.9 InsertRecord.cfmail.cfm (line 199)
- **Link:** `#LawDept1_Base_URL#/ClientService/ContingentLiabilities/#ServerFolder#Report.cfm?RecIDParm=[ID]`
- **Expected Resolved URL:** `https://lawdept-dev.usps.gov/ClientService/ContingentLiabilities/V1.0/Report.cfm?RecIDParm=[ID]`
- **Test:** Insert a new case record. Check the confirmation email for the correct report link.
- [ ] Email sent successfully
- [ ] Link in email is correct
- [ ] Link in email navigates to correct report page

### 2.10 SendEmailFromMC.cfm (line 381)
- **Link:** `#LawDept1_Base_URL#/ClientService/ContingentLiabilities/V1.0/Report.cfm?RecIDParm=[ID]`
- **Expected Resolved URL:** `https://lawdept-dev.usps.gov/ClientService/ContingentLiabilities/V1.0/Report.cfm?RecIDParm=[ID]`
- **Test:** Approve or disapprove a case as Managing Counsel. Check the notification email for the correct report link.
- [ ] Email sent successfully
- [ ] Link in email is correct
- [ ] Link in email navigates to correct report page

---

## 3. No Remaining Hardcoded Old URLs

Verify no active (non-commented) code contains hardcoded references to any of these old servers:

| Old Server / Pattern | Should NOT appear in active code | Status |
|---|---|---|
| `lawdept.usps.gov` (without `-dev`) | Confirmed removed | [ ] Pass / [ ] Fail |
| `lawdept1.usps.gov` | Never existed in codebase | [ ] Pass / [ ] Fail |
| `lawdept2.usps.gov` | Confirmed removed | [ ] Pass / [ ] Fail |
| `56.207.31.151` | Confirmed removed | [ ] Pass / [ ] Fail |
| `eagnmntwe1860` | Confirmed removed from application.cfm | [ ] Pass / [ ] Fail |
| `eagnmnss29c` | Confirmed removed from application.cfm | [ ] Pass / [ ] Fail |

### Test Steps
1. Do a workspace-wide search for each pattern above.
2. Confirm any remaining matches are only inside `<!--- --->` comments or in `PRO_application.cfm` (production template, not yet updated).

---

## 4. End-to-End Functional Tests

| # | Scenario | Steps | Expected Result | Status |
|---|---|---|---|---|
| 4.1 | Authorized user login | Log in as a user with `CONTINGENT_LIAB_AUTH = 'A'` | ContingLiabLinks div appears with Protocol and Report links | [ ] Pass / [ ] Fail |
| 4.2 | Office-scoped user login | Log in as a user with auth `'O'`, `'B'`, or `'T'` | Report link and Protocol link display correctly | [ ] Pass / [ ] Fail |
| 4.3 | Individual attorney login | Log in as an attorney assigned to cases | Report link appears for their assigned cases | [ ] Pass / [ ] Fail |
| 4.4 | Unauthorized user login | Log in as a non-authorized user | IFrame hidden, no Contingent Liabilities links shown | [ ] Pass / [ ] Fail |
| 4.5 | View full report | Click "Current Report" link | Report.cfm redirects to Report.full.cfm on correct server | [ ] Pass / [ ] Fail |
| 4.6 | View LawManager link | Open case with LM_MATTER_KEY | LawManager link opens correct LawManager page | [ ] Pass / [ ] Fail |
| 4.7 | Insert new case email | Submit a new case via InsertRecord.cfm | Email contains link to `lawdept-dev.usps.gov` report page | [ ] Pass / [ ] Fail |
| 4.8 | Edit case email | Edit and save a case via EditRecord.cfm | Email contains link with correct server URL | [ ] Pass / [ ] Fail |
| 4.9 | MC approval email | Approve a case via SendEmailFromMC.cfm | Email contains link to `lawdept-dev.usps.gov` report page | [ ] Pass / [ ] Fail |
| 4.10 | Protocol page | Click "Contingent Liability Protocol" link | Opens `lawdept-dev.usps.gov/InHouse/conting.liab.htm` | [ ] Pass / [ ] Fail |

---

## 5. Files Changed Summary

| File | Change Made |
|---|---|
| `application.cfm` | Set `LawDept_Base_URL`, `LawDept1_Base_URL`, `LawManager_Base_URL` to `lawdept-dev.usps.gov`; removed old commented-out server/path blocks |
| `checkUserAtty.cfm` | Removed old hardcoded URL comment; active link uses `#LawDept_Base_URL#` |
| `calendar5.js` | Removed commented-out old `STR_ICONPATH` URL |
| `Instruc.Form.Requirements.cfm` | Removed old URL comment; active link uses `#LawDept_Base_URL#` |
| `TopRightLinksDiv.FromCF9..cfm` | Removed old URL comment; active link uses `#LawDept_Base_URL#` |
| `EditRecord.ptB.cfm` | Removed old IP and duplicate commented-out links; active link uses `#LawManager_Base_URL#` |
| `Report.ptC.cfm` | Removed old IP and duplicate commented-out links; active links use `#LawManager_Base_URL#` |
| `Report.TopIndexDiv.cfloops.cfm` | Removed old commented-out image URL references |
| `SendEmailFromMC.cfm` | Removed old hardcoded URL comment; active link uses `#LawDept1_Base_URL#` |

---

## 6. Not Yet Updated (Out of Scope)

| File | Notes |
|---|---|
| `PRO_application.cfm` | Production template — contains old server references in comments. Deferred per request. |

---

## Sign-Off

| Role | Name | Date | Signature |
|---|---|---|---|
| Tester | | | |
| Developer | | | |
| Reviewer | | | |
