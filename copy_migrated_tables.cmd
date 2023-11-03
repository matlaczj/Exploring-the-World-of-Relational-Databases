REM Workbench Table Data copy script
REM Workbench Version: 8.0.33
REM 
REM Execute this to copy table data from a source RDBMS to MySQL.
REM Edit the options below to customize it. You will need to provide passwords, at least.
REM 
REM Source DB: Mssql@wynajem_db_tsql_ODBC (Microsoft SQL Server)
REM Target DB: Mysql@localhost:3306


@ECHO OFF
REM Source and target DB passwords
set arg_source_password=
set arg_target_password=
set arg_source_ssh_password=
set arg_target_ssh_password=


REM Set the location for wbcopytables.exe in this variable
set "wbcopytables_path=C:\Program Files\MySQL\MySQL Workbench 8.0"

if not [%wbcopytables_path%] == [] set wbcopytables_path=%wbcopytables_path%
set wbcopytables=%wbcopytables_path%\wbcopytables.exe

if not exist "%wbcopytables%" (
	echo "wbcopytables.exe doesn't exist in the supplied path. Please set 'wbcopytables_path' with the proper path(e.g. to Workbench binaries)"
	exit 1
)

IF [%arg_source_password%] == [] (
    IF [%arg_target_password%] == [] (
        IF [%arg_source_ssh_password%] == [] (
            IF [%arg_target_ssh_password%] == [] (
                ECHO WARNING: All source and target passwords are empty. You should edit this file to set them.
            )
        )
    )
)
set arg_worker_count=2
REM Uncomment the following options according to your needs

REM Whether target tables should be truncated before copy
REM set arg_truncate_target=--truncate-target
REM Enable debugging output
REM set arg_debug_output=--log-level=debug3


REM Creation of file with table definitions for copytable

set table_file=%TMP%\wb_tables_to_migrate.txt
TYPE NUL > %TMP%\wb_tables_to_migrate.txt
ECHO [wynajem_db]	[dbo].[konto]	`wynajem_db`	`konto`	-	-	CAST([login] as NVARCHAR(20)) as [login], CAST([email] as NVARCHAR(50)) as [email], CAST([haslo] as NVARCHAR(20)) as [haslo], CAST([dane_bankowe] as NVARCHAR(26)) as [dane_bankowe], [srodki] >> %TMP%\wb_tables_to_migrate.txt
ECHO [wynajem_db]	[dbo].[wynajem]	`wynajem_db`	`wynajem`	-	-	[id], [status], [kwota], [czas_trwania], [data], CAST([login] as NVARCHAR(20)) as [login], [bot] >> %TMP%\wb_tables_to_migrate.txt
ECHO [wynajem_db]	[dbo].[bot]	`wynajem_db`	`bot`	-	-	[id], [ranga], CAST([param] as NVARCHAR(255)) as [param], CAST([cechy] as NVARCHAR(255)) as [cechy], CAST([nazwa_gry] as NVARCHAR(20)) as [nazwa_gry], [mecz] >> %TMP%\wb_tables_to_migrate.txt
ECHO [wynajem_db]	[dbo].[srodowisko]	`wynajem_db`	`srodowisko`	-	-	CAST([nazwa_gry] as NVARCHAR(20)) as [nazwa_gry], [ilosc_botow] >> %TMP%\wb_tables_to_migrate.txt
ECHO [wynajem_db]	[dbo].[mecz]	`wynajem_db`	`mecz`	-	-	[id], [wygrany_1], [wygrany_2], [wynik], [status], CAST([nazwa_gry] as NVARCHAR(20)) as [nazwa_gry] >> %TMP%\wb_tables_to_migrate.txt
ECHO [wynajem_db]	[dbo].[przedmiot]	`wynajem_db`	`przedmiot`	-	-	[id], CAST([nazwa_os] as NVARCHAR(20)) as [nazwa_os], CAST([nazwa_przedmiotu] as NVARCHAR(20)) as [nazwa_przedmiotu], [jakosc] >> %TMP%\wb_tables_to_migrate.txt
ECHO [wynajem_db]	[dbo].[osiagniecie]	`wynajem_db`	`osiagniecie`	-	-	[id], [przedmiot], [czas_os], CAST([login] as NVARCHAR(20)) as [login], [bot] >> %TMP%\wb_tables_to_migrate.txt
ECHO [wynajem_db]	[dbo].[doladowanie]	`wynajem_db`	`doladowanie`	-	-	[id], [kwota], [data], CAST([login] as NVARCHAR(20)) as [login] >> %TMP%\wb_tables_to_migrate.txt
ECHO [wynajem_db]	[dbo].[recenzja]	`wynajem_db`	`recenzja`	-	-	[id], [ocena], CAST([komentarz] as NVARCHAR(100)) as [komentarz], [data], CAST([login] as NVARCHAR(20)) as [login], [bot] >> %TMP%\wb_tables_to_migrate.txt
ECHO [wynajem_db]	[dbo].[wiadomosc]	`wynajem_db`	`wiadomosc`	-	-	[id], CAST([nadawca] as NVARCHAR(20)) as [nadawca], CAST([odbiorca] as NVARCHAR(20)) as [odbiorca], CAST([tresc] as NVARCHAR(100)) as [tresc], [data], [status] >> %TMP%\wb_tables_to_migrate.txt


"%wbcopytables%" ^
 --odbc-source="DSN=wynajem_db_tsql_ODBC;DATABASE=;UID=sa" ^
 --source-rdbms-type=Mssql ^
 --target="root@localhost:3306" ^
 --source-password="%arg_source_password%" ^
 --target-password="%arg_target_password%" ^
 --table-file="%table_file%" ^
 --target-ssh-port="22" ^
 --target-ssh-host="" ^
 --target-ssh-user="" ^
 --source-ssh-password="%arg_source_ssh_password%" ^
 --target-ssh-password="%arg_target_ssh_password%" --thread-count=%arg_worker_count% ^
 %arg_truncate_target% ^
 %arg_debug_output%

REM Removes the file with the table definitions
DEL %TMP%\wb_tables_to_migrate.txt


