USE wynajem_db;
GO

CREATE NONCLUSTERED INDEX IX_konto_email ON konto(email);
GO

CREATE NONCLUSTERED INDEX IX_doladowanie_login_data ON doladowanie(login, data);
GO

CREATE NONCLUSTERED INDEX IX_wynajem_login_data ON wynajem(login, data);
GO

CREATE NONCLUSTERED INDEX IX_bot_nazwa_gry ON bot(nazwa_gry);
GO

CREATE NONCLUSTERED INDEX IX_mecz_nazwa_gry_status ON mecz(nazwa_gry, status);
GO