# SQL Practice - Ticket Booking System

## 📋 Overview

This project demonstrates SQL database design and query execution for a **Ticket Booking System**. It showcases essential database concepts including table creation, data insertion, relationships, joins, and complex queries.

## 🏗️ Database Schema

The system consists of three main tables:

### Database Structure
![Database Schema](https://github.com/Arun-DEV-prog/sql-practice/raw/main/schema-diagram.png)

**Users Table**
- Stores user information with role-based access
- `user_id` (PK): Unique identifier
- `full_name`: User's complete name
- `email`: Unique email address
- `role`: Enum type - 'Ticket Manager' or 'Football Fan'
- `phone_number`: Contact information

**Matches Table**
- Contains football match details and ticket information
- `match_id` (PK): Unique identifier
- `fixture`: Match details (e.g., "Real Madrid vs Barcelona")
- `tournament_category`: League/tournament name
- `base_ticket_price`: Starting price with validation (≥ 0)
- `match_status`: Enum - 'Available', 'Selling Fast', 'Sold Out', 'Postponed'

**Bookings Table**
- Tracks ticket reservations and payments
- `booking_id` (PK): Unique identifier
- `user_id` (FK): References Users table
- `match_id` (FK): References Matches table
- `seat_number`: Allocated seat
- `payment_status`: Enum - 'Pending', 'Confirmed', 'Cancelled', 'Refunded'
- `total_cost`: Booking amount with validation (≥ 0)

## 📊 Sample Data

**Users**: 4 football fans and ticket managers
**Matches**: 5 matches across different tournaments (Champions League, Premier League, Serie A)
**Bookings**: 5 bookings with various payment statuses

## 🔍 Queries Explained

### Query 1: Filter Matches by Tournament & Status
```sql
SELECT match_id, fixture, base_ticket_price
FROM matches
WHERE tournament_category = 'Champions League'
  AND match_status = 'Available';
```
**Purpose**: Find available matches in Champions League
**Learning**: Basic WHERE clause with AND operator

---

### Query 2: Search Users with ILIKE Pattern Matching
```sql
SELECT user_id, full_name, email
FROM users
WHERE full_name ILIKE 'Tanvir%'
  OR full_name ILIKE '%Haque%';
```
**Purpose**: Search users by name patterns (case-insensitive)
**Learning**: ILIKE for flexible text searching with OR conditions

---

### Query 3: Handle NULL Values with COALESCE
```sql
SELECT booking_id, user_id, match_id, 
       COALESCE(payment_status, 'Action Required') 
FROM bookings
WHERE payment_status IS NULL;
```
**Purpose**: Find incomplete bookings and provide default values
**Learning**: COALESCE function for NULL handling, IS NULL operator

---

### Query 4: INNER JOIN Multiple Tables
```sql
SELECT b.booking_id, u.full_name, m.fixture, b.total_cost
FROM bookings b
INNER JOIN users u ON b.user_id = u.user_id 
INNER JOIN matches m ON b.match_id = m.match_id;
```
**Purpose**: Combine booking, user, and match information
**Learning**: Multiple INNER JOINs for related data, table aliasing

---

### Query 5: LEFT JOIN for Complete User List
```sql
SELECT u.user_id, u.full_name, b.booking_id 
FROM users u
LEFT JOIN bookings b ON u.user_id = b.user_id;
```
**Purpose**: Display all users with their bookings (if any)
**Learning**: LEFT JOIN preserves all left table records, even without matches

---

### Query 6: Subquery with Aggregate Functions
```sql
SELECT b.booking_id, m.match_id, b.total_cost 
FROM bookings b
INNER JOIN matches m ON b.match_id = m.match_id
WHERE b.total_cost > (
  SELECT AVG(total_cost)
  FROM bookings
);
```
**Purpose**: Find bookings above average cost
**Learning**: Subqueries, AVG() aggregate function, comparison with calculated values

---

### Query 7: ORDER BY with LIMIT & OFFSET
```sql
SELECT match_id, fixture, base_ticket_price
FROM matches
ORDER BY base_ticket_price DESC
LIMIT 2 OFFSET 1;
```
**Purpose**: Get 2nd and 3rd most expensive matches
**Learning**: Sorting (DESC), pagination with LIMIT and OFFSET

---

## 🎓 What I Learned

### SQL Fundamentals
✅ **Database Creation**: Creating custom types (ENUM), tables with constraints
✅ **Data Insertion**: INSERT statements with multiple rows
✅ **Data Constraints**: PRIMARY KEY, FOREIGN KEY, UNIQUE, CHECK, NOT NULL

### Query Techniques
✅ **WHERE Clauses**: Filtering with AND/OR operators
✅ **Pattern Matching**: ILIKE for case-insensitive text searches
✅ **NULL Handling**: IS NULL, COALESCE function
✅ **JOIN Operations**: INNER JOIN, LEFT JOIN, multiple joins
✅ **Table Aliasing**: Using aliases (b, u, m) for cleaner queries
✅ **Subqueries**: Nested SELECT statements for complex logic
✅ **Aggregate Functions**: AVG(), SUM() (implicitly used)
✅ **Sorting & Pagination**: ORDER BY, LIMIT, OFFSET

### Advanced Concepts
✅ **Referential Integrity**: Foreign keys maintaining data relationships
✅ **ENUM Data Types**: Custom types for restricted values
✅ **Data Validation**: CHECK constraints for business rules
✅ **Query Optimization**: Joining related tables efficiently

## 🛠️ Technologies Used
- **Database**: PostgreSQL
- **Language**: SQL (T-SQL variant)

## 📁 File Structure
```
sql-practice/
├── README.md          (This file)
├── query.sql          (All database setup and queries)
└── schema-diagram.png (Database relationship diagram)
```

## 🚀 How to Use

1. **Create the database**: Run the CREATE DATABASE statement
2. **Create tables**: Execute the CREATE TABLE statements
3. **Insert data**: Run all INSERT statements
4. **Execute queries**: Run any of the 7 queries to see results

## 💡 Key Takeaways

| Concept | Application |
|---------|------------|
| **Relationships** | Users, Matches, and Bookings are connected through foreign keys |
| **Data Integrity** | Constraints ensure valid data (prices ≥ 0, valid payment statuses) |
| **Flexible Searching** | ILIKE provides case-insensitive text matching |
| **Complex Analysis** | Subqueries enable average calculations and comparisons |
| **Data Completeness** | LEFT JOIN shows all users regardless of booking status |
| **Efficient Retrieval** | LIMIT/OFFSET enables pagination for large datasets |

## 📝 Notes

- All queries are production-ready with proper error handling through constraints
- NULL values in bookings indicate incomplete reservations
- The system supports role-based access through the role ENUM type
- Real-world extensions could include timestamps, cancellation reasons, and discount codes

---

**Created**: June 2026
**Author**: Arun-DEV-prog
