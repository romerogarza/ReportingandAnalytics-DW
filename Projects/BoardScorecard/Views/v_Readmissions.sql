USE [PROJECTS]
GO

/****** Object:  View [BoardScorecard].[v_Readmissions]    Script Date: 9/19/2023 9:26:29 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [BoardScorecard].[v_Readmissions] AS

select
	ID
	,StageID
	,Date
	,REPLACE(Date,'-','') as DateKey
	,DateDisplay
	,Value
	,FYTD
	,Active
	,Upload_dt_tm
from(
	select
		ID
		,StageID
		,DATEADD(month,4,Date) as Date
		,Date as DateDisplay
		,Value
		,FYTD
		,Active
		,Upload_dt_tm
	from 
		BoardScorecard.Readmissions
	where
		Active = 1
)a
GO


