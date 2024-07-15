component {
    function getPrevReptRecord(prevRptDate,caseRecordIdSeq) {
        var sqlString = "select * from contingent_liab_report where date_report = :reportDate and case_rec_id_sequence = :caseSeq and deleted_flag is null";
        var qry = new query();
        qry.setdatasource("contliab");
        qry.setname("qPrevReport");
        qry.addparam(name="reportDate",value="#prevRptDate#",cfsqltype="cf_sql_date");
        qry.addparam(name="caseSeq",value="#caseRecordIdSeq#",cfsqltype="cf_sql_numeric");
        qPrevReport = qry.execute(sql=sqlString).getResult();
        return qPrevReport;
        
    }
}
 