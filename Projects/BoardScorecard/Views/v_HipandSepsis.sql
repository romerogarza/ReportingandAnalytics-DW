USE [PROJECTS]
GO

/****** Object:  View [BoardScorecard].[v_HipandSepsis]    Script Date: 9/19/2023 9:20:25 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [BoardScorecard].[v_HipandSepsis] AS

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
		,case when StageID = 7 then DATEADD(month,6,Date) when StageID = 12 then DATEADD(month,2,Date) end as Date
		,Date as DateDisplay
		,Value
		,FYTD
		,Active
		,Upload_dt_tm
	from 
		BoardScorecard.HipandSepsis
	where
		Active = 1
)a
GO


