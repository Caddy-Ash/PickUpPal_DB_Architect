# PickUpPal Database – Normalization Summary

This summary explains how the PickUpPal database is designed to stay neat and avoid repeated or confusing information. It follows three simple rules:  

- **1NF:** Every column holds one piece of information only.  
- **2NF:** Every detail in a table depends on the main ID of that table.  
- **3NF:** No column depends on another column, a column only depends on the main ID.  

---

### 1. Users Table  
- **1NF:** Each row is one user; no repeated info.  
- **2NF:** All details belong to that user’s ID.  
- **3NF:** No column depends on another column.  

### 2. Drivers Table  
- **1NF:** Each row is one driver.  
- **2NF:** All details belong to that driver’s ID.  
- **3NF:** Linked to Users; no repeated or calculated info.  

### 3. Students Table  
- **1NF:** Each row is one student.  
- **2NF:** All details belong to that student’s ID.  
- **3NF:** Connected to Users; no extra or copied data.  

### 4. StudentParentMap Table  
- **1NF:** Each row shows one student-parent link.  
- **2NF:** All details depend on the record ID.  
- **3NF:** Links use foreign keys; no repeated info.  

### 5. Guardians Table  
- **1NF:** Each row is one guardian.  
- **2NF:** All details belong to that guardian’s ID.  
- **3NF:** Describes only the guardian; nothing extra.  

### 6. Messages Table  
- **1NF:** Each row is one message.  
- **2NF:** All details belong to that message’s ID.  
- **3NF:** Sender and receiver are linked to Users; content is separate.  

### 7. Vehicle Table  
- **1NF:** Each row is one vehicle.  
- **2NF:** All details belong to that vehicle’s ID.  
- **3NF:** Details like model and year don’t depend on each other.  

### 8. Drivers_Car Table  
- **1NF:** Each row shows one driver-car link.  
- **2NF:** All details depend on the record ID.  
- **3NF:** Links use foreign keys; no repeated or calculated info.  

### 9. Routes Table  
- **1NF:** Each row is one route.  
- **2NF:** All details belong to that route’s ID.  
- **3NF:** Origin, destination, and time are separate facts.  

### 10. Trips Table  
- **1NF:** Each row is one trip.  
- **2NF:** All details belong to that trip’s ID.  
- **3NF:** Linked to driver and route; no extra info.  

### 11. Trip_Locations Table  
- **1NF:** Each row is one stop.  
- **2NF:** All details depend on the record ID.  
- **3NF:** Stop details are separate; trip link uses a foreign key.  

### 12. TripAttendance Table  
- **1NF:** Each row shows one student on one trip.  
- **2NF:** All details belong to that attendance ID.  
- **3NF:** Times and status only describe that record.  

### 13. Alerts Table  
- **1NF:** Each row is one alert.  
- **2NF:** All details belong to that alert’s ID.  
- **3NF:** Linked to driver or trip; all info is direct.  

### 14. Ratings Table  
- **1NF:** Each row is one rating.  
- **2NF:** All details belong to that rating’s ID.  
- **3NF:** Stars and comment describe this rating only.  

### 15. Payments Table  
- **1NF:** Each row is one payment.  
- **2NF:** All details belong to that payment’s ID.  
- **3NF:** Info is direct; foreign keys link related data.  

### 16. Payment_Methods Table  
- **1NF:** Each row is one payment method.  
- **2NF:** All details belong to that method’s ID.  
- **3NF:** Columns don’t depend on each other.  

### 17. DriverPayouts Table  
- **1NF:** Each row is one payout.  
- **2NF:** All details belong to that payout’s ID.  
- **3NF:** Info is direct; trip link uses a foreign key.  

### 18. Fares Table  
- **1NF:** Each row is one fare.  
- **2NF:** All details belong to that fare’s ID.  
- **3NF:** Base fare and rate per km are separate facts.  

### 19. Documents Table  
- **1NF:** Each row is one document.  
- **2NF:** All details belong to that document’s ID.  
- **3NF:** Info describes the document; linked to Users.  

### 20. AuditLogs Table  
- **1NF:** Each row is one log.  
- **2NF:** All details belong to that log’s ID.  
- **3NF:** Details like action, time, and IP are separate.  

### 21. Schools Table  
- **1NF:** Each row is one school.  
- **2NF:** All details belong to that school’s ID.  
- **3NF:** Name, address, and contact info are independent.  

### 22. Shifts Table  
- **1NF:** Each row is one shift.  
- **2NF:** All details belong to that shift’s ID.  
- **3NF:** Times are not based on other data; linked to school.


So now, **all** the tables are fully normalized and follow the **1NF, 2NF, and 3NF**. That means no weird repeats, no messy designs, and no confusion. Just a clean and smart structure that we build on.


