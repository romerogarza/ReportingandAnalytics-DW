USE [PROJECTS]
GO

/****** Object:  Table [MHPulmonary].[referral_appointments]    Script Date: 9/19/2023 8:58:11 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [MHPulmonary].[referral_appointments](
	[SCH_APPT_ID] [bigint] NULL,
	[PATIENT] [varchar](255) NULL,
	[GENDER] [varchar](100) NULL,
	[DURATION] [int] NULL,
	[SCH_APPT_STATE] [varchar](100) NULL,
	[SCH_ROLE] [varchar](100) NULL,
	[APPT_LOCATION] [varchar](255) NULL,
	[APPT_START_TIME] [datetime] NULL,
	[APPT_END_TIME] [datetime] NULL,
	[APPT_TYPE] [varchar](100) NULL,
	[PHYSICIAN] [varchar](255) NULL,
	[DIAGNOSIS] [varchar](255) NULL,
	[NOMENCLATURE] [varchar](255) NULL,
	[DIAGNOSIS_CODE] [varchar](100) NULL,
	[ENCNTR_ID] [bigint] NULL,
	[UPDATE_DT_TM] [datetime] NULL
) ON [PRIMARY]
GO


