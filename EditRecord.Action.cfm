<cfinclude template="MfaCookieCheck.cfm">

<html>
<head>
<title>Law Department Contingent Liabilities: Edit Record Action</title>

</head>

<body>

<!---
5/21/09 Changed SQL references to 5000000 cutoff: Use ASSESSMENT_AMOUNT instead of ASSESSMENT_AMOUNT_UPPER
--->

<!---
<CFOUTPUT>

STATUS_CODE_SELECTED = #Form.STATUS_CODE#

</CFOUTPUT>

--->


<!---
<script>

alert("CaseForm_1.STATUS_CODE = " + CaseForm_1.STATUS_CODE.value);

// alert("CaseForm_1.STATUS_CODE = ");


</script>
--->



<CFIF IsDefined("Form.RecID")>
	<CFSET ThisRecID = Form.RecID>
<CFELSEIF IsDefined("RecIDParm")>
	<CFSET ThisRecID = RecIDParm>
</cfif>



<CFIF IsDefined("Form.ActionButton") 
AND 
Form.ActionButton EQ "Delete This Record">


	<CFQUERY NAME="CONTINGENT_LIAB_Delete_Record" DATASOURCE="contliab">
	
	UPDATE CONTINGENT_LIAB_REPORT
	SET
	DELETED_FLAG = 'D',
	DELETED_FLAG_SETBY_USERID = '#RespondingUser_Id#',
	DELETED_FLAG_DATE = SYSDATE
	
	WHERE PRIMARYKEY = #ThisRecID#
	
	</cfquery>
	


<CFELSEIF IsDefined("LockFlag")>


	<CFIF LockFlag EQ "Lock">
	
		<CFQUERY NAME="CONTINGENT_LIAB_LockRecord" DATASOURCE="contliab">
		
		UPDATE CONTINGENT_LIAB_REPORT
		SET FINALIZED_FLAG = 1
		WHERE PRIMARYKEY = #ThisRecID#
		
		</cfquery>
	
	<CFELSEIF LockFlag EQ "UNLock">
	
		<CFQUERY NAME="CONTINGENT_LIAB_LockRecord" DATASOURCE="contliab">
		
		UPDATE CONTINGENT_LIAB_REPORT
		SET FINALIZED_FLAG = 0
		WHERE PRIMARYKEY = #ThisRecID#
		
		</cfquery>
		
	</cfif>

<!--- Add check for UndoApprFlag --->

<CFELSEIF IsDefined("UndoApprFlag") 
AND 
UndoApprFlag EQ "UndoAppr">


	<CFQUERY NAME="CONTINGENT_LIAB_UndoAppr" DATASOURCE="contliab">
	UPDATE CONTINGENT_LIAB_REPORT
	SET
		CONCUR_MC = NULL,
		CONCUR_MC_DATE = NULL,
		CONCUR_MC_USER_ID = NULL,
		CONCUR_ALT = NULL,
		CONCUR_ALT_DATE = NULL,
		CONCUR_ALT_USER_ID = NULL
	
	WHERE PRIMARYKEY = #ThisRecID#
	</cfquery>
	
