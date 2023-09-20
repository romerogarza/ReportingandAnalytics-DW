USE [PROJECTS]
GO

/****** Object:  View [BoardScorecard].[v_QualityOutcomesLineChart]    Script Date: 9/19/2023 9:26:03 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE view [BoardScorecard].[v_QualityOutcomesLineChart] as

WITH maxdate as (
	select distinct
		stageID
		,max(Date) over (partition by StageID) as maxdate
	from(
		select
			StageID
			,Date
		from 
			BoardScorecard.InfectionPrevention
		where
		Active = 1
	union all
		select distinct
			StageID
			,max(datejoin) over (partition by StageID) as maxdate
		from
			BoardScorecard.v_FallLineCharts
		where
			StageID = 10
	union all
	select distinct
		StageId
		,max(datejoin) over (partition by StageID) as maxdate
	from
		BoardScorecard.v_HipandSepsisLineChart
	where
		StageID = 7
	)a
), data as (
	select
		StageId
		,End_dt as DateDisplay
		,RYTD_SIR as value
	from
		BoardScorecard.infectionpreventionRYTDtrend
)
select
	a.*
	,row_number() over (partition by StageID order by DateDisplay desc) as sort
from(
	select
		d.StageID
		,d.DateDisplay
		,d.value
		,m.maxdate as datejoin
	from
		data d
		join maxdate m on m.StageID = d.stageID and d.DateDisplay > dateadd(month,-14,m.maxdate)
	)a
union all
select
	f.StageID
	,f.Date
	,f.Value
	,f.DateJoin
	,f.sortorder
from
	BoardScorecard.v_FallLineCharts f
	join maxdate m on f.StageID = m.StageID and f.Datejoin = m.maxdate
where
	f.StageID = 10
union all
select
	h.StageID
	,h.Date
	,h.Value
	,h.DateJoin
	,h.sortorder
from
	BoardScorecard.v_HipandSepsisLineChart h
	join maxdate m on h.StageID = m.StageID and h.Datejoin = m.maxdate

--select * from BoardScorecard.dimScorecardMetrics
GO


