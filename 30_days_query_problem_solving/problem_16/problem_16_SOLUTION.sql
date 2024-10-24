
WITH cte AS (
    SELECT 
        DATE_FORMAT(dates, '%m') AS month_number,
        SUM(cases_reported) AS total_cases
    FROM covid_cases
    GROUP BY month_number
),
cte_final AS (
    SELECT *,
        SUM(total_cases) OVER (ORDER BY month_number) AS cumulative_total
    FROM cte
)
SELECT * ,
	case when month_number > 1
				then (total_cases / lag(cumulative_total) over (order by month_number))*100
                else '_' end as per_increase
from cte_final
