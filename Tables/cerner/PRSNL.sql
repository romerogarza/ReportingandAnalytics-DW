USE [ENTERPRISE]
GO

/****** Object:  Table [cerner].[PRSNL]    Script Date: 11/29/2021 5:12:41 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [cerner].[PRSNL](
	[PERSON_ID] [int] NULL,
	[UPDT_CNT] [int] NULL,
	[UPDT_DT_TM] [datetime2](7) NULL,
	[UPDT_ID] [int] NULL,
	[UPDT_TASK] [int] NULL,
	[UPDT_APPLCTX] [int] NULL,
	[ACTIVE_IND] [int] NULL,
	[ACTIVE_STATUS_CD] [int] NULL,
	[ACTIVE_STATUS_PRSNL_ID] [int] NULL,
	[CREATE_PRSNL_ID] [int] NULL,
	[NAME_LAST_KEY] [varchar](100) NULL,
	[NAME_FIRST_KEY] [varchar](100) NULL,
	[PRSNL_TYPE_CD] [int] NULL,
	[NAME_FULL_FORMATTED] [varchar](100) NULL,
	[PASSWORD] [varchar](100) NULL,
	[EMAIL] [varchar](100) NULL,
	[PHYSICIAN_IND] [int] NULL,
	[POSITION_CD] [int] NULL,
	[DEPARTMENT_CD] [int] NULL,
	[FREE_TEXT_IND] [int] NULL,
	[SECTION_CD] [int] NULL,
	[DATA_STATUS_CD] [int] NULL,
	[DATA_STATUS_PRSNL_ID] [int] NULL,
	[CONTRIBUTOR_SYSTEM_CD] [int] NULL,
	[NAME_LAST] [varchar](200) NULL,
	[NAME_FIRST] [varchar](200) NULL,
	[USERNAME] [varchar](50) NULL,
	[FT_ENTITY_NAME] [varchar](32) NULL,
	[FT_ENTITY_ID] [int] NULL,
	[PRIM_ASSIGN_LOC_CD] [int] NULL,
	[LOG_ACCESS_IND] [int] NULL,
	[LOG_LEVEL] [int] NULL,
	[NAME_LAST_KEY_NLS] [varchar](202) NULL,
	[NAME_FIRST_KEY_NLS] [varchar](202) NULL,
	[PHYSICIAN_STATUS_CD] [int] NULL,
	[ACTIVE_STATUS_DT_TM] [datetime2](7) NULL,
	[BEG_EFFECTIVE_DT_TM] [datetime2](7) NULL,
	[CREATE_DT_TM] [datetime2](7) NULL,
	[DATA_STATUS_DT_TM] [datetime2](7) NULL,
	[END_EFFECTIVE_DT_TM] [datetime2](7) NULL,
	[LOGICAL_DOMAIN_GRP_ID] [int] NULL,
	[LOGICAL_DOMAIN_ID] [int] NULL,
	[NAME_FIRST_KEY_A_NLS] [varchar](400) NULL,
	[NAME_LAST_KEY_A_NLS] [varchar](400) NULL,
	[ENTERPRISE_UPDATE_DT_TM] [datetime2](7) NULL
) ON [PRIMARY]
GO


