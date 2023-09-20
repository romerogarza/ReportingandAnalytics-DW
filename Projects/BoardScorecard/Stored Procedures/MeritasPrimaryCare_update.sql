USE [PROJECTS]
GO
/****** Object:  StoredProcedure [BoardScorecard].[MeritasPrimaryCare_update]    Script Date: 9/19/2023 9:30:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER procedure [BoardScorecard].[MeritasPrimaryCare_update] as

declare @upload_dt_tm datetime = getdate()

BEGIN
	truncate table BoardScorecard.MeritasPrimaryCare
END
BEGIN
	insert into BoardScorecard.MeritasPrimaryCare
	select
		StageId
		,date
		,replace(date,'-','') as datekey
		,Start_Reporting_Date
		,End_Reporting_Date
		,value
		,active
		,upload_dt_tm
	from(
		select
			m.StageId
			,CONVERT(DATE, CONVERT(VARCHAR(7), a.[End Reporting Date], 120) + '-01') as date
			,null as datekey
			,a.[Start Reporting Date] as Start_Reporting_Date
			,a.[End Reporting Date] as End_Reporting_Date
			,round(a.[Value],2) as value
			,1 as Active
			,@upload_dt_tm as upload_dt_tm
		from 
			openrowset(
			'Microsoft.ACE.OLEDB.12.0',
			'Excel 8.0;HDR=YES;Database=\\nkch.org\shares\enterprise common area\ReportingAndAnalytics\scorecard\import\nkc_unit_scorecard_infection\Board_Scorecard_Data\BoardScorecardMeritasPrimaryCare.xlsx',
			'select * from [Meritas Primary Care$]')a
		join BoardScorecard.dimScorecardMetrics m on m.ShortDisplay = a.[Metric]
		)a
END