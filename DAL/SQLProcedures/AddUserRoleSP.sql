-- =============================================
-- Author:		Sanders, Kriston
-- Create date: 	8/6/2019
-- Last update: 	9/30/2019
-- Description:	Add user role
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[AddUserRole]
	(@UserID INT, @UserRole int, @Requestor int)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @DateOfAction datetime = GETDATE()
	
	-- assign user role
	INSERT INTO [dbo].[UserRole] (
		[UserID],
		[RoleID]
	)
	VALUES (
		@UserID,
		@UserRole
	)

END