-- this is the script to updated old rows in areas districts HQ departments to Contingent Liabilities Reporting too
-- find the max primarykey
select max(primarykey) as maxkey
from areas_districts;

-- turn off this define thing so we can use the ampersand in the name
set define off;

-- update the old rows with an NAME
UPDATE areas_districts
set NAME = 'Westshore Division'
WHERE PRIMARYKEY IN (290);

-- turn the define thing back on
SET DEFINE ON;

commit;
