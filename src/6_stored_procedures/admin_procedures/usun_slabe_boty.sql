USE wynajem_db
GO

CREATE PROCEDURE UsunSlabeBoty
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