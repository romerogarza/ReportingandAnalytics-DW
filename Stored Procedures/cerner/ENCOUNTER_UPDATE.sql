USE [ENTERPRISE]
GO
/****** Object:  StoredProcedure [cerner].[ENCOUNTER_UPDATE]    Script Date: 11/29/2021 5:20:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [cerner].[ENCOUNTER_UPDATE] AS

BEGIN
	CREATE TABLE #encounter_update (
		ENCNTR_ID INT
		,PERSON_ID INT
		,UPDT_CNT INT
		,UPDT_DT_TM DATETIME2
		,UPDT_ID INT
		,UPDT_TASK INT
		,UPDT_APPLCTX INT
		,ACTIVE_IND INT
		,ACTIVE_STATUS_CD INT
		,ACTIVE_STATUS_PRSNL_ID INT
		,CREATE_PRSNL_ID INT
		,ENCNTR_CLASS_CD INT
		,ENCNTR_TYPE_CD INT
		,ENCNTR_TYPE_CLASS_CD INT
		,ENCNTR_STATUS_CD INT
		,PRE_REG_PRSNL_ID INT
		,REG_PRSNL_ID INT
		,ADMIT_TYPE_CD INT
		,ADMIT_SRC_CD INT
		,ADMIT_MODE_CD INT
		,ADMIT_WITH_MEDICATION_CD INT
		,REFERRING_COMMENT VARCHAR(100)
		,DISCH_DISPOSITION_CD INT
		,DISCH_TO_LOCTN_CD INT
		,PREADMIT_NBR VARCHAR(100)
		,PREADMIT_TESTING_CD INT
		,READMIT_CD INT
		,ACCOMMODATION_CD INT
		,ACCOMMODATION_REQUEST_CD INT
		,ALT_RESULT_DEST_CD INT
		,AMBULATORY_COND_CD INT
		,COURTESY_CD INT
		,DIET_TYPE_CD INT
		,ISOLATION_CD INT
		,MED_SERVICE_CD INT
		,RESULT_DEST_CD INT
		,CONFID_LEVEL_CD INT
		,VIP_CD INT
		,NAME_LAST_KEY VARCHAR(200)
		,NAME_FIRST_KEY VARCHAR(200)
		,NAME_FULL_FORMATTED VARCHAR(200)
		,NAME_LAST VARCHAR(200)
		,NAME_FIRST VARCHAR(200)
		,NAME_PHONETIC VARCHAR(200)
		,SEX_CD INT
		,BIRTH_DT_CD INT
		,SPECIES_CD INT
		,DATA_STATUS_CD INT
		,DATA_STATUS_PRSNL_ID INT
		,CONTRIBUTOR_SYSTEM_CD INT
		,LOCATION_CD INT
		,LOC_FACILITY_CD INT
		,LOC_BUILDING_CD INT
		,LOC_NURSE_UNIT_CD INT
		,LOC_ROOM_CD INT
		,LOC_BED_CD INT
		,GUARANTOR_TYPE_CD INT
		,LOC_TEMP_CD INT
		,ORGANIZATION_ID INT
		,REASON_FOR_VISIT VARCHAR(255)
		,ENCNTR_FINANCIAL_ID INT
		,NAME_FIRST_SYNONYM_ID INT
		,FINANCIAL_CLASS_CD INT
		,BBD_PROCEDURE_CD INT
		,INFO_GIVEN_BY VARCHAR(100)
		,SAFEKEEPING_CD INT
		,TRAUMA_CD INT
		,TRIAGE_CD INT
		,VISITOR_STATUS_CD INT
		,VALUABLES_CD INT
		,SECURITY_ACCESS_CD INT
		,REFER_FACILITY_CD INT
		,ACCOMP_BY_CD INT
		,ACCOMMODATION_REASON_CD INT
		,PA_CURRENT_STATUS_CD INT
		,PARENT_RET_CRITERIA_ID INT
		,SERVICE_CATEGORY_CD INT
		,CONTRACT_STATUS_CD INT
		,EST_LENGTH_OF_STAY INT
		,ALT_LVL_CARE_CD INT
		,PROGRAM_SERVICE_CD INT
		,SPECIALTY_UNIT_CD INT
		,MENTAL_HEALTH_CD INT
		,REGION_CD INT
		,SITTER_REQUIRED_CD INT
		,ALC_REASON_CD INT
		,PLACEMENT_AUTH_PRSNL_ID INT
		,PATIENT_CLASSIFICATION_CD INT
		,MENTAL_CATEGORY_CD INT
		,PSYCHIATRIC_STATUS_CD INT
		,ZERO_BALANCE_DT_TM DATETIME2
		,ACTIVE_STATUS_DT_TM DATETIME2
		,ALC_DECOMP_DT_TM DATETIME2
		,ALT_LVL_CARE_DT_TM DATETIME2
		,ARCHIVE_DT_TM_ACT DATETIME2
		,ARCHIVE_DT_TM_EST DATETIME2
		,ASSIGN_TO_LOC_DT_TM DATETIME2
		,BEG_EFFECTIVE_DT_TM DATETIME2
		,CREATE_DT_TM DATETIME2
		,DEPART_DT_TM DATETIME2
		,END_EFFECTIVE_DT_TM DATETIME2
		,EST_ARRIVE_DT_TM DATETIME2
		,MENTAL_HEALTH_DT_TM DATETIME2
		,PRE_REG_DT_TM DATETIME2
		,PURGE_DT_TM_ACT DATETIME2
		,REFERRAL_RCVD_DT_TM DATETIME2
		,TRIAGE_DT_TM DATETIME2
		,ARRIVE_DT_TM DATETIME2
		,BIRTH_DT_TM DATETIME2
		,CHART_COMPLETE_DT_TM DATETIME2
		,DATA_STATUS_DT_TM DATETIME2
		,DISCH_DT_TM DATETIME2
		,DOC_RCVD_DT_TM DATETIME2
		,ENCNTR_COMPLETE_DT_TM DATETIME2
		,EST_DEPART_DT_TM DATETIME2
		,INPATIENT_ADMIT_DT_TM DATETIME2
		,PA_CURRENT_STATUS_DT_TM DATETIME2
		,PURGE_DT_TM_EST DATETIME2
		,REG_DT_TM DATETIME2
		,RESULT_ACCUMULATION_DT_TM DATETIME2
		,TRAUMA_DT_TM DATETIME2
		,PREGNANCY_STATUS_CD INT
		,INITIAL_CONTACT_DT_TM DATETIME2
		,LAST_MENSTRUAL_PERIOD_DT_TM DATETIME2
		,ONSET_DT_TM DATETIME2
		,EXPECTED_DELIVERY_DT_TM DATETIME2
		,LEVEL_OF_SERVICE_CD INT
		,ABN_STATUS_CD INT
		,PLACE_OF_SVC_ORG_ID INT
		,PLACE_OF_SVC_TYPE_CD INT
		,PLACE_OF_SVC_ADMIT_DT_TM DATETIME2
		,ENTERPRISE_UPDATE_DT_TM DATETIME2
	)

	DECLARE @StartDate datetime2
	DECLARE @EndDate datetime2
	SET @StartDate = dateadd(day,-2,convert(date,getdate()))
	SET @EndDate = convert(date,getdate())

	INSERT INTO #encounter_update
	EXEC('
	select 
		ENCNTR_ID
		,PERSON_ID
		,UPDT_CNT
		,UPDT_DT_TM
		,UPDT_ID
		,UPDT_TASK
		,UPDT_APPLCTX
		,ACTIVE_IND
		,ACTIVE_STATUS_CD
		,ACTIVE_STATUS_PRSNL_ID
		,CREATE_PRSNL_ID
		,ENCNTR_CLASS_CD
		,ENCNTR_TYPE_CD
		,ENCNTR_TYPE_CLASS_CD
		,ENCNTR_STATUS_CD
		,PRE_REG_PRSNL_ID
		,REG_PRSNL_ID
		,ADMIT_TYPE_CD
		,ADMIT_SRC_CD
		,ADMIT_MODE_CD
		,ADMIT_WITH_MEDICATION_CD
		,REFERRING_COMMENT
		,DISCH_DISPOSITION_CD
		,DISCH_TO_LOCTN_CD
		,PREADMIT_NBR
		,PREADMIT_TESTING_CD
		,READMIT_CD
		,ACCOMMODATION_CD
		,ACCOMMODATION_REQUEST_CD
		,ALT_RESULT_DEST_CD
		,AMBULATORY_COND_CD
		,COURTESY_CD
		,DIET_TYPE_CD
		,ISOLATION_CD
		,MED_SERVICE_CD
		,RESULT_DEST_CD
		,CONFID_LEVEL_CD
		,VIP_CD
		,NAME_LAST_KEY
		,NAME_FIRST_KEY
		,NAME_FULL_FORMATTED
		,NAME_LAST
		,NAME_FIRST
		,NAME_PHONETIC
		,SEX_CD
		,BIRTH_DT_CD
		,SPECIES_CD
		,DATA_STATUS_CD
		,DATA_STATUS_PRSNL_ID
		,CONTRIBUTOR_SYSTEM_CD
		,LOCATION_CD
		,LOC_FACILITY_CD
		,LOC_BUILDING_CD
		,LOC_NURSE_UNIT_CD
		,LOC_ROOM_CD
		,LOC_BED_CD
		,GUARANTOR_TYPE_CD
		,LOC_TEMP_CD
		,ORGANIZATION_ID
		,REASON_FOR_VISIT
		,ENCNTR_FINANCIAL_ID
		,NAME_FIRST_SYNONYM_ID
		,FINANCIAL_CLASS_CD
		,BBD_PROCEDURE_CD
		,INFO_GIVEN_BY
		,SAFEKEEPING_CD
		,TRAUMA_CD
		,TRIAGE_CD
		,VISITOR_STATUS_CD
		,VALUABLES_CD
		,SECURITY_ACCESS_CD
		,REFER_FACILITY_CD
		,ACCOMP_BY_CD
		,ACCOMMODATION_REASON_CD
		,PA_CURRENT_STATUS_CD
		,PARENT_RET_CRITERIA_ID
		,SERVICE_CATEGORY_CD
		,CONTRACT_STATUS_CD
		,EST_LENGTH_OF_STAY
		,ALT_LVL_CARE_CD
		,PROGRAM_SERVICE_CD
		,SPECIALTY_UNIT_CD
		,MENTAL_HEALTH_CD
		,REGION_CD
		,SITTER_REQUIRED_CD
		,ALC_REASON_CD
		,PLACEMENT_AUTH_PRSNL_ID
		,PATIENT_CLASSIFICATION_CD
		,MENTAL_CATEGORY_CD
		,PSYCHIATRIC_STATUS_CD
		,ZERO_BALANCE_DT_TM
		,ACTIVE_STATUS_DT_TM
		,ALC_DECOMP_DT_TM
		,ALT_LVL_CARE_DT_TM
		,ARCHIVE_DT_TM_ACT
		,ARCHIVE_DT_TM_EST
		,ASSIGN_TO_LOC_DT_TM
		,BEG_EFFECTIVE_DT_TM
		,CREATE_DT_TM
		,DEPART_DT_TM
		,END_EFFECTIVE_DT_TM
		,EST_ARRIVE_DT_TM
		,MENTAL_HEALTH_DT_TM
		,PRE_REG_DT_TM
		,PURGE_DT_TM_ACT
		,REFERRAL_RCVD_DT_TM
		,TRIAGE_DT_TM
		,ARRIVE_DT_TM
		,BIRTH_DT_TM
		,CHART_COMPLETE_DT_TM
		,DATA_STATUS_DT_TM
		,DISCH_DT_TM
		,DOC_RCVD_DT_TM
		,ENCNTR_COMPLETE_DT_TM
		,EST_DEPART_DT_TM
		,INPATIENT_ADMIT_DT_TM
		,PA_CURRENT_STATUS_DT_TM
		,PURGE_DT_TM_EST
		,REG_DT_TM
		,RESULT_ACCUMULATION_DT_TM
		,TRAUMA_DT_TM
		,PREGNANCY_STATUS_CD
		,INITIAL_CONTACT_DT_TM
		,LAST_MENSTRUAL_PERIOD_DT_TM
		,ONSET_DT_TM
		,EXPECTED_DELIVERY_DT_TM
		,LEVEL_OF_SERVICE_CD
		,ABN_STATUS_CD
		,PLACE_OF_SVC_ORG_ID
		,PLACE_OF_SVC_TYPE_CD
		,PLACE_OF_SVC_ADMIT_DT_TM
		,sysdate as ENTERPRISE_UPDATE_DT_TM
	from 
		encounter
	where
		(create_dt_tm >= ? and create_dt_tm < ?)
		OR (updt_dt_tm >= ? and updt_dt_tm < ?)
	', @StartDate, @EndDate, @StartDate, @EndDate) AT [CERNERPROD]
END

BEGIN
	CREATE TABLE #encounter_update_filtered (
		ENCNTR_ID INT
		,PERSON_ID INT
		,UPDT_CNT INT
		,UPDT_DT_TM DATETIME2
		,UPDT_ID INT
		,UPDT_TASK INT
		,UPDT_APPLCTX INT
		,ACTIVE_IND INT
		,ACTIVE_STATUS_CD INT
		,ACTIVE_STATUS_PRSNL_ID INT
		,CREATE_PRSNL_ID INT
		,ENCNTR_CLASS_CD INT
		,ENCNTR_TYPE_CD INT
		,ENCNTR_TYPE_CLASS_CD INT
		,ENCNTR_STATUS_CD INT
		,PRE_REG_PRSNL_ID INT
		,REG_PRSNL_ID INT
		,ADMIT_TYPE_CD INT
		,ADMIT_SRC_CD INT
		,ADMIT_MODE_CD INT
		,ADMIT_WITH_MEDICATION_CD INT
		,REFERRING_COMMENT VARCHAR(100)
		,DISCH_DISPOSITION_CD INT
		,DISCH_TO_LOCTN_CD INT
		,PREADMIT_NBR VARCHAR(100)
		,PREADMIT_TESTING_CD INT
		,READMIT_CD INT
		,ACCOMMODATION_CD INT
		,ACCOMMODATION_REQUEST_CD INT
		,ALT_RESULT_DEST_CD INT
		,AMBULATORY_COND_CD INT
		,COURTESY_CD INT
		,DIET_TYPE_CD INT
		,ISOLATION_CD INT
		,MED_SERVICE_CD INT
		,RESULT_DEST_CD INT
		,CONFID_LEVEL_CD INT
		,VIP_CD INT
		,NAME_LAST_KEY VARCHAR(200)
		,NAME_FIRST_KEY VARCHAR(200)
		,NAME_FULL_FORMATTED VARCHAR(200)
		,NAME_LAST VARCHAR(200)
		,NAME_FIRST VARCHAR(200)
		,NAME_PHONETIC VARCHAR(200)
		,SEX_CD INT
		,BIRTH_DT_CD INT
		,SPECIES_CD INT
		,DATA_STATUS_CD INT
		,DATA_STATUS_PRSNL_ID INT
		,CONTRIBUTOR_SYSTEM_CD INT
		,LOCATION_CD INT
		,LOC_FACILITY_CD INT
		,LOC_BUILDING_CD INT
		,LOC_NURSE_UNIT_CD INT
		,LOC_ROOM_CD INT
		,LOC_BED_CD INT
		,GUARANTOR_TYPE_CD INT
		,LOC_TEMP_CD INT
		,ORGANIZATION_ID INT
		,REASON_FOR_VISIT VARCHAR(255)
		,ENCNTR_FINANCIAL_ID INT
		,NAME_FIRST_SYNONYM_ID INT
		,FINANCIAL_CLASS_CD INT
		,BBD_PROCEDURE_CD INT
		,INFO_GIVEN_BY VARCHAR(100)
		,SAFEKEEPING_CD INT
		,TRAUMA_CD INT
		,TRIAGE_CD INT
		,VISITOR_STATUS_CD INT
		,VALUABLES_CD INT
		,SECURITY_ACCESS_CD INT
		,REFER_FACILITY_CD INT
		,ACCOMP_BY_CD INT
		,ACCOMMODATION_REASON_CD INT
		,PA_CURRENT_STATUS_CD INT
		,PARENT_RET_CRITERIA_ID INT
		,SERVICE_CATEGORY_CD INT
		,CONTRACT_STATUS_CD INT
		,EST_LENGTH_OF_STAY INT
		,ALT_LVL_CARE_CD INT
		,PROGRAM_SERVICE_CD INT
		,SPECIALTY_UNIT_CD INT
		,MENTAL_HEALTH_CD INT
		,REGION_CD INT
		,SITTER_REQUIRED_CD INT
		,ALC_REASON_CD INT
		,PLACEMENT_AUTH_PRSNL_ID INT
		,PATIENT_CLASSIFICATION_CD INT
		,MENTAL_CATEGORY_CD INT
		,PSYCHIATRIC_STATUS_CD INT
		,ZERO_BALANCE_DT_TM DATETIME2
		,ACTIVE_STATUS_DT_TM DATETIME2
		,ALC_DECOMP_DT_TM DATETIME2
		,ALT_LVL_CARE_DT_TM DATETIME2
		,ARCHIVE_DT_TM_ACT DATETIME2
		,ARCHIVE_DT_TM_EST DATETIME2
		,ASSIGN_TO_LOC_DT_TM DATETIME2
		,BEG_EFFECTIVE_DT_TM DATETIME2
		,CREATE_DT_TM DATETIME2
		,DEPART_DT_TM DATETIME2
		,END_EFFECTIVE_DT_TM DATETIME2
		,EST_ARRIVE_DT_TM DATETIME2
		,MENTAL_HEALTH_DT_TM DATETIME2
		,PRE_REG_DT_TM DATETIME2
		,PURGE_DT_TM_ACT DATETIME2
		,REFERRAL_RCVD_DT_TM DATETIME2
		,TRIAGE_DT_TM DATETIME2
		,ARRIVE_DT_TM DATETIME2
		,BIRTH_DT_TM DATETIME2
		,CHART_COMPLETE_DT_TM DATETIME2
		,DATA_STATUS_DT_TM DATETIME2
		,DISCH_DT_TM DATETIME2
		,DOC_RCVD_DT_TM DATETIME2
		,ENCNTR_COMPLETE_DT_TM DATETIME2
		,EST_DEPART_DT_TM DATETIME2
		,INPATIENT_ADMIT_DT_TM DATETIME2
		,PA_CURRENT_STATUS_DT_TM DATETIME2
		,PURGE_DT_TM_EST DATETIME2
		,REG_DT_TM DATETIME2
		,RESULT_ACCUMULATION_DT_TM DATETIME2
		,TRAUMA_DT_TM DATETIME2
		,PREGNANCY_STATUS_CD INT
		,INITIAL_CONTACT_DT_TM DATETIME2
		,LAST_MENSTRUAL_PERIOD_DT_TM DATETIME2
		,ONSET_DT_TM DATETIME2
		,EXPECTED_DELIVERY_DT_TM DATETIME2
		,LEVEL_OF_SERVICE_CD INT
		,ABN_STATUS_CD INT
		,PLACE_OF_SVC_ORG_ID INT
		,PLACE_OF_SVC_TYPE_CD INT
		,PLACE_OF_SVC_ADMIT_DT_TM DATETIME2
		,ENTERPRISE_UPDATE_DT_TM DATETIME2
	)

	INSERT INTO #encounter_update_filtered
	select 
		eu.ENCNTR_ID
		,eu.PERSON_ID
		,eu.UPDT_CNT
		,eu.UPDT_DT_TM
		,eu.UPDT_ID
		,eu.UPDT_TASK
		,eu.UPDT_APPLCTX
		,eu.ACTIVE_IND
		,eu.ACTIVE_STATUS_CD
		,eu.ACTIVE_STATUS_PRSNL_ID
		,eu.CREATE_PRSNL_ID
		,eu.ENCNTR_CLASS_CD
		,eu.ENCNTR_TYPE_CD
		,eu.ENCNTR_TYPE_CLASS_CD
		,eu.ENCNTR_STATUS_CD
		,eu.PRE_REG_PRSNL_ID
		,eu.REG_PRSNL_ID
		,eu.ADMIT_TYPE_CD
		,eu.ADMIT_SRC_CD
		,eu.ADMIT_MODE_CD
		,eu.ADMIT_WITH_MEDICATION_CD
		,eu.REFERRING_COMMENT
		,eu.DISCH_DISPOSITION_CD
		,eu.DISCH_TO_LOCTN_CD
		,eu.PREADMIT_NBR
		,eu.PREADMIT_TESTING_CD
		,eu.READMIT_CD
		,eu.ACCOMMODATION_CD
		,eu.ACCOMMODATION_REQUEST_CD
		,eu.ALT_RESULT_DEST_CD
		,eu.AMBULATORY_COND_CD
		,eu.COURTESY_CD
		,eu.DIET_TYPE_CD
		,eu.ISOLATION_CD
		,eu.MED_SERVICE_CD
		,eu.RESULT_DEST_CD
		,eu.CONFID_LEVEL_CD
		,eu.VIP_CD
		,eu.NAME_LAST_KEY
		,eu.NAME_FIRST_KEY
		,eu.NAME_FULL_FORMATTED
		,eu.NAME_LAST
		,eu.NAME_FIRST
		,eu.NAME_PHONETIC
		,eu.SEX_CD
		,eu.BIRTH_DT_CD
		,eu.SPECIES_CD
		,eu.DATA_STATUS_CD
		,eu.DATA_STATUS_PRSNL_ID
		,eu.CONTRIBUTOR_SYSTEM_CD
		,eu.LOCATION_CD
		,eu.LOC_FACILITY_CD
		,eu.LOC_BUILDING_CD
		,eu.LOC_NURSE_UNIT_CD
		,eu.LOC_ROOM_CD
		,eu.LOC_BED_CD
		,eu.GUARANTOR_TYPE_CD
		,eu.LOC_TEMP_CD
		,eu.ORGANIZATION_ID
		,eu.REASON_FOR_VISIT
		,eu.ENCNTR_FINANCIAL_ID
		,eu.NAME_FIRST_SYNONYM_ID
		,eu.FINANCIAL_CLASS_CD
		,eu.BBD_PROCEDURE_CD
		,eu.INFO_GIVEN_BY
		,eu.SAFEKEEPING_CD
		,eu.TRAUMA_CD
		,eu.TRIAGE_CD
		,eu.VISITOR_STATUS_CD
		,eu.VALUABLES_CD
		,eu.SECURITY_ACCESS_CD
		,eu.REFER_FACILITY_CD
		,eu.ACCOMP_BY_CD
		,eu.ACCOMMODATION_REASON_CD
		,eu.PA_CURRENT_STATUS_CD
		,eu.PARENT_RET_CRITERIA_ID
		,eu.SERVICE_CATEGORY_CD
		,eu.CONTRACT_STATUS_CD
		,eu.EST_LENGTH_OF_STAY
		,eu.ALT_LVL_CARE_CD
		,eu.PROGRAM_SERVICE_CD
		,eu.SPECIALTY_UNIT_CD
		,eu.MENTAL_HEALTH_CD
		,eu.REGION_CD
		,eu.SITTER_REQUIRED_CD
		,eu.ALC_REASON_CD
		,eu.PLACEMENT_AUTH_PRSNL_ID
		,eu.PATIENT_CLASSIFICATION_CD
		,eu.MENTAL_CATEGORY_CD
		,eu.PSYCHIATRIC_STATUS_CD
		,eu.ZERO_BALANCE_DT_TM
		,eu.ACTIVE_STATUS_DT_TM
		,eu.ALC_DECOMP_DT_TM
		,eu.ALT_LVL_CARE_DT_TM
		,eu.ARCHIVE_DT_TM_ACT
		,eu.ARCHIVE_DT_TM_EST
		,eu.ASSIGN_TO_LOC_DT_TM
		,eu.BEG_EFFECTIVE_DT_TM
		,eu.CREATE_DT_TM
		,eu.DEPART_DT_TM
		,eu.END_EFFECTIVE_DT_TM
		,eu.EST_ARRIVE_DT_TM
		,eu.MENTAL_HEALTH_DT_TM
		,eu.PRE_REG_DT_TM
		,eu.PURGE_DT_TM_ACT
		,eu.REFERRAL_RCVD_DT_TM
		,eu.TRIAGE_DT_TM
		,eu.ARRIVE_DT_TM
		,eu.BIRTH_DT_TM
		,eu.CHART_COMPLETE_DT_TM
		,eu.DATA_STATUS_DT_TM
		,eu.DISCH_DT_TM
		,eu.DOC_RCVD_DT_TM
		,eu.ENCNTR_COMPLETE_DT_TM
		,eu.EST_DEPART_DT_TM
		,eu.INPATIENT_ADMIT_DT_TM
		,eu.PA_CURRENT_STATUS_DT_TM
		,eu.PURGE_DT_TM_EST
		,eu.REG_DT_TM
		,eu.RESULT_ACCUMULATION_DT_TM
		,eu.TRAUMA_DT_TM
		,eu.PREGNANCY_STATUS_CD
		,eu.INITIAL_CONTACT_DT_TM
		,eu.LAST_MENSTRUAL_PERIOD_DT_TM
		,eu.ONSET_DT_TM
		,eu.EXPECTED_DELIVERY_DT_TM
		,eu.LEVEL_OF_SERVICE_CD
		,eu.ABN_STATUS_CD
		,eu.PLACE_OF_SVC_ORG_ID
		,eu.PLACE_OF_SVC_TYPE_CD
		,eu.PLACE_OF_SVC_ADMIT_DT_TM
		,eu.ENTERPRISE_UPDATE_DT_TM
	from 
		#encounter_update eu
		left outer join cerner.ENCOUNTER e on e.ENCNTR_ID = eu.ENCNTR_ID
	where
		e.ENCNTR_ID is null
	union all
	select 
		eu.ENCNTR_ID
		,eu.PERSON_ID
		,eu.UPDT_CNT
		,eu.UPDT_DT_TM
		,eu.UPDT_ID
		,eu.UPDT_TASK
		,eu.UPDT_APPLCTX
		,eu.ACTIVE_IND
		,eu.ACTIVE_STATUS_CD
		,eu.ACTIVE_STATUS_PRSNL_ID
		,eu.CREATE_PRSNL_ID
		,eu.ENCNTR_CLASS_CD
		,eu.ENCNTR_TYPE_CD
		,eu.ENCNTR_TYPE_CLASS_CD
		,eu.ENCNTR_STATUS_CD
		,eu.PRE_REG_PRSNL_ID
		,eu.REG_PRSNL_ID
		,eu.ADMIT_TYPE_CD
		,eu.ADMIT_SRC_CD
		,eu.ADMIT_MODE_CD
		,eu.ADMIT_WITH_MEDICATION_CD
		,eu.REFERRING_COMMENT
		,eu.DISCH_DISPOSITION_CD
		,eu.DISCH_TO_LOCTN_CD
		,eu.PREADMIT_NBR
		,eu.PREADMIT_TESTING_CD
		,eu.READMIT_CD
		,eu.ACCOMMODATION_CD
		,eu.ACCOMMODATION_REQUEST_CD
		,eu.ALT_RESULT_DEST_CD
		,eu.AMBULATORY_COND_CD
		,eu.COURTESY_CD
		,eu.DIET_TYPE_CD
		,eu.ISOLATION_CD
		,eu.MED_SERVICE_CD
		,eu.RESULT_DEST_CD
		,eu.CONFID_LEVEL_CD
		,eu.VIP_CD
		,eu.NAME_LAST_KEY
		,eu.NAME_FIRST_KEY
		,eu.NAME_FULL_FORMATTED
		,eu.NAME_LAST
		,eu.NAME_FIRST
		,eu.NAME_PHONETIC
		,eu.SEX_CD
		,eu.BIRTH_DT_CD
		,eu.SPECIES_CD
		,eu.DATA_STATUS_CD
		,eu.DATA_STATUS_PRSNL_ID
		,eu.CONTRIBUTOR_SYSTEM_CD
		,eu.LOCATION_CD
		,eu.LOC_FACILITY_CD
		,eu.LOC_BUILDING_CD
		,eu.LOC_NURSE_UNIT_CD
		,eu.LOC_ROOM_CD
		,eu.LOC_BED_CD
		,eu.GUARANTOR_TYPE_CD
		,eu.LOC_TEMP_CD
		,eu.ORGANIZATION_ID
		,eu.REASON_FOR_VISIT
		,eu.ENCNTR_FINANCIAL_ID
		,eu.NAME_FIRST_SYNONYM_ID
		,eu.FINANCIAL_CLASS_CD
		,eu.BBD_PROCEDURE_CD
		,eu.INFO_GIVEN_BY
		,eu.SAFEKEEPING_CD
		,eu.TRAUMA_CD
		,eu.TRIAGE_CD
		,eu.VISITOR_STATUS_CD
		,eu.VALUABLES_CD
		,eu.SECURITY_ACCESS_CD
		,eu.REFER_FACILITY_CD
		,eu.ACCOMP_BY_CD
		,eu.ACCOMMODATION_REASON_CD
		,eu.PA_CURRENT_STATUS_CD
		,eu.PARENT_RET_CRITERIA_ID
		,eu.SERVICE_CATEGORY_CD
		,eu.CONTRACT_STATUS_CD
		,eu.EST_LENGTH_OF_STAY
		,eu.ALT_LVL_CARE_CD
		,eu.PROGRAM_SERVICE_CD
		,eu.SPECIALTY_UNIT_CD
		,eu.MENTAL_HEALTH_CD
		,eu.REGION_CD
		,eu.SITTER_REQUIRED_CD
		,eu.ALC_REASON_CD
		,eu.PLACEMENT_AUTH_PRSNL_ID
		,eu.PATIENT_CLASSIFICATION_CD
		,eu.MENTAL_CATEGORY_CD
		,eu.PSYCHIATRIC_STATUS_CD
		,eu.ZERO_BALANCE_DT_TM
		,eu.ACTIVE_STATUS_DT_TM
		,eu.ALC_DECOMP_DT_TM
		,eu.ALT_LVL_CARE_DT_TM
		,eu.ARCHIVE_DT_TM_ACT
		,eu.ARCHIVE_DT_TM_EST
		,eu.ASSIGN_TO_LOC_DT_TM
		,eu.BEG_EFFECTIVE_DT_TM
		,eu.CREATE_DT_TM
		,eu.DEPART_DT_TM
		,eu.END_EFFECTIVE_DT_TM
		,eu.EST_ARRIVE_DT_TM
		,eu.MENTAL_HEALTH_DT_TM
		,eu.PRE_REG_DT_TM
		,eu.PURGE_DT_TM_ACT
		,eu.REFERRAL_RCVD_DT_TM
		,eu.TRIAGE_DT_TM
		,eu.ARRIVE_DT_TM
		,eu.BIRTH_DT_TM
		,eu.CHART_COMPLETE_DT_TM
		,eu.DATA_STATUS_DT_TM
		,eu.DISCH_DT_TM
		,eu.DOC_RCVD_DT_TM
		,eu.ENCNTR_COMPLETE_DT_TM
		,eu.EST_DEPART_DT_TM
		,eu.INPATIENT_ADMIT_DT_TM
		,eu.PA_CURRENT_STATUS_DT_TM
		,eu.PURGE_DT_TM_EST
		,eu.REG_DT_TM
		,eu.RESULT_ACCUMULATION_DT_TM
		,eu.TRAUMA_DT_TM
		,eu.PREGNANCY_STATUS_CD
		,eu.INITIAL_CONTACT_DT_TM
		,eu.LAST_MENSTRUAL_PERIOD_DT_TM
		,eu.ONSET_DT_TM
		,eu.EXPECTED_DELIVERY_DT_TM
		,eu.LEVEL_OF_SERVICE_CD
		,eu.ABN_STATUS_CD
		,eu.PLACE_OF_SVC_ORG_ID
		,eu.PLACE_OF_SVC_TYPE_CD
		,eu.PLACE_OF_SVC_ADMIT_DT_TM
		,eu.ENTERPRISE_UPDATE_DT_TM
	from
		#encounter_update eu
		left outer join cerner.ENCOUNTER e on e.ENCNTR_ID = eu.ENCNTR_ID and e.UPDT_CNT < eu.UPDT_CNT
	where
		e.ENCNTR_ID is not null
END

BEGIN
	delete 
	from 
		cerner.ENCOUNTER
	where 
		ENCNTR_ID in (select ENCNTR_ID from #encounter_update_filtered)
END

BEGIN
	insert into cerner.ENCOUNTER
	select * from #encounter_update_filtered
END
