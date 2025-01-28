select max(primarykey) as maxkey
from areas_districts;
set define off;
-- insert the new HQ departments to Contingent Liabilities Reporting
INSERT INTO areas_districts (PRIMARYKEY,area_code,district_code,name,dist_perf_cluster_code,start_date_report)
VALUES(301,'6C',0,'HQ VP Strategic Accounts and Service Initiatives',0,'01-OCT-2023');
SET DEFINE ON;
commit;
