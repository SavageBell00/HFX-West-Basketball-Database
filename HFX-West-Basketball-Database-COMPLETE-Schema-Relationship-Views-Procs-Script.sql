-- Author: Dawan Savage Bell
-- Date: 2022-11-21
-- Description: DDL for hfxWestBasketball, all tables


/*
-- Creating Database
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='hfxWestBasketball' and xtype='U')
BEGIN
CREATE DATABASE hfxWestBasketball
END;
GO
*/

USE hfxWestBasketball
GO


-- CREATING TABLES AND ATTRIBUTES --

/* PLAYER TABLE */

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Player' and xtype='U')
BEGIN
CREATE TABLE [dbo].Player(
playerId int IDENTITY PRIMARY KEY,
firstName nvarchar(40) NOT NULL,
lastName nvarchar(45) NOT NULL,
grade nvarchar (3) NOT NULL,
seasonId int DEFAULT 1-- ForeignKey from Season table
)
END;
GO


/* PLAYERCONTACT TABLE*/
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='PlayerContact' and xtype='U')
BEGIN
CREATE TABLE [dbo].PlayerContact(
playerId int PRIMARY KEY, -- primary key and foreign key from Player table
playerPhoneNum nvarchar (16),
emergContactFName nvarchar(40) NOT NULL,
emergContactLName nvarchar(40) NOT NULL,
emergContactNum nvarchar(16),
relationship nvarchar(20)
)
END;
GO

/* JERSEY TABLE*/
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Jersey' and xtype='U')
BEGIN
CREATE TABLE [dbo].Jersey(
jerseyId int IDENTITY PRIMARY KEY,
redJerseyNum nvarchar(2),
greyJerseyNum nvarchar(2),
blackJerseyNum nvarchar(2),
whiteJerseyNum nvarchar(2),
returned bit,
playerId int --ForeignKey from Player Table
)
END;
GO


/* SEASON TABLE */
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Season' and xtype='U')
BEGIN
CREATE TABLE [dbo].Season(
seasonId int IDENTITY PRIMARY KEY,
startYear date,
endYear date,
wins int,
loses int,
playoffWins int,
playoffLosses int
)
END;
GO


/*OPPONENT TABLE */
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Opponent' and xtype='U')
BEGIN
CREATE TABLE [dbo].Opponent(
oppId int IDENTITY PRIMARY KEY,
schoolName nvarchar(50),
teamName nvarchar(50),
addrsNum nvarchar(6),
addrsStreetName nvarchar(50),
city nvarchar(30) DEFAULT 'Halifax',
areaCode nvarchar(6),
province nvarchar(3) DEFAULT 'NS',
country nvarchar(50) DEFAULT 'Canada',
conference nvarchar(25),
oppWins int,
oppLosses int
)
END;
GO
 

/* GAME TABLE */
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Game' and xtype='U')
BEGIN
CREATE TABLE [dbo].Game(
gameId int IDENTITY PRIMARY KEY, --PRIMARY KEY
oppId int, -- foreignKey from Opponents table
gameDate date,
homeGame bit DEFAULT 1, -- 1 is for true
wonGame bit DEFAULT 1,
seasonId int DEFAULT 1, -- foreignKey from Season table
jerseyWorn nvarchar(6)
)
END;
GO



/* PLAYERSTAT Table */

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='PlayerStat' and xtype='U')
BEGIN
CREATE TABLE [dbo].PlayerStat(
playerStatId int IDENTITY PRIMARY KEY,
playerId int, -- FOREIGN KEY FROM PLAYER
playerPts int,
playerFgA int,
playerFgM int,
playerFgP float,
playerThreeA int,
playerThreeM int,
playerThreeP float,
playerFtA int,
playerFtM int,
playerFtP float,
playerRebs int,
playerOffRebs int,
playerDefRebs int,
playerAssists int,
playerSteals int,
playerTurnovers int,
playerBlocks int,
playerFouls int,
playerTechs int
)
END;
GO

/* PLAYERGAMESTAT Table */
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='PlayerGameStat' and xtype='U')
BEGIN
CREATE TABLE [dbo].PlayerGameStat(
gameId int, -- COMPOSITE KEY and FOREIGN KEY
playerStatId int, -- COMPOSITE KEY and FOREIGN KEY
PRIMARY KEY (gameId, playerStatId)
)
END;
GO

