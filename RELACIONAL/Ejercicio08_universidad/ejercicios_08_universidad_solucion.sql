-- *** BBDD 06_universidad ***

-- 1 Obtener el nombre completo de los alumnos que estén cursando "Matematica Discreta"
select alu.id_alumno, alu.apellido1, alu.apellido2, alu.nombre
from alumnos alu
join notas n on alu.id_alumno = n.fk_alumno
join asignaturas asig on n.fk_asignatura = asig.id_asignatura
where asig.asignatura = 'matematica discreta';

-- 2 Obtener el nombre completo y la nota obtenida de los alumnos que hayan cursado "Matematica Discreta"
select alu.id_alumno, alu.apellido1, coalesce(alu.apellido2, 'NO TIENE'), alu.nombre, n.nota
from alumnos alu
join notas n on alu.id_alumno = n.fk_alumno
join asignaturas asig on n.fk_asignatura = asig.id_asignatura
where asig.asignatura = 'matematica discreta';

-- 3 Obtener el listado de profesores de la Factultad de "Informatica"
select distinct profesores.*
from profesores
join asignaturas on fk_profesor = id_profesor
where facultad = 'informatica';

-- 4 Obtener la cantidad de alumnos por ciudad
select ciudad, count(*)
from alumnos
group by ciudad;

-- 5 Obtener el nombre completo y edad de todos los alumnos
		-- Cómo obtener años transcurridos entre dos fechas
		set @fecha_nac = '2000-05-16';
		-- correcto para calcular edad
		select now(), @fecha_nac, timestampdiff(year, @fecha_nac,  now());

		-- no da exacto, es aproximado
		select now(), @fecha_nac, truncate((datediff(now(), @fecha_nac) / 365.25), 0);

select id_alumno, concat(apellido1, ' ', coalesce(apellido2, ''), ', ', nombre) nombre, timestampdiff(year, fecha_nacimiento,  now()) edad
from alumnos;

-- 6 Obtener las edades de los alumnos que cursan asignaturas
select distinct timestampdiff(year, fecha_nacimiento,  now()) edad
from alumnos
join notas on id_alumno = fk_alumno
order by edad;

-- 7 Obtener las notas medias de los alumnos por edad
select distinct timestampdiff(year, fecha_nacimiento,  now()) edad, round(avg(nota), 2)
from alumnos
join notas on id_alumno = fk_alumno
group by edad
order by edad;

-- 8 Cantidad de alumnos matriculados en más de dos asignaturas
	-- cantidad de matriculas por alumno
    select fk_alumno, count(*) cant
    from notas
    group by fk_alumno;

	-- cantidad de matriculas por alumno de los que cursan mas de dos
    select fk_alumno, count(*) cant
    from notas
    group by fk_alumno
    having cant > 2;

select count(*)
from (select fk_alumno, count(*) cant
      from notas
      group by fk_alumno
      having cant > 2
      ) cursado;

-- 9 Obtener los datos de los alumnos que no cursan ninguna asignatura ni tienen ninguna nota
select alu.*
from alumnos alu
left join notas n on alu.id_alumno = n.fk_alumno
where n.fk_alumno is null;

select *
from alumnos
where id_alumno != all (select distinct fk_alumno from notas);
   --  != all   es lo mismo que   not in

-- 10 Cantidad de notas y media de notas de cada alumno
select alu.*, count(n.nota) cant_notas, avg(n.nota) nota_media
from alumnos alu
join notas n on alu.id_alumno = n.fk_alumno
group by alu.id_alumno;

-- 11 Listado de profesores con la cantidad de asignaturas que imparte cada uno de ellos, aunque ahora no estén impartiendo ninguna.
select profesores.*, count(id_asignatura) cant
from profesores
left join asignaturas on id_profesor = fk_profesor
group by id_profesor
order by cant desc;

