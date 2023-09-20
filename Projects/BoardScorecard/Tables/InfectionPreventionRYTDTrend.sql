USE [PROJECTS]
GO

/****** Object:  Table [BoardScorecard].[InfectionPreventionRYTDTrend]    Script Date: 9/19/2023 9:14:00 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [BoardScorecard].[InfectionPreventionRYTDTrend](
	[StageId] [int] NULL,
	[Start_dt] [date] NULL,
	[End_dt] [date] NULL,
	[RYTD_SIR] [float] NULL,
	[Update_dt] [datetime] NULL
) ON [PRIMARY]
GO


