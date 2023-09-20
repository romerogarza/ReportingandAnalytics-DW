USE [PROJECTS]
GO

/****** Object:  Table [BoardScorecard].[InfectionPrevention]    Script Date: 9/19/2023 9:13:29 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [BoardScorecard].[InfectionPrevention](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[StageID] [int] NULL,
	[Date] [date] NULL,
	[DateKey] [varchar](10) NULL,
	[DateDisplay] [date] NULL,
	[Value] [float] NULL,
	[FTYD] [float] NULL,
	[Active] [bit] NULL,
	[Upload_dt_tm] [datetime] NULL
) ON [PRIMARY]
GO


