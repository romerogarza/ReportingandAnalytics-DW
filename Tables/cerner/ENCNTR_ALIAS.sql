USE [ENTERPRISE]
GO

/****** Object:  Table [cerner].[ENCNTR_ALIAS]    Script Date: 11/29/2021 5:06:09 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [cerner].[ENCNTR_ALIAS](
	[ENCNTR_ALIAS_ID] [bigint] NULL,
	[ENCNTR_ID] [bigint] NULL,
	[UPDT_CNT] [bigint] NULL,
	[UPDT_DT_TM] [datetime2](7) NULL,
	[UPDT_ID] [bigint] NULL,
	[UPDT_TASK] [bigint] NULL,
	[UPDT_APPLCTX] [bigint] NULL,
	[ACTIVE_IND] [bigint] NULL,
	[ACTIVE_STATUS_CD] [bigint] NULL,
	[ACTIVE_STATUS_DT_TM] [datetime2](7) NULL,
	[ACTIVE_STATUS_PRSNL_ID] [bigint] NULL,
	[ALIAS_POOL_CD] [bigint] NULL,
	[ENCNTR_ALIAS_TYPE_CD] [bigint] NULL,
	[ALIAS] [varchar](200) NULL,
	[ENCNTR_ALIAS_SUB_TYPE_CD] [bigint] NULL,
	[CHECK_DIGIT] [bigint] NULL,
	[CHECK_DIGIT_METHOD_CD] [bigint] NULL,
	[BEG_EFFECTIVE_DT_TM] [datetime2](7) NULL,
	[END_EFFECTIVE_DT_TM] [datetime2](7) NULL,
	[DATA_STATUS_CD] [bigint] NULL,
	[DATA_STATUS_DT_TM] [datetime2](7) NULL,
	[DATA_STATUS_PRSNL_ID] [bigint] NULL,
	[CONTRIBUTOR_SYSTEM_CD] [bigint] NULL,
	[ASSIGN_AUTHORITY_SYS_CD] [bigint] NULL,
	[ENTERPRISE_UPDATE_DT_TM] [datetime2](7) NULL
) ON [PRIMARY]
GO


