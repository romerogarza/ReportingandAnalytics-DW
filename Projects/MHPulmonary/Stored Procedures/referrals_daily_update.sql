USE [PROJECTS]
GO
/****** Object:  StoredProcedure [MHPulmonary].[referrals_daily_update]    Script Date: 9/19/2023 8:55:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [MHPulmonary].[referrals_daily_update] AS

BEGIN
	create table #referrals (
		REFERRAL_ID bigint
		,REFERED_FROM_OR_TO varchar(255)
		,LAST_PERFORMED_ACTION varchar(255)
		,MEDICAL_SERVICE varchar(255)
		,PATIENT varchar(255)
		,REFER_FROM_ORGANIZATION varchar(255)
		,REFER_FROM_PROVIDER varchar(255)
		,REFER_TO_PROVIDER varchar(255)
		,REFERRAL_CATEGORY varchar(255)
		,REFERRAL_PRIORITY varchar(255)
		,REFERRAL_WRITTEN_DT_TM datetime
		,CREATE_DT_TM datetime
		,SERVICE_TYPE_REQUESTED varchar(255)
		,SERVICE_BY_DT_TM datetime
		,REQUESTED_START_DT_TM datetime
		,OUTBOUND_ASSIGNED_PRSNL varchar(255)
		,INBOUND_ASSIGNED_PRSNL  varchar(255)
		,OUTBOUND_ENCNTR_ID bigint
		,ORDER_ID bigint
		,REFERRAL_STATUS varchar(255)
		,REFER_FROM_PRACTICE_SITE_ID varchar(255)
		,REFER_TO_PRACTICE_SITE_ID varchar(255)
		,REFER_FROM_LOC varchar(255)
		,UPDATE_DT_TM datetime
	)

	BEGIN

		DECLARE @FirstDay as VARCHAR(10) = (select dateadd(day,-4,convert(date,getdate())))
		DECLARE @NextDay as VARCHAR(11) = (select dateadd(day,-1,convert(date,getdate())))

		insert into #referrals
		select
			r.REFERRAL_ID
			,'Refered from MHPulmonary Provider' as REFERED_FROM_OR_TO
			,(select display from enterprise.cerner.code_value where code_value = r.LAST_PERFORMED_ACTION_CD) as LAST_PERFORMED_ACTION
			,(select display from enterprise.cerner.code_value where code_value = r.MEDICAL_SERVICE_CD) as MEDICAL_SERVICE
			,(select name_full_formatted from enterprise.cerner.person where person_id = r.PERSON_ID) as PATIENT
			,(select org_name from enterprise.cerner.organization where organization_id = r.REFER_FROM_ORGANIZATION_ID) as REFER_FROM_ORGANIZATION
			,(select name_full_formatted from enterprise.cerner.prsnl where person_id = r.REFER_FROM_PROVIDER_ID) as REFER_FROM_PROVIDER
			,(select name_full_formatted from enterprise.cerner.prsnl where person_id = r.REFER_TO_PROVIDER_ID) as REFER_TO_PROVIDER
			,(select display from enterprise.cerner.code_value where code_value = r.REFERRAL_CATEGORY_CD) as REFERRAL_CATEGORY
			,(select display from enterprise.cerner.code_value where code_value = r.REFERRAL_PRIORITY_CD) as REFERRAL_PRIORITY
			,convert(datetime, r.REFERRAL_WRITTEN_DT_TM) as REFERRAL_WRITTEN_DT_TM
			,convert(datetime, r.CREATE_DT_TM) as CREATE_DT_TM
			,(select display from enterprise.cerner.code_value where code_value = r.SERVICE_TYPE_REQUESTED_CD) as SERVICE_TYPE_REQUESTED
			,convert(datetime, r.SERVICE_BY_DT_TM) as SERVICE_BY_DT_TM
			,convert(datetime, r.REQUESTED_START_DT_TM) as REQUESTED_START_DT_TM
			,(select name_full_formatted from enterprise.cerner.prsnl where person_id = r.OUTBOUND_ASSIGNED_PRSNL_ID) as OUTBOUND_ASSIGNED_PRSNL
			,(select name_full_formatted from enterprise.cerner.prsnl where person_id = r.INBOUND_ASSIGNED_PRSNL_ID) as INBOUND_ASSIGNED_PRSNL
			,r.OUTBOUND_ENCNTR_ID
			,r.ORDER_ID
			,(select display from enterprise.cerner.code_value where code_value = r.REFERRAL_STATUS_CD) as REFERRAL_STATUS
			,(select practice_site_display from enterprise.cerner.practice_site where practice_site_id = r.REFER_FROM_PRACTICE_SITE_ID) as REFER_FROM_PRACTICE_SITE_ID
			,(select practice_site_display from enterprise.cerner.practice_site where practice_site_id = r.REFER_TO_PRACTICE_SITE_ID) as REFER_TO_PRACTICE_SITE_ID
			,(select display from enterprise.cerner.code_value where code_value = r.REFER_FROM_LOC_CD) as REFER_FROM_LOC
			,getdate() as UPDATE_DT_TM
		from
			enterprise.cerner.referral r
		where
			r.REFER_FROM_PROVIDER_ID in (2246260,2564901,3645052,4096460,5078609,5223921) --MH Pulmonary Physicians
			and r.updt_dt_tm >= @FirstDay
			and r.updt_dt_tm < @NextDay
		union all
		select 
			r.REFERRAL_ID
			,'Refered to MHPulmonary Provider' as REFERED_FROM_OR_TO
			,(select display from enterprise.cerner.code_value where code_value = r.LAST_PERFORMED_ACTION_CD) as LAST_PERFORMED_ACTION
			,(select display from enterprise.cerner.code_value where code_value = r.MEDICAL_SERVICE_CD) as MEDICAL_SERVICE
			,(select name_full_formatted from enterprise.cerner.person where person_id = r.PERSON_ID) as PATIENT
			,(select org_name from enterprise.cerner.organization where organization_id = r.REFER_FROM_ORGANIZATION_ID) as REFER_FROM_ORGANIZATION_ID
			,(select name_full_formatted from enterprise.cerner.prsnl where person_id = r.REFER_FROM_PROVIDER_ID) as REFER_FROM_PROVIDER_ID
			,(select name_full_formatted from enterprise.cerner.prsnl where person_id = r.REFER_TO_PROVIDER_ID) as REFER_TO_PROVIDER_ID
			,(select display from enterprise.cerner.code_value where code_value = r.REFERRAL_CATEGORY_CD) as REFERRAL_CATEGORY
			,(select display from enterprise.cerner.code_value where code_value = r.REFERRAL_PRIORITY_CD) as REFERRAL_PRIORITY
			,r.REFERRAL_WRITTEN_DT_TM
			,r.CREATE_DT_TM
			,(select display from enterprise.cerner.code_value where code_value = r.SERVICE_TYPE_REQUESTED_CD) as SERVICE_TYPE_REQUESTED
			,r.SERVICE_BY_DT_TM
			,r.REQUESTED_START_DT_TM
			,(select name_full_formatted from enterprise.cerner.prsnl where person_id = r.OUTBOUND_ASSIGNED_PRSNL_ID) as OUTBOUND_ASSIGNED_PRSNL_ID
			,(select name_full_formatted from enterprise.cerner.prsnl where person_id = r.INBOUND_ASSIGNED_PRSNL_ID) as INBOUND_ASSIGNED_PRSNL_ID
			,r.OUTBOUND_ENCNTR_ID
			,r.ORDER_ID
			,(select display from enterprise.cerner.code_value where code_value = r.REFERRAL_STATUS_CD) as REFERRAL_STATUS
			,(select practice_site_display from enterprise.cerner.practice_site where practice_site_id = r.REFER_FROM_PRACTICE_SITE_ID) as REFER_FROM_PRACTICE_SITE_ID
			,(select practice_site_display from enterprise.cerner.practice_site where practice_site_id = r.REFER_TO_PRACTICE_SITE_ID) as REFER_TO_PRACTICE_SITE_ID
			,(select display from enterprise.cerner.code_value where code_value = r.REFER_FROM_LOC_CD) as REFER_FROM_LOC
			,getdate() as UPDATE_DT_TM
		from
			enterprise.cerner.referral r
		where
			r.REFER_TO_PROVIDER_ID in (2246260,2564901,3645052,4096460,5078609,5223921) --MH Pulmonary Physicians
			and r.updt_dt_tm >= @FirstDay
			and r.updt_dt_tm < @NextDay
	END
	BEGIN
		delete
		from
			MHPulmonary.referrals
		where
			REFERRAL_ID in (select REFERRAL_ID from #referrals)
	END
	BEGIN
		INSERT INTO MHPulmonary.referrals
		SELECT * FROM #referrals
	END
END