-- =============================================
-- Author:		Sanders, Kriston
-- Create date: 	8/9/2019
-- Last update: 	9/30/2019
-- Description:	Link user to a shared account
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[AddUserToSharedAccount]
	(@UserID int, @AccountID int, @Requestor int)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @DateOfAction datetime = GETDATE(),
		@RequestType int = 1002; -- add user type
	
	-- link user to account
	INSERT INTO [dbo].[UserAccount] (
		[UserID],
		[AccountID]
	)
	VALUES (
		@UserID,
		@AccountID
	)
	
	-- log the action in request table
	EXEC [dbo].[LogRequest] @Requestor, @RequestType, @UserID,
						@DateOfAction, @DateOfAction;

END