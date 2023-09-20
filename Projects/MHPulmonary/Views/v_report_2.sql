USE [PROJECTS]
GO

/****** Object:  View [MHPulmonary].[v_report_2]    Script Date: 9/19/2023 9:03:58 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


create view [MHPulmonary].[v_report_2] as

select distinct
	year
	,MHPulmonary_PROVIDER
	,sum(new_patient_ind) over (partition by year, MHPulmonary_PROVIDER) new_patient_cnt
from(
	select distinct
		year
		,MHPulmonary_PROVIDER
		,patient
		,case when new_patient_ind > 0 then 1 else 0 end as new_patient_ind
	from(
		select distinct
			year
			,patient
			,appt_type
			,MHPulmonary_PROVIDER
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
				SCH_APPT_STATE = 'Checked Out'
			)a
		where
			MHPulmonary_PROVIDER is not null
		)b
	)c
--order by year, MHPulmonary_PROVIDER
GO


