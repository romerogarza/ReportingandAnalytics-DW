USE [PROJECTS]
GO
/****** Object:  StoredProcedure [BoardScorecard].[VBPTargets_Update]    Script Date: 9/19/2023 9:32:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [BoardScorecard].[VBPTargets_Update] as

DECLARE @update_dt_tm datetime
SET @update_dt_tm = getdate()

BEGIN

	insert into BoardScorecard.VBPTargets
	select
		StageId
		,ShortDisplay
		,Tab
		,[VBP Target] as VBP_Target
		,1 as Active
		,[Start]
		,[End]
		,@update_dt_tm as Upload_dt_tm
	from
		openrowset(
		'Microsoft.ACE.OLEDB.12.0',
		'Excel 8.0;HDR=YES;Database=\\nkch.org\shares\Enterprise Common Area\ReportingAndAnalytics\scorecard\import\targets\VBPtargets.xlsx',
		'select * from [Sheet1$]')
END
BEGIN

	DECLARE @New_update_dt_tm datetime
	SET @New_update_dt_tm = (select max(Upload_dt_tm) from BoardScorecard.VBPTargets)

	update BoardScorecard.VBPTargets
	set Active = 0
	where
		Upload_dt_tm < @New_update_dt_tm
END
