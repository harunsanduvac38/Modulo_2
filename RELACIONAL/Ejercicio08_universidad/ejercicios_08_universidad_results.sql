-- *** BBDD 06_universidad ***
use 06_universidad;

-- 01 Obtener el nombre completo de los alumnos que estén cursando "Matematica Discreta"
select al.id_alumno, al.nombre, al.apellido1, al.apellido2, notas.asignatura, notas.nota
from alumnos al
join (select * from notas as notas join asignaturas asi on asi.id_asignatura = notas.fk_asignatura) notas 
on al.id_alumno = notas.fk_alumno
where notas.asignatura = 'matematica discreta';

select al.id_alumno, al.nombre, concat(al.apellido1, ' ', al.apellido2) apellidos, asi.asignatura
from alumnos al
join asignaturas asi
join notas on al.id_alumno = notas.fk_alumno and notas.fk_asignatura = asi.id_asignatura 
where asignatura = 'matematica discreta';


-- 02 Obtener el nombre completo y la nota obtenida de los alumnos que hayan cursado "Matematica Discreta"
select al.id_alumno, al.nombre, concat(al.apellido1, ' ', al.apellido2) apellidos
from alumnos al
join (select * from notas notas join asignaturas asi on asi.id_asignatura = notas.fk_asignatura) notas 
on al.id_alumno = notas.fk_alumno
where notas.asignatura = 'matematica discreta' and notas.nota is not null;

select al.id_alumno, al.nombre, concat(al.apellido1, ' ', apellido2) apellidos, asi.asignatura
from alumnos al
join asignaturas asi
join notas on al.id_alumno = notas.fk_alumno and notas.fk_asignatura = asi.id_asignatura
where asignatura = 'matematica discreta' and notas.nota is not null;


-- 03 Obtener el listado de profesores de la Factultad de "Informatica"
select *
from profesores prof
join asignaturas asi on asi.fk_profesor = prof.id_profesor
where facultad = 'Informatica';

-- 04 Obtener la cantidad de alumnos por ciudad
select ciudad, count(id_alumno) cant_alumno
from alumnos 
group by ciudad;

-- 05 Obtener el nombre completo y edad de todos los alumnos
select id_alumno, nombre, concat (apellido1, ' ', apellido2) apellidos, timestampdiff(year, alumnos.fecha_nacimiento, now()) edad
from alumnos; 

-- 06 Obtener las edades de los alumnos que cursan asignaturas
select id_alumno, nombre, apellido1, apellido2, timestampdiff(year, alumnos.fecha_nacimiento, now()) edad
from alumnos
join notas on id_alumno = fk_alumno and nota is not null
group by id_alumno;

-- 07 Obtener las notas medias de los alumnos por edad
select timestampdiff(year, alumnos.fecha_nacimiento, now()) edad, truncate(avg(notas.nota),2)
from alumnos
join notas on id_alumno = fk_alumno
group by edad;

-- 08 Cantidad de alumnos matriculados en más de dos asignaturas
select id_alumno, count(notas.fk_asignatura) cant_alum
from alumnos al
join notas on notas.fk_alumno = al.id_alumno
group by fk_alumno
having cant_alum > 2;


-- 09 Obtener los datos de los alumnos que no cursan ninguna asignatura ni tienen ninguna nota
select *
from alumnos
left join notas on fk_alumno = id_alumno
where fk_asignatura is null and nota is null;

-- 10 Cantidad de notas y media de notas de cada alumno
select id_alumno, dni, nombre, apellido1, apellido2, count(notas.nota) cantidad, truncate(avg(notas.nota),2)
from alumnos
join notas on id_alumno = notas.fk_alumno
group by id_alumno;

-- 11 Listado de profesores con la cantidad de asignaturas que imparte cada uno de ellos, aunque ahora no estén impartiendo ninguna.
select id_profesor, nombre, apellido1, apellido2, nro_cuenta, count(asig.id_asignatura) cant_asig
from profesores
left join asignaturas asig on asig.fk_profesor = id_profesor
group by id_profesor;


-- 12 Notas medias por asignaturas que imparte cada profesor
select asig.id_asignatura, asig.asignatura, prof.id_profesor, prof.nombre, concat(prof.apellido1, ' ', prof.apellido2) apellidos, truncate(avg(notas.nota),2)
from profesores prof
join asignaturas asig on asig.fk_profesor = prof.id_profesor
join notas on notas.fk_asignatura = asig.id_asignatura
group by asig.id_asignatura;

-- 13 Mostrar, de la Asignatura “Programacion I”, la nota máxima, mínima y la diferencia entre ambas. 
select id_asignatura, asignatura, max(nota) maximo_nota, min(nota) minimo_nota, (max(nota) - min(nota)) diferencia
from asignaturas
join notas on fk_asignatura = id_asignatura
where asignatura = 'Programacion I'
group by id_asignatura;

-- 14 Devolver también el número de alumnos que la han cursado.
select asig.id_asignatura, asig.asignatura, max(notas.nota) max_nota, min(notas.nota) min_nota, (max(notas.nota) - min(notas.nota)) diferencia, count(al.id_alumno)
from asignaturas asig
join notas on notas.fk_asignatura = asig.id_asignatura
join alumnos al on notas.fk_alumno = al.id_alumno
where asig.asignatura = 'programacion I'
group by asig.id_asignatura;

select asig.id_asignatura, asig.asignatura, max(notas.nota) max_nota, min(notas.nota) min_nota, (max(notas.nota) - min(notas.nota)) diferencia, count(notas.fk_alumno) cant_alumnos
from asignaturas asig
join notas on notas.fk_asignatura = asig.id_asignatura
where asig.asignatura = 'programacion I'
group by asig.id_asignatura;

-- 15 Obtener de Cada profesor las asignaturas que imparte, con los alumnos en cada una de ellas y su nota
select prof.id_profesor, prof.dni, prof.nombre, prof.apellido1, prof.apellido2, asig.asignatura, al.id_alumno, al.dni, al.nombre, concat(al.apellido1, ' ', al.apellido2) apellidos, notas.nota
from profesores prof
join asignaturas asig on asig.fk_profesor = prof.id_profesor
join notas on notas.fk_asignatura = asig.id_asignatura
join alumnos al on al.id_alumno = notas.fk_alumno;


-- *** Subconsultas ***
-- 16 Cantidad de alumnos aprobados por ciudad, usando una subconsulta
select count()
from alumnos
join notas on id_alumno = fk_alumno
where nota (

-- 17 Notas de las asignaturas de cada uno de los alumnos comparada con la nota media de la asignatura

-- 18 Alumnos que están cursando asignaturas con los profesores de Málaga (subconsulta en JOIN)

-- 19 Nota media por asignatura, sólo aquéllas que la nota media sea mayor a la nota media del alumnos con dni 55630078R