<!--- End UndoApprFlag check --->
<CFELSE>

	<CFIF IsDefined("Form.ActionButton") 
	AND 
	Form.ActionButton EQ "Update Checklist">
	
	
		<CFSET QuesNumList = ValueList(Get_ChecklistQues.QUESNUM_TRIM)>
		<CFSET QuesNumListSQLFields = "">
		<CFSET QuesNumListSQLValues = "">
	
	<!---
	Save Checklist Reponses:
	--->
	
		<CFQUERY NAME="Update_Checklist_Reponses" DATASOURCE="contliab">
		
		UPDATE CONTINGENT_LIAB_C_E_CHECKLIST
		
		SET
		
		UPD_DATE = SYSDATE,
		
		UPD_USERID = '#RespondingUser_Id#',
		
		FORUM = '#Form.FORUM#',
		CLIENT = '#Form.CLIENT#',
		
		<CFIF IsDefined("Form.MC_APPR_FLAG")>
		MC_APPR_FLAG = #Form.MC_APPR_FLAG#,
		MC_USERID = '#RespondingUser_Id#',
		</cfif>
		
		<CFIF IsDefined("Form.MC_COMMENT")>
		
		<CFSET ThisMC_COMMENT = Trim(Form.MC_COMMENT)>
		<CFSET ThisMC_COMMENT = JSStringFormat(ThisMC_COMMENT)>
		<CFSET ThisMC_COMMENT = Replace(ThisMC_COMMENT, "\r\n", "<br>", "ALL")>
		MC_COMMENT = <CFQUERYPARAM VALUE="#ThisMC_COMMENT#" CFSQLType="CF_SQL_LONGVARCHAR">,
		
		</cfif>
		
		
		
		<CFLOOP INDEX="QuesNumListIndex" LIST="#QuesNumList#">
		
		<CFSET ThisFormQues = "Form.ChecklistResponse_" & QuesNumListIndex>
		
		<CFIF IsDefined(ThisFormQues)>
			<CFSET QuesNumListSQLFields = ListAppend(QuesNumListSQLFields, "QUES_" & QuesNumListIndex)>
		</cfif>
		
		</cfloop>
		
		
		
		<CFLOOP INDEX="QuesNumListIndex" LIST="#QuesNumList#">
		
		<CFSET ThisFormReponse = "Form.ChecklistResponse_" & QuesNumListIndex>
		
		<CFIF IsDefined(ThisFormReponse)>
			<CFSET QuesNumListSQLValues = ListAppend(QuesNumListSQLValues, Evaluate(ThisFormReponse))>
		</cfif>
		
		</cfloop>
		
		
		<CFSET QuesNumListSQLValues_Counter = 0>
		<CFSET ListLenQuesNumListSQLValues = ListLen(QuesNumListSQLValues)>
		
		<CFLOOP INDEX="QuesNumListSQLFields_Index" LIST="#QuesNumListSQLFields#">
		
		<CFSET QuesNumListSQLValues_Counter = QuesNumListSQLValues_Counter + 1>
		
		<CFIF ListGetAt(QuesNumListSQLValues, QuesNumListSQLValues_Counter) EQ "99">
		#QuesNumListSQLFields_Index# = ''
		<CFELSE>
		#QuesNumListSQLFields_Index# = '#ListGetAt(QuesNumListSQLValues, QuesNumListSQLValues_Counter)#'
		</cfif>
		
		<CFIF QuesNumListSQLValues_Counter LT ListLen(QuesNumListSQLValues)>
		,
		</cfif>
		
		</cfloop>
		
		
		WHERE CASE_REC_ID_SEQUENCE = #Form.CASE_REC_ID_SEQUENCE#
		
		</cfquery>
		
		
	<CFELSE>
		
	<!---
	Update Main Record:
	--->
	
		<CFIF IsDefined("Form.MC_APPR_FLAG") OR IsDefined("Form.MC_COMMENT")>
		
			<CFQUERY NAME="CONTINGENT_LIAB_C_E_CHECKLISTUpdate" DATASOURCE="contliab">
			
			UPDATE CONTINGENT_LIAB_C_E_CHECKLIST
			
			SET
			
			<!---
			UPD_DATE = to_date('#todayDateFmt#', 'mm/dd/yyyy'),
			--->
			
			UPD_DATE = SYSDATE,
			
			UPD_USERID = '#RespondingUser_Id#',
			MC_USERID = '#RespondingUser_Id#',
			
			<CFIF IsDefined("Form.MC_APPR_FLAG")>
			MC_APPR_FLAG = #Form.MC_APPR_FLAG#
			</cfif>
			
			<CFIF IsDefined("Form.MC_COMMENT")>
			
			<CFIF IsDefined("Form.MC_APPR_FLAG")>
			,
			</cfif>
			
			<CFSET ThisMC_COMMENT = Trim(Form.MC_COMMENT)>
			<CFSET ThisMC_COMMENT = JSStringFormat(ThisMC_COMMENT)>
			<CFSET ThisMC_COMMENT = Replace(ThisMC_COMMENT, "\r\n", "<br>", "ALL")>
			MC_COMMENT = <CFQUERYPARAM VALUE="#ThisMC_COMMENT#" CFSQLType="CF_SQL_LONGVARCHAR">
			
			</cfif>
			
			WHERE CASE_REC_ID_SEQUENCE = #Form.CASE_REC_ID_SEQUENCE#
			
			</cfquery>
		
		</cfif>
		
		
		<!--- If LM Matter Number entered, but Matter Key field blank, look up Matter Key to validate Matter Number: --->
		
		
		<CFIF IsDefined("Form.LM_MATTER_NUMBER")>
		
			<CFQUERY NAME="Get_Matter_Key" DATASOURCE="contliab">
			
			select
			c.matter_key
			
			from
			lawmanager.matter c
			
			where
			c.matter_number = '#Form.LM_MATTER_NUMBER#'
			
			</cfquery>
		
		</CFIF>
		
		
		
		
		<CFQUERY NAME="CONTINGENT_LIAB_Update" DATASOURCE="contliab">
		
		UPDATE CONTINGENT_LIAB_REPORT
		
		SET
		
		<CFIF IsDefined("Form.ActionButton")>
		
			CASE_NAME = '#Form.CASE_NAME#',
			CASE_NUMBER = '#Form.CASE_NUMBER#',
			
			
			LM_MATTER_NUMBER = '#Form.LM_MATTER_NUMBER#',
			
			
			<CFIF IsDefined("Get_Matter_Key.RecordCount") AND Get_Matter_Key.RecordCount EQ 1>
				LM_MATTER_KEY = #Get_Matter_Key.matter_key#,
			<CFELSE>
				LM_MATTER_KEY = NULL,
			</cfif>
			
		
			CLAIM_CATEGORY = #Form.CLAIM_CATEGORY#,
		
		
			<CFIF Form.DATE_FILED NEQ "">
			
				<CFSET DateFiledFmt = DateFormat(Form.DATE_FILED, "mm/dd/yyyy")>
				DATE_FILED = to_date('#DateFiledFmt#', 'mm/dd/yyyy'),
				DATE_FILED_UNKNOWN = 0,
			
			<CFELSEIF IsDefined("Form.DATE_FILED_UNKNOWN")>
            
				DATE_FILED = NULL,
				DATE_FILED_UNKNOWN = #Form.DATE_FILED_UNKNOWN#,
			
			<CFELSE>
	
    			DATE_FILED_UNKNOWN = 0,
		
        	</cfif>
		
		
			<CFIF Form.AMOUNT_SOUGHT NEQ "">
            
				<CFSET ThisString = Form.AMOUNT_SOUGHT>
				<CFINCLUDE TEMPLATE="IsNumeric.validate.cfm">
				<CFSET AMOUNT_SOUGHT_Dollars = ValidatedString * OneMillion>

				AMOUNT_SOUGHT = #AMOUNT_SOUGHT_Dollars#,
				AMOUNT_SOUGHT_UNKNOWN = 0,
			
			<CFELSEIF IsDefined("Form.AMOUNT_SOUGHT_UNKNOWN")>
            
				AMOUNT_SOUGHT = NULL,
				AMOUNT_SOUGHT_UNKNOWN = #Form.AMOUNT_SOUGHT_UNKNOWN#,
			
			<CFELSE>
            
				AMOUNT_SOUGHT_UNKNOWN = 0,

			</cfif>
			
		
			<CFIF IsDefined("Form.AMOUNT_SOUGHT_UPPER")>
			
				<CFIF Form.AMOUNT_SOUGHT_UPPER NEQ "">
                
					<CFSET ThisString = Form.AMOUNT_SOUGHT_UPPER>
					<CFINCLUDE TEMPLATE="IsNumeric.validate.cfm">
					<CFSET AMOUNT_SOUGHT_UPPER_Dollars = ValidatedString * OneMillion>
		
        			AMOUNT_SOUGHT_UPPER = #AMOUNT_SOUGHT_UPPER_Dollars#,
				
				<CFELSE>
			
            		AMOUNT_SOUGHT_UPPER = NULL,
				
				</cfif>
			
			</cfif>
		
		
			<CFIF IsDefined("Form.ASSESSMENT_PROBABILITY")>
				ASSESSMENT_PROBABILITY = #Form.ASSESSMENT_PROBABILITY#,
			</cfif>
		
		
			<CFIF Form.ASSESSMENT_AMOUNT NEQ "">
            
				<CFSET ThisString = Form.ASSESSMENT_AMOUNT>
				<CFINCLUDE TEMPLATE="IsNumeric.validate.cfm">
				<CFSET ASSESSMENT_AMOUNT_Dollars = ValidatedString * OneMillion>
		
        		ASSESSMENT_AMOUNT = #ASSESSMENT_AMOUNT_Dollars#,
				ASSESSMENT_AMT_UNKNOWN = 0,
			
			<CFELSEIF IsDefined("Form.ASSESSMENT_AMOUNT_UNKNOWN")>

				ASSESSMENT_AMOUNT = NULL,
				ASSESSMENT_AMT_UNKNOWN = #Form.ASSESSMENT_AMOUNT_UNKNOWN#,
			
			<CFELSE>
            
				ASSESSMENT_AMT_UNKNOWN = 0,
	
    		</cfif>
		
		
			<CFIF IsDefined("Form.ASSESSMENT_AMT_HIGH_END")>
			
				<CFIF Form.ASSESSMENT_AMT_HIGH_END NEQ "">
				
					<CFSET ThisString = Form.ASSESSMENT_AMT_HIGH_END>
					<CFINCLUDE TEMPLATE="IsNumeric.validate.cfm">
	           		<CFSET ASSESSMENT_AMT_HIGH_END_Dollars = ValidatedString * OneMillion>
	
    				ASSESSMENT_AMT_HIGH_END = #ASSESSMENT_AMT_HIGH_END_Dollars#,
				
				<CFELSE>
				
					ASSESSMENT_AMT_HIGH_END = NULL,
				
				</cfif>
			
			</cfif>
		
		
		
			<CFIF IsDefined("Form.ASSESSMENT_AMOUNT_UPPER")>
			
				<CFIF Form.ASSESSMENT_AMOUNT_UPPER NEQ "">
				
					<CFSET ThisString = Form.ASSESSMENT_AMOUNT_UPPER>
					<CFINCLUDE TEMPLATE="IsNumeric.validate.cfm">
					<CFSET ASSESSMENT_AMOUNT_UPPER_Dollars = ValidatedString * OneMillion>
                    
					ASSESSMENT_AMOUNT_UPPER = #ASSESSMENT_AMOUNT_UPPER_Dollars#,
					
				<CFELSEIF IsDefined("Form.ASSESSMENT_AMT_MAX_UNKNOWN")>
                
					ASSESSMENT_AMOUNT_UPPER = NULL,
					ASSESSMENT_AMT_MAX_UNKNOWN = #Form.ASSESSMENT_AMT_MAX_UNKNOWN#,
				
				<CFELSE>
                
					ASSESSMENT_AMOUNT_UPPER = NULL,
					ASSESSMENT_AMT_MAX_UNKNOWN = 0,
				
				</cfif>
			
			</cfif>
		
		
			<CFIF IsDefined("Form.ASSESSMENT_AMT_UPPER_HIGH_END")>
			
				<CFIF Form.ASSESSMENT_AMT_UPPER_HIGH_END NEQ "">
				
					<CFSET ThisString = Form.ASSESSMENT_AMT_UPPER_HIGH_END>
					<CFINCLUDE TEMPLATE="IsNumeric.validate.cfm">
					<CFSET ASSESSMENT_AMT_UPPER_HIGH_END_Dollars = ValidatedString * OneMillion>
                
					ASSESSMENT_AMT_UPPER_HIGH_END = #ASSESSMENT_AMT_UPPER_HIGH_END_Dollars#,
				
				<CFELSE>
				
					ASSESSMENT_AMT_UPPER_HIGH_END = NULL,
				
				</cfif>
			
			</cfif>
		

