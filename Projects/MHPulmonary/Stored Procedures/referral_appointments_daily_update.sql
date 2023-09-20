USE [PROJECTS]
GO
/****** Object:  StoredProcedure [MHPulmonary].[referral_appointments_daily_update]    Script Date: 9/19/2023 8:53:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [MHPulmonary].[referral_appointments_daily_update] AS

BEGIN
	BEGIN
		create table #appointments (
			SCH_APPT_ID bigint
			,PATIENT varchar(255)
			,GENDER varchar(100)
			,DURATION int
			,SCH_APPT_STATE varchar(100)
			,SCH_ROLE varchar(100)
			,APPT_LOCATION varchar(255)
			,APPT_START_TIME DATETIME
			,APPT_END_TIME DATETIME
			,APPT_TYPE varchar(100)
			,PHYSICIAN varchar(255)
			,DIAGNOSIS varchar(255)
			,NOMENCLATURE varchar(255)
			,DIAGNOSIS_CODE varchar(100)
			,ENCNTR_ID bigint
			,UPDATE_DT_TM datetime
		)
		create table #referrals (
			ENCNTR_ID bigint
		)
	END
	BEGIN
		insert into #referrals
		select distinct
			outbound_encntr_id
		from
			MHPulmonary.referrals
		where
			outbound_encntr_id != 0
	END
	BEGIN

		insert into #appointments
		select distinct
			s.SCH_APPT_ID
			,p.NAME_FULL_FORMATTED AS Patient
			,(select display from enterprise.cerner.code_value where code_value = p.sex_cd) as gender
			,s.duration
			,(select display from enterprise.cerner.code_value where code_value = s.SCH_STATE_CD) as sch_appt_state
			,(select display from enterprise.cerner.code_value where code_value = s.sch_role_cd) as sch_role
			,(select display from enterprise.cerner.code_value where code_value = s.appt_location_cd) as appt_location
			,CONVERT(datetime, DATEADD(MINUTE, DATEDIFF(MINUTE, getutcdate(), getdate()), s.BEG_DT_TM)) as appt_start_time
			,CONVERT(datetime, DATEADD(MINUTE, DATEDIFF(MINUTE, getutcdate(), getdate()), s.END_DT_TM)) as appt_end_time
			,(select display from enterprise.cerner.code_value where code_value = se.APPT_TYPE_CD) as appt_type
			,(select display from enterprise.cerner.code_value where code_value = s2.RESOURCE_CD) as Physician
			,d.DIAGNOSIS_DISPLAY as Diagnosis
			,n.SOURCE_STRING as nomenclature
			,n.SOURCE_IDENTIFIER as diagnosis_code
			,e.ENCNTR_ID
			,getdate() as UPDATE_DT_TM
		from
			#referrals r
			join enterprise.cerner.sch_appt s on r.encntr_id = s.encntr_id and s.sch_role_cd = 4572
			join enterprise.cerner.sch_appt s2 on s2.sch_event_id = s.sch_event_id and s2.schedule_id = s.schedule_id /*Most Recent*/ and s2.primary_role_ind = 1 --and s2.ROLE_DESCRIPTION in (''Providers'',''Resource'')
			join enterprise.cerner.person p on p.person_id = s.person_id
			join enterprise.cerner.sch_event se on se.sch_event_id = s.sch_event_id and se.active_ind = 1
			left join enterprise.cerner.encounter e on s.encntr_id = e.encntr_id
			left join enterprise.cerner.diagnosis d on d.encntr_id = e.encntr_id
			left join enterprise.cerner.nomenclature n on n.nomenclature_id = d.nomenclature_id
		END
		BEGIN
			delete
			from
				MHPulmonary.referral_appointments
			where
				sch_appt_id in (select sch_appt_id from #appointments)
		END
		BEGIN
			INSERT INTO MHPulmonary.referral_appointments
			SELECT * FROM #appointments
		END
END