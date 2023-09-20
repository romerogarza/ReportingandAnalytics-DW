USE [PROJECTS]
GO
/****** Object:  StoredProcedure [BoardScorecard].[InfectionPrevention_Update]    Script Date: 9/19/2023 9:29:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [BoardScorecard].[InfectionPrevention_Update] AS

BEGIN
	drop table if exists #stage
	create table #stage (
		[Procedure Code] varchar(50)
		,[Date] datetime
		,[Value] varchar(10)
		,[FYTD] varchar(10)
	)

	insert into #stage
	select
		'COLO' as [Procedure Code]
		,dateadd(month,2,[Date]) as [Date]
		,[Value]
		,[SIRComplex30d]
	from
		openrowset(
		'Microsoft.ACE.OLEDB.12.0',
		'Excel 8.0;HDR=YES;Database=\\nkch.org\shares\enterprise common area\ReportingAndAnalytics\scorecard\import\nkc_unit_scorecard_infection\Board_Scorecard_Data\BoardScorecardInfectionPrevention.xlsx',
		'select * from [SSI_COLO$]')
	where
		[Date] is not null
	insert into #stage
	select
		'HYST' as [Procedure Code]
		,dateadd(month,2,[Date]) as [Date]
		,[Value]
		,[SIRComplex30d]
	from
		openrowset(
		'Microsoft.ACE.OLEDB.12.0',
		'Excel 8.0;HDR=YES;Database=\\nkch.org\shares\enterprise common area\ReportingAndAnalytics\scorecard\import\nkc_unit_scorecard_infection\Board_Scorecard_Data\BoardScorecardInfectionPrevention.xlsx',
		'select * from [SSI_HYST$]')
	where
		[Date] is not null
	insert into #stage
	select
		'CLAB' as [Procedure Code]
		,dateadd(month,2,[Date]) as [Date]
		,[Value]
		,[SIR]
	from
		openrowset(
		'Microsoft.ACE.OLEDB.12.0',
		'Excel 8.0;HDR=YES;Database=\\nkch.org\shares\enterprise common area\ReportingAndAnalytics\scorecard\import\nkc_unit_scorecard_infection\Board_Scorecard_Data\BoardScorecardInfectionPrevention.xlsx',
		'select * from [CLAB$]')
	where
		[Date] is not null
	insert into #stage
	select
		'CAUTI' as [Procedure Code]
		,dateadd(month,2,[Date]) as [Date]
		,[Value]
		,[SIR]
	from
		openrowset(
		'Microsoft.ACE.OLEDB.12.0',
		'Excel 8.0;HDR=YES;Database=\\nkch.org\shares\enterprise common area\ReportingAndAnalytics\scorecard\import\nkc_unit_scorecard_infection\Board_Scorecard_Data\BoardScorecardInfectionPrevention.xlsx',
		'select * from [CAUTI$]')
	where
		[Date] is not null
	insert into #stage
	select
		'MRSA' as [Procedure Code]
		,dateadd(month,2,[Date]) as [Date]
		,[Value]
		,[SIR]
	from
		openrowset(
		'Microsoft.ACE.OLEDB.12.0',
		'Excel 8.0;HDR=YES;Database=\\nkch.org\shares\enterprise common area\ReportingAndAnalytics\scorecard\import\nkc_unit_scorecard_infection\Board_Scorecard_Data\BoardScorecardInfectionPrevention.xlsx',
		'select * from [MRSA$]')
	where
		[Date] is not null
	insert into #stage
	select
		'CDIF' as [Procedure Code]
		,dateadd(month,2,[Date]) as [Date]
		,[Value]
		,[SIR]
	from
		openrowset(
		'Microsoft.ACE.OLEDB.12.0',
		'Excel 8.0;HDR=YES;Database=\\nkch.org\shares\enterprise common area\ReportingAndAnalytics\scorecard\import\nkc_unit_scorecard_infection\Board_Scorecard_Data\BoardScorecardInfectionPrevention.xlsx',
		'select * from [CDIF$]')
	where
		[Date] is not null
END
BEGIN
	drop table if exists #temp
	create table #temp (
		StageID int
		,Date date
		,DateKey varchar(50)
		,DateDisplay date
		,Value float
		,FYTD float
		,Active bit
		,Update_dt_tm datetime
	)
	insert into #temp
	select
		1 as StageID
		,CONVERT(date,[Date]) as [Date]
		,replace(CONVERT(date,[Date]),'-','') as DateKey
		,DATEADD(MONTH, -2, CONVERT(date,[Date])) as DateDisplay
		,convert(float,[Value]) as Value
		,convert(float,FYTD) as FYTD
		,1 as Active
		,getdate() as Update_dt_tm
	from
		#stage
	where
		[Procedure Code] = 'COLO'
	insert into #temp
	select
		2 as StageID
		,CONVERT(date,[Date]) as [Date]
		,replace(CONVERT(date,[Date]),'-','') as DateKey
		,DATEADD(MONTH, -2, CONVERT(date,[Date])) as DateDisplay
		,CAST([Value] as float) as Value
		,CAST([FYTD] as float) as FYTD
		,1 as Active
		,getdate() as Update_dt_tm
	from
		#stage
	where
		[Procedure Code] = 'HYST'
	insert into #temp
	select
		3 as StageID
		,CONVERT(date,[Date]) as [Date]
		,replace(CONVERT(date,[Date]),'-','') as DateKey
		,DATEADD(MONTH, -2, CONVERT(date,[Date])) as DateDisplay
		,NULL as Value
		,CAST([FYTD] as float) as FYTD
		,1 as Active
		,getdate() as Update_dt_tm
	from
		#stage
	where
		[Procedure Code] = 'CLAB'
	insert into #temp
	select
		4 as StageID
		,CONVERT(date,[Date]) as [Date]
		,replace(CONVERT(date,[Date]),'-','') as DateKey
		,DATEADD(MONTH, -2, CONVERT(date,[Date])) as DateDisplay
		,NULL as Value
		,CAST([FYTD] as float) as FYTD
		,1 as Active
		,getdate() as Update_dt_tm
	from
		#stage
	where
		[Procedure Code] = 'CAUTI'
	insert into #temp
	select
		5 as StageID
		,CONVERT(date,[Date]) as [Date]
		,replace(CONVERT(date,[Date]),'-','') as DateKey
		,DATEADD(MONTH, -2, CONVERT(date,[Date])) as DateDisplay
		,CAST([Value] as float) as Value
		,CAST([FYTD] as float) as FYTD
		,1 as Active
		,getdate() as Update_dt_tm
	from
		#stage
	where
		[Procedure Code] = 'MRSA'
	insert into #temp
	select
		6 as StageID
		,CONVERT(date,[Date]) as [Date]
		,replace(CONVERT(date,[Date]),'-','') as DateKey
		,DATEADD(MONTH, -2, CONVERT(date,[Date])) as DateDisplay
		,CAST([Value] as float) as Value
		,CAST([FYTD] as float) as FYTD
		,1 as Active
		,getdate() as Update_dt_tm
	from
		#stage
	where
		[Procedure Code] = 'CDIF'
END
BEGIN
	truncate table BoardScorecard.InfectionPrevention
END
BEGIN
	insert into BoardScorecard.InfectionPrevention
	select * from #temp
END