USE wynajem_db;
GO

-- Assign admin privileges to the AdminUser
ALTER ROLE db_owner ADD MEMBER AdminUser;
GO

CREATE ROLE RestrictedExecutorBotUser;
GRANT EXECUTE ON [dbo].[CreateBot] TO RestrictedExecutorBotUser;
GRANT SELECT ON [dbo].[BotDashboard] TO RestrictedExecutorBotUser;
ALTER ROLE RestrictedExecutorBotUser ADD MEMBER BotUser; 
GO

CREATE ROLE RestrictedExecutorRegularUser;
GRANT EXECUTE ON [dbo].[RentBot] TO RestrictedExecutorRegularUser;
GRANT EXECUTE ON [dbo].[SendMessage] TO RestrictedExecutorRegularUser;
GRANT EXECUTE ON [dbo].[ViewTransactionHistory] TO RestrictedExecutorRegularUser;
GRANT SELECT ON [dbo].[UserDashboard] TO RestrictedExecutorRegularUser;
ALTER ROLE RestrictedExecutorRegularUser ADD MEMBER RegularUser; 
GO