<!---
			STATUS_CODE_SELECTED = '#Form.STATUS_CODE#',
--->



			<CFIF IsDefined("Form.STATUS_CODE_SELECTED_ALL")>
	
				STATUS_CODE_SELECTED = '#Form.STATUS_CODE_SELECTED_ALL#',

			<CFELSEIF IsDefined("Form.STATUS_CODE")>

				STATUS_CODE_SELECTED = '#Form.STATUS_CODE#',

			</CFIF>

		
		
			<CFIF IsDefined("Form.PAYOUT_AMOUNT")>
			
				<CFIF Form.PAYOUT_AMOUNT NEQ "">
				
					<CFSET ThisString = Form.PAYOUT_AMOUNT>
					<CFINCLUDE TEMPLATE="IsNumeric.validate.cfm">
					<CFSET PAYOUT_AMOUNT_Dollars = ValidatedString * OneMillion>
			
            		PAYOUT_AMOUNT = #PAYOUT_AMOUNT_Dollars#,
				
				<CFELSE>
				
					PAYOUT_AMOUNT = NULL,
				
				</cfif>
			
			
			<CFELSE>
			
				PAYOUT_AMOUNT = NULL,
			
			</cfif>
		
		
		
			<CFIF IsDefined("Form.PAYOUT_LT_100K")>
			
				<CFIF Form.PAYOUT_LT_100K NEQ "">
					PAYOUT_LT_100K = #Form.PAYOUT_LT_100K#,
				<CFELSE>
					PAYOUT_LT_100K = NULL,
				</cfif>
			
			<CFELSEIF IsDefined("Form.PAYOUT_NA")>
			
				<CFIF Form.PAYOUT_NA NEQ "">
					PAYOUT_LT_100K = #Form.PAYOUT_NA#,
				<CFELSE>
					PAYOUT_LT_100K = NULL,
				</cfif>
			
			<CFELSE>
			
				PAYOUT_LT_100K = NULL,
			
			</cfif>
		
		
		
			<CFIF IsDefined("Form.PAYOUT_DATE")>
			
				<CFIF Form.PAYOUT_DATE NEQ "">
				
					<CFSET PayoutDateFmt = DateFormat(Form.PAYOUT_DATE, "mm/dd/yyyy")>
			
            		PAYOUT_DATE = to_date('#PayoutDateFmt#', 'mm/dd/yyyy'),
					PAYOUT_DATE_NA = NULL,
				
				<CFELSE>
				
					PAYOUT_DATE = NULL,
				
					<CFIF IsDefined("Form.PAYOUT_DATE_NA")>
						PAYOUT_DATE_NA = #Form.PAYOUT_DATE_NA#,
					<CFELSE>
						PAYOUT_DATE_NA = NULL,
				    </cfif>
				
				</cfif>
			
			
			<CFELSE>
			
				PAYOUT_DATE = NULL,
				PAYOUT_DATE_NA = NULL,
			
			</cfif>
			
		
			<CFIF IsDefined("Form.SHORT_TERM_LIABILITY")>
				SHORT_TERM_LIABILITY = #Form.SHORT_TERM_LIABILITY#,
			</cfif>
		
		
			<CFIF IsDefined("Form.FIELD_GRIEVANCE_FLAG")>
				FIELD_GRIEVANCE_FLAG = '#Form.FIELD_GRIEVANCE_FLAG#',
			<CFELSE>
				FIELD_GRIEVANCE_FLAG = NULL,
			</cfif>
			
			
			<CFIF IsDefined("Form.NATL_GATS_NUMBER")>
				NATL_GATS_NUMBER = '#Form.NATL_GATS_NUMBER#',
			<CFELSE>
				NATL_GATS_NUMBER = NULL,
			</cfif>
		

			<CFIF IsDefined("Form.DIST_PERF_CLUSTER_CODE")>


				<CFIF Form.DIST_PERF_CLUSTER_CODE NEQ "0">

			
					<CFSET Slashes_DIST_PERF_CLUSTER_CODE_Index = Find(" // ", Form.DIST_PERF_CLUSTER_CODE)>
                
                
					<CFIF Slashes_DIST_PERF_CLUSTER_CODE_Index GT 0>
	                
	                                
						<CFSET Slashes_Next_Word = Slashes_DIST_PERF_CLUSTER_CODE_Index + 4>
					
						<CFSET This_DIST_PERF_CLUSTER_CODE = Left(Form.DIST_PERF_CLUSTER_CODE, Slashes_DIST_PERF_CLUSTER_CODE_Index - 1)>
					
						DIST_PERF_CLUSTER_CODE = '#This_DIST_PERF_CLUSTER_CODE#',
					
						<CFIF This_DIST_PERF_CLUSTER_CODE NEQ "Multiple">
					
							<CFSET Vert_Bars_DIST_PERF_CLUSTER_CODE_Index = Find(" || ", Form.DIST_PERF_CLUSTER_CODE)>
							<CFSET Vert_Bars_Next_Word = Vert_Bars_DIST_PERF_CLUSTER_CODE_Index + 4>
					
							<CFSET This_DIST_PERF_CLUSTER_NAME = Mid(Form.DIST_PERF_CLUSTER_CODE, Slashes_Next_Word, Vert_Bars_DIST_PERF_CLUSTER_CODE_Index - (Slashes_Next_Word))>
					
							DIST_PERF_CLUSTER_NAME = '#This_DIST_PERF_CLUSTER_NAME#',
					
							<CFSET Ampersands_DIST_PERF_CLUSTER_CODE_Index = Find(" && ", Form.DIST_PERF_CLUSTER_CODE)>
							<CFSET Ampersands_Next_Word = Ampersands_DIST_PERF_CLUSTER_CODE_Index + 4>
					
							<CFSET This_DIST_AREA_CODE = Mid(Form.DIST_PERF_CLUSTER_CODE, Vert_Bars_Next_Word, Ampersands_DIST_PERF_CLUSTER_CODE_Index - (Vert_Bars_Next_Word))>
					
							<CFSET This_DIST_AREA_NAME = Right(Form.DIST_PERF_CLUSTER_CODE, Len(Form.DIST_PERF_CLUSTER_CODE) - (Ampersands_Next_Word - 1))>

