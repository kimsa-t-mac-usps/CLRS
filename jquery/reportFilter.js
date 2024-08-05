$(document).ready(function(){
    let url="report.full.cfm?";
    $('#Select_DIST_PERF_CLUSTER_CODE').on('change',function() {
        let selectedVal = $('#Select_DIST_PERF_CLUSTER_CODE').val();
        url = url + "SelectedPC=" + selectedVal;
        let encoded = encodeURI(url);
        location.href = encoded;
    })
});