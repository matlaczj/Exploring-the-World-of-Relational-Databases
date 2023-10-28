CREATE LOGIN AdminUser WITH PASSWORD = 'AdminPassword';
CREATE LOGIN BotUser WITH PASSWORD = 'BotPassword';
CREATE LOGIN RegularUser WITH PASSWORD = 'RegularPassword';
GO

USE wynajem_db;
GO

CREATE USER AdminUser FOR LOGIN AdminUser;
CREATE USER BotUser FOR LOGIN BotUser;
CREATE USER RegularUser FOR LOGIN RegularUser;
GO

-- Assign admin privileges to the AdminUser
ALTER ROLE db_owner ADD MEMBER AdminUser;
GO

CREATE ROLE RestrictedExecutorBotUser;
GRANT EXECUTE ON [dbo].[CreateBot] TO RestrictedExecutorBotUser;
ALTER ROLE RestrictedExecutorBotUser ADD MEMBER BotUser; 
GO

CREATE ROLE RestrictedExecutorRegularUser;
GRANT EXECUTE ON [dbo].[RentBot] TO RestrictedExecutorRegularUser;
GRANT EXECUTE ON [dbo].[SendMessage] TO RestrictedExecutorRegularUser;
GRANT EXECUTE ON [dbo].[ViewTransactionHistory] TO RestrictedExecutorRegularUser;
ALTER ROLE RestrictedExecutorRegularUser ADD MEMBER RegularUser; 
GO