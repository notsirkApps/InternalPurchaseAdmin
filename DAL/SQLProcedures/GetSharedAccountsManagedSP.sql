-- =============================================
-- Author:		Sanders, Kriston
-- Create date: 	8/8/2019
-- Last update: 	9/30/2019
-- Description:	Get list of shared accounts managed by current user
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[GetSharedAccountsManaged]
	@UserID int,
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
	SELECT AccountID
	FROM [dbo].[Manager] JOIN (
		SELECT ID, Name, ManagerCount
		FROM [dbo].[Account] JOIN (
			SELECT AccountID, COUNT(UserID) AS ManagerCount
			FROM [dbo].[Manager]
			GROUP BY AccountID
		) AS Managers
		ON [dbo].[Account].ID = Managers.AccountID 
		WHERE DeletedDateTime IS NULL
		) AS AccountData
	ON [dbo].[Manager].AccountID = AccountData.ID
	WHERE UserID = @UserID) AS Results;
	
	-- Get records for the current page
	SELECT AccountID, Name, ManagerCount
	FROM (
	SELECT ROW_NUMBER() OVER (ORDER BY AccountID ASC) AS RowNum,
		AccountID, Name, ManagerCount
	FROM [dbo].[Manager] JOIN (
	SELECT ID, Name, ManagerCount
	FROM [dbo].[Account] JOIN (
		SELECT AccountID, COUNT(UserID) AS ManagerCount
		FROM [dbo].[Manager]
		GROUP BY AccountID
	) AS Managers
		ON [dbo].[Account].ID = Managers.AccountID 
	WHERE DeletedDateTime IS NULL
	) AS AccountData
	ON [dbo].[Manager].AccountID = AccountData.ID
	WHERE UserID = @UserID
	) AS UserResults
	WHERE RowNum BETWEEN ((@PageNumber - 1) * @RowsPerPage + 1) AND (@PageNumber * @RowsPerPage)
END