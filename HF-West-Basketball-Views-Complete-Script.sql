
-- Author: Dawan Savage Bell
-- Date: Nov 26, 2022
-- Description: Views created to access player and team stats more efficiently 


--------------------------------
-- VIEWS FOR GAME 2 VS CITADEL --
--------------------------------
USE hfxWestBasketball
GO

-- Player Stats vs Citadel Game 2 View --
CREATE OR ALTER VIEW vPlayerStatsVSCitadelGame2
AS
	SELECT Player.playerId, Player.[firstName], Player.[lastName], [playerPts], [playerFgA], [playerFgM], [playerFgP],[playerThreeA], [playerThreeM], [playerThreeP],
	[playerFtA], [playerFtM], [playerFtP], [playerRebs],[playerDefRebs],[playerOffRebs],[playerAssists],[playerSteals],[playerTurnovers],[playerBlocks],[playerFouls]
	FROM PlayerStat 
	INNER JOIN Player
	ON PlayerStat.playerId = Player.playerId
	INNER JOIN PlayerGameStat
	ON PlayerGameStat.playerStatId = PlayerStat.playerStatId
	WHERE PlayerGameStat.gameId=2;
GO

-- Team Stats vs Citadel Game 2 View --
CREATE OR ALTER VIEW vTeamStatsVSCitadelGame2
AS
	SELECT[teamPts]
      ,[teamFgA]
      ,[teamFgM]
      ,[teamFgP]
      ,[teamThreeA]
      ,[teamThreeM]
      ,[teamThreeP]
      ,[teamFtA]
      ,[teamFtM]
      ,[teamFtP]
      ,[teamRebs]
      ,[teamOffRebs]
      ,[teamDefRebs]
      ,[teamAssists]
      ,[teamSteals]
      ,[teamTurnovers]
      ,[teamBlocks]
      ,[teamFouls]
      ,[oppPts]
	FROM [hfxWestBasketball].[dbo].[TeamGameStat]
	INNER JOIN Game
		ON Game.gameId= TeamGameStat.gameId
	WHERE TeamGameStat.gameId = 2;
GO


-------------------------------
-- VIEWS FOR GAME 3 VS AMBRAE --
-------------------------------

-- Player Stats vs Ambrae Game 3 View
CREATE OR ALTER VIEW vPlayerStatsVSAmbraeGame3
AS
	SELECT Player.playerId, Player.[firstName], Player.[lastName], [playerPts], [playerFgA], [playerFgM], [playerFgP],[playerThreeA], [playerThreeM], [playerThreeP],
	[playerFtA], [playerFtM], [playerFtP], [playerRebs],[playerDefRebs],[playerOffRebs],[playerAssists],[playerSteals],[playerTurnovers],[playerBlocks],[playerFouls]
	FROM PlayerStat 
	INNER JOIN Player
	ON PlayerStat.playerId = Player.playerId
	INNER JOIN PlayerGameStat
	ON PlayerGameStat.playerStatId = PlayerStat.playerStatId
	WHERE PlayerGameStat.gameId=3;
GO


-- Team Stats vs Ambrae Game 3 View
CREATE OR ALTER VIEW vTeamStatsVSAmbraeGame3
AS
	SELECT[teamPts]
      ,[teamFgA]
      ,[teamFgM]
      ,[teamFgP]
      ,[teamThreeA]
      ,[teamThreeM]
      ,[teamThreeP]
      ,[teamFtA]
      ,[teamFtM]
      ,[teamFtP]
      ,[teamRebs]
      ,[teamOffRebs]
      ,[teamDefRebs]
      ,[teamAssists]
      ,[teamSteals]
      ,[teamTurnovers]
      ,[teamBlocks]
      ,[teamFouls]
      ,[oppPts]
	FROM [hfxWestBasketball].[dbo].[TeamGameStat]
	INNER JOIN Game
		ON Game.gameId= TeamGameStat.gameId
	WHERE TeamGameStat.gameId = 3;
GO


-------------------------------
-- VIEWS FOR GAME 3 VS AUBURN --
-------------------------------

-- Player Stats vs Auburn Game 4 View
CREATE OR ALTER VIEW vPlayerStatsVSAuburnGame4
AS
	SELECT Player.playerId, Player.[firstName] + ' ' + Player.[lastName] AS PlayerName, [playerPts], [playerFgA], [playerFgM], [playerFgP],[playerThreeA], [playerThreeM], [playerThreeP],
	[playerFtA], [playerFtM], [playerFtP], [playerRebs],[playerDefRebs],[playerOffRebs],[playerAssists],[playerSteals],[playerTurnovers],[playerBlocks],[playerFouls]
	FROM PlayerStat 
	INNER JOIN Player
	ON PlayerStat.playerId = Player.playerId
	INNER JOIN PlayerGameStat
	ON PlayerGameStat.playerStatId = PlayerStat.playerStatId
	WHERE PlayerGameStat.gameId=4;
GO

-- Team Stats vs Auburn Game 4 View
CREATE OR ALTER VIEW vTeamStatsVSAuburnGame4
AS
	SELECT[teamPts]
      ,[teamFgA]
      ,[teamFgM]
      ,[teamFgP]
      ,[teamThreeA]
      ,[teamThreeM]
      ,[teamThreeP]
      ,[teamFtA]
      ,[teamFtM]
      ,[teamFtP]
      ,[teamRebs]
      ,[teamOffRebs]
      ,[teamDefRebs]
      ,[teamAssists]
      ,[teamSteals]
      ,[teamTurnovers]
      ,[teamBlocks]
      ,[teamFouls]
      ,[oppPts]
	FROM [hfxWestBasketball].[dbo].[TeamGameStat]
	INNER JOIN Game
		ON Game.gameId= TeamGameStat.gameId
	WHERE TeamGameStat.gameId = 4;
