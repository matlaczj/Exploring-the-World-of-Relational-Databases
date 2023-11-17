USE wynajem_db
GO

CREATE VIEW BotDashboard
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