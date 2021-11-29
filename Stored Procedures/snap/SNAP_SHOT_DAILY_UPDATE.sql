USE [ENTERPRISE]
GO
/****** Object:  StoredProcedure [snap].[SNAP_SHOT_DAILY_UPDATE]    Script Date: 11/29/2021 5:25:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [snap].[SNAP_SHOT_DAILY_UPDATE] as

BEGIN
	DECLARE @date DATE
	DECLARE @currentdate DATE
	SET @date = (select max(as_of) as as_of from [snap].[ENTERPRISE_SNAP_SHOT_DAILY])
	SET @currentdate = convert(date,getdate())
	
	if @date = @currentdate
		update [snap].[ENTERPRISE_SNAP_SHOT_DAILY]
		set active = 0
		where as_of = @currentdate
END

BEGIN
	INSERT INTO snap.ENTERPRISE_SNAP_SHOT_DAILY
	select
		'cerner' as [vendor]
		,'ENCOUNTER' as [table]
		,count(*) as row_count
		,case when convert(date,max(enterprise_update_dt_tm)) is null then convert(date,getdate()) else convert(date,max(enterprise_update_dt_tm)) end as as_of
		,1 as active
		,getdate() as update_dt_tm
	from
		cerner.ENCOUNTER
	union all
	select
		'cerner' as [vendor]
		,'CODE_VALUE' as [table]
		,count(*) as row_count
		,case when convert(date,max(enterprise_update_dt_tm)) is null then convert(date,getdate()) else convert(date,max(enterprise_update_dt_tm)) end as as_of
		,1 as active
		,getdate() as update_dt_tm
	from
		cerner.CODE_VALUE
	union all
	select
		'cerner' as [vendor]
		,'ENCNTR_ALIAS' as [table]
		,count(*) as row_count
		,case when convert(date,max(enterprise_update_dt_tm)) is null then convert(date,getdate()) else convert(date,max(enterprise_update_dt_tm)) end as as_of
		,1 as active
		,getdate() as update_dt_tm
	from
		cerner.ENCNTR_ALIAS
	union all
	select
		'cerner' as [vendor]
		,'ENCNTR_LOC_HIST' as [table]
		,count(*) as row_count
		,case when convert(date,max(enterprise_update_dt_tm)) is null then convert(date,getdate()) else convert(date,max(enterprise_update_dt_tm)) end as as_of
		,1 as active
		,getdate() as update_dt_tm
	from
		cerner.ENCNTR_LOC_HIST
	union all
	select
		'cerner' as [vendor]
		,'PERSON' as [table]
		,count(*) as row_count
		,case when convert(date,max(enterprise_update_dt_tm)) is null then convert(date,getdate()) else convert(date,max(enterprise_update_dt_tm)) end as as_of
		,1 as active
		,getdate() as update_dt_tm
	from
		cerner.PERSON
	union all
	select
		'cerner' as [vendor]
		,'PRSNL' as [table]
		,count(*) as row_count
		,case when convert(date,max(enterprise_update_dt_tm)) is null then convert(date,getdate()) else convert(date,max(enterprise_update_dt_tm)) end as as_of
		,1 as active
		,getdate() as update_dt_tm
	from
		cerner.PRSNL
	union all
	select
		'cerner' as [vendor]
		,'SCH_APPT' as [table]
		,count(*) as row_count
		,case when convert(date,max(enterprise_update_dt_tm)) is null then convert(date,getdate()) else convert(date,max(enterprise_update_dt_tm)) end as as_of
		,1 as active
		,getdate() as update_dt_tm
	from
		cerner.SCH_APPT
	union all
	select
		'cerner' as [vendor]
		,'SCH_BOOKING' as [table]
		,count(*) as row_count
		,case when convert(date,max(enterprise_update_dt_tm)) is null then convert(date,getdate()) else convert(date,max(enterprise_update_dt_tm)) end as as_of
		,1 as active
		,getdate() as update_dt_tm
	from
		cerner.SCH_BOOKING
	union all
	select
		'cerner' as [vendor]
		,'SCH_EVENT' as [table]
		,count(*) as row_count
		,case when convert(date,max(enterprise_update_dt_tm)) is null then convert(date,getdate()) else convert(date,max(enterprise_update_dt_tm)) end as as_of
		,1 as active
		,getdate() as update_dt_tm
	from
		cerner.SCH_EVENT
	union all
	select
		'cerner' as [vendor]
		,'ENCNTR_FINANCIAL' as [table]
		,count(*) as row_count
		,case when convert(date,max(enterprise_update_dt_tm)) is null then convert(date,getdate()) else convert(date,max(enterprise_update_dt_tm)) end as as_of
		,1 as active
		,getdate() as update_dt_tm
	from
		cerner.ENCNTR_FINANCIAL
	union all
	select
		'cerner' as [vendor]
		,'ORGANIZATION' as [table]
		,count(*) as row_count
		,case when convert(date,max(enterprise_update_dt_tm)) is null then convert(date,getdate()) else convert(date,max(enterprise_update_dt_tm)) end as as_of
		,1 as active
		,getdate() as update_dt_tm
	from
		cerner.ORGANIZATION
	union all
	select
		'cerner' as [vendor]
		,'ORDERS' as [table]
		,count(*) as row_count
		,case when convert(date,max(enterprise_update_dt_tm)) is null then convert(date,getdate()) else convert(date,max(enterprise_update_dt_tm)) end as as_of
		,1 as active
		,getdate() as update_dt_tm
	from
		cerner.ORDERS
	union all
	select
		'cerner' as [vendor]
		,'ENCOUNTER_HISTORY' as [table]
		,count(*) as row_count
		,case when convert(date,max(enterprise_update_dt_tm)) is null then convert(date,getdate()) else convert(date,max(enterprise_update_dt_tm)) end as as_of
		,1 as active
		,getdate() as update_dt_tm
	from
		cerner.ENCOUNTER_HISTORY
END