--Primer Ejercicio 
SELECT TOP (200) DisplayName, Location, Reputation 
from Users
Order BY Reputation DESC; 

--Segundo Ejercicio (titulo de publicaciones)
SELECT TOP (200) Posts.Title, Users.DisplayName
FROM Posts  --se utilizan datos de la tabla posts 
INNER JOIN Users ON Posts.OwnerUserId = Users.Id;  --se hace la union interna

-- Tercer Ejercicio (calcular el promedio)
SELECT TOP (200) Users.DisplayName, AVG(Posts.Score) AS AverageScore
FROM Posts
INNER JOIN Users ON Posts.OwnerUserId = Users.Id
WHERE Posts.OwnerUserId IS NOT NULL
GROUP BY Users.DisplayName
ORDER BY AverageScore DESC;

--CUARTO EJERCICIO  (encontrar usuarios con mas de 100 comments )
SELECT TOP (200) Users.DisplayName
FROM Users
WHERE Users.Id IN (         --se filtran de acuerdo a los requerimientos id-consulta
    SELECT Comments.UserId
    FROM Comments
    GROUP BY Comments.UserId
    HAVING COUNT(Comments.Id) > 100
)
ORDER BY Users.DisplayName, Users.Id; 


-- Quinto Ejercicio ()
UPDATE Users            --se actualiza 
SET Location = 'desconocido'
WHERE Location IS NULL OR TRIM(Location) = ''

PRINT 'La actualizacion se realizo correctamente. Se actualizaron' + CAST(@@ROWCOUNT AS VARCHAR(10)) + 'filas.' --convierte el numero de filas a cadena de txt

-- Para visualizar
SELECT TOP (200) Displayname, Location 
FROM Users
WHERE Location = 'desconocido'
ORDER BY DisplayName

-- Ejercicio 6 (elimina comentarios de usuarios con reputacion menos de 100 )
DELETE Comments
FROM Comments
JOIN Users On Comments.UserId = Users.Id    --asocia cada comentaerio con su usuario 
WHERE Users.Reputation < 100;

DECLARE @DeletedCount INT;   
SET @DeletedCount = @@ROWCOUNT;     --devuelve el numero de filas afectadas 
PRINT CAST(@DeletedCount AS VARCHAR) + ' comentarios fueron eliminados.'; 


-- Septimo ejercicio 
-- Seleccionar el DisplayName del usuario y contar el número de posts, comentarios y medallas
SELECT TOP 200
    u.DisplayName,
    (SELECT COUNT(*) FROM Posts WHERE OwnerUserId = u.Id) AS TotalPosts, --cuenta el numero de posts
    (SELECT COUNT(*) FROM Comments WHERE UserId = u.Id) AS TotalComments, -- total de commentarios 
    (SELECT COUNT(*) FROM Badges WHERE UserId = u.Id) AS TotalBadges -- total medals 
FROM 
    Users u     --se utiliza el alias
ORDER BY 
    TotalPosts DESC, u.DisplayName;


--Octavo ejercicio (titulos y puntuaciones)
SELECT Title, Score
FROM dbo.Posts
ORDER BY Score DESC
OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY;

--noveno ejercicio  (textos y date de los comments)
SELECT Text, CreationDate
FROM dbo.Comments
ORDER BY CreationDate DESC
OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY;