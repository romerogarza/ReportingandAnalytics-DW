USE [ENTERPRISE]
GO

/****** Object:  Table [cerner].[PERSON]    Script Date: 11/29/2021 5:11:36 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [cerner].[PERSON](
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
	[PERSON_TYPE_CD] [int] NULL,
	[NAME_LAST_KEY] [varchar](100) NULL,
	[NAME_FIRST_KEY] [varchar](100) NULL,
	[NAME_FULL_FORMATTED] [varchar](100) NULL,
	[AUTOPSY_CD] [int] NULL,
	[BIRTH_DT_CD] [int] NULL,
	[CAUSE_OF_DEATH] [varchar](100) NULL,
	[DECEASED_CD] [int] NULL,
	[ETHNIC_GRP_CD] [int] NULL,
	[LANGUAGE_CD] [int] NULL,
	[MARITAL_TYPE_CD] [int] NULL,
	[PURGE_OPTION_CD] [int] NULL,
	[RACE_CD] [int] NULL,
	[RELIGION_CD] [int] NULL,
	[SEX_CD] [int] NULL,
	[SEX_AGE_CHANGE_IND] [int] NULL,
	[DATA_STATUS_CD] [int] NULL,
	[DATA_STATUS_PRSNL_ID] [int] NULL,
	[CONTRIBUTOR_SYSTEM_CD] [int] NULL,
	[LANGUAGE_DIALECT_CD] [int] NULL,
	[NAME_LAST] [varchar](200) NULL,
	[NAME_FIRST] [varchar](200) NULL,
	[NAME_PHONETIC] [varchar](8) NULL,
	[SPECIES_CD] [int] NULL,
	[CONFID_LEVEL_CD] [int] NULL,
	[VIP_CD] [int] NULL,
	[NAME_FIRST_SYNONYM_ID] [int] NULL,
	[CITIZENSHIP_CD] [int] NULL,
	[VET_MILITARY_STATUS_CD] [int] NULL,
	[MOTHER_MAIDEN_NAME] [varchar](100) NULL,
	[NATIONALITY_CD] [int] NULL,
	[FT_ENTITY_NAME] [varchar](32) NULL,
	[FT_ENTITY_ID] [int] NULL,
	[NAME_MIDDLE_KEY] [varchar](100) NULL,
	[NAME_MIDDLE] [varchar](200) NULL,
	[NAME_FIRST_PHONETIC] [varchar](8) NULL,
	[NAME_LAST_PHONETIC] [varchar](8) NULL,
	[NAME_LAST_KEY_NLS] [varchar](202) NULL,
	[NAME_FIRST_KEY_NLS] [varchar](202) NULL,
	[NAME_MIDDLE_KEY_NLS] [varchar](202) NULL,
	[MILITARY_RANK_CD] [int] NULL,
	[MILITARY_BASE_LOCATION] [varchar](100) NULL,
	[MILITARY_SERVICE_CD] [int] NULL,
	[DECEASED_SOURCE_CD] [int] NULL,
	[CAUSE_OF_DEATH_CD] [int] NULL,
	[BIRTH_TZ] [int] NULL,
	[BIRTH_PREC_FLAG] [int] NULL,
	[ARCHIVE_ENV_ID] [int] NULL,
	[ARCHIVE_STATUS_CD] [int] NULL,
	[ABS_BIRTH_DT_TM] [datetime2](7) NULL,
	[ACTIVE_STATUS_DT_TM] [datetime2](7) NULL,
	[ARCHIVE_STATUS_DT_TM] [datetime2](7) NULL,
	[CONCEPTION_DT_TM] [datetime2](7) NULL,
	[CREATE_DT_TM] [datetime2](7) NULL,
	[BIRTH_DT_TM] [datetime2](7) NULL,
	[BEG_EFFECTIVE_DT_TM] [datetime2](7) NULL,
	[DATA_STATUS_DT_TM] [datetime2](7) NULL,
	[END_EFFECTIVE_DT_TM] [datetime2](7) NULL,
	[NEXT_RESTORE_DT_TM] [datetime2](7) NULL,
	[LAST_ENCNTR_DT_TM] [datetime2](7) NULL,
	[LAST_ACCESSED_DT_TM] [datetime2](7) NULL,
	[DECEASED_DT_TM] [datetime2](7) NULL,
	[AGE_AT_DEATH] [int] NULL,
	[AGE_AT_DEATH_UNIT_CD] [int] NULL,
	[AGE_AT_DEATH_PREC_MOD_FLAG] [int] NULL,
	[DECEASED_TZ] [int] NULL,
	[DECEASED_DT_TM_PREC_FLAG] [int] NULL,
	[DECEASED_ID_METHOD_CD] [int] NULL,
	[LOGICAL_DOMAIN_ID] [int] NULL,
	[NAME_LAST_KEY_A_NLS] [varchar](400) NULL,
	[NAME_FIRST_KEY_A_NLS] [varchar](400) NULL,
	[NAME_MIDDLE_KEY_A_NLS] [varchar](400) NULL,
	[PERSON_STATUS_CD] [int] NULL,
	[ENTERPRISE_UPDATE_DT_TM] [datetime2](7) NULL
) ON [PRIMARY]
GO


