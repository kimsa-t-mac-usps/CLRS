component {
    function getPrevReptRecord(prevRptDate,caseRecordIdSeq) {
        var sqlString = "SELECT
        date_report,
        case_rec_id_sequence,
        primarykey,
        case_name,
        case_number,
        area_name,
        area_code,
        dist_perf_cluster_name,
        dist_perf_cluster_code,
        division_code,
        division_name
    FROM
        contingent_liab_report
    WHERE
            date_report = :reportDate
        AND case_rec_id_sequence = :caseSeq
        AND deleted_flag IS NULL";
        var qry = new query();
        qry.setdatasource("contliab");
        qry.setname("qPrevReport");
        qry.addparam(name="reportDate",value="#prevRptDate#",cfsqltype="cf_sql_date");
        qry.addparam(name="caseSeq",value="#caseRecordIdSeq#",cfsqltype="cf_sql_numeric");
        qPrevReport = qry.execute(sql=sqlString).getResult();
        return qPrevReport;
        
    }
}
 