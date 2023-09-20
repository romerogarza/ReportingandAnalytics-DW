USE [PROJECTS]
GO

/****** Object:  Table [BoardScorecard].[Targets]    Script Date: 9/19/2023 9:17:27 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [BoardScorecard].[Targets](
	[StageID] [int] NULL,
	[Target] [float] NULL,
	[StretchGoal] [float] NULL,
	[VBPThreshold] [float] NULL,
	[FY] [nvarchar](100) NULL,
	[Upload_dt_tm] [datetime] NULL,
	[Active] [bit] NULL
) ON [PRIMARY]
GO


