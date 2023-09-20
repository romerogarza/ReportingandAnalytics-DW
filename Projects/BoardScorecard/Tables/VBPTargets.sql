USE [PROJECTS]
GO

/****** Object:  Table [BoardScorecard].[VBPTargets]    Script Date: 9/19/2023 9:18:10 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [BoardScorecard].[VBPTargets](
	[StageID] [int] NULL,
	[ShortDisplay] [varchar](1000) NULL,
	[Tab] [varchar](1000) NULL,
	[VBP_Target] [float] NULL,
	[Top_Decile] [float] NULL,
	[Active] [bit] NULL,
	[Start] [datetime] NULL,
	[End] [datetime] NULL,
	[Upload_dt_tm] [datetime] NULL
) ON [PRIMARY]
GO


