$(document).ready(function(){

    if ($('#Select_HQ_AREA_NAME').val() == "6X // HQ Labor Relations") {
        $('#unionSelect').show();
    } else {
        $('#unionSelect').hide();
    }
    
    

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
       
        location.href = encoded; 
    });

    $('#Select_UNIONS_SELECTED').on('change',function(event) {
        event.preventDefault();
        let url = checkEarlierRpt(event);
        url = clearHq(url);
        let selectedVal = $('#Select_UNIONS_SELECTED').val();
        url = url + "&SelectedUnion=" + selectedVal;
        let encoded = encodeURI(url);
        location.href = encoded;
    });

    

    $('#Select_LDOffice').on('change',function(event){
        event.preventDefault();
        let url = checkEarlierRpt(event);
        let selectedVal = $('#Select_LDOffice').val();
        url = url + "SelectedLDOffice=" + selectedVal;
        console.log("URL: " + url);
        let encoded = encodeURI(url);
        console.log("ENCODED: " + encoded);
        location.href = encoded;

    });

   

    $('#Select_CaseCategory').on('change',function(event) {
        event.preventDefault();
        let url = checkEarlierRpt(event);
        let selectedVal = $('#Select_CaseCategory').val();
        url = url + "SelectedCategory=" + selectedVal;
        console.log("URL: " + url);
        let encoded = encodeURI(url);
        console.log("ENCODED: " + encoded);
        location.href = encoded;
    })

    function checkEarlierRpt(event) {
        console.log(event);
        let urlString = event.currentTarget.baseURI;
        let fileIndex = urlString.indexOf("Report");
        let result = urlString.slice(fileIndex);
        let hqIdx = result.indexOf("SelectedHQDept");
        if(result.indexOf("EarlierRptDate") > -1) {
            result = result + "&";
        } else if (result.indexOf("SelectedHQDept") > -1) {
            result = result + "&";
        } else {
            result = result + "?";
        }
        if (hqIdx == -1) {
        result = clearCaseCat(result);
        }
        console.log("RESULT: " + result);
        return result;

    }

    function clearCaseCat(resultString) {
        let idx = resultString.indexOf("Select");
        if(idx > -1) {
            let caseSubStr = resultString.substring(idx,resultString.length);
            resultString = resultString.replace(caseSubStr,'');
        }
        
        return resultString;
    }

    function clearHq(urlString) {
        let hqIdx = urlString.indexOf("SelectedHQDept");
        if(hqIdx > -1) {
            let hqSubStr = urlString.substring(hqIdx,urlString.length);
            urlString = urlString.replace(hqSubStr,"SelectedHQDept=6X // HQ Labor Relations");
        }
        return urlString;
    }

   
   // selectedOption = selectedOption.replaceAll(/&/g,"%26");

    

});