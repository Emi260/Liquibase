--liquibase formatted sql
--changeset none:none enddelimiter:\nGO runOnChange:true

IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwDepotOrderFactorsBack]'))
EXEC dbo.sp_executesql @statement = N' 

CREATE OR ALTER VIEW [dbo].[vwDepotOrderFactorsBack] 
AS  select Campo1=1' 
GO


