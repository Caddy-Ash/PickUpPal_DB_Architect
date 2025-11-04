-- ======================================
-- INDEXING FOR THE PickUpPal SCHEMA
-- ======================================

-- USERS TABLE
CREATE INDEX idx_users_role ON PickUpPal.Users(`role`);
CREATE INDEX idx_users_email ON PickUpPal.Users(email);

-- STUDENTS TABLE
CREATE INDEX idx_students_user_id ON PickUpPal.Students(user_id);
CREATE INDEX idx_students_school_name ON PickUpPal.Students(school_name);

-- STUDENT-PARENT MAP TABLE
CREATE INDEX idx_studentparentmap_student_id ON PickUpPal.StudentParentMap(student_id);
CREATE INDEX idx_studentparentmap_parent_id ON PickUpPal.StudentParentMap(parent_id);

-- GUARDIANS TABLE
CREATE INDEX idx_guardians_student_id ON PickUpPal.Guardians(student_id);

-- DRIVERS TABLE
CREATE INDEX idx_drivers_user_id ON PickUpPal.Drivers(user_id);
CREATE INDEX idx_drivers_verified ON PickUpPal.Drivers(verified);

-- VEHICLE TABLE
CREATE INDEX idx_vehicle_plate_number ON PickUpPal.Vehicle(plate_number);

-- DRIVERS_CAR TABLE
CREATE INDEX idx_drivers_car_driver_id ON PickUpPal.Drivers_Car(driver_id);
CREATE INDEX idx_drivers_car_car_id ON PickUpPal.Drivers_Car(car_id);
CREATE INDEX idx_drivers_car_start_date ON PickUpPal.Drivers_Car(start_date);

-- SCHOOLS TABLE
CREATE INDEX idx_schools_name ON PickUpPal.Schools(name);

-- SHIFTS TABLE
CREATE INDEX idx_shifts_school_id ON PickUpPal.Shifts(school_id);
CREATE INDEX idx_shifts_name ON PickUpPal.Shifts(shift_name);

-- ROUTES TABLE
CREATE INDEX idx_routes_name ON PickUpPal.Routes(name);

-- TRIPS TABLE
CREATE INDEX idx_trips_driver_id ON PickUpPal.Trips(driver_id);
CREATE INDEX idx_trips_route_id ON PickUpPal.Trips(route_id);
CREATE INDEX idx_trips_status ON PickUpPal.Trips(status);
CREATE INDEX idx_trips_date ON PickUpPal.Trips(trip_date);

-- TRIP LOCATIONS TABLE
CREATE INDEX idx_trip_locations_trip_id ON PickUpPal.Trip_Locations(trip_id);
CREATE INDEX idx_trip_locations_stop_order ON PickUpPal.Trip_Locations(stop_order);

-- TRIP ATTENDANCE TABLE
CREATE INDEX idx_tripattendance_trip_id ON PickUpPal.TripAttendance(trip_id);
CREATE INDEX idx_tripattendance_student_id ON PickUpPal.TripAttendance(student_id);
CREATE INDEX idx_tripattendance_confirmed ON PickUpPal.TripAttendance(confirmed_by_driver);

-- RATINGS TABLE
CREATE INDEX idx_ratings_trip_id ON PickUpPal.Ratings(trip_id);
CREATE INDEX idx_ratings_driver_id ON PickUpPal.Ratings(driver_id);
CREATE INDEX idx_ratings_parent_id ON PickUpPal.Ratings(parent_id);

-- PAYMENTS TABLE
CREATE INDEX idx_payments_parent_id ON PickUpPal.Payments(parent_id);
CREATE INDEX idx_payments_trip_id ON PickUpPal.Payments(trip_id);
CREATE INDEX idx_payments_status ON PickUpPal.Payments(status);

-- PAYMENT METHODS TABLE
CREATE INDEX idx_payment_methods_user_id ON PickUpPal.Payment_Methods(user_id);
CREATE INDEX idx_payment_methods_type ON PickUpPal.Payment_Methods(method_type);

-- DRIVER PAYOUTS TABLE
CREATE INDEX idx_driverpayouts_driver_id ON PickUpPal.DriverPayouts(driver_id);
CREATE INDEX idx_driverpayouts_trip_id ON PickUpPal.DriverPayouts(trip_id);
CREATE INDEX idx_driverpayouts_status ON PickUpPal.DriverPayouts(payout_status);

-- FARES TABLE
CREATE INDEX idx_fares_route_id ON PickUpPal.Fares(route_id);

-- DOCUMENTS TABLE
CREATE INDEX idx_documents_user_id ON PickUpPal.Documents(user_id);
CREATE INDEX idx_documents_type ON PickUpPal.Documents(type);

-- AUDIT LOGS TABLE
CREATE INDEX idx_auditlogs_user_id ON PickUpPal.AuditLogs(user_id);
CREATE INDEX idx_auditlogs_timestamp ON PickUpPal.AuditLogs(timestamp);

-- ALERTS TABLE
CREATE INDEX idx_alerts_driver_id ON PickUpPal.Alerts(driver_id);
CREATE INDEX idx_alerts_trip_id ON PickUpPal.Alerts(trip_id);
CREATE INDEX idx_alerts_type ON PickUpPal.Alerts(alert_type);

-- MESSAGES TABLE
CREATE INDEX idx_messages_sender_id ON PickUpPal.Messages(sender_id);
CREATE INDEX idx_messages_receiver_id ON PickUpPal.Messages(receiver_id);
CREATE INDEX idx_messages_sent_at ON PickUpPal.Messages(sent_at);
