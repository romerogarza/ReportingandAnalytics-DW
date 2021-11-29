USE [ENTERPRISE]
GO

/****** Object:  View [cerner].[v_ENCOUNTER]    Script Date: 11/29/2021 5:28:37 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [cerner].[v_ENCOUNTER] AS

select
	e.ENCNTR_ID
	,p.NAME_FULL_FORMATTED as PERSON_ID
	,e.UPDT_CNT
	,e.UPDT_DT_TM
	,e.UPDT_ID
	,e.UPDT_TASK
	,e.UPDT_APPLCTX
	,e.ACTIVE_IND
	,(select display from cerner.code_value where code_value = e.ACTIVE_STATUS_CD) as ACTIVE_STATUS_CD
	,e.ACTIVE_STATUS_PRSNL_ID
	,e.CREATE_PRSNL_ID
	,(select display from cerner.code_value where code_value = e.ENCNTR_CLASS_CD) as ENCNTR_CLASS_CD
	,(select display from cerner.code_value where code_value = e.ENCNTR_TYPE_CD) as ENCNTR_TYPE_CD
	,(select display from cerner.code_value where code_value = e.ENCNTR_TYPE_CLASS_CD) as ENCNTR_TYPE_CLASS_CD
	,(select display from cerner.code_value where code_value = e.ENCNTR_STATUS_CD) as ENCNTR_STATUS_CD
	,e.PRE_REG_PRSNL_ID
	,e.REG_PRSNL_ID
	,(select display from cerner.code_value where code_value = e.ADMIT_TYPE_CD) as ADMIT_TYPE_CD
	,(select display from cerner.code_value where code_value = e.ADMIT_SRC_CD) as ADMIT_SRC_CD
	,(select display from cerner.code_value where code_value = e.ADMIT_MODE_CD) as ADMIT_MODE_CD
	,(select display from cerner.code_value where code_value = e.ADMIT_WITH_MEDICATION_CD) as ADMIT_WITH_MEDICATION_CD
	,e.REFERRING_COMMENT
	,(select display from cerner.code_value where code_value = e.DISCH_DISPOSITION_CD) as DISCH_DISPOSITION_CD
	,(select display from cerner.code_value where code_value = e.DISCH_TO_LOCTN_CD) as DISCH_TO_LOCTN_CD
	,e.PREADMIT_NBR
	,(select display from cerner.code_value where code_value = e.PREADMIT_TESTING_CD) as PREADMIT_TESTING_CD
	,(select display from cerner.code_value where code_value = e.READMIT_CD) as READMIT_CD
	,(select display from cerner.code_value where code_value = e.ACCOMMODATION_CD) as ACCOMMODATION_CD
	,(select display from cerner.code_value where code_value = e.ACCOMMODATION_REQUEST_CD) as ACCOMMODATION_REQUEST_CD
	,(select display from cerner.code_value where code_value = e.ALT_RESULT_DEST_CD) as ALT_RESULT_DEST_CD
	,(select display from cerner.code_value where code_value = e.AMBULATORY_COND_CD) as AMBULATORY_COND_CD
	,(select display from cerner.code_value where code_value = e.COURTESY_CD) as COURTESY_CD
	,(select display from cerner.code_value where code_value = e.DIET_TYPE_CD) as DIET_TYPE_CD
	,(select display from cerner.code_value where code_value = e.ISOLATION_CD) as ISOLATION_CD
	,(select display from cerner.code_value where code_value = e.MED_SERVICE_CD) as MED_SERVICE_CD
	,(select display from cerner.code_value where code_value = e.RESULT_DEST_CD) as RESULT_DEST_CD
	,(select display from cerner.code_value where code_value = e.CONFID_LEVEL_CD) as CONFID_LEVEL_CD
	,(select display from cerner.code_value where code_value = e.VIP_CD) as VIP_CD
	,e.NAME_LAST_KEY
	,e.NAME_FIRST_KEY
	,e.NAME_FULL_FORMATTED
	,e.NAME_LAST
	,e.NAME_FIRST
	,e.NAME_PHONETIC
	,(select display from cerner.code_value where code_value = e.SEX_CD) as SEX_CD
	,(select display from cerner.code_value where code_value = e.BIRTH_DT_CD) as BIRTH_DT_CD
	,(select display from cerner.code_value where code_value = e.SPECIES_CD) as SPECIES_CD
	,(select display from cerner.code_value where code_value = e.DATA_STATUS_CD) as DATA_STATUS_CD
	,e.DATA_STATUS_PRSNL_ID
	,(select display from cerner.code_value where code_value = e.CONTRIBUTOR_SYSTEM_CD) as CONTRIBUTOR_SYSTEM_CD
	,(select display from cerner.code_value where code_value = e.LOCATION_CD) as LOCATION_CD
	,(select display from cerner.code_value where code_value = e.LOC_FACILITY_CD) as LOC_FACILITY_CD
	,(select display from cerner.code_value where code_value = e.LOC_BUILDING_CD) as LOC_BUILDING_CD
	,(select display from cerner.code_value where code_value = e.LOC_NURSE_UNIT_CD) as LOC_NURSE_UNIT_CD
	,(select display from cerner.code_value where code_value = e.LOC_ROOM_CD) as LOC_ROOM_CD
	,(select display from cerner.code_value where code_value = e.LOC_BED_CD) as LOC_BED_CD
	,(select display from cerner.code_value where code_value = e.GUARANTOR_TYPE_CD) as GUARANTOR_TYPE_CD
	,(select display from cerner.code_value where code_value = e.LOC_TEMP_CD) as LOC_TEMP_CD
	,e.ORGANIZATION_ID
	,e.REASON_FOR_VISIT
	,ENCNTR_FINANCIAL_ID
	,e.NAME_FIRST_SYNONYM_ID
	,(select display from cerner.code_value where code_value = e.FINANCIAL_CLASS_CD) as FINANCIAL_CLASS_CD
	,(select display from cerner.code_value where code_value = e.BBD_PROCEDURE_CD) as BBD_PROCEDURE_CD
	,e.INFO_GIVEN_BY
	,(select display from cerner.code_value where code_value = e.SAFEKEEPING_CD) as SAFEKEEPING_CD
	,(select display from cerner.code_value where code_value = e.TRAUMA_CD) as TRAUMA_CD
	,(select display from cerner.code_value where code_value = e.TRIAGE_CD) as TRIAGE_CD
	,(select display from cerner.code_value where code_value = e.VISITOR_STATUS_CD) as VISITOR_STATUS_CD
	,(select display from cerner.code_value where code_value = e.VALUABLES_CD) as VALUABLES_CD
	,(select display from cerner.code_value where code_value = e.SECURITY_ACCESS_CD) as SECURITY_ACCESS_CD
	,(select display from cerner.code_value where code_value = e.REFER_FACILITY_CD) as REFER_FACILITY_CD
	,(select display from cerner.code_value where code_value = e.ACCOMP_BY_CD) as ACCOMP_BY_CD
	,(select display from cerner.code_value where code_value = e.ACCOMMODATION_REASON_CD) as ACCOMMODATION_REASON_CD
	,(select display from cerner.code_value where code_value = e.PA_CURRENT_STATUS_CD) as PA_CURRENT_STATUS_CD
	,e.PARENT_RET_CRITERIA_ID
	,(select display from cerner.code_value where code_value = e.SERVICE_CATEGORY_CD) as SERVICE_CATEGORY_CD
	,(select display from cerner.code_value where code_value = e.CONTRACT_STATUS_CD) as CONTRACT_STATUS_CD
	,e.EST_LENGTH_OF_STAY
	,(select display from cerner.code_value where code_value = e.ALT_LVL_CARE_CD) as ALT_LVL_CARE_CD
	,(select display from cerner.code_value where code_value = e.PROGRAM_SERVICE_CD) as PROGRAM_SERVICE_CD
	,(select display from cerner.code_value where code_value = e.SPECIALTY_UNIT_CD) as SPECIALTY_UNIT_CD
	,(select display from cerner.code_value where code_value = e.MENTAL_HEALTH_CD) as MENTAL_HEALTH_CD
	,(select display from cerner.code_value where code_value = e.REGION_CD) as REGION_CD
	,(select display from cerner.code_value where code_value = e.SITTER_REQUIRED_CD) as SITTER_REQUIRED_CD
	,(select display from cerner.code_value where code_value = e.ALC_REASON_CD) as ALC_REASON_CD
	,e.PLACEMENT_AUTH_PRSNL_ID
	,(select display from cerner.code_value where code_value = e.PATIENT_CLASSIFICATION_CD) as PATIENT_CLASSIFICATION_CD
	,(select display from cerner.code_value where code_value = e.MENTAL_CATEGORY_CD) as MENTAL_CATEGORY_CD
	,(select display from cerner.code_value where code_value = e.PSYCHIATRIC_STATUS_CD) as PSYCHIATRIC_STATUS_CD
	,e.ZERO_BALANCE_DT_TM
	,e.ACTIVE_STATUS_DT_TM
	,e.ALC_DECOMP_DT_TM
	,e.ALT_LVL_CARE_DT_TM
	,e.ARCHIVE_DT_TM_ACT
	,e.ARCHIVE_DT_TM_EST
	,e.ASSIGN_TO_LOC_DT_TM
	,e.BEG_EFFECTIVE_DT_TM
	,e.CREATE_DT_TM
	,e.DEPART_DT_TM
	,e.END_EFFECTIVE_DT_TM
	,e.EST_ARRIVE_DT_TM
	,e.MENTAL_HEALTH_DT_TM
	,e.PRE_REG_DT_TM
	,e.PURGE_DT_TM_ACT
	,e.REFERRAL_RCVD_DT_TM
	,e.TRIAGE_DT_TM
	,e.ARRIVE_DT_TM
	,e.BIRTH_DT_TM
	,e.CHART_COMPLETE_DT_TM
	,e.DATA_STATUS_DT_TM
	,e.DISCH_DT_TM
	,e.DOC_RCVD_DT_TM
	,e.ENCNTR_COMPLETE_DT_TM
	,e.EST_DEPART_DT_TM
	,e.INPATIENT_ADMIT_DT_TM
	,e.PA_CURRENT_STATUS_DT_TM
	,e.PURGE_DT_TM_EST
	,e.REG_DT_TM
	,e.RESULT_ACCUMULATION_DT_TM
	,e.TRAUMA_DT_TM
	,(select display from cerner.code_value where code_value = e.PREGNANCY_STATUS_CD) as PREGNANCY_STATUS_CD
	,e.INITIAL_CONTACT_DT_TM
	,e.LAST_MENSTRUAL_PERIOD_DT_TM
	,e.ONSET_DT_TM
	,e.EXPECTED_DELIVERY_DT_TM
	,(select display from cerner.code_value where code_value = e.LEVEL_OF_SERVICE_CD) as LEVEL_OF_SERVICE_CD
	,(select display from cerner.code_value where code_value = e.ABN_STATUS_CD) as ABN_STATUS_CD
	,e.PLACE_OF_SVC_ORG_ID
	,(select display from cerner.code_value where code_value = e.PLACE_OF_SVC_TYPE_CD) as PLACE_OF_SVC_TYPE_CD
	,e.PLACE_OF_SVC_ADMIT_DT_TM
from
	cerner.ENCOUNTER e
	left join cerner.PERSON p on e.PERSON_ID = p.PERSON_ID
GO