GO



-----------------------------------------------------------------
-- VIEW FOR PLAYERSTATS TOTAL AND AVERAGE FROM GAMES 2,3, AND 4--
-----------------------------------------------------------------

CREATE OR ALTER VIEW vPlayerSeasonTotalandAvgFromGame2Game3Game4
AS
(
  SELECT PlayerStat.playerId, firstName + ' ' + lastName AS playerName
	,SUM ([playerPts]) AS TotalPoints
	,AVG ([playerPts]) AS avgPPG
      ,AVG ([playerFgA]) AS avgFGA
      ,AVG ([playerFgM]) AS avgFGM
      ,CAST(ROUND(AVG ([playerFgP]),2) AS DEC(10,2)) AS avgFGP
      ,AVG ([playerThreeA]) AS avgThreeA
      ,AVG ([playerThreeM]) AS avgThreeM
      ,ROUND(AVG ([playerThreeP]),2)  AS avgThreeP
      ,AVG ([playerFtA]) AS avgFtA
      ,AVG ([playerFtM]) AS avgFtM
      ,ROUND(AVG ([playerFtP]),2) AS avgFtP
	  , SUM (playerRebs) AS TotalRebs
      ,AVG ([playerRebs])  AS avgRebs
      ,AVG ([playerDefRebs])  AS avgDefRebs
      ,AVG ([playerOffRebs])  AS avgOffRebs
	  ,SUM([playerAssists]) AS TotalAssists
      ,AVG ([playerAssists])  AS avgAssists
	  ,SUM ([playerSteals]) AS TotalSteals
      ,AVG ([playerSteals])  AS avgSteals
	  ,SUM ([playerTurnovers]) AS TotalTurnovers
      ,AVG ([playerTurnovers])  AS avgTurnOvers
	  ,SUM ([playerBlocks]) AS TotalBlocks
      ,AVG ([playerBlocks])  AS avgBlocks
      ,AVG ([playerFouls]) AS avgFouls
	  FROM PlayerStat 
	  INNER JOIN Player
	  ON Player.playerId = PlayerStat.playerid
	  INNER JOIN PlayerGameStat
	  ON PlayerGameStat.playerStatId = PlayerStat.playerStatId
	  WHERE PlayerGameStat.gameId IN (2,3,4)
	  GROUP BY PlayerStat.playerId, firstName, lastName
)
GO

------------------------------------------------------------------
-- VIEW FOR Teamgamestat TOTAL AND AVERAGE FROM GAMES 2,3, AND 4--
------------------------------------------------------------------

CREATE OR ALTER VIEW vTeamSeasonTotalandAvgFromGame2Game3Game4
AS
(
  SELECT 
	SUM ([teamPts]) AS TotalPoints
	,AVG ([teamPts]) AS avgPPG
      ,AVG ([teamFgA]) AS avgFGA
      ,AVG ([teamFgM]) AS avgFGM
      ,CAST(ROUND(AVG ([teamFgP]),2) AS DEC(10,2)) AS avgFGP
      ,AVG ([teamThreeA]) AS avgThreeA
      ,AVG ([teamThreeM]) AS avgThreeM
      ,ROUND(AVG ([teamThreeP]),2)  AS avgThreeP
      ,AVG ([teamFtA]) AS avgFtA
      ,AVG ([teamFtM]) AS avgFtM
      ,ROUND(AVG ([teamFtP]),2) AS avgFtP
	  , SUM (teamRebs) AS TotalRebs
      ,AVG ([teamRebs])  AS avgRebs
      ,AVG ([teamDefRebs])  AS avgDefRebs
      ,AVG ([teamOffRebs])  AS avgOffRebs
	  ,SUM([teamAssists]) AS TotalAssists
      ,AVG ([teamAssists])  AS avgAssists
	  ,SUM ([teamSteals]) AS TotalSteals
      ,AVG ([teamSteals])  AS avgSteals
	  ,SUM ([teamTurnovers]) AS TotalTurnovers
      ,AVG ([teamTurnovers])  AS avgTurnOvers
	  ,SUM ([teamBlocks]) AS TotalBlocks
      ,AVG ([teamBlocks])  AS avgBlocks
      ,AVG ([teamFouls]) AS avgFouls
	  ,AVG ([oppPts]) AS avgOppPts
	  FROM TeamGameStat 
	  WHERE TeamGameStat.gameId IN (2,3,4)
)
GO


----------------------------------------------
-- VIEWS FOR GAME 5 VS Bay View High School --
----------------------------------------------

-- Player Stats vs Bay View Game 5 View
CREATE OR ALTER VIEW vPlayerStatsVSBayViewGame5
AS
	SELECT Player.playerId, Player.[firstName] + ' ' + Player.[lastName] AS Player, 
	[playerPts] AS Points, 
	[playerFgA] AS 'Fg Attempts', 
	[playerFgM] AS 'Fg Made', 
	[playerFgP] AS 'Fg%',
	[playerThreeA] AS '3pt Attempts', 
	[playerThreeM] AS '3pt Made', 
	[playerThreeP] AS '3pt%',
	[playerFtA] AS 'Ft Attempts', 
	[playerFtM] AS 'Ft Made', 
	[playerFtP] AS 'Ft%', 
	[playerRebs] AS 'Rebs',
	[playerDefRebs] AS 'Deff Rebs',
	[playerOffRebs] AS 'Off Rebs',
	[playerAssists] AS 'Assists',
	[playerSteals] AS 'Steals',
	[playerTurnovers] AS 'Turnovers',
	[playerBlocks] AS 'Blocks',
	[playerFouls]  AS 'Fouls'
	FROM PlayerStat 
	INNER JOIN Player
	ON PlayerStat.playerId = Player.playerId
	INNER JOIN PlayerGameStat
	ON PlayerGameStat.playerStatId = PlayerStat.playerStatId
	WHERE PlayerGameStat.gameId=5;
