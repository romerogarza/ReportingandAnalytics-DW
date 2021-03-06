USE [ENTERPRISE]
GO
/****** Object:  StoredProcedure [cerner].[SCH_BOOKING_UPDATE]    Script Date: 11/29/2021 5:23:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [cerner].[SCH_BOOKING_UPDATE] AS

BEGIN
	create table #sch_booking_update (
		BOOKING_ID INT
		,RESOURCE_CD INT
		,PERSON_ID INT
		,APPLY_SLOT_ID INT
		,STATUS_FLAG INT
		,STATUS_MEANING VARCHAR(12)
		,GRANTED_PRSNL_ID INT
		,RELEASE_PRSNL_ID INT
		,FORCE_IND INT
		,ENCNTR_ID INT
		,CANDIDATE_ID INT
		,ACTIVE_IND INT
		,ACTIVE_STATUS_CD INT
		,ACTIVE_STATUS_PRSNL_ID INT
		,UPDT_DT_TM DATETIME2
		,UPDT_APPLCTX INT
		,UPDT_ID INT
		,UPDT_CNT INT
		,UPDT_TASK INT
		,APPT_TYPE_CD INT
		,LOCATION_CD INT
		,SCH_ROLE_CD INT
		,ROLE_MEANING VARCHAR(12)
		,SEQ_NBR INT
		,BEG_EFFECTIVE_DT_TM DATETIME2
		,END_DT_TM DATETIME2
		,END_EFFECTIVE_DT_TM DATETIME2
		,ORIG_BEG_DT_TM DATETIME2
		,NULL_DT_TM DATETIME2
		,VERIFY_DT_TM DATETIME2
		,VERSION_DT_TM DATETIME2
		,WRITTEN_DT_TM DATETIME2
		,ACTIVE_STATUS_DT_TM DATETIME2
		,BEG_DT_TM DATETIME2
		,GRANTED_DT_TM DATETIME2
		,ORIG_END_DT_TM DATETIME2
		,RELEASE_DT_TM DATETIME2
		,ENTERPRISE_UPDATE_DT_TM DATETIME2
	)
	
	DECLARE @StartDate datetime2
	DECLARE @EndDate datetime2
	SET @StartDate = dateadd(day,-2,convert(date,getdate()))
	SET @EndDate = convert(date,getdate())

	INSERT INTO #sch_booking_update
	EXEC('
	select
		BOOKING_ID
		,RESOURCE_CD
		,PERSON_ID
		,APPLY_SLOT_ID
		,STATUS_FLAG
		,STATUS_MEANING
		,GRANTED_PRSNL_ID
		,RELEASE_PRSNL_ID
		,FORCE_IND
		,ENCNTR_ID
		,CANDIDATE_ID
		,ACTIVE_IND
		,ACTIVE_STATUS_CD
		,ACTIVE_STATUS_PRSNL_ID
		,UPDT_DT_TM
		,UPDT_APPLCTX
		,UPDT_ID
		,UPDT_CNT
		,UPDT_TASK
		,APPT_TYPE_CD
		,LOCATION_CD
		,SCH_ROLE_CD
		,ROLE_MEANING
		,SEQ_NBR
		,BEG_EFFECTIVE_DT_TM
		,END_DT_TM
		,END_EFFECTIVE_DT_TM
		,ORIG_BEG_DT_TM
		,NULL_DT_TM
		,VERIFY_DT_TM
		,VERSION_DT_TM
		,WRITTEN_DT_TM
		,ACTIVE_STATUS_DT_TM
		,BEG_DT_TM
		,GRANTED_DT_TM
		,ORIG_END_DT_TM
		,RELEASE_DT_TM
		,sysdate as ENTERPRISE_UPDATE_DT_TM
	from
		sch_booking
	where
		(updt_dt_tm >= ? and updt_dt_tm < ?)
	', @StartDate, @EndDate) AT [CERNERPROD]
END

BEGIN
	CREATE TABLE #sch_booking_update_filtered (
		BOOKING_ID INT
		,RESOURCE_CD INT
		,PERSON_ID INT
		,APPLY_SLOT_ID INT
		,STATUS_FLAG INT
		,STATUS_MEANING VARCHAR(12)
		,GRANTED_PRSNL_ID INT
		,RELEASE_PRSNL_ID INT
		,FORCE_IND INT
		,ENCNTR_ID INT
		,CANDIDATE_ID INT
		,ACTIVE_IND INT
		,ACTIVE_STATUS_CD INT
		,ACTIVE_STATUS_PRSNL_ID INT
		,UPDT_DT_TM DATETIME2
		,UPDT_APPLCTX INT
		,UPDT_ID INT
		,UPDT_CNT INT
		,UPDT_TASK INT
		,APPT_TYPE_CD INT
		,LOCATION_CD INT
		,SCH_ROLE_CD INT
		,ROLE_MEANING VARCHAR(12)
		,SEQ_NBR INT
		,BEG_EFFECTIVE_DT_TM DATETIME2
		,END_DT_TM DATETIME2
		,END_EFFECTIVE_DT_TM DATETIME2
		,ORIG_BEG_DT_TM DATETIME2
		,NULL_DT_TM DATETIME2
		,VERIFY_DT_TM DATETIME2
		,VERSION_DT_TM DATETIME2
		,WRITTEN_DT_TM DATETIME2
		,ACTIVE_STATUS_DT_TM DATETIME2
		,BEG_DT_TM DATETIME2
		,GRANTED_DT_TM DATETIME2
		,ORIG_END_DT_TM DATETIME2
		,RELEASE_DT_TM DATETIME2
		,ENTERPRISE_UPDATE_DT_TM DATETIME2
	)

	INSERT INTO #sch_booking_update_filtered
	select
		su.BOOKING_ID
		,su.RESOURCE_CD
		,su.PERSON_ID
		,su.APPLY_SLOT_ID
		,su.STATUS_FLAG
		,su.STATUS_MEANING
		,su.GRANTED_PRSNL_ID
		,su.RELEASE_PRSNL_ID
		,su.FORCE_IND
		,su.ENCNTR_ID
		,su.CANDIDATE_ID
		,su.ACTIVE_IND
		,su.ACTIVE_STATUS_CD
		,su.ACTIVE_STATUS_PRSNL_ID
		,su.UPDT_DT_TM
		,su.UPDT_APPLCTX
		,su.UPDT_ID
		,su.UPDT_CNT
		,su.UPDT_TASK
		,su.APPT_TYPE_CD
		,su.LOCATION_CD
		,su.SCH_ROLE_CD
		,su.ROLE_MEANING
		,su.SEQ_NBR
		,su.BEG_EFFECTIVE_DT_TM
		,su.END_DT_TM
		,su.END_EFFECTIVE_DT_TM
		,su.ORIG_BEG_DT_TM
		,su.NULL_DT_TM
		,su.VERIFY_DT_TM
		,su.VERSION_DT_TM
		,su.WRITTEN_DT_TM
		,su.ACTIVE_STATUS_DT_TM
		,su.BEG_DT_TM
		,su.GRANTED_DT_TM
		,su.ORIG_END_DT_TM
		,su.RELEASE_DT_TM
		,su.ENTERPRISE_UPDATE_DT_TM
	from 
		#sch_booking_update su
		left outer join cerner.SCH_BOOKING s on s.BOOKING_ID = su.BOOKING_ID
	where
		s.BOOKING_ID is null
	union all
	select
		su.BOOKING_ID
		,su.RESOURCE_CD
		,su.PERSON_ID
		,su.APPLY_SLOT_ID
		,su.STATUS_FLAG
		,su.STATUS_MEANING
		,su.GRANTED_PRSNL_ID
		,su.RELEASE_PRSNL_ID
		,su.FORCE_IND
		,su.ENCNTR_ID
		,su.CANDIDATE_ID
		,su.ACTIVE_IND
		,su.ACTIVE_STATUS_CD
		,su.ACTIVE_STATUS_PRSNL_ID
		,su.UPDT_DT_TM
		,su.UPDT_APPLCTX
		,su.UPDT_ID
		,su.UPDT_CNT
		,su.UPDT_TASK
		,su.APPT_TYPE_CD
		,su.LOCATION_CD
		,su.SCH_ROLE_CD
		,su.ROLE_MEANING
		,su.SEQ_NBR
		,su.BEG_EFFECTIVE_DT_TM
		,su.END_DT_TM
		,su.END_EFFECTIVE_DT_TM
		,su.ORIG_BEG_DT_TM
		,su.NULL_DT_TM
		,su.VERIFY_DT_TM
		,su.VERSION_DT_TM
		,su.WRITTEN_DT_TM
		,su.ACTIVE_STATUS_DT_TM
		,su.BEG_DT_TM
		,su.GRANTED_DT_TM
		,su.ORIG_END_DT_TM
		,su.RELEASE_DT_TM
		,su.ENTERPRISE_UPDATE_DT_TM
	from 
		#sch_booking_update su
		left outer join cerner.SCH_BOOKING s on s.BOOKING_ID = su.BOOKING_ID and s.UPDT_CNT < su.UPDT_CNT
	where
		s.BOOKING_ID is not null
END

BEGIN
	delete 
	from 
		cerner.SCH_BOOKING
	where 
		BOOKING_ID in (select BOOKING_ID from #sch_booking_update_filtered)
END

BEGIN
	insert into cerner.SCH_BOOKING
	select * from #sch_booking_update_filtered
END