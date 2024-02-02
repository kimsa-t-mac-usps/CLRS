
<!--------------------- Assessment_probabily_Label_Count.loop.cfm ------------>

<CFLOOP CONDITION="(ASSESSMENT_PROBABILITY_Label_Count NEQ ThisASSESSMENT_PROBABILITY) AND (ASSESSMENT_PROBABILITY_Label_Count LE ASSESSMENT_PROBABILITY_Label_List_Len) AND (HeaderParm EQ 'TopIndex')">

<p>

<CFOUTPUT>
<h5 style="color:gray; font-weight:normal; font-size:9pt">[#ListGetAt(ASSESSMENT_PROBABILITY_Label_List, ASSESSMENT_PROBABILITY_Label_Count)#]</h5>
</CFOUTPUT>


<CFIF ASSESSMENT_PROBABILITY_Label_Count EQ ASSESSMENT_PROBABILITY_Label_List_Len>
	<CFBREAK>
</cfif>


<CFSET ASSESSMENT_PROBABILITY_Label_Count = ASSESSMENT_PROBABILITY_Label_Count + 1> 

</cfloop>


