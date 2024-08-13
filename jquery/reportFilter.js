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
        selectedVal = removeAmp(selectedVal);
        url = url + "SelectedPC=" + selectedVal;
        console.log("URL: " + url);
        let encoded = encodeURI(url);
        location.href = encoded;
        
    });

    
   
    $('#Select_DIVISION_CODE').on('change',function(event) {
        event.preventDefault();
        let url = checkEarlierRpt(event);
        let selectedVal = $('#Select_DIVISION_CODE').val();
        selectedVal = removeAmp(selectedVal);
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
        selectedVal = removeAmp(selectedVal);
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
        selectedVal = removeAmp(selectedVal);
        url = url + "&SelectedUnion=" + selectedVal;
        let encoded = encodeURI(url);
        location.href = encoded;
    });

    

    $('#Select_LDOffice').on('change',function(event){
        event.preventDefault();
        let url = checkEarlierRpt(event);
        let selectedVal = $('#Select_LDOffice').val();
        selectedVal = removeAmp(selectedVal);
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
        selectedVal = removeAmp(selectedVal);
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
        let result = decodeURI(urlString.slice(fileIndex));
        let unionIdx = result.indexOf("SelectedUnion");
        let hqLrIdx = result.indexOf("SelectedHQDept=6X // HQ Labor Relations");
        let hqDeptIdx = result.indexOf("SelectedHQDept");
        if(result.indexOf("EarlierRptDate") > -1) {
            result = result + "&";
        } else if (hqLrIdx > -1) {
            result = result + "&";
        } else {
            result = result + "?";
        }
        if ((hqLrIdx == -1 || unionIdx > -1) || (hqLrIdx == -1 && hqDeptIdx > -1))  {
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

    function removeAmp(selectString) {
        let ampIdx = selectString.indexOf("&");
        if(ampIdx > -1) {
            selectString = selectString.replaceAll(/&/g, '%26');

        }
        selectString = selectString.trim();
        return selectString;
    }

   
   // selectedOption = selectedOption.replaceAll(/&/g,"%26");

    

});