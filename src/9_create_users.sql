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