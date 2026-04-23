<html lang="en">
<head>
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<meta content="IE=edge,chrome=1" http-equiv="X-UA-Compatible">
<meta content="width=device-width, initial-scale=1" name="viewport">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<title>

Test dB query

</title>
</head>
<body>
<!--- cfldap Query Example --->
<P>This is a test</P>
  <cfldap

    server="ldaps-prod.usps.gov"
    action="query"
    name="results"
    start="dc=usa,dc=dce,dc=usps,dc=gov"
	filter="(&(objectClass=user)(|(extensionAttribute13=TRFV00)(mailNickName=TRFV00)))"
	scope="subtree"
    attributes="displayName, mail"
    sort="name"
    maxrows="100"
	secure = "CFSSL_BASIC"
	port="636"
	username="usa\smtp_prod_ldis_8309"
	password="2wsx##EDC4rfv%TGB"
  >

  <!--- Display results --->
<!--- cfif (isdefined(#query.results#) AND (#query.results# IS NOT "")) --->
<cftry>
  <table border="0" cellspacing="2" cellpadding="2">

    <tr>

      <th>displayName</th>

      <th>mail</th>


    </tr>

    <!--- cfoutput query="#query.results#" --->

      <tr>

        <td>This is the name: #results.displayName#</td>

        <td>This is the email: #results.mail#</td>


      </tr>

    <!--- /cfoutput --->

  </table>
<!--- cfelse>
<p>"#query.name#"</p>
</cfelse --->
		<cfcatch type="any">
			<cflog text="QueryGetDisplayName Error: #cfcatch.message#" type="error" file="clrs-ldap">
			
		</cfcatch>
		

<!--- /cfif --->
</cftry>
</body>


</html>
