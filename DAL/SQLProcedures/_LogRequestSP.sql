-- =============================================
-- Author:		Sanders, Kriston
-- Create date: 	8/6/2019
-- Last update: 	9/30/2019
-- Description:	Log an event in the Request table
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[LogRequest1]
	(@Requestor int, @RequestType int, @AffectedUserID int, 
	@DateRequested datetime, @DateCompleted datetime = NULL, @Attribute varchar(50) = NULL)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @Rejected bit = 0;

	-- log the action in request table
	INSERT INTO [dbo].[RequestLog] (
		[RequestDateTime],
		[CompletedDateTime],
		[IsRejected],
		[Type],
		[Attribute],
		[AffectedUserID],
		[RequestedByUserID]
	)
	VALUES (
		@DateRequested,
		@DateCompleted,
		@Rejected,
		@RequestType,
		@Attribute,
		@AffectedUserID,
		@Requestor
	)

END