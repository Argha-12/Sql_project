/* Problem Statement:
- For pairs of brands in the same year (e.g. apple/samsung/2020 and samsung/apple/2020) 
    - if custom1 = custom3 and custom2 = custom4 : then keep only one pair

- For pairs of brands in the same year 
    - if custom1 != custom3 OR custom2 != custom4 : then keep both pairs

- For brands that do not have pairs in the same year : keep those rows as well
*/
WITH cte AS (
    SELECT *,
           CASE 
               WHEN brand1 < brand2 THEN CONCAT(brand1, brand2, year)
               ELSE CONCAT(brand2, brand1, year)
           END AS pair_id
    FROM brands
),
my_cte AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY pair_id ORDER BY pair_id) AS rn
    FROM cte
)
SELECT brand1 , brand2 , custom1 , custom2 , custom3 , custom4
FROM my_cte
WHERE rn = 1
   OR (rn <> 1 AND custom1 <> custom3 AND custom3 <> custom4)
order by custom1 ;