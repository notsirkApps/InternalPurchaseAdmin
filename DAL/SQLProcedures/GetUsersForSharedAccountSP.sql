-- =============================================
-- Author:		Sanders, Kriston
-- Create date: 	8/8/2019
-- Last update: 	9/30/2019
-- Description:	Get list of user details linked to a shared account
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[GetUsersForSharedAccount]
	@AccountID int,
	@PageNumber int,
	@RowsPerPage int,
	@TotalRows int OUTPUT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	-- Get count of record matches for output
	SELECT @TotalRows = COUNT(*)
	FROM (
	SELECT UserID
	FROM [dbo].[User] JOIN [dbo].[UserAccount]
	ON [dbo].[User].ID = [dbo].[UserAccount].UserID
	WHERE [dbo].[UserAccount].AccountID = @AccountID AND
		DeletedDateTime IS NULL
	) AS UserInfo;
	
	-- Get records for the current page
	SELECT UserID, Username, FirstName, LastName, CardNumber
	FROM (SELECT ROW_NUMBER() OVER (ORDER BY Username ASC) AS RowNum,
	UserID, Username, FirstName, LastName, CardNumber
	FROM [dbo].[User] JOIN [dbo].[UserAccount]
	ON [dbo].[User].ID = [dbo].[UserAccount].UserID
	WHERE [dbo].[UserAccount].AccountID = @AccountID AND
		DeletedDateTime IS NULL
	) AS UserInfo
	WHERE RowNum BETWEEN ((@PageNumber - 1) * @RowsPerPage + 1) AND (@PageNumber * @RowsPerPage)

END