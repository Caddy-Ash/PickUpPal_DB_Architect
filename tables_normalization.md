# PickUpPal Database - Normalization Summary

This write-up explains how I made sure **all** the tables in the PickUpPal database are organized and not repeating stuff. This process is called **normalization**, and I checked every table to make sure it follows the first 3 rules:

- **1NF** = One value per column (nothing like lists)
- **2NF** = Everything depends on the whole ID (not just part of it)
- **3NF** = No weird columns that depend on other columns

---

## 1. Users Table

- • 1NF: Each column stores only one value
- • 2NF: All info depends on `user_id`
- • 3NF: No extra or calculated info here

## 2. Drivers Table

- • 1NF: Everything is clear and separate
- • 2NF: All depends on `driver_id`
- • 3NF: `user_id` just connects to Users, not calculated

## 3. Students Table

- • 1NF: Each student has one row
- • 2NF: All columns depend on `student_id`
- • 3NF: `user_id` only connects, no hidden info

## 4. Guardians Table

- • 1NF: One guardian per row
- • 2NF: Based on `guardian_id`
- • 3NF: All fields describe that guardian only

## 5. Messages Table

- • 1NF: One message per row
- • 2NF: All tied to `message_id`
- • 3NF: Nothing weird or repeated from other tables

## 6. Vehicle Table

- • 1NF: One car per row
- • 2NF: All info depends on `vehicle_id`
- • 3NF: Model or year are not linked to each other

## 7. Drivers\_Car Table

- • 1NF: One car driver pair per row
- • 2NF: Everything depends on `id`
- • 3NF: No overlap or derived columns

## 8. Routes Table

- • 1NF: Each route is its own row
- • 2NF: All columns use `route_id`
- • 3NF: Origin or destination not calculated from other fields

## 9. Trips Table

- • 1NF: One trip = one row
- • 2NF: All data uses `trip_id`
- • 3NF: Route or driver are just links, not duplicates

## 10. Trip\_Locations Table

- • 1NF: One stop per row
- • 2NF: Based on `id`
- • 3NF: All stop info stays with the stop

## 11. Attendance Table

- • 1NF: Each row = one student on one trip
- • 2NF: Depends on `attendance_id`
- • 3NF: Status and time are about this exact trip

## 12. Alerts Table

- • 1NF: One alert per row
- • 2NF: All columns depend on `alert_id`
- • 3NF: No copied data, just a link to trip or driver

## 13. Ratings Table

- • 1NF: One row per rating
- • 2NF: All info uses `rating_id`
- • 3NF: `stars` and `comment` are not based on other columns

## 14. Payments Table

- • 1NF: One payment per row
- • 2NF: Depends on `payment_id`
- • 3NF: All info belongs to this one payment only

## 15. Payment\_Methods Table

- • 1NF: Each method is on its own row
- • 2NF: Tied to `method_id`
- • 3NF: Nothing depends on other columns

---

So now, **all** the tables are fully normalized and follow the **1NF, 2NF, and 3NF**. That means no weird repeats, no messy designs, and no confusion. Just a clean and smart structure that we build on.

