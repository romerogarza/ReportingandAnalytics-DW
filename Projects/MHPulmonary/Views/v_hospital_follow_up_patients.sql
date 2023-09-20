USE [PROJECTS]
GO

/****** Object:  View [MHPulmonary].[v_hospital_follow_up_patients]    Script Date: 9/19/2023 9:00:23 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


create view [MHPulmonary].[v_hospital_follow_up_patients] as

select distinct
	year
	,count(case when appt_type = 'Hospital Follow Up' then 1 end) over (partition by year) as Hospital_Follow_Up_cnt
from(
	select
		case
			when APPT_START_TIME >= '10-1-2019' and APPT_START_TIME < '10-1-2020' then '2019-2020'
			when APPT_START_TIME >= '10-1-2020' and APPT_START_TIME < '10-1-2021' then '2020-2021'
			when APPT_START_TIME >= '10-1-2021' and APPT_START_TIME < '10-1-2022' then '2021-2022'
			end as year
		,APPT_TYPE
	from(
		select distinct
			SCH_APPT_ID
			,PATIENT
			,SCH_APPT_STATE
			,APPT_TYPE
			,APPT_LOCATION
			,APPT_START_TIME
			,APPT_END_TIME
			,PHYSICIAN
		from
			MHPulmonary.Appointments
		where
			APPT_START_TIME < getdate()
		)a
	)b
GO


