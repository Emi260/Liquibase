--liquibase formatted sql
--changeset none:none enddelimiter:\nGO runOnChange:true
/****** Object:  StoredProcedure [dbo].[isValidateStockTransfer]    Script Date: 8/14/2020 8:20:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[isValidateStockTransfer]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[isValidateStockTransfer] AS' 
END
GO
	 --DECLARE @outField int;
	 --EXEC isValidateBusinessPartnerTransfer '22', @outField=@outField OUTPUT
	 --SELECT @outField
	ALTER PROCEDURE [dbo].[isValidateStockTransfer]
		@EquipmentNo varchar(255) NULL=NULL,
		@EquipmentStatusType varchar(255) NULL=NULL,
		@Yarda varchar(255) NULL=NULL,
		@Area varchar(255) NULL=NULL,
		@Block varchar(255) NULL=NULL,
		@BlockTypeCode varchar(255) NULL=NULL,
		@EquipmentActivityType varchar(255) NULL=NULL,
		@VesselCode varchar(255) NULL=NULL,
		@Vessel varchar(255) NULL=NULL,
		@IMO varchar(255) NULL=NULL,
		@Voyage varchar(255) NULL=NULL,
		@BoxCondition varchar(255) NULL=NULL,
		@ReeferCondition varchar(255) NULL=NULL,
		@Class varchar(255) NULL=NULL,
		@ActivityDateGateIn varchar(255) NULL=NULL,
		@isValid int OUTPUT,
		@validationReport nvarchar(255) OUTPUT
	AS
	BEGIN
		SET NOCOUNT ON;
		SELECT @isValid=1;
		SELECT @validationReport='';
		DECLARE @Count INT=NULL;

		-- Valida que no exista duplicidad de numero de equipo
		SELECT @Count=COUNT(EquipmentNo)
		FROM EquipmentTransfer
		WHERE EquipmentNo=@EquipmentNo;

		IF(@Count =0)
		BEGIN
			SELECT @isValid=0;
			SELECT @validationReport='@EquipmentNo, no existe en Equipment '+ ' - ' + CAST( GETDATE() AS NVARCHAR(255));
		END
	END
GO
