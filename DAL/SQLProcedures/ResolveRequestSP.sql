-- =============================================
-- Author:		Sanders, Kriston
-- Create date: 	8/6/2019
-- Last update:	9/30/2019
-- Description:	When request complete or rejected, update Request record
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[ResolveRequest]
	(@RequestID int, @ResolvedBy int, @Rejected bit = 0, @ResolutionNotes varchar(255) = NULL)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @DateResolved datetime = GETDATE();
	
	UPDATE [dbo].[RequestLog]
	SET CompletedDateTime = @DateResolved,
		IsRejected = @Rejected,
		ResolutionNotes = @ResolutionNotes,
		ResolvedByUserID = @ResolvedBy
	WHERE ID = @RequestID;
	
END