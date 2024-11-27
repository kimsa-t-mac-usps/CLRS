component {
    if(cgi.SERVER_NAME != "127.0.0.1") {
    public void function doMfaInit(relayPage, queryString) {
        //writeLog(text="saml.cfc: relayPage: #arguments.relayPage# | querystring: #arguments.queryString#", type="information",file="ContLiab_samlcfc");
        if(len(arguments.queryString) > 0) {
            returnPage = "#arguments.relayPage#?#arguments.queryString#";
        } else {
            returnPage = "#arguments.relayPage#";
        }
        samlConfig = {
            idp = {name="ContLiab_idp"},
            sp = {name="ContLiab_sp"},
            relayState = "#returnPage#"
        };
        initSamlAuthRequest(samlConfig);
    }
}
}