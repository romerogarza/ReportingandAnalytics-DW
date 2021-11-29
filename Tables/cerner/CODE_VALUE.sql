USE [ENTERPRISE]
GO

/****** Object:  Table [cerner].[CODE_VALUE]    Script Date: 11/29/2021 5:04:42 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [cerner].[CODE_VALUE](
	[CODE_VALUE] [int] NULL,
	[CODE_SET] [int] NULL,
	[CDF_MEANING] [varchar](12) NULL,
	[DISPLAY] [varchar](40) NULL,
	[DISPLAY_KEY] [varchar](40) NULL,
	[DESCRIPTION] [varchar](60) NULL,
	[DEFINITION] [varchar](100) NULL,
	[COLLATION_SEQ] [int] NULL,
	[ACTIVE_TYPE_CD] [int] NULL,
	[ACTIVE_IND] [int] NULL,
	[UPDT_DT_TM] [datetime2](7) NULL,
	[UPDT_ID] [int] NULL,
	[UPDT_CNT] [int] NULL,
	[UPDT_TASK] [int] NULL,
	[UPDT_APPLCTX] [int] NULL,
	[DATA_STATUS_CD] [int] NULL,
	[DATA_STATUS_PRSNL_ID] [int] NULL,
	[ACTIVE_STATUS_PRSNL_ID] [int] NULL,
	[CKI] [varchar](255) NULL,
	[DISPLAY_KEY_NLS] [varchar](255) NULL,
	[CONCEPT_CKI] [varchar](255) NULL,
	[ACTIVE_DT_TM] [datetime2](7) NULL,
	[BEGIN_EFFECTIVE_DT_TM] [datetime2](7) NULL,
	[DATA_STATUS_DT_TM] [datetime2](7) NULL,
	[END_EFFECTIVE_DT_TM] [datetime2](7) NULL,
	[INACTIVE_DT_TM] [datetime2](7) NULL,
	[DISPLAY_KEY_A_NLS] [varchar](160) NULL,
	[ENTERPRISE_UPDATE_DT_TM] [datetime2](7) NULL
) ON [PRIMARY]
GO


