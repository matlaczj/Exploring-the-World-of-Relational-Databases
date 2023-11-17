USE wynajem_db
GO

CREATE PROCEDURE SendMessage
    @sender varchar(20),
    @recipient varchar(20),
    @messageText varchar(100)
AS
BEGIN
    -- Send a message to the recipient
    INSERT INTO [wiadomosc]
        ([nadawca], [odbiorca], [tresc], [data], [status])
    VALUES
        (@sender, @recipient, @messageText, GETDATE(), 0)

    SELECT 'Message sent successfully' AS [Status]
END
GO

-- DECLARE @sender varchar(20) = 'adventureSeeker'
-- DECLARE @recipient varchar(20) = 'fitnessFanatic'
-- DECLARE @messageText varchar(100) = 'Hello, world!'
-- EXEC SendMessage @sender, @recipient, @messageText
-- GO

-- IF EXISTS (SELECT *
-- FROM sys.objects
-- WHERE type = 'P' AND name = 'SendMessage')
-- BEGIN
--     DROP PROCEDURE SendMessage
-- END
-- GO