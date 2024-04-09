component {
    function getUserId(userPkey) {
        var sqlString = "SELECT
        ldextra.ad_userid as userid
    FROM
        ldextra
    WHERE
        ldextra.primarykey = :pk";
        var qry = new query();
        qry.setname("quser");
        qry.setdatasource("ContLiab")
        qry.addparam(name="pk", value="#userPkey#", cfsqltype="cf_sql_numeric");
        quser = qry.execute(sql=sqlString).getResult();
        return quser;

    }
}