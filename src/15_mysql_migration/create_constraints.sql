-- Constraints for table 'wynajem'
ALTER TABLE wynajem ADD CONSTRAINT FK_Wynajem_Konto_Login 
FOREIGN KEY (login) REFERENCES konto (login);

ALTER TABLE wynajem ADD CONSTRAINT FK_Wynajem_Bot_ID 
FOREIGN KEY (bot) REFERENCES bot (id);

-- Constraints for table 'bot'
ALTER TABLE bot ADD CONSTRAINT FK_Bot_Srodowisko_Nazwa_Gry 
FOREIGN KEY (nazwa_gry) REFERENCES srodowisko (nazwa_gry);

ALTER TABLE bot ADD CONSTRAINT FK_Bot_Mecz_ID 
FOREIGN KEY (mecz) REFERENCES mecz (id);

-- Constraints for table 'mecz'
ALTER TABLE mecz ADD CONSTRAINT FK_Mecz_Bot1_ID 
FOREIGN KEY (wygrany_1) REFERENCES bot (id);

ALTER TABLE mecz ADD CONSTRAINT FK_Mecz_Bot2_ID 
FOREIGN KEY (wygrany_2) REFERENCES bot (id);

ALTER TABLE mecz ADD CONSTRAINT FK_Mecz_Srodowisko_Nazwa_Gry 
FOREIGN KEY (nazwa_gry) REFERENCES srodowisko (nazwa_gry);

-- Constraints for table 'osiagniecie'
ALTER TABLE osiagniecie ADD CONSTRAINT FK_Osiagniecie_Konto_Login 
FOREIGN KEY (login) REFERENCES konto (login);

ALTER TABLE osiagniecie ADD CONSTRAINT FK_Osiagniecie_Bot_ID 
FOREIGN KEY (bot) REFERENCES bot (id);

ALTER TABLE osiagniecie ADD CONSTRAINT FK_Osiagniecie_Przedmiot_ID 
FOREIGN KEY (przedmiot) REFERENCES przedmiot (id);

-- Constraints for table 'doladowanie'
ALTER TABLE doladowanie ADD CONSTRAINT FK_Doladowanie_Konto_Login 
FOREIGN KEY (login) REFERENCES konto (login);

-- Constraints for table 'recenzja'
ALTER TABLE recenzja ADD CONSTRAINT FK_Recenzja_Konto_Login 
FOREIGN KEY (login) REFERENCES konto (login);

ALTER TABLE recenzja ADD CONSTRAINT FK_Recenzja_Bot_ID 
FOREIGN KEY (bot) REFERENCES bot (id);

-- Constraints for table 'wiadomosc'
ALTER TABLE wiadomosc ADD CONSTRAINT FK_Wiadomosc_Nadawca 
FOREIGN KEY (nadawca) REFERENCES konto (login);

ALTER TABLE wiadomosc ADD CONSTRAINT FK_Wiadomosc_Odbiorca 
FOREIGN KEY (odbiorca) REFERENCES konto (login);
