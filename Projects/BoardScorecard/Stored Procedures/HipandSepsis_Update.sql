USE [PROJECTS]
GO
/****** Object:  StoredProcedure [BoardScorecard].[HipandSepsis_Update]    Script Date: 9/19/2023 9:27:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [BoardScorecard].[HipandSepsis_Update] AS

BEGIN
	DECLARE @Upload_dt_tm datetime
	SET @Upload_dt_tm = getdate()
	TRUNCATE TABLE BoardScorecard.HipandSepsis
END
BEGIN
	insert into BoardScorecard.HipandSepsis
	select
		7 as StageID
		,[Month] as Date
		,REPLACE(CAST([Month] as Date),'-','') as DateKey
		,case when [Observed Rate] is null then 0 else ROUND([Observed Rate],3) end as value
		,case when [FYTD Rate] is null then 0 else ROUND([FYTD Rate],3) end as FYTD
		,1 as Active
		,@Upload_dt_tm
	from 
		openrowset(
		'Microsoft.ACE.OLEDB.12.0',
		'Excel 8.0;HDR=YES;Database=\\nkch.org\shares\enterprise common area\statit\board\BoardScorecardWorkbooks\HipandKnee\HipandKneeDataSource.xlsx',
		'select * from [HipKneeComplications$]')
	/*UNION ALL
	select
		12 as StageID
		,Date
		,REPLACE(CAST(Date as Date),'-','') as DateKey
		,Value
		,round((sum(num) over (partition by YEAR(DATEADD(month,-6,Date)) order by Date))/
		(sum(den) over (partition by YEAR(DATEADD(month,-6,Date)) order by date)),4) as FYTD
		,1 as Active
		,@Upload_dt_tm
	from(
	select
		[Month] as Date
		,round(cast(count(case when [SEP-1] = 'Met' then 1 end) as float)/cast(count(*) as float),4) as value
		,cast(count(case when [SEP-1] = 'Met' then 1 end) as float) as num
		,cast(count(*) as float) as den
	from 
		openrowset(
		'Microsoft.ACE.OLEDB.12.0',
		'Excel 8.0;HDR=YES;Database=\\nkch.org\shares\enterprise common area\statit\board\BoardScorecardWorkbooks\Sepsis\SepsisDataSource.xlsx',
		'select * from [Composite-Breakdown$]')
	Group by
		[Month]
	)a*/
END

