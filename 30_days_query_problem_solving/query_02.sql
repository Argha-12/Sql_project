CREATE TABLE swipe (
    id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT,
    swipe_time DATETIME,
    swipe_type ENUM('login', 'logout')
);

INSERT INTO swipe (employee_id, swipe_time, swipe_type) VALUES
(1, '2024-07-01 08:00:00', 'login'),
(1, '2024-07-01 12:00:00', 'logout'),
(1, '2024-07-01 13:00:00', 'login'),
(1, '2024-07-01 17:00:00', 'logout'),
(2, '2024-07-01 09:00:00', 'login'),
(2, '2024-07-01 18:00:00', 'logout'),
(2, '2024-07-02 09:00:00', 'login'),
(2, '2024-07-02 17:00:00', 'logout');

select * from swipe;
--- Find out how much productive he was at office on a particular day. (He might have done many swipes per day. I need to find the actual time spent at office) --
SELECT 
    employee_id,
    DATE(swipe_time) AS day,
    TIMESTAMPDIFF(MINUTE , MIN(swipe_time), MAX(swipe_time)) AS office_hours
FROM swipe
WHERE 
    swipe_type IN ('login', 'logout')
GROUP BY 
    employee_id, DATE(swipe_time);

---different way--