GO

-- Team Stats vs Bay View Game 5 View
CREATE OR ALTER VIEW vTeamStatsVSBayViewGame5
AS
	SELECT[teamPts] AS 'Points'
      ,[teamFgA] AS 'Fg Attempts'
      ,[teamFgM] AS 'Fg Made'
      ,[teamFgP] AS 'Fg%'
      ,[teamThreeA] AS '3pt Attempts'
      ,[teamThreeM] AS '3pt Made'
      ,[teamThreeP] AS '3pt%'
      ,[teamFtA] AS 'Ft Attempts'
      ,[teamFtM] AS 'Ft Made'
      ,[teamFtP] AS 'Ft%'
      ,[teamRebs] AS 'Rebs'
      ,[teamOffRebs] AS 'Off Rebs'
      ,[teamDefRebs] AS 'Def Rebs'
      ,[teamAssists] AS 'Assists'
      ,[teamSteals] AS 'Steals'
      ,[teamTurnovers] AS 'Turnovers'
      ,[teamBlocks] AS 'Blocks'
      ,[teamFouls] AS 'Fouls'
      ,[oppPts] AS 'Opp Points'
	FROM [hfxWestBasketball].[dbo].[TeamGameStat]
	INNER JOIN Game
		ON Game.gameId=TeamGameStat.gameId
	WHERE TeamGameStat.gameId=5;
GO

-----------------------------------------------------------------
-- VIEW FOR PLAYERSTATS TOTAL AND AVERAGE FROM GAMES 2,3,4, AND 5--
-----------------------------------------------------------------

CREATE OR ALTER VIEW vPlayerSeasonTotalandAvgFromGame2Game3Game4Game5
AS
(
  SELECT PlayerStat.playerId, firstName + ' ' + lastName AS playerName
	,SUM ([playerPts]) AS 'Total Points'
	,AVG ([playerPts]) AS avgPPG
      ,AVG ([playerFgA]) AS avgFGA
      ,AVG ([playerFgM]) AS avgFGM
      ,CAST(ROUND(AVG ([playerFgP]),2) AS DEC(10,2)) AS avgFGP
      ,AVG ([playerThreeA]) AS avgThreeA
      ,AVG ([playerThreeM]) AS avgThreeM
      ,ROUND(AVG ([playerThreeP]),2)  AS avgThreeP
      ,AVG ([playerFtA]) AS avgFtA
      ,AVG ([playerFtM]) AS avgFtM
      ,ROUND(AVG ([playerFtP]),2) AS avgFtP
	  , SUM (playerRebs) AS TotalRebs
      ,AVG ([playerRebs])  AS avgRebs
      ,AVG ([playerDefRebs])  AS avgDefRebs
      ,AVG ([playerOffRebs])  AS avgOffRebs
	  ,SUM([playerAssists]) AS TotalAssists
      ,AVG ([playerAssists])  AS avgAssists
	  ,SUM ([playerSteals]) AS TotalSteals
      ,AVG ([playerSteals])  AS avgSteals
	  ,SUM ([playerTurnovers]) AS TotalTurnovers
      ,AVG ([playerTurnovers])  AS avgTurnOvers
	  ,SUM ([playerBlocks]) AS TotalBlocks
      ,AVG ([playerBlocks])  AS avgBlocks
      ,AVG ([playerFouls]) AS avgFouls
	  FROM PlayerStat 
	  INNER JOIN Player
	  ON Player.playerId = PlayerStat.playerid
	  INNER JOIN PlayerGameStat
	  ON PlayerGameStat.playerStatId = PlayerStat.playerStatId
	  WHERE PlayerGameStat.gameId IN (2,3,4,5)
	  GROUP BY PlayerStat.playerId, firstName, lastName
)
GO

------------------------------------------------------------------
-- VIEW FOR Teamgamestat TOTAL AND AVERAGE FROM GAMES 2,3,4, AND 5--
------------------------------------------------------------------

CREATE OR ALTER VIEW vTeamSeasonTotalandAvgFromGame2Game3Game4Game5
AS
(
  SELECT 
	SUM ([teamPts]) AS TotalPoints
	,AVG ([teamPts]) AS avgPPG
      ,AVG ([teamFgA]) AS avgFGA
      ,AVG ([teamFgM]) AS avgFGM
      ,CAST(ROUND(AVG ([teamFgP]),2) AS DEC(10,2)) AS avgFGP
      ,AVG ([teamThreeA]) AS avgThreeA
      ,AVG ([teamThreeM]) AS avgThreeM
      ,ROUND(AVG ([teamThreeP]),2)  AS avgThreeP
      ,AVG ([teamFtA]) AS avgFtA
      ,AVG ([teamFtM]) AS avgFtM
      ,ROUND(AVG ([teamFtP]),2) AS avgFtP
	  , SUM (teamRebs) AS TotalRebs
      ,AVG ([teamRebs])  AS avgRebs
      ,AVG ([teamDefRebs])  AS avgDefRebs
      ,AVG ([teamOffRebs])  AS avgOffRebs
	  ,SUM([teamAssists]) AS TotalAssists
      ,AVG ([teamAssists])  AS avgAssists
	  ,SUM ([teamSteals]) AS TotalSteals
      ,AVG ([teamSteals])  AS avgSteals
	  ,SUM ([teamTurnovers]) AS TotalTurnovers
      ,AVG ([teamTurnovers])  AS avgTurnOvers
	  ,SUM ([teamBlocks]) AS TotalBlocks
      ,AVG ([teamBlocks])  AS avgBlocks
      ,AVG ([teamFouls]) AS avgFouls
	  ,AVG ([oppPts]) AS avgOppPts
	  FROM TeamGameStat 
	  WHERE TeamGameStat.gameId IN (2,3,4,5)
)
GO


