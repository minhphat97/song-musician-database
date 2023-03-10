USE [master]
GO
/****** Object:  Database [Phatt]    Script Date: 2021-08-07 6:09:24 PM ******/
CREATE DATABASE [Phatt]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Phatt', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\Phatt.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Phatt_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\Phatt_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Phatt] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Phatt].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Phatt] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Phatt] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Phatt] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Phatt] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Phatt] SET ARITHABORT OFF 
GO
ALTER DATABASE [Phatt] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Phatt] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Phatt] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Phatt] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Phatt] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Phatt] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Phatt] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Phatt] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Phatt] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Phatt] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Phatt] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Phatt] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Phatt] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Phatt] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Phatt] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Phatt] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Phatt] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Phatt] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Phatt] SET  MULTI_USER 
GO
ALTER DATABASE [Phatt] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Phatt] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Phatt] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Phatt] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Phatt] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Phatt] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Phatt] SET QUERY_STORE = OFF
GO
USE [Phatt]
GO
/****** Object:  UserDefinedFunction [dbo].[CheckConstraint]    Script Date: 2021-08-07 6:09:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[CheckConstraint]()
RETURNS int
AS 
BEGIN
	DECLARE @result int
	if (select COUNT(*) from Song s, Artist a
		WHERE s.artistname = a.artistname AND s.songyear < YEAR(a.startdate)) > 0
			SET @result = 0
		ELSE
			SET @result = 1
		RETURN @result
END
GO
/****** Object:  Table [dbo].[Artist]    Script Date: 2021-08-07 6:09:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Artist](
	[artistname] [varchar](30) NOT NULL,
	[startdate] [date] NOT NULL,
	[members] [int] NULL,
	[genre] [varchar](30) NULL,
 CONSTRAINT [PK_Artist] PRIMARY KEY CLUSTERED 
(
	[artistname] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Musician]    Script Date: 2021-08-07 6:09:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Musician](
	[msin] [char](5) NOT NULL,
	[firstname] [varchar](30) NULL,
	[lastname] [varchar](30) NOT NULL,
	[birthdate] [date] NULL,
 CONSTRAINT [PK_Musician] PRIMARY KEY CLUSTERED 
(
	[msin] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Plays]    Script Date: 2021-08-07 6:09:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Plays](
	[artistname] [varchar](30) NOT NULL,
	[msin] [char](5) NOT NULL,
	[share] [decimal](18, 3) NULL,
 CONSTRAINT [PK_Plays_1] PRIMARY KEY CLUSTERED 
(
	[artistname] ASC,
	[msin] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Song]    Script Date: 2021-08-07 6:09:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Song](
	[isrc] [char](14) NOT NULL,
	[title] [varchar](30) NULL,
	[songyear] [int] NULL,
	[artistname] [varchar](30) NULL,
 CONSTRAINT [PK_Song] PRIMARY KEY CLUSTERED 
(
	[isrc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [SongCandidateKey] UNIQUE NONCLUSTERED 
(
	[title] ASC,
	[artistname] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Plays]  WITH CHECK ADD  CONSTRAINT [FK_Plays_Artist] FOREIGN KEY([artistname])
REFERENCES [dbo].[Artist] ([artistname])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Plays] CHECK CONSTRAINT [FK_Plays_Artist]
GO
ALTER TABLE [dbo].[Plays]  WITH CHECK ADD  CONSTRAINT [FK_Plays_Musician] FOREIGN KEY([msin])
REFERENCES [dbo].[Musician] ([msin])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Plays] CHECK CONSTRAINT [FK_Plays_Musician]
GO
ALTER TABLE [dbo].[Song]  WITH CHECK ADD  CONSTRAINT [FK_Song_Artist] FOREIGN KEY([artistname])
REFERENCES [dbo].[Artist] ([artistname])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Song] CHECK CONSTRAINT [FK_Song_Artist]
GO
ALTER TABLE [dbo].[Song]  WITH CHECK ADD  CONSTRAINT [SongCheckConstraint] CHECK  (([dbo].[CheckConstraint]()=(1)))
GO
ALTER TABLE [dbo].[Song] CHECK CONSTRAINT [SongCheckConstraint]
GO
/****** Object:  StoredProcedure [dbo].[spMusicianMoreThanOneArtist]    Script Date: 2021-08-07 6:09:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spMusicianMoreThanOneArtist] @ParticularArtist varchar(30)
AS 
BEGIN

	SELECT MuSin.msin, Musician.lastname,  Plays.artistname  
	FROM
	(SELECT O.msin FROM
	(SELECT M.msin, count(A.artistname) AS CountArtist
	FROM Artist A, Musician M, Plays P
	WHERE A.artistname = P.artistname AND P.msin = M.msin 
	GROUP BY M.msin) O
	WHERE O.CountArtist > = 2
	EXCEPT
	(SELECT M.msin
	FROM Artist A, Musician M, Plays P
	WHERE A.artistname = P.artistname AND P.msin = M.msin AND P.artistname = @ParticularArtist)) MuSin, Musician, Plays
	WHERE MuSin.msin = Plays.msin AND Plays.msin = Musician.msin 
	ORDER BY Plays.artistname, Musician.lastname, MuSin.msin

END
GO
/****** Object:  StoredProcedure [dbo].[spSongsWithTheInTitle]    Script Date: 2021-08-07 6:09:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spSongsWithTheInTitle] @NumSongs INT
AS 
BEGIN

	SELECT A.artistname, M.lastname, COUNT(DISTINCT(isrc)) AS NumberOfSongs
	FROM
	(SELECT P.artistname
	FROM Song S, Musician M, Plays P
	WHERE S.artistname = P.artistname AND P.msin = M.msin
	GROUP BY P.artistname, M.lastname
	HAVING COUNT(DISTINCT(isrc)) >= @NumSongs
	INTERSECT
	SELECT P.artistname
	FROM Song S, Musician M, Plays P
	WHERE S.artistname = P.artistname AND P.msin = M.msin AND S.title LIKE '%__ the %') A, Plays P, Musician M, Song S
	WHERE A.artistname = P.artistname AND P.msin = M.msin AND P.artistname = S.artistname
	GROUP BY A.artistname, M.lastname
	ORDER BY A.artistname, M.lastname, NumberOfSongs DESC
END
GO
USE [master]
GO
ALTER DATABASE [Phatt] SET  READ_WRITE 
GO

/****** Object:  Trigger [dbo].[ArtistMusician]    Script Date: 2021-08-07 6:11:28 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[ArtistMusician]
ON [dbo].[Plays]
FOR INSERT, UPDATE, DELETE
AS
BEGIN
	UPDATE Artist SET members = CountMusician 
	FROM
	(SELECT P.artistname, COUNT(P.msin) AS CountMusician 
	 FROM Plays P
	 GROUP BY P.artistname) AS A 
	 WHERE Artist.artistname = A.artistname
END
GO

ALTER TABLE [dbo].[Plays] ENABLE TRIGGER [ArtistMusician]
GO

/****** Object:  Trigger [dbo].[TriggerSumShare]    Script Date: 2021-08-07 6:12:30 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[TriggerSumShare]
ON [dbo].[Plays]
FOR INSERT, UPDATE, DELETE
AS
IF EXISTS
(SELECT * FROM  (SELECT artistname, SUM(share) AS SumOfShare FROM Plays GROUP BY artistname)A
WHERE A.SumOfShare <> 1)
BEGIN
	RAISERROR('Error: total share is not correct (does not sum to 1)', 16,1) 
END
GO

ALTER TABLE [dbo].[Plays] ENABLE TRIGGER [TriggerSumShare]
GO
