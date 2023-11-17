DELIMITER //

CREATE FUNCTION CalculateTotalExpenditure (userLogin VARCHAR(20)) 
RETURNS INT 
DETERMINISTIC
BEGIN 
    DECLARE totalExpenditure INT; 
    
    SELECT SUM(kwota) INTO totalExpenditure 
    FROM wynajem 
    WHERE status = 1 AND login = userLogin; 
    
    IF totalExpenditure IS NULL THEN 
        SET totalExpenditure = 0; 
    END IF; 
    
    RETURN totalExpenditure; 
END //

DELIMITER ;