/* GAME STATS TABLE */
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='GameStat' and xtype='U')
BEGIN
CREATE TABLE [dbo].TeamGameStat(
teamGameStatId int IDENTITY PRIMARY KEY, -- PRIMARY KEY
gameId int, --foreignkey from Game table
teamPts int,
teamFgA int,
teamFgM int,
teamFgP float,
teamThreeA int,
teamThreeM int,
teamThreeP float,
teamFtA int,
teamFtM int,
teamFtP float,
teamRebs int,
teamOffRebs int,
teamDefRebs int,
teamAssists int,
teamSteals int,
teamTurnovers int,
teamBlocks int,
teamFouls int,
teamTransitionPts int,
teamSecondChancePts int,
teamPtsInPaint int,
oppPts int,
oppFgA int,
oppFgM int,
oppFgP float,
oppThreeA int,
oppThreeM int,
oppThreeP float,
oppFtA int,
oppFtM int,
oppFtP float,
oppRebs int,
oppOffRebs int,
oppDefRebs int,
oppSteals int,
oppAssists int,
oppTurnovers int,
oppBlocks int,
oppFouls int,
oppPtsInPaint int,
oppSecondChancePts int,
)
END;
GO

-- Author: Dawan Savage Bell
-- Date: 2022-11-23
-- Description: Creating Relationships for hfxWestBasketball Database

USE hfxWestBasketball;
GO
-- RELATIONSHIPS! --

-- Player table Created --

-- COMPLETED
ALTER TABLE [dbo].Player
ADD CONSTRAINT FK_PLAYER_SEASON
FOREIGN KEY(seasonId) REFERENCES Season(seasonId)
ON DELETE CASCADE
ON UPDATE CASCADE;
GO



-- Game Table --

-- COMPLETED
ALTER TABLE [dbo].Game
ADD CONSTRAINT FK_GAME_OPP
FOREIGN KEY(oppId) REFERENCES Opponent(oppId)
ON DELETE CASCADE
ON UPDATE CASCADE;
GO



-- PlayerStat Table --

-- COMPLETED
ALTER TABLE [dbo].PlayerStat
ADD FOREIGN KEY(playerId) REFERENCES Player(playerId)
ON DELETE NO ACTION
ON UPDATE NO ACTION;
GO

-- COMPLETED
ALTER TABLE [dbo].PlayerGameStat
ADD FOREIGN KEY(gameId) REFERENCES Game(gameId)
ON DELETE NO ACTION
ON UPDATE NO ACTION;
GO


-- COMPLETE
ALTER TABLE [dbo].PlayerGameStat
ADD FOREIGN KEY(playerStatId) REFERENCES PlayerStat(playerStatId)
ON DELETE NO ACTION
ON UPDATE NO ACTION;
GO

-- GameStat Table --

-- COMPLETED
ALTER TABLE [dbo].TeamGameStat
ADD FOREIGN KEY(gameId) REFERENCES Game(gameId)
ON DELETE NO ACTION
ON UPDATE NO ACTION;
GO



-- Jersey Table --
-- COMPLETE
ALTER TABLE [dbo].Jersey
ADD CONSTRAINT FK_JERSEY_PLAYER
FOREIGN KEY(playerId) REFERENCES Player(playerId)
ON DELETE CASCADE
ON UPDATE CASCADE;
GO


-- PlayerContact Table --
-- COMPLETE
ALTER TABLE [dbo].PlayerContact
ADD FOREIGN KEY (playerId) REFERENCES Player(playerId)
ON DELETE CASCADE
ON UPDATE CASCADE;
GO


-- Author: Dawan Savage Bell
-- Date: 2023-01-02
-- Description: Script for creating Stored Procedures for hfxWestBasketball Database

--------------------------------------------
-- Old Stored Proc for inserting player stats --
--------------------------------------------

USE hfxWestBasketball
GO

