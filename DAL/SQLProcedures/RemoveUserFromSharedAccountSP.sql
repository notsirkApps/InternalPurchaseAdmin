-- =============================================
-- Author:		Sanders, Kriston
-- Create date: 	8/9/2019
-- Last update: 	9/30/2019
-- Description:	Unlink user from a shared account
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[RemoveUserFromSharedAccount]
	(@UserID int, @AccountID int, @Requestor int)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @DateOfAction datetime = GETDATE(),
		@RequestType int = 1003; -- add user type
	
	-- unlink user from account
	DELETE FROM [dbo].[UserAccount]
	WHERE [UserID] = @UserID AND [AccountID] = @AccountID;
	
	-- log the action in request table
	EXEC [dbo].[LogRequest] @Requestor, @RequestType, @UserID,
						@DateOfAction, @DateOfAction;

END