DELIMITER //

CREATE PROCEDURE iphone (
    IN price_id INT,
    IN brand_id VARCHAR(50)
)
BEGIN
    SELECT * FROM product 
    WHERE brand = brand_id;

    SELECT * FROM product 
    WHERE price = price_id;
END //

DELIMITER ;
call iphone(1000, 'Apple');