CREATE OR ALTER PROCEDURE dbo.InsertPlayerStat
	@playerID int,
	@playerFgA int,
	@playerFgM int,
	@playerFgP float,
	@playerThreeA int,
	@playerThreeM int,
	@playerThreeP float,
	@playerFtA int,
	@playerFtM int,
	@playerFtP float,
	@playerOffRebs int,
	@playerDefRebs int,
	@playerAssists int,
	@playerSteals int,
	@playerTurnovers int,
	@playerBlocks int,
	@playerFouls int
AS
BEGIN
	BEGIN TRY -- Begin TRY for entire Procedure
		BEGIN TRAN -- Begin Tran for entire procedure
			BEGIN TRY -- Try Catch for decalring percentages and rebs variables
				DECLARE @playerPts int,
						@playerRebs int
			END TRY
			BEGIN CATCH
				SELECT ERROR_MESSAGE() AS 'UNABLE to declare variables'
			END CATCH

			BEGIN TRY -- try catch for setting playerPts
				SET @playerPts = (@playerThreeM * 3) + (@playerFgM * 2) + (@playerFtM)
			END TRY
			BEGIN CATCH
				SELECT ERROR_MESSAGE() AS 'Error: Unable to set playerPts'
			END CATCH

			BEGIN TRY -- try catch for setting playerRebs
				SET @playerRebs = (@playerOffRebs + @playerDefRebs)
			END TRY
			BEGIN CATCH
				SELECT ERROR_MESSAGE() AS 'Error: Unable to set playerRebs'
			END CATCH

			-- Try Catch for inserting Values
			BEGIN TRY
				INSERT INTO PlayerStat ([playerId],[playerPts],[playerFgA],[playerFgM],[playerFgP],
										[playerThreeA],[playerThreeM],[playerThreeP],
										[playerFtA],[playerFtM],[playerFtP],[playerRebs],
										[playerOffRebs],[playerDefRebs],[playerAssists],[playerSteals],
										[playerTurnovers],
										[playerBlocks],[playerFouls])
				VALUES (@playerID, @playerPts, @playerFgA, @playerFgM, @playerFgP, 
						@playerThreeA, @playerThreeM, @playerThreeP, 
						@playerFtA, @playerFtM, @playerFtP, @playerRebs,
						@playerOffRebs, @playerDefRebs, @playerAssists, @playerSteals,
						@playerTurnovers, @playerBlocks, @playerFouls)
			END TRY
			BEGIN CATCH
				SELECT ERROR_MESSAGE() AS 'Error: Unable to Insert Player Values'
			END CATCH

		IF (@@ERROR > 0)
			BEGIN
				ROLLBACK TRAN
			END
		COMMIT TRAN
	
	END TRY
	BEGIN CATCH
		SELECT ERROR_MESSAGE() AS 'Error: Unable to insert into player game stats'
	END CATCH
END;
GO


USE hfxWestBasketball
GO

CREATE OR ALTER PROCEDURE dbo.InsertPlayerGameStat
	@playerID int,
	@playerFgA int,
	@playerFgM int,
	@playerThreeA int,
	@playerThreeM int,
	@playerFtA int,
	@playerFtM int,
	@playerOffRebs int,
	@playerDefRebs int,
	@playerAssists int,
	@playerSteals int,
	@playerTurnovers int,
	@playerBlocks int,
	@playerFouls int
