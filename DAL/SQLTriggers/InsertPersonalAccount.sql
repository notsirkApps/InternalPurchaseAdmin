-- =============================================
-- Author:		Sanders, Kriston
-- Create date: 	8/15/2019
-- Last update: 	9/29/2019
-- Description:	When a new user is added, automatically create a personal account for them
-- =============================================
CREATE OR ALTER TRIGGER [dbo].[InsertPersonalAccount]
   ON  [InternalPurchaseAdmin].[dbo].[User]
   AFTER INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    DECLARE @Requestor int = 1000, -- admin user
			@RequestType int = 1006, -- create account type
			@UserID INT,
			@Username varchar(50),
			@AccountType int = 1000, -- PERSONAL account type code
			@DateOfAction datetime,
			@AccountID int;
			
	BEGIN TRY
	-- Get data from new record
	SELECT @UserID = ID FROM INSERTED;
	SELECT @Username = Username FROM INSERTED;
	SELECT @DateOfAction = CreatedDateTime FROM INSERTED;

	-- Create the personal account for new user
	INSERT INTO [dbo].[Account] (
		[Name],
		[AccountTypeID],
		[CreatedDateTime]
	)
	VALUES (
		@Username,
		@AccountType, 
		@DateOfAction
	)
	
	-- get newly generated account ID
	SELECT @AccountID = MAX(ID) FROM [dbo].[Account];

	-- log the action in request table
	EXEC [dbo].[LogRequest] @Requestor, @RequestType, @UserID,
							@DateOfAction, @DateOfAction;
	
	-- link new personal account to new user
	INSERT INTO [dbo].[UserAccount] (
		[AccountID],
		[UserID]
	)
	VALUES (
		@AccountID,
		@UserID
	)
	END TRY
	BEGIN CATCH
	END CATCH

END


ALTER TABLE [InternalPurchaseAdmin].[dbo].[User] ENABLE TRIGGER [InsertPersonalAccount];