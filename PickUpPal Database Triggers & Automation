-- TRIGGERS & AUTOMATION
-- ======================================
-- This section adds automatic actions to the PickUpPal database.
-- Triggers run automatically when certain events (like INSERT or UPDATE) happen.
-- Events run on a schedule, like every few minutes.

------------------------------------------------------------
-- 1. AUDIT: LOG WHEN A NEW USER IS CREATED
------------------------------------------------------------
-- Creates a table to keep track of when new users are added.
CREATE TABLE IF NOT EXISTS PickUpPal.User_Audit (
  audit_id INT AUTO_INCREMENT PRIMARY KEY,   -- Unique ID for each audit record
  user_id INT,                               -- ID of the user created
  action VARCHAR(50),                        -- What happened (e.g., 'created')
  log_time DATETIME DEFAULT CURRENT_TIMESTAMP -- When it happened
);

-- Trigger: After a new user is inserted, log it automatically.
DELIMITER $$
CREATE TRIGGER after_user_insert
AFTER INSERT ON PickUpPal.Users
FOR EACH ROW
BEGIN
  INSERT INTO PickUpPal.User_Audit (user_id, action)
  VALUES (NEW.user_id, 'created');  -- Log that a new user was created
END$$
DELIMITER ;


------------------------------------------------------------
-- 2. VALIDATE PHONE NUMBERS BEFORE INSERTING USERS
------------------------------------------------------------
-- This checks that phone numbers are between 10 and 15 digits long.
-- If not, MySQL shows an error and refuses to insert the record.
DELIMITER $$
CREATE TRIGGER validate_phone
BEFORE INSERT ON PickUpPal.Users
FOR EACH ROW
BEGIN
  IF NEW.phone_number NOT REGEXP '^[0-9]{10,15}$' THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Phone number must be 10–15 digits only.';
  END IF;
END$$
DELIMITER ;


------------------------------------------------------------
-- 3. AUTO-UPDATE TRIP STATUS BASED ON ATTENDANCE
------------------------------------------------------------
-- Whenever a student's trip attendance is added,
-- this trigger updates the trip status automatically.

DELIMITER $$
CREATE TRIGGER trg_update_trip_status
AFTER INSERT ON TripAttendance
FOR EACH ROW
BEGIN
  UPDATE Trips
  SET status = CASE 
    WHEN EXISTS (
      SELECT 1 FROM TripAttendance
      WHERE trip_id = NEW.trip_id
        AND boarded_at IS NOT NULL
        AND alighted_at IS NULL
    ) THEN 'in_progress'       -- Trip started
    WHEN EXISTS (
      SELECT 1 FROM TripAttendance
      WHERE trip_id = NEW.trip_id
        AND alighted_at IS NOT NULL
    ) THEN 'completed'         -- Trip finished
    ELSE 'scheduled'           -- Trip not yet started
  END
  WHERE trip_id = NEW.trip_id;
END$$
DELIMITER ;


------------------------------------------------------------
-- 4. CALCULATE PAYMENT AMOUNT AUTOMATICALLY
------------------------------------------------------------
-- Before adding a new payment, calculate how much it should be
-- using the route’s base fare and distance.

DELIMITER $$
CREATE TRIGGER trg_before_insert_payment
BEFORE INSERT ON Payments
FOR EACH ROW
BEGIN
  DECLARE rate_per_km DECIMAL(5,2);
  DECLARE base DECIMAL(6,2);
  DECLARE distance DECIMAL(6,2);

  -- Get fare details from the route
  SELECT f.price_per_km, f.base_fare, r.estimated_distance_km
  INTO rate_per_km, base, distance
  FROM Fares f
  JOIN Routes r ON r.route_id = f.route_id
  WHERE f.route_id = NEW.route_id
  LIMIT 1;

  -- Calculate total payment = base fare + (rate × distance)
  SET NEW.amount = base + (rate_per_km * distance);
END$$
DELIMITER ;


------------------------------------------------------------
-- 5. FLAG UNCONFIRMED TRIPS (AUTOMATIC EVENT)
------------------------------------------------------------
-- This event runs every 15 minutes.
-- It marks any trip as 'unconfirmed' if:
--    - no one has boarded, and
--    - the scheduled time has already passed.

DELIMITER $$
CREATE EVENT ev_flag_unconfirmed_trips
ON SCHEDULE EVERY 15 MINUTE
DO
BEGIN
  UPDATE Trips
  SET status = 'unconfirmed'
  WHERE trip_id IN (
    SELECT t.trip_id
    FROM Trips t
    LEFT JOIN TripAttendance ta ON t.trip_id = ta.trip_id
    WHERE ta.boarded_at IS NULL
      AND t.scheduled_time < NOW()
  );
END$$
DELIMITER ;

-- Turn on MySQL’s event scheduler so the event can run automatically.
SET GLOBAL event_scheduler = ON;
