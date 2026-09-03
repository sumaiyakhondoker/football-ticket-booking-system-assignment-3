 
create table Users(
  user_id serial primary key,
  full_name varchar(50) not null,
  email varchar(255) unique,
  role varchar(20) check(role in('Ticket Manager', 'Football Fan')),
  phone_number varchar(20)
  );

create table Matches(
  match_id int primary key,
  fixture varchar(255) not null,
  tournament_category varchar(100) not null,
  base_ticket_price int check(base_ticket_price > 0),
  match_status varchar(20) check(match_status in ('Available', 'Selling Fast', 'Sold Out', 'Postponed'))
  );

create table Bookings(
  booking_id int primary key,
  user_id int references users(user_id),
  match_id int references matches(match_id),
  seat_number varchar(10) not null,
  payment_status varchar(20) check (payment_status in ('Pending', 'Confirmed','Cancelled', 'Refunded')),
  total_cost int check(total_cost > 0)
  );


insert into users(full_name, role,phone_number) values
('Tanvir Rahman', 'tanvir@mail.com', 'Football Fan', '+8801711111111'),
('Asif Haque', 'asif@mail.com', 'Football Fan', '+88017222222'),
('Sajjad Rahman', 'sajjad@mail.com', 'Ticket Manager', '+88017333333'),
('Jannat Ara', 'jannat@mail.com', 'Football Fan', null);

insert into Matches (match_id, fixture, tournament_category, base_ticket_price, match_status) VALUES
(101, 'Real Madrid vs Barcelona', 'Champions League', 150, 'Available'),
(102, 'Man City vs Liverpool', 'Premier League', 120, 'Selling Fast'),
(103, 'Bayern Munich vs PSG', 'Champions League', 130, 'Available'),
(104, 'AC Milan vs Inter Milan', 'Serie A', 90, 'Sold Out'),
(105, 'Juventus vs Roma', 'Serie A', 80, 'Available');


insert into Bookings (booking_id, user_id, match_id, seat_number, payment_status, total_cost) VALUES
(501, 1, 101, 'A-12', 'Confirmed', 150),
(502, 1, 102, 'B-04', 'Confirmed', 120),
(503, 2, 101, 'A-13', 'Confirmed', 150),
(504, 2, 101, 'D-24', NULL, 150),
(505, 3, 102, 'C-20', 'Pending', 120);


-- query 1
select match_id, fixture, base_ticket_price from Matches where tournament_category = 'Champions League' and match_status = 'Available';

-- query 2
select user_id, full_name, email from Users where full_name Ilike 'tanvir%' or full_name Ilike '%Haque%';

-- query-3
select booking_id, user_id, match_id, coalesce(payment_status,'Action Required') as "systematic_status" from bookings where payment_status is null;

-- query 4
select booking_id, full_name, fixture, total_cost from Users inner join Bookings using(user_id) inner join matches using(match_id);

-- query 5
select user_id, full_name, booking_id from Users left join Bookings using(user_id);

-- query 6
select booking_id, match_id, total_cost from Bookings where total_cost > (select avg(total_cost) from Bookings);

-- query 7
select match_id, fixture, base_ticket_price from Matches order by base_ticket_price desc limit 2 offset 1;













