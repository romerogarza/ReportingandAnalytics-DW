USE [PROJECTS]
GO
/****** Object:  StoredProcedure [BoardScorecard].[MortalityRate_Update]    Script Date: 9/19/2023 9:30:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [BoardScorecard].[MortalityRate_Update] AS

BEGIN
	DECLARE @Upload_dt_tm datetime
	SET @Upload_dt_tm = getdate()
	TRUNCATE TABLE BoardScorecard.MortalityRate
END
BEGIN
	insert into BoardScorecard.MortalityRate
	select  
		a.StageId
		,a.Date
		,a.DateKey
		,a.value
		,b.FYTD
		,1 as Active
		,a.Upload_dt_tm
	from (
		select
			case when [Group] = 'Total' then 13 when [Group] = 'AMI' then 14 when [Group] = 'COPD' then 15 when [Group] = 'Heart Failure' then 16 when [Group] = 'Pneumonia' then 17
			when [Group] = 'CABG' then 18 when [Group] = 'Stroke' then 19 when [Group] = 'Sepsis or Septic Shock' then 20 end as StageId
			,[Month] as Date
			,REPLACE(CAST([Month] as Date),'-','') as DateKey
			,case when [Mortality Survival] is null then 0 else ROUND([Mortality Survival],3) end as value
			--,ROUND([FYTD O/E],3) as FYTD
			,getdate() as Upload_dt_tm
		from 
			openrowset(
			'Microsoft.ACE.OLEDB.12.0',
			'Excel 8.0;HDR=YES;Database=\\nkch.org\shares\enterprise common area\statit\board\BoardScorecardWorkbooks\Mortality\MortalityRatebyMeasureMedicare.xlsx',
			'select * from [MortalitiesMedicareFFS$]'/*[MortalitiesMedicareFFS FYTD$]*/)
		where 
			[Group] not in ('All Others')
	)a
	join (
		select
			case when [Group] = 'Total' then 13 when [Group] = 'AMI' then 14 when [Group] = 'COPD' then 15 when [Group] = 'Heart Failure' then 16 when [Group] = 'Pneumonia' then 17
			when [Group] = 'CABG' then 18 when [Group] = 'Stroke' then 19 when [Group] = 'Sepsis or Septic Shock' then 20 end as StageId
			,[Month] as Date
			,REPLACE(CAST([Month] as Date),'-','') as DateKey
			,case when [Mortality Survival] is null then 0 else ROUND([Mortality Survival],3) end as FYTD
			,getdate() as Upload_dt_tm
		from 
			openrowset(
			'Microsoft.ACE.OLEDB.12.0',
			'Excel 8.0;HDR=YES;Database=\\nkch.org\shares\enterprise common area\statit\board\BoardScorecardWorkbooks\Mortality\MortalityRatebyMeasureMedicare.xlsx',
			'select * from [MortalitiesMedicareFFS FYTD$]')
		where 
			[Group] not in ('All Others')
	)b on a.StageId = b.StageId and a.DateKey = b.DateKey
END
/*BEGIN
	DECLARE @InsertUpdate_dt_tm datetime
	SET @InsertUpdate_dt_tm = (select max(Upload_dt_tm) from BoardScorecard.MortalityRate)

	IF @InsertUpdate_dt_tm = @Upload_dt_tm	
		update BoardScorecard.MortalityRate
		set Active = 0
		where Active = 1
		and Upload_dt_tm < @InsertUpdate_dt_tm
END*/
