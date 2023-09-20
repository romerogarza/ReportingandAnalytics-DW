USE [PROJECTS]
GO
/****** Object:  StoredProcedure [BoardScorecard].[InfectionPrevention_old_Update]    Script Date: 9/19/2023 9:28:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [BoardScorecard].[InfectionPrevention_old_Update] AS

DECLARE @update_dt_tm datetime
DECLARE @StageId1 date
DECLARE @StageId2 date
DECLARE @StageId3 date
DECLARE @StageId4 date
DECLARE @StageId5 date
DECLARE @StageId6 date

SET @update_dt_tm = getdate()
SET @StageId1 = (select MAX(Date) from BoardScorecard.InfectionPrevention where StageID = 1)
SET @StageId2 = (select MAX(Date) from BoardScorecard.InfectionPrevention where StageID = 2)
SET @StageId3 = (select MAX(Date) from BoardScorecard.InfectionPrevention where StageID = 3)
SET @StageId4 = (select MAX(Date) from BoardScorecard.InfectionPrevention where StageID = 4)
SET @StageId5 = (select MAX(Date) from BoardScorecard.InfectionPrevention where StageID = 5)
SET @StageId6 = (select MAX(Date) from BoardScorecard.InfectionPrevention where StageID = 6)

BEGIN
	drop table if exists #BoardSIRforComplex30_DaySSIData
	create table #BoardSIRforComplex30_DaySSIData (
	[Facility Org ID]			varchar(100)
	,[Procedure Code]			varchar(100)
	,[Procedure Count]			varchar(100)
	,[infCountComplex30d]		varchar(100)
	,[numPredComplex30d]		varchar(100)
	,[SIRComplex30d]			varchar(100)
	,[SIRComplex30d_pval]		varchar(100)
	,[SIRComplex30d95CI]		varchar(100)
	,[Type of Facility]			varchar(100)
	,[Type of Affiliation]		varchar(100)
	,[State]					varchar(100)
	,[CMS Certification Number]	varchar(100)
	)

	BULK INSERT #BoardSIRforComplex30_DaySSIData
	FROM '\\nkch.org\shares\Enterprise Common Area\ReportingAndAnalytics\scorecard\import\nkc_unit_scorecard_infection\Board_Scorecard_Data\BoardSIRforComplex30_DaySSIData.csv'
	WITH (
	  FIRSTROW = 2
	  ,FIELDTERMINATOR = ','
	  ,ROWTERMINATOR = '\n'
	)

	drop table if exists #SIRforCAUTIDataforHospitalIQR_2
	create table #SIRforCAUTIDataforHospitalIQR_2 (
	[Facility Org ID]			VARCHAR(100)
	,[Type of Facility]			VARCHAR(100)
	,[Type of Affiliation]		VARCHAR(100)
	,[State]					VARCHAR(100)
	,[CMS Certification Number] VARCHAR(100)
	,[Events]					VARCHAR(100)
	,[Number Predicted]			VARCHAR(100)
	,[Urinary Catheter Days]	VARCHAR(100)
	,[SIR p-value]				VARCHAR(100)
	,[SIR]						VARCHAR(100)
	,[95% Confidence Interval]	VARCHAR(100)
	,[Location Type]			VARCHAR(100)
	,[CDC Location]				VARCHAR(100)
	,[Location]					VARCHAR(100)
	,[Months]					VARCHAR(100)
	)

	BULK INSERT #SIRforCAUTIDataforHospitalIQR_2
	FROM '\\nkch.org\shares\Enterprise Common Area\ReportingAndAnalytics\scorecard\import\nkc_unit_scorecard_infection\Board_Scorecard_Data\SIRforCAUTIDataforHospitalIQR1.csv'
	WITH (
	  FIRSTROW = 2
	  ,FIELDTERMINATOR = ','
	  ,ROWTERMINATOR = '\n'
	)

	drop table if exists #SIRforCLABDataforHospitalIQR_20
	create table #SIRforCLABDataforHospitalIQR_20 (
	[Facility Org ID]			VARCHAR(100)
	,[Type of Facility]			VARCHAR(100)
	,[Type of Affiliation]		VARCHAR(100)
	,[State]					VARCHAR(100)
	,[CMS Certification Number] VARCHAR(100)
	,[Events]					VARCHAR(100)
	,[Number Predicted]			VARCHAR(100)
	,[Urinary Catheter Days]	VARCHAR(100)
	,[SIR p-value]				VARCHAR(100)
	,[SIR]						VARCHAR(100)
	,[95% Confidence Interval]	VARCHAR(100)
	,[Location Type]			VARCHAR(100)
	,[CDC Location]				VARCHAR(100)
	,[Location]					VARCHAR(100)
	,[Months]					VARCHAR(100)
	)

	BULK INSERT #SIRforCLABDataforHospitalIQR_20
	FROM '\\nkch.org\shares\Enterprise Common Area\ReportingAndAnalytics\scorecard\import\nkc_unit_scorecard_infection\Board_Scorecard_Data\SIRforCLABDataforHospitalIQR_2.csv'
	WITH (
	  FIRSTROW = 2
	  ,FIELDTERMINATOR = ','
	  ,ROWTERMINATOR = '\n'
	)
	
	drop table if exists #SIRforMRSABloodFacwideINforCMSH
	create table #SIRforMRSABloodFacwideINforCMSH (
	[Facility Org ID]					VARCHAR(100)
	,[CMS Certification Number]			VARCHAR(100)
	--,[Summary Yr/Qtr]					VARCHAR(100)
	,[Location]							VARCHAR(100)
	,[MRSA Blood Incident LabID Count]	VARCHAR(100)
	,[Patient Days]						VARCHAR(100)
	,[Number Predicted]					VARCHAR(100)
	,[SIR p-value]						VARCHAR(100)
	,[SIR]								VARCHAR(100)
	,[95% Confidence Interval]			VARCHAR(100)
	,[Months]							VARCHAR(100)
	)

	BULK INSERT #SIRforMRSABloodFacwideINforCMSH
	FROM '\\nkch.org\shares\Enterprise Common Area\ReportingAndAnalytics\scorecard\import\nkc_unit_scorecard_infection\Board_Scorecard_Data\SIRforMRSABloodFacwideINforCMSH.csv'
	WITH (
	  FIRSTROW = 2
	  ,FIELDTERMINATOR = ','
	  ,ROWTERMINATOR = '\n'
	)
	
	drop table if exists #SIRforCDIFacwideINforCMSHospita
	create table #SIRforCDIFacwideINforCMSHospita (
	[Facility Org ID] VARCHAR(100)
	--,[Summary Yr/Qtr] VARCHAR(100)
	,[Location] VARCHAR(100)
	,[CMS Certification Number] VARCHAR(100)
	,[CDIF Facility Incident HO LabID Event Count] VARCHAR(100)
	,[Patient Days] VARCHAR(100)
	,[Number Predicted] VARCHAR(100)
	,[SIR p-value] VARCHAR(100)
	,[SIR] VARCHAR(100)
	,[95% Confidence Interval] VARCHAR(100)
	,[Months] VARCHAR(100)
	)

	BULK INSERT #SIRforCDIFacwideINforCMSHospita
	FROM '\\nkch.org\shares\Enterprise Common Area\ReportingAndAnalytics\scorecard\import\nkc_unit_scorecard_infection\Board_Scorecard_Data\SIRforCDIFacwideINforCMSHospita.csv'
	WITH (
	  FIRSTROW = 2
	  ,FIELDTERMINATOR = ','
	  ,ROWTERMINATOR = '\n'
	)

	drop table if exists #SIRforCDIFacwideINforCMSHospita003
	create table #SIRforCDIFacwideINforCMSHospita003 (
		[Facility Org ID]								VARCHAR(100)
		,[Location]										VARCHAR(100)
		,[CMS Certification Number]						VARCHAR(100)
		,[CDIF Facility Incident HO LabID Event Count]	VARCHAR(100)
		,[Patient Days]									VARCHAR(100)
		,[Number Predicted]								VARCHAR(100)
		,[SIR p-value]									VARCHAR(100)
		,[SIR]											VARCHAR(100)
		,[95% Confidence Interval]						VARCHAR(100)
		,[Months]										VARCHAR(100)
	)

	BULK INSERT #SIRforCDIFacwideINforCMSHospita003
	FROM '\\nkch.org\shares\Enterprise Common Area\ReportingAndAnalytics\scorecard\import\nkc_unit_scorecard_infection\Board_Scorecard_Data\SIRforCDIFacwideINforCMSHospita.csv'
	WITH (
	  FIRSTROW = 2
	  ,FIELDTERMINATOR = ','
	  ,ROWTERMINATOR = '\n'
	)

	drop table if exists #SIRforMRSABloodFacwideINforCMSH003
	create table #SIRforMRSABloodFacwideINforCMSH003 (
	[Facility Org ID]					VARCHAR(100)
	,[CMS Certification Number]			VARCHAR(100)
	,[Location]							VARCHAR(100)
	,[MRSA Blood Incident~LabID Count]	VARCHAR(100)
	,[Patient Days]						VARCHAR(100)
	,[Number~Predicted]					VARCHAR(100)
	,[SIR p-value]						VARCHAR(100)
	,[SIR]								VARCHAR(100)
	,[95% Confidence~Interval]			VARCHAR(100)
	,[Months]							VARCHAR(100)
	)

	BULK INSERT #SIRforMRSABloodFacwideINforCMSH003
	FROM '\\nkch.org\shares\Enterprise Common Area\ReportingAndAnalytics\scorecard\import\nkc_unit_scorecard_infection\Board_Scorecard_Data\SIRforMRSABloodFacwideINforCMSH.csv'
	WITH (
	  FIRSTROW = 2
	  ,FIELDTERMINATOR = ','
	  ,ROWTERMINATOR = '\n'
	)
END
BEGIN
	BEGIN
		IF @StageId1 = CAST(CONVERT(DATETIME, CONVERT(VARCHAR(7), @update_dt_tm, 120) + '-01') as date)
			BEGIN
				update BoardScorecard.InfectionPrevention
				set Active = 0
				where
					Date = @StageId1
					and StageID = 1

				insert into BoardScorecard.InfectionPrevention
				select
					1 as StageId
					,CAST(CONVERT(DATETIME, CONVERT(VARCHAR(7), @update_dt_tm, 120) + '-01') as date) as Date
					,replace(cast(CAST(CONVERT(DATETIME, CONVERT(VARCHAR(7), @update_dt_tm, 120) + '-01') as date) as date),'-','') as DateKey
					,DATEADD(MONTH, -2, CAST(CONVERT(DATETIME, CONVERT(VARCHAR(7), @update_dt_tm, 120) + '-01') as date)) as DateDisplay
					,NULL as Value
					,case when [SIRComplex30d] = '.' then 0 else cast([SIRComplex30d] as float) end as FYTD
					,1 as Active
					,@update_dt_tm as Update_dt_tm
				from
					#BoardSIRforComplex30_DaySSIData
				where
					[Procedure Code] = 'COLO'
			END
		ELSE
			BEGIN
				insert into BoardScorecard.InfectionPrevention
				select
					1 as StageId
					,CAST(CONVERT(DATETIME, CONVERT(VARCHAR(7), @update_dt_tm, 120) + '-01') as date) as Date
					,replace(cast(CAST(CONVERT(DATETIME, CONVERT(VARCHAR(7), @update_dt_tm, 120) + '-01') as date) as date),'-','') as DateKey
					,DATEADD(MONTH, -2, CAST(CONVERT(DATETIME, CONVERT(VARCHAR(7), @update_dt_tm, 120) + '-01') as date)) as DateDisplay
					,NULL as Value
					,case when [SIRComplex30d] = '.' then 0 else cast([SIRComplex30d] as float) end as FYTD
					,1 as Active
					,@update_dt_tm as Update_dt_tm
				from
					#BoardSIRforComplex30_DaySSIData
				where
					[Procedure Code] = 'COLO'
			END
	END
	BEGIN
		IF @StageId2 = CAST(CONVERT(DATETIME, CONVERT(VARCHAR(7), @update_dt_tm, 120) + '-01') as date)
			BEGIN
				update BoardScorecard.InfectionPrevention
				set Active = 0
				where
					Date = @StageId2
					and StageID = 2
				insert into BoardScorecard.InfectionPrevention
				select
					2 as StageId
					,CAST(CONVERT(DATETIME, CONVERT(VARCHAR(7), @update_dt_tm, 120) + '-01') as date) as Date
					,replace(cast(CAST(CONVERT(DATETIME, CONVERT(VARCHAR(7), @update_dt_tm, 120) + '-01') as date) as date),'-','') as DateKey
					,DATEADD(MONTH, -2, CAST(CONVERT(DATETIME, CONVERT(VARCHAR(7), @update_dt_tm, 120) + '-01') as date)) as DateDisplay
					,NULL as Value
					,case when [SIRComplex30d] = '.' then 0 else cast([SIRComplex30d] as float) end as FYTD
					,1 as Active
					,@update_dt_tm as Update_dt_tm
				from
					#BoardSIRforComplex30_DaySSIData
				where
					[Procedure Code] = 'HYST'
			END
		ELSE
			BEGIN
				insert into BoardScorecard.InfectionPrevention
				select
					2 as StageId
					,CAST(CONVERT(DATETIME, CONVERT(VARCHAR(7), @update_dt_tm, 120) + '-01') as date) as Date
					,replace(cast(CAST(CONVERT(DATETIME, CONVERT(VARCHAR(7), @update_dt_tm, 120) + '-01') as date) as date),'-','') as DateKey
					,DATEADD(MONTH, -2, CAST(CONVERT(DATETIME, CONVERT(VARCHAR(7), @update_dt_tm, 120) + '-01') as date)) as DateDisplay
					,NULL as Value
					,case when [SIRComplex30d] = '.' then 0 else cast([SIRComplex30d] as float) end as FYTD
					,1 as Active
					,@update_dt_tm as Update_dt_tm
				from
					#BoardSIRforComplex30_DaySSIData
				where
					[Procedure Code] = 'HYST'
			END
	END
	BEGIN
		IF @StageId3 = CAST(CONVERT(DATETIME, CONVERT(VARCHAR(7), @update_dt_tm, 120) + '-01') as date)
			BEGIN
				update BoardScorecard.InfectionPrevention
				set Active = 0
				where
					Date = @StageId3
					and StageID = 3
				insert into BoardScorecard.InfectionPrevention
				select top 1
					3 as StageId
					,CAST(CONVERT(DATETIME, CONVERT(VARCHAR(7), @update_dt_tm, 120) + '-01') as date) as Date
					,replace(cast(CAST(CONVERT(DATETIME, CONVERT(VARCHAR(7), @update_dt_tm, 120) + '-01') as date) as date),'-','') as DateKey
					,DATEADD(MONTH, -2, CAST(CONVERT(DATETIME, CONVERT(VARCHAR(7), @update_dt_tm, 120) + '-01') as date)) as DateDisplay
					,NULL as Value
					,case when [SIR] = '.' then 0 else cast([SIR] as float) end as FYTD
					,1 as Active
					,@update_dt_tm as Update_dt_tm
				from
					#SIRforCLABDataforHospitalIQR_20
			END
		ELSE
			BEGIN
				insert into BoardScorecard.InfectionPrevention
				select top 1
					3 as StageId
					,CAST(CONVERT(DATETIME, CONVERT(VARCHAR(7), @update_dt_tm, 120) + '-01') as date) as Date
					,replace(cast(CAST(CONVERT(DATETIME, CONVERT(VARCHAR(7), @update_dt_tm, 120) + '-01') as date) as date),'-','') as DateKey
					,DATEADD(MONTH, -2, CAST(CONVERT(DATETIME, CONVERT(VARCHAR(7), @update_dt_tm, 120) + '-01') as date)) as DateDisplay
					,NULL as Value
					,case when [SIR] = '.' then 0 else cast([SIR] as float) end as FYTD
					,1 as Active
					,@update_dt_tm as Update_dt_tm
				from
					#SIRforCLABDataforHospitalIQR_20
			END
	END
	BEGIN
		IF @StageId4 = CAST(CONVERT(DATETIME, CONVERT(VARCHAR(7), @update_dt_tm, 120) + '-01') as date)
			BEGIN
				update BoardScorecard.InfectionPrevention
				set Active = 0
				where
					Date = @StageId4
					and StageID = 4
				insert into BoardScorecard.InfectionPrevention
				select top 1
					4 as StageId
					,CAST(CONVERT(DATETIME, CONVERT(VARCHAR(7), @update_dt_tm, 120) + '-01') as date) as Date
					,replace(cast(CAST(CONVERT(DATETIME, CONVERT(VARCHAR(7), @update_dt_tm, 120) + '-01') as date) as date),'-','') as DateKey
					,DATEADD(MONTH, -2, CAST(CONVERT(DATETIME, CONVERT(VARCHAR(7), @update_dt_tm, 120) + '-01') as date)) as DateDisplay
					,NULL as Value
					,case when [SIR] = '.' then 0 else cast([SIR] as float) end as FYTD
					,1 as Active
					,@update_dt_tm as Update_dt_tm
				from
					#SIRforCAUTIDataforHospitalIQR_2
			END
		ELSE
			BEGIN
				insert into BoardScorecard.InfectionPrevention
				select top 1
					4 as StageId
					,CAST(CONVERT(DATETIME, CONVERT(VARCHAR(7), @update_dt_tm, 120) + '-01') as date) as Date
					,replace(cast(CAST(CONVERT(DATETIME, CONVERT(VARCHAR(7), @update_dt_tm, 120) + '-01') as date) as date),'-','') as DateKey
					,DATEADD(MONTH, -2, CAST(CONVERT(DATETIME, CONVERT(VARCHAR(7), @update_dt_tm, 120) + '-01') as date)) as DateDisplay
					,NULL as Value
					,case when [SIR] = '.' then 0 else cast([SIR] as float) end as FYTD
					,1 as Active
					,@update_dt_tm as Update_dt_tm
				from
					#SIRforCAUTIDataforHospitalIQR_2
			END
	END
	BEGIN
		IF @StageId5 = CAST(CONVERT(DATETIME, CONVERT(VARCHAR(7), @update_dt_tm, 120) + '-01') as date)
			BEGIN
				update BoardScorecard.InfectionPrevention
				set Active = 0
				where
					Date = @StageId5
					and StageID = 5
				insert into BoardScorecard.InfectionPrevention
				select
					5 as StageId
					,CAST(CONVERT(DATETIME, CONVERT(VARCHAR(7), @update_dt_tm, 120) + '-01') as date) as Date
					,replace(cast(CAST(CONVERT(DATETIME, CONVERT(VARCHAR(7), @update_dt_tm, 120) + '-01') as date) as date),'-','') as DateKey
					,DATEADD(MONTH, -2, CAST(CONVERT(DATETIME, CONVERT(VARCHAR(7), @update_dt_tm, 120) + '-01') as date)) as DateDisplay
					,case when SIR_VALUE = '.' then 0 else cast(SIR_VALUE as float) end as Value
					,case when SIR_FYTD = '.' then 0 else cast(SIR_FYTD as float) end as FYTD
					,1 as Active
					,@update_dt_tm as Update_dt_tm
				from
					(select 
						SIR_FYTD
						,SIR_VALUE
					from(
						select top 1 
							[Facility Org ID]
							,[SIR] as SIR_FYTD 
						from 
							#SIRforMRSABloodFacwideINforCMSH003
					)f join (
						select top 1 
							[Facility Org ID]
							,[SIR] as SIR_VALUE 
						from 
							#SIRforMRSABloodFacwideINforCMSH
					)v on f.[Facility Org ID] = v.[Facility Org ID])a
			END
		ELSE
			BEGIN
				insert into BoardScorecard.InfectionPrevention
				select
					5 as StageId
					,CAST(CONVERT(DATETIME, CONVERT(VARCHAR(7), @update_dt_tm, 120) + '-01') as date) as Date
					,replace(cast(CAST(CONVERT(DATETIME, CONVERT(VARCHAR(7), @update_dt_tm, 120) + '-01') as date) as date),'-','') as DateKey
					,DATEADD(MONTH, -2, CAST(CONVERT(DATETIME, CONVERT(VARCHAR(7), @update_dt_tm, 120) + '-01') as date)) as DateDisplay
					,case when SIR_VALUE = '.' then 0 else cast(SIR_VALUE as float) end as Value
					,case when SIR_FYTD = '.' then 0 else cast(SIR_FYTD as float) end as FYTD
					,1 as Active
					,@update_dt_tm as Update_dt_tm
				from
					(select 
						SIR_FYTD
						,SIR_VALUE
					from(
						select top 1 
							[Facility Org ID]
							,[SIR] as SIR_FYTD 
						from 
							#SIRforMRSABloodFacwideINforCMSH003
					)f join (
						select top 1 
							[Facility Org ID]
							,[SIR] as SIR_VALUE 
						from 
							#SIRforMRSABloodFacwideINforCMSH
					)v on f.[Facility Org ID] = v.[Facility Org ID])a
			END
	END
	BEGIN
		IF @StageId6 = CAST(CONVERT(DATETIME, CONVERT(VARCHAR(7), @update_dt_tm, 120) + '-01') as date)
			BEGIN
				update BoardScorecard.InfectionPrevention
				set Active = 0
				where
					Date = @StageId6
					and StageID = 6
				insert into BoardScorecard.InfectionPrevention
				select
					6 as StageId
					,CAST(CONVERT(DATETIME, CONVERT(VARCHAR(7), @update_dt_tm, 120) + '-01') as date) as Date
					,replace(cast(CAST(CONVERT(DATETIME, CONVERT(VARCHAR(7), @update_dt_tm, 120) + '-01') as date) as date),'-','') as DateKey
					,DATEADD(MONTH, -2, CAST(CONVERT(DATETIME, CONVERT(VARCHAR(7), @update_dt_tm, 120) + '-01') as date)) as DateDisplay
					,case when SIR_VALUE = '.' then 0 else cast(SIR_VALUE as float) end as Value
					,case when SIR_FYTD = '.' then 0 else cast(SIR_FYTD as float) end as FYTD
					,1 as Active
					,@update_dt_tm as Update_dt_tm
				from
					(select 
						SIR_FYTD
						,SIR_VALUE
					from(
						select top 1 
							[Facility Org ID]
							,[SIR] as SIR_FYTD 
						from 
							#SIRforCDIFacwideINforCMSHospita003
					)f join (
						select top 1 
							[Facility Org ID]
							,[SIR] as SIR_VALUE 
						from 
							#SIRforCDIFacwideINforCMSHospita
					)v on f.[Facility Org ID] = v.[Facility Org ID])a
			END
		ELSE
			BEGIN
				insert into BoardScorecard.InfectionPrevention
				select
					6 as StageId
					,CAST(CONVERT(DATETIME, CONVERT(VARCHAR(7), @update_dt_tm, 120) + '-01') as date) as Date
					,replace(cast(CAST(CONVERT(DATETIME, CONVERT(VARCHAR(7), @update_dt_tm, 120) + '-01') as date) as date),'-','') as DateKey
					,DATEADD(MONTH, -2, CAST(CONVERT(DATETIME, CONVERT(VARCHAR(7), @update_dt_tm, 120) + '-01') as date)) as DateDisplay
					,case when SIR_VALUE = '.' then 0 else cast(SIR_VALUE as float) end as Value
					,case when SIR_FYTD = '.' then 0 else cast(SIR_FYTD as float) end as FYTD
					,1 as Active
					,@update_dt_tm as Update_dt_tm
				from
					(select 
						SIR_FYTD
						,SIR_VALUE
					from(
						select top 1 
							[Facility Org ID]
							,[SIR] as SIR_FYTD 
						from 
							#SIRforCDIFacwideINforCMSHospita003
					)f join (
						select top 1 
							[Facility Org ID]
							,[SIR] as SIR_VALUE 
						from 
							#SIRforCDIFacwideINforCMSHospita
					)v on f.[Facility Org ID] = v.[Facility Org ID])a
			END
	END
END
BEGIN
	drop table #SIRforMRSABloodFacwideINforCMSH
	drop table #SIRforMRSABloodFacwideINforCMSH003
	drop table #SIRforCDIFacwideINforCMSHospita
	drop table #SIRforCDIFacwideINforCMSHospita003
	drop table #SIRforCAUTIDataforHospitalIQR_2
	drop table #SIRforCLABDataforHospitalIQR_20
	drop table #BoardSIRforComplex30_DaySSIData
END
