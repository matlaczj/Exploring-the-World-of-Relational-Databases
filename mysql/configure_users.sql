CREATE USER 'AdminUser'@'localhost' IDENTIFIED BY 'AdminPassword';
CREATE USER 'BotUser'@'localhost' IDENTIFIED BY 'BotPassword';
CREATE USER 'RegularUser'@'localhost' IDENTIFIED BY 'RegularPassword';

GRANT ALL PRIVILEGES ON wynajem_db.* TO 'AdminUser'@'localhost';
GRANT ALL PRIVILEGES ON wynajem_db.* TO 'BotUser'@'localhost';
GRANT ALL PRIVILEGES ON wynajem_db.* TO 'RegularUser'@'localhost';

CREATE ROLE RestrictedExecutorBotUser;
CREATE ROLE RestrictedExecutorRegularUser;

GRANT EXECUTE ON PROCEDURE wynajem_db.CreateBot TO RestrictedExecutorBotUser;
GRANT SELECT ON TABLE wynajem_db.BotDashboard TO RestrictedExecutorBotUser;
GRANT EXECUTE ON PROCEDURE wynajem_db.RentBot TO RestrictedExecutorRegularUser;
GRANT EXECUTE ON PROCEDURE wynajem_db.SendMessage TO RestrictedExecutorRegularUser;
GRANT EXECUTE ON PROCEDURE wynajem_db.ViewTransactionHistory TO RestrictedExecutorRegularUser;
GRANT SELECT ON TABLE wynajem_db.UserDashboard TO RestrictedExecutorRegularUser;

GRANT RestrictedExecutorBotUser TO 'BotUser'@'localhost';
GRANT RestrictedExecutorRegularUser TO 'RegularUser'@'localhost';
