USE [ENTERPRISE]
GO

/****** Object:  Table [cerner].[SCH_BOOKING]    Script Date: 11/29/2021 5:13:56 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [cerner].[SCH_BOOKING](
	[BOOKING_ID] [bigint] NULL,
	[RESOURCE_CD] [bigint] NULL,
	[PERSON_ID] [bigint] NULL,
	[APPLY_SLOT_ID] [bigint] NULL,
	[STATUS_FLAG] [bigint] NULL,
	[STATUS_MEANING] [varchar](12) NULL,
	[GRANTED_PRSNL_ID] [bigint] NULL,
	[RELEASE_PRSNL_ID] [bigint] NULL,
	[FORCE_IND] [bigint] NULL,
	[ENCNTR_ID] [bigint] NULL,
	[CANDIDATE_ID] [bigint] NULL,
	[ACTIVE_IND] [bigint] NULL,
	[ACTIVE_STATUS_CD] [bigint] NULL,
	[ACTIVE_STATUS_PRSNL_ID] [bigint] NULL,
	[UPDT_DT_TM] [datetime2](7) NULL,
	[UPDT_APPLCTX] [bigint] NULL,
	[UPDT_ID] [bigint] NULL,
	[UPDT_CNT] [bigint] NULL,
	[UPDT_TASK] [bigint] NULL,
	[APPT_TYPE_CD] [bigint] NULL,
	[LOCATION_CD] [bigint] NULL,
	[SCH_ROLE_CD] [bigint] NULL,
	[ROLE_MEANING] [varchar](12) NULL,
	[SEQ_NBR] [bigint] NULL,
	[BEG_EFFECTIVE_DT_TM] [datetime2](7) NULL,
	[END_DT_TM] [datetime2](7) NULL,
	[END_EFFECTIVE_DT_TM] [datetime2](7) NULL,
	[ORIG_BEG_DT_TM] [datetime2](7) NULL,
	[NULL_DT_TM] [datetime2](7) NULL,
	[VERIFY_DT_TM] [datetime2](7) NULL,
	[VERSION_DT_TM] [datetime2](7) NULL,
	[WRITTEN_DT_TM] [datetime2](7) NULL,
	[ACTIVE_STATUS_DT_TM] [datetime2](7) NULL,
	[BEG_DT_TM] [datetime2](7) NULL,
	[GRANTED_DT_TM] [datetime2](7) NULL,
	[ORIG_END_DT_TM] [datetime2](7) NULL,
	[RELEASE_DT_TM] [datetime2](7) NULL,
	[ENTERPRISE_UPDATE_DT_TM] [datetime2](7) NULL
) ON [PRIMARY]
GO


