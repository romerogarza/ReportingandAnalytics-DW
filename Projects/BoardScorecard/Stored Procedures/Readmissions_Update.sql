USE [PROJECTS]
GO
/****** Object:  StoredProcedure [BoardScorecard].[Readmissions_Update]    Script Date: 9/19/2023 9:32:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [BoardScorecard].[Readmissions_Update] AS

BEGIN
	TRUNCATE TABLE BoardScorecard.Readmissions
END
BEGIN
	insert into BoardScorecard.Readmissions
	select  
		a.StageId
		,a.Date
		,a.DateKey
		,a.value
		,b.FYTD
		,1 as Active
		,a.Upload_dt_tm
	from(
		select
			21 as StageID
			,CAST([Month] as DATE) as Date
			,REPLACE(CAST([Month] as Date),'-','') as DateKey
			,CASE WHEN [O/E] is null then 0 else ROUND([O/E],3) END as value
			,1 as Active
			,getdate() as Upload_dt_tm
		from 
			openrowset(
			'Microsoft.ACE.OLEDB.12.0',
			'Excel 8.0;HDR=YES;Database=\\nkch.org\shares\enterprise common area\statit\board\BoardScorecardWorkbooks\Readmissions\FocusedPopulationReadmissionMedicareFFS.xlsx',
			'select * from [HWReadmissionsMedicareFFS$]')
	)a
	join (
		select
			21 as StageID
			,CAST([Month] as DATE) as Date
			,REPLACE(CAST([Month] as Date),'-','') as DateKey
			,CASE WHEN [O/E] is null then 0 else ROUND([O/E],3) END as FYTD
			,1 as Active
			,getdate() as Upload_dt_tm
		from 
			openrowset(
			'Microsoft.ACE.OLEDB.12.0',
			'Excel 8.0;HDR=YES;Database=\\nkch.org\shares\enterprise common area\statit\board\BoardScorecardWorkbooks\Readmissions\FocusedPopulationReadmissionMedicareFFS.xlsx',
			'select * from [HW Read MC FFS FYTD$]')
	)b on a.StageId = b.StageId and a.DateKey = b.DateKey
	UNION ALL
	select  
		a.StageId
		,a.Date
		,a.DateKey
		,a.value
		,b.FYTD
		,1 as Active
		,a.Upload_dt_tm
	from(
		select 
			case when [Focused Population] = 'AMI' then 22 when [Focused Population] = 'CABG' then 23 
				when [Focused Population] = 'COPD' then 24 when [Focused Population] = 'Heart Failure' then 25
				when [Focused Population] = 'THA/TKA' then 26 when [Focused Population] = 'Pneumonia' then 27 
				when [Focused Population] = 'Stroke' then 28 end as StageID
			,CAST([Month] as DATE) as Date
			,REPLACE(CAST([Month] as Date),'-','') as DateKey
			,CASE WHEN [O/E] is null then 0 else ROUND([O/E],3) END as value
			,1 as Active
			,getdate() as Upload_dt_tm
		from 
			openrowset(
			'Microsoft.ACE.OLEDB.12.0',
			'Excel 8.0;HDR=YES;Database=\\nkch.org\shares\enterprise common area\statit\board\BoardScorecardWorkbooks\Readmissions\FocusedPopulationReadmissionMedicareFFS.xlsx',
			'select * from [CMS Readmits Medicare FFS$]')
		where
			[Focused Population] <> 'Severe Sepsis/Septic Shock'
	)a
	join (
		select
			case when [Focused Population] = 'AMI' then 22 when [Focused Population] = 'CABG' then 23 
				when [Focused Population] = 'COPD' then 24 when [Focused Population] = 'Heart Failure' then 25
				when [Focused Population] = 'THA/TKA' then 26 when [Focused Population] = 'Pneumonia' then 27 
				when [Focused Population] = 'Stroke' then 28 end as StageID
			,CAST([Month] as DATE) as Date
			,REPLACE(CAST([Month] as Date),'-','') as DateKey
			,CASE WHEN [O/E] is null then 0 else ROUND([O/E],3) END as FYTD
			,1 as Active
			,getdate() as Upload_dt_tm
		from 
			openrowset(
			'Microsoft.ACE.OLEDB.12.0',
			'Excel 8.0;HDR=YES;Database=\\nkch.org\shares\enterprise common area\statit\board\BoardScorecardWorkbooks\Readmissions\FocusedPopulationReadmissionMedicareFFS.xlsx',
			'select * from [CMS Readmits MC FFS FYTD$]')
		where
			[Focused Population] <> 'Severe Sepsis/Septic Shock'
	)b on a.StageId = b.StageId and a.DateKey = b.DateKey
END
