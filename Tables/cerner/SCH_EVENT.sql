USE [ENTERPRISE]
GO

/****** Object:  Table [cerner].[SCH_EVENT]    Script Date: 11/29/2021 5:14:32 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [cerner].[SCH_EVENT](
	[SCH_EVENT_ID] [int] NULL,
	[APPT_TYPE_CD] [int] NULL,
	[APPT_SYNONYM_CD] [int] NULL,
	[OE_FORMAT_ID] [int] NULL,
	[ORDER_SENTENCE_ID] [int] NULL,
	[SCHEDULE_SEQ] [int] NULL,
	[SCH_STATE_CD] [int] NULL,
	[SCH_MEANING] [varchar](12) NULL,
	[CONTRIBUTOR_SYSTEM_CD] [int] NULL,
	[APPT_SYNONYM_FREE] [varchar](255) NULL,
	[APPT_REASON_FREE] [varchar](255) NULL,
	[REQ_PRSNL_ID] [int] NULL,
	[CANDIDATE_ID] [int] NULL,
	[ACTIVE_IND] [int] NULL,
	[ACTIVE_STATUS_CD] [int] NULL,
	[ACTIVE_STATUS_PRSNL_ID] [int] NULL,
	[UPDT_DT_TM] [datetime2](7) NULL,
	[UPDT_APPLCTX] [int] NULL,
	[UPDT_ID] [int] NULL,
	[UPDT_CNT] [int] NULL,
	[UPDT_TASK] [int] NULL,
	[RECUR_TYPE_FLAG] [int] NULL,
	[RECUR_PARENT_ID] [int] NULL,
	[RECUR_TEMPLATE_ID] [int] NULL,
	[RECUR_SEQ_NBR] [int] NULL,
	[EVENT_RECUR_ID] [int] NULL,
	[PROTOCOL_TYPE_FLAG] [int] NULL,
	[ESO_SEND_IND] [int] NULL,
	[OFFSET_BEG_UNITS] [int] NULL,
	[OFFSET_BEG_UNITS_CD] [int] NULL,
	[OFFSET_BEG_UNITS_MEANING] [varchar](12) NULL,
	[OFFSET_END_UNITS] [int] NULL,
	[OFFSET_END_UNITS_CD] [int] NULL,
	[OFFSET_END_UNITS_MEANING] [varchar](12) NULL,
	[OFFSET_EVENT_ID] [int] NULL,
	[OFFSET_FROM_CD] [int] NULL,
	[OFFSET_FROM_MEANING] [varchar](12) NULL,
	[OFFSET_TYPE_CD] [int] NULL,
	[OFFSET_TYPE_MEANING] [varchar](12) NULL,
	[PROTOCOL_PARENT_ID] [int] NULL,
	[PROTOCOL_SEQ_NBR] [int] NULL,
	[GRP_DESC] [varchar](255) NULL,
	[GRP_CAPACITY] [int] NULL,
	[GRP_NBR_SCHED] [int] NULL,
	[GRP_FLAG] [int] NULL,
	[GRP_SHARED_IND] [int] NULL,
	[GRP_CLOSED_IND] [int] NULL,
	[EVENT_CLASS_CD] [int] NULL,
	[SCH_EVENT_SEQ] [int] NULL,
	[ACTIVE_STATUS_DT_TM] [datetime2](7) NULL,
	[BEG_EFFECTIVE_DT_TM] [datetime2](7) NULL,
	[END_EFFECTIVE_DT_TM] [datetime2](7) NULL,
	[GRP_BEG_DT_TM] [datetime2](7) NULL,
	[GRP_END_DT_TM] [datetime2](7) NULL,
	[NULL_DT_TM] [datetime2](7) NULL,
	[REFER_DT_TM] [datetime2](7) NULL,
	[VERSION_DT_TM] [datetime2](7) NULL,
	[REFER_PRINTED_IND] [int] NULL,
	[ENTERPRISE_UPDATE_DT_TM] [datetime2](7) NULL
) ON [PRIMARY]
GO