----------------------------------------------
-- VIEWS FOR GAME 6 VS DARTMOUTH High School --
----------------------------------------------

-- Player Stats vs Dartmouth Game 6 View
CREATE OR ALTER VIEW vPlayerStatsVSDartmouthGame6
AS
	SELECT Player.playerId, Player.[firstName] + ' ' + Player.[lastName] AS Player, 
	[playerPts] AS Points, 
	[playerFgA] AS 'Fg Attempts', 
	[playerFgM] AS 'Fg Made', 
	[playerFgP] AS 'Fg%',
	[playerThreeA] AS '3pt Attempts', 
	[playerThreeM] AS '3pt Made', 
	[playerThreeP] AS '3pt%',
	[playerFtA] AS 'Ft Attempts', 
	[playerFtM] AS 'Ft Made', 
	[playerFtP] AS 'Ft%', 
	[playerRebs] AS 'Rebs',
	[playerDefRebs] AS 'Deff Rebs',
	[playerOffRebs] AS 'Off Rebs',
	[playerAssists] AS 'Assists',
	[playerSteals] AS 'Steals',
	[playerTurnovers] AS 'Turnovers',
	[playerBlocks] AS 'Blocks',
	[playerFouls]  AS 'Fouls'
	FROM PlayerStat 
	INNER JOIN Player
	ON PlayerStat.playerId = Player.playerId
	INNER JOIN PlayerGameStat
	ON PlayerGameStat.playerStatId = PlayerStat.playerStatId
	WHERE PlayerGameStat.gameId=6;
GO

-- Team Stats vs Dartmouth Game 6 View
CREATE OR ALTER VIEW vTeamStatsVSDartmouthGame6
AS
	SELECT[teamPts] AS 'Points'
      ,[teamFgA] AS 'Fg Attempts'
      ,[teamFgM] AS 'Fg Made'
      ,[teamFgP] AS 'Fg%'
      ,[teamThreeA] AS '3pt Attempts'
      ,[teamThreeM] AS '3pt Made'
      ,[teamThreeP] AS '3pt%'
      ,[teamFtA] AS 'Ft Attempts'
      ,[teamFtM] AS 'Ft Made'
      ,[teamFtP] AS 'Ft%'
      ,[teamRebs] AS 'Rebs'
      ,[teamOffRebs] AS 'Off Rebs'
      ,[teamDefRebs] AS 'Def Rebs'
      ,[teamAssists] AS 'Assists'
      ,[teamSteals] AS 'Steals'
      ,[teamTurnovers] AS 'Turnovers'
      ,[teamBlocks] AS 'Blocks'
      ,[teamFouls] AS 'Fouls'
      ,[oppPts] AS 'Opp Points'
	FROM [hfxWestBasketball].[dbo].[TeamGameStat]
	INNER JOIN Game
		ON Game.gameId=TeamGameStat.gameId
	WHERE TeamGameStat.gameId=6;
GO


----------------------------------------------
-- VIEWS FOR GAME 7 VS GRAMMAR High School --
----------------------------------------------

-- Player Stats vs Grammar Game 7 View
CREATE OR ALTER VIEW vPlayerStatsVSGrammarGame7
AS
	SELECT Player.playerId, Player.[firstName] + ' ' + Player.[lastName] AS Player, 
	[playerPts] AS Points, 
	[playerFgA] AS 'Fg Attempts', 
	[playerFgM] AS 'Fg Made', 
	[playerFgP] AS 'Fg%',
	[playerThreeA] AS '3pt Attempts', 
	[playerThreeM] AS '3pt Made', 
	[playerThreeP] AS '3pt%',
	[playerFtA] AS 'Ft Attempts', 
	[playerFtM] AS 'Ft Made', 
	[playerFtP] AS 'Ft%', 
	[playerRebs] AS 'Rebs',
	[playerDefRebs] AS 'Deff Rebs',
	[playerOffRebs] AS 'Off Rebs',
	[playerAssists] AS 'Assists',
	[playerSteals] AS 'Steals',
	[playerTurnovers] AS 'Turnovers',
	[playerBlocks] AS 'Blocks',
	[playerFouls]  AS 'Fouls'
	FROM PlayerStat 
	INNER JOIN Player
	ON PlayerStat.playerId = Player.playerId
	INNER JOIN PlayerGameStat
	ON PlayerGameStat.playerStatId = PlayerStat.playerStatId
	WHERE PlayerGameStat.gameId=7;
GO

