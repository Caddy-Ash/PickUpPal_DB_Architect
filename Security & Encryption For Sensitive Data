-- ENCRYPTION FOR SENSITIVE DATA


-- ======================================
-- This section protects private information (like phone numbers and emails)
-- by converting them into unreadable, encrypted form.

-- 1. CHANGE COLUMN TYPES
-- Changes phone_number and email columns to VARBINARY
-- so they can store encrypted data instead of normal text.

ALTER TABLE PickUpPal.Users
MODIFY phone_number VARBINARY(255),   -- Used for storing encrypted phone numbers
MODIFY email VARBINARY(255);          -- Used for storing encrypted emails


-- ======================================
-- 2. ENCRYPT AND SAVE DATA
-- This locks (encrypts) phone numbers and emails using AES encryption.
-- The result is turned into Base64 format so it can be stored as text.
-- Replace 'YourStrongSecretKey!' with your own secure key.

UPDATE PickUpPal.Users
SET phone_number = TO_BASE64(AES_ENCRYPT('0123456789', 'YourStrongSecretKey!')),
    email = TO_BASE64(AES_ENCRYPT('test@example.com', 'YourStrongSecretKey!'))
WHERE user_id = 1;


-- ======================================
-- 3. DECRYPT ENCRYPTED DATA
-- This unlocks (decrypts) the encrypted phone and email so they can be read again.
-- Only the backend system or an admin should do this.

SELECT 
  user_id,
  AES_DECRYPT(FROM_BASE64(phone_number), 'YourStrongSecretKey!') AS phone_number,
  AES_DECRYPT(FROM_BASE64(email), 'YourStrongSecretKey!') AS email
FROM PickUpPal.Users;


-- ======================================
-- 4. SECURITY ROLES AND PERMISSIONS
-- This part sets up roles (groups of permissions)
-- so each type of user can only do what they’re supposed to.

CREATE ROLE 'PARENT', 'DRIVER', 'ADMIN';

-- Give each role its own access level:
GRANT SELECT ON Messages TO 'PARENT';                    -- Parents can read messages
GRANT INSERT, SELECT ON TripAttendance TO 'DRIVER';      -- Drivers can mark attendance
GRANT ALL ON *.* TO 'ADMIN';                             -- Admins can do everything


-- ======================================
-- 5. CUSTOM FUNCTIONS FOR ENCRYPTION AND DECRYPTION
-- These make it easier to encrypt and decrypt email addresses automatically.

CREATE FUNCTION encrypt_email(val TEXT) RETURNS BLOB
RETURN AES_ENCRYPT(val, 'your_secure_key');

CREATE FUNCTION decrypt_email(val BLOB) RETURNS TEXT
RETURN AES_DECRYPT(val, 'your_secure_key');

-- Example: Encrypt all existing emails
UPDATE Users SET email = encrypt_email(email);


-- ======================================
-- 6. PUBLIC VIEW WITHOUT PRIVATE DATA
-- This creates a simple "view" (like a filtered table)
-- that hides private information such as email and phone numbers.

CREATE VIEW PublicUsers AS
SELECT user_id, name, role
FROM Users;
