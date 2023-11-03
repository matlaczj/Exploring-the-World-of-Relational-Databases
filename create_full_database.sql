CREATE DATABASE [wynajem_db_from_script]
GO
USE [wynajem_db_from_script]
GO
CREATE USER [AdminUser] FOR LOGIN [AdminUser] WITH DEFAULT_SCHEMA=[dbo]
GO
CREATE USER [BotUser] FOR LOGIN [BotUser] WITH DEFAULT_SCHEMA=[dbo]
GO
CREATE USER [RegularUser] FOR LOGIN [RegularUser] WITH DEFAULT_SCHEMA=[dbo]
GO
CREATE ROLE [RestrictedExecutorBotUser]
GO
CREATE ROLE [RestrictedExecutorRegularUser]
GO
ALTER ROLE [db_owner] ADD MEMBER [AdminUser]
GO
ALTER ROLE [RestrictedExecutorBotUser] ADD MEMBER [BotUser]
GO
ALTER ROLE [RestrictedExecutorRegularUser] ADD MEMBER [RegularUser]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[CalculateTotalExpenditure] (@login varchar(20))
RETURNS INT
AS
BEGIN
    DECLARE @totalExpenditure INT;
    SELECT @totalExpenditure = SUM(kwota)
    FROM wynajem
    WHERE [status] = 1 AND login = @login;
    RETURN @totalExpenditure;
