--liquibase formatted sql
--changeset none:none enddelimiter:\nGO runOnChange:true

if exists( select 1 from sys.objects where object_id = object_id( N'[dbo].[fnGetChargeAmount]' ) and type in ( N'FN', N'IF', N'TF', N'FS', N'FT' ) )
  drop function [dbo].[fnGetChargeAmount]
go

CREATE FUNCTION [dbo].[fnGetChargeAmount]
  (@ServiceAmount numeric(10,2), @MinimumCharge numeric(10,2)) 
  returns numeric(10,2)

AS 
  begin 
  ---- comentarios varios 
  ---- comentarios varios 
    declare @result numeric(10,2)
	set @result = CASE WHEN @ServiceAmount > @MinimumCharge THEN @ServiceAmount ELSE @MinimumCharge END
	return @result
  
  end
GO
