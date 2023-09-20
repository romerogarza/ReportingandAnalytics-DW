USE [PROJECTS]
GO

/****** Object:  Table [BoardScorecard].[PGValues]    Script Date: 9/19/2023 9:16:28 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [BoardScorecard].[PGValues](
	[StageID] [int] NULL,
	[Month] [datetime] NULL,
	[DateKey] [varchar](10) NULL,
	[PG] [int] NULL,
	[Ending] [varchar](2) NULL,
	[Active] [bit] NULL,
	[Update_dt_tm] [datetime] NULL
) ON [PRIMARY]
GO


