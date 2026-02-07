use sample 

select * from products
truncate table products

---Scalar function return only one row 
create function price_check(@price int)
returns int
as 
begin
	return @price * 0.5
end;
SELECT *, dbo.price_check(price)
from products
	
----Table-Valued function return only multiple values 

create function multiple_values(@price int)
returns table
as 
return(
	select * from products
	where price > @price
)
select * from multiple_values(100)


create function add_two_values(@values1 int , @values2 int)
returns int
as 
begin
	declare @result int
	set @result = @values1 + @values2
	return @result
end
select dbo.add_two_values(10,15)
SELECT product_id, dbo.add_two_values(price , price)
from products


create function add_three_values (@values1 int, @values2 int, @values3 int)
returns int
as 
begin
	declare @okay int
	set @okay = @values1 + @values2 + @values3
	return @okay
end

select dbo.add_three_values(10,15,20)


create function more_values (@values1 int , @values2 int)
returns int
as 
begin 
	return @values1 + @values2
end 

select dbo.more_values(10,15)


---using local variable

create function local_values (@values1 int, @values2 int)
returns int
as 
begin 
	declare @argha int
	set @argha = @values1 + @values2
	return @argha
end 

select dbo.local_values(10,15)
select * from employees

-----  Table-Valued User-Defined Function

create function table_valued (@logic varchar(25))
returns table
as 
 return select * from  employees where Department = @logic

 select * from table_valued ('IT')
 

