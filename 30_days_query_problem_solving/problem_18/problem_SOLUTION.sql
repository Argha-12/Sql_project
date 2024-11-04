---------dataset --------------------
create table employees
(
	id			int,
	name		varchar(50)
);
insert into employees values(1, 'Lewis');
insert into employees values(2, 'Max');
insert into employees values(3, 'Charles');
insert into employees values(4, 'Sainz');


drop table if exists events;
create table events
(
	event_name		varchar(50),
	emp_id			int,
	dates			date
);
insert into events values('Product launch', 1, to_date('01-03-2024','DD-MM-YYYY'));
insert into events values('Product launch', 3, to_date('01-03-2024','DD-MM-YYYY'));
insert into events values('Product launch', 4, to_date('01-03-2024','DD-MM-YYYY'));
insert into events values('Conference', 2, to_date('02-03-2024','DD-MM-YYYY'));
insert into events values('Conference', 2, to_date('03-03-2024','DD-MM-YYYY'));
insert into events values('Conference', 3, to_date('02-03-2024','DD-MM-YYYY'));
insert into events values('Conference', 4, to_date('02-03-2024','DD-MM-YYYY'));
insert into events values('Training', 3, to_date('04-03-2024','DD-MM-YYYY'));
insert into events values('Training', 2, to_date('04-03-2024','DD-MM-YYYY'));
insert into events values('Training', 4, to_date('04-03-2024','DD-MM-YYYY'));
insert into events values('Training', 4, to_date('05-03-2024','DD-MM-YYYY'));



select * from employees;
select * from events;



----------Sloluction--------

select e.name as emp_name, count(distinct event_name) no_of_eve
from events ev
join employees e
on ev.emp_id = e.id
group by e.name
having count(distinct event_name) = (select count(distinct event_name) from events)
order by e.name

---------Solution_2-------------

WITH total_event_count AS (
    SELECT COUNT(DISTINCT event_name) AS total_events
    FROM events
)

SELECT e.name AS emp_name, COUNT(DISTINCT ev.event_name) AS no_of_eve
FROM events ev
JOIN employees e ON ev.emp_id = e.id
JOIN total_event_count tec ON COUNT(DISTINCT ev.event_name) = tec.total_events
GROUP BY e.name
ORDER BY e.name;