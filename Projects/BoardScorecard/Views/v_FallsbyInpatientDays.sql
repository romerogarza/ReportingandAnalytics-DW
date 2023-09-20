USE [PROJECTS]
GO

/****** Object:  View [BoardScorecard].[v_FallsbyInpatientDays]    Script Date: 9/19/2023 9:19:49 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [BoardScorecard].[v_FallsbyInpatientDays] AS

select
	DATEADD(month,1,c.date) as date
	,c.date as datedisplay
	,c.[TotalFallsby1000PatientDaysCCValue]
	,c.[TotalFallsby1000PatientDaysACValue]
	,c.[TotalFallswithInjuryby1000PatientDaysCCValue]
	,c.[TotalFallswithInjuryby1000PatientDaysACValue]
	,round(cast(left(cast(convert(float,((sum([CC_num]) over (partition by YEAR(dateadd(month,-6,date)) order by date))
		/ NULLIF((sum(CC_den_total) over (partition by YEAR(dateadd(month,-6,date)) order by date)),0))*1000) as varchar(max)),5) as float),2) as [TotalFallsby1000PatientDaysCCFYTD]
	,round(cast(left(cast(convert(float,((sum(AC_num) over (partition by YEAR(dateadd(month,-6,date)) order by date))
		/ NULLIF((sum(AC_den_total) over (partition by YEAR(dateadd(month,-6,date)) order by date)),0))*1000) as varchar(max)),5) as float),2) as [TotalFallsby1000PatientDaysACFYTD]
	,round(cast(left(cast(convert(float,((sum(CC_num2) over (partition by YEAR(dateadd(month,-6,date)) order by date))
		/ NULLIF((sum(CC_den_total) over (partition by YEAR(dateadd(month,-6,date)) order by date)),0))*1000) as varchar(max)),5) as float),2) as [TotalFallswithInjuryby1000PatientDaysCCFYTD]
	,round(cast(left(cast(convert(float,((sum(AC_num2) over (partition by YEAR(dateadd(month,-6,date)) order by date))
		/ NULLIF((sum(AC_den_total) over (partition by YEAR(dateadd(month,-6,date)) order by date)),0))*1000) as varchar(max)),5) as float),2) as [TotalFallswithInjuryby1000PatientDaysACFYTD]
from(
	select
		p.date
		,case when cc.CC_num is null then 0 else cc.CC_num end as CC_num
		,case when cc.AC_num is null then 0 else cc.AC_num end as AC_num
		,case when cc.CC_num2 is null then 0 else cc.CC_num2 end as CC_num2
		,case when cc.AC_num2 is null then 0 else cc.AC_num2 end as AC_num2
		,case when p.CC_den_total is null then 0 else p.CC_den_total end as CC_den_total
		,case when p.AC_den_total is null then 0 else p.AC_den_total end as AC_den_total
		,round(case when cc.CC_num/p.CC_den is null then 0 else cc.CC_num/p.CC_den end,2) as [TotalFallsby1000PatientDaysCCValue]
		,round(case when cc.AC_num/p.AC_den is null then 0 else cc.AC_num/p.AC_den end,2) as [TotalFallsby1000PatientDaysACValue]
		,round(case when cc.CC_num2/p.CC_den is null then 0 else cc.CC_num2/p.CC_den end,2) as [TotalFallswithInjuryby1000PatientDaysCCValue]
		,round(case when cc.AC_num2/p.AC_den is null then 0 else cc.AC_num2/p.AC_den end,2) as [TotalFallswithInjuryby1000PatientDaysACValue]
	from(
		select
			CONVERT(DATE, CONVERT(VARCHAR(7), Date, 120) + '-01') as Date
			,cast(sum(case when f.CC = 1 then f.DAYS end) as float)/cast(1000 as float) as CC_den
			,cast(sum(case when f.AC = 1 then f.DAYS end) as float)/cast(1000 as float) as AC_den
			,cast(sum(case when f.CC = 1 then f.DAYS end) as float) as CC_den_total
			,cast(sum(case when f.AC = 1 then f.DAYS end) as float) as AC_den_total
		from
			BoardScorecard.v_InpatientDays f
		group by
			CONVERT(DATE, CONVERT(VARCHAR(7), Date, 120) + '-01')
	)p
		left join (
	select
		CONVERT(DATE, CONVERT(VARCHAR(7), b.FallDate, 120) + '-01') as Date
		,SUM(case when b.CC = 1 then 1 end) as CC_num
		,SUM(case when b.AC = 1 then 1 end) as AC_num
		,SUM(case when b.CC = 1 AND b.Injured = 1 then 1 end) as CC_num2
		,SUM(case when b.AC = 1 AND b.Injured = 1 then 1 end) as AC_num2
	from(
		select 
			* 
		from(
			select 
				f.* 
				,case when FallUnitID in (682892/*CICU*/,684077/*ICU*/,43697268, 43697343 /*CVICU*/) then 1 else 0 end as CC
				,case when FallUnitID in (683967,684032/*5 Main*/,683830,683748/*6 Main*/,3988703,3988806/*8 HSP*/,4226472,4226583,4226667/*9 HSP*/,
					17471097,17471229/*10 HSP*/,682807,682766/*10 Main*/,683418,682686/*11 Main*/) then 1 else 0 end as AC
				,case when FallRelatedInjury in ('Minor','Moderate','Major') then 1 else 0 end as Injured
			from 
				(
					select * from UnitScorecard.facFall_1
					union all
					select * from UnitScorecard.facFall_2
				)f
		)a
		where 
			a.CC = 1 or a.AC = 1
	)b
	group by
		CONVERT(DATE, CONVERT(VARCHAR(7), b.FallDate, 120) + '-01')
	)cc on cc.Date = p.Date
)c
GO


