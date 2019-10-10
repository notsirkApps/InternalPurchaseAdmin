-- =============================================
-- Author:		Sanders, Kriston
-- Create date: 	8/5/2019
-- Last update: 	9/30/2019
-- Description:	When user created, log the event in Request table
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[AddUserToSystem]
	(@Username varchar(50), @FirstName varchar(50), @LastName varchar(50), 
		@CardNumber char(10), @Requestor int)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @UserID INT,
		@DateOfAction datetime = GETDATE(),
		@RequestType int = 1000; -- import user type
	
	-- first, CREATE OR ALTERuser in User table
	INSERT INTO [dbo].[User] (
		[Username],
		[FirstName],
		[LastName],
		[CardNumber],
		[CreatedDateTime]
	)
	VALUES (
		@Username,
		@FirstName,
		@LastName,
		@CardNumber, 
		@DateOfAction
	)
	
	-- NOTE: InsertPersonalAccount trigger will activate here,
	--			adding personal account and linking it to user
	
	-- get newly generated user ID
	SELECT @UserID = MAX(ID) FROM [dbo].[User];
	
	-- log the action in request table
	EXEC [dbo].[LogRequest] @Requestor, @RequestType, @UserID,
						@DateOfAction, @DateOfAction;

END