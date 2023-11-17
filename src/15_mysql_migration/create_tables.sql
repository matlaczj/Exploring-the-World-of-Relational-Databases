CREATE DATABASE wynajem_db;

USE wynajem_db;

CREATE TABLE konto (
  login varchar(20) PRIMARY KEY,
  email varchar(50) NOT NULL,
  haslo varchar(20) NOT NULL,
  dane_bankowe varchar(26) NOT NULL,
  srodki int DEFAULT 0 NOT NULL
);

CREATE TABLE wynajem (
  id int PRIMARY KEY AUTO_INCREMENT,
  status bit DEFAULT 0 NOT NULL,
  kwota int NOT NULL,
  czas_trwania int NOT NULL,
  data datetime NOT NULL,
  login varchar(20) NOT NULL,
  bot int NOT NULL
);

CREATE TABLE bot (
  id int PRIMARY KEY AUTO_INCREMENT,
  ranga int DEFAULT 0 NOT NULL,
  param varchar(255) NOT NULL,
  cechy varchar(255) NOT NULL,
  nazwa_gry varchar(20) NOT NULL,
  mecz int
);

CREATE TABLE srodowisko (
  nazwa_gry varchar(20) PRIMARY KEY,
  ilosc_botow int DEFAULT 0 NOT NULL
);

CREATE TABLE mecz (
  id int PRIMARY KEY AUTO_INCREMENT,
  wygrany_1 int NOT NULL,
  wygrany_2 int NOT NULL,
  wynik int NOT NULL,
  status bit DEFAULT 0 NOT NULL,
  nazwa_gry varchar(20) NOT NULL
);

CREATE TABLE przedmiot (
  id int PRIMARY KEY AUTO_INCREMENT,
  nazwa_os varchar(20) NOT NULL,
  nazwa_przedmiotu varchar(20) NOT NULL,
  jakosc int DEFAULT 0 NOT NULL
);

CREATE TABLE osiagniecie (
  id int PRIMARY KEY AUTO_INCREMENT,
  przedmiot int NOT NULL,
  czas_os datetime NOT NULL,
  login varchar(20) NOT NULL,
  bot int NOT NULL
);

CREATE TABLE doladowanie (
  id int PRIMARY KEY AUTO_INCREMENT,
  kwota int NOT NULL,
  data datetime NOT NULL,
  login varchar(20) NOT NULL
);

CREATE TABLE recenzja (
  id int PRIMARY KEY AUTO_INCREMENT,
  ocena int DEFAULT 0 NOT NULL,
  komentarz varchar(100),
  data datetime NOT NULL,
  login varchar(20) NOT NULL,
  bot int NOT NULL
);

CREATE TABLE wiadomosc (
  id int PRIMARY KEY AUTO_INCREMENT,
  nadawca varchar(20) NOT NULL,
  odbiorca varchar(20) NOT NULL,
  tresc varchar(100) NOT NULL,
  data datetime NOT NULL,
  status bit DEFAULT 0 NOT NULL
);