<!---					
							AREA_CODE = '#This_DIST_AREA_CODE#',
							AREA_NAME = '#This_DIST_AREA_NAME#',
--->
					
						<CFELSE>
					
							<CFSET This_DIST_PERF_CLUSTER_NAME = Right(Form.DIST_PERF_CLUSTER_CODE, Len(Form.DIST_PERF_CLUSTER_CODE) - (Slashes_Next_Word - 1))>
					
							DIST_PERF_CLUSTER_NAME = '#This_DIST_PERF_CLUSTER_NAME#',
			
<!---            		
							AREA_CODE = NULL,
							AREA_NAME = NULL,
--->
					
						</cfif>
	
	
					</CFIF>                



				<CFELSE>


					DIST_PERF_CLUSTER_CODE = NULL,

					DIST_PERF_CLUSTER_NAME = NULL,


				</CFIF>

			
			</CFIF>


	
			<CFIF IsDefined("Form.DIVISION_CODE")>
			
	
				<CFIF Form.DIVISION_CODE NEQ "0">


					<CFIF UCase(Form.DIVISION_CODE) CONTAINS "MULTIPLE">
                    
						DIVISION_CODE = 'MULTIPLE Divisions',
                    
						DIVISION_NAME = 'MULTIPLE Divisions',

					<CFELSE>
                    
						DIVISION_CODE = '#Form.DIVISION_CODE#',

						DIVISION_NAME = '#Form.DIVISION_CODE#',

					</CFIF>
                                                            

				<CFELSE>

					DIVISION_CODE = NULL,

					DIVISION_NAME = NULL,


				</CFIF>


			</CFIF>
            
            

			<CFIF IsDefined("Form.HQ_AREA_NAME")>
			
			
            	<CFIF Form.HQ_AREA_NAME NEQ "0">


					<CFSET Slashes_HQ_AREA_NAME_Index = Find(" // ", Form.HQ_AREA_NAME)>
			
					<CFSET This_HQ_AREA_CODE = Left(Form.HQ_AREA_NAME, Slashes_HQ_AREA_NAME_Index - 1)>
			
					<CFSET This_HQ_AREA_NAME = Right(Form.HQ_AREA_NAME, Len(Form.HQ_AREA_NAME) - (Slashes_HQ_AREA_NAME_Index + 3))>
			
					AREA_CODE = '#This_HQ_AREA_CODE#',
					AREA_NAME = '#This_HQ_AREA_NAME#',


				<CFELSE>
                
                
					AREA_CODE = NULL,
					AREA_NAME = NULL,

                
                </CFIF>

			
			</cfif>
		
		
