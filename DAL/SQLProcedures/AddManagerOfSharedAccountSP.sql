-- =============================================
-- Author:		Sanders, Kriston
-- Create date: 	8/9/2019
-- Last update: 	9/30/2019
-- Description:	Designate user a manager of a shared account
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[AddManagerOfSharedAccount]
	(@UserID int, @AccountID int, @Requestor int)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @DateOfAction datetime = GETDATE(),
		@RequestType int = 1004; -- add user type
	
	-- add manager to account
	INSERT INTO [dbo].[Manager] (
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