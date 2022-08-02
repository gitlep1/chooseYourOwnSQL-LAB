-- Comfort rating: 4
-- matching activity: bonus problems

-- PART 1 BONUS:

-- Query for hotels that allow pets
-- Query for hotels that allow pets AND have vacancies
-- Query for the average room price for a hotel that allows pets
-- Query for the most expensive room
-- Query for the average price of a room that has a name that includes queen in it (case insensitive)
-- Query for the most expensive room
-- Update a room at Hotel California with a room number of 202 to go from vacant-true to vacant false.
-- Update all the rooms with the hotel_id of 7 to now have a hotel_id that matches the Grand Budapest Hotel

SELECT * FROM hotels WHERE pets IS TRUE;
SELECT * FROM hotels JOIN rooms ON hotels.id = rooms.hotel_id WHERE pets IS TRUE AND vacant IS TRUE;
SELECT AVG(price) FROM rooms JOIN hotels ON hotels.id = rooms.hotel_id WHERE pets IS TRUE;
SELECT * FROM rooms WHERE price = (SELECT MAX(price) FROM rooms);
SELECT AVG(price) FROM rooms WHERE LOWER(name) LIKE 'queen';
SELECT MAX(price) FROM rooms WHERE LOWER(name) LIKE 'queen';
UPDATE rooms SET vacant = FALSE WHERE room_num = 202;
UPDATE rooms SET hotel_id = (SELECT id FROM hotels WHERE name = 'Grand Budapest Hotel') WHERE hotel_id = 7;



-- PART 2 BONUS:

-- create a table named "hotel_guests" with the following columns:
-- guest_name (string
-- stay_dates (string)
-- room_name (string)
-- room_num (integer)
-- price (integer)
-- hotel_name (string)
-- state (string)

CREATE TABLE hotel_guests (
  guest_name VARCHAR(255),
  stay_dates VARCHAR(255),
  room_name VARCHAR(255),
  room_num INTEGER,
  price INTEGER,
  hotel_name VARCHAR(255),
  state VARCHAR(255)
);

-- INSERT INTO the table "hotel_guests" the following values:
-- guest_name: SELECT guest_name FROM guests;
-- stay_dates: SELECT stay_dates FROM rooms_guests WHERE rooms_guests.guest_id = guests.id;
-- room_name: SELECT room_name FROM rooms WHERE rooms_guests.room_id = rooms.id;
-- room_num: SELECT room_num FROM rooms WHERE rooms_guests.room_id = rooms.id;
-- price: SELECT price FROM rooms WHERE rooms_guests.room_id = rooms.id;
-- hotel_name: SELECT hotel_name FROM hotels WHERE rooms.hotel_id = hotels.id;
-- state: SELECT state FROM hotels WHERE rooms.hotel_id = hotels.id;

INSERT INTO hotel_guests (
  guest_name,
  stay_dates,
  room_name,
  room_num,
  price,
  hotel_name,
  state
) SELECT
  guests.name,
  rooms_guests.stay_dates,
  rooms.name,
  rooms.room_num,
  rooms.price,
  hotels.name,
  hotels.state
FROM guests
  JOIN rooms_guests ON guests.id = rooms_guests.guest_id
  JOIN rooms ON rooms_guests.room_id = rooms.id
  JOIN hotels ON rooms.hotel_id = hotels.id;

  -- organize the data in the table "hotel_guests" by guest_name

SELECT * FROM hotel_guests ORDER BY guest_name;