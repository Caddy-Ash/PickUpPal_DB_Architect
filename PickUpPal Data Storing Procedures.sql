-- ======================================
-- PICKUPPAL STORED PROCEDURES SUMMARY
-- ======================================
-- These are automatic actions that help PickUpPal run smoothly:
--
-- 1. Add a new user:
--    When someone signs up as a parent, driver, or admin, the system automatically adds them.
--    It checks for duplicate emails so no one can sign up twice with the same email.
--
-- 2. Book a trip:
--    Parents or staff can schedule a trip for a driver and a route.
--    The system marks it as "scheduled" automatically.
--
-- 3. Daily trip summary:
--    Every day, the system can show how many trips happened, 
--    and how many are scheduled, in progress, completed, or missed.
--
-- 4. Driver payouts:
--    The system automatically calculates how much money drivers earned
--    from trips that have been paid for and records it for payout.
--
-- 5. Student attendance summary:
--    It counts how many trips a student took, who boarded, who got off,
--    and who missed trips over a certain period.
--
-- 6. Driver monthly earnings:
--    Shows total money a driver earned for a whole month.
--
-- In short, these procedures make PickUpPal automatic, organized, and accurate,
-- so the system does the work instead of relying on people to update everything manually.




-- STORED PROCEDURES
-- ======================================
-- REGISTER USER
-- Adds a new user (parent, driver, or admin) to the system
-- Makes sure the email is not already used
DELIMITER $$
CREATE PROCEDURE register_user (
  IN p_full_name VARCHAR(100),
  IN p_email VARCHAR(100),
  IN p_phone_number VARCHAR(20),
  IN p_role ENUM('parent', 'driver', 'admin'),
  IN p_password VARCHAR(255)
)
BEGIN
  -- Check if the email already exists
  IF EXISTS (
    SELECT 1 FROM PickUpPal.Users WHERE email = p_email
  ) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Email already in use';
  ELSE
    -- Add the new user
    INSERT INTO PickUpPal.Users (full_name, email, phone_number, role, password)
    VALUES (p_full_name, p_email, p_phone_number, p_role, p_password);
  END IF;
END$$
DELIMITER ;


-- ======================================
-- BOOK TRIP
-- Schedules a new trip with a specific driver and route
DELIMITER $$
CREATE PROCEDURE book_trip (
  IN p_driver_id INT,
  IN p_route_id INT,
  IN p_trip_date DATE
)
BEGIN
  INSERT INTO PickUpPal.Trips (driver_id, route_id, trip_date, status)
  VALUES (p_driver_id, p_route_id, p_trip_date, 'scheduled');
END$$
DELIMITER ;


-- ======================================
-- DAILY TRIP SUMMARY
-- Shows the number of trips for a specific day by their status
DELIMITER $$
CREATE PROCEDURE daily_trip_summary(IN report_date DATE)
BEGIN
  SELECT 
    DATE(scheduled_time) AS trip_day,
    COUNT(*) AS total_trips,
    SUM(CASE WHEN status = 'scheduled' THEN 1 ELSE 0 END) AS scheduled,
    SUM(CASE WHEN status = 'in_progress' THEN 1 ELSE 0 END) AS in_progress,
    SUM(CASE WHEN status = 'completed' THEN 1 ELSE 0 END) AS completed,
    SUM(CASE WHEN status = 'unconfirmed' THEN 1 ELSE 0 END) AS unconfirmed
  FROM Trips
  WHERE DATE(scheduled_time) = report_date;
END$$
DELIMITER ;


-- ======================================
-- GENERATE DRIVER PAYOUT
-- Calculates total paid trips for a driver and creates payout records
DELIMITER $$
CREATE PROCEDURE generate_driver_payout(IN input_driver_id INT, IN payout_date DATE)
BEGIN
  DECLARE total DECIMAL(10,2);

  -- Sum up all paid trips for this driver on the given date
  SELECT SUM(p.amount)
  INTO total
  FROM Payments p
  JOIN Trips t ON p.trip_id = t.trip_id
  WHERE t.driver_id = input_driver_id
    AND DATE(p.created_at) = payout_date
    AND p.paid = 1;

  -- If there are any payments, create payout records
  IF total IS NOT NULL THEN
    INSERT INTO DriverPayouts(driver_id, amount, trip_id, payout_status, created_at)
    SELECT t.driver_id, p.amount, p.trip_id, 'pending', NOW()
    FROM Payments p
    JOIN Trips t ON t.trip_id = p.trip_id
    WHERE t.driver_id = input_driver_id
      AND DATE(p.created_at) = payout_date
      AND p.paid = 1;
  END IF;
END$$
DELIMITER ;


-- ======================================
-- STUDENT ATTENDANCE SUMMARY
-- Shows attendance summary for each student in a date range
DELIMITER $$
CREATE PROCEDURE student_attendance_summary(IN start_date DATE, IN end_date DATE)
BEGIN
  SELECT 
    s.user_id AS student_id,
    u.full_name,
    COUNT(*) AS total_trips,
    SUM(CASE WHEN ta.boarded_at IS NOT NULL THEN 1 ELSE 0 END) AS boarded,
    SUM(CASE WHEN ta.alighted_at IS NOT NULL THEN 1 ELSE 0 END) AS alighted,
    SUM(CASE WHEN ta.boarded_at IS NULL THEN 1 ELSE 0 END) AS missed
  FROM TripAttendance ta
  JOIN Students s ON ta.user_id = s.user_id
  JOIN Users u ON u.user_id = s.user_id
  JOIN Trips t ON t.trip_id = ta.trip_id
  WHERE DATE(t.scheduled_time) BETWEEN start_date AND end_date
  GROUP BY s.user_id, u.full_name;
END$$
DELIMITER ;


-- ======================================
-- DRIVER MONTHLY EARNINGS
-- Shows total earnings for a driver for a given month (YYYY-MM)
DELIMITER $$
CREATE PROCEDURE driver_monthly_earnings(IN driver_id INT, IN month_year VARCHAR(7))
BEGIN
  SELECT 
    d.driver_id,
    u.full_name,
    SUM(p.amount) AS total_earnings
  FROM Drivers d
  JOIN Users u ON u.user_id = d.user_id
  JOIN Trips t ON t.driver_id = d.driver_id
  JOIN Payments p ON p.trip_id = t.trip_id
  WHERE d.driver_id = driver_id
    AND DATE_FORMAT(p.created_at, '%Y-%m') = month_year
  GROUP BY d.driver_id, u.full_name;
END$$
DELIMITER ;
