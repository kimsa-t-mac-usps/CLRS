<cfinclude template="MfaCookieCheck.cfm">

<!---
For attaching a spreadsheet for a case report: new spreadsheet or updated replacement of previously saved spreadsheet.
Action file: AttachFile.uploadfileaction.cfm
--->


<script language="javascript">

function checkFileSelected(thisForm) {

if (thisForm.FiletoUpload.value == "") return false;

}

</script>




<body style="background:linen; line-height:150%; font-family:Verdana; font-size:9pt; color:maroon; width:40%">



<cfdirectory action="list" 
name="dirQuery" 
directory="#CFFILE_Destination_Dir#"
sort="name, datelastmodified">


<CFSET FileReplace = "no">



    <CFLOOP QUERY="dirQuery">
   
	    <CFIF name EQ "CL.Case." & CaseRecIDSeq & ".GC.xls">
    
			<CFSET savedEasternTime = DateAdd("h", 1, DateLastModified)>

    		<CFOUTPUT>

			<a href="#CFFILE_Uploads_Dir_Link##name#" class="formlink" target="_blank" style="font-weight:bold">Spreadsheet attached</a>
        
        	for FY#RptDateToFmt_FY#, Quarter #RptDateToFmt_FYQuarter#
        
	        <span style="font-family:verdana; font-size:8pt; font-style:italic">(saved #DateFormat(DateLastModified, "m/d/yy")# #TimeFormat(savedEasternTime, "h:mm:ss tt")# Eastern)</span>

		    </CFOUTPUT>

			<CFSET FileReplace = "yes">

			<cfbreak>
        
	    </CFIF>

    </CFLOOP>




<CFIF FileReplace EQ "no">

	<cfdirectory action="list" 
	name="Prev_dirQuery" 
	directory="#PrevCFFILE_Destination_Dir#"
	sort="name, datelastmodified">


<!---
	<CFOUTPUT>
    <p>
    Prev_dirQuery.RecordCount = #Prev_dirQuery.RecordCount#
    <p>
    </CFOUTPUT>
--->


	<CFSET PrevQSpsheetFound = "no">




	    <CFLOOP QUERY="Prev_dirQuery">
   	
		    <CFIF name EQ "CL.Case." & CaseRecIDSeq & ".GC.xls">


				<CFSET PrevQSpsheetFound = "yes">

				<cfbreak>

			</CFIF>

		</CFLOOP>




</CFIF>


<!---
<CFOUTPUT>
<p>
FileReplace = #FileReplace#
<p>
</CFOUTPUT>
--->


<CFIF IsDefined("FileReplace")
AND
FileReplace EQ "no">

	<CFIF IsDefined("Prev_dirQuery.RecordCount")
	AND
	(
	Prev_dirQuery.RecordCount EQ 0
	OR
	PrevQSpsheetFound EQ "no"
	)>

		To attach a spreadsheet to this case report:
    
<!---
Lesson learned: Can't use OL; causes browser to display Divs with style.display=none:
    <ol style="margin-top:0">
--->

		<br>
	    &nbsp;&nbsp;<b>1.</b>&nbsp; Open and fill in the <a href="../Spreadsheets/CL.CILO.Template.xls" target="_blank" style="font-weight:bold">Spreadsheet Template</a>.
		<br>
		&nbsp;&nbsp;<b>2.</b>&nbsp; Save your filled-in spreadsheet to your directory folder.
    
    <CFELSEIF PrevQSpsheetFound EQ "yes">
    
		<CFSET savedEasternTime = DateAdd("h", 1, Prev_dirQuery.DateLastModified)>
                
		To attach a spreadsheet for the current Quarter:
        <br>
	    &nbsp;&nbsp;<b>1.</b>&nbsp; Open and update the spreadsheet from 
        
        <CFOUTPUT>
        
        <a href="#PrevCFFILE_Uploads_Dir_Link##Prev_dirQuery.name#" class="formlink" target="_blank" style="font-weight:bold">FY#PrevRptDateToFmt_FY#, Quarter #PrevRptDateToFmt_FYQuarter#</a>
        
		<span style="font-family:verdana; font-size:8pt; font-style:italic">(saved #DateFormat(Prev_dirQuery.DateLastModified, "m/d/yy")# #TimeFormat(savedEasternTime, "h:mm:ss tt")# Eastern)</span>.

        </CFOUTPUT>
        
		<br>
		&nbsp;&nbsp;<b>2.</b>&nbsp; Save your updated spreadsheet to your directory folder.
    
    </CFIF>
    
    
</CFIF>












<CFOUTPUT>


<div id="FileSelectDiv" style="width:100%; height:100%">



</CFOUTPUT>



<CFIF IsDefined("FileReplace")
AND
FileReplace EQ "no">


	<div id="ClickBrowseDiv" style="margin-bottom:0">

	&nbsp;&nbsp;<b>3.</b>&nbsp; Click <b>Browse</b> and select your 
    

<cfelse>


	<div id="ClickBrowseDiv" style="margin-bottom:0; margin-top:5pt">

	To replace it with an updated spreadsheet: 
    <br>
	&nbsp;&nbsp;<b>1.</b>&nbsp; Click <b>Browse</b> and select your updated

</CFIF>



spreadsheet from your directory folder&nbsp;.&nbsp;.&nbsp;.


</div>


<form name="UploadFile_Form" action="AttachFile.uploadfileaction.cfm" 
enctype="multipart/form-data" method="post" style="margin-top:0; margin-left:16pt">


<input type="hidden" 

<CFIF IsDefined("FileReplace")
AND
FileReplace EQ "yes">

	<cfoutput>
	name="FileReplace" value="#FileReplace#">
	</cfoutput>
    
<cfelse>

	name="FileReplace"> 

</cfif>



<input type="hidden" 


<CFIF IsDefined("CaseRecIDSeq")>

	<cfoutput>
	name="CaseRecIDSeq" value="#CaseRecIDSeq#">
	</cfoutput>
    
<cfelse>

	name="CaseRecIDSeq">
    
</cfif>


<CFOUTPUT>
<input type="hidden" name="RecID" value="#RecIDParm#">
</CFOUTPUT>





<!--- Initial display: Div hides remnant of text field in FiletoUpload input field: --->
<div id="HideLineDiv" style="position:absolute; z-index:10; background:linen; width:3px; height:21px; left:20px"></div>

<!---
margin-left:16pt; 
--->

<input id="FiletoUpload_Button" type="file" name="FiletoUpload" size="160" style="width:0px; border-width:1px; font-size:10pt" onClick="this.style.width='500px'; this.style.marginLeft='0px'; HideLineDiv.style.display = 'none'; AttachButtonDiv.style.display = 'inline'">


<div style="margin-top:0">


<div id="AttachButtonDiv" style="display:none; margin-top:0; margin-bottom:2pt; color:red; font-weight:bold; font-family:Verdana">

<span style="font-size:25pt; font-weight:bold; color:red; position:relative; top:+4px">&rarr;</span> 

<!---
<li>
--->


<CFIF IsDefined("FileReplace")
AND
FileReplace EQ "no">

	&nbsp;&nbsp;<b>4.</b>&nbsp; 

<cfelse>

	&nbsp;&nbsp;<b>2.</b>&nbsp; 

</CFIF>







Then click&nbsp;&nbsp;<input id="AttachButton" type="submit" value="Attach Spreadsheet to Report" onClick="return checkFileSelected(this.form)" style="width:150pt; border-width:1px; background:maroon; color:white; font-weight:bold">

</div>



</div>


<!---
<CFINCLUDE TEMPLATE="AttachFile.ReturnFormFields.cfm">
--->

</form>


</div id="FileSelectDiv">



<!---
<p>
<a href="../Spreadsheets/CL.Case.template.xls" target="_blank" style="font-weight:bold">Spreadsheet Template</a>
--->

</body>


