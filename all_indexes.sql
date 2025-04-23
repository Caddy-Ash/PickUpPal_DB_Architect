-- Indexing for all the PickUpPal Schema

-- Users Table
CREATE INDEX idx_users_role ON PickUpPal.Users(`role`);
CREATE INDEX idx_users_email ON PickUpPal.Users(email);


-- Students Table
CREATE INDEX idx_students_user_id ON PickUpPal.Students(user_id);

-- Attendance Table
CREATE INDEX idx_attendance_student_id ON PickUpPal.Attendance(student_id);
CREATE INDEX idx_attendance_trip_id ON PickUpPal.Attendance(trip_id);

-- Drivers Table
CREATE INDEX idx_drivers_user_id ON PickUpPal.Drivers(user_id);

-- Drivers Car Table
CREATE INDEX idx_drivers_car_driver_id ON PickUpPal.Drivers_Car(driver_id);
CREATE INDEX idx_drivers_car_car_id ON PickUpPal.Drivers_Car(car_id);

-- Vehicle Table
CREATE INDEX idx_vehicle_plate_number ON PickUpPal.Vehicle(plate_number);

-- Guardians Table
CREATE INDEX idx_guardians_student_id ON PickUpPal.Guardians(student_id);

-- Alerts Table
CREATE INDEX idx_alerts_driver_id ON PickUpPal.Alerts(driver_id);
CREATE INDEX idx_alerts_trip_id ON PickUpPal.Alerts(trip_id);

-- Messages Table
CREATE INDEX idx_messages_sender_id ON PickUpPal.Messages(sender_id);
CREATE INDEX idx_messages_receiver_id ON PickUpPal.Messages(receiver_id);

-- Ratings Table
CREATE INDEX idx_ratings_trip_id ON PickUpPal.Ratings(trip_id);
CREATE INDEX idx_ratings_driver_id ON PickUpPal.Ratings(driver_id);
CREATE INDEX idx_ratings_parent_id ON PickUpPal.Ratings(parent_id);

-- Trips Table
CREATE INDEX idx_trips_driver_id ON PickUpPal.Trips(driver_id);
CREATE INDEX idx_trips_route_id ON PickUpPal.Trips(route_id);
CREATE INDEX idx_trips_status ON PickUpPal.Trips(status);

-- Routes Table
CREATE INDEX idx_routes_name ON PickUpPal.Routes(name);

-- Trip Locations Table
CREATE INDEX idx_trip_locations_trip_id ON PickUpPal.Trip_Locations(trip_id);
CREATE INDEX idx_trip_locations_stop_order ON PickUpPal.Trip_Locations(stop_order);

-- Payments Table
CREATE INDEX idx_payments_parent_id ON PickUpPal.Payments(parent_id);
CREATE INDEX idx_payments_trip_id ON PickUpPal.Payments(trip_id);
CREATE INDEX idx_payments_status ON PickUpPal.Payments(status);

-- Payment Methods Table
CREATE INDEX idx_payment_methods_user_id ON PickUpPal.Payment_Methods(user_id);