<!---		
			<CFIF IsDefined("Form.Unions_Selected")
			AND
			Form.Unions_Selected NEQ "">
			
				UNIONS_SELECTED = '#Form.Unions_Selected#',
			
			<CFELSE>
			
				UNIONS_SELECTED = NULL,
			
			</CFIF>

--->



			<CFIF IsDefined("Form.UNIONS_SELECTED_ALL")
			AND
			Form.UNIONS_SELECTED_ALL NEQ "">
	
				UNIONS_SELECTED = '#Form.UNIONS_SELECTED_ALL#',

<!---
			<CFELSEIF IsDefined("Form.UNIONS_SELECTED")
			AND
			Form.UNIONS_SELECTED NEQ "">

				UNIONS_SELECTED = '#Form.UNIONS_SELECTED#',
--->

			<CFELSE>
			
				UNIONS_SELECTED = NULL,

			</CFIF>









		
		
		
			<CFIF IsDefined("Form.COUNSEL_LAW_DEPT")>
			
				COUNSEL_LAW_DEPT = #Form.COUNSEL_LAW_DEPT#,
			
			</cfif>
			
			
			<CFIF IsDefined("Form.COCOUNSEL_LAW_DEPT")>
			
				COCOUNSEL_LAW_DEPT = #Form.COCOUNSEL_LAW_DEPT#,
			
			</cfif>
			
			
			<CFIF IsDefined("Form.COUNSEL_OTHER")>
			
				COUNSEL_OTHER = '#Form.COUNSEL_OTHER#',
			
			</cfif>
			
			
			<CFIF IsDefined("Form.LAW_DEPT_OFFICE")>
			
				LAW_DEPT_OFFICE = #Form.LAW_DEPT_OFFICE#,
			
			</cfif>
			
			
			<CFIF IsDefined("Form.ALT_LAW_DEPT_OFFICE")>
			
				ALT_LAW_DEPT_OFFICE = #Form.ALT_LAW_DEPT_OFFICE#,
			
			</cfif>
			
			
			
			
			
			<CFIF Form.ActionButton EQ "Remove This Case">

				<CFSET ThisCaseType = Form.CASE_TYPE_Choice + 10>

				CASE_TYPE = #ThisCaseType#,
		
			<CFELSE>
			
			<!--- Set CASE_TYPE to 11 or 12 where selected STATUS_CODE is for final disposition, even when user did not click "Remove" button: --->
			
				<CFSET STATUS_CODE_Found = "">
			
				<CFLOOP INDEX="Form_STATUS_CODE_Index" FROM="11" TO="15">
			
<!---            
					<CFIF ListFind(Form.STATUS_CODE, Form_STATUS_CODE_Index) GT 0>
			           	<CFSET STATUS_CODE_Found = "yes">
						<CFBREAK>
					</CFIF>
--->



					<CFIF IsDefined("Form.STATUS_CODE_SELECTED_ALL")>
	
						<CFIF ListFind(Form.STATUS_CODE_SELECTED_ALL, Form_STATUS_CODE_Index) GT 0>
				           	<CFSET STATUS_CODE_Found = "yes">
							<CFBREAK>
						</CFIF>
		
					<CFELSEIF IsDefined("Form.STATUS_CODE")>

						<CFIF ListFind(Form.STATUS_CODE, Form_STATUS_CODE_Index) GT 0>
				           	<CFSET STATUS_CODE_Found = "yes">
							<CFBREAK>
						</CFIF>
        
		        	</CFIF>


				</CFLOOP>

			
				<CFIF STATUS_CODE_Found EQ "yes">
					<CFSET ThisCaseType = Form.CASE_TYPE_Choice + 10>
					CASE_TYPE = #ThisCaseType#,
				<CFELSE>
					CASE_TYPE = #Form.CASE_TYPE_Choice#,
				</cfif>
			
			</cfif>
		
        
			<CFIF Form.ActionButton EQ "Lock This Record">
				FINALIZED_FLAG = 1,
			<CFELSEIF Form.ActionButton EQ "UNLock This Record">
				FINALIZED_FLAG = 0,
			</cfif>
			
            			
			<CFIF Form.ActionButton EQ "Undo Approvals">
				CONCUR_MC = NULL,
				CONCUR_MC_DATE = NULL,
				CONCUR_MC_USER_ID = NULL,
				CONCUR_ALT = NULL,
				CONCUR_ALT_DATE = NULL,
				CONCUR_ALT_USER_ID = NULL,
			</cfif>
			