-- Team Stats vs Grammar Game 7 View 
CREATE OR ALTER VIEW vTeamStatsVSGrammarGame7
AS
	SELECT[teamPts] AS 'Points'
      ,[teamFgA] AS 'Fg Attempts'
      ,[teamFgM] AS 'Fg Made'
      ,[teamFgP] AS 'Fg%'
      ,[teamThreeA] AS '3pt Attempts'
      ,[teamThreeM] AS '3pt Made'
      ,[teamThreeP] AS '3pt%'
      ,[teamFtA] AS 'Ft Attempts'
      ,[teamFtM] AS 'Ft Made'
      ,[teamFtP] AS 'Ft%'
      ,[teamRebs] AS 'Rebs'
      ,[teamOffRebs] AS 'Off Rebs'
      ,[teamDefRebs] AS 'Def Rebs'
      ,[teamAssists] AS 'Assists'
      ,[teamSteals] AS 'Steals'
      ,[teamTurnovers] AS 'Turnovers'
      ,[teamBlocks] AS 'Blocks'
      ,[teamFouls] AS 'Fouls'
      ,[oppPts] AS 'Opp Points'
	FROM [hfxWestBasketball].[dbo].[TeamGameStat]
	INNER JOIN Game
		ON Game.gameId=TeamGameStat.gameId
	WHERE TeamGameStat.gameId=7;
GO

-----------------------------------------------------------------
-- VIEW FOR PLAYERSTATS TOTAL AND AVERAGE FROM GAMES 2,3,4,5,6 AND 7--
-----------------------------------------------------------------

CREATE OR ALTER VIEW vPlayerSeasonTotalandAvgFromGame2Game3Game4Game5Game6Game7
AS
(
  SELECT PlayerStat.playerId, firstName + ' ' + lastName AS playerName
	,SUM ([playerPts]) AS 'Total Points'
	,AVG ([playerPts]) AS avgPPG
      ,AVG ([playerFgA]) AS avgFGA
      ,AVG ([playerFgM]) AS avgFGM
      ,CAST(ROUND(AVG ([playerFgP]),2) AS DEC(10,2)) AS avgFGP
      ,AVG ([playerThreeA]) AS avgThreeA
      ,AVG ([playerThreeM]) AS avgThreeM
      ,ROUND(AVG ([playerThreeP]),2)  AS avgThreeP
      ,AVG ([playerFtA]) AS avgFtA
      ,AVG ([playerFtM]) AS avgFtM
      ,ROUND(AVG ([playerFtP]),2) AS avgFtP
	  , SUM (playerRebs) AS TotalRebs
      ,AVG ([playerRebs])  AS avgRebs
      ,AVG ([playerDefRebs])  AS avgDefRebs
      ,AVG ([playerOffRebs])  AS avgOffRebs
	  ,SUM([playerAssists]) AS TotalAssists
      ,AVG ([playerAssists])  AS avgAssists
	  ,SUM ([playerSteals]) AS TotalSteals
      ,AVG ([playerSteals])  AS avgSteals
	  ,SUM ([playerTurnovers]) AS TotalTurnovers
      ,AVG ([playerTurnovers])  AS avgTurnOvers
	  ,SUM ([playerBlocks]) AS TotalBlocks
      ,AVG ([playerBlocks])  AS avgBlocks
      ,AVG ([playerFouls]) AS avgFouls
	  FROM PlayerStat 
	  INNER JOIN Player
	  ON Player.playerId = PlayerStat.playerid
	  INNER JOIN PlayerGameStat
	  ON PlayerGameStat.playerStatId = PlayerStat.playerStatId
	  WHERE PlayerGameStat.gameId > 1
	  GROUP BY PlayerStat.playerId, firstName, lastName
)
GO

------------------------------------------------------------------
-- VIEW FOR Teamgamestat TOTAL AND AVERAGE FROM GAMES 2,3,4,5,6, AND 7--
------------------------------------------------------------------

CREATE OR ALTER VIEW vTeamSeasonTotalandAvgFromGame2Game3Game4Game5Game6Game7
AS
(
  SELECT 
	SUM ([teamPts]) AS TotalPoints
	,AVG ([teamPts]) AS avgPPG
      ,AVG ([teamFgA]) AS avgFGA
      ,AVG ([teamFgM]) AS avgFGM
      ,CAST(ROUND(AVG ([teamFgP]),2) AS DEC(10,2)) AS avgFGP
      ,AVG ([teamThreeA]) AS avgThreeA
      ,AVG ([teamThreeM]) AS avgThreeM
      ,ROUND(AVG ([teamThreeP]),2)  AS avgThreeP
      ,AVG ([teamFtA]) AS avgFtA
      ,AVG ([teamFtM]) AS avgFtM
      ,ROUND(AVG ([teamFtP]),2) AS avgFtP
	  , SUM (teamRebs) AS TotalRebs
      ,AVG ([teamRebs])  AS avgRebs
      ,AVG ([teamDefRebs])  AS avgDefRebs
      ,AVG ([teamOffRebs])  AS avgOffRebs
	  ,SUM([teamAssists]) AS TotalAssists
      ,AVG ([teamAssists])  AS avgAssists
	  ,SUM ([teamSteals]) AS TotalSteals
      ,AVG ([teamSteals])  AS avgSteals
	  ,SUM ([teamTurnovers]) AS TotalTurnovers
      ,AVG ([teamTurnovers])  AS avgTurnOvers
	  ,SUM ([teamBlocks]) AS TotalBlocks
      ,AVG ([teamBlocks])  AS avgBlocks
      ,AVG ([teamFouls]) AS avgFouls
	  ,AVG ([oppPts]) AS avgOppPts
	  FROM TeamGameStat 
	  WHERE TeamGameStat.gameId > 1
)
GO


----------------------------------------------
-- VIEWS FOR GAME 8 VS JL High School --
----------------------------------------------

