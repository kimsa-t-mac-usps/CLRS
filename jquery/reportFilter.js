$(document).ready(function(){
    
    $('#unionSelect').hide();

    $('#Select_DIST_PERF_CLUSTER_CODE').on('change',function(event) {
        event.preventDefault();
        let url = checkEarlierRpt(event);
        let selectedVal = $('#Select_DIST_PERF_CLUSTER_CODE').val();
        url = url + "SelectedPC=" + selectedVal;
        console.log("URL: " + url);
        let encoded = encodeURI(url);
        location.href = encoded;
        
    });
   
    $('#Select_DIVISION_CODE').on('change',function(event) {
        event.preventDefault();
        let url = checkEarlierRpt(event);
        let selectedVal = $('#Select_DIVISION_CODE').val();
        url = url + "SelectedPC=" + selectedVal;
        console.log("URL: " + url);
        let encoded = encodeURI(url);
        location.href = encoded;
    });

    $('#Select_HQ_AREA_NAME').on('change',function(event) {
        event.preventDefault();
        let url = checkEarlierRpt(event);
        console.log("URL: " + url);
        let selectedVal = $('#Select_HQ_AREA_NAME').val();
        console.log("SELECTEDVAL: " + selectedVal);
        url = url + "SelectedHQDept=" + selectedVal;
        let encoded = encodeURI(url);
        console.log("ENCODED: " + encoded);
        if (selectedVal == "6X // HQ Labor Relations") {
            $('#unionSelect').show();
            $('#Select_UNIONS_SELECTED').on('change',function() {
                let selectedUnion = $('#Select_UNIONS_SELECTED').val();
                console.log("UNION: " + selectedUnion);
                url = url + "&SelectedUnion=" + selectedUnion;
                console.log("UNION URL: " + url);
                encoded = encodeURI(url);
                console.log("UNION ENCODED: " + encoded);
                location.href = encoded;
            })    
        } else {
            $('#unionSelect').hide();
             location.href = encoded; 
        }
       
    });

    function checkEarlierRpt(event) {
        console.log(event);
        let urlString = event.currentTarget.baseURI;
        let fileIndex = urlString.indexOf("Report");
        let result = urlString.slice(fileIndex);
        if(result.indexOf("EarlierRptDate") > -1) {
            result = result + "&";
        } else {
            result = result + "?";
        }
        console.log("RESULT: " + result);
        return result;

    }

});
/* https://lawdept1.usps.gov/ClientService/ContingentLiabilities/V1.0/Report.full.cfm?SelectedHQDept=6X%20//%20HQ%20Labor%20Relations&SelectedUnion=Mail%20Handlers */