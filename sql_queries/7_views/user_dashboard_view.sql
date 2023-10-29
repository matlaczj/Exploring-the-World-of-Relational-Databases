USE wynajem_db
GO

CREATE VIEW UserDashboard
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