-- JOINS

-- INSCRIPCIONES POR CURSOS

SELECT *
FROM studentXcourses sc
    JOIN student s
    ON s.id = sc.studentId
    JOIN course c
    ON c.id = sc.courseId;

-- TODOS LOS ALUMNOS QUE FUERON AL BOOT

SELECT *
FROM student s
    JOIN studentXcourses sc
    ON sc.studentId = s.id

WHERE sc.courseId = 1;
-- AGREGACION

-- CANTIDAD DE ALUMNOS

SELECT count(*)
FROM student;

-- CANTIDAD ALUMNOS QUE FUERON AL BOOTCAMP
SELECT count(*)
FROM student s
    JOIN studentXcourses sc
    ON sc.studentId = s.id
WHERE sc.courseId = 1;

-- EDAD PROMEDIO

SELECT avg(age)
FROM student;

--# GROUP BY

-- CANTIDAD DE ALUMNOS POR CURSO

SELECT count(*), c.name
FROM course c
    JOIN studentXcourses sc
    ON sc.courseId = c.id
GROUP BY c.name;

-- ORDEN DE QUERY

SELECT DISTINCT column, AGG_FUNC(column_or_expression)
FROM mytable
    JOIN another_table
    ON mytable.column = another_table.column

WHERE constraint_expression
GROUP BY column
HAVING constraint_expression
ORDER BY column ASC
/DESC
LIMIT count OFFSET COUNT;