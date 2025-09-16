use MatchMe1

USE MatchMe1;
GO

/* 1) Users preferring long-term relationships + computed age */
SELECT  U.userEmail,
        U.firstName + ' ' + U.surName AS FullName,
        DATEDIFF(YEAR, U.birthDate, GETDATE()) AS Age
FROM users AS U
JOIN userRelation AS R
  ON R.userEmail = U.userEmail
WHERE R.relationName = N'קשר לטווח ארוך';
GO

/* 2) Users registered in the last 4 years (deduplicated per user, any app) */
SELECT DISTINCT
       U.userEmail,
       U.firstName + ' ' + U.surName AS FullName,
       DATEDIFF(YEAR, U.birthDate, GETDATE()) AS Age
FROM RegisteredTo AS R
JOIN users AS U
  ON R.userEmail = U.userEmail
WHERE DATEDIFF(YEAR, R.registrationDate, GETDATE()) <= 4;
GO

/* 3) Same as (2) but including app name */
SELECT DISTINCT
       U.userEmail,
       U.firstName + ' ' + U.surName AS FullName,
       DATEDIFF(YEAR, U.birthDate, GETDATE()) AS Age,
       A.appName
FROM RegisteredTo AS R
JOIN users AS U
  ON R.userEmail = U.userEmail
JOIN App AS A
  ON A.appName = R.appName
WHERE DATEDIFF(YEAR, R.registrationDate, GETDATE()) <= 4;
GO

/* 4) Users from Tel Aviv OR with 'open relationship' */
SELECT userEmail
FROM users
WHERE cityName = N'תל אביב'
UNION
SELECT userEmail
FROM userRelation
WHERE relationName = N'קשר פתוח';
GO

/* 5) Users who appear in lists AND are registered to "Love Me" */
SELECT userEmailAddedTo
FROM list
INTERSECT
SELECT userEmail
FROM RegisteredTo
WHERE appName = N'לאב מי';
GO

/* 6) Users who were NEVER added to any list */
SELECT U.userEmail
FROM users AS U
EXCEPT
SELECT L.userEmailAddedTo
FROM list AS L;
GO

/* 7) Long-term pref + appeared in lists (adder/added), EXCLUDING mutual hate */
WITH MutualHate AS (
  SELECT d1.userEmailHate AS A, d1.userEmailHated AS B
  FROM DoesntLike d1
  JOIN DoesntLike d2
    ON d2.userEmailHate  = d1.userEmailHated
   AND d2.userEmailHated = d1.userEmailHate
),
ListUsers AS (
  SELECT userEmailAddedTo AS userEmail FROM list
  UNION
  SELECT userEmailAddTo  AS userEmail FROM list  -- אם אצלך כך נקרא העמודה, מומלץ לאחד לשם אחד בטבלה
)
SELECT ur.userEmail
FROM userRelation ur
WHERE ur.relationName = N'קשר טווח ארוך'
  AND ur.userEmail IN (SELECT userEmail FROM ListUsers)
EXCEPT
SELECT A FROM MutualHate
EXCEPT
SELECT B FROM MutualHate;
GO






