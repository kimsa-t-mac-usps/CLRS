-- this is the script to updated date HQ departments to Contingent Liabilities Reporting tool
-- find the max primarykey
select max(primarykey) as maxkey
from areas_districts;

-- turn off this define thing so we can use the ampersand in the name
set define off;

-- update the old rows with an THRU_DATE_REPORT
UPDATE areas_districts
set THRU_DATE_REPORT = '31-DEC-2023'
WHERE PRIMARYKEY IN (140);

-- turn the define thing back on
SET DEFINE ON;

commit;