
#show the total index_count

SELECT COUNT(*) AS index_count
FROM information_schema.statistics
WHERE table_schema = 'rana';

#show the total index_name in the database ###

SELECT DISTINCT index_name
FROM information_schema.statistics
WHERE table_schema = 'rana';
 

 #show the total index_name in the table ###
 
SHOW INDEXES FROM employee;
