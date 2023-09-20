USE [PROJECTS]
GO
/****** Object:  StoredProcedure [MHPulmonary].[appointments_daily_update]    Script Date: 9/19/2023 4:26:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [MHPulmonary].[appointments_daily_update] AS

BEGIN
	create table #appointments (
		SCH_APPT_ID bigint
		,PERSON_ID bigint
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
		,ZIPCODE varchar(100)
		,MRN	bigint
		,UPDATE_DT_TM datetime
	)

	BEGIN

			DECLARE @FirstDay as VARCHAR(10) = (select dateadd(day,-4,convert(date,getdate())))
			DECLARE @NextDay as VARCHAR(11) = (select dateadd(day,-1,convert(date,getdate())))

			insert into #appointments
			select distinct
				s.SCH_APPT_ID
				,p.person_id
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
				,case
					when len(a.zipcode) > 5 then left(a.zipcode,5)
				else a.zipcode end as zipcode
				,ea1.ALIAS as MRN
				,getdate() as UPDATE_DT_TM
			from
				enterprise.cerner.sch_appt s
				join enterprise.cerner.sch_appt s2 on s2.sch_event_id = s.sch_event_id and s2.schedule_id = s.schedule_id /*Most Recent*/ and s2.primary_role_ind = 1 --and s2.ROLE_DESCRIPTION in (''Providers'',''Resource'')
				join enterprise.cerner.person p on p.person_id = s.person_id
				join enterprise.cerner.sch_event se on se.sch_event_id = s.sch_event_id and se.active_ind = 1
				left join enterprise.cerner.encounter e on s.encntr_id = e.encntr_id
				left join enterprise.cerner.diagnosis d on d.encntr_id = e.encntr_id
				left join enterprise.cerner.nomenclature n on n.nomenclature_id = d.nomenclature_id
				left join enterprise.cerner.address a 
					on p.person_id = a.parent_entity_id
					and a.address_type_cd = 756 
					and a.active_ind = 1
					and a.beg_effective_dt_tm <= sysutcdatetime() 
					and a.end_effective_dt_tm > sysutcdatetime()
				left join enterprise.cerner.encntr_alias ea1 
					on e.encntr_id = ea1.encntr_id
					and ea1.active_ind = 1
					and ea1.alias_pool_cd = 678286
					and ea1.beg_effective_dt_tm <= sysutcdatetime() 
					and (ea1.end_effective_dt_tm > sysutcdatetime() or ea1.end_effective_dt_tm is null)
			where
				e.LOC_FACILITY_CD = 674458669 --Meritas Health Pulmonary Medicine
				and s.sch_role_cd = 4572 --Patient
				--and s.SCH_STATE_CD = 4537 --Checked Out
				and s.BEG_DT_TM >= @FirstDay
				and s.END_DT_TM < @NextDay
		END
		BEGIN
			delete
			from
				MHPulmonary.Appointments
			where
				sch_appt_id in (select sch_appt_id from #appointments)
		END
		BEGIN
			INSERT INTO MHPulmonary.Appointments
			SELECT * FROM #appointments
		END
END
