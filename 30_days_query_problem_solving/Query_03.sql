----PROBLEM STATEMENT: Write a sql query to return the footer values from input table, meaning all the last non null values from each field as shown in expected output.									
									
									




select * 
from (select car from footer where car is not null order by id desc limit 1) car
cross join(select length from footer where length is not null order by id desc limit 1) length
   cross join  (select width from footer where width is not null order by id desc limit 1) width
  cross join   (select height from footer where height is not null order by id desc limit 1) height
