select max(primarykey) as maxkey
from areas_districts;
--set define off;
-- insert the new HQ departments to Contingent Liabilities Reporting
INSERT INTO areas_districts (PRIMARYKEY,area_code,district_code,name,dist_perf_cluster_code,start_date_report)
VALUES(302,'6B',0,'HQ National Sales',0,'31-DEC-2025');
SET DEFINE ON;
commit;
