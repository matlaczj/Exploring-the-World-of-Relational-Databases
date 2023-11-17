USE wynajem_db
GO

CREATE VIEW AdminDashboard
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



