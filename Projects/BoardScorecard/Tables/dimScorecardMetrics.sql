USE [PROJECTS]
GO

/****** Object:  Table [BoardScorecard].[dimScorecardMetrics]    Script Date: 9/19/2023 9:09:30 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [BoardScorecard].[dimScorecardMetrics](
	[StageId] [int] IDENTITY(1,1) NOT NULL,
	[MetricName] [varchar](100) NOT NULL,
	[ShortDisplay] [varchar](100) NULL,
	[Description] [varchar](200) NULL,
	[HelpText] [varchar](200) NULL,
	[SortOrder] [int] NOT NULL,
	[Tab] [nvarchar](50) NULL,
	[Table] [int] NULL
) ON [PRIMARY]
GO


