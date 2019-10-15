-- ==========================================================================
-- Author:		Sanders, Kriston
-- Create date:	9/29/2019
-- Last update:	10/7/2019
-- Description:	For seeding InternalPurchaseAdmin database with mock data.
--				Mock data generated at www.mockaroo.com
-- ==========================================================================

USE [InternalPurchaseAdmin]

insert into [dbo].[AccountType] (TypeName) values ('PERSONAL');
insert into [dbo].[AccountType] (TypeName) values ('SHARED');

insert into [dbo].[Account] (AccountTypeID, Name, CreatedDateTime) values (1001, 'Athletics Administration', '2018-08-28 06:46:20');
insert into [dbo].[Account] (AccountTypeID, Name, CreatedDateTime) values (1001, 'Facilities Services', '2019-02-11 08:15:59');
insert into [dbo].[Account] (AccountTypeID, Name, CreatedDateTime) values (1001, 'Nursing School', '2018-05-15 21:39:06');
insert into [dbo].[Account] (AccountTypeID, Name, CreatedDateTime) values (1001, 'Chemistry Dept', '2018-12-15 13:14:09');
insert into [dbo].[Account] (AccountTypeID, Name, CreatedDateTime) values (1001, 'Biology', '2019-02-25 04:46:51');
insert into [dbo].[Account] (AccountTypeID, Name, CreatedDateTime) values (1001, 'English Dept', '2018-12-01 10:30:35');
insert into [dbo].[Account] (AccountTypeID, Name, CreatedDateTime) values (1001, 'Mathematics', '2018-05-22 14:24:48');
insert into [dbo].[Account] (AccountTypeID, Name, CreatedDateTime) values (1001, 'Modern Languages', '2019-03-30 08:17:09');
insert into [dbo].[Account] (AccountTypeID, Name, CreatedDateTime) values (1001, 'Office of Human Resources', '2018-10-18 03:53:59');
insert into [dbo].[Account] (AccountTypeID, Name, CreatedDateTime) values (1001, 'Library', '2019-02-09 04:36:52');
insert into [dbo].[Account] (AccountTypeID, Name, CreatedDateTime) values (1001, 'Fine Arts Dept', '2018-11-04 18:13:15');
insert into [dbo].[Account] (AccountTypeID, Name, CreatedDateTime) values (1001, 'Psychology Dept', '2018-05-10 07:20:27');



INSERT INTO [dbo].[RequestType]
           ([Type], [Description])
     VALUES
           ('ImportUser', 'Import user into system'),
		   ('DeleteUser', 'Delete user from system'),
		   ('AddUserToShared', 'Add user to shared account'),
		   ('RemoveUserFromShared', 'Remove user from shared account'),
		   ('AddManagerOfShared', 'Add manager for shared account'),
		   ('RemoveManagerOfShared', 'Remove manager for shared account'),
		   ('AddPersonal', 'Add personal account for created user'),
		   ('RemovePersonal', 'Remove personal account for deleted user')



insert into [dbo].[Role] (Name) values ('Staff');
insert into [dbo].[Role] (Name) values ('Faculty');
insert into [dbo].[Role] (Name) values ('Student');


insert into [dbo].[LocationType] (Type) values ('LOCAL');
insert into [dbo].[LocationType] (Type) values ('REMOTE');

insert into [dbo].[Location] (TypeID, Description, Name, CreatedDateTime) values (1000, 'Main campus- Admin Bldg', 'Campus Store', GETDATE());
insert into [dbo].[Location] (TypeID, Description, Name, CreatedDateTime) values (1000, 'Student Center', 'Pop-up Store', GETDATE());
insert into [dbo].[Location] (TypeID, Description, Name, CreatedDateTime) values (1001, 'Eastside campus', 'Mini-mart', GETDATE());


insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('SYSTEM', 'SYSTEM', 'SYSTEM', 'SYSTEM', '2019-04-05 00:00:00');
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('kmalloch0', 'Krishnah', 'Malloch', '2107124469', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('npinnigar1', 'Neddie', 'Pinnigar', '2881975194', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('phardaker2', 'Pasquale', 'Hardaker', '8110467482', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('jralphs3', 'Jemmie', 'Ralphs', '7571482380', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('rleggin4', 'Rivi', 'Leggin', '0135790867', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('adearsley5', 'Adham', 'Dearsley', '5256845772', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('dpadwick6', 'De witt', 'Padwick', '9647590334', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('bkerton7', 'Biddie', 'Kerton', '8935788643', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('jbaird8', 'Jan', 'Baird', '9072484193', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('rilden9', 'Riane', 'Ilden', '4433724912', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('rpendocka', 'Randee', 'Pendock', '2441355392', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('plindenbluthb', 'Paulo', 'Lindenbluth', '5932646969', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('wgoltc', 'Warden', 'Golt', '7867751270', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('gbinfieldd', 'Godwin', 'Binfield', '3203401460', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('sstitchere', 'Samara', 'Stitcher', '5171717516', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('gtribblef', 'Georgetta', 'Tribble', '7938010723', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('mwoolnerg', 'Michaela', 'Woolner', '4128474452', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('khoundesomeh', 'Kyrstin', 'Houndesome', '5312685232', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('ouppetti', 'Obidiah', 'Uppett', '9370617302', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('svedishchevj', 'Sarajane', 'Vedishchev', '3028321831', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('lsabinek', 'Loraine', 'Sabine', '2409646999', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('tdinceyl', 'Tucker', 'Dincey', '0418591326', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('uscramagem', 'Ulla', 'Scramage', '7219571488', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('mlewsonn', 'Mora', 'Lewson', '8535624384', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('vorromo', 'Verena', 'Orrom', '6148162822', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('mrufflep', 'Minni', 'Ruffle', '3989650874', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('mwakeq', 'Marlane', 'Wake', '3915988898', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('cstangelr', 'Chrissie', 'St Angel', '0190280379', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('sreicherzs', 'Shelbi', 'Reicherz', '8757154139', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('kteschet', 'Karolina', 'Tesche', '2510967215', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('gcrimu', 'Graig', 'Crim', '2620887798', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('bkwietekv', 'Boycey', 'Kwietek', '5930109575', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('koboylew', 'Koressa', 'O''Boyle', '8244772751', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('hschuckx', 'Harriette', 'Schuck', '8214920418', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('lboarery', 'Lulita', 'Boarer', '7356809028', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('gpennaz', 'Grace', 'Penna', '4906375235', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('cpogosian10', 'Celestina', 'Pogosian', '0248298623', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('tlisett11', 'Trey', 'Lisett', '0848686136', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('bferson12', 'Briant', 'Ferson', '2477764748', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('syaneev13', 'Stace', 'Yaneev', '8898000774', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('tmartinetto14', 'Terra', 'Martinetto', '1635710235', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('astoak15', 'Aveline', 'Stoak', '7857798886', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('slathe16', 'Shelton', 'Lathe', '9081378503', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('mtotterdell17', 'Marne', 'Totterdell', '8735965363', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('mcotterrill18', 'Meridith', 'Cotterrill', '0437193152', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('aboatswain19', 'Aggi', 'Boatswain', '5879252035', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('abenny1a', 'Antonia', 'Benny', '3046471890', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('dwoodroof1b', 'Darwin', 'Woodroof', '3369046598', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('ocovely1c', 'Olwen', 'Covely', '4730639944', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('apryell1d', 'Abeu', 'Pryell', '4922491279', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('neschelle1e', 'Nataniel', 'Eschelle', '3938681748', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('ahardingham1f', 'Abigail', 'Hardingham', '1726350045', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('hgookes1g', 'Hobey', 'Gookes', '7808141011', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('mkenner1h', 'Meaghan', 'Kenner', '8904330076', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('pcominoli1i', 'Phyllys', 'Cominoli', '2481655915', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('rpickburn1j', 'Rea', 'Pickburn', '0028423666', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('bchurchin1k', 'Bambi', 'Churchin', '8672864069', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('wrickert1l', 'Wyatt', 'Rickert', '2130816053', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('cpolak1m', 'Collete', 'Polak', '6184537822', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('mwilce1n', 'Marsha', 'Wilce', '0304373885', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('eloidl1o', 'Earvin', 'Loidl', '6909552946', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('rjohanssen1p', 'Rivy', 'Johanssen', '8171855245', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('llilly1q', 'Lorilyn', 'Lilly', '5324053805', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('aoventon1r', 'Alfie', 'Oventon', '1367388333', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('csreenan1s', 'Carney', 'Sreenan', '9676088749', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('dmargach1t', 'Darius', 'Margach', '9920379034', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('dsleeford1u', 'Davis', 'Sleeford', '0975807323', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('efairnie1v', 'Evelin', 'Fairnie', '0232821658', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('ientwistle1w', 'Issiah', 'Entwistle', '4642055355', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('msolesbury1x', 'Malissia', 'Solesbury', '9890109565', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('sbaudou1y', 'Sam', 'Baudou', '6827711005', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('pcolliber1z', 'Piotr', 'Colliber', '4829350490', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('sdenore20', 'Stearne', 'de Nore', '4977186494', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('sluckcuck21', 'Suellen', 'Luckcuck', '3329575360', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('bkennett22', 'Becca', 'Kennett', '6169126337', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('tboreham23', 'Trish', 'Boreham', '4352277843', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('mgilburt24', 'Marabel', 'Gilburt', '5568723435', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('slaneham25', 'Sauveur', 'Laneham', '1251747671', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('jmonkley26', 'Janith', 'Monkley', '4661625773', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('sfranken27', 'Siana', 'Franken', '9989399530', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('jquinevan28', 'Joyous', 'Quinevan', '8213114760', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('tjollie29', 'Teodor', 'Jollie', '7275194805', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('ahimsworth2a', 'Ann', 'Himsworth', '8326573116', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('kvitet2b', 'Korry', 'Vitet', '0141466561', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('amaxwell2c', 'Abel', 'Maxwell', '0986629057', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('jconstantine2d', 'Jasmine', 'Constantine', '1202036899', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('llaxston2e', 'Lara', 'Laxston', '7208557128', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('elapsley2f', 'Esma', 'Lapsley', '4409721666', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('rduchart2g', 'Raina', 'Duchart', '6113684067', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('eleborgne2h', 'Eldredge', 'Le Borgne', '8651422547', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('xsymon2i', 'Xavier', 'Symon', '5920260610', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('qmusselwhite2j', 'Quinton', 'Musselwhite', '4032993726', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('hputt2k', 'Harman', 'Putt', '7767156710', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('gstelfox2l', 'Gibb', 'Stelfox', '9170414696', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('hsherar2m', 'Horatia', 'Sherar', '5410584422', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('rdawley2n', 'Rosalyn', 'Dawley', '0780278240', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('rdackombe2o', 'Randie', 'Dackombe', '6542322817', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('sshreeve2p', 'Shaughn', 'Shreeve', '5577057558', GETDATE());
insert into [dbo].[User] (Username, FirstName, LastName, CardNumber, CreatedDateTime) values ('dgutridge2q', 'Donall', 'Gutridge', '7351153809', GETDATE());