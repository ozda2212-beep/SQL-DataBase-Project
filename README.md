# SQL-DataBase-Project
SQL queries for the MatchMe1 schema – exercises on joins, set operations, and data analysis
# SQL Exercises – MatchMe1

This repository contains solutions for a set of SQL query exercises based on the **MatchMe1** schema.  
The tasks cover key SQL topics such as filtering, joins, set operations, and handling mutual relationships.

---

## 📂 Files
- `sql/solutions.sql` – contains all solutions (Q1–Q7), written with clean SQL and comments.
- *(Optional)* `docs/assignment.pdf` – original assignment instructions (for reference only).

---

## 📝 Exercise Highlights
- Selecting users by relationship preferences and calculating age with `DATEDIFF`.
- Filtering users registered in the last 4 years across multiple applications.
- Using `UNION`, `INTERSECT`, and `EXCEPT` to combine and filter datasets.
- Identifying users not included in any list (set difference).
- Detecting **mutual hate relationships** with a self-join query.
- Ensuring consistent column names and explicit `JOIN` syntax for clarity.

---

## 🚀 How to Run
1. Open SQL Server Management Studio (SSMS) or Azure Data Studio.
2. Connect to your database and ensure the `MatchMe1` schema is available.
3. Run the queries from `sql/solutions.sql`.

---

## 🔍 Example Query (Q1)
```sql
SELECT  U.userEmail,
        U.firstName + ' ' + U.surName AS FullName,
        DATEDIFF(YEAR, U.birthDate, GETDATE()) AS Age
FROM users AS U
JOIN userRelation AS R
  ON R.userEmail = U.userEmail
WHERE R.relationName = N'קשר לטווח ארוך';