<!--- Close <CFIF IsDefined("Form.ActionButton")> --->	
		</cfif>
		
		
		LAST_UPDATE_USER_ID = '#RespondingUser_Id#',
		
		
		DATE_LAST_UPDATE = SYSDATE,
		
		
		
		
		<!---
		Rearranged order of fields to put LONG last, to avoid error ORA-24816
		--->
		
		<CFSET ThisCOMMENT_GENERAL = Trim(Form.COMMENT_GENERAL)>
		
		<CFSET Orig_String = JSStringFormat(ThisCOMMENT_GENERAL)>
		<CFINCLUDE TEMPLATE="ReplaceSlashQuote.cfm">
		<CFSET ThisCOMMENT_GENERAL = Result_String>
		
		COMMENT_GENERAL = <CFQUERYPARAM VALUE="#ThisCOMMENT_GENERAL#" CFSQLType="CF_SQL_LONGVARCHAR">,
		
		
		<CFSET ThisFACTS_POSITIONS_LONG = Trim(Form.FACTS_POSITIONS_LONG)>
		
		<CFSET Orig_String = JSStringFormat(ThisFACTS_POSITIONS_LONG)>
		<CFINCLUDE TEMPLATE="ReplaceSlashQuote.cfm">
		<CFSET ThisFACTS_POSITIONS_LONG = Result_String>
		
		FACTS_POSITIONS_LONG = <CFQUERYPARAM VALUE="#ThisFACTS_POSITIONS_LONG#" CFSQLType="CF_SQL_LONGVARCHAR">
		
		
		
		WHERE PRIMARYKEY = #ThisRecID#
		
		</cfquery>
		
		<!---
		Close <CFIF IsDefined("Form.ActionButton") AND Form.ActionButton EQ "Update Checklist">:
		--->
	
	</cfif>
	
	
	<!--- Close <CFIF IsDefined("LockFlag") AND LockFlag EQ "Lock">:
	--->
</cfif>


<CFIF NOT 
(
IsDefined("Form.ActionButton") 
AND 
Form.ActionButton EQ "Delete This Record"
)>


<!---
For approved case, e-mail notice to MC, other manager(s) if ASSESSMENT_AMOUNT [formerly ASSESSMENT_AMOUNT_UPPER] goes above or below $5 million:
--->


	<CFIF IsDefined("Form.ASSESSMENT_AMOUNT") 
	AND 
	Form.ASSESSMENT_AMOUNT NEQ "" 
	AND 
	IsDefined("Form.ASSESSMENT_AMOUNT_Orig") 
	AND 
	Form.ASSESSMENT_AMOUNT_Orig NEQ "">
	
		<CFSET ThisString = Form.ASSESSMENT_AMOUNT_Orig>
		<CFINCLUDE TEMPLATE="IsNumeric.validate.cfm">
		<CFSET ASSESSMENT_AMOUNT_Orig_Dollars = ValidatedString * OneMillion>
		
		<CFIF ASSESSMENT_AMOUNT_Orig_Dollars GE TenMillion 
		AND 
		ASSESSMENT_AMOUNT_Dollars LT TenMillion>
		
			<CFSET ASSESSMENT_AMOUNT_Change = "Decrease">
			<CFSET ASSESSMENT_AMOUNT_Change_Phrase = "decreased below $10 million">
		
		<CFELSEIF ASSESSMENT_AMOUNT_Orig_Dollars LT TenMillion 
		AND 
		ASSESSMENT_AMOUNT_Dollars GE TenMillion>
		
			<CFSET ASSESSMENT_AMOUNT_Change = "Increase">
		
		    <CFIF ASSESSMENT_AMOUNT_Dollars EQ TenMillion>
				<CFSET ASSESSMENT_AMOUNT_Change_Phrase = "increased to $10 million">
		    <CFELSE>
		    	<CFSET ASSESSMENT_AMOUNT_Change_Phrase = "increased above $10 million">
			</CFIF>
		
		<CFELSE>
		
			<CFSET ASSESSMENT_AMOUNT_Change = "">
			<CFSET ASSESSMENT_AMOUNT_Change_Phrase = "">
		
		</cfif>
		
		
		<CFIF IsDefined("ASSESSMENT_AMOUNT_Change") 
		AND 
		ASSESSMENT_AMOUNT_Change NEQ "">
		
		
			<CFQUERY NAME="Check_MC_APPR_FLAG" DATASOURCE="contliab">
		
			SELECT MC_APPR_FLAG
			FROM CONTINGENT_LIAB_C_E_CHECKLIST
		
			WHERE CASE_REC_ID_SEQUENCE = #Form.CASE_REC_ID_SEQUENCE#
			AND MC_APPR_FLAG != 0
		
			</cfquery>
		
			<CFIF Check_MC_APPR_FLAG.RecordCount GT 0>
		        <CFINCLUDE TEMPLATE="EditRecord.cfmail.cfm">
			</CFIF>
		
		
		</cfif>
		
	
	<!--- Close <CFIF IsDefined("Form.ASSESSMENT_AMOUNT") AND Form.ASSESSMENT_AMOUNT NEQ "" AND IsDefined("Form.ASSESSMENT_AMOUNT_Orig") AND Form.ASSESSMENT_AMOUNT_Orig NEQ ""> --->
	</cfif>
	
	
	
	<CFIF IsDefined("Form.RecordDisplay_Parm") AND Form.RecordDisplay_Parm EQ "Single"
	AND
	IsDefined("Form.ThisReportDate_Parm") AND Form.ThisReportDate_Parm NEQ ""
	AND
	IsDefined("Form.PrevReportDate_Parm") AND Form.PrevReportDate_Parm NEQ "">
	
		<CFSET ReturnFormAction_ThisReportDate_Parm = Form.ThisReportDate_Parm>
		<CFSET ReturnFormAction_PrevReportDate_Parm = Form.PrevReportDate_Parm>
	
	<CFELSEIF IsDefined("RecordDisplay_Parm")
	AND
	IsDefined("ThisReportDate_Parm")
	AND
	IsDefined("PrevReportDate_Parm")>
	
		<CFSET ReturnFormAction_ThisReportDate_Parm = ThisReportDate_Parm>
		<CFSET ReturnFormAction_PrevReportDate_Parm = PrevReportDate_Parm>
		
	</cfif>


