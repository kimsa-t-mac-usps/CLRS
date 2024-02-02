-- this is the script to add new HQ departments to Contingent Liabilities Reporting tool

-- find the max primarykey
select max(primarykey) as maxkey
from areas_districts;

-- turn off this define thing so we can use the ampersand in the name
set define off;

-- insert the new rows
INSERT INTO areas_districts (PRIMARYKEY,area_code,district_code,name,dist_perf_cluster_code,start_date_report)
VALUES(292,'6_',0,'HQ Sales Intelligence & Support',0,'01-OCT-2023');
INSERT INTO areas_districts (PRIMARYKEY,area_code,district_code,name,dist_perf_cluster_code,start_date_report)
VALUES(293,'6_',0,'HQ International Business',0,'01-OCT-2023');

-- update the old rows with an ending date
UPDATE areas_districts
set thru_date_report = '30-SEP-2023'
WHERE PRIMARYKEY IN (101,102);

-- turn the define thing back on
SET DEFINE ON;

commit;
