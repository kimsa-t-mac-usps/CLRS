-- this is the script to add new HQ departments to Contingent Liabilities Reporting tool
-- find the max primarykey
select max(primarykey) as maxkey
from areas_districts;
-- turn off this define thing so we can use the ampersand in the name
set define off;
-- insert the new HQ departments to Contingent Liabilities Reporting
INSERT INTO areas_districts (PRIMARYKEY,area_code,district_code,name,dist_perf_cluster_code,start_date_report)
VALUES(299,'6V',0,'HQ Senior Logistics',0,'01-OCT-2023');
INSERT INTO areas_districts (PRIMARYKEY,area_code,district_code,name,dist_perf_cluster_code,start_date_report)
VALUES(300,'6G',0,'HQ Applied Engineering',0,'01-OCT-2023');
-- turn the define thing back on
SET DEFINE ON;
commit;
