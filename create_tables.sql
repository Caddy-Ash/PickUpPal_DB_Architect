CREATE TABLE PickUpPal.Users (
	user_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
	full_name VARCHAR(100) NOT NULL,
	email VARCHAR(100) NOT NULL,
	phone_number VARCHAR(20) NOT NULL,
	`role` ENUM('parent', 'driver', 'admin') NOT NULL,
	password VARCHAR(100) NOT NULL,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP NULL,
	CONSTRAINT UN_email UNIQUE KEY (email)
);


CREATE TABLE PickUpPal.Students (
  student_id INT AUTO_INCREMENT PRIMARY KEY,
  full_name VARCHAR(100) NOT NULL,
  grade VARCHAR(20),
  school_name VARCHAR(100),
  user_id INT NOT NULL,
  FOREIGN KEY (user_id) REFERENCES PickUpPal.Users(user_id)
);


CREATE TABLE PickUpPal.Attendance (
  attendance_id INT AUTO_INCREMENT PRIMARY KEY,
  student_id INT NOT NULL,
  trip_id INT NOT NULL,
  status ENUM('boarded', 'absent', 'dropped') NOT NULL,
  timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (student_id) REFERENCES PickUpPal.Students(student_id)
);


CREATE TABLE PickUpPal.Drivers (
	driver_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
	user_id INT NULL,
	licence_plate VARCHAR(50) NOT NULL,
	verified BOOL DEFAULT FALSE,
	CONSTRAINT FK_drivers_users FOREIGN KEY (user_id) REFERENCES PickUpPal.Users(user_id)
);


CREATE TABLE PickUpPal.Drivers_Car (
	id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
	driver_id INT,
	car_id INT NOT NULL,
	start_date DATE,
	end_date DATE,
	CONSTRAINT FK_drivers_car_drivers FOREIGN KEY (driver_id) REFERENCES PickUpPal.Drivers(driver_id),
	CONSTRAINT FK_drivers_car_vehicle FOREIGN KEY (car_id) REFERENCES PickUpPal.Vehicle(vehicle_id)
);


CREATE TABLE PickUpPal.Vehicle (
	vehicle_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
	plate_number VARCHAR(20) NOT NULL,
	model VARCHAR(50),
	capacity INT,
	`year` YEAR,
	CONSTRAINT UK_vehicle UNIQUE KEY (plate_number)
);


CREATE TABLE PickUpPal.Guardians (
  guardian_id INT AUTO_INCREMENT PRIMARY KEY,
  student_id INT NOT NULL,
  full_name VARCHAR(100),
  phone_number VARCHAR(20),
  relationship VARCHAR(50),
  FOREIGN KEY (student_id) REFERENCES PickUpPal.Students(student_id)
);


CREATE TABLE PickUpPal.Alerts (
  alert_id INT AUTO_INCREMENT PRIMARY KEY,
  driver_id INT NOT NULL,
  trip_id INT,
  alert_type ENUM('breakdown', 'accident', 'medical', 'other') NOT NULL,
  message TEXT,
  alert_time DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (driver_id) REFERENCES PickUpPal.Drivers(driver_id)
);


CREATE TABLE PickUpPal.Messages (
  message_id INT AUTO_INCREMENT PRIMARY KEY,
  sender_id INT NOT NULL,
  receiver_id INT NOT NULL,
  content TEXT NOT NULL,
  sent_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (sender_id) REFERENCES PickUpPal.Users(user_id),
  FOREIGN KEY (receiver_id) REFERENCES PickUpPal.Users(user_id)
);


CREATE TABLE PickUpPal.Ratings (
  rating_id INT AUTO_INCREMENT PRIMARY KEY,
  trip_id INT NOT NULL,
  parent_id INT NOT NULL,
  driver_id INT NOT NULL,
  stars INT CHECK (stars BETWEEN 1 AND 5),
  comment TEXT,
  submitted_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (parent_id) REFERENCES PickUpPal.Users(user_id),
  FOREIGN KEY (driver_id) REFERENCES PickUpPal.Drivers(driver_id)
);


CREATE TABLE PickUpPal.Trips (
  trip_id INT AUTO_INCREMENT PRIMARY KEY,
  driver_id INT NOT NULL,
  route_id INT NOT NULL,
  trip_date DATE,
  status ENUM('scheduled', 'in_progress', 'completed', 'cancelled'),
  FOREIGN KEY (driver_id) REFERENCES PickUpPal.Drivers(driver_id)
);


CREATE TABLE PickUpPal.Routes (
  route_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100),
  origin VARCHAR(100),
  destination VARCHAR(100),
  estimated_time TIME
);


CREATE TABLE PickUpPal.Trip_Locations (
  id INT AUTO_INCREMENT PRIMARY KEY,
  trip_id INT NOT NULL,
  stop_name VARCHAR(100),
  stop_time TIME,
  stop_order INT,
  FOREIGN KEY (trip_id) REFERENCES PickUpPal.Trips(trip_id)
);


CREATE TABLE PickUpPal.Payments (
  payment_id INT AUTO_INCREMENT PRIMARY KEY,
  parent_id INT NOT NULL,
  trip_id INT NOT NULL,
  amount DECIMAL(10, 2),
  status ENUM('pending', 'paid', 'failed'),
  payment_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (parent_id) REFERENCES PickUpPal.Users(user_id),
  FOREIGN KEY (trip_id) REFERENCES PickUpPal.Trips(trip_id)
);


CREATE TABLE PickUpPal.Payment_Methods (
  method_id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  method_type ENUM('card', 'mobile_wallet', 'bank_transfer'),
  provider_name VARCHAR(100),
  FOREIGN KEY (user_id) REFERENCES PickUpPal.Users(user_id)
);


