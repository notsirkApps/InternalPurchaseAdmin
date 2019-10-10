-- =============================================
-- Author:		Sanders, Kriston
-- Create date: 	8/9/2019
-- Last update: 	9/30/2019
-- Description:	Remove manager from a shared account
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[RemoveManagerFromSharedAccount]
	(@UserID int, @AccountID int, @Requestor int)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @DateOfAction datetime = GETDATE(),
		@RequestType int = 1005; -- add user type
	
	-- unlink user from account
	DELETE FROM [dbo].[Manager]
	WHERE [UserID] = @UserID AND [AccountID] = @AccountID;
	
	-- log the action in request table
	EXEC [dbo].[LogRequest] @Requestor, @RequestType, @UserID,
						@DateOfAction, @DateOfAction;

END