-- Player Stats vs JL Game 8 View
CREATE OR ALTER VIEW vPlayerStatsVSJLGame8
AS
	SELECT
	Player.playerId,
	Player.[firstName] + ' ' + Player.[lastName] AS Player, 
	[playerPts] AS Points, 
	[playerFgA] AS 'Fg Attempts', 
	[playerFgM] AS 'Fg Made', 
	[playerFgP] AS 'Fg%',
	[playerThreeA] AS '3pt Attempts', 
	[playerThreeM] AS '3pt Made', 
	[playerThreeP] AS '3pt%',
	[playerFtA] AS 'Ft Attempts', 
	[playerFtM] AS 'Ft Made', 
	[playerFtP] AS 'Ft%', 
	[playerRebs] AS 'Rebs',
	[playerDefRebs] AS 'Deff Rebs',
	[playerOffRebs] AS 'Off Rebs',
	[playerAssists] AS 'Assists',
	[playerSteals] AS 'Steals',
	[playerTurnovers] AS 'Turnovers',
	[playerBlocks] AS 'Blocks',
	[playerFouls]  AS 'Fouls'
	FROM PlayerStat 
	INNER JOIN Player
	ON PlayerStat.playerId = Player.playerId
	INNER JOIN PlayerGameStat
	ON PlayerGameStat.playerStatId = PlayerStat.playerStatId
	WHERE PlayerGameStat.gameId=8;
GO

-- Team Stats vs JL Game 8 View 
CREATE OR ALTER VIEW vTeamStatsVSJLGame8
AS
	SELECT[teamPts] AS 'Points'
      ,[teamFgA] AS 'Fg Attempts'
      ,[teamFgM] AS 'Fg Made'
      ,[teamFgP] AS 'Fg%'
      ,[teamThreeA] AS '3pt Attempts'
      ,[teamThreeM] AS '3pt Made'
      ,[teamThreeP] AS '3pt%'
      ,[teamFtA] AS 'Ft Attempts'
      ,[teamFtM] AS 'Ft Made'
      ,[teamFtP] AS 'Ft%'
      ,[teamRebs] AS 'Rebs'
      ,[teamOffRebs] AS 'Off Rebs'
      ,[teamDefRebs] AS 'Def Rebs'
      ,[teamAssists] AS 'Assists'
      ,[teamSteals] AS 'Steals'
      ,[teamTurnovers] AS 'Turnovers'
      ,[teamBlocks] AS 'Blocks'
      ,[teamFouls] AS 'Fouls'
      ,[oppPts] AS 'Opp Points'
	FROM [hfxWestBasketball].[dbo].[TeamGameStat]
	INNER JOIN Game
		ON Game.gameId=TeamGameStat.gameId
	WHERE TeamGameStat.gameId=8;
GO


-----------------------------------------------------------------
-- VIEW FOR PLAYERSTATS TOTAL AND AVERAGE FROM ALL GAMES not 1 --
-----------------------------------------------------------------

CREATE OR ALTER VIEW vPlayerSeasonTotalandAvgFromGame2Game3Game4Game5Game6Game7Game8
AS
(
  SELECT PlayerStat.playerId, 
	Player.firstName + ' ' + Player.lastName AS 'Player Name',
	SUBSTRING([firstName],1,1) + '.' + SUBSTRING([lastName],1,1) + '.' AS 'Player Initials'
	,SUM ([playerPts]) AS 'Total Points'
	,AVG ([playerPts]) AS avgPPG
      ,AVG ([playerFgA]) AS avgFGA
      ,AVG ([playerFgM]) AS avgFGM,
	  AVG (CASE WHEN [playerFgA] <>0 THEN CAST(Round(([playerFgP]),2) AS DEC(10, 2)) END) AS avgFgP
      ,AVG ([playerThreeA]) AS avgThreeA
      ,AVG ([playerThreeM]) AS avgThreeM
      ,AVG (CASE WHEN [playerThreeA]<>0 THEN CAST(Round(([playerThreeP]),2) AS DEC(10,2))END)  AS avgThreeP
      ,AVG ([playerFtA]) AS avgFtA
      ,AVG ([playerFtM]) AS avgFtM
      ,AVG (CASE WHEN [playerFtA]<> 0 THEN Cast(Round(([playerFtP]),2) AS DEC(10, 2)) END) AS avgFtP
	  , SUM (playerRebs) AS TotalRebs
      ,AVG ([playerRebs])  AS avgRebs
      ,AVG ([playerDefRebs])  AS avgDefRebs
      ,AVG ([playerOffRebs])  AS avgOffRebs
	  ,SUM([playerAssists]) AS TotalAssists
      ,AVG ([playerAssists])  AS avgAssists
	  ,SUM ([playerSteals]) AS TotalSteals
      ,AVG ([playerSteals])  AS avgSteals
	  ,SUM ([playerTurnovers]) AS TotalTurnovers
      ,AVG ([playerTurnovers])  AS avgTurnOvers
	  ,SUM ([playerBlocks]) AS TotalBlocks
      ,AVG ([playerBlocks])  AS avgBlocks
      ,AVG ([playerFouls]) AS avgFouls
	  FROM PlayerStat 
	  INNER JOIN Player
	  ON Player.playerId = PlayerStat.playerid
	  INNER JOIN PlayerGameStat
	  ON PlayerGameStat.playerStatId = PlayerStat.playerStatId
	  WHERE PlayerGameStat.gameId > 1 
	  GROUP BY PlayerStat.playerId, firstName, lastName
)
GO

------------------------------------------------------------------
-- VIEW FOR Teamgamestat TOTAL AND AVERAGE FROM ALL GAMES not 1--
------------------------------------------------------------------

