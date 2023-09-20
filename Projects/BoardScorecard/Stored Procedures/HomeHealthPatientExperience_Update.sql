USE [PROJECTS]
GO
/****** Object:  StoredProcedure [BoardScorecard].[HomeHealthPatientExperience_Update]    Script Date: 9/19/2023 9:28:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER procedure [BoardScorecard].[HomeHealthPatientExperience_Update] as

begin
	truncate table BoardScorecard.HomeHealthPatientExperience
end
begin
	if object_id('tempdb..#temp') is not null drop table #temp

	create table #temp (
		[Column1] varchar(50),
		[Column2] varchar(50),
		[Column3] varchar(50),
		[Column4] varchar(50),
		[Column5] varchar(50),
		[Column6] varchar(50),
		[Column7] varchar(50),
		[Column8] varchar(50),
		[Column9] varchar(50),
		[Column10] varchar(50),
		[Column11] varchar(50),
		[Column12] varchar(50),
		[Column13] varchar(50),
		[RunDate] datetime,
		[InsertDtTm] datetime,
	)

	insert into #temp
	select
		cast(convert(date,[Month]) as varchar(100))
		,convert(varchar(100),[Communications Between Providers and Patients (Provider Communic])
		,convert(varchar(100),[Overall Rating of Agency (Overall Rating)])
		,convert(varchar(100),[Recommend Agency (Likelihood to Recommend)])
		,convert(varchar(100),[Communications Between Providers and Patients FYTD])
		,convert(varchar(100),[Overall Rating of Agency FYTD])
		,convert(varchar(100),[Recommend Agency FYTD])
		,convert(varchar(100),[Communications Between Providers and Patients Percentile Ranking])
		,convert(varchar(100),[Overall Rating of Agency Percentile Ranking])
		,convert(varchar(100),[Recommend Agency Percentile Ranking])
		,convert(varchar(100),[Communications Between Providers and Patients Target])
		,convert(varchar(100),[Overall Rating of Agency Target])
		,convert(varchar(100),[Recommend Agency Target])
		,convert(datetime,[Run Date])
		,getdate()
	from 
		openrowset(
		'Microsoft.ACE.OLEDB.12.0',
		'Excel 8.0;HDR=YES;Database=\\nkch.org\shares\enterprise common area\STATIT\Board\BoardScorecardWorkbooks\Patient Experience\PtExpScorecardHomeHealth.xlsx',
		'select * from [Sheet1$]')
	where
		[Month] is not null

	create table #HomeHealthPatientExperience (
		StageId int not null
		,Date date not null
		,Datekey varchar(10) not null
		,CurrentValue float null
		,FYTD float null
		,Active bit not null
		,Upload_dt_tm datetime not null
	)

	insert into #HomeHealthPatientExperience
	select
		49 as StageID
		,convert(date, convert(varchar(7),Column1, 120) + '-01') as date
		,replace(convert(date, convert(varchar(7),Column1, 120) + '-01'),'-','') as DateKey
		,convert(float,Column3) as [CurrentValue]
		,case when Column6 is not null then concat('0.',replace(Column6,'%','')) else null end as [FYTD]
		,1 as Active
		,[InsertDtTm] as Upload_dt_tm
	from
		#temp
	union all
	select
		50 as StageID
		,convert(date, convert(varchar(7),Column1, 120) + '-01') as date
		,replace(convert(date, convert(varchar(7),Column1, 120) + '-01'),'-','') as DateKey
		,convert(float,Column2) as [CurrentValue]
		,case when Column5 is not null then concat('0.',replace(Column5,'%','')) else null end as [FYTD]
		,1 as Active
		,[InsertDtTm] as Upload_dt_tm
	from
		#temp
	union all
	select
		51 as StageID
		,convert(date, convert(varchar(7),Column1, 120) + '-01') as date
		,replace(convert(date, convert(varchar(7),Column1, 120) + '-01'),'-','') as DateKey
		,convert(float,Column4) as [CurrentValue]
		,case when Column7 is not null then concat('0.',replace(Column7,'%','')) else null end as [FYTD]
		,1 as Active
		,[InsertDtTm] as Upload_dt_tm
	from
		#temp

	insert into BoardScorecard.HomeHealthPatientExperience
	select * from #HomeHealthPatientExperience
ends