AS
BEGIN
	BEGIN TRY -- Begin TRY for entire Procedure
		BEGIN TRAN -- Begin Tran for entire procedure
			BEGIN TRY -- Try Catch for decalring percentages and rebs variables
				DECLARE @playerPts int,
						@playerRebs int,
						@playerFgP float,
						@playerThreeP float,
						@playerFtP float
			END TRY
			BEGIN CATCH
				SELECT ERROR_MESSAGE() AS 'UNABLE to declare variables'
			END CATCH

			BEGIN TRY -- try catch for setting playerFgP
				IF @playerFgA > 0
					SET @playerFgP = (@playerFgM * 100) / @playerFgA
				ELSE
					SET @playerFgP = 0
			END TRY
			BEGIN CATCH
				SELECT ERROR_MESSAGE() AS 'Error: Unable to set playerFgP'
			END CATCH

			BEGIN TRY -- try catch for setting playerThreeP
				IF @playerThreeA > 0
					SET @playerThreeP = (@playerThreeM * 100) / @playerThreeA
				ELSE
					SET @playerThreeP = 0
			END TRY
			BEGIN CATCH
				SELECT ERROR_MESSAGE() AS 'Error: Unable to set playerThreeP'
			END CATCH

			BEGIN TRY -- try catch for setting playerFtP
				IF @playerFtA > 0
					SET @playerFtP = (@playerFtM * 100) / @playerFtA
				ELSE
					SET @playerFtP = 0
			END TRY
			BEGIN CATCH
				SELECT ERROR_MESSAGE() AS 'Error: Unable to set playerFtP'
			END CATCH

			BEGIN TRY -- try catch for setting playerPts
				SET @playerPts = (@playerThreeM * 3) + (@playerFgM * 2) + (@playerFtM)
			END TRY
			BEGIN CATCH
				SELECT ERROR_MESSAGE() AS 'Error: Unable to set playerPts'
			END CATCH

			BEGIN TRY -- try catch for setting playerRebs
				SET @playerRebs = (@playerOffRebs + @playerDefRebs)
			END TRY
			BEGIN CATCH
				SELECT ERROR_MESSAGE() AS 'Error: Unable to set playerRebs'
			END CATCH

			-- Try Catch for inserting Values
			BEGIN TRY
				INSERT INTO PlayerStat ([playerId],[playerPts],[playerFgA],[playerFgM],[playerFgP],
										[playerThreeA],[playerThreeM],[playerThreeP],
										[playerFtA],[playerFtM],[playerFtP],[playerRebs],
										[playerOffRebs],[playerDefRebs],[playerAssists],[playerSteals],
										[playerTurnovers],
										[playerBlocks],[playerFouls])
				VALUES (@playerID, @playerPts, @playerFgA, @playerFgM, @playerFgP, 
						@playerThreeA, @playerThreeM, @playerThreeP, 
						@playerFtA, @playerFtM, @playerFtP, @playerRebs,
						@playerOffRebs, @playerDefRebs, @playerAssists, @playerSteals,
						@playerTurnovers, @playerBlocks, @playerFouls)
			END TRY
			BEGIN CATCH
				SELECT ERROR_MESSAGE() AS 'Error: Unable to Insert Player Values'
			END CATCH

		IF (@@ERROR > 0)
			BEGIN
				ROLLBACK TRAN
			END
		COMMIT TRAN
	
	END TRY
	BEGIN CATCH
		SELECT ERROR_MESSAGE() AS 'Error: Unable to insert into player game stats'
	END CATCH
END;
GO

--------------------------------------------
-- Stored Proc for inserting Team Game Info --
--------------------------------------------

CREATE OR ALTER PROCEDURE dbo.InsertGameInfo
	@oppId int,
	@gameDate date,
	@homeGame bit,
	@wonGame bit,
	@jerseyWorn nvarchar(6)
AS
BEGIN
	BEGIN TRY -- try catch for entire procedure
		BEGIN TRAN
			BEGIN TRY -- try catch for inserting values
				INSERT INTO Game([oppId],[gameDate],[homeGame],[wonGame],[jerseyWorn])
				VALUES(@oppId,@gameDate,@homeGame,@wonGame,@jerseyWorn)
			END TRY
			BEGIN CATCH
				SELECT ERROR_MESSAGE() AS 'Error: Unable to insert game stat info'
			END CATCH


		IF (@@ERROR > 0) -- TRAN
			BEGIN
				ROLLBACK TRAN
			END
		COMMIT TRAN


	END TRY
	BEGIN CATCH
		SELECT ERROR_MESSAGE() AS 'Error: Unable to insert game info'
	END CATCH
END;
GO

--------------------------------------------
-- Stored Proc for inserting Team Game Stats --
--------------------------------------------

CREATE OR ALTER PROCEDURE dbo.InsertTeamGameStats
	@gameID int,
	@teamFgA int,
	@teamFgM int,
	@teamThreeA int,
	@teamThreeM int,
	@teamFtA int,
	@teamFtM int,
	@teamOffRebs int,
	@teamDefRebs int,
	@teamAssists int,
	@teamSteals int,
	@teamTurnovers int,
	@teamBlocks int,
	@teamFouls int,
	@oppPts int
