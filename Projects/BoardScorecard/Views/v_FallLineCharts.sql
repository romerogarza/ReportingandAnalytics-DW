USE [PROJECTS]
GO

/****** Object:  View [BoardScorecard].[v_FallLineCharts]    Script Date: 9/19/2023 9:19:12 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [BoardScorecard].[v_FallLineCharts] AS

WITH facFall AS(
	select 
		*
	from BoardScorecard.v_facfall
), CC /*StageID 9*/ as (
	select
		cast((cast(YEAR(FallDate) AS VARCHAR(4)) +'-'+CAST(MONTH(FallDate) AS VARCHAR(2)) + '-' + '01') as date) as Date
		,count(*) as Num
	from
		FacFall
	where
		CC = 1 AND Injured = 1
	group by
		cast((cast(YEAR(FallDate) AS VARCHAR(4)) +'-'+CAST(MONTH(FallDate) AS VARCHAR(2)) + '-' + '01') as date)
), InpatientDaysCC /*StageID 9*/ as (
	select
		cast((cast(YEAR(date) AS VARCHAR(4)) +'-'+CAST(MONTH(date) AS VARCHAR(2)) + '-' + '01') as date) as Date
		,sum([DAYS]) as Den
	from
		[BoardScorecard].[v_InpatientDays]
	where
		CC = 1
		AND date <= (select max(FallDate) from facFall)
	group by
		cast((cast(YEAR(date) AS VARCHAR(4)) +'-'+CAST(MONTH(date) AS VARCHAR(2)) + '-' + '01') as date)
), AC /*StageID 11*/ as (
	select
		cast((cast(YEAR(FallDate) AS VARCHAR(4)) +'-'+CAST(MONTH(FallDate) AS VARCHAR(2)) + '-' + '01') as date) as Date
		,count(*) as Num
	from
		FacFall
	where
		AC = 1 AND Injured = 1
	group by
		cast((cast(YEAR(FallDate) AS VARCHAR(4)) +'-'+CAST(MONTH(FallDate) AS VARCHAR(2)) + '-' + '01') as date)
), InpatientDaysAC /*StageID 11*/ as (
	select
		cast((cast(YEAR(date) AS VARCHAR(4)) +'-'+CAST(MONTH(date) AS VARCHAR(2)) + '-' + '01') as date) as Date
		,sum([DAYS]) as Den
	from
		[BoardScorecard].[v_InpatientDays]
	where
		AC = 1
		AND date <= (select max(FallDate) from facFall)
	group by
		cast((cast(YEAR(date) AS VARCHAR(4)) +'-'+CAST(MONTH(date) AS VARCHAR(2)) + '-' + '01') as date)
),TotalCC as (
	select
		cast((cast(YEAR(FallDate) AS VARCHAR(4)) +'-'+CAST(MONTH(FallDate) AS VARCHAR(2)) + '-' + '01') as date) as Date
		,count(*) as Num
	from
		FacFall
	where
		CC = 1
	group by
		cast((cast(YEAR(FallDate) AS VARCHAR(4)) +'-'+CAST(MONTH(FallDate) AS VARCHAR(2)) + '-' + '01') as date)
), TotalAC as (
	select
		cast((cast(YEAR(FallDate) AS VARCHAR(4)) +'-'+CAST(MONTH(FallDate) AS VARCHAR(2)) + '-' + '01') as date) as Date
		,count(*) as Num
	from
		FacFall
	where
		AC = 1
	group by
		cast((cast(YEAR(FallDate) AS VARCHAR(4)) +'-'+CAST(MONTH(FallDate) AS VARCHAR(2)) + '-' + '01') as date)
)
select
	*
