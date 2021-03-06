--liquibase formatted sql
--changeset none:none enddelimiter:\nGO runOnChange:true
if exists( select 1 from sys.objects where object_id = object_id( N'[dbo].[fnCastStringToInt]' ) and type in ( N'FN', N'IF', N'TF', N'FS', N'FT' ) )
  drop function [dbo].[fnCastStringToInt]
go
GO
 
CREATE FUNCTION [dbo].[fnCastStringToInt] 
( 
    @Expression NVARCHAR(MAX)
   
)  
RETURNS int
as
BEGIN 
  
   	RETURN CAST(@Expression AS INT)
END
GO
