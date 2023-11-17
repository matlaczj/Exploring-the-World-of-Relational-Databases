USE wynajem_db;
GO

DROP INDEX IX_konto_email ON konto;
GO

DROP INDEX IX_doladowanie_login_data ON doladowanie;
GO

DROP INDEX IX_wynajem_login_data ON wynajem;
GO

DROP INDEX IX_bot_nazwa_gry ON bot;
GO

DROP INDEX IX_mecz_nazwa_gry_status ON mecz;
GO