CREATE OR ALTER VIEW vTeamSeasonTotalandAvgFromGame2Game3Game4Game5Game6Game7Game8
AS
(
  SELECT 
	SUM ([teamPts]) AS TotalPoints
	,AVG ([teamPts]) AS avgPPG
      ,AVG ([teamFgA]) AS avgFGA
      ,AVG ([teamFgM]) AS avgFGM
      ,CAST(ROUND(AVG ([teamFgP]),2) AS DEC(10,2)) AS avgFGP
      ,AVG ([teamThreeA]) AS avgThreeA
      ,AVG ([teamThreeM]) AS avgThreeM
      ,ROUND(AVG ([teamThreeP]),2)  AS avgThreeP
      ,AVG ([teamFtA]) AS avgFtA
      ,AVG ([teamFtM]) AS avgFtM
      ,ROUND(AVG ([teamFtP]),2) AS avgFtP
	  , SUM (teamRebs) AS TotalRebs
      ,AVG ([teamRebs])  AS avgRebs
      ,AVG ([teamDefRebs])  AS avgDefRebs
      ,AVG ([teamOffRebs])  AS avgOffRebs
	  ,SUM([teamAssists]) AS TotalAssists
      ,AVG ([teamAssists])  AS avgAssists
	  ,SUM ([teamSteals]) AS TotalSteals
      ,AVG ([teamSteals])  AS avgSteals
	  ,SUM ([teamTurnovers]) AS TotalTurnovers
      ,AVG ([teamTurnovers])  AS avgTurnOvers
	  ,SUM ([teamBlocks]) AS TotalBlocks
      ,AVG ([teamBlocks])  AS avgBlocks
      ,AVG ([teamFouls]) AS avgFouls
	  ,AVG ([oppPts]) AS avgOppPts
	  FROM TeamGameStat 
	  WHERE TeamGameStat.gameId > 1
)
GO


-----------------------------------------------------------------
-- VIEW FOR PLAYERSTATS TOTAL AND AVERAGE FROM GAMES 5,6,7,8--
-----------------------------------------------------------------

CREATE OR ALTER VIEW vPlayerSeasonTotalandAvgFromGame5Game6Game7Game8
AS
(
  SELECT PlayerStat.playerId, firstName + ' ' + lastName AS playerName
	,SUM ([playerPts]) AS 'Total Points'
	,AVG ([playerPts]) AS avgPPG
      ,AVG ([playerFgA]) AS avgFGA
      ,AVG ([playerFgM]) AS avgFGM
      ,CAST(ROUND(AVG ([playerFgP]),2) AS DEC(10,2)) AS avgFGP
      ,AVG ([playerThreeA]) AS avgThreeA
      ,AVG ([playerThreeM]) AS avgThreeM
      ,ROUND(AVG ([playerThreeP]),2)  AS avgThreeP
      ,AVG ([playerFtA]) AS avgFtA
      ,AVG ([playerFtM]) AS avgFtM
      ,ROUND(AVG ([playerFtP]),2) AS avgFtP
	  , SUM (playerRebs) AS TotalRebs
      ,AVG ([playerRebs])  AS avgRebs
      ,AVG ([playerDefRebs])  AS avgDefRebs
      ,AVG ([playerOffRebs])  AS avgOffRebs
	  ,SUM([playerAssists]) AS TotalAssists
      ,AVG ([playerAssists])  AS avgAssists
	  ,SUM ([playerSteals]) AS TotalSteals
      ,AVG ([playerSteals])  AS avgSteals
	  ,SUM ([playerTurnovers]) AS TotalTurnovers
      ,AVG ([playerTurnovers])  AS avgTurnOvers
	  ,SUM ([playerBlocks]) AS TotalBlocks
      ,AVG ([playerBlocks])  AS avgBlocks
      ,AVG ([playerFouls]) AS avgFouls
	  FROM PlayerStat 
	  INNER JOIN Player
	  ON Player.playerId = PlayerStat.playerid
	  INNER JOIN PlayerGameStat
	  ON PlayerGameStat.playerStatId = PlayerStat.playerStatId
	  WHERE PlayerGameStat.gameId > 4 
	  GROUP BY PlayerStat.playerId, firstName, lastName
)
GO

------------------------------------------------------------------
-- VIEW FOR Teamgamestat TOTAL AND AVERAGE FROM GAMES 5,6,7, 8--
------------------------------------------------------------------

CREATE OR ALTER VIEW vTeamSeasonTotalandAvgFromGame5Game6Game7Game8
AS
(
  SELECT 
	SUM ([teamPts]) AS TotalPoints
	,AVG ([teamPts]) AS avgPPG
      ,AVG ([teamFgA]) AS avgFGA
      ,AVG ([teamFgM]) AS avgFGM
      ,CAST(ROUND(AVG ([teamFgP]),2) AS DEC(10,2)) AS avgFGP
      ,AVG ([teamThreeA]) AS avgThreeA
      ,AVG ([teamThreeM]) AS avgThreeM
      ,ROUND(AVG ([teamThreeP]),2)  AS avgThreeP
      ,AVG ([teamFtA]) AS avgFtA
      ,AVG ([teamFtM]) AS avgFtM
      ,ROUND(AVG ([teamFtP]),2) AS avgFtP
	  , SUM (teamRebs) AS TotalRebs
      ,AVG ([teamRebs])  AS avgRebs
      ,AVG ([teamDefRebs])  AS avgDefRebs
      ,AVG ([teamOffRebs])  AS avgOffRebs
	  ,SUM([teamAssists]) AS TotalAssists
      ,AVG ([teamAssists])  AS avgAssists
	  ,SUM ([teamSteals]) AS TotalSteals
      ,AVG ([teamSteals])  AS avgSteals
	  ,SUM ([teamTurnovers]) AS TotalTurnovers
      ,AVG ([teamTurnovers])  AS avgTurnOvers
	  ,SUM ([teamBlocks]) AS TotalBlocks
      ,AVG ([teamBlocks])  AS avgBlocks
      ,AVG ([teamFouls]) AS avgFouls
	  ,AVG ([oppPts]) AS avgOppPts
	  FROM TeamGameStat 
	  WHERE TeamGameStat.gameId > 4
)
GO

