create database railwayreservationsystem;
use railwayreservationsystem;

create table trains (train_id int primary key,
                     train_name varchar(100),
                     source varchar(50),
                     destination varchar(50),
                     departure_time time,
                     arrival_time time);
insert into trains values (12951, 'rajdhani express', 'delhi', 'mumbai', '16:25', '08:35');

create table passengers (passenger_id int primary key,
                         name varchar(100),
                         email varchar(100),
                         phone varchar(15));
insert into passengers values (1, 'aman verma', 'aman@example.com', '1234567890');

create table bookings (pnr varchar(20) primary key,
                       passenger_id int,
                       train_id int,
                       travel_date date,
                       class varchar(20),
                       seat_no varchar(10),
					   status varchar(20),
                       foreign key (passenger_id) references passengers(passenger_id),
                       foreign key (train_id) references trains(train_id));
insert into bookings values ('563920145', 1, 12951, '2025-09-25', 'ac 2 tier', 'b2-45', 'confirmed');

create table payments (payment_id int primary key,
                       pnr varchar(20),
                       amount decimal(10,2),
                       payment_date date,
                       status varchar(20),
					   foreign key (pnr) references bookings(pnr));
insert into payments values (1, '563920145', 2450.00, '2025-09-25', 'paid');

-- queries

-- find all trains between two stations
select train_name, departure_time, arrival_time
from trains
where source = 'delhi' and destination = 'mumbai';

-- get booking details
select b.pnr, t.train_name, b.travel_date, b.class, b.seat_no, b.status
from bookings b
join passengers p on b.passenger_id = p.passenger_id
join trains t on b.train_id = t.train_id
where p.passenger_id = 1;

-- check payment status of a booking
select p.payment_id, p.amount, p.payment_date, p.status
from payments p
join bookings b on p.pnr = b.pnr
where b.pnr = '563920145';

-- get all passengers of a train
select p.name, b.class, b.seat_no
from passengers p
join bookings b on p.passenger_id = b.passenger_id
where b.train_id = 12951 and b.travel_date = '2025-09-25';

-- cancel a booking and update status
update bookings
set status = 'cancelled'
where pnr = '563920145';

update payments
set status = 'refunded'
where pnr = '563920145';

