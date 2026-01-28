<cfinclude template="MfaCookieCheck.cfm">
<script>
// Popup window code
function newWindow(url) {
	popupWindow = window.open(
		url,
		'popUpWindow','height=300,width=450,left=100,top=100,resizable=yes,scrollbars=yes,toolbar=yes,menubar=no,location=no,directories=no,status=yes')
}

function closeWindow()
{
   if(false == popupWindow.closed)
   {
      popupWindow.close ();
   }
   else
   {
      alert('That window is already closed. Open the window first and try again!!!');
   }
}
</script>
<button onClick="JavaScript:newWindow('/javascript/examples/sample_popup.cfm')">Open Popup Window</button>
<button onClick="JavaScript:closeWindow();">Close Popup Window</button>
<!---<!DOCTYPE html>
<html>
	<head>
		<title>CF Mail Test on DEV</title>
	</head>
	<body>
		<p>This is a test for cfmail to see if the connection works !!!!!</p>
		<!---<cfdump var="#cgi#" >--->
		<cftry>
		<cfmail from="Kimsa.t.mac@usps.gov"
		 subject="Thank you for your email  !!!!!!!!!!!!!"
		  to="Kimsa.t.mac@usps.gov"
		  <!---BCC="Kimsa.t.mac@usps.gov"--->
		   usetls="true" debug="true" >
			<p>Kimsa,</p>
			<p>It worked for me.</p>
			<p>Kimsa</p>
		</cfmail>
		<cfcatch type="any" >
			<cfdump var="#cfcatch#" >
		</cfcatch>
		</cftry>
	</body>
</html>
</html>
--->


