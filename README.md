# PickUpPal Database Design

Hey there

This repo contains all the database work I’ve done for **PickUpPal**, a smart school transport system my team and I are building. As the Data Architect, it’s been my responsibility to design the entire structure behind how the data flows — from users to trips, vehicles to payments, and everything in between.

---

## What You'll Find in This Repo

| File | What It’s For |
|------|----------------|
| `create_tables.sql` | All the SQL scripts that create the tables and relationships |
| `all_indexes.sql` | Indexing strategy for better performance when the DB grows |
| `PickUpPal_ERD.png` | A full visual ERD showing how everything connects |
| `how_it_all_connects.txt` | Quick breakdown of table relationships in plain English |
| `tables_normalization(1-3NF).md` | Shows how I structured the schema using 1NF, 2NF, and 3NF |

---

## Why I Designed It Like This

- The schema is **normalized up to 3NF**, to reduce redundancy and keep everything clean
- I added **indexes** on key columns to help with large queries and future scalability
- Every table has a **clear purpose**, and the relationships between them are tightly structured
- Role-based design (admin, parent, driver) helps with data security and logic

---

## What the Tables Cover (Schema)


Here’s a quick breakdown of each table in the PickUpPal database and what it’s used for:

### `Users`
- Stores **all users** of the platform — parents, drivers, and admins.
- Role-based logic (`role` enum) for access control.
- Used by almost every other table for links and references.

### `Students`
- Holds data about each student who needs school transport.
- Linked to a parent through `user_id`.

### `Guardians`
- Stores emergency/backup contact details for students.
- Linked to a student by `student_id`.

### `Drivers`
- Extends the `Users` table with driver-specific data (plate, verified status).
- Linked to a user profile (driver = user).

### `Vehicle`
- Stores each vehicle used in the system.
- Linked to drivers through the `Drivers_Car` table.

### `Drivers_Car`
- Manages the relationship between drivers and vehicles.
- Tracks who was assigned to which vehicle and when.

### `Routes`
- Represents pre-defined school routes.
- Used to organize and group trips logically.

### `Trips`
- A record of an actual ride on a specific day.
- Linked to a route and a driver.
- Tracks trip status like `scheduled`, `completed`, etc.

### `Trip_Locations`
- Stop-by-stop breakdown for each trip.
- Includes timing and stop order for better planning.
  
### `Attendance`
- Logs whether students boarded, were absent, or dropped during a trip.
- Critical for safety tracking and real-time updates.

### `Alerts`
- Used for emergencies like breakdowns or accidents.
- Sent by drivers, linked to a trip.

### `Messages`
- In-app or SMS-style messages between users (e.g., driver to parent).
- Used for notifications, updates, etc.

### `Payments`
- Logs payments made by parents for trips.
- Tracks amount, trip, and payment status.

### `Payment_Methods`
- Stores the payment options each parent has saved (card, wallet, etc.)

### `Ratings`
- Feedback from parents about trips and drivers.
- Stars + optional comment.

---

## Stack Used

- **MySQL**
- **DBeaver** for design + visual ERD
- Just me and some clean SQL

---

## About Me

I’m the Data Architect on this project. My main role is to:
- Design the complete database schema for PickUpPal's features (students, drivers, trips, payments, etc.).
- Develop ERD diagrams, normalize tables (1NF–3NF).
- Define data types, keys, constraints, and indexing strategies.
- Share the design with the team for feedback and ensure consistency

---

Thanks for checking this out! Feel free to use it for learning or feedback. If you’re part of my team, everything you need to understand the data side of PickUpPal is right here.


