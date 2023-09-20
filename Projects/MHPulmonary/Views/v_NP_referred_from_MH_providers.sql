USE [PROJECTS]
GO

/****** Object:  View [MHPulmonary].[v_NP_referred_from_MH_providers]    Script Date: 9/19/2023 9:02:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE view [MHPulmonary].[v_NP_referred_from_MH_providers] as

select distinct
	year
	,count(appt_type) over (partition by year) as referal_cnt
from(
	select
		case
			when APPT_START_TIME >= '10-1-2019' and APPT_START_TIME < '10-1-2020' then '2019-2020'
			when APPT_START_TIME >= '10-1-2020' and APPT_START_TIME < '10-1-2021' then '2020-2021'
			when APPT_START_TIME >= '10-1-2021' and APPT_START_TIME < '10-1-2022' then '2021-2022'
			end as year
		,APPT_TYPE
	from(
		select 
			r.* 
			,a.APPT_TYPE
			,a.APPT_START_TIME
		from 
			MHPulmonary.referrals r
			join (
				select distinct 
					ENCNTR_ID
					,APPT_TYPE
					,APPT_START_TIME
				from 
					MHPulmonary.referral_appointments a
				where 
					APPT_TYPE = 'New Patient'
					OR APPT_TYPE = 'Hospital Follow Up'
			)a on r.OUTBOUND_ENCNTR_ID = a.ENCNTR_ID
		where
			r.REFERED_FROM_OR_TO = 'Refered to MHPulmonary Provider'
			and len(r.REFER_FROM_LOC) > 1
		)a
	)b
GO


