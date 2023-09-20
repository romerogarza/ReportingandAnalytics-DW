USE [PROJECTS]
GO

/****** Object:  View [MHPulmonary].[v_report_3]    Script Date: 9/19/2023 9:04:32 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


create view [MHPulmonary].[v_report_3] as

select distinct
	year
	,MHPulmonary_PROVIDER
	,zipcode
	,patient_type
	,case
		when patient_type = 'New Patients' then 
			sum(case when Patient_type = 'New Patients' then 1 end) over (partition by year, MHPulmonary_PROVIDER, zipcode, patient_type) 
		when patient_type = 'Existing Patients' then 
			sum(case when Patient_type = 'Existing Patients' then 1 end) over (partition by year, MHPulmonary_PROVIDER, zipcode, patient_type) 
		end as patient_cnt
	,sum(COPD_Patient) over (partition by year, MHPulmonary_PROVIDER, zipcode, patient_type) as COPD_patient
	,sum(ASTHMA_Patient) over (partition by year, MHPulmonary_PROVIDER, zipcode, patient_type) as ASTHMA_Patient
	,sum(SLEEP_Patient) over (partition by year, MHPulmonary_PROVIDER, zipcode, patient_type) as SLEEP_Patient
from(
	select
		year
		,MHPulmonary_PROVIDER
		,zipcode
		,case when new_patient_ind = 1 then 'New Patients' else 'Existing Patients' end as Patient_type
		,COPD_Patient
		,ASTHMA_Patient
		,SLEEP_Patient
	from(
		select distinct
			year
			,MHPulmonary_PROVIDER
			,PATIENT
			,zipcode
			,case
				when COPD_Patient > 0 then 1 else 0 end as COPD_Patient
			,case 
				when ASTHMA_Patient > 0 then 1 else 0 end as ASTHMA_Patient
			,case 
				when SLEEP_Patient > 0 then 1 else 0 end as SLEEP_Patient
			,case 
				when new_patient_ind > 0 then 1 else 0 end as new_patient_ind
		from(
			select distinct
				year
				,MHPulmonary_PROVIDER
				,PATIENT
				,zipcode
				,sum(COPD) over (partition by patient) as COPD_Patient
				,sum(ASTHMA) over (partition by patient) as ASTHMA_Patient
				,sum(SLEEP) over (partition by patient) as SLEEP_Patient
				,sum(case when appt_type = 'New Patient' OR APPT_TYPE = 'Hospital Follow Up' then 1 end) over (partition by year, patient) as new_patient_ind
			from(
				select
					a.*
					,case
						when APPT_START_TIME >= '10-1-2019' and APPT_START_TIME < '10-1-2020' then '2019-2020'
						when APPT_START_TIME >= '10-1-2020' and APPT_START_TIME < '10-1-2021' then '2020-2021'
						when APPT_START_TIME >= '10-1-2021' and APPT_START_TIME < '10-1-2022' then '2021-2022'
						end as year
					,case 
						when DIAGNOSIS_CODE like '%J45%' then 1 
						when DIAGNOSIS_CODE like '%J46%' then 1 
						when DIAGNOSIS_CODE like '%J40%' then 1 
						when DIAGNOSIS_CODE like '%J41%' then 1 
						when DIAGNOSIS_CODE like '%J42%' then 1 
						when DIAGNOSIS_CODE like '%J43%' then 1 
						when DIAGNOSIS_CODE like '%J44%' then 1 
						when DIAGNOSIS_CODE like '%J47%' then 1 
						when DIAGNOSIS_CODE like '%J67%' then 1 
						when DIAGNOSIS_CODE like '%C33%' then 1 
						when DIAGNOSIS_CODE like '%C34%' then 1 
						when DIAGNOSIS_CODE like '%C45%' then 1 
						when DIAGNOSIS_CODE like '%J84%' then 1 
						when DIAGNOSIS_CODE like '%J10%' then 1 
						when DIAGNOSIS_CODE like '%J11%' then 1 
						when DIAGNOSIS_CODE like '%J12%' then 1 
						when DIAGNOSIS_CODE like '%J13%' then 1 
						when DIAGNOSIS_CODE like '%J14%' then 1 
						when DIAGNOSIS_CODE like '%J15%' then 1 
						when DIAGNOSIS_CODE like '%J16%' then 1 
						when DIAGNOSIS_CODE like '%J18%' then 1 
						when DIAGNOSIS_CODE like '%J61%' then 1 
						when DIAGNOSIS_CODE like '%J60%' then 1 
						when DIAGNOSIS_CODE like '%J62%' then 1 
						when DIAGNOSIS_CODE like '%J66%' then 1 
						when DIAGNOSIS_CODE like '%J63%' then 1 
						when DIAGNOSIS_CODE like '%J64%' then 1 
						when DIAGNOSIS_CODE like '%J84%' then 1 
						when DIAGNOSIS_CODE like '%A16%' then 1 
						when DIAGNOSIS_CODE like '%A19%' then 1 
						when DIAGNOSIS_CODE like '%B90.9%' then 1 
						else 0 end as COPD
					,case 
						when DIAGNOSIS_CODE like '%J45.2%' then 1 
						when DIAGNOSIS_CODE like '%J45.3%' then 1 
						when DIAGNOSIS_CODE like '%J45.4%' then 1 
						when DIAGNOSIS_CODE like '%J45.5%' then 1 
						when DIAGNOSIS_CODE like '%J45.9%' then 1 
						else 0 end as ASTHMA
					,case
						when DIAGNOSIS_CODE like '%G47%' then 1 
						else 0 end as SLEEP
					,case
						when a.PHYSICIAN = 'Anthony, Andrea K, MD - Pulm Med' then 'Anthony, Andrea K, MD'
						when a.PHYSICIAN = 'Fieser, Jason A, MD - Pulmonary Medicine' then 'Fieser, Jason A, MD' 
						when a.PHYSICIAN = 'Ladesich, J. Brian MD' then 'Ladesich, J. Brian MD' 
						when a.PHYSICIAN = 'Meredith, Alexis MD' then 'Meredith, Alexis MD' 
						when a.PHYSICIAN = 'Ranes, Justin MD' then 'Ranes, Justin MD' 
						when a.PHYSICIAN = 'Tosh-Mitchell, Debashree, MD' then 'Tosh-Mitchell, Debashree, MD' 
						end as MHPulmonary_PROVIDER
				from
					MHPulmonary.Appointments a
				where
					a.SCH_APPT_STATE = 'Checked Out'
				)a
			where
				MHPulmonary_PROVIDER is not null
			)b
		)c
	)d
GO


