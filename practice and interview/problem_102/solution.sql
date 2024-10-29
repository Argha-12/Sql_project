###----dataset

Table: Transactions 

CREATE TABLE Transactions (
    transaction_id INT PRIMARY KEY,
    company_id INT,
    transaction_date DATE,
    revenue DECIMAL(10, 2)
);
INSERT INTO Transactions (transaction_id, company_id, transaction_date, revenue) VALUES
(101, 1, '2020-01-15', 5000.00),
(102, 2, '2020-01-20', 8500.00),
(103, 1, '2020-02-10', 4500.00),
(104, 3, '2020-02-20', 9900.00),
(105, 2, '2020-02-25', 7500.00);


Table: Sectors 

CREATE TABLE Sectors (
    company_id INT PRIMARY KEY,
    sector VARCHAR(50)
);
INSERT INTO Sectors (company_id, sector) VALUES
(1, 'Technology'),
(2, 'Healthcare'),
(3, 'Technology');


##----solution 
with argha as (
	select T.company_id , T.revenue , S.sector,
		DATE_FORMAT(transaction_date, '%m') AS month_number
	from Transactions T
	join Sectors S
	on T. company_id = S .company_id
)
select company_id, month_number, sector,
	avg (revenue) over ( partition by company_id, month_number) as avg_revenue
from argha