END;
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[konto]
(
    [login] [varchar](20) NOT NULL,
    [email] [varchar](50) NOT NULL,
    [haslo] [varchar](20) NOT NULL,
    [dane_bankowe] [varchar](26) NOT NULL,
    [srodki] [int] NOT NULL,
    PRIMARY KEY CLUSTERED 
(
	[login] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[wynajem]
(
    [id] [int] IDENTITY(0,1) NOT NULL,
    [status] [bit] NOT NULL,
    [kwota] [int] NOT NULL,
    [czas_trwania] [int] NOT NULL,
    [data] [datetime] NOT NULL,
    [login] [varchar](20) NOT NULL,
    [bot] [int] NOT NULL,
    PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bot]
(
    [id] [int] IDENTITY(0,1) NOT NULL,
    [ranga] [int] NOT NULL,
    [param] [varchar](255) NOT NULL,
    [cechy] [varchar](255) NOT NULL,
    [nazwa_gry] [varchar](20) NOT NULL,
    [mecz] [int] NULL,
    PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[srodowisko]
(
    [nazwa_gry] [varchar](20) NOT NULL,
    [ilosc_botow] [int] NOT NULL,
    PRIMARY KEY CLUSTERED 
(
	[nazwa_gry] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[mecz]
(
    [id] [int] IDENTITY(0,1) NOT NULL,
    [wygrany_1] [int] NOT NULL,
    [wygrany_2] [int] NOT NULL,
    [wynik] [int] NOT NULL,
    [status] [bit] NOT NULL,
    [nazwa_gry] [varchar](20) NOT NULL,
    PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[osiagniecie]
(
    [id] [int] IDENTITY(0,1) NOT NULL,
    [przedmiot] [int] NOT NULL,
    [czas_os] [datetime] NOT NULL,
    [login] [varchar](20) NOT NULL,
    [bot] [int] NOT NULL,
    PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[wiadomosc]
(
    [id] [int] IDENTITY(0,1) NOT NULL,
    [nadawca] [varchar](20) NOT NULL,
    [odbiorca] [varchar](20) NOT NULL,
    [tresc] [varchar](100) NOT NULL,
    [data] [datetime] NOT NULL,
    [status] [bit] NOT NULL,
    PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[AdminDashboard]
AS
    SELECT
        A.login AS AccountLogin,
        A.email AS AccountEmail,
        R.id AS RentalID,
        R.status AS RentalStatus,
        R.kwota AS RentalAmount,
        R.czas_trwania AS RentalDuration,
        R.data AS RentalDate,
        B.id AS BotID,
        B.nazwa_gry AS GameName,
        B.ranga AS BotRank,
        V.ilosc_botow AS EnvironmentBotCount,
        M.id AS MatchID,
        M.wygrany_1 AS Winner1,
        M.wygrany_2 AS Winner2,
        M.wynik AS MatchResult,
        M.status AS MatchStatus,
        WI.id AS MessageID,
        WI.nadawca AS Sender,
        WI.odbiorca AS Receiver,
        WI.tresc AS MessageContent,
        WI.data AS MessageDate,
        WI.status AS MessageStatus
    FROM
        konto A
        LEFT JOIN
        wynajem R ON A.login = R.login
        LEFT JOIN
        bot B ON R.bot = B.id
        LEFT JOIN
        srodowisko V ON B.nazwa_gry = V.nazwa_gry
        LEFT JOIN
        mecz M ON B.id = M.wygrany_1 OR B.id = M.wygrany_2
        LEFT JOIN
        osiagniecie AC ON A.login = AC.login
        LEFT JOIN
        wiadomosc WI ON A.login = WI.nadawca OR A.login = WI.odbiorca;
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[BotDashboard]
AS
    SELECT
        M.id AS MatchID,
        M.wygrany_1 AS Winner1,
        M.wygrany_2 AS Winner2,
        CASE
        WHEN (M.wygrany_1 = B.id AND M.wynik = 1) OR (M.wygrany_2 = B.id AND M.wynik = 2) THEN 'Win'
        WHEN (M.wygrany_1 = B.id OR M.wygrany_2 = B.id) AND M.wynik = 0 THEN 'Draw'
        ELSE 'Loss'
    END AS MatchOutcome,
        AC.czas_os AS AchievementTime,
        AC.id AS AchievementID
    FROM
        mecz M
        LEFT JOIN
        osiagniecie AC ON (M.wygrany_1 = AC.bot OR M.wygrany_2 = AC.bot)
        LEFT JOIN
        konto A ON A.login = AC.login
        JOIN
        bot B ON B.id = AC.bot;
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[UserDashboard]
AS
    SELECT
        R.id AS RentalID,
        R.status AS RentalStatus,
        R.kwota AS RentalAmount,
        R.czas_trwania AS RentalDuration,
        R.data AS RentalDate,
        B.id AS BotID,
        B.nazwa_gry AS GameName,
        B.ranga AS BotRank,
        V.ilosc_botow AS EnvironmentBotCount,
        AC.id AS AchievementID,
        AC.czas_os AS AchievementTime,
        AC.przedmiot AS AchievementItemID,
        WI.id AS MessageID,
        WI.nadawca AS Sender,
        WI.tresc AS MessageContent,
        WI.data AS MessageDate,
        WI.status AS MessageStatus
    FROM
        wynajem R
        JOIN
        bot B ON R.bot = B.id
        JOIN
        srodowisko V ON B.nazwa_gry = V.nazwa_gry
        LEFT JOIN
        osiagniecie AC ON R.login = AC.login AND B.id = AC.bot
        LEFT JOIN
        wiadomosc WI ON R.login = WI.nadawca OR R.login = WI.odbiorca;
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[doladowanie]
(
    [id] [int] IDENTITY(0,1) NOT NULL,
    [kwota] [int] NOT NULL,
    [data] [datetime] NOT NULL,
    [login] [varchar](20) NOT NULL,
    PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[przedmiot]
(
    [id] [int] IDENTITY(0,1) NOT NULL,
    [nazwa_os] [varchar](20) NOT NULL,
    [nazwa_przedmiotu] [varchar](20) NOT NULL,
    [jakosc] [int] NOT NULL,
    PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[recenzja]
(
    [id] [int] IDENTITY(0,1) NOT NULL,
    [ocena] [int] NOT NULL,
    [komentarz] [varchar](100) NULL,
    [data] [datetime] NOT NULL,
    [login] [varchar](20) NOT NULL,
    [bot] [int] NOT NULL,
    PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[bot] ADD  DEFAULT ((0)) FOR [ranga]
GO
ALTER TABLE [dbo].[konto] ADD  DEFAULT ((0)) FOR [srodki]
GO
ALTER TABLE [dbo].[mecz] ADD  DEFAULT ((0)) FOR [status]
GO
ALTER TABLE [dbo].[przedmiot] ADD  DEFAULT ((0)) FOR [jakosc]
GO
ALTER TABLE [dbo].[recenzja] ADD  DEFAULT ((0)) FOR [ocena]
GO
ALTER TABLE [dbo].[srodowisko] ADD  DEFAULT ((0)) FOR [ilosc_botow]
GO
ALTER TABLE [dbo].[wiadomosc] ADD  DEFAULT ((0)) FOR [status]
GO
ALTER TABLE [dbo].[wynajem] ADD  DEFAULT ((0)) FOR [status]
GO
ALTER TABLE [dbo].[bot]  WITH CHECK ADD  CONSTRAINT [FK__Bot_Mecz_ID] FOREIGN KEY([mecz])
REFERENCES [dbo].[mecz] ([id])
GO
ALTER TABLE [dbo].[bot] CHECK CONSTRAINT [FK__Bot_Mecz_ID]
GO
ALTER TABLE [dbo].[bot]  WITH CHECK ADD  CONSTRAINT [FK__Bot_Srodowisko_Nazwa_Gry] FOREIGN KEY([nazwa_gry])
REFERENCES [dbo].[srodowisko] ([nazwa_gry])
GO
ALTER TABLE [dbo].[bot] CHECK CONSTRAINT [FK__Bot_Srodowisko_Nazwa_Gry]
GO
ALTER TABLE [dbo].[doladowanie]  WITH CHECK ADD  CONSTRAINT [FK__Doladowanie_Konto_Login] FOREIGN KEY([login])
REFERENCES [dbo].[konto] ([login])
GO
ALTER TABLE [dbo].[doladowanie] CHECK CONSTRAINT [FK__Doladowanie_Konto_Login]
GO
ALTER TABLE [dbo].[mecz]  WITH CHECK ADD  CONSTRAINT [FK__Mecz_Bot1_ID] FOREIGN KEY([wygrany_1])
REFERENCES [dbo].[bot] ([id])
GO
ALTER TABLE [dbo].[mecz] CHECK CONSTRAINT [FK__Mecz_Bot1_ID]
GO
ALTER TABLE [dbo].[mecz]  WITH CHECK ADD  CONSTRAINT [FK__Mecz_Bot2_ID] FOREIGN KEY([wygrany_2])
REFERENCES [dbo].[bot] ([id])
GO
ALTER TABLE [dbo].[mecz] CHECK CONSTRAINT [FK__Mecz_Bot2_ID]
GO
ALTER TABLE [dbo].[mecz]  WITH CHECK ADD  CONSTRAINT [FK__Mecz_Srodowisko_Nazwa_Gry] FOREIGN KEY([nazwa_gry])
REFERENCES [dbo].[srodowisko] ([nazwa_gry])
GO
ALTER TABLE [dbo].[mecz] CHECK CONSTRAINT [FK__Mecz_Srodowisko_Nazwa_Gry]
GO
ALTER TABLE [dbo].[osiagniecie]  WITH CHECK ADD  CONSTRAINT [FK__Osiagniecie_Bot_ID] FOREIGN KEY([bot])
REFERENCES [dbo].[bot] ([id])
GO
ALTER TABLE [dbo].[osiagniecie] CHECK CONSTRAINT [FK__Osiagniecie_Bot_ID]
GO
ALTER TABLE [dbo].[osiagniecie]  WITH CHECK ADD  CONSTRAINT [FK__Osiagniecie_Konto_Login] FOREIGN KEY([login])
REFERENCES [dbo].[konto] ([login])
GO
ALTER TABLE [dbo].[osiagniecie] CHECK CONSTRAINT [FK__Osiagniecie_Konto_Login]
GO
ALTER TABLE [dbo].[osiagniecie]  WITH CHECK ADD  CONSTRAINT [FK__Osiagniecie_Przedmiot_ID] FOREIGN KEY([przedmiot])
REFERENCES [dbo].[przedmiot] ([id])
GO
ALTER TABLE [dbo].[osiagniecie] CHECK CONSTRAINT [FK__Osiagniecie_Przedmiot_ID]
GO
ALTER TABLE [dbo].[recenzja]  WITH CHECK ADD  CONSTRAINT [FK__Recenzja_Bot_ID] FOREIGN KEY([bot])
REFERENCES [dbo].[bot] ([id])
GO
ALTER TABLE [dbo].[recenzja] CHECK CONSTRAINT [FK__Recenzja_Bot_ID]
GO
ALTER TABLE [dbo].[recenzja]  WITH CHECK ADD  CONSTRAINT [FK__Recenzja_Konto_Login] FOREIGN KEY([login])
REFERENCES [dbo].[konto] ([login])
GO
ALTER TABLE [dbo].[recenzja] CHECK CONSTRAINT [FK__Recenzja_Konto_Login]
GO
ALTER TABLE [dbo].[wiadomosc]  WITH CHECK ADD  CONSTRAINT [FK__Wiadomosc_Nadawca] FOREIGN KEY([nadawca])
REFERENCES [dbo].[konto] ([login])
GO
ALTER TABLE [dbo].[wiadomosc] CHECK CONSTRAINT [FK__Wiadomosc_Nadawca]
GO
ALTER TABLE [dbo].[wiadomosc]  WITH CHECK ADD  CONSTRAINT [FK__Wiadomosc_Odbiorca] FOREIGN KEY([odbiorca])
REFERENCES [dbo].[konto] ([login])
GO
ALTER TABLE [dbo].[wiadomosc] CHECK CONSTRAINT [FK__Wiadomosc_Odbiorca]
GO
ALTER TABLE [dbo].[wynajem]  WITH CHECK ADD  CONSTRAINT [FK__Wynajem_Bot_ID] FOREIGN KEY([bot])
REFERENCES [dbo].[bot] ([id])
GO
ALTER TABLE [dbo].[wynajem] CHECK CONSTRAINT [FK__Wynajem_Bot_ID]
GO
ALTER TABLE [dbo].[wynajem]  WITH CHECK ADD  CONSTRAINT [FK__Wynajem_Konto_Login] FOREIGN KEY([login])
REFERENCES [dbo].[konto] ([login])
GO
ALTER TABLE [dbo].[wynajem] CHECK CONSTRAINT [FK__Wynajem_Konto_Login]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CreateBot]
    @ranga integer,
    @param varchar(255),
    @cechy varchar(255),
    @nazwa_gry varchar(20),
    @ilosc_botow integer,
    @login varchar(20),
    @wygrany_1 integer,
    @wygrany_2 integer
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @botID integer;
    DECLARE @meczID integer;
    BEGIN TRY
                BEGIN TRANSACTION;
                INSERT INTO bot
        (ranga, param, cechy, nazwa_gry, mecz)
    VALUES
        (@ranga, @param, @cechy, @nazwa_gry, NULL);
                SET @botID = SCOPE_IDENTITY();
                SELECT @meczID = id
    FROM mecz
    WHERE nazwa_gry = @nazwa_gry AND status = 0;
        BEGIN
        INSERT INTO mecz
            (wygrany_1, wygrany_2, wynik, status, nazwa_gry)
        VALUES
            (@wygrany_1, @wygrany_2, 0, 0, @nazwa_gry);
        SET @meczID = SCOPE_IDENTITY();
    END
                UPDATE bot
        SET mecz = @meczID
        WHERE id = @botID;
                UPDATE srodowisko
        SET ilosc_botow = @ilosc_botow + 1
        WHERE nazwa_gry = @nazwa_gry;
                COMMIT;
    END TRY
    BEGIN CATCH
                ROLLBACK;
                THROW;
    END CATCH;
END;
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CreateNewUserAccount]
    @login varchar(20),
    @email varchar(50),
    @password varchar(20),
    @dane_bankowe varchar(26)
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (SELECT 1
    FROM konto
    WHERE login = @login)
    BEGIN
        DECLARE @hashedPassword nvarchar(64)
        SET @hashedPassword = HASHBYTES('SHA2_256', @password);
        INSERT INTO konto
            (login, email, haslo, dane_bankowe, srodki)
        VALUES
            (@login, @email, @hashedPassword, @dane_bankowe, 0);
        SELECT 1 AS 'Status', 'User account created successfully.' AS 'Message';
    END
    ELSE
    BEGIN
        SELECT 0 AS 'Status', 'User account creation failed. Login already exists.' AS 'Message';
    END
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DodajBota]
    @ranga integer,
    @param varchar(255),
    @cechy varchar(255),
    @nazwa_gry varchar(20),
    @mecz integer
AS
BEGIN
    INSERT INTO bot
        (ranga, param, cechy, nazwa_gry, mecz)
    VALUES
        (@ranga, @param, @cechy, @nazwa_gry, @mecz)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DodajDoladowanie]
    @kwota integer,
    @data datetime,
    @login varchar(20)
AS
BEGIN
    INSERT INTO doladowanie
        (kwota, data, login)
    VALUES
        (@kwota, @data, @login)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DodajKonto]
    @login varchar(20),
    @email varchar(50),
    @haslo varchar(20),
    @dane_bankowe varchar(26),
    @srodki integer
AS
BEGIN
    INSERT INTO konto
        (login, email, haslo, dane_bankowe, srodki)
    VALUES
        (@login, @email, @haslo, @dane_bankowe, @srodki)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DodajMecz]
    @wygrany_1 integer,
    @wygrany_2 integer,
    @wynik integer,
    @status bit,
    @nazwa_gry varchar(20)
AS
BEGIN
    INSERT INTO mecz
        (wygrany_1, wygrany_2, wynik, status, nazwa_gry)
    VALUES
        (@wygrany_1, @wygrany_2, @wynik, @status, @nazwa_gry)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DodajOsiagniecie]
    @przedmiot integer,
    @czas_os datetime,
    @login varchar(20),
    @bot integer
AS
BEGIN
    INSERT INTO osiagniecie
        (przedmiot, czas_os, login, bot)
    VALUES
        (@przedmiot, @czas_os, @login, @bot)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DodajPrzedmiot]
    @nazwa_os varchar(20),
    @nazwa_przedmiotu varchar(20),
    @jakosc integer
AS
BEGIN
    INSERT INTO przedmiot
        (nazwa_os, nazwa_przedmiotu, jakosc)
    VALUES
        (@nazwa_os, @nazwa_przedmiotu, @jakosc)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DodajRecenzje]
    @ocena integer,
    @komentarz varchar(100),
    @data datetime,
    @login varchar(20),
    @bot integer
AS
BEGIN
    INSERT INTO recenzja
        (ocena, komentarz, data, login, bot)
    VALUES
        (@ocena, @komentarz, @data, @login, @bot)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DodajSrodowisko]
    @nazwa_gry varchar(20),
    @ilosc_botow integer
AS
BEGIN
    INSERT INTO srodowisko
        (nazwa_gry, ilosc_botow)
    VALUES
        (@nazwa_gry, @ilosc_botow)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DodajWiadomosc]
    @nadawca varchar(20),
    @odbiorca varchar(20),
    @tresc varchar(100),
    @data datetime,
    @status bit
