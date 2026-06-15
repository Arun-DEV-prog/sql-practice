CREATE DATABASE Ticket_Booking
CREATE TYPE role_type AS enum('Ticket Manager', 'Football Fan');


CREATE TABLE Users (
  user_id serial PRIMARY KEY,
  full_name varchar(100),
  email varchar(100) UNIQUE NOT NULL,
  role role_type NOT NULL,
  phone_number varchar(20)
);


CREATE TABLE Matches (
  match_id serial PRIMARY KEY,
  fixture varchar(200),
  tournament_category varchar(100),
  base_ticket_price numeric CHECK (base_ticket_price >= 0),
  match_status varchar(50) CHECK (
    match_status IN (
      'Available',
      'Selling Fast',
      'Sold Out',
      'Postponed'
    )
  )
);


-- =========================================================================
-- 3. CREATE BOOKINGS TABLE
-- =========================================================================
CREATE TABLE bookings (
  booking_id int PRIMARY KEY,
  user_id int REFERENCES users (user_id),
  match_id int REFERENCES matches (match_id),
  seat_number varchar(20),
  payment_status varchar(20) CHECK (
    payment_status IN ('Pending', 'Confirmed', 'Cancelled', 'Refunded')
  ),
  total_cost numeric CHECK (total_cost >= 0)
);


INSERT INTO
  Users (user_id, full_name, email, role, phone_number)
VALUES
  (
    1,
    'Tanvir Rahman',
    'tanvir@mail.com',
    'Football Fan',
    '+8801711111111'
  ),
  (
    2,
    'Asif Haque',
    'asif@mail.com',
    'Football Fan',
    '+8801722222222'
  ),
  (
    3,
    'Sajjad Rahman',
    'sajjad@mail.com',
    'Ticket Manager',
    '+8801733333333'
  ),
  (
    4,
    'Jannat Ara',
    'jannat@mail.com',
    'Football Fan',
    NULL
  );


INSERT INTO
  Matches (
    match_id,
    fixture,
    tournament_category,
    base_ticket_price,
    match_status
  )
VALUES
  (
    101,
    'Real Madrid vs Barcelona',
    'Champions League',
    150.00,
    'Available'
  ),
  (
    102,
    'Man City vs Liverpool',
    'Premier League',
    120.00,
    'Selling Fast'
  ),
  (
    103,
    'Bayern Munich vs PSG',
    'Champions League',
    130.00,
    'Available'
  ),
  (
    104,
    'AC Milan vs Inter Milan',
    'Serie A',
    90.00,
    'Sold Out'
  ),
  (
    105,
    'Juventus vs Roma',
    'Serie A',
    80.00,
    'Available'
  );


INSERT INTO
  Bookings (
    booking_id,
    user_id,
    match_id,
    seat_number,
    payment_status,
    total_cost
  )
VALUES
  (501, 1, 101, 'A-12', 'Confirmed', 150.00),
  (502, 1, 102, 'B-04', 'Confirmed', 120.00),
  (503, 2, 101, 'A-13', 'Confirmed', 150.00),
  (504, 2, 101, NULL, NULL, 150.00),
  (505, 3, 102, 'C-20', 'Pending', 120.00);


--QUERY 1
SELECT
  match_id,
  fixture,
  base_ticket_price
FROM
  matches
WHERE
  tournament_category = 'Champions League'
  AND match_status = 'Available';


--QUERY2 
SELECT
  user_id,
  full_name,
  email
FROM
  users
WHERE
  full_name ILIKE 'Tanvir%'
  OR full_name ILIKE '%Haque%';


--QUERY3
SELECT  booking_id,user_id,match_id, COALESCE(payment_status,'Action Required') FROM bookings
WHERE payment_status IS NULL;


--QUERY4
SELECT  
  b.booking_id ,
  u.full_name ,
  m.fixture,
  b.total_cost
  FROM bookings  b
INNER JOIN users  u ON b.user_id=u.user_id 
INNER JOIN matches m ON b.match_id=m.match_id;
;

--QUERY5
SELECT
  u.user_id, 
  u.full_name,
  b.booking_id 
  FROM users u
LEFT JOIN bookings b ON u.user_id=b.user_id; 

--QUERY6
SELECT
  b.booking_id,
  m.match_id,
  b.total_cost FROM bookings b
INNER JOIN matches m ON b.match_id=m.match_id
WHERE(
  b.total_cost >(
   SELECT AVG(total_cost)
    FROM bookings
  )
)  
;

--QUERY 7
SELECT 
    match_id,
    fixture,
    base_ticket_price
FROM matches
ORDER BY base_ticket_price DESC
LIMIT 2 OFFSET 1;