-- 12 Notas medias por asignaturas que imparte cada profesor
select p.*, a.*, avg(n.nota) nota_media
from profesores p
join asignaturas a on p.id_profesor = a.fk_profesor
join notas n on a.id_asignatura = n.fk_asignatura
where n.nota is not null
group by p.id_profesor, a.id_asignatura
order by p.id_profesor, a.id_asignatura;

-- 13 Mostrar, de la Asignatura “Programacion I”, la nota máxima, mínima y la diferencia entre ambas. 
   -- Devolver también el número de alumnos que la han cursado.
select id_asignatura, asignatura, max(nota) nota_maxima, min(nota) nota_minima, max(nota)-min(nota) dif, count(distinct fk_alumno) cant_alu
from asignaturas
join notas on id_asignatura = fk_asignatura
where asignatura = 'Programacion I' and nota is not null
group by id_asignatura;

-- 14 Obtener de Cada profesor las asignaturas que imparte, con los alumnos en cada una de ellas y su nota
select p.id_profesor, p.apellido1, a.id_asignatura, a.asignatura, alu.id_alumno, alu.apellido1, n.nota
from profesores p
join asignaturas a on p.id_profesor = a.fk_profesor
join notas n on a.id_asignatura = n.fk_asignatura
join alumnos alu on n.fk_alumno = alu.id_alumno
order by p.id_profesor, a.id_asignatura, alu.id_alumno;

-- *** Subconsultas ***
-- 15 Cantidad de alumnos aprobados por ciudad, usando una subconsulta (no cantidad de asignaturas aprobadas por cada alumno)
	-- alumnos diferentes que han aprobado
    select distinct fk_alumno
    from notas
    where nota >= 5;

select ciudad, count(id_alumno) cant
from alumnos
where id_alumno in (select distinct fk_alumno
					from notas
					where nota >= 5)
group by ciudad;

	-- sin subconsulta
    select ciudad, count(distinct id_alumno) cant
    from alumnos
    join notas on id_alumno = fk_alumno
    where nota >= 5
    group by ciudad;

-- 16 Notas de las asignaturas de cada uno de los alumnos comparada con la nota media de la asignatura
	-- nota media de cada asignatura
    select fk_asignatura, avg(nota) media
    from notas
    group by fk_asignatura;
    
    select alu.id_alumno, alu.apellido1, a.id_asignatura, a.asignatura, n.nota, medias.media
    from alumnos alu
    join notas n on alu.id_alumno = n.fk_alumno
    join asignaturas a on n.fk_asignatura = a.id_asignatura
    join (select fk_asignatura, avg(nota) media
		  from notas
		  group by fk_asignatura) medias on n.fk_asignatura = medias.fk_asignatura
	where n.nota is not null;

-- 17 Alumnos que están cursando asignaturas con los profesores de Málaga (subconsulta en JOIN)
	-- profesores de Malaga
    select id_profesor
    from profesores
    where ciudad = 'Malaga';
    
    -- asignaturas de profesores de Malaga
    select id_asignatura
    from asignaturas
    where fk_profesor in (select id_profesor
    from profesores
    where ciudad = 'Malaga');
    
    select distinct alumnos.*
    from alumnos
    join notas n on id_alumno = n.fk_alumno
    join (select id_asignatura
		 from asignaturas
		 where fk_profesor in (select id_profesor
								from profesores
		                         where ciudad = 'Malaga')) asigs on n.fk_asignatura = asigs.id_asignatura;

-- 18 Nota media por asignatura, sólo aquéllas que la nota media sea mayor a la nota media del alumnos con dni 55630078R
	-- Nota media del alumno (subconsulta escalar para usar en el having)
    select avg(nota) media
    from notas
    join alumnos on fk_alumno = id_alumno
    where dni = '55630078R';
    
    select id_asignatura, asignatura, avg(nota) media
    from asignaturas
    join notas on id_asignatura = fk_asignatura
    group by id_asignatura
    having media > (select avg(nota) media
					from notas
					join alumnos on fk_alumno = id_alumno
					where dni = '55630078R');
    
    
