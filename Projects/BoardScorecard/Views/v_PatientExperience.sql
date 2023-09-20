USE [PROJECTS]
GO

/****** Object:  View [BoardScorecard].[v_PatientExperience]    Script Date: 9/19/2023 9:24:51 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [BoardScorecard].[v_PatientExperience] AS

select
	StageID
	,Date
	,REPLACE(Date,'-','') as DateKey
	,DateDisplay
	,Value
	,FYTD
	,Update_dt_tm
from(
	select
		StageID
		,DATEADD(month,2,cast(Date as date)) as Date
		,cast(Date as date) as DateDisplay
		,Value
		,FYTD
		,Update_dt_tm
	from 
		BoardScorecard.PatientExperience
	where
		Active = 1
)a
union all
select
	StageID
	,Date
	,REPLACE(Date,'-','') as DateKey
	,DateDisplay
	,CurrentValue
	,FYTD
	,Upload_dt_tm
from(
	select
		StageID
		,DATEADD(month,1,cast(Date as date)) as Date
		,cast(Date as date) as DateDisplay
		,CurrentValue
		,FYTD
		,Upload_dt_tm
	from 
		BoardScorecard.HomeHealthPatientExperience
	where
		Active = 1
)a
GO


