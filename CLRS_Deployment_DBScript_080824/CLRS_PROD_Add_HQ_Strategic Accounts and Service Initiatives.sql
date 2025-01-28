select max(primarykey) as maxkey
from areas_districts;
--set define off;
-- insert the new HQ departments to Contingent Liabilities Reporting
INSERT INTO areas_districts (PRIMARYKEY,area_code,district_code,name,dist_perf_cluster_code,start_date_report)
VALUES(303,'6C',0,'HQ Strategic Accounts and Service Initiatives',0,'31-DEC-2024');
--SET DEFINE ON;
commit;