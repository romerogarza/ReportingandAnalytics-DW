USE [PROJECTS]
GO

/****** Object:  Table [MHPulmonary].[referrals]    Script Date: 9/19/2023 8:59:32 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [MHPulmonary].[referrals](
	[REFERRAL_ID] [bigint] NULL,
	[REFERED_FROM_OR_TO] [varchar](255) NULL,
	[LAST_PERFORMED_ACTION] [varchar](255) NULL,
	[MEDICAL_SERVICE] [varchar](255) NULL,
	[PATIENT] [varchar](255) NULL,
	[REFER_FROM_ORGANIZATION] [varchar](255) NULL,
	[REFER_FROM_PROVIDER] [varchar](255) NULL,
	[REFER_TO_PROVIDER] [varchar](255) NULL,
	[REFERRAL_CATEGORY] [varchar](255) NULL,
	[REFERRAL_PRIORITY] [varchar](255) NULL,
	[REFERRAL_WRITTEN_DT_TM] [datetime] NULL,
	[CREATE_DT_TM] [datetime] NULL,
	[SERVICE_TYPE_REQUESTED] [varchar](255) NULL,
	[SERVICE_BY_DT_TM] [datetime] NULL,
	[REQUESTED_START_DT_TM] [datetime] NULL,
	[OUTBOUND_ASSIGNED_PRSNL] [varchar](255) NULL,
	[INBOUND_ASSIGNED_PRSNL] [varchar](255) NULL,
	[OUTBOUND_ENCNTR_ID] [bigint] NULL,
	[ORDER_ID] [bigint] NULL,
	[REFERRAL_STATUS] [varchar](255) NULL,
	[REFER_FROM_PRACTICE_SITE_ID] [varchar](255) NULL,
	[REFER_TO_PRACTICE_SITE_ID] [varchar](255) NULL,
	[REFER_FROM_LOC] [varchar](255) NULL,
	[UPDATE_DT_TM] [datetime] NULL
) ON [PRIMARY]
GO

