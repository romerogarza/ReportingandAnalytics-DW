USE [PROJECTS]
GO

/****** Object:  Table [BoardScorecard].[MeritasPatientExperience]    Script Date: 9/19/2023 9:14:32 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [BoardScorecard].[MeritasPatientExperience](
	[StageId] [int] NOT NULL,
	[Date] [date] NOT NULL,
	[Datekey] [varchar](10) NOT NULL,
	[CurrentValue] [float] NULL,
	[FYTD] [float] NULL,
	[Active] [bit] NOT NULL,
	[Upload_dt_tm] [datetime] NOT NULL
) ON [PRIMARY]
GO


