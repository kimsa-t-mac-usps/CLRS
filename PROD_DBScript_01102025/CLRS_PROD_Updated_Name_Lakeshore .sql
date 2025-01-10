-- this is the script to updated in areas districts HQ departments to Contingent Liabilities Reporting tool
-- find the max primarykey
select max(primarykey) as maxkey
from areas_districts;
-- turn off this define thing so we can use the ampersand in the name
set define off;
-- update with an NAME
update areas_districts set name = 'Lakeshores Division' where division_code = 'Lakeshores Division';
-- turn the define thing back on
SET DEFINE ON;
commit;

