--liquibase formatted sql
--changeset none:none enddelimiter:\nGO runOnChange:true
/****** Object:  StoredProcedure [dbo].[isValidateTruckTransfer]    Script Date: 8/14/2020 8:20:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[isValidateTruckTransfer]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[isValidateTruckTransfer] AS' 
END
GO
	 --DECLARE @outField int;
	 --EXEC isValidateBusinessPartnerTransfer '22', @outField=@outField OUTPUT
	 --SELECT @outField
	ALTER PROCEDURE [dbo].[isValidateTruckTransfer]
		@Plate nvarchar(20)  NULL=NULL,
		@ContractNumber varchar(255) NULL=NULL,
		@StartDate varchar(255) NULL=NULL,
		@ExpirationDate varchar(255) NULL=NULL,
		@bp_code varchar(255) NULL=NULL,
		@name nvarchar(50) NULL=NULL,
		@TruckDocumentTypeId int NULL=NULL,
		@DocumentNumber nvarchar(40) NULL=NULL,
		@BusinessPartnerDocumentTypeNumber nvarchar(40) NULL=NULL,
		@PolDocumentTypeNumber varchar(255) NULL=NULL,
		@PolStartDate varchar(255) NULL=NULL,
		@PolExpirationDate varchar(255) NULL=NULL,
		@RevDocumentTypeNumber varchar(255) NULL=NULL,
		@RevStartDate varchar(255) NULL=NULL,
		@RevExpirationDate varchar(255) NULL=NULL,
		@isValid int OUTPUT,
		@validationReport nvarchar(255) OUTPUT
	AS
	BEGIN
		SET NOCOUNT ON;
		SELECT @isValid=1;
		SELECT @validationReport='';
		DECLARE @Count INT=NULL;

		-- Valida que no exista duplicidad de numero de equipo
		SELECT @Count=COUNT(Plate)
		FROM TruckTransfer
		WHERE Plate=@Plate;

		IF(@Count > 1)
		BEGIN
			SELECT @isValid=0;
			SELECT @validationReport='@Plate, duplicados - '+ CAST(@Count AS NVARCHAR(255))  + ' - ' + CAST( GETDATE() AS NVARCHAR(255));
		END
	END
GO