AS
BEGIN
	BEGIN TRY -- Begin TRY for entire Procedure
		BEGIN TRAN -- Begin Tran for entire procedure
			BEGIN TRY -- Try Catch for decalring percentages and rebs variables
				DECLARE @teamPts int,
						@teamRebs int,
						@teamFgP float,
						@teamThreeP float,
						@teamFtP float
			END TRY
			BEGIN CATCH
				SELECT ERROR_MESSAGE() AS 'UNABLE to declare variables'
			END CATCH

			BEGIN TRY -- try catch for setting teamFgP
				IF @teamFgA > 0
					SET @teamFgP = (@teamFgM * 100) / @teamFgA
				ELSE
					SET @teamFgP = 0
			END TRY
			BEGIN CATCH
				SELECT ERROR_MESSAGE() AS 'Error: Unable to set teamFgP'
			END CATCH

			BEGIN TRY -- try catch for setting teamThreeP
				IF @teamThreeA > 0
					SET @teamThreeP = (@teamThreeM * 100) / @teamThreeA
				ELSE
					SET @teamThreeP = 0
			END TRY
			BEGIN CATCH
				SELECT ERROR_MESSAGE() AS 'Error: Unable to set teamThreeP'
			END CATCH

			BEGIN TRY -- try catch for setting teamFtP
				IF @teamFtA > 0
					SET @teamFtP = (@teamFtM * 100) / @teamFtA
				ELSE
					SET @teamFtP = 0
			END TRY
			BEGIN CATCH
				SELECT ERROR_MESSAGE() AS 'Error: Unable to set teamFtP'
			END CATCH

			BEGIN TRY -- try catch for setting teamPts
				SET @teamPts = (@teamThreeM * 3) + (@teamFgM * 2) + (@teamFtM)
			END TRY
			BEGIN CATCH
				SELECT ERROR_MESSAGE() AS 'Error: Unable to set teamPts'
			END CATCH

			BEGIN TRY -- try catch for setting teamRebs
				SET @teamRebs = (@teamOffRebs + @teamDefRebs)
			END TRY
			BEGIN CATCH
				SELECT ERROR_MESSAGE() AS 'Error: Unable to set teamRebs'
			END CATCH

			-- Try Catch for inserting Values
			BEGIN TRY
				INSERT INTO TeamGameStat ([gameId],[teamPts],[teamFgA],[teamFgM],[teamFgP],
										[teamThreeA],[teamThreeM],[teamThreeP],
										[teamFtA],[teamFtM],[teamFtP],[teamRebs],
										[teamOffRebs],[teamDefRebs],[teamAssists],[teamSteals],
										[teamTurnovers],
										[teamBlocks],[teamFouls],[oppPts])
				VALUES (@gameID, @teamPts, @teamFgA, @teamFgM, @teamFgP, 
						@teamThreeA, @teamThreeM, @teamThreeP, 
						@teamFtA, @teamFtM, @teamFtP, @teamRebs,
						@teamOffRebs, @teamDefRebs, @teamAssists, @teamSteals,
						@teamTurnovers, @teamBlocks, @teamFouls, @oppPts)
			END TRY
			BEGIN CATCH
				SELECT ERROR_MESSAGE() AS 'Error: Unable to Insert team Values'
			END CATCH

		IF (@@ERROR > 0)
			BEGIN
				ROLLBACK TRAN
			END
		COMMIT TRAN
	
	END TRY
	BEGIN CATCH
		SELECT ERROR_MESSAGE() AS 'Error: Unable to insert into team game stats'
	END CATCH
END;
GO


-----------------------------------------------------------------------------------
-- User Defined Function for a team whose playerStatId is higher than the argument --
-----------------------------------------------------------------------------------
IF OBJECT_ID(N'dbo.funcGetPlayerStatIDsGreaterThan',N'IF') IS NOT NULL
	DROP FUNCTION dbo.funcGetPlayerStatIDsGreaterThan;
GO
CREATE OR ALTER FUNCTION dbo.funcGetPlayerStatIDsGreaterThan(@playerStatID int)
RETURNS table
AS
-- Returns all PlayerStatIds Greater than the one provided or last one entered.
RETURN
(
	SELECT playerStatId, firstName, lastName 
	FROM PlayerStat inner join player on player.playerId=PlayerStat.playerId
	where playerStatId > @playerStatID
);
GO
