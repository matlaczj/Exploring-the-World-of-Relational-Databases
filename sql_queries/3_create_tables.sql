CREATE DATABASE wynajem_db
GO

USE wynajem_db
GO

CREATE TABLE [konto]
(
  [login] varchar(20) PRIMARY KEY,
  [email] varchar(50) NOT NULL,
  [haslo] varchar(20) NOT NULL,
  [dane_bankowe] varchar(26) NOT NULL,
  [srodki] integer DEFAULT 0 NOT NULL
)
GO

CREATE TABLE [wynajem]
(
  [id] integer PRIMARY KEY IDENTITY(0,1),
  [status] bit DEFAULT 0 NOT NULL,
  [kwota] integer NOT NULL,
  [czas_trwania] integer NOT NULL,
  [data] datetime NOT NULL,
  [login] varchar(20) NOT NULL,
  [bot] integer NOT NULL,
)
GO

CREATE TABLE [bot]
(
  [id] integer PRIMARY KEY IDENTITY(0,1),
  [ranga] integer DEFAULT 0 NOT NULL,
  [param] varchar(255) NOT NULL,
  [cechy] varchar(255) NOT NULL,
  [nazwa_gry] varchar(20) NOT NULL,
  [mecz] integer,
)
GO

CREATE TABLE [srodowisko]
(
  [nazwa_gry] varchar(20) PRIMARY KEY,
  [ilosc_botow] integer DEFAULT 0 NOT NULL
)
GO

CREATE TABLE [mecz]
(
  [id] integer PRIMARY KEY IDENTITY(0,1),
  [wygrany_1] integer NOT NULL,
  [wygrany_2] integer NOT NULL,
  [wynik] integer NOT NULL,
  [status] bit DEFAULT 0 NOT NULL,
  [nazwa_gry] varchar(20) NOT NULL,
)
GO

CREATE TABLE [przedmiot]
(
  [id] integer PRIMARY KEY IDENTITY(0,1),
  [nazwa_os] varchar(20) NOT NULL,
  [nazwa_przedmiotu] varchar(20) NOT NULL,
  [jakosc] integer DEFAULT 0 NOT NULL,
)
GO

CREATE TABLE [osiagniecie]
(
  [id] integer PRIMARY KEY IDENTITY(0,1),
  [przedmiot] integer NOT NULL,
  [czas_os] datetime NOT NULL,
  [login] varchar(20) NOT NULL,
  [bot] integer NOT NULL,
)
GO

CREATE TABLE [doladowanie]
(
  [id] integer PRIMARY KEY IDENTITY(0,1),
  [kwota] integer NOT NULL,
  [data] datetime NOT NULL,
  [login] varchar(20) NOT NULL,
)
GO

CREATE TABLE [recenzja]
(
  [id] integer PRIMARY KEY IDENTITY(0,1),
  [ocena] integer DEFAULT 0 NOT NULL,
  [komentarz] varchar(100),
  [data] datetime NOT NULL,
  [login] varchar(20) NOT NULL,
  [bot] integer NOT NULL,
)
GO

CREATE TABLE [wiadomosc]
(
  [id] integer PRIMARY KEY IDENTITY(0,1),
  [nadawca] varchar(20) NOT NULL,
  [odbiorca] varchar(20) NOT NULL,
  [tresc] varchar(100) NOT NULL,
  [data] datetime NOT NULL,
  [status] bit DEFAULT 0 NOT NULL,
)
GO