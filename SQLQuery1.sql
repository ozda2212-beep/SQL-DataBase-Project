use MatchMe1

-- שאלה 1
select  U.userEmail,
		U.firstName+ ' ' + U.surName AS FullName,
		datediff(year,U.birthDate,GETDATE()) as Age
from userRelation R cross join  users U
where R.userEmail = U.userEmail and R.relationName like N'קשר לטווח ארוך'

-- שאלה 2

select  U.userEmail,
		U.firstName+ ' ' + U.surName AS FullName,
		datediff(year,U.birthDate,GETDATE()) as Age
from RegisteredTo R , users U
where R.userEmail = U.userEmail and
		datediff(year,R.registrationDate,GETDATE()) <=4
-- שאלה 3
select  U.userEmail,
		U.firstName+ ' ' + U.surName AS FullName,
		datediff(year,U.birthDate,GETDATE()) as Age
from RegisteredTo R , users U, App A 
where R.userEmail = U.userEmail and 
		A.appName = R.appName AND
		datediff(year,R.registrationDate,GETDATE()) <=4

--שאלה 4
SELECT userEmail
from users
where cityName like N'תל אביב'

union

select userEmail
from userRelation
where relationName like N'קשר פתוח'

--שאלה 5
select userEmailAddedTo
from list

intersect

select userEmail
from RegisteredTo
where appName like N'לאב מי'

-- שאלה 6

select userEmail
from users

except  

select userEmailAddTo
from list

-- שאלה 7

select userEmail
from userRelation
where relationName like N'קשר טווח ארוך'

intersect

(select userEmailAddTo
from list

union

select  userEmailAddedTo
from list)

except 

(select userEmailHate
from DoesntLike
intersect
select userEmailHated
from DoesntLike)




