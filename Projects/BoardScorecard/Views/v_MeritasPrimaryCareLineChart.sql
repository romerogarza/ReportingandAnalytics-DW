USE [PROJECTS]
GO

/****** Object:  View [BoardScorecard].[v_MeritasPrimaryCareLineChart]    Script Date: 9/19/2023 9:23:14 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [BoardScorecard].[v_MeritasPrimaryCareLineChart] AS

WITH maxdate as (
	select distinct
		stageID
		,max(date) over (partition by StageID) as maxdate
	from(
		select
			StageID
			,Date
		from 
			[BoardScorecard].[v_MeritasPrimaryCare]
		union
		select
			StageID
			,Date
		from 
			[BoardScorecard].MeritasPatientExperience
	)a
), data as (
	select
		StageID
		,Date
		,value
	from 
		[BoardScorecard].[v_MeritasPrimaryCare]
	where
		StageID in (41,42,43,44,45)
	union all
	select
		StageID
		,dateadd(month,1,Date) as date
		,[CurrentValue]
	from
		BoardScorecard.MeritasPatientExperience
)
	/*Most Recent Month*/
	select
		StageID
		,Date
		,value
		,maxdate as Datejoin
		,case 
			when Date = maxdate then 1 
			when Date = DATEADD(month,-1,maxdate) then 2 
			when Date = DATEADD(month,-2,maxdate) then 3 
			when Date = DATEADD(month,-3,maxdate) then 4
			when Date = DATEADD(month,-4,maxdate) then 5 
			when Date = DATEADD(month,-5,maxdate) then 6
			when Date = DATEADD(month,-6,maxdate) then 7 
			when Date = DATEADD(month,-7,maxdate) then 8
			when Date = DATEADD(month,-8,maxdate) then 9 
			when Date = DATEADD(month,-9,maxdate) then 10 
			when Date = DATEADD(month,-10,maxdate) then 11
			when Date = DATEADD(month,-11,maxdate) then 12 
		end as sortorder
	from(
		select 
			d.StageID
			,d.Date
			,d.value
			,m.maxdate
			,case when d.date > DATEADD(month,-12,MAX(d.Date) over (partition by d.StageID)) then 1 end as dates
		from 
			data d
			join maxdate m on /*m.maxdate = d.Date and*/ m.StageID = d.StageID
	)a
	where
		dates = 1
		
GO


