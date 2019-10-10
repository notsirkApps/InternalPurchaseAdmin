-- =============================================
-- Author:		Sanders, Kriston
-- Create date: 	8/9/2019
-- Last update: 	9/30/2019
-- Description:	Search for user by username, name, or card number
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[GetUserMatches]
	@SearchValue varchar(50),
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
	SELECT ID
	FROM [dbo].[User]
	WHERE DeletedDateTime IS NULL AND (
		Username LIKE '%' + @SearchValue + '%' OR
		LastName LIKE '%' + @SearchValue + '%' OR
		CardNumber LIKE '%' + @SearchValue + '%'
	)
	) AS Results;
	
	-- Get records for the current page
	SELECT ID, Username, FirstName, LastName, CardNumber
	FROM (
	SELECT ROW_NUMBER() OVER (ORDER BY Username ASC) AS RowNum, ID, 
		Username, FirstName, LastName, CardNumber
	FROM [dbo].[User]
	WHERE DeletedDateTime IS NULL AND (
		Username LIKE '%' + @SearchValue + '%' OR
		LastName LIKE '%' + @SearchValue + '%' OR
		CardNumber LIKE '%' + @SearchValue + '%'
	)) AS UserResults
	WHERE RowNum BETWEEN ((@PageNumber - 1) * @RowsPerPage + 1) AND (@PageNumber * @RowsPerPage)
END