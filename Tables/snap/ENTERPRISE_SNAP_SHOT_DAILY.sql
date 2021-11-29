USE [ENTERPRISE]
GO

/****** Object:  Table [snap].[ENTERPRISE_SNAP_SHOT_DAILY]    Script Date: 11/29/2021 5:27:58 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [snap].[ENTERPRISE_SNAP_SHOT_DAILY](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[vendor] [varchar](200) NULL,
	[table] [varchar](200) NULL,
	[row_count] [bigint] NULL,
	[as_of] [date] NULL,
	[active] [bit] NULL,
	[update_dt_tm] [datetime] NULL
) ON [PRIMARY]
GO


