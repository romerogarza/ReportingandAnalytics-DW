USE [PROJECTS]
GO

/****** Object:  Table [BoardScorecard].[HipandSepsis]    Script Date: 9/19/2023 9:11:58 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [BoardScorecard].[HipandSepsis](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[StageID] [int] NULL,
	[Date] [date] NULL,
	[Datekey] [varchar](10) NULL,
	[Value] [float] NULL,
	[FYTD] [float] NULL,
	[Active] [bit] NULL,
	[Upload_dt_tm] [datetime] NULL
) ON [PRIMARY]
GO


