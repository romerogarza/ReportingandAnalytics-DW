USE [PROJECTS]
GO

/****** Object:  Table [BoardScorecard].[MortalityRate]    Script Date: 9/19/2023 9:15:28 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [BoardScorecard].[MortalityRate](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[StageID] [int] NULL,
	[Date] [date] NULL,
	[DateKey] [varchar](10) NULL,
	[Value] [float] NULL,
	[FTYD] [float] NULL,
	[Active] [bit] NULL,
	[Upload_dt_tm] [datetime] NULL
) ON [PRIMARY]
GO


