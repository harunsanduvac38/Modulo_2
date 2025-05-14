-- todos lo departamentos con sus empleados

select *
from departamentos d
join empleados e on d.id_departamento = e.fk_departamento;

select id_departamento, departamento, count(id_empleado)
from departamentos d
left join empleados e on d.id_departamento = e.fk_departamento
group by id_departamento;


select id_departamento, departamento, count(id_empleado)
from departamentos d
left join empleados e on d.id_departamento = e.fk_departamento
where d.presupuesto >= 150000
group by id_departamento;

-- Datos de los departamentos y cantidad de empleados de aquellos departamentos..
-- con más de 1 empleado?

select id_departamento, departamento, count(id_empleado)
from departamentos d
left join empleados e on d.id_departamento = e.fk_departamento
group by id_departamento
having count(id_empleado) > 1;

