USE [PROJECTS]
GO

/****** Object:  Table [BoardScorecard].[PatientExperience]    Script Date: 9/19/2023 9:15:59 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [BoardScorecard].[PatientExperience](
	[StageID] [int] NULL,
	[MetricName] [varchar](100) NULL,
	[ShortDisplay] [varchar](100) NULL,
	[Date] [datetime] NULL,
	[Datekey] [bigint] NULL,
	[Value] [float] NULL,
	[FYTD] [float] NULL,
	[Active] [bit] NULL,
	[Update_dt_tm] [datetime] NULL
) ON [PRIMARY]
GO


