oldFusion2021\cfusion\wwwroot\ClientService\ContingentLiabilities\ldis-CLRS-MFA_APPCFC\ldis-CLRS-V2">
<cfset fileList = directoryList(path="#directoryPath#", recurse="false" ,listInfo="path" ,filter="*.cfm" ,type="all")>
    <cfdump var="#fileList#">
    <cfset doNotIncludeList = "application.cfm,MfaCookieCheck.cfm,mfaInsertUtility.cfm,cfswitch.serveraddr_id.cfm,serverName.cfm,Query.Get_Bus_Serv_Contact.cfm,LabelLists.cfm,RptDateFYQFmt.cfm,SetUserID.TestUser.cfm">
    <cfset deleteContent = '<cfinclude template="MfaCookieCheck.cfm">'>
    <cfloop from="1" to="#arraylen(fileList)#" index="i">
        <cfif listfindnocase(donotIncludeList,getFileFromPath(fileList[i])) eq 0>
            <cffile action="read" file="#fileList[i]#" variable="fileContents">
            <cfif findNoCase(deleteContent,fileContents) gt 0>
                <cfset fileContents = right(fileContents,len(fileContents)-len(deleteContent))>
                <cffile action="write" file="#fileList[i]#" output="#filecontents#">
                <cfoutput><p>#i# #fileList[i]#</p></cfoutput>
            </cfif>
        </cfif>
    </cfloop>
    <cfcatch type="any">
        <cfdump var=#cfcatch#>
    </cfcatch>
</cftry>


