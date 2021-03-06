USE [ENTERPRISE]
GO
/****** Object:  StoredProcedure [cerner].[ENCNTR_FINANCIAL_UPDATE]    Script Date: 11/29/2021 5:18:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [cerner].[ENCNTR_FINANCIAL_UPDATE] AS

BEGIN
	CREATE TABLE #encntr_financial_update (
		ENCNTR_FINANCIAL_ID BIGINT
		,PERSON_ID BIGINT
		,UPDT_CNT BIGINT
		,UPDT_DT_TM DATETIME2
		,UPDT_ID BIGINT
		,UPDT_TASK BIGINT
		,UPDT_APPLCTX BIGINT
		,ACTIVE_IND BIGINT
		,ACTIVE_STATUS_CD BIGINT
		,ACTIVE_STATUS_DT_TM DATETIME2
		,ACTIVE_STATUS_PRSNL_ID BIGINT
		,BEG_EFFECTIVE_DT_TM DATETIME2
		,END_EFFECTIVE_DT_TM DATETIME2
		,RESEARCH_ACCOUNT VARCHAR(100)
		,DATA_STATUS_CD BIGINT
		,DATA_STATUS_DT_TM DATETIME2
		,DATA_STATUS_PRSNL_ID BIGINT
		,CONTRIBUTOR_SYSTEM_CD BIGINT
		,BILL_TYPE_CD BIGINT
		,ENTERPRISE_UPDATE_DT_TM DATETIME2
	)

	DECLARE @StartDate datetime2
	DECLARE @EndDate datetime2
	SET @StartDate = dateadd(day,-2,convert(date,getdate()))
	SET @EndDate = convert(date,getdate())

	INSERT INTO #encntr_financial_update
	EXEC('
	select
		ENCNTR_FINANCIAL_ID
		,PERSON_ID
		,UPDT_CNT
		,UPDT_DT_TM
		,UPDT_ID
		,UPDT_TASK
		,UPDT_APPLCTX
		,ACTIVE_IND
		,ACTIVE_STATUS_CD
		,ACTIVE_STATUS_DT_TM
		,ACTIVE_STATUS_PRSNL_ID
		,BEG_EFFECTIVE_DT_TM
		,END_EFFECTIVE_DT_TM
		,RESEARCH_ACCOUNT
		,DATA_STATUS_CD
		,DATA_STATUS_DT_TM
		,DATA_STATUS_PRSNL_ID
		,CONTRIBUTOR_SYSTEM_CD
		,BILL_TYPE_CD
		,sysdate as ENTERPRISE_UPDATE_DT_TM
	from
		ENCNTR_FINANCIAL
	where
		updt_dt_tm >= ? and updt_dt_tm < ?
	', @StartDate, @EndDate) AT [CERNERPROD]
END

BEGIN
	CREATE TABLE #encntr_financial_update_filtered (
		ENCNTR_FINANCIAL_ID BIGINT
		,PERSON_ID BIGINT
		,UPDT_CNT BIGINT
		,UPDT_DT_TM DATETIME2
		,UPDT_ID BIGINT
		,UPDT_TASK BIGINT
		,UPDT_APPLCTX BIGINT
		,ACTIVE_IND BIGINT
		,ACTIVE_STATUS_CD BIGINT
		,ACTIVE_STATUS_DT_TM DATETIME2
		,ACTIVE_STATUS_PRSNL_ID BIGINT
		,BEG_EFFECTIVE_DT_TM DATETIME2
		,END_EFFECTIVE_DT_TM DATETIME2
		,RESEARCH_ACCOUNT VARCHAR(100)
		,DATA_STATUS_CD BIGINT
		,DATA_STATUS_DT_TM DATETIME2
		,DATA_STATUS_PRSNL_ID BIGINT
		,CONTRIBUTOR_SYSTEM_CD BIGINT
		,BILL_TYPE_CD BIGINT
		,ENTERPRISE_UPDATE_DT_TM DATETIME2
	)

	INSERT INTO #encntr_financial_update_filtered
	select 
		eu.ENCNTR_FINANCIAL_ID
		,eu.PERSON_ID
		,eu.UPDT_CNT
		,eu.UPDT_DT_TM
		,eu.UPDT_ID
		,eu.UPDT_TASK
		,eu.UPDT_APPLCTX
		,eu.ACTIVE_IND
		,eu.ACTIVE_STATUS_CD
		,eu.ACTIVE_STATUS_DT_TM
		,eu.ACTIVE_STATUS_PRSNL_ID
		,eu.BEG_EFFECTIVE_DT_TM
		,eu.END_EFFECTIVE_DT_TM
		,eu.RESEARCH_ACCOUNT
		,eu.DATA_STATUS_CD
		,eu.DATA_STATUS_DT_TM
		,eu.DATA_STATUS_PRSNL_ID
		,eu.CONTRIBUTOR_SYSTEM_CD
		,eu.BILL_TYPE_CD
		,eu.ENTERPRISE_UPDATE_DT_TM
	from 
		#encntr_financial_update eu
		left outer join cerner.ENCNTR_FINANCIAL e on e.ENCNTR_FINANCIAL_ID = eu.ENCNTR_FINANCIAL_ID
	where
		e.ENCNTR_FINANCIAL_ID is null
	union all
	select 
		eu.ENCNTR_FINANCIAL_ID
		,eu.PERSON_ID
		,eu.UPDT_CNT
		,eu.UPDT_DT_TM
		,eu.UPDT_ID
		,eu.UPDT_TASK
		,eu.UPDT_APPLCTX
		,eu.ACTIVE_IND
		,eu.ACTIVE_STATUS_CD
		,eu.ACTIVE_STATUS_DT_TM
		,eu.ACTIVE_STATUS_PRSNL_ID
		,eu.BEG_EFFECTIVE_DT_TM
		,eu.END_EFFECTIVE_DT_TM
		,eu.RESEARCH_ACCOUNT
		,eu.DATA_STATUS_CD
		,eu.DATA_STATUS_DT_TM
		,eu.DATA_STATUS_PRSNL_ID
		,eu.CONTRIBUTOR_SYSTEM_CD
		,eu.BILL_TYPE_CD
		,eu.ENTERPRISE_UPDATE_DT_TM
	from 
		#encntr_financial_update eu
		left outer join cerner.ENCNTR_FINANCIAL e on e.ENCNTR_FINANCIAL_ID = eu.ENCNTR_FINANCIAL_ID and e.UPDT_CNT < eu.UPDT_CNT
	where
		e.ENCNTR_FINANCIAL_ID is not null
END

BEGIN
	delete 
	from 
		cerner.ENCNTR_FINANCIAL
	where 
		ENCNTR_FINANCIAL_ID in (select ENCNTR_FINANCIAL_ID from #encntr_financial_update_filtered)
END

BEGIN
	insert into cerner.ENCNTR_FINANCIAL
	select * from #encntr_financial_update_filtered
END

