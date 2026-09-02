 
create table Users(
  user_id serial primary key,
  full_name varchar(50) not null,
  email varchar(255) unique,
  role varchar(20) check(role in('Ticket Manager', 'Football Fan')),
  phone_number varchar(20)
  )

create table Matches(
  match_id int primary key,
  fixture varchar(255) not null,
  tournament_category varchar(100) not null,
  base_ticket_price int check(base_ticket_price > 0),
  match_status varchar(20) check(match_status in ('Available', 'Selling Fast', 'Sold Out', 'Postponed'))
  )

create table Bookings(
  booking_id int primary key,
  user_id int references users(user_id),
  match_id int references matches(match_id),
  seat_number varchar(10) not null,
  payment_status varchar(20) check (payment_status in ('Pending', 'Confirmed','Cancelled', 'Refunded')),
  total_cost int check(total_cost > 0)
  )












