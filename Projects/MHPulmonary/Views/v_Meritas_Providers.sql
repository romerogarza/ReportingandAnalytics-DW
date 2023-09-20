USE [PROJECTS]
GO

/****** Object:  View [MHPulmonary].[v_Meritas_Providers]    Script Date: 9/19/2023 9:01:10 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


create view [MHPulmonary].[v_Meritas_Providers] as

select
	p.name_full_formatted as physician
	,(select display from enterprise.cerner.code_value where code_value = p.prsnl_type_cd) as prsnl_type
	,(select display from enterprise.cerner.code_value where code_value = p.position_cd) as position
	,(select display from enterprise.cerner.code_value where code_value = p.physician_status_cd) as physician_status
	,p.physician_ind
	,(select display from enterprise.cerner.code_value where code_value = pg.prsnl_group_type_cd) as prsnl_group_type
	,pg.PRSNL_GROUP_NAME
	,pg.PRSNL_GROUP_DESC
	,(select display from enterprise.cerner.code_value where code_value = pg.PRSNL_GROUP_CLASS_CD) as PRSNL_GROUP_CLASS
from
	enterprise.cerner.PRSNL_GROUP_RELTN pgr
	join enterprise.cerner.PRSNL p on p.person_id = pgr.person_id and p.active_ind = 1 and physician_ind = 1
	join enterprise.cerner.PRSNL_GROUP pg on pg.PRSNL_GROUP_ID = pgr.PRSNL_GROUP_ID
where
	pg.prsnl_group_type_cd = 907310301 --Meritas Health Providers
GO


