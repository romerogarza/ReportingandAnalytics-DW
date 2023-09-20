USE [PROJECTS]
GO
/****** Object:  StoredProcedure [BoardScorecard].[PGValues_Update]    Script Date: 9/19/2023 9:31:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [BoardScorecard].[PGValues_Update] as

DECLARE @update_dt_tm datetime
SET @update_dt_tm = getdate()

BEGIN
	truncate table BoardScorecard.PGValues
END
BEGIN
	insert into BoardScorecard.PGValues
	select
		[Stageid]
		,[Month]
		,replace(CAST(dateadd(month,2,[Month]) as date),'-','') as DateKey
		,[PG]
		,case when right([PG],1) = 1 then 'st' when right([PG],1) = 2 then 'nd'  when right([PG],1) = 3 then 'rd' else 'th'
		end as Ending
		,1 as Active
		,@update_dt_tm as update_dt_tm
	from(
		select
			[Month]
			,[Overall Rating Monthly Percentile Ranking] as "29"
			,[Communication with Nurses Monthly Percentile Ranking] as "30"
			,[Communication with Doctors Monthly Percentile Ranking] as "31" 
			,[Responsiveness of Hospital Staff Monthly Percentile Ranking] as "32"
			,[Communication about Medicines Monthly Percentile Ranking] as "33"
			,[Discharge Information Monthly Percentile Ranking] as "34"
			,[Hospital Environment Monthly Percentile Ranking] as "35"
			,[Care Transition Monthly Percentile Ranking] as "36"
			,[Likelihood to Recommend Monthly Percentile Ranking] as "40"
			,[AS (CAHPS) Recommend the Facility Monthly Percentile Ranking] as "37"
			,[OP Likelihood to Recommend Overall Monthly Percentile Ranking] as "38"
			,[ED Satisfaction Likelihood to Recommend Monthly Percentile Ranki] as "39"
		from
			openrowset(
			'Microsoft.ACE.OLEDB.12.0',
			'Excel 8.0;HDR=YES;Database=\\nkch.org\shares\enterprise common area\statit\board\BoardScorecardWorkbooks\Patient Experience\PtExpScorecard.xlsx',
			'select * from [Qual PX Scorecard$]')
		)a
	unpivot(
		[PG] for [Stageid] in ("29","30","31","32","33","34","35","36","40","37","38", "39")
	)p
END
