<cfinclude template="MfaCookieCheck.cfm">
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Page with iFrame that FITS!</title>
    <style type="text/css" media="screen">
  html, body {
     position: absolute;
     height: 100%;
     max-height: 100%;
     width: 100%;
     margin: 0;
     padding: 0;
   }
   iframe {
     position: fixed;
     height: 100%;
     width: 100%;
     border: none;
   }
   #container {
     position: fixed;
     top: 10px; /* Change with Height of #header */
     bottom: 0;
     width: 100%;
     overflow: hidden ;
   }
   #header {
     position:fixed;
     top: 10px;
     height: 40px; /* Change with top of #container */
     color: #eee;
     background-color: lightgreen;
     width: 100%;
   }
.page {
  page-break-after: always;
}
  @page {
  margin: 1mm
}


  </style>
    
 
</head>
<body>
<div id="header">
  <div id="container">
    <iframe src="Report.ptC.cfm"></iframe>
  </div></div>
   
    <br /><br />
  <div class="page" style="line-height: 2;">
      <h3><a href="https://www.w3schools.com" </a>Probable</h3> <br />
      <h3><a href="https://www.w3schools.com/" </a>Claims</h3> 
      <div id="mybody">Case Label: Case1!</div>
  
 </div>
    <script>
        var count = 10; // number of images
        var myBody = document.getElementById("mybody");

        i = 0;
        while (i < count) {
            document.getElementById("mybody").innerHTML += "<div class='adddiv'><strong>Case Label:</strong> Case " + i.toString() + "</div>";
            i++;
        }
    </script>
          
</body>
</html>



