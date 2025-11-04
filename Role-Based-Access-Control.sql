-- ROLE-BASED ACCESS CONTROL (RBAC)
-- This part controls what different people are allowed to do in the database.
-- It helps make sure everyone only sees or changes what they’re supposed to.

-- ======================================
-- A. CREATE MYSQL USERS
-- These lines create MySQL accounts for different kinds of users.

CREATE USER 'admin_user'@'localhost' IDENTIFIED BY 'adminpass';     -- Admin account
CREATE USER 'driver_user'@'localhost' IDENTIFIED BY 'driverpass';   -- Driver account
CREATE USER 'parent_user'@'localhost' IDENTIFIED BY 'parentpass';   -- Parent account

-- ======================================
-- B. GIVE PERMISSIONS (ACCESS LEVELS)

-- ADMIN: Can do everything in the PickUpPal database
GRANT ALL PRIVILEGES ON PickUpPal.* TO 'admin_user'@'localhost';

-- DRIVER: Can only see trip schedules and send messages
GRANT SELECT ON PickUpPal.Trips TO 'driver_user'@'localhost';           -- Can view trips
GRANT SELECT, INSERT ON PickUpPal.Messages TO 'driver_user'@'localhost'; -- Can read and send messages

-- PARENT: Can send messages and view or make payments
GRANT SELECT, INSERT ON PickUpPal.Messages TO 'parent_user'@'localhost'; -- Can read and send messages
GRANT SELECT, INSERT ON PickUpPal.Payments TO 'parent_user'@'localhost'; -- Can view and make payments

-- ======================================
-- C. APPLY CHANGES
-- This command activates all the new permissions above.
FLUSH PRIVILEGES;
