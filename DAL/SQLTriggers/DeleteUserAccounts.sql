-- =============================================
-- Author:		Sanders, Kriston
-- Create date: 	8/15/2019
-- Last update: 	9/29/2019
-- Description:	When a user is marked as deleted, 
--				automatically remove all account associations
-- =============================================
CREATE OR ALTER TRIGGER [dbo].[DeleteUserAccounts]
	ON  [InternalPurchaseAdmin].[dbo].[User]
	AFTER UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @Requestor int = 1000, -- admin user
		@RequestType int = 1007, -- remove account type
		@UserID INT,
		@Username varchar(50),
		@DateOfAction datetime;
	
	BEGIN TRY
	-- get data from changed record
	SELECT @UserID = ID FROM INSERTED;
	SELECT @Username = Username FROM INSERTED;
	SELECT @DateOfAction = DeletedDateTime FROM INSERTED;
	
	-- mark personal account deleted
	UPDATE [dbo].[Account]
	SET DeletedDateTime = @DateOfAction
	WHERE Name = @Username
	
	-- unlink user to all accounts
	DELETE FROM [dbo].[UserAccount]
	WHERE [UserID] = @UserID
	
	-- log the action in request table
	EXEC [dbo].[LogRequest] @Requestor, @RequestType, @UserID,
						@DateOfAction, @DateOfAction;
	END TRY
	BEGIN CATCH
	END CATCH

END


ALTER TABLE [InternalPurchaseAdmin].[dbo].[User] ENABLE TRIGGER [DeleteUserAccounts];