from(
	/*Month 1*/
	select 
		StageID
		,Date
		,Value
		,DATEADD(month,1,DateJoin) as DateJoin
		,case 
			when Date = DateJoin then 1 when Date = DATEADD(month,-1,DateJoin) then 2 
			when Date = DATEADD(month,-2,DateJoin) then 3 when Date = DATEADD(month,-3,DateJoin) then 4
			when Date = DATEADD(month,-4,DateJoin) then 5 when Date = DATEADD(month,-5,DateJoin) then 6
			when Date = DATEADD(month,-6,DateJoin) then 7 when Date = DATEADD(month,-7,DateJoin) then 8
			when Date = DATEADD(month,-8,DateJoin) then 9 when Date = DATEADD(month,-9,DateJoin) then 10
			when Date = DATEADD(month,-10,DateJoin) then 11 when Date = DATEADD(month,-11,DateJoin) then 12
			end as sortorder
	from(
		select
			case when date > DATEADD(month,-13,MAX(Date) over (partition by StageID)) then 1 end as dates
			,a.*
			,max(date) over (partition by StageID) as Datejoin
		from (
			/*Line Chart for Total Falls/1000 Patient Days (AC)*/
			select 
				10 as StageID
				,InpatientDaysAC.Date
				,case when round(cast(TotalAC.Num as float)/(cast(InpatientDaysAC.Den as float)/cast(1000 as float)),2) is null
					then 0 else round(cast(TotalAC.Num as float)/(cast(InpatientDaysAC.Den as float)/cast(1000 as float)),2) end as value
			from 
				InpatientDaysAC
				left join TotalAC on TotalAC.Date = InpatientDaysAC.Date 
			UNION ALL
			/*Line Chart for Total Falls/1000 Patient Days (CC)*/
			select 
				8 as StageID
				,InpatientDaysCC.Date
				,case when round(cast(TotalCC.Num as float)/(cast(InpatientDaysCC.Den as float)/cast(1000 as float)),2) is null
					then 0 else round(cast(TotalCC.Num as float)/(cast(InpatientDaysCC.Den as float)/cast(1000 as float)),2) end as value
			from 
				InpatientDaysCC
				left join TotalCC on TotalCC.Date = InpatientDaysCC.Date
			UNION ALL
			/*Line Chart for Total Falls with Injury/1000 Patient Days (AC)*/
			select 
				11 as StageID
				,InpatientDaysAC.Date
				,case when round(cast(AC.Num as float)/(cast(InpatientDaysAC.Den as float)/cast(1000 as float)),2) is null
					then 0 else round(cast(AC.Num as float)/(cast(InpatientDaysAC.Den as float)/cast(1000 as float)),2) end as value
			from 
				InpatientDaysAC
				left join AC on AC.Date = InpatientDaysAC.Date 
			UNION ALL
			/*Line Chart for Total Falls with Injury/1000 Patient Days (CC)*/
			select 
				9 as StageID
				,InpatientDaysCC.Date
				,case when round(cast(cc.Num as float)/(cast(InpatientDaysCC.Den as float)/cast(1000 as float)),2) is null
					then 0 else round(cast(cc.Num as float)/(cast(InpatientDaysCC.Den as float)/cast(1000 as float)),2) end as value
			from 
				InpatientDaysCC
				left join CC on CC.Date = InpatientDaysCC.Date
		)a
		group by
			StageID
			,Date
			,Value
	)b
	where
		b.dates = 1
	UNION ALL
	/*Month 2*/
	select 
		StageID
		,Date
		,Value
		,DATEADD(month,1,DateJoin) as DateJoin
		,case 
			when Date = DateJoin then 1 when Date = DATEADD(month,-1,DateJoin) then 2 
			when Date = DATEADD(month,-2,DateJoin) then 3 when Date = DATEADD(month,-3,DateJoin) then 4
			when Date = DATEADD(month,-4,DateJoin) then 5 when Date = DATEADD(month,-5,DateJoin) then 6
			when Date = DATEADD(month,-6,DateJoin) then 7 when Date = DATEADD(month,-7,DateJoin) then 8
			when Date = DATEADD(month,-8,DateJoin) then 9 when Date = DATEADD(month,-9,DateJoin) then 10
			when Date = DATEADD(month,-10,DateJoin) then 11 when Date = DATEADD(month,-11,DateJoin) then 12
			end as sortorder
	from(
		select
			case when date > DATEADD(month,-10,DATEADD(month,-1,MAX(Date) over (partition by StageID))) then 1 end as dates
			,a.*
			,DATEADD(month,-1,max(date) over (partition by StageID)) as Datejoin
		from (
			/*Line Chart for Total Falls/1000 Patient Days (AC)*/
			select 
				10 as StageID
				,InpatientDaysAC.Date
				,case when round(cast(TotalAC.Num as float)/(cast(InpatientDaysAC.Den as float)/cast(1000 as float)),2) is null
					then 0 else round(cast(TotalAC.Num as float)/(cast(InpatientDaysAC.Den as float)/cast(1000 as float)),2) end as value
			from 
				InpatientDaysAC
				left join TotalAC on TotalAC.Date = InpatientDaysAC.Date 
			UNION ALL
			/*Line Chart for Total Falls/1000 Patient Days (CC)*/
			select 
				8 as StageID
				,InpatientDaysCC.Date
				,case when round(cast(TotalCC.Num as float)/(cast(InpatientDaysCC.Den as float)/cast(1000 as float)),2) is null
					then 0 else round(cast(TotalCC.Num as float)/(cast(InpatientDaysCC.Den as float)/cast(1000 as float)),2) end as value
			from 
				InpatientDaysCC
				left join TotalCC on TotalCC.Date = InpatientDaysCC.Date
			UNION ALL
			/*Line Chart for Total Falls with Injury/1000 Patient Days (AC)*/
			select 
				11 as StageID
				,InpatientDaysAC.Date
				,case when round(cast(AC.Num as float)/(cast(InpatientDaysAC.Den as float)/cast(1000 as float)),2) is null
					then 0 else round(cast(AC.Num as float)/(cast(InpatientDaysAC.Den as float)/cast(1000 as float)),2) end as value
			from 
				InpatientDaysAC
				left join AC on AC.Date = InpatientDaysAC.Date 
			UNION ALL
			/*Line Chart for Total Falls with Injury/1000 Patient Days (CC)*/
			select 
				9 as StageID
				,InpatientDaysCC.Date
				,case when round(cast(cc.Num as float)/(cast(InpatientDaysCC.Den as float)/cast(1000 as float)),2) is null
					then 0 else round(cast(cc.Num as float)/(cast(InpatientDaysCC.Den as float)/cast(1000 as float)),2) end as value
			from 
				InpatientDaysCC
				left join CC on CC.Date = InpatientDaysCC.Date
		)a
		group by
			StageID
			,Date
			,Value
	)b
	where
		b.dates = 1
		AND b.Date <= b.Datejoin
	UNION ALL
	/*Month 3*/
	select 
		StageID
		,Date
		,Value
		,DATEADD(month,1,DateJoin) as DateJoin
		,case 
			when Date = DateJoin then 1 when Date = DATEADD(month,-1,DateJoin) then 2 
			when Date = DATEADD(month,-2,DateJoin) then 3 when Date = DATEADD(month,-3,DateJoin) then 4
			when Date = DATEADD(month,-4,DateJoin) then 5 when Date = DATEADD(month,-5,DateJoin) then 6
			when Date = DATEADD(month,-6,DateJoin) then 7 when Date = DATEADD(month,-7,DateJoin) then 8
			when Date = DATEADD(month,-8,DateJoin) then 9 when Date = DATEADD(month,-9,DateJoin) then 10
			when Date = DATEADD(month,-10,DateJoin) then 11 when Date = DATEADD(month,-11,DateJoin) then 12
			end as sortorder
	from(
		select
			case when date > DATEADD(month,-10,DATEADD(month,-2,MAX(Date) over (partition by StageID))) then 1 end as dates
			,a.*
			,DATEADD(month,-2,max(date) over (partition by StageID)) as Datejoin
		from (
			/*Line Chart for Total Falls/1000 Patient Days (AC)*/
			select 
				10 as StageID
				,InpatientDaysAC.Date
				,case when round(cast(TotalAC.Num as float)/(cast(InpatientDaysAC.Den as float)/cast(1000 as float)),2) is null
					then 0 else round(cast(TotalAC.Num as float)/(cast(InpatientDaysAC.Den as float)/cast(1000 as float)),2) end as value
			from 
				InpatientDaysAC
				left join TotalAC on TotalAC.Date = InpatientDaysAC.Date 
			UNION ALL
			/*Line Chart for Total Falls/1000 Patient Days (CC)*/
			select 
				8 as StageID
				,InpatientDaysCC.Date
				,case when round(cast(TotalCC.Num as float)/(cast(InpatientDaysCC.Den as float)/cast(1000 as float)),2) is null
					then 0 else round(cast(TotalCC.Num as float)/(cast(InpatientDaysCC.Den as float)/cast(1000 as float)),2) end as value
			from 
				InpatientDaysCC
				left join TotalCC on TotalCC.Date = InpatientDaysCC.Date
			UNION ALL
			/*Line Chart for Total Falls with Injury/1000 Patient Days (AC)*/
			select 
				11 as StageID
				,InpatientDaysAC.Date
				,case when round(cast(AC.Num as float)/(cast(InpatientDaysAC.Den as float)/cast(1000 as float)),2) is null
					then 0 else round(cast(AC.Num as float)/(cast(InpatientDaysAC.Den as float)/cast(1000 as float)),2) end as value
			from 
				InpatientDaysAC
				left join AC on AC.Date = InpatientDaysAC.Date 
			UNION ALL
			/*Line Chart for Total Falls with Injury/1000 Patient Days (CC)*/
			select 
				9 as StageID
				,InpatientDaysCC.Date
				,case when round(cast(cc.Num as float)/(cast(InpatientDaysCC.Den as float)/cast(1000 as float)),2) is null
					then 0 else round(cast(cc.Num as float)/(cast(InpatientDaysCC.Den as float)/cast(1000 as float)),2) end as value
			from 
				InpatientDaysCC
				left join CC on CC.Date = InpatientDaysCC.Date
		)a
		group by
			StageID
			,Date
			,Value
	)b
	where
		b.dates = 1
		AND b.Date <= b.Datejoin
	UNION ALL
	/*Month 4*/
	select 
		StageID
		,Date
		,Value
		,DATEADD(month,1,DateJoin) as DateJoin
		,case 
			when Date = DateJoin then 1 when Date = DATEADD(month,-1,DateJoin) then 2 
			when Date = DATEADD(month,-2,DateJoin) then 3 when Date = DATEADD(month,-3,DateJoin) then 4
			when Date = DATEADD(month,-4,DateJoin) then 5 when Date = DATEADD(month,-5,DateJoin) then 6
			when Date = DATEADD(month,-6,DateJoin) then 7 when Date = DATEADD(month,-7,DateJoin) then 8
			when Date = DATEADD(month,-8,DateJoin) then 9 when Date = DATEADD(month,-9,DateJoin) then 10
			when Date = DATEADD(month,-10,DateJoin) then 11 when Date = DATEADD(month,-11,DateJoin) then 12
			end as sortorder
	from(
		select
			case when date > DATEADD(month,-10,DATEADD(month,-3,MAX(Date) over (partition by StageID))) then 1 end as dates
			,a.*
			,DATEADD(month,-3,max(date) over (partition by StageID)) as Datejoin
		from (
			/*Line Chart for Total Falls/1000 Patient Days (AC)*/
			select 
				10 as StageID
				,InpatientDaysAC.Date
				,case when round(cast(TotalAC.Num as float)/(cast(InpatientDaysAC.Den as float)/cast(1000 as float)),2) is null
					then 0 else round(cast(TotalAC.Num as float)/(cast(InpatientDaysAC.Den as float)/cast(1000 as float)),2) end as value
			from 
				InpatientDaysAC
				left join TotalAC on TotalAC.Date = InpatientDaysAC.Date 
			UNION ALL
			/*Line Chart for Total Falls/1000 Patient Days (CC)*/
			select 
				8 as StageID
				,InpatientDaysCC.Date
				,case when round(cast(TotalCC.Num as float)/(cast(InpatientDaysCC.Den as float)/cast(1000 as float)),2) is null
					then 0 else round(cast(TotalCC.Num as float)/(cast(InpatientDaysCC.Den as float)/cast(1000 as float)),2) end as value
			from 
				InpatientDaysCC
				left join TotalCC on TotalCC.Date = InpatientDaysCC.Date
			UNION ALL
			/*Line Chart for Total Falls with Injury/1000 Patient Days (AC)*/
			select 
				11 as StageID
				,InpatientDaysAC.Date
				,case when round(cast(AC.Num as float)/(cast(InpatientDaysAC.Den as float)/cast(1000 as float)),2) is null
					then 0 else round(cast(AC.Num as float)/(cast(InpatientDaysAC.Den as float)/cast(1000 as float)),2) end as value
			from 
				InpatientDaysAC
				left join AC on AC.Date = InpatientDaysAC.Date 
			UNION ALL
			/*Line Chart for Total Falls with Injury/1000 Patient Days (CC)*/
			select 
				9 as StageID
				,InpatientDaysCC.Date
				,case when round(cast(cc.Num as float)/(cast(InpatientDaysCC.Den as float)/cast(1000 as float)),2) is null
					then 0 else round(cast(cc.Num as float)/(cast(InpatientDaysCC.Den as float)/cast(1000 as float)),2) end as value
			from 
				InpatientDaysCC
				left join CC on CC.Date = InpatientDaysCC.Date
		)a
		group by
			StageID
			,Date
			,Value
	)b
	where
		b.dates = 1
		AND b.Date <= b.Datejoin
	UNION ALL
	/*Month 5*/
	select 
		StageID
		,Date
		,Value
		,DATEADD(month,1,DateJoin) as DateJoin
		,case 
			when Date = DateJoin then 1 when Date = DATEADD(month,-1,DateJoin) then 2 
			when Date = DATEADD(month,-2,DateJoin) then 3 when Date = DATEADD(month,-3,DateJoin) then 4
			when Date = DATEADD(month,-4,DateJoin) then 5 when Date = DATEADD(month,-5,DateJoin) then 6
			when Date = DATEADD(month,-6,DateJoin) then 7 when Date = DATEADD(month,-7,DateJoin) then 8
			when Date = DATEADD(month,-8,DateJoin) then 9 when Date = DATEADD(month,-9,DateJoin) then 10
			when Date = DATEADD(month,-10,DateJoin) then 11 when Date = DATEADD(month,-11,DateJoin) then 12
			end as sortorder
	from(
		select
			case when date > DATEADD(month,-10,DATEADD(month,-4,MAX(Date) over (partition by StageID))) then 1 end as dates
			,a.*
			,DATEADD(month,-4,max(date) over (partition by StageID)) as Datejoin
		from (
			/*Line Chart for Total Falls/1000 Patient Days (AC)*/
			select 
				10 as StageID
				,InpatientDaysAC.Date
				,case when round(cast(TotalAC.Num as float)/(cast(InpatientDaysAC.Den as float)/cast(1000 as float)),2) is null
					then 0 else round(cast(TotalAC.Num as float)/(cast(InpatientDaysAC.Den as float)/cast(1000 as float)),2) end as value
			from 
				InpatientDaysAC
				left join TotalAC on TotalAC.Date = InpatientDaysAC.Date 
			UNION ALL
			/*Line Chart for Total Falls/1000 Patient Days (CC)*/
			select 
				8 as StageID
				,InpatientDaysCC.Date
				,case when round(cast(TotalCC.Num as float)/(cast(InpatientDaysCC.Den as float)/cast(1000 as float)),2) is null
					then 0 else round(cast(TotalCC.Num as float)/(cast(InpatientDaysCC.Den as float)/cast(1000 as float)),2) end as value
			from 
				InpatientDaysCC
				left join TotalCC on TotalCC.Date = InpatientDaysCC.Date
			UNION ALL
			/*Line Chart for Total Falls with Injury/1000 Patient Days (AC)*/
			select 
				11 as StageID
				,InpatientDaysAC.Date
				,case when round(cast(AC.Num as float)/(cast(InpatientDaysAC.Den as float)/cast(1000 as float)),2) is null
					then 0 else round(cast(AC.Num as float)/(cast(InpatientDaysAC.Den as float)/cast(1000 as float)),2) end as value
			from 
				InpatientDaysAC
				left join AC on AC.Date = InpatientDaysAC.Date 
			UNION ALL
			/*Line Chart for Total Falls with Injury/1000 Patient Days (CC)*/
			select 
				9 as StageID
				,InpatientDaysCC.Date
				,case when round(cast(cc.Num as float)/(cast(InpatientDaysCC.Den as float)/cast(1000 as float)),2) is null
					then 0 else round(cast(cc.Num as float)/(cast(InpatientDaysCC.Den as float)/cast(1000 as float)),2) end as value
			from 
				InpatientDaysCC
				left join CC on CC.Date = InpatientDaysCC.Date
		)a
		group by
			StageID
			,Date
			,Value
	)b
	where
		b.dates = 1
		AND b.Date <= b.Datejoin
	UNION ALL
	/*Month 6*/
	select 
		StageID
		,Date
		,Value
		,DATEADD(month,1,DateJoin) as DateJoin
		,case 
			when Date = DateJoin then 1 when Date = DATEADD(month,-1,DateJoin) then 2 
			when Date = DATEADD(month,-2,DateJoin) then 3 when Date = DATEADD(month,-3,DateJoin) then 4
			when Date = DATEADD(month,-4,DateJoin) then 5 when Date = DATEADD(month,-5,DateJoin) then 6
			when Date = DATEADD(month,-6,DateJoin) then 7 when Date = DATEADD(month,-7,DateJoin) then 8
			when Date = DATEADD(month,-8,DateJoin) then 9 when Date = DATEADD(month,-9,DateJoin) then 10
			when Date = DATEADD(month,-10,DateJoin) then 11 when Date = DATEADD(month,-11,DateJoin) then 12
			end as sortorder
	from(
		select
			case when date > DATEADD(month,-10,DATEADD(month,-5,MAX(Date) over (partition by StageID))) then 1 end as dates
			,a.*
			,DATEADD(month,-5,max(date) over (partition by StageID)) as Datejoin
		from (
			/*Line Chart for Total Falls/1000 Patient Days (AC)*/
			select 
				10 as StageID
				,InpatientDaysAC.Date
				,case when round(cast(TotalAC.Num as float)/(cast(InpatientDaysAC.Den as float)/cast(1000 as float)),2) is null
					then 0 else round(cast(TotalAC.Num as float)/(cast(InpatientDaysAC.Den as float)/cast(1000 as float)),2) end as value
			from 
				InpatientDaysAC
				left join TotalAC on TotalAC.Date = InpatientDaysAC.Date 
			UNION ALL
			/*Line Chart for Total Falls/1000 Patient Days (CC)*/
			select 
				8 as StageID
				,InpatientDaysCC.Date
				,case when round(cast(TotalCC.Num as float)/(cast(InpatientDaysCC.Den as float)/cast(1000 as float)),2) is null
					then 0 else round(cast(TotalCC.Num as float)/(cast(InpatientDaysCC.Den as float)/cast(1000 as float)),2) end as value
			from 
				InpatientDaysCC
				left join TotalCC on TotalCC.Date = InpatientDaysCC.Date
			UNION ALL
			/*Line Chart for Total Falls with Injury/1000 Patient Days (AC)*/
			select 
				11 as StageID
				,InpatientDaysAC.Date
				,case when round(cast(AC.Num as float)/(cast(InpatientDaysAC.Den as float)/cast(1000 as float)),2) is null
					then 0 else round(cast(AC.Num as float)/(cast(InpatientDaysAC.Den as float)/cast(1000 as float)),2) end as value
			from 
				InpatientDaysAC
				left join AC on AC.Date = InpatientDaysAC.Date 
			UNION ALL
			/*Line Chart for Total Falls with Injury/1000 Patient Days (CC)*/
			select 
				9 as StageID
				,InpatientDaysCC.Date
				,case when round(cast(cc.Num as float)/(cast(InpatientDaysCC.Den as float)/cast(1000 as float)),2) is null
					then 0 else round(cast(cc.Num as float)/(cast(InpatientDaysCC.Den as float)/cast(1000 as float)),2) end as value
			from 
				InpatientDaysCC
				left join CC on CC.Date = InpatientDaysCC.Date
		)a
		group by
			StageID
			,Date
			,Value
	)b
	where
		b.dates = 1
		AND b.Date <= b.Datejoin
	UNION ALL
	/*Month 7*/
	select 
		StageID
		,Date
		,Value
		,DATEADD(month,1,DateJoin) as DateJoin
		,case 
			when Date = DateJoin then 1 when Date = DATEADD(month,-1,DateJoin) then 2 
			when Date = DATEADD(month,-2,DateJoin) then 3 when Date = DATEADD(month,-3,DateJoin) then 4
			when Date = DATEADD(month,-4,DateJoin) then 5 when Date = DATEADD(month,-5,DateJoin) then 6
			when Date = DATEADD(month,-6,DateJoin) then 7 when Date = DATEADD(month,-7,DateJoin) then 8
			when Date = DATEADD(month,-8,DateJoin) then 9 when Date = DATEADD(month,-9,DateJoin) then 10
			when Date = DATEADD(month,-10,DateJoin) then 11 when Date = DATEADD(month,-11,DateJoin) then 12
			end as sortorder
	from(
		select
			case when date > DATEADD(month,-10,DATEADD(month,-6,MAX(Date) over (partition by StageID))) then 1 end as dates
			,a.*
			,DATEADD(month,-6,max(date) over (partition by StageID)) as Datejoin
		from (
			/*Line Chart for Total Falls/1000 Patient Days (AC)*/
			select 
				10 as StageID
				,InpatientDaysAC.Date
				,case when round(cast(TotalAC.Num as float)/(cast(InpatientDaysAC.Den as float)/cast(1000 as float)),2) is null
					then 0 else round(cast(TotalAC.Num as float)/(cast(InpatientDaysAC.Den as float)/cast(1000 as float)),2) end as value
			from 
				InpatientDaysAC
				left join TotalAC on TotalAC.Date = InpatientDaysAC.Date 
			UNION ALL
			/*Line Chart for Total Falls/1000 Patient Days (CC)*/
			select 
				8 as StageID
				,InpatientDaysCC.Date
				,case when round(cast(TotalCC.Num as float)/(cast(InpatientDaysCC.Den as float)/cast(1000 as float)),2) is null
					then 0 else round(cast(TotalCC.Num as float)/(cast(InpatientDaysCC.Den as float)/cast(1000 as float)),2) end as value
			from 
				InpatientDaysCC
				left join TotalCC on TotalCC.Date = InpatientDaysCC.Date
			UNION ALL
			/*Line Chart for Total Falls with Injury/1000 Patient Days (AC)*/
			select 
				11 as StageID
				,InpatientDaysAC.Date
				,case when round(cast(AC.Num as float)/(cast(InpatientDaysAC.Den as float)/cast(1000 as float)),2) is null
					then 0 else round(cast(AC.Num as float)/(cast(InpatientDaysAC.Den as float)/cast(1000 as float)),2) end as value
			from 
				InpatientDaysAC
				left join AC on AC.Date = InpatientDaysAC.Date 
			UNION ALL
			/*Line Chart for Total Falls with Injury/1000 Patient Days (CC)*/
			select 
				9 as StageID
				,InpatientDaysCC.Date
				,case when round(cast(cc.Num as float)/(cast(InpatientDaysCC.Den as float)/cast(1000 as float)),2) is null
					then 0 else round(cast(cc.Num as float)/(cast(InpatientDaysCC.Den as float)/cast(1000 as float)),2) end as value
			from 
				InpatientDaysCC
				left join CC on CC.Date = InpatientDaysCC.Date
		)a
		group by
			StageID
			,Date
			,Value
	)b
	where
		b.dates = 1
		AND b.Date <= b.Datejoin
	UNION ALL
	/*Month 8*/
	select 
		StageID
		,Date
		,Value
		,DATEADD(month,1,DateJoin) as DateJoin
		,case 
			when Date = DateJoin then 1 when Date = DATEADD(month,-1,DateJoin) then 2 
			when Date = DATEADD(month,-2,DateJoin) then 3 when Date = DATEADD(month,-3,DateJoin) then 4
			when Date = DATEADD(month,-4,DateJoin) then 5 when Date = DATEADD(month,-5,DateJoin) then 6
			when Date = DATEADD(month,-6,DateJoin) then 7 when Date = DATEADD(month,-7,DateJoin) then 8
			when Date = DATEADD(month,-8,DateJoin) then 9 when Date = DATEADD(month,-9,DateJoin) then 10
			when Date = DATEADD(month,-10,DateJoin) then 11 when Date = DATEADD(month,-11,DateJoin) then 12
			end as sortorder
	from(
		select
			case when date > DATEADD(month,-10,DATEADD(month,-7,MAX(Date) over (partition by StageID))) then 1 end as dates
			,a.*
			,DATEADD(month,-7,max(date) over (partition by StageID)) as Datejoin
		from (
			/*Line Chart for Total Falls/1000 Patient Days (AC)*/
			select 
				10 as StageID
				,InpatientDaysAC.Date
				,case when round(cast(TotalAC.Num as float)/(cast(InpatientDaysAC.Den as float)/cast(1000 as float)),2) is null
					then 0 else round(cast(TotalAC.Num as float)/(cast(InpatientDaysAC.Den as float)/cast(1000 as float)),2) end as value
			from 
				InpatientDaysAC
				left join TotalAC on TotalAC.Date = InpatientDaysAC.Date 
			UNION ALL
			/*Line Chart for Total Falls/1000 Patient Days (CC)*/
			select 
				8 as StageID
				,InpatientDaysCC.Date
				,case when round(cast(TotalCC.Num as float)/(cast(InpatientDaysCC.Den as float)/cast(1000 as float)),2) is null
					then 0 else round(cast(TotalCC.Num as float)/(cast(InpatientDaysCC.Den as float)/cast(1000 as float)),2) end as value
			from 
				InpatientDaysCC
				left join TotalCC on TotalCC.Date = InpatientDaysCC.Date
			UNION ALL
			/*Line Chart for Total Falls with Injury/1000 Patient Days (AC)*/
			select 
				11 as StageID
				,InpatientDaysAC.Date
				,case when round(cast(AC.Num as float)/(cast(InpatientDaysAC.Den as float)/cast(1000 as float)),2) is null
					then 0 else round(cast(AC.Num as float)/(cast(InpatientDaysAC.Den as float)/cast(1000 as float)),2) end as value
			from 
				InpatientDaysAC
				left join AC on AC.Date = InpatientDaysAC.Date 
			UNION ALL
			/*Line Chart for Total Falls with Injury/1000 Patient Days (CC)*/
			select 
				9 as StageID
				,InpatientDaysCC.Date
				,case when round(cast(cc.Num as float)/(cast(InpatientDaysCC.Den as float)/cast(1000 as float)),2) is null
					then 0 else round(cast(cc.Num as float)/(cast(InpatientDaysCC.Den as float)/cast(1000 as float)),2) end as value
			from 
				InpatientDaysCC
				left join CC on CC.Date = InpatientDaysCC.Date
		)a
		group by
			StageID
			,Date
			,Value
	)b
	where
		b.dates = 1
		AND b.Date <= b.Datejoin
)c
where
	sortorder <> 0
GO


