USE [PROJECTS]
GO

/****** Object:  Table [BoardScorecard].[Readmissions]    Script Date: 9/19/2023 9:16:55 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [BoardScorecard].[Readmissions](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[StageID] [int] NULL,
	[Date] [date] NULL,
	[Datekey] [varchar](10) NULL,
	[value] [float] NULL,
	[FYTD] [float] NULL,
	[Active] [bit] NULL,
	[Upload_dt_tm] [datetime] NULL
) ON [PRIMARY]
GO


