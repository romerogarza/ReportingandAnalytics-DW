USE [PROJECTS]
GO
/****** Object:  StoredProcedure [MHPulmonary].[referral_nonappointments_daily_update]    Script Date: 9/19/2023 8:54:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [MHPulmonary].[referral_nonappointments_daily_update] AS

BEGIN
	BEGIN
		create table #nonappointments (
			SCH_APPT_ID bigint
			,PATIENT varchar(255)
			,GENDER varchar(100)
			,DURATION int
			,SCH_APPT_STATE varchar(100)
			,SCH_ROLE varchar(100)
			,APPT_LOCATION varchar(255)
			,ARRIVE_TIME DATETIME
			,DISCH_TIME DATETIME
			,ENCNTR_TYPE varchar(100)
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

		insert into #nonappointments
		select distinct
			0 as SCH_APPT_ID
			,p.NAME_FULL_FORMATTED AS Patient
			,(select display from enterprise.cerner.code_value where code_value = p.sex_cd) as gender
			,null as duration
			,'No Appointment' sch_appt_state
			,'No Appointment' as sch_role
			,(select display from enterprise.cerner.code_value where code_value = e.LOC_FACILITY_CD) as appt_location
			,CONVERT(datetime, DATEADD(MINUTE, DATEDIFF(MINUTE, getutcdate(), getdate()), e.ARRIVE_DT_TM)) as ARRIVE_time
			,CONVERT(datetime, DATEADD(MINUTE, DATEDIFF(MINUTE, getutcdate(), getdate()), e.DISCH_DT_TM)) as DISCH_time
			,(select display from enterprise.cerner.code_value where code_value = e.encntr_type_cd) as encntr_type
			,pr.NAME_FULL_FORMATTED as Physician
			,d.DIAGNOSIS_DISPLAY as Diagnosis
			,n.SOURCE_STRING as nomenclature
			,n.SOURCE_IDENTIFIER as diagnosis_code
			,e.ENCNTR_ID
			,getdate() as UPDATE_DT_TM
		from
			#referrals r
			join enterprise.cerner.encounter e on r.encntr_id = e.encntr_id
			left join enterprise.cerner.sch_appt s on e.encntr_id = s.encntr_id and s.sch_role_cd = 4572
			left join enterprise.cerner.sch_appt s2 on s2.sch_event_id = s.sch_event_id and s2.schedule_id = s.schedule_id /*Most Recent*/ and s2.primary_role_ind = 1 --and s2.ROLE_DESCRIPTION in (''Providers'',''Resource'')
			left join enterprise.cerner.person p on p.person_id = e.person_id
			left join enterprise.cerner.sch_event se on se.sch_event_id = s.sch_event_id and se.active_ind = 1
			left join enterprise.cerner.encntr_prsnl_reltn ep on ep.encntr_id = e.encntr_id
			left join enterprise.cerner.prsnl pr on pr.person_id = ep.prsnl_person_id
			left join enterprise.cerner.diagnosis d on d.encntr_id = e.encntr_id
			left join enterprise.cerner.nomenclature n on n.nomenclature_id = d.nomenclature_id
		where
			s.sch_appt_id is null
		END
		BEGIN
			delete
			from
				MHPulmonary.referral_nonappointments
			where
				ENCNTR_ID in (select ENCNTR_ID from #nonappointments)
		END
		BEGIN
			INSERT INTO MHPulmonary.referral_nonappointments
			SELECT * FROM #nonappointments
		END
END