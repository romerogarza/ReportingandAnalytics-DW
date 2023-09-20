USE [PROJECTS]
GO

/****** Object:  View [BoardScorecard].[v_Mortality]    Script Date: 9/19/2023 9:23:49 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [BoardScorecard].[v_Mortality] AS

select
	ID
	,StageID
	,Date
	,REPLACE(Date,'-','') as DateKey
	,DateDisplay
	,Value
	,FTYD
	,Active
	,Upload_dt_tm
from(
	select
		ID
		,StageID
		,DATEADD(month,3,Date) as Date
		,Date as DateDisplay
		,Value
		,FTYD
		,Active
		,Upload_dt_tm
	from 
		BoardScorecard.MortalityRate
	where
		Active = 1
)a
GO