AS
BEGIN
    INSERT INTO wiadomosc
        (nadawca, odbiorca, tresc, data, status)
    VALUES
        (@nadawca, @odbiorca, @tresc, @data, @status)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DodajWynajem]
    @status bit,
    @kwota integer,
    @czas_trwania integer,
    @data datetime,
    @login varchar(20),
    @bot integer
AS
BEGIN
    INSERT INTO wynajem
        (status, kwota, czas_trwania, data, login, bot)
    VALUES
        (@status, @kwota, @czas_trwania, @data, @login, @bot)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[RentBot]
    @login varchar(20),
    @botID integer,
    @rentalDuration integer
AS
BEGIN
    DECLARE @botRentalFee integer = 10 * @rentalDuration
    IF (SELECT [srodki]
    FROM [konto]
    WHERE [login] = @login) >= @botRentalFee
    BEGIN
        UPDATE [konto] SET [srodki] = [srodki] - @botRentalFee WHERE [login] = @login
        INSERT INTO [wynajem]
            ([status], [kwota], [czas_trwania], [data], [login], [bot])
        VALUES
            (1, @botRentalFee, @rentalDuration, GETDATE(), @login, @botID)
        SELECT 'Bot rented successfully' AS [Status]
    END
    ELSE
    BEGIN
        SELECT 'Insufficient funds' AS [Status]
    END
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SendMessage]
    @sender varchar(20),
    @recipient varchar(20),
    @messageText varchar(100)
AS
BEGIN
    INSERT INTO [wiadomosc]
        ([nadawca], [odbiorca], [tresc], [data], [status])
    VALUES
        (@sender, @recipient, @messageText, GETDATE(), 0)
    SELECT 'Message sent successfully' AS [Status]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UsunSlabeBoty]
AS
BEGIN
    DECLARE @MinimalnaOcena INT;
    SET @MinimalnaOcena = 2;
    DELETE FROM bot
    WHERE id IN (SELECT bot.id
    FROM bot
        LEFT JOIN recenzja ON bot.id = recenzja.bot
    GROUP BY bot.id
    HAVING AVG(ISNULL(recenzja.ocena, 0)) < @MinimalnaOcena);
END;
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ViewTransactionHistory]
    @login varchar(20)
AS
BEGIN
            SELECT [id], [kwota], [data], 'Doladowanie' AS [TransactionType]
        FROM [doladowanie]
        WHERE [login] = @login
    UNION ALL
        SELECT [id], [kwota], [data], 'Wynajem' AS [TransactionType]
        FROM [wynajem]
        WHERE [login] = @login
END
GO
