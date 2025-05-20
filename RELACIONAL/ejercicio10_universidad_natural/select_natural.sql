-- profesores con asignaturas que imparte, solo los que imparten asignaturas

select *
from profesores prof
join asignaturas asig on prof.id_profesor = asig.id_profesor;


select *
from profesores prof
natural join asignaturas;

-- todos los profesores con las asignaturas que imparten
select *
from profesores prof
natural left join asignaturas;