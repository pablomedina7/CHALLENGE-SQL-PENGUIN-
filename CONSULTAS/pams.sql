--Primer Ejercicio 
SELECT TOP (200) DisplayName, Location, Reputation 
from Users
Order BY Reputation DESC; 

--Segundo Ejercicio 
SELECT TOP (200) Posts.Title, Users.DisplayName
FROM Posts
INNER JOIN Users ON Posts.OwnerUserId = Users.Id;

-- Tercer Ejercicio (calcular el promedio)
SELECT TOP (200) Users.DisplayName, AVG(Posts.Score) AS AverageScore
FROM Posts
INNER JOIN Users ON Posts.OwnerUserId = Users.Id
WHERE Posts.OwnerUserId IS NOT NULL
GROUP BY Users.DisplayName
ORDER BY AverageScore DESC;

-- CUARTO EJERCICIO
SELECT u.DisplayName
FROM dbo.Users u
WHERE (SELECT COUNT(*) FROM dbo.Comments c WHERE c.UserId = u.Id) > 100;


-- Quinto Ejercicio
UPDATE Users
SET Location = 'desconocido'
WHERE Location IS NULL OR TRIM(Location) = ''

PRINT 'La actualizacion se realizo correctamente. Se actualizaron' + CAST(@@ROWCOUNT AS VARCHAR(10)) + 'filas.'

-- Para visualizar
SELECT TOP (200) Displayname, Location 
FROM Users
WHERE Location = 'desconocido'
ORDER BY DisplayName

-- Ejercicio 6
DELETE Comments
FROM Comments
JOIN Users On Comments.UserId = Users.Id
WHERE Users.Reputation < 100;

DECLARE @DeletedCount INT;
SET @DeletedCount = @@ROWCOUNT;
PRINT CAST(@DeletedCount AS VARCHAR) + ' comentarios fueron eliminados.';


--septimo ejercicio 
SELECT TOP (200) u.DisplayName, 
    ISNULL(p.TotalPosts, 0) AS TotalPosts,
    ISNULL(c.TotalComments, 0) AS TotalComments,
    ISNULL(b.TotalBadges, 0) AS TotalBadges
FROM dbo.Users u
LEFT JOIN (
    SELECT OwnerUserId, COUNT(*) AS TotalPosts
    FROM dbo.Posts
    GROUP BY OwnerUserId
) p ON u.Id = p.OwnerUserId
LEFT JOIN (
    SELECT UserId, COUNT(*) AS TotalComments
    FROM dbo.Comments
    GROUP BY UserId
) c ON u.Id = c.UserId
LEFT JOIN (
    SELECT UserId, COUNT(*) AS TotalBadges
    FROM dbo.Badges
    GROUP BY UserId
) b ON u.Id = b.UserId
ORDER BY TotalBadges Desc ; 

--Octavo ejercicio 
SELECT Title, Score
FROM dbo.Posts
ORDER BY Score DESC
OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY;

--noveno ejercicio 
SELECT Text, CreationDate
FROM dbo.Comments
ORDER BY CreationDate DESC
OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY;