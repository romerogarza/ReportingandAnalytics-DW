USE [PROJECTS]
GO

/****** Object:  Table [BoardScorecard].[MeritasPrimaryCare]    Script Date: 9/19/2023 9:15:00 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [BoardScorecard].[MeritasPrimaryCare](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[StageID] [int] NULL,
	[Date] [date] NULL,
	[Datekey] [varchar](10) NULL,
	[Start_reporting_date] [date] NULL,
	[End_reporting_date] [date] NULL,
	[Value] [float] NULL,
	[Active] [bit] NULL,
	[Upload_dt_tm] [datetime] NULL
) ON [PRIMARY]
GO


