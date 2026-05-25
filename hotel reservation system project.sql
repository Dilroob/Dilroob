create database hotelreservationsystem;
use hotelreservationsystem;

create table hotel (hotel_id int primary key,
                    name varchar(100),
                    location varchar(100),
                    rating decimal(2,1));
insert into hotel values (1,'sunshine residency','city center',4.5);

create table room (room_id int primary key,
                   hotel_id int,
                   room_type varchar(50),
                   price decimal(10,2),
                   status varchar(50),
                   foreign key (hotel_id) references hotel(hotel_id));
insert into room values (101,1,'deluxe suite',150.00,'available');

create table customer (customer_id int primary key,
                       name varchar(100),
                       email varchar(100),
					   phone varchar(50));
insert into customer values (1,'john doe','john@example.com','1234567890');

create table reservation (res_id int primary key,
						  customer_id int,
                          room_id int,
                          checkin date,
						  checkout date,
                          status varchar(50),
						  foreign key (customer_id) references customer(customer_id),
						  foreign key (room_id) references room(room_id));
insert into reservation values (1,1,101,'2025-09-25','2025-09-28','confirmed');

create table payment (payment_id int primary key,
                      res_id int,
                      amount decimal(10,2),
					  date date,
                      method varchar(50),
                      foreign key (res_id) references reservation(res_id));
insert into payment values (1,1,450.00,'2025-09-25','credit card');

-- queries:
 
-- find available rooms
select room_id,room_type,price
from room
where hotel_id = 1 and status = 'available';

-- get all reservations
select r.res_id,r.checkin,r.checkout,h.name as hotel_name,rm.room_type
from reservation r
join customer c on r.customer_id = c.customer_id
join room rm on r.room_id = rm.room_id
join hotel h on rm.hotel_id = h.hotel_id
where c.customer_id = 1;

-- find total revenue generated
select h.name, sum(p.amount) as total_revenue
from payment p
join reservation r on p.res_id = r.res_id
join room rm on r.room_id = rm.room_id
join hotel h on rm.hotel_id = h.hotel_id
where h.hotel_id = 1
group by h.name;

-- get customers who have made reservations
select c.customer_id, c.name, c.email
from customer c
join reservation r on c.customer_id = r.customer_id;

-- get payment details
select p.payment_id, p.amount, p.date, p.method
from payment p
join reservation r on p.res_id = r.res_id
where r.res_id = 1;

-- update room status after reservation
update room
set status = 'occupied'
where room_id = 101;

-- cancel a reservation and update room status
update reservation
set status = 'cancelled'
where res_id = 1;

update room
set status = 'available'
where room_id = 101;
 





