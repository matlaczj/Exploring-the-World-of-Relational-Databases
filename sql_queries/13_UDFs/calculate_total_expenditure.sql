USE wynajem_db;
GO

CREATE FUNCTION CalculateTotalExpenditure (@login varchar(20))
RETURNS INT
AS
BEGIN
    DECLARE @totalExpenditure INT;

    SELECT @totalExpenditure = SUM(kwota)
    FROM wynajem
    WHERE [status] = 1 AND login = @login;

    RETURN @totalExpenditure;
END;
GO

DECLARE @userLogin varchar(20);
SET @userLogin = 'adventureSeeker';
SELECT dbo.CalculateTotalExpenditure(@userLogin) AS 'Total Expenditure for ExampleUser';
GO
