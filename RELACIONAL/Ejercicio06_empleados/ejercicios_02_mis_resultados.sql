-- base de datos xx_empleados
-- 1 Devuelve un listado con los empleados y los datos de los departamentos donde trabaja cada uno.
select e.id_empleado, e.nif, e.nombre, e.apellido1, e.apellido2, d.id_departamento, d.departamento, d.presupuesto, d.gastos
from empleados e
join departamentos d on e.fk_departamento = d.id_departamento
order by e.id_empleado;

-- 2 Devuelve un listado con los empleados y los datos de los departamentos donde trabaja cada uno. Ordena el resultado, en primer lugar por el nombre del departamento (en orden alfabético) y en segundo lugar por los apellidos y el nombre de los empleados.
select e.id_empleado, e.nif, e.nombre, e.apellido1, e.apellido2, d.id_departamento, d.departamento, d.presupuesto, d.gastos
from empleados e
join departamentos d on e.fk_departamento = d.id_departamento
order by d.departamento, e.apellido1, e.apellido2, e.nombre;

-- 3 Devuelve un listado con el código y el nombre del departamento, solamente de aquellos departamentos que tienen empleados.
select distinct d.id_departamento, d.departamento
from departamentos d
join empleados e on e.fk_departamento = d.id_departamento;

-- 4 Devuelve un listado con el código, el nombre del departamento y el valor del presupuesto actual del que dispone, solamente de aquellos departamentos que tienen empleados.
    -- El valor del presupuesto actual lo puede calcular restando al valor del presupuesto inicial (columna presupuesto) menos el valor de los gastos que ha generado (columna gastos).
    -- Verificar el resultado en el departamento I+D si es correcto.
    select d.id_departamento, d.departamento, cast(d.presupuesto as signed) - cast(d.gastos as signed) 'Presupuesto'
    from departamentos d
    join empleados e on e.fk_departamento = d.id_departamento;
-- 5 Devuelve el nombre del departamento donde trabaja el emplead
o que tiene el nif 38382980M.
select *
from empleados
where nif = '38382980M';
 
-- 6 Devuelve el nombre del departamento donde trabaja el empleado Pepe Ruiz Santana.
select *
from empleados
where (nombre, apellido1, apellido2) = ('Pepe', 'Ruiz', 'Santana');

-- 7 Devuelve un listado con los datos de los empleados que trabajan en el departamento de I+D. Ordena el resultado alfabéticamente.
select *
from empleados
where fk_departamento = 5
order by apellido1, apellido2, nombre;

-- 8 Devuelve un listado con los datos de los empleados que trabajan en el departamento de Sistemas, Contabilidad o I+D. Ordena el resultado alfabéticamente.
select *
from empleados
where fk_departamento in (2,4,5)
order by apellido1, apellido2, nombre;

-- 9 Devuelve una lista con el nombre de los empleados que tienen los departamentos que no tienen un presupuesto entre 100000 y 200000 euros.
select *
from empleados e
join departamentos d on e.fk_departamento = d.id_departamento and d.presupuesto not between 100000 and 200000;

-- 10 Devuelve un listado con el nombre de los departamentos donde existe algún empleado cuyo segundo apellido sea NULL. Tenga en cuenta que no debe mostrar nombres de departamentos que estén repetidos.
select distinct d.departamento, d.id_departamento
from departamentos d
join empleados e on e.fk_departamento = d.id_departamento and e.apellido2 is NULL;

-- ****Resuelva las siguientes consultas utilizando las cláusulas LEFT JOIN y RIGHT JOIN.***
-- 11 Devuelve un listado con todos los empleados junto con los datos de los departamentos donde trabajan. Este listado también debe incluir los empleados que no tienen ningún departamento asociado.
select *
from empleados e
left join departamentos d on e.fk_departamento = d.id_departamento;

-- 12 Devuelve un listado donde sólo aparezcan aquellos empleados que no tienen ningún departamento asociado.
select e.id_empleado, e.nif, e.nombre, e.apellido1, e.apellido2
from empleados e
left join departamentos d on e.fk_departamento = d.id_departamento 
where fk_departamento is NULL;

-- 13 Devuelve un listado donde sólo aparezcan aquellos departamentos que no tienen ningún empleado asociado.
select distinct d.id_departamento, d.departamento
from departamentos d
left join empleados e on e.fk_departamento = d.id_departamento
where e.fk_departamento is NULL;

-- 14 Devuelve un listado con todos los empleados junto con los datos de los departamentos donde trabajan. 
-- El listado debe incluir los empleados que no tienen ningún departamento asociado y los departamentos que no tienen ningún empleado asociado.
-- Ordene el listado alfabéticamente por el nombre del departamento.

(select *
from empleados e
left join departamentos d on e.fk_departamento = d.id_departamento)
union
(select *
from empleados e
right join departamentos d on e.fk_departamento = d.id_departamento)
order by departamento; 

-- 15 Devuelve un listado con los empleados que no tienen ningún departamento asociado y los departamentos que no tienen ningún empleado asociado. 
-- Ordene el listado alfabéticamente por el nombre del departamento.
(select *
from empleados e
left join departamentos d on e.fk_departamento = d.id_departamento
where e.fk_departamento is NULL)
union
(select *
from empleados e
right join departamentos d on e.fk_departamento = d.id_departamento
where e.fk_departamento is NULL)
order by departamento;
