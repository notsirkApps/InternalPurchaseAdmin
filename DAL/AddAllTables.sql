USE [InternalPurchaseAdmin]

SET ANSI_NULLS ON


SET QUOTED_IDENTIFIER ON


-- =============================================
-- Author:		Sanders, Kriston
-- Create date: 	4/4/2019
-- Last update: 	9/29/2019
-- Description:	Spending accounts may have different types,
--				such as personal or shared
-- =============================================
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='AccountType' and xtype='U')
CREATE TABLE [dbo].[AccountType](
	[ID] [int] IDENTITY(1000,1) NOT NULL,
	[TypeName] [varchar](50) NOT NULL
 CONSTRAINT [PK_AccountType] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];


-- =============================================
-- Author:		Sanders, Kriston
-- Create date: 	8/8/2019
-- Last update: 	9/29/2019
-- Description:	Stores spending accounts.
--				May be flagged as deleted but should remain in table
--				for auditing purposes.
-- =============================================
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Account' and xtype='U')
CREATE TABLE [dbo].[Account](
	[ID] [int] IDENTITY(1000,1) NOT NULL,
	[AccountTypeID] [int] NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[CreatedDateTime] [datetime] NOT NULL,
	[DeletedDateTime] [datetime] NULL
 CONSTRAINT [PK_Account] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];


ALTER TABLE [dbo].[Account]  WITH CHECK ADD CONSTRAINT [FK_Account_AccountType] FOREIGN KEY([AccountTypeID])
REFERENCES [dbo].[AccountType] ([ID]);


ALTER TABLE [dbo].[Account] CHECK CONSTRAINT [FK_Account_AccountType];


-- =============================================
-- Author:		Sanders, Kriston
-- Create date: 	8/8/2019
-- Last update: 	9/29/2019
-- Description:	Link a code to shared accounts used
--				by accounting/controller office for credits/debits
-- =============================================
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='BillingCode' and xtype='U')
CREATE TABLE [dbo].[BillingCode](
	[Code] [int] NOT NULL,
	[AccountID] [int] NOT NULL
 CONSTRAINT [PK_BillingCode] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ_Account] UNIQUE NONCLUSTERED 
(
	[AccountID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ_Code] UNIQUE NONCLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];


ALTER TABLE [dbo].[BillingCode]  WITH CHECK ADD  CONSTRAINT [FK_BillingCode_Account] FOREIGN KEY([AccountID])
REFERENCES [dbo].[Account] ([ID]);


ALTER TABLE [dbo].[BillingCode] CHECK CONSTRAINT [FK_BillingCode_Account];


-- Description:	Linking table to tie users to spending accounts.
--				Users may be linked to multiple accounts
--				in a many-to-many relationship.
-- =============================================
-- Author:		Sanders, Kriston
-- Create date: 	8/8/2019
-- Last update: 	9/29/2019
-- Description:	Support for multiple locations 
--				and type caterization
-- =============================================
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='LocationType' and xtype='U')
CREATE TABLE [dbo].[LocationType](
	[ID] [int] IDENTITY(1000,1) NOT NULL,
	[Type] [varchar](50) NOT NULL
 CONSTRAINT [PK_LocationType] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];


-- =============================================
-- Author:		Sanders, Kriston
-- Create date: 	8/8/2019
-- Last update: 	9/29/2019
-- Description:	Used for identifying spending location
-- =============================================
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Location' and xtype='U')
CREATE TABLE [dbo].[Location](
	[ID] [int] IDENTITY(1000,1) NOT NULL,
	[TypeID] [int] NOT NULL,
	[Description] [varchar](50) NULL,
	[Name] [varchar](50) NOT NULL,
	[CreatedDateTime] [datetime] NOT NULL,
	[DeletedDateTime] [datetime] NULL
 CONSTRAINT [PK_Location] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];


ALTER TABLE [dbo].[Location]  WITH CHECK ADD  CONSTRAINT [FK_Location_LocationType] FOREIGN KEY([TypeID])
REFERENCES [dbo].[LocationType] ([ID]);


ALTER TABLE [dbo].[Location] CHECK CONSTRAINT [FK_Location_LocationType];


-- =============================================
-- Author:		Sanders, Kriston
-- Create date: 	8/5/2019
-- Last update: 	9/29/2019
-- Description:	Support for caterizing users such as
--				student, faculy, staff. Roles may be used
--				for differing settings, permissions, 
--				statistics, fund allocation, etc.
-- =============================================
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Role' and xtype='U')
CREATE TABLE [dbo].[Role](
	[ID] [int] IDENTITY(1000,1) NOT NULL,
	[Name] [varchar](50) NOT NULL
 CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];


