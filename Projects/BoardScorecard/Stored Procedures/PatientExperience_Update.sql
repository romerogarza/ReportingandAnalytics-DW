USE [PROJECTS]
GO
/****** Object:  StoredProcedure [BoardScorecard].[PatientExperience_Update]    Script Date: 9/19/2023 9:31:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [BoardScorecard].[PatientExperience_Update] AS

BEGIN
	truncate table BoardScorecard.PatientExperience
END
BEGIN

	DECLARE @update_dt_tm datetime
	SET @update_dt_tm = getdate()

	create table #patientexperience (
		Month		datetime
		,[Overall RatingTop Box Monthly]	float
		,[Likelihood to Recommend Top Box Monthly]	float
		,[Communication with Nurses Top Box Monthly]	float
		,[Responsiveness of Hospital Staff Top Box Monthly]	float
		,[Communication with Doctors Top Box Monthly]	float
		,[Hospital Environment Top Box Monthly ]	float
		,[Communication about Medicines Top Box Monthly]	float
		,[Discharge Information Top Box Monthly]	float
		,[Care Transition Top Box Monthly]	float
		,[OP Likelihood to Recommend Overall Mean Monthly]	float
		,[ED Satisfaction Likelihood to Recommend Mean Monthly]	float
		,[AS (CAHPS) Recommend the Facility Top Box Monthly]	float
		,[Overall Rating FYTD]	float
		,[Likelihood to Recommend FYTD]		float
		,[Communication with Nurse FYTD]	float
		,[Responsiveness of Hospital Staff FYTD]	float
		,[Communication with Doctors FYTD]	float
		,[Hospital Environment FYTD]	float
		,[Communication about Medicines FYTD]	float
		,[Discharge Information FYTD]	float
		,[Care Transition FYTD]	float
		,[OP Likelihood to Recommend Overall FYTD]	float
		,[ED Satisfaction Likelihood to Recommend FYTD]	float
		,[AS (CAHPS) Recommend the Facility Top Box FYTD]	float
	)

	insert into #patientexperience
	select
		Month
		,[Overall RatingTop Box Monthly]
		,[Likelihood to Recommend Top Box Monthly]
		,[Communication with Nurses Top Box Monthly]
		,[Responsiveness of Hospital Staff Top Box Monthly]
		,[Communication with Doctors Top Box Monthly]
		,[Hospital Environment Top Box Monthly ]
		,[Communication about Medicines Top Box Monthly]
		,[Discharge Information Top Box Monthly]
		,[Care Transition Top Box Monthly]
		,[OP Likelihood to Recommend Overall Mean Monthly]
		,[ED Satisfaction Likelihood to Recommend Mean Monthly]
		,[AS (CAHPS) Recommend the Facility Top Box Monthly]
		,[Overall Rating FYTD]
		,[Likelihood to Recommend FYTD]
		,[Communication with Nurse FYTD]
		,[Responsiveness of Hospital Staff FYTD]
		,[Communication with Doctors FYTD]
		,[Hospital Environment FYTD]
		,[Communication about Medicines FYTD]
		,[Discharge Information FYTD]
		,[Care Transition FYTD]
		,[OP Likelihood to Recommend Overall FYTD]
		,[ED Satisfaction Likelihood to Recommend FYTD]
		,[AS (CAHPS) Recommend the Facility Top Box FYTD]
	from
		openrowset(
		'Microsoft.ACE.OLEDB.12.0',
		'Excel 8.0;HDR=YES;Database=\\nkch.org\shares\enterprise common area\statit\board\BoardScorecardWorkbooks\Patient Experience\PtExpScorecard.xlsx',
		'select * from [Qual PX Scorecard$]')
	where
		[Month] is not null

	insert into BoardScorecard.PatientExperience
	select
		29 as StageId
		,'INPATIENTSATISFACTIONOVERALLRATING%SCORE' as MetricName
		,'Inpatient Satisfaction Overall Rating % Score' as ShortDisplay
		,month as date
		,replace(cast(month as date), '-','') as datekey
		,[Overall RatingTop Box Monthly] as value
		,[Overall Rating FYTD] as FYTD
		,1 as active
		,@update_dt_tm as update_dt_tm
	from
		#patientexperience
	union all
	select
		30 as StageId
		,'NURSECOMMUNICATION' as MetricName
		,'Nurse Communication' as ShortDisplay
		,month as date
		,replace(cast(month as date), '-','') as datekey
		,[Communication with Nurses Top Box Monthly] as value
		,[Communication with Nurse FYTD] as FYTD
		,1 as active
		,@update_dt_tm as update_dt_tm
	from
		#patientexperience
	union all
	select
		31 as StageId
		,'DOCTORCOMMUNICATION' as MetricName
		,'Doctor Communication' as ShortDisplay
		,month as date
		,replace(cast(month as date), '-','') as datekey
		,[Communication with Doctors Top Box Monthly] as value
		,[Communication with Doctors FYTD] as FYTD
		,1 as active
		,@update_dt_tm as update_dt_tm
	from
		#patientexperience
	union all
	select
		32 as StageId
		,'RESPONSIVENESSOFHOSPITALSTAFF' as MetricName
		,'Responsiveness of Hospital Staff' as ShortDisplay
		,month as date
		,replace(cast(month as date), '-','') as datekey
		,[Responsiveness of Hospital Staff Top Box Monthly] as value
		,[Responsiveness of Hospital Staff FYTD] as FYTD
		,1 as active
		,@update_dt_tm as update_dt_tm
	from
		#patientexperience
	union all
	select
		33 as StageId
		,'COMMUNICATIONABOUTMEDICATIONS' as MetricName
		,'Communication About Medications' as ShortDisplay
		,month as date
		,replace(cast(month as date), '-','') as datekey
		,[Communication about Medicines Top Box Monthly] as value
		,[Communication about Medicines FYTD] as FYTD
		,1 as active
		,@update_dt_tm as update_dt_tm
	from
		#patientexperience
	union all
	select
		34 as StageId
		,'DISCHARGEINFORMATION' as MetricName
		,'Discharge Information' as ShortDisplay
		,month as date
		,replace(cast(month as date), '-','') as datekey
		,[Discharge Information Top Box Monthly] as value
		,[Discharge Information FYTD] as FYTD
		,1 as active
		,@update_dt_tm as update_dt_tm
	from
		#patientexperience
	union all
	select
		35 as StageId
		,'HOSPITALCLEANLINESSANDQUIETNESS' as MetricName
		,'Hospital Cleanliness and Quietness' as ShortDisplay
		,month as date
		,replace(cast(month as date), '-','') as datekey
		,[Hospital Environment Top Box Monthly ] as value
		,[Hospital Environment FYTD] as FYTD
		,1 as active
		,@update_dt_tm as update_dt_tm
	from
		#patientexperience
	union all
	select
		36 as StageId
		,'CARETRANSITION' as MetricName
		,'Care Transition' as ShortDisplay
		,month as date
		,replace(cast(month as date), '-','') as datekey
		,[Care Transition Top Box Monthly] as value
		,[Care Transition FYTD] as FYTD
		,1 as active
		,@update_dt_tm as update_dt_tm
	from
		#patientexperience
	union all
	select
		37 as StageId
		,'ASRECOMMENDTHEFACILTIYTOPBOX' as MetricName
		,'AS Recommend the Faciltiy Top Box' as ShortDisplay
		,month as date
		,replace(cast(month as date), '-','') as datekey
		,[AS (CAHPS) Recommend the Facility Top Box Monthly] as value
		,[AS (CAHPS) Recommend the Facility Top Box FYTD] as FYTD
		,1 as active
		,@update_dt_tm as update_dt_tm
	from
		#patientexperience
	union all
	select
		38 as StageId
		,'OPLIKELIHOODTORECOMMENDOVERALLMEAN' as MetricName
		,'OP Likelihood to Recommend Overall Mean' as ShortDisplay
		,month as date
		,replace(cast(month as date), '-','') as datekey
		,[OP Likelihood to Recommend Overall Mean Monthly] as value
		,[OP Likelihood to Recommend Overall FYTD] as FYTD
		,1 as active
		,@update_dt_tm as update_dt_tm
	from
		#patientexperience
	union all
	select
		39 as StageId
		,'EDSATISFACTIONLIKELIHOODTORECOMMENDOVERALLMEAN' as MetricName
		,'ED Satisfaction Likelihood to Recommend Overall Mean' as ShortDisplay
		,month as date
		,replace(cast(month as date), '-','') as datekey
		,[ED Satisfaction Likelihood to Recommend Mean Monthly] as value
		,[ED Satisfaction Likelihood to Recommend FYTD] as FYTD
		,1 as active
		,@update_dt_tm as update_dt_tm
	from
		#patientexperience
	union all
	select
		40 as StageId
		,'LIKELIHOODTORECOMMEND' as MetricName
		,'Likelihood to Recommend' as ShortDisplay
		,month as date
		,replace(cast(month as date), '-','') as datekey
		,[Likelihood to Recommend Top Box Monthly] as value
		,[Likelihood to Recommend FYTD] as FYTD
		,1 as active
		,@update_dt_tm as update_dt_tm
	from
		#patientexperience

	drop table #patientexperience
END
