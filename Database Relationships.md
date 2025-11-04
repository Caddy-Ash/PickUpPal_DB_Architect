# PickUpPal Database Relationships – How The Tables Relate To One Another  

## Users  
- Every person using PickUpPal is a **user** — they can be a **parent**, **driver**, or **admin**.  
- Parents and drivers connect to other parts of the system depending on their role.  

---

## Parents & Students  
- A **parent** manages one or more **students** (`Students.user_id → Users.user_id`).  
- The **StudentParentMap** table allows a student to have more than one parent if needed.  

---

## Drivers & Vehicles  
- Each **driver** (`Drivers.user_id`) can be assigned a **vehicle** (`Drivers_Car.car_id → Vehicle.vehicle_id`).  
- A driver may use different vehicles at different times, tracked using `start_date` and `end_date`.  

---

## Trips  
- A **trip** is created for a specific **route** and assigned to a **driver** (`Trips.driver_id → Drivers.driver_id`, `Trips.route_id → Routes.route_id`).  
- **Parents** can book trips for their **students** (`TripAttendance.student_id → Students.student_id`).  

---

## Trip Attendance  
- Each **TripAttendance** record shows when a student **boards** or **gets off** the vehicle.  
- The **driver** confirms who actually attended the trip (`confirmed_by_driver`).  

---

## Payments  
- A **parent** pays for a trip (`Payments.parent_id → Users.user_id`, `Payments.trip_id → Trips.trip_id`).  
- Payment methods are saved in the **Payment_Methods** table so parents can reuse them later.  

---

## Ratings  
- After a trip, **parents** can leave a **rating** for the **driver** (`Ratings.parent_id → Users.user_id`, `Ratings.driver_id → Drivers.driver_id`, `Ratings.trip_id → Trips.trip_id`).  

---

## Notifications / Messages  
- **Users** can send **messages** or **alerts** to each other (`Messages.sender_id` and `receiver_id → Users.user_id`).  
- **Drivers** can also send **alerts** about their trips (`Alerts.driver_id`, `Alerts.trip_id`).  

---

## Additional Supporting Tables  
- **Guardians:** List emergency contacts for each student (`Guardians.student_id → Students.student_id`).  
- **Schools & Shifts:** Connect trips to schools and pickup times (`Shifts.school_id → Schools.school_id`).  
- **DriverPayouts:** Record payments made to drivers (`DriverPayouts.driver_id → Users.user_id`, `DriverPayouts.trip_id → Trips.trip_id`).  
- **Documents:** Store IDs, licenses, or verification files for users.  
- **AuditLogs:** Record all actions taken by users in the system.  
- **Fares:** Store trip prices for each route (`Fares.route_id → Routes.route_id`).  
