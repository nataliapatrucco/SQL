-- crea tabla movies
CREATE TABLE MOVIES
(
    id INTEGER PRIMARY KEY,
    name TEXT default NULL,
    year INTEGER DEFAULT NULL,
    rank REAL DEFAULT NULL
);

--Crea tabla Actors
CREATE TABLE ACTORS
(
    id INTEGER PRIMARY KEY,
    first_name TEXT DEFAULT NULL,
    last_name TEXT DEFAULT NULL,
    gender TEXT DEFAULT NULL
);

--Crea tabla Roles
CREATE TABLE ROLES
(
    actor_id INTEGER,
    movie_id INTEGER,
    role_name TEXT DEFAULT NULL
);

--busca las pelis del 1902 con rank mayor a 5
SELECT name, year
FROM movies
WHERE year=1902 AND rank>5;

--Encontrá todas las películas hechas en el año que naciste.
SELECT name, year
FROM movies
WHERE year=1985;

--¿Cuantás películas tiene nuestra base de datos para el año 1982?
SELECT count(*)
from movies
WHERE year=1982;

--Encontrá los actores que tienen "stack" en su apellido.
SELECT id, first_name, last_name, gender
FROM ACTORS
WHERE last_name LIKE '%stack%';

--JUEGO DEL NOMBRE DE LA FAMA
--Todos queremos que nuestros hijos sean actores (…cierto), entonces ¿cúal es el mejor nombre y apellido para darles? ¿Cúales son los 10 nombres más populares? ¿Cúales son los 10 apellidos más populares? ¿Cuales son los full_names más populares (nombre y apellido)?
--Buscar el nombre mas popular
select COUNT(first_name), first_name
from actors
GROUP BY first_name
ORDER BY COUNT(first_name) DESC
LIMIT
10;

--Buscar el apellido mas popular
select COUNT
(last_name), last_name
from actors
GROUP BY first_name
ORDER BY COUNT
(last_name) DESC
LIMIT 10;

--Buscar el nombre/apellido mas popular
select COUNT
(*), a.first_name
, a.last_name
from actors as a
GROUP BY a.first_name, '' || '', a.last_name
ORDER BY COUNT
(*) DESC
LIMIT 10;

--Prolífico
--Listá el top 100 de actores más activos y el numero de roles que hayan participado.
SELECT first_name
AS Nombre, last_name  AS Apellido, COUNT
(*) AS count FROM actors 
    INNER JOIN roles as r
    on r.actor_id = actors.id
    GROUP by r.actor_id 
    ORDER BY count DESC
LIMIT 100;

--Fondo del Barril
--¿Cuántas películas tiene IMBD de cada género, ordenado por el género más popular?

SELECT genre, COUNT
(genre)
FROM movies_genres
    INNER JOIN movies as pelis
    on pelis.id = movie_id
GROUP BY genre
ORDER BY COUNT(genre) DESC;

--Braveheart
--Lista el nombre y apellido de todos los actores que actuaron en la película 'Braveheart' de 1995, ordenados alfabéticamente por sus apellidos.

SELECT first_name, last_name
FROM actors
    INNER JOIN roles
    on roles.actor_id = actors.id
    INNER JOIN movies
    on roles.movie_id = movies.id
WHERE name = 'Braveheart' AND year=1995
ORDER BY last_name ASC;

--Noir Bisiesto
--Listá todos los directores que dirigieron una película de género 'Film-Noir' en un año bisiesto (para este challenge hagamos de cuente que todos los años divisibles por 4 son años bisiestos - lo cual no es verdad en la vida real). Tu query debería retornar el nombre del director, el nombre de la película y el año, ordenado por el nombre de la película.

--movies = id, name, year, rank
--movies_genres = movie_id, genre
--directors_genres = director_id, genre, prob
--Directors = id, first_name, last_name

--movies where year%4 === 0
--genre = film-noir (movies_genres)
--nombre pelicula asc,nombre director, año pelicula

SELECT d.first_name, d.last_name, m.name, m.year
FROM movies AS m
    INNER JOIN movies_genres AS g
    on m.id = g.movie_id
    INNER JOIN movies_directors AS md
    on m.id = md.movie_id
    INNER JOIN directors AS d
    on md.director_id = d.id
WHERE m.year%4=0 AND g.genre='Film-Noir'
ORDER BY m.name ASC;


--° Bacon
--Lista todos los actores que han trabajado con Kevin Bacon en una película de Drama (incluí el nombre de la película). Por favor exluí al Sr. Bacon de los resultados.
--movies = id, name, year, rank
--movies_genres = movie_id, genre
--actors = id, first_name, last_name, gender
--roles = actor_id, movie_id, role

--movie actor = 
--movies_genres.genre = 'Drama'

SELECT m.name, actors.first_name, actors.last_name
FROM actors
    INNER JOIN roles
    on roles.actor_id = movies.id
    INNER JOIN movies
    on roles.movie_id = movies.id
WHERE movies.id IN (SELECT roles.movie_id
    from movies
        INNER JOIN roles
        on roles.movie_id = movies.id
        INNER JOIN actors
        on actors.id = roles.actor_id
        INNER JOIN movies_genres ON movies_genres.movie_id = movies.id
    WHERE movies_genres.genre = 'Drama' AND actors.first_name = 'Kevin' AND actors.last_name = 'Bacon'
    ORDER BY movies.name ASC)
    AND actors.first_name != 'Kevin' AND actors.last_name != 'Bacon'
ORDER BY movies.name;







