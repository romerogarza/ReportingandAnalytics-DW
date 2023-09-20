USE [PROJECTS]
GO

/****** Object:  View [BoardScorecard].[v_MeritasPrimaryCare]    Script Date: 9/19/2023 9:22:22 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [BoardScorecard].[v_MeritasPrimaryCare] AS

select 
	StageID
	,dateadd(month,2,Date) as date
	,replace(dateadd(month,2,Date),'-','') as DateKey
	,date as datedisplay
	,End_reporting_date
	,Value
from
	BoardScorecard.MeritasPrimaryCare
where
	Active = 1
union all
select
	StageID
	,dateadd(month,1,Date) as date
	,replace(dateadd(month,1,Date),'-','') as DateKey
	,date as datedisplay
	,Date as End_reporting_date
	,[FYTD]
from
	BoardScorecard.MeritasPatientExperience
where
	Active = 1
GO


