-- =============================================
-- Author:		Sanders, Kriston
-- Create date: 	8/9/2019
-- Last update: 	9/29/2019
-- Description:	Remove user role
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[RemoveUserRole]
(@UserID INT, @RoleID int)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @DateOfAction datetime = GETDATE()
	
	-- delete user role
	DELETE FROM [dbo].[UserRole]
	WHERE UserID = @UserID AND RoleID = @RoleID;

END