-- =============================================
-- Author:		Sanders, Kriston
-- Create date: 	8/5/2019
-- Last update: 	9/29/2019
-- Description:	Users able to access the system
-- =============================================
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='User' and xtype='U')
CREATE TABLE [dbo].[User](
	[ID] [int] IDENTITY(1000,1) NOT NULL,
	[Username] [varchar](50) NOT NULL,
	[FirstName] [varchar](50) NULL,
	[LastName] [varchar](50) NULL,
	[CardNumber] [char](10) NULL,
	[CreatedDateTime] [datetime] NOT NULL,
	[DeletedDateTime] [datetime] NULL
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ_CardNumber] UNIQUE NONCLUSTERED 
(
	[CardNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ_Username] UNIQUE NONCLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];



-- =============================================
-- Author:		Sanders, Kriston
-- Create date: 	8/5/2019
-- Last update: 	9/29/2019
-- =============================================
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='UserAccount' and xtype='U')
CREATE TABLE [dbo].[UserAccount](
	[ID] [int] IDENTITY(1000,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[AccountID] [int] NOT NULL
 CONSTRAINT [PK_UserAccount] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];


ALTER TABLE [dbo].[UserAccount]  WITH CHECK ADD  CONSTRAINT [FK_Manager_Account] FOREIGN KEY([AccountID])
REFERENCES [dbo].[Account] ([ID]);


ALTER TABLE [dbo].[UserAccount] CHECK CONSTRAINT [FK_Manager_Account];


ALTER TABLE [dbo].[UserAccount]  WITH CHECK ADD  CONSTRAINT [FK_UserAccount_Account] FOREIGN KEY([AccountID])
REFERENCES [dbo].[Account] ([ID]);


ALTER TABLE [dbo].[UserAccount] CHECK CONSTRAINT [FK_UserAccount_Account];


ALTER TABLE [dbo].[UserAccount]  WITH CHECK ADD  CONSTRAINT [FK_UserAccount_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([ID]);


ALTER TABLE [dbo].[UserAccount] CHECK CONSTRAINT [FK_UserAccount_User];


-- =============================================
-- Author:		Sanders, Kriston
-- Create date: 	8/5/2019
-- Last update: 	9/29/2019
-- Description:	Linking table to tie users to roles.
--				Users may hold more than one roles
--				in many-to-many relationship.
-- =============================================
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='UserRole' and xtype='U')
CREATE TABLE [dbo].[UserRole](
	[ID] [int] IDENTITY(1000,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[RoleID] [int] NOT NULL
 CONSTRAINT [PK_UserRole] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];


ALTER TABLE [dbo].[UserRole]  WITH CHECK ADD  CONSTRAINT [FK_UserRole_Role] FOREIGN KEY([RoleID])
REFERENCES [dbo].[Role] ([ID]);


ALTER TABLE [dbo].[UserRole] CHECK CONSTRAINT [FK_UserRole_Role];


ALTER TABLE [dbo].[UserRole]  WITH CHECK ADD  CONSTRAINT [FK_UserRole_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([ID]);


ALTER TABLE [dbo].[UserRole] CHECK CONSTRAINT [FK_UserRole_User];


-- =============================================
-- Author:		Sanders, Kriston
-- Create date: 	8/7/2019
-- Last update: 	9/29/2019
-- Description:	Managers may submit requests to alter
--				access to the system or to accounts.
-- =============================================
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='RequestType' and xtype='U')
CREATE TABLE [dbo].[RequestType](
	[ID] [int] IDENTITY(1000,1) NOT NULL,
	[Type] [varchar](50) NOT NULL,
	[Description] [varchar](255) NULL
 CONSTRAINT [PK_RequestType] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];


-- =============================================
-- Author:		Sanders, Kriston
-- Create date: 	8/8/2019
-- Last update: 	10/15/2019
-- Description:	Logs changes to the system for autiding.
--				Requests may be accepted or rejected.
--				ResolutionNotes can be used to explain why 
--				a request was rejected or for other means.
--				Request may be submitted and resolved by 
--				different users/managers. 
--				Attribute can be used to add details
--				,such as linking requests together,
--				as defined by system admin.
-- =============================================
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='RequestLog' and xtype='U')
CREATE TABLE [dbo].[RequestLog](
	[ID] [int] IDENTITY(1000,1) NOT NULL,
	[RequestDateTime] [datetime] NOT NULL,
	[CompletedDateTime] [datetime] NULL,
	[IsRejected] [bit] NULL,
	[ResolutionNotes] [varchar](255) NULL,
	[ResolvedByUserID] [int] NULL,
	[TypeID] [int] NOT NULL,
	[Attribute] [varchar](50) NULL,
	[AffectedUserID] [int] NULL,
	[RequestedByUserID] [int] NOT NULL
 CONSTRAINT [PK_RequestLog] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];


ALTER TABLE [dbo].[RequestLog]  WITH CHECK ADD  CONSTRAINT [FK_Affected_User] FOREIGN KEY([AffectedUserID])
REFERENCES [dbo].[User] ([ID]);


ALTER TABLE [dbo].[RequestLog] CHECK CONSTRAINT [FK_Affected_User];


ALTER TABLE [dbo].[RequestLog]  WITH CHECK ADD  CONSTRAINT [FK_Request_Type] FOREIGN KEY([Type])
REFERENCES [dbo].[RequestType] ([ID]);


ALTER TABLE [dbo].[RequestLog] CHECK CONSTRAINT [FK_Request_Type];


ALTER TABLE [dbo].[RequestLog]  WITH CHECK ADD  CONSTRAINT [FK_Requestor] FOREIGN KEY([RequestedByUserID])
REFERENCES [dbo].[User] ([ID]);


ALTER TABLE [dbo].[RequestLog] CHECK CONSTRAINT [FK_Requestor];


ALTER TABLE [dbo].[RequestLog]  WITH CHECK ADD  CONSTRAINT [FK_Resolved_By] FOREIGN KEY([ResolvedByUserID])
REFERENCES [dbo].[User] ([ID]);


ALTER TABLE [dbo].[RequestLog] CHECK CONSTRAINT [FK_Resolved_By];


-- =============================================
-- Author:		Sanders, Kriston
-- Create date: 	8/8/2019
-- Last update: 	9/29/2019
-- Description:	Linking table to designate managers of spending accounts.
--				Users may be linked to multiple accounts
--				in a many-to-many relationship.
-- =============================================
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Manager' and xtype='U')
CREATE TABLE [dbo].[Manager](
	[ID] [int] IDENTITY(1000,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[AccountID] [int] NOT NULL
 CONSTRAINT [PK_Manager] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];


ALTER TABLE [dbo].[Manager]  WITH CHECK ADD  CONSTRAINT [FK_Manager_Account1] FOREIGN KEY([AccountID])
REFERENCES [dbo].[Account] ([ID]);


ALTER TABLE [dbo].[Manager] CHECK CONSTRAINT [FK_Manager_Account1];


ALTER TABLE [dbo].[Manager]  WITH CHECK ADD  CONSTRAINT [FK_Manager_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([ID]);


ALTER TABLE [dbo].[Manager] CHECK CONSTRAINT [FK_Manager_User];


-- =============================================
-- Author:		Sanders, Kriston
-- Create date: 	8/8/2019
-- Last update: 	9/29/2019
-- Description:	Tracks spending by users. Indicates user,
--				amont spent, location of purchase, account used,
--				item purchased, and optional attributes for further detail
--				such as quantity, type, etc.
-- =============================================
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='UsageLog' and xtype='U')
CREATE TABLE [dbo].[UsageLog](
	[ID] [int] IDENTITY(1000,1) NOT NULL,
	[DateTime] [datetime] NOT NULL,
	[UserID] [int] NOT NULL,
	[AccountID] [int] NOT NULL,
	[Cost] [float] NOT NULL,
	[LocationID] [int] NOT NULL,
	[ItemName] [varchar](50) NOT NULL,
	[ItemAttribute1] [varchar](50) NULL,
	[ItemAttribute2] [varchar](50) NULL,
	[ItemAttribute3] [varchar](50) NULL,
	[ItemAttribute4] [varchar](50) NULL
 CONSTRAINT [PK_UsageLog] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];


ALTER TABLE [dbo].[UsageLog]  WITH CHECK ADD  CONSTRAINT [FK_UsageLog_Account] FOREIGN KEY([AccountID])
REFERENCES [dbo].[Account] ([ID]);


ALTER TABLE [dbo].[UsageLog] CHECK CONSTRAINT [FK_UsageLog_Account];


ALTER TABLE [dbo].[UsageLog]  WITH CHECK ADD  CONSTRAINT [FK_UsageLog_Location] FOREIGN KEY([LocationID])
REFERENCES [dbo].[Location] ([ID]);


ALTER TABLE [dbo].[UsageLog] CHECK CONSTRAINT [FK_UsageLog_Location];


ALTER TABLE [dbo].[UsageLog]  WITH CHECK ADD  CONSTRAINT [FK_UsageLog_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([ID]);


ALTER TABLE [dbo].[UsageLog] CHECK CONSTRAINT [FK_UsageLog_User];
