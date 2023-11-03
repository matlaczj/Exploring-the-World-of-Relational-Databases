CREATE INDEX IX_konto_email ON konto(email);
CREATE INDEX IX_doladowanie_login_data ON doladowanie(login, data);
CREATE INDEX IX_wynajem_login_data ON wynajem(login, data);
CREATE INDEX IX_bot_nazwa_gry ON bot(nazwa_gry);
CREATE INDEX IX_mecz_nazwa_gry_status ON mecz(nazwa_gry, status);