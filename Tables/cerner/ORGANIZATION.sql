USE [ENTERPRISE]
GO

/****** Object:  Table [cerner].[ORGANIZATION]    Script Date: 11/29/2021 5:11:00 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [cerner].[ORGANIZATION](
	[ORGANIZATION_ID] [bigint] NULL,
	[UPDT_CNT] [bigint] NULL,
	[UPDT_DT_TM] [datetime2](7) NULL,
	[UPDT_ID] [bigint] NULL,
	[UPDT_TASK] [bigint] NULL,
	[UPDT_APPLCTX] [bigint] NULL,
	[ACTIVE_IND] [bigint] NULL,
	[ACTIVE_STATUS_CD] [bigint] NULL,
	[ACTIVE_STATUS_PRSNL_ID] [bigint] NULL,
	[DATA_STATUS_CD] [bigint] NULL,
	[DATA_STATUS_PRSNL_ID] [bigint] NULL,
	[CONTRIBUTOR_SYSTEM_CD] [bigint] NULL,
	[ORG_NAME] [varchar](100) NULL,
	[ORG_NAME_KEY] [varchar](100) NULL,
	[FEDERAL_TAX_ID_NBR] [varchar](100) NULL,
	[ORG_STATUS_CD] [bigint] NULL,
	[FT_ENTITY_ID] [bigint] NULL,
	[FT_ENTITY_NAME] [varchar](32) NULL,
	[ORG_CLASS_CD] [bigint] NULL,
	[ORG_NAME_KEY_NLS] [varchar](202) NULL,
	[CONTRIBUTOR_SOURCE_CD] [bigint] NULL,
	[ACTIVE_STATUS_DT_TM] [datetime2](7) NULL,
	[BEG_EFFECTIVE_DT_TM] [datetime2](7) NULL,
	[DATA_STATUS_DT_TM] [datetime2](7) NULL,
	[END_EFFECTIVE_DT_TM] [datetime2](7) NULL,
	[LOGICAL_DOMAIN_ID] [bigint] NULL,
	[ORG_NAME_KEY_A_NLS] [varchar](400) NULL,
	[ENTERPRISE_UPDATE_DT_TM] [datetime2](7) NULL
) ON [PRIMARY]
GO