<!--- Close <CFIF NOT (IsDefined("Form.ActionButton") AND Form.ActionButton EQ "Delete This Record")> --->
</cfif>


<CFIF (IsDefined("Form.SelectedLDOffice") AND Form.SelectedLDOffice NEQ "")>

	<CFSET SelectedLDOffice_Parm = "?SelectedLDOffice=" & Form.SelectedLDOffice>

<CFELSEIF IsDefined("SelectedLDOffice") AND SelectedLDOffice NEQ "">

	<CFSET SelectedLDOffice_Parm = "?SelectedLDOffice=" & SelectedLDOffice>

<CFELSE>

	<CFSET SelectedLDOffice_Parm = "">

</cfif>


<CFIF IsDefined("Form.ActionButton") AND Form.ActionButton EQ "Delete This Record">

	<CFOUTPUT>
	<form name="ReturnForm" METHOD="POST" ACTION="Report.cfm#SelectedLDOffice_Parm#">
	</form>
	</cfoutput>


<CFELSEIF IsDefined("ReturnFormAction_ThisReportDate_Parm") AND IsDefined("ReturnFormAction_PrevReportDate_Parm")>


	<CFIF IsDefined("TextHighlight")
	AND
	TextHighlight EQ "Disabled">

		<CFSET GetSingle_TextHighlightParm = "&TextHighlight=Disabled">

	<CFELSE>

		<CFSET GetSingle_TextHighlightParm = "">

	</CFIF>


	<CFOUTPUT>
	<form name="ReturnForm" METHOD="POST" ACTION="Get_Single_Record.cfm?PRIMARYKEY=#ThisRecID#&ThisReportDate_Parm=#ReturnFormAction_ThisReportDate_Parm#&PrevReportDate_Parm=#ReturnFormAction_PrevReportDate_Parm##GetSingle_TextHighlightParm#">
	</form>
	</cfoutput>

<CFELSE>

	<CFOUTPUT>
	<form name="ReturnForm" METHOD="POST" ACTION="Report.cfm#SelectedLDOffice_Parm####ThisRecID#">
	</form>
	</cfoutput>

</CFIF>



<!---

<form name="ReturnForm" METHOD="POST"


<CFIF IsDefined("Form.RecordDisplay_Parm") AND Form.RecordDisplay_Parm EQ "Single"
AND
IsDefined("Form.ThisReportDate_Parm") AND Form.ThisReportDate_Parm NEQ ""
AND
IsDefined("Form.PrevReportDate_Parm") AND Form.PrevReportDate_Parm NEQ "">

ACTION="Get_Single_Record.cfm?PRIMARYKEY=#ThisRecID#&ThisReportDate_Parm=#Form.ThisReportDate_Parm#&PrevReportDate_Parm=#Form.PrevReportDate_Parm#">

<CFELSEIF IsDefined("RecordDisplay_Parm")
AND
IsDefined("ThisReportDate_Parm")
AND
IsDefined("PrevReportDate_Parm")>

ACTION="Get_Single_Record.cfm?PRIMARYKEY=#ThisRecID#&ThisReportDate_Parm=#ThisReportDate_Parm#&PrevReportDate_Parm=#PrevReportDate_Parm#">

<CFELSE>

ACTION="Report.cfm#SelectedLDOffice_Parm####ThisRecID#">

</cfif>

</form>

</cfoutput>


--->




<!---
AlertToLine set in EditRecord.cfmail.cfm
--->

<script language="javascript">

<CFIF IsDefined("ASSESSMENT_AMOUNT_UPPER_Change") AND ASSESSMENT_AMOUNT_UPPER_Change NEQ "">

<CFOUTPUT>
alert("An e-mail notice has been sent to #AlertToLine# that the Assessment Amount High End has been #ASSESSMENT_AMOUNT_UPPER_Change_Phrase#.");
</cfoutput>

</cfif>


ReturnForm.submit();


</script>


</body>
</html>