------------------------------------
-- VIEW FOR Opponents Information--
------------------------------------
CREATE OR ALTER VIEW dbo.vAllOppTeamNames
AS
-- Returns all PlayerStatIds Greater than the one provided or last one entered.
(
	SELECT [oppId],[schoolName],[teamName],[city] FROM Opponent
);
GO

-----------------------------------------------------------------
-- VIEW FOR PLAYERSTATS TOTAL AND AVERAGE FROM ALL GAMES not 1 --
-----------------------------------------------------------------

CREATE OR ALTER VIEW vFinalSeasonPlayerStats
AS
(
  SELECT PlayerStat.playerId, 
	Player.firstName + ' ' + Player.lastName AS 'Player Name',
	SUBSTRING([firstName],1,1) + '.' + SUBSTRING([lastName],1,1) + '.' AS 'Player Initials'
	,SUM ([playerPts]) AS 'Total Points'
	,AVG ([playerPts]) AS avgPPG
      ,AVG ([playerFgA]) AS avgFGA
      ,AVG ([playerFgM]) AS avgFGM,
	  AVG (CASE WHEN [playerFgA] <>0 THEN CAST(Round(([playerFgP]),2) AS DEC(10, 2)) END) AS avgFgP
      ,AVG ([playerThreeA]) AS avgThreeA
      ,AVG ([playerThreeM]) AS avgThreeM
      ,AVG (CASE WHEN [playerThreeA]<>0 THEN CAST(Round(([playerThreeP]),2) AS DEC(10,2))END)  AS avgThreeP
      ,AVG ([playerFtA]) AS avgFtA
      ,AVG ([playerFtM]) AS avgFtM
      ,AVG (CASE WHEN [playerFtA]<> 0 THEN Cast(Round(([playerFtP]),2) AS DEC(10, 2)) END) AS avgFtP
	  , SUM (playerRebs) AS TotalRebs
      ,AVG ([playerRebs])  AS avgRebs
      ,AVG ([playerDefRebs])  AS avgDefRebs
      ,AVG ([playerOffRebs])  AS avgOffRebs
	  ,SUM([playerAssists]) AS TotalAssists
      ,AVG ([playerAssists])  AS avgAssists
	  ,SUM ([playerSteals]) AS TotalSteals
      ,AVG ([playerSteals])  AS avgSteals
	  ,SUM ([playerTurnovers]) AS TotalTurnovers
      ,AVG ([playerTurnovers])  AS avgTurnOvers
	  ,SUM ([playerBlocks]) AS TotalBlocks
      ,AVG ([playerBlocks])  AS avgBlocks
      ,AVG ([playerFouls]) AS avgFouls
	  FROM PlayerStat 
	  INNER JOIN Player
	  ON Player.playerId = PlayerStat.playerid
	  INNER JOIN PlayerGameStat
	  ON PlayerGameStat.playerStatId = PlayerStat.playerStatId
	  WHERE PlayerGameStat.gameId > 1 
	  GROUP BY PlayerStat.playerId, firstName, lastName
)
GO

------------------------------------------------------------------
-- VIEW FOR Teamgamestat TOTAL AND AVERAGE FROM ALL GAMES not 1--
------------------------------------------------------------------

CREATE OR ALTER VIEW vFinalSeasonTeamStats
AS
(
  SELECT 
	SUM ([teamPts]) AS TotalPoints
	,AVG ([teamPts]) AS avgPPG
      ,AVG ([teamFgA]) AS avgFGA
      ,AVG ([teamFgM]) AS avgFGM
      ,CAST(ROUND(AVG ([teamFgP]),2) AS DEC(10,2)) AS avgFGP
      ,AVG ([teamThreeA]) AS avgThreeA
      ,AVG ([teamThreeM]) AS avgThreeM
      ,ROUND(AVG ([teamThreeP]),2)  AS avgThreeP
      ,AVG ([teamFtA]) AS avgFtA
      ,AVG ([teamFtM]) AS avgFtM
      ,ROUND(AVG ([teamFtP]),2) AS avgFtP
	  , SUM (teamRebs) AS TotalRebs
      ,AVG ([teamRebs])  AS avgRebs
      ,AVG ([teamDefRebs])  AS avgDefRebs
      ,AVG ([teamOffRebs])  AS avgOffRebs
	  ,SUM([teamAssists]) AS TotalAssists
      ,AVG ([teamAssists])  AS avgAssists
	  ,SUM ([teamSteals]) AS TotalSteals
      ,AVG ([teamSteals])  AS avgSteals
	  ,SUM ([teamTurnovers]) AS TotalTurnovers
      ,AVG ([teamTurnovers])  AS avgTurnOvers
	  ,SUM ([teamBlocks]) AS TotalBlocks
      ,AVG ([teamBlocks])  AS avgBlocks
      ,AVG ([teamFouls]) AS avgFouls
	  ,AVG ([oppPts]) AS avgOppPts
	  FROM TeamGameStat 
	  WHERE TeamGameStat.gameId > 1
)
GO