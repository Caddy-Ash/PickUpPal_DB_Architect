-- USERS TABLE
-- This table stores all users of the system: parents, drivers, and admins.
CREATE TABLE PickUpPal.Users (
	user_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,  -- Unique ID for each user
	full_name VARCHAR(100) NOT NULL,                 -- User’s full name
	email VARCHAR(100) NOT NULL,                     -- User’s email address (must be unique)
	phone_number VARCHAR(20) NOT NULL,               -- Contact number
	`role` ENUM('parent', 'driver', 'admin') NOT NULL,  -- Role in the system
	password VARCHAR(100) NOT NULL,                  -- Encrypted password
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP NULL,  -- When the user was created
	CONSTRAINT UN_email UNIQUE KEY (email)           -- Make sure no duplicate emails exist
);



-- STUDENTS TABLE
-- Stores children who will be transported. Linked to a parent.
CREATE TABLE PickUpPal.Students (
  student_id INT AUTO_INCREMENT PRIMARY KEY,
  full_name VARCHAR(100) NOT NULL,        -- Student's name
  grade VARCHAR(20),                      -- Their school grade
  school_name VARCHAR(100),               -- Name of their school
  user_id INT NOT NULL,                   -- Parent's user_id
  FOREIGN KEY (user_id) REFERENCES PickUpPal.Users(user_id)
);



-- ATTENDANCE TABLE
-- Tracks whether a student was picked up, dropped off, or absent.
CREATE TABLE PickUpPal.Attendance (
  attendance_id INT AUTO_INCREMENT PRIMARY KEY,
  student_id INT NOT NULL,     -- The student being tracked
  trip_id INT NOT NULL,        -- The trip they’re assigned to
  status ENUM('boarded', 'absent', 'dropped') NOT NULL,  -- Their attendance status
  timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,  -- When this status was recorded
  FOREIGN KEY (student_id) REFERENCES PickUpPal.Students(student_id)
);



-- DRIVERS TABLE
-- Info about registered drivers. Linked to their user account.
CREATE TABLE PickUpPal.Drivers (
	driver_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
	user_id INT NULL,                    -- Connects to Users table
	licence_plate VARCHAR(50) NOT NULL,  -- Vehicle's plate number
	verified BOOL DEFAULT FALSE,         -- If this driver passed verification
	CONSTRAINT FK_drivers_users FOREIGN KEY (user_id) REFERENCES PickUpPal.Users(user_id)
);



-- DRIVERS_CAR TABLE
-- Links drivers to their cars and records when they were using them.
CREATE TABLE PickUpPal.Drivers_Car (
	id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
	driver_id INT,                       -- Driver using the car
	car_id INT NOT NULL,                 -- The actual vehicle ID
	start_date DATE,                     -- When the car use started
	end_date DATE,                       -- When it ended (if any)
	CONSTRAINT FK_drivers_car_drivers FOREIGN KEY (driver_id) REFERENCES PickUpPal.Drivers(driver_id),
	CONSTRAINT FK_drivers_car_vehicle FOREIGN KEY (car_id) REFERENCES PickUpPal.Vehicle(vehicle_id)
);



-- VEHICLE TABLE
-- Details about each car used for school transport.
CREATE TABLE PickUpPal.Vehicle (
	vehicle_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
	plate_number VARCHAR(20) NOT NULL,        -- Vehicle's plate (must be unique)
	model VARCHAR(50),                        -- Type or brand of car
	capacity INT,                             -- Number of students it can carry
	`year` YEAR,                              -- Year model of the car
	CONSTRAINT UK_vehicle UNIQUE KEY (plate_number)
);



-- GUARDIANS TABLE
-- Stores emergency contacts for each student.
CREATE TABLE PickUpPal.Guardians (
  guardian_id INT AUTO_INCREMENT PRIMARY KEY,
  student_id INT NOT NULL,           -- Which student they’re linked to
  full_name VARCHAR(100),            -- Guardian's name
  phone_number VARCHAR(20),          -- Contact number
  relationship VARCHAR(50),          -- “Mother”, “Uncle”
  FOREIGN KEY (student_id) REFERENCES PickUpPal.Students(student_id)
);



