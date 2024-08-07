-- this is the script to add new HQ departments to Contingent Liabilities Reporting tool
-- find the max primarykey
select max(primarykey) as maxkey
from areas_districts;

-- turn off this define thing so we can use the ampersand in the name
set define off;

-- insert the new HQ departments to Contingent Liabilities Reporting
INSERT INTO areas_districts (PRIMARYKEY,area_code,district_code,name,dist_perf_cluster_code,start_date_report)
VALUES(294,'6A',0,'HQ Business & Commercial Initiatives',0,'01-OCT-2023');
INSERT INTO areas_districts (PRIMARYKEY,area_code,district_code,name,dist_perf_cluster_code,start_date_report)
VALUES(295,'6B',0,'HQ Corporate Affairs',0,'01-OCT-2023');
--INSERT INTO areas_districts (PRIMARYKEY,area_code,district_code,name,dist_perf_cluster_code,start_date_report)
--VALUES(296,'6G',0,'HQ Plant & Process Modernization ',0,'01-OCT-2023');
INSERT INTO areas_districts (PRIMARYKEY,area_code,district_code,name,dist_perf_cluster_code,start_date_report)
VALUES(297,'6B',0,'HQ Infrastructure and Operations Support ',0,'01-OCT-2023');
INSERT INTO areas_districts (PRIMARYKEY,area_code,district_code,name,dist_perf_cluster_code,start_date_report)
VALUES(298,'6F',0,'HQ Network Infrastructure Technology',0,'01-OCT-2023');

-- update the old rows with an ending date
UPDATE areas_districts
set thru_date_report = '30-SEP-2023'
WHERE PRIMARYKEY IN (294,295,297,298);

-- turn the define thing back on
SET DEFINE ON;

commit;
