USE [PROJECTS]
GO

/****** Object:  View [BoardScorecard].[v_InpatientDays]    Script Date: 9/19/2023 9:21:52 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [BoardScorecard].[v_InpatientDays] AS

select
	UNITID
	,date
	,datekey
	,convert(int,days) as days
	,UPLOAD_DT_TM
	,CC
	,AC
from(
	select 
		f.* 
		,case when UNITID in (682892/*CICU*/,684077/*ICU*/,43697268, 43697343 /*CVICU*/) then 1 else 0 end as CC
		,case when UNITID in (683967,684032/*5 Main*/,683830,683748/*6 Main*/,3988703,3988806/*8 HSP*/,4226472,4226583,4226667/*9 HSP*/,
			17471097,17471229/*10 HSP*/,682807,682766/*10 Main*/,683418,682686/*11 Main*/) then 1 else 0 end as AC
	from InpatientDays.InpatientDaysCerner f
)a
where 
	a.CC = 1 or a.AC = 1
GO


