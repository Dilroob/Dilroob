create database automobile;
use automobile;
select * from automobile_data;


-- all cars of 'audi'
select * from automobile_data
where make = 'audi';

-- expensive cars
select make,price
from automobile_data
where price > 20000
order by price desc
limit 5;

-- cheap cars
select make,price
from automobile_data
where price < 20000;

-- avg price of cars
select avg(price) as avg_price from automobile_data;

-- cars with highest mileage
select make,`city-mpg`
from automobile_data
order by `city-mpg` desc
limit 5;

-- cars with lowest mileage
select make,`city-mpg`
from automobile_data
order by `city-mpg` asc
limit 5;

-- count cars by fuel type
select `fuel-type`,COUNT(*) 
from automobile_data
group by `fuel-type`;

-- cars with highest horsepower
select make,horsepower
from automobile_data
order by horsepower desc
limit 5;

-- cars with lowest horsepower
select make,horsepower
from automobile_data
order by horsepower asc
limit 5;

-- cars within a price range
select make,price
from automobile_data
where price between 10000 and 20000;

-- avg mileage by fuel type
select `fuel-type`, avg(`city-mpg`) as avg_city_mpg
from automobile_data
group by `fuel-type`;

-- compare city vs highway mileage
select make,`city-mpg`,`highway-mpg`,
       (`highway-mpg` - `city-mpg`) as mileage_difference
from automobile_data;

-- count cars by brand
select make,COUNT(*) as total_cars
from automobile_data
group by make
order by total_cars desc;

-- cars with above avg price
select make,price
from automobile_data
where price > (select avg(price) from automobile_data);

-- fuel efficient cars
select make,`city-mpg`
from automobile_data
where `city-mpg` > 30;

-- creating a view for fuel efficient car
create view fuel_efficient_cars as
select make,`city-mpg`
from automobile_data
where `city-mpg` > 30;

select * from fuel_efficient_cars;

set sql_safe_updates = 0;

-- updating missing values 
update automobile_data
set price = null
where trim(price) = '?';

-- deleting invalid rows
delete from automobile_data
where price is null;

-- cars with biggest engine size
select make,`engine-size`
from automobile_data
order by `engine-size` desc
limit 5;

-- cars with smallest engine size
select make,`engine-size`
from automobile_data
order by `engine-size` asc
limit 5;