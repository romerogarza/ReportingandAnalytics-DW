USE [PROJECTS]
GO
/****** Object:  StoredProcedure [BoardScorecard].[InfectionPreventionRYTDTrend_Update]    Script Date: 9/19/2023 9:29:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER procedure [BoardScorecard].[InfectionPreventionRYTDTrend_Update] as

BEGIN
	truncate table BoardScorecard.InfectionPreventionRYTDTrend
END
BEGIN
	insert into BoardScorecard.InfectionPreventionRYTDTrend
	select
		StageId
		,start_dt
		,end_dt
		,RYTD_SIR
		,getdate() as update_dt
	from(
		select
			1 as StageId
			,convert(date,('20'+right(start_dt,2)+'-'+left(start_dt,2)+'-01')) as start_dt
			,convert(date,('20'+right(end_dt,2)+'-'+left(end_dt,2)+'-01')) as end_dt
			,RYTD_SIR
		from(
			select
				case when len(start_dt) < 5 then CONCAT('0',start_dt) else start_dt end as start_dt
				,case when len(end_dt) < 5 then CONCAT('0',end_dt) else end_dt end as end_dt
				,RYTD_SIR
			from(
				select
					replace(left(replace([Time Frame],'RYTD ',''),5),'-','') as start_dt
					,replace(right(replace([Time Frame],'RYTD ',''),5),'-','') as end_dt
					,[RYTD SIR] as RYTD_SIR
				from 
					openrowset(
					'Microsoft.ACE.OLEDB.12.0',
					'Excel 8.0;HDR=YES;Database=\\nkch.org\shares\enterprise common area\ReportingAndAnalytics\scorecard\import\nkc_unit_scorecard_infection\Board_Scorecard_Data\BoardscorecardInfectionPreventionTrend.xlsx',
					'select * from [Colon$]')
				)a
			)a
		union all
		select
			2 as StageId
			,convert(date,('20'+right(start_dt,2)+'-'+left(start_dt,2)+'-01')) as start_dt
			,convert(date,('20'+right(end_dt,2)+'-'+left(end_dt,2)+'-01')) as end_dt
			,RYTD_SIR
		from(
			select
				case when len(start_dt) < 5 then CONCAT('0',start_dt) else start_dt end as start_dt
				,case when len(end_dt) < 5 then CONCAT('0',end_dt) else end_dt end as end_dt
				,RYTD_SIR
			from(
				select
					replace(left(replace([Time Frame],'RYTD ',''),5),'-','') as start_dt
					,replace(right(replace([Time Frame],'RYTD ',''),5),'-','') as end_dt
					,[RYTD SIR] as RYTD_SIR
				from 
					openrowset(
					'Microsoft.ACE.OLEDB.12.0',
					'Excel 8.0;HDR=YES;Database=\\nkch.org\shares\enterprise common area\ReportingAndAnalytics\scorecard\import\nkc_unit_scorecard_infection\Board_Scorecard_Data\BoardscorecardInfectionPreventionTrend.xlsx',
					'select * from [Hyster$]')
				)a
			)a
		union all
		select
			3 as StageId
			,convert(date,('20'+right(start_dt,2)+'-'+left(start_dt,2)+'-01')) as start_dt
			,convert(date,('20'+right(end_dt,2)+'-'+left(end_dt,2)+'-01')) as end_dt
			,RYTD_SIR
		from(
			select
				case when len(start_dt) < 5 then CONCAT('0',start_dt) else start_dt end as start_dt
				,case when len(end_dt) < 5 then CONCAT('0',end_dt) else end_dt end as end_dt
				,RYTD_SIR
			from(
				select
					replace(left(replace([Time Frame],'RYTD ',''),5),'-','') as start_dt
					,replace(right(replace([Time Frame],'RYTD ',''),5),'-','') as end_dt
					,[RYTD SIR] as RYTD_SIR
				from 
					openrowset(
					'Microsoft.ACE.OLEDB.12.0',
					'Excel 8.0;HDR=YES;Database=\\nkch.org\shares\enterprise common area\ReportingAndAnalytics\scorecard\import\nkc_unit_scorecard_infection\Board_Scorecard_Data\BoardscorecardInfectionPreventionTrend.xlsx',
					'select * from [CLABSI$]')
				)a
			)a
		union all
		select
			4 as StageId
			,convert(date,('20'+right(start_dt,2)+'-'+left(start_dt,2)+'-01')) as start_dt
			,convert(date,('20'+right(end_dt,2)+'-'+left(end_dt,2)+'-01')) as end_dt
			,RYTD_SIR
		from(
			select
				case when len(start_dt) < 5 then CONCAT('0',start_dt) else start_dt end as start_dt
				,case when len(end_dt) < 5 then CONCAT('0',end_dt) else end_dt end as end_dt
				,RYTD_SIR
			from(
				select
					replace(left(replace([Time Frame],'RYTD ',''),5),'-','') as start_dt
					,replace(right(replace([Time Frame],'RYTD ',''),5),'-','') as end_dt
					,[RYTD SIR] as RYTD_SIR
				from 
					openrowset(
					'Microsoft.ACE.OLEDB.12.0',
					'Excel 8.0;HDR=YES;Database=\\nkch.org\shares\enterprise common area\ReportingAndAnalytics\scorecard\import\nkc_unit_scorecard_infection\Board_Scorecard_Data\BoardscorecardInfectionPreventionTrend.xlsx',
					'select * from [CAUTI$]')
				)a
			)a
		union all
		select
			5 as StageId
			,convert(date,('20'+right(start_dt,2)+'-'+left(start_dt,2)+'-01')) as start_dt
			,convert(date,('20'+right(end_dt,2)+'-'+left(end_dt,2)+'-01')) as end_dt
			,RYTD_SIR
		from(
			select
				case when len(start_dt) < 5 then CONCAT('0',start_dt) else start_dt end as start_dt
				,case when len(end_dt) < 5 then CONCAT('0',end_dt) else end_dt end as end_dt
				,RYTD_SIR
			from(
				select
					replace(left(replace([Time Frame],'RYTD ',''),5),'-','') as start_dt
					,replace(right(replace([Time Frame],'RYTD ',''),5),'-','') as end_dt
					,[RYTD SIR] as RYTD_SIR
				from 
					openrowset(
					'Microsoft.ACE.OLEDB.12.0',
					'Excel 8.0;HDR=YES;Database=\\nkch.org\shares\enterprise common area\ReportingAndAnalytics\scorecard\import\nkc_unit_scorecard_infection\Board_Scorecard_Data\BoardscorecardInfectionPreventionTrend.xlsx',
					'select * from [MSRA$]')
				)a
			)a
		union all
		select
			6 as StageId
			,convert(date,('20'+right(start_dt,2)+'-'+left(start_dt,2)+'-01')) as start_dt
			,convert(date,('20'+right(end_dt,2)+'-'+left(end_dt,2)+'-01')) as end_dt
			,RYTD_SIR
		from(
			select
				case when len(start_dt) < 5 then CONCAT('0',start_dt) else start_dt end as start_dt
				,case when len(end_dt) < 5 then CONCAT('0',end_dt) else end_dt end as end_dt
				,RYTD_SIR
			from(
				select
					replace(left(replace([Time Frame],'RYTD ',''),5),'-','') as start_dt
					,replace(right(replace([Time Frame],'RYTD ',''),5),'-','') as end_dt
					,[RYTD SIR] as RYTD_SIR
				from 
					openrowset(
					'Microsoft.ACE.OLEDB.12.0',
					'Excel 8.0;HDR=YES;Database=\\nkch.org\shares\enterprise common area\ReportingAndAnalytics\scorecard\import\nkc_unit_scorecard_infection\Board_Scorecard_Data\BoardscorecardInfectionPreventionTrend.xlsx',
					'select * from [CDiff$]')
				)a
			)a
		)a
END