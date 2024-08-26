-- Solution:
select Dates , cast(product_id as char) as product
from orders
union
select Dates , GROUP_CONCAT(cast(product_id as char)) as product
from orders
group by Dates , customer_id
order by Dates ,product