-- ALERTS TABLE
-- Stores emergency alerts sent by drivers (breakdowns or).
CREATE TABLE PickUpPal.Alerts (
  alert_id INT AUTO_INCREMENT PRIMARY KEY,
  driver_id INT NOT NULL,               -- Who sent the alert
  trip_id INT,                          -- Optional: which trip it's linked to
  alert_type ENUM('breakdown', 'accident', 'medical', 'other') NOT NULL,
  message TEXT,                         -- Description of the problem
  alert_time DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (driver_id) REFERENCES PickUpPal.Drivers(driver_id)
);



-- MESSAGES TABLE
-- In-app messages between users (parent and driver).
CREATE TABLE PickUpPal.Messages (
  message_id INT AUTO_INCREMENT PRIMARY KEY,
  sender_id INT NOT NULL,           -- Who sent the message
  receiver_id INT NOT NULL,         -- Who got the message
  content TEXT NOT NULL,            -- The actual message
  sent_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (sender_id) REFERENCES PickUpPal.Users(user_id),
  FOREIGN KEY (receiver_id) REFERENCES PickUpPal.Users(user_id)
);



-- RATINGS TABLE
-- Stores reviews parents leave after a trip.
CREATE TABLE PickUpPal.Ratings (
  rating_id INT AUTO_INCREMENT PRIMARY KEY,
  trip_id INT NOT NULL,
  parent_id INT NOT NULL,          -- Who gave the rating
  driver_id INT NOT NULL,          -- Who it’s for
  stars INT CHECK (stars BETWEEN 1 AND 5),   -- Star rating
  comment TEXT,                    -- Optional written feedback
  submitted_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (parent_id) REFERENCES PickUpPal.Users(user_id),
  FOREIGN KEY (driver_id) REFERENCES PickUpPal.Drivers(driver_id)
);



-- TRIPS TABLE
-- Each record here is a scheduled or completed trip.
CREATE TABLE PickUpPal.Trips (
  trip_id INT AUTO_INCREMENT PRIMARY KEY,
  driver_id INT NOT NULL,
  route_id INT NOT NULL,            -- Which route is being followed
  trip_date DATE,                   -- When the trip happens
  status ENUM('scheduled', 'in_progress', 'completed', 'cancelled'),
  FOREIGN KEY (driver_id) REFERENCES PickUpPal.Drivers(driver_id)
);



-- ROUTES TABLE
-- Pre-defined travel paths for trips (origin → destination).
CREATE TABLE PickUpPal.Routes (
  route_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100),               -- Route name like “Morning Route A”
  origin VARCHAR(100),             -- Starting point
  destination VARCHAR(100),        -- Where the trip ends
  estimated_time TIME              -- Estimated trip duration
);



-- TRIP LOCATIONS TABLE
-- Stores all the stops for a trip (pickup or drop-off points).
CREATE TABLE PickUpPal.Trip_Locations (
  id INT AUTO_INCREMENT PRIMARY KEY,
  trip_id INT NOT NULL,            -- Which trip this stop belongs to
  stop_name VARCHAR(100),          -- Name of the stop
  stop_time TIME,                  -- Expected time at this stop
  stop_order INT,                  -- Order of stop (1, 2, 3...)
  FOREIGN KEY (trip_id) REFERENCES PickUpPal.Trips(trip_id)
);



-- PAYMENTS TABLE
-- Tracks payment transactions made by parents for rides.
CREATE TABLE PickUpPal.Payments (
  payment_id INT AUTO_INCREMENT PRIMARY KEY,
  parent_id INT NOT NULL,
  trip_id INT NOT NULL,
  amount DECIMAL(10, 2),           -- How much was paid
  status ENUM('pending', 'paid', 'failed'),  -- Payment result
  payment_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (parent_id) REFERENCES PickUpPal.Users(user_id),
  FOREIGN KEY (trip_id) REFERENCES PickUpPal.Trips(trip_id)
);



-- PAYMENT METHODS TABLE
-- Stores preferred payment options per user (e.g. card or mobile wallet).
CREATE TABLE PickUpPal.Payment_Methods (
  method_id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,                      -- Who owns this method
  method_type ENUM('card', 'mobile_wallet', 'bank_transfer'),
  provider_name VARCHAR(100),                -- Like “Visa” or “Mtn MoMo”
  FOREIGN KEY (user_id) REFERENCES PickUpPal.Users(user_id)
);

