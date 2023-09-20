USE [PROJECTS]
GO
/****** Object:  StoredProcedure [BoardScorecard].[MeritasPatientExperience_Update]    Script Date: 9/19/2023 9:30:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER procedure [BoardScorecard].[MeritasPatientExperience_Update] as

begin
	truncate table BoardScorecard.MeritasPatientExperience
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
		[InsertDtTm] datetime,
	)

	insert into #temp
	select
		cast(convert(date,[Month]) as varchar(100))
		,convert(varchar(100),[Explaining the Medical Condition and Treatment (Communication ab])
		,convert(varchar(100),[His or Her Courtesy and Friendliness (Doctor Communication)-41])
		,convert(varchar(100),[Would you say the likelihood of your recommending "physician nam])
		,convert(varchar(100),[Explaining the Medical Condition and Treatment FYTD])
		,convert(varchar(100),[His or Her Courtesy and Friendliness FYTD])
		,convert(varchar(100),[Likelihood of your recommending "physician name" to friends and ])
		,convert(varchar(100),[Explaining the Medical Condition and Treatment Percentile Rankin])
		,convert(varchar(100),[His or Her Courtesy and Friendliness Percentile Ranking])
		,convert(varchar(100),[Would you say the likelihood of your recommending "physician nam])
		,convert(varchar(100),[Explaining the Medical Condition and Treatment Target])
		,convert(varchar(100),[His or Her Courtesy and Friendliness Target])
		,convert(varchar(100),[Would you say the likelihood of your recommending "physician nam])
		,getdate() 
	from 
		openrowset(
		'Microsoft.ACE.OLEDB.12.0',
		'Excel 8.0;HDR=YES;Database=\\nkch.org\shares\enterprise common area\STATIT\Board\BoardScorecardWorkbooks\Patient Experience\PtExpScorecardMeritas.xlsx',
		'select * from [Data$]')


	create table #MeritasPatientExperience (
		StageId int not null
		,Date date not null
		,Datekey varchar(10) not null
		,CurrentValue float null
		,FYTD float null
		,Active bit not null
		,Upload_dt_tm datetime not null
	)

	insert into #MeritasPatientExperience
	select
		46 as StageID
		,convert(date, convert(varchar(7),Column1, 120) + '-01') as date
		,replace(convert(date, convert(varchar(7),Column1, 120) + '-01'),'-','') as DateKey
		,Column2 as [CurrentValue]
		,Column5 as [FYTD]
		,1 as Active
		,[InsertDtTm] as Upload_dt_tm
	from
		#temp
	union all
	select
		47 as StageID
		,convert(date, convert(varchar(7),Column1, 120) + '-01') as date
		,replace(convert(date, convert(varchar(7),Column1, 120) + '-01'),'-','') as DateKey
		,Column3 as [CurrentValue]
		,Column6 as [FYTD]
		,1 as Active
		,[InsertDtTm] as Upload_dt_tm
	from
		#temp
	union all
	select
		48 as StageID
		,convert(date, convert(varchar(7),Column1, 120) + '-01') as date
		,replace(convert(date, convert(varchar(7),Column1, 120) + '-01'),'-','') as DateKey
		,Column4 as [CurrentValue]
		,Column7 as [FYTD]
		,1 as Active
		,[InsertDtTm] as Upload_dt_tm
	from
		#temp

	insert into BoardScorecard.MeritasPatientExperience
	select * from #MeritasPatientExperience
end