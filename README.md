# Foundation Database Management System

A relational database management system designed for a charitable foundation to manage donors, students in need, donations, fundraising events, and donor engagement. The database is implemented using MySQL and applies relational database concepts including primary and foreign keys, integrity constraints, cascading actions, views, stored procedures, and role-based user permissions.

## Project Overview

The system provides a structured database for managing the relationships between donors, students, donations, and charitable events. Donors can participate in multiple events and make donations, while donations can be allocated to multiple students through relational mapping tables.

The database was designed to ensure data integrity, reduce redundancy, and support efficient retrieval of information through SQL queries, views, and stored procedures.

## Main Features

### Donor Management

Stores donor information, including personal details, career information, contact details, and address information. Donors can have multiple phone numbers through a separate relational table.

### Student Management

Manages students who require financial or other forms of assistance. Each student record includes personal information, city, age, email, and information about their specific needs.

### Event Management

Stores charitable and fundraising event information, including event location, date, and description.

### Donation Management

Records donations made by donors, including the donation amount, date, payment method, associated donor, and related event.

### Donation Allocation

Uses a many-to-many relationship between students and donations to track how donations are allocated to students.

### Donor Engagement

Tracks donor participation in events using a many-to-many relationship between donors and events.

## Database Tables

The database contains the following main tables:

- `Donors` – Stores donor information.
- `Donors_phone` – Stores one or more phone numbers for each donor.
- `Student` – Stores student information and assistance needs.
- `Event` – Stores charitable event details.
- `Donation` – Stores donation transactions.
- `student_donation` – Maps donations to students.
- `Engagement` – Maps donor participation to events.

## Views

The project includes SQL views for generating useful summaries and analytical insights:

- `donorContribution` – Calculates the total amount donated by each donor.
- `all_participants` – Displays donors participating in each event.
- `student_receiving` – Calculates the total donations received by each student.
- `event_total_donations` – Calculates the total donations associated with each event.

## Stored Procedures

Stored procedures were created to simplify common database operations:

- `get_student_info()` – Retrieves information for a specific student.
- `get_event_details()` – Retrieves details for a specific event.
- `donations_by_donors()` – Calculates the total donations made by a specific donor.
- `student_by_City()` – Retrieves students from a selected city.
- `get_Student_don_info()` – Retrieves a student's information together with their total allocated donations.
- `view_donorName_byEvent()` – Retrieves donor information for a selected event.

## Database Security and User Roles

The system implements role-based access control by creating database users with different permissions.

Roles include:

- **Admin** – Full access to the database.
- **Donor Information Manager** – Access to donor and donation information.
- **Student User** – Limited access to student donation information through stored procedures.
- **Event User** – Permissions related to event information and donor engagement.
- **Procedure User** – Permission to execute selected stored procedures.

## Data Integrity and Constraints

The database applies multiple constraints to maintain data consistency and integrity:

- Primary Keys
- Foreign Keys
- Composite Primary Keys
- Unique Constraints
- NOT NULL Constraints
- CHECK Constraints
- ON UPDATE CASCADE
- ON DELETE CASCADE
- ON DELETE RESTRICT

## Database Relationships

The system includes several one-to-many and many-to-many relationships:

- One donor can have multiple phone numbers.
- One donor can make multiple donations.
- One event can receive multiple donations.
- Donations can be allocated to multiple students.
- Students can receive allocations from multiple donations.
- Donors can participate in multiple events.
- Events can include multiple donor participants.

## Technologies Used

- MySQL
- SQL
- MySQL Workbench
- Relational Database Design
- Stored Procedures
- SQL Views
- Role-Based Access Control

## Validation and Testing

The project includes SQL tests to validate database behavior and integrity, including:

- Primary key uniqueness
- NOT NULL constraints
- Foreign key constraints
- Unique email validation
- CHECK constraints
- Cascade deletion
- Restrict deletion
- Data insertion
- Data updates
- JOIN queries
- Aggregate queries
- View queries
- Stored procedure execution
