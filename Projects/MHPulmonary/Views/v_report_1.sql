USE [PROJECTS]
GO

/****** Object:  View [MHPulmonary].[v_report_1]    Script Date: 9/19/2023 9:03:24 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


create view [MHPulmonary].[v_report_1] as

with referral_data as (
select
	r.*
	,case
		when r.REFER_TO_PROVIDER = 'Anthony, Andrea K, MD - Pulm Med' then 'Anthony, Andrea K, MD'
		when r.REFER_TO_PROVIDER = 'Fieser, Jason A, MD - Pulmonary Medicine' then 'Fieser, Jason A, MD' 
		when r.REFER_TO_PROVIDER = 'Ladesich, J Brian, MD - Pulmonary Medicine' then 'Ladesich, J. Brian MD' 
		when r.REFER_TO_PROVIDER = 'Meredith, Alexis H, MD - Pulmonary Medicine' then 'Meredith, Alexis MD' 
		when r.REFER_TO_PROVIDER = 'Ranes, Justin L, MD - Pulmonary Medicine' then 'Ranes, Justin MD' 
		when r.REFER_TO_PROVIDER = 'Tosh-Mitchell, Debashree, MD - Pulmonary Medicine' then 'Tosh-Mitchell, Debashree, MD' 
		end as MHPulmonary_PROVIDER
	,case
		when CREATE_DT_TM >= '10-1-2019' and CREATE_DT_TM < '10-1-2020' then '2019-2020'
		when CREATE_DT_TM >= '10-1-2020' and CREATE_DT_TM < '10-1-2021' then '2020-2021'
		when CREATE_DT_TM >= '10-1-2021' and CREATE_DT_TM < '10-1-2022' then '2021-2022'
		end as year
	,case when len(r.REFER_FROM_LOC) < 1 then null else r.REFER_FROM_LOC end as REFER_FROM_LOC_nulls
	,case when len(r.REFER_FROM_PRACTICE_SITE_ID) < 1 then null else r.REFER_FROM_PRACTICE_SITE_ID end as REFER_FROM_PRAC_nulls
from
	MHPulmonary.referrals r
where
	r.REFERED_FROM_OR_TO = 'Refered to MHPulmonary Provider'
), appointment_data as (
select distinct
	year
	,patient
	,MHPulmonary_PROVIDER
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
)
select
*
from(
	select distinct
		year
		,MHPulmonary_PROVIDER
		,count(patient) over (partition by year, MHPulmonary_PROVIDER) as num_of_referrals
		,sum(mh_location_ind) over (partition by year, MHPulmonary_PROVIDER) as refer_inside_org
		,count(case when new_patient_ind is not null then 1 end) over (partition by year, MHPulmonary_PROVIDER) as appointments_made_from_referrals
		,sum(new_patient_ind) over (partition by year, MHPulmonary_PROVIDER) as new_patients_from_referrals
		,count(outside_location) over (partition by year, MHPulmonary_PROVIDER, outside_location) as refer_outside_org
		,outside_location
	from(
		select
			year
			,MHPulmonary_PROVIDER
			,patient
			,mh_location_ind
			,case 
				when mh_location_ind = 0 AND outside_location is null then 'No Location Data'
				when mh_location_ind = 1 then null
				else outside_location end as outside_location
			,new_patient_ind
		from(
			select
				year
				,MHPulmonary_PROVIDER
				,patient
				,REFER_FROM_PRAC_nulls as outside_location
				,case
					when REFER_FROM_LOC_nulls is not null then 1
					when REFER_FROM_PRAC_nulls like '%Meritas Health%' then 1
					else 0 end as mh_location_ind
				,new_patient_ind
			from(
				select
					year
					,MHPulmonary_PROVIDER
					,PATIENT
					,REFER_FROM_LOC_nulls
					,REFER_FROM_PRAC_nulls
					,new_patient_ind
				from(
					select
						r.*
						,a.new_patient_ind
					from
						referral_data r
						left join appointment_data a 
							on r.PATIENT = a.PATIENT
							and r.year = a.year
					)a
				)b
			)c
		)d
	)e
where
	outside_location is not null
--order by year, MHPulmonary_PROVIDER
GO


