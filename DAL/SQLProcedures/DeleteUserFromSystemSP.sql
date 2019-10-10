-- =============================================
-- Author:		Sanders, Kriston
-- Create date: 	8/5/2019
-- Last update: 	10/7/2019
-- Description:	When user deleted from system, delete their personal account, 
--				unlink them from all accounts, remove their role, 
--				and log the event for auditing
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[DeleteUserFromSystem]
	-- Add the parameters for the stored procedure here
	(@UserID int, @Username varchar(50), @Requestor int)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @DateOfAction datetime = GETDATE(),
		@RequestType int = 1001; -- delete user type
	
	-- delete user
	UPDATE [dbo].[User]
	SET DeletedDateTime = @DateOfAction
	WHERE ID = @UserID;
	
	-- Note: DeleteUserAccounts trigger will activate here, removing personal account 
	--			and unlinking all roles and accounts from user
	
	-- log the action in request table
	EXEC [dbo].[LogRequest] @Requestor, @RequestType, @UserID,
						@DateOfAction, @DateOfAction;

END