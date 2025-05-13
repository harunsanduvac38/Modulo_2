 -- Datos del jefe maximo (Jefazo)
 select *
 from empleados
 where fk_jefe is null;
 
 -- Datod de los Directores Generales (Dependen del Jefazo), conociendo el id del jefazo
 
 select *
 from empleados
 where fk_jefe = 2;
 
 -- Datos de todos los empleados con el nombre de su jefe
 
 select *
 from empleados emp
 join empleados jefes on emp.fk_jefe = jefes.idempleados;
 
 
 
 
 
 