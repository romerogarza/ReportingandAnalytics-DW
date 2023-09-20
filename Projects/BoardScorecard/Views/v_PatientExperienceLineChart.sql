USE [PROJECTS]
GO

/****** Object:  View [BoardScorecard].[v_PatientExperienceLineChart]    Script Date: 9/19/2023 9:25:16 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [BoardScorecard].[v_PatientExperienceLineChart] AS

WITH maxdate as (
	select distinct
		stageID
		,max(date) over (partition by StageID) as maxdate
	from(
		select
			StageID
			,Date
		from 
			[BoardScorecard].[v_PatientExperience]
	)a
), data as (
	select
		StageID
		,Date
		,value
	from 
		[BoardScorecard].[v_PatientExperience]
)
select distinct StageID, Date, value, Datejoin, case when sortorder is null then 0 else sortorder end as sortorder from(
	/*Most Recent Month*/
	select
		StageID
		,Date
		,value
		,maxdate as Datejoin
		,case 
			when Date = DATEADD(month,-1,maxdate) then 1 when Date = DATEADD(month,-2,maxdate) then 2 
			when Date = DATEADD(month,-3,maxdate) then 3 when Date = DATEADD(month,-4,maxdate) then 4
			when Date = DATEADD(month,-5,maxdate) then 5 when Date = DATEADD(month,-6,maxdate) then 6
			when Date = DATEADD(month,-7,maxdate) then 7 when Date = DATEADD(month,-8,maxdate) then 8
			when Date = DATEADD(month,-9,maxdate) then 9 when Date = DATEADD(month,-10,maxdate) then 10
			when Date = DATEADD(month,-11,maxdate) then 11 when Date = DATEADD(month,-12,maxdate) then 12
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
	UNION ALL
	/*Month 1*/
	select
		StageID
		,Date
		,value
		,maxdate as Datejoin
		,case 
			when Date = DATEADD(month,-1,maxdate) then 1 when Date = DATEADD(month,-2,maxdate) then 2 
			when Date = DATEADD(month,-3,maxdate) then 3 when Date = DATEADD(month,-4,maxdate) then 4
			when Date = DATEADD(month,-5,maxdate) then 5 when Date = DATEADD(month,-6,maxdate) then 6
			when Date = DATEADD(month,-7,maxdate) then 7 when Date = DATEADD(month,-8,maxdate) then 8
			when Date = DATEADD(month,-9,maxdate) then 9 when Date = DATEADD(month,-10,maxdate) then 10
			when Date = DATEADD(month,-11,maxdate) then 11 when Date = DATEADD(month,-12,maxdate) then 12
			end as sortorder
	from(
		select 
			d.StageID
			,d.Date
			,d.value
			,DATEADD(month,-1,m.maxdate) as maxdate
			,case when d.date > DATEADD(month,-12,MAX(DATEADD(month,-1,d.date)) over (partition by d.StageID)) then 1 end as dates
		from 
			data d
			join maxdate m on /*m.maxdate = d.Date and*/ m.StageID = d.StageID
	)a
	where
		dates = 1
		and date <= maxdate
	UNION ALL
	/*Month 2*/
	select
		StageID
		,Date
		,value
		,maxdate as Datejoin
		,case 
			when Date = DATEADD(month,-1,maxdate) then 1 when Date = DATEADD(month,-2,maxdate) then 2 
			when Date = DATEADD(month,-3,maxdate) then 3 when Date = DATEADD(month,-4,maxdate) then 4
			when Date = DATEADD(month,-5,maxdate) then 5 when Date = DATEADD(month,-6,maxdate) then 6
			when Date = DATEADD(month,-7,maxdate) then 7 when Date = DATEADD(month,-8,maxdate) then 8
			when Date = DATEADD(month,-9,maxdate) then 9 when Date = DATEADD(month,-10,maxdate) then 10
			when Date = DATEADD(month,-11,maxdate) then 11 when Date = DATEADD(month,-12,maxdate) then 12
			end as sortorder
	from(
		select 
			d.StageID
			,d.Date
			,d.value
			,DATEADD(month,-2,m.maxdate) as maxdate
			,case when d.date > DATEADD(month,-12,MAX(DATEADD(month,-2,d.date)) over (partition by d.StageID)) then 1 end as dates
		from 
			data d
			join maxdate m on /*m.maxdate = d.Date and*/ m.StageID = d.StageID
	)a
	where
		dates = 1
		and date <= maxdate
	UNION ALL
	/*Month 3*/
	select
		StageID
		,Date
		,value
		,maxdate as Datejoin
		,case 
			when Date = DATEADD(month,-1,maxdate) then 1 when Date = DATEADD(month,-2,maxdate) then 2 
			when Date = DATEADD(month,-3,maxdate) then 3 when Date = DATEADD(month,-4,maxdate) then 4
			when Date = DATEADD(month,-5,maxdate) then 5 when Date = DATEADD(month,-6,maxdate) then 6
			when Date = DATEADD(month,-7,maxdate) then 7 when Date = DATEADD(month,-8,maxdate) then 8
			when Date = DATEADD(month,-9,maxdate) then 9 when Date = DATEADD(month,-10,maxdate) then 10
			when Date = DATEADD(month,-11,maxdate) then 11 when Date = DATEADD(month,-12,maxdate) then 12
			end as sortorder
	from(
		select 
			d.StageID
			,d.Date
			,d.value
			,DATEADD(month,-3,m.maxdate) as maxdate
			,case when d.date > DATEADD(month,-12,MAX(DATEADD(month,-3,d.date)) over (partition by d.StageID)) then 1 end as dates
		from 
			data d
			join maxdate m on /*m.maxdate = d.Date and*/ m.StageID = d.StageID
	)a
	where
		dates = 1
		and date <= maxdate
	UNION ALL
	/*Month 4*/
	select
		StageID
		,Date
		,value
		,maxdate as Datejoin
		,case 
			when Date = DATEADD(month,-1,maxdate) then 1 when Date = DATEADD(month,-2,maxdate) then 2 
			when Date = DATEADD(month,-3,maxdate) then 3 when Date = DATEADD(month,-4,maxdate) then 4
			when Date = DATEADD(month,-5,maxdate) then 5 when Date = DATEADD(month,-6,maxdate) then 6
			when Date = DATEADD(month,-7,maxdate) then 7 when Date = DATEADD(month,-8,maxdate) then 8
			when Date = DATEADD(month,-9,maxdate) then 9 when Date = DATEADD(month,-10,maxdate) then 10
			when Date = DATEADD(month,-11,maxdate) then 11 when Date = DATEADD(month,-12,maxdate) then 12
			end as sortorder
	from(
		select 
			d.StageID
			,d.Date
			,d.value
			,DATEADD(month,-4,m.maxdate) as maxdate
			,case when d.date > DATEADD(month,-12,MAX(DATEADD(month,-4,d.date)) over (partition by d.StageID)) then 1 end as dates
		from 
			data d
			join maxdate m on /*m.maxdate = d.Date and*/ m.StageID = d.StageID
	)a
	where
		dates = 1
		and date <= maxdate
	UNION ALL
	/*Month 5*/
	select
		StageID
		,Date
		,value
		,maxdate as Datejoin
		,case 
			when Date = DATEADD(month,-1,maxdate) then 1 when Date = DATEADD(month,-2,maxdate) then 2 
			when Date = DATEADD(month,-3,maxdate) then 3 when Date = DATEADD(month,-4,maxdate) then 4
			when Date = DATEADD(month,-5,maxdate) then 5 when Date = DATEADD(month,-6,maxdate) then 6
			when Date = DATEADD(month,-7,maxdate) then 7 when Date = DATEADD(month,-8,maxdate) then 8
			when Date = DATEADD(month,-9,maxdate) then 9 when Date = DATEADD(month,-10,maxdate) then 10
			when Date = DATEADD(month,-11,maxdate) then 11 when Date = DATEADD(month,-12,maxdate) then 12
			end as sortorder
	from(
		select 
			d.StageID
			,d.Date
			,d.value
			,DATEADD(month,-5,m.maxdate) as maxdate
			,case when d.date > DATEADD(month,-12,MAX(DATEADD(month,-5,d.date)) over (partition by d.StageID)) then 1 end as dates
		from 
			data d
			join maxdate m on /*m.maxdate = d.Date and*/ m.StageID = d.StageID
	)a
	where
		dates = 1
		and date <= maxdate
	UNION ALL
	/*Month 6*/
	select
		StageID
		,Date
		,value
		,maxdate as Datejoin
		,case 
			when Date = DATEADD(month,-1,maxdate) then 1 when Date = DATEADD(month,-2,maxdate) then 2 
			when Date = DATEADD(month,-3,maxdate) then 3 when Date = DATEADD(month,-4,maxdate) then 4
			when Date = DATEADD(month,-5,maxdate) then 5 when Date = DATEADD(month,-6,maxdate) then 6
			when Date = DATEADD(month,-7,maxdate) then 7 when Date = DATEADD(month,-8,maxdate) then 8
			when Date = DATEADD(month,-9,maxdate) then 9 when Date = DATEADD(month,-10,maxdate) then 10
			when Date = DATEADD(month,-11,maxdate) then 11 when Date = DATEADD(month,-12,maxdate) then 12
			end as sortorder
	from(
		select 
			d.StageID
			,d.Date
			,d.value
			,DATEADD(month,-6,m.maxdate) as maxdate
			,case when d.date > DATEADD(month,-12,MAX(DATEADD(month,-6,d.date)) over (partition by d.StageID)) then 1 end as dates
		from 
			data d
			join maxdate m on /*m.maxdate = d.Date and*/ m.StageID = d.StageID
	)a
	where
		dates = 1
		and date <= maxdate
)b
--where
	--sortorder is not null
--order by
	--StageID,datejoin,date,sortorder
GO


