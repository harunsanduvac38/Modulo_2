-- *** BBDD 09_jardineria ***
use 10_jardineria;
-- 1 Devuelve el nombre de los clientes que no hayan hecho pagos y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.

select cli.id_cliente, cli.nombre_cliente, cli.nombre_contacto, emp.id_empleado, emp.nombre respresentate, ofi.id_oficina, ofi.ciudad ciudad_representante
from clientes cli
join empleados emp on emp.id_empleado = cli.fk_empleado_rep_ventas
join oficinas ofi on ofi.id_oficina = emp.fk_oficina
where not exists(select * from pagos where fk_cliente = cli.id_cliente)
;

-- 2 Devuelve un listado que muestre los clientes que no han realizado ningún pago y los que no han realizado ningún pedido.

select cli.id_cliente, cli.nombre_cliente, cli.nombre_contacto, cli.apellido_contacto
from clientes cli
left join pagos pag on pag.fk_cliente = cli.id_cliente
left join pedidos ped on ped.fk_cliente = cli.id_cliente
where pag.fk_cliente is null and ped.fk_cliente is null;

-- 3 Devuelve un listado que muestre solamente los clientes que sí han realizado algún pago.

select cli.id_cliente, cli.nombre_cliente, cli.nombre_contacto, cli.apellido_contacto
from clientes cli
where exists (select * from pagos where fk_cliente = cli.id_cliente);

-- 4 Calcula el número de clientes que tiene la empresa.

select count(*) clientes
from clientes cli;


-- 5 Devuelve el nombre del producto que tenga el precio de venta más caro.

select pro.*
from productos pro
where pro.precio_venta = (select max(precio_venta) from productos);

select pro.*
from productos pro
where pro.precio_venta >= all(select precio_venta from productos);


-- 6 Devuelve un listado indicando todas las ciudades donde hay oficinas y el número de empleados que tiene.

select ofi.ciudad, count(emp.id_empleado) cant_empleados
from oficinas ofi
left join empleados emp on emp.fk_oficina = ofi.id_oficina
group by ofi.ciudad;


-- 7 Devuelve un listado con el código de pedido, código de cliente, fecha esperada y 
--   fecha de entrega de los pedidos que no han sido entregados a tiempo.

select ped.id_pedido, cli.id_cliente, ped.fecha_esperada, ped.fecha_entrega
from pedidos ped
join clientes cli on ped.fk_cliente = cli.id_cliente
where ped.fecha_esperada != ped.fecha_entrega and ped.estado = 'entregado';

-- 8 Devuelve un listado de los productos que nunca han aparecido en un pedido.

select pro.*
from productos pro
left join detalles_pedido det on det.fk_producto = pro.id_producto
where det.fk_pedido is null;


-- 9 Calcula el número de clientes que no tiene asignado representante de ventas.

select count(*)
from clientes cli
where fk_empleado_rep_ventas is null;

-- 10 Devuelve un listado con el nombre, apellidos y puesto de aquellos empleados que no sean representantes de ventas.

select emp.id_empleado, emp.nombre, concat(emp.apellido1, coalesce(emp.apellido2, ' ')) apellidos, emp.puesto
from empleados emp
left join clientes cli on cli.fk_empleado_rep_ventas = emp.id_empleado
where cli.fk_empleado_rep_ventas is null;

select emp.id_empleado, emp.nombre, concat(emp.apellido1, coalesce(emp.apellido2, ' ')) apellidos, emp.puesto
from empleados emp
left join clientes cli on cli.fk_empleado_rep_ventas = emp.id_empleado
where not exists (select * from clientes where fk_empleado_rep_ventas = emp.id_empleado);


-- 11 Devuelve un listado con todos los clientes que sean de la ciudad de Madrid y 
   -- cuyo representante de ventas tenga el código de empleado 11 o 30.

select cli.*
from clientes cli
join empleados emp on emp.id_empleado = cli.fk_empleado_rep_ventas
where cli.ciudad = 'Madrid' and (emp.id_empleado = 11 or emp.id_empleado = 30);

-- 12 Devuelve el nombre del puesto, nombre, apellidos y email del jefe de la empresa.

select emp.id_empleado, emp.nombre, concat(apellido1, coalesce(apellido2, ' ')), emp.email, emp.puesto
from empleados emp
where fk_jefe is null;

-- 13 Devuelve un listado con los clientes que han realizado algún pedido pero no han realizado ningún pago, 
    -- utilizando una subconsulta
    
select cli.*, ped.*
from clientes cli
join pedidos ped on ped.fk_cliente = cli.id_cliente
where cli.id_cliente != ALL (select fk_cliente from pagos);
    
    
-- 14 Devuelve un listado con todos los pagos que se realizaron en el año 2008 mediante Paypal. 
   -- Ordene el resultado de mayor a menor.
   
select pag.*
from pagos pag
where pag.forma_pago = 'paypal' and year(fecha_pago) = 2008
order by pag.total desc;

-- 15 Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos empleados que 
   -- no sean representante de ventas de ningún cliente, utilizando una subconsulta
   
select emp.id_empleado, concat(emp.apellido1, coalesce(apellido2, ' ')), emp.puesto, ofi.telefono
from (select * from empleados emp left join clientes cli on cli.fk_empleado_rep_ventas = emp.id_empleado
where cli.fk_empleado_rep_ventas is null) emp
join oficinas ofi on emp.fk_oficina = ofi.id_oficina
order by emp.id_empleado;
   
-- 16 Muestra el nombre de los clientes que hayan realizado pagos junto con el nombre de sus representantes de ventas.

select cli.id_cliente, cli.nombre_cliente, cli.nombre_contacto nombre_cliente, cli.apellido_contacto apellido_cliente, emp.nombre representante, concat(apellido1, coalesce(apellido2, ' ')) apellido_representante
from clientes cli
join pagos pag on pag.fk_cliente = cli.id_cliente
join empleados emp on emp.id_empleado = cli.fk_empleado_rep_ventas;

-- 17 Devuelve el nombre del producto del que se han vendido más unidades. 
   -- (Tenga en cuenta que tendrá que calcular cuál es el número total de unidades que se han vendido 
    --  de cada producto a partir de los datos de la tabla detalle_pedido)

select nombre, fk_producto, sum(cantidad) top_venta
from detalles_pedido
join productos on fk_producto = id_producto
group by fk_producto
having sum(cantidad) = (select max(top_venta) 
						from (select fk_producto, sum(cantidad) top_venta 
							  from detalles_pedido 
                              group by fk_producto) max_vent);



    
-- 18 Devuelve un listado que muestre los empleados que no tienen una oficina asociada y los que no tienen un cliente asociado.

select emp.id_empleado, emp.nombre, emp.apellido1, emp.apellido2
from empleados emp
left join clientes cli on cli.fk_empleado_rep_ventas = emp.id_empleado
left join oficinas ofi on ofi.id_oficina = emp.fk_oficina
where emp.id_empleado != ALL (select fk_empleado_rep_ventas from clientes) 
     and emp.fk_oficina != ALL (select id_oficina from oficinas);

-- 19 La misma información que en la pregunta anterior, pero agrupada por código de producto.

select id_producto,  sum(cantidad) top_venta
from detalles_pedido
join productos on fk_producto = id_producto
group by id_producto
having sum(cantidad) = (select max(top_venta) 
						from (select fk_producto, sum(cantidad) top_venta 
							  from detalles_pedido 
                              group by fk_producto) max_vent);


-- 20 ¿Cuántos clientes existen con domicilio en la ciudad de Madrid?

select ciudad, count(id_cliente)
from clientes
group by ciudad
having ciudad = 'Madrid';

-- 21 Devuelve un listado con el código de oficina y la ciudad donde hay oficinas.

select id_oficina, oficina, ciudad
from oficinas;

-- 22 Devuelve un listado con los datos de los empleados que no tienen clientes asociados y el nombre de su jefe asociado.

select emp.id_empleado, emp.nombre, emp.apellido1, emp.apellido2,
 jef.id_empleado id_jefe, jef.nombre jefe_nombre, jef.apellido1 jefe_apellido1,jef.apellido2 jefe_apellido2
from empleados emp
left join empleados jef on emp.fk_jefe = jef.id_empleado
where emp.id_empleado not in (select fk_empleado_rep_ventas from clientes)
; 


-- 23 Devuelve el producto que más unidades tiene en stock.

select *
from productos pro
where pro.cantidad_en_stock = (select max(cantidad_en_stock) cant_max from productos);

-- 24 Muestra el nombre de los clientes que no hayan realizado pagos junto con el nombre de sus representantes de ventas.

select cli.*, emp.*
from clientes cli
join empleados emp on emp.id_empleado = cli.fk_empleado_rep_ventas
left join pagos pag on pag.fk_cliente = cli.id_cliente
where fk_cliente is null;

-- 25 Devuelve un listado con la ciudad y el teléfono de las oficinas de España.

select oficina, ciudad, telefono
from (select * from oficinas ofi where pais = 'España' or pais = 'Espana' or pais = 'spain') ofi_esp;

-- 26 La facturación que ha tenido la empresa en toda la historia, indicando la base imponible, el IVA y el total facturado. 
  -- La base imponible se calcula sumando el coste del producto por el número de unidades vendidas de la tabla detalle_pedido.
   -- El IVA es el 21 % de la base imponible, y el total la suma de los dos campos anteriores.
   

   select truncate(base_imponible, 2), truncate(IVA, 2), truncate((base_imponible + IVA), 2) total_facturado
   from(select sum(base_impo) base_imponible, sum(IVA) IVA
		from (select fk_producto, 
					(sum(cantidad * precio_unidad) /1.21) base_impo,
					(sum(cantidad * precio_unidad) / 1.21 * 1.21) IVA
					from detalles_pedido
			  group by fk_producto) base_imp) total_fac;

        
        select sum(IVA) 
       from (select (sum(cantidad * precio_unidad) /1.21) / 1.21 IVA
        from detalles_pedido
        group by fk_producto) iva_part;
        
-- 27 Devuelve un listado con el nombre, apellidos y email de los empleados cuyo jefe tiene un código de jefe igual a 7.

select emp.id_empleado, emp.nombre, emp.apellido1, emp.apellido2, emp.email
from empleados emp
where fk_jefe = 7;

-- 28 Lista la dirección de las oficinas que tengan clientes en Fuenlabrada.

select ofi.id_oficina, ofi.oficina, ofi.ciudad, ofi.pais, ofi.telefono, ofi.linea_direccion1, coalesce(ofi.linea_direccion2, ' ')
from oficinas ofi
join (select * 
		from empleados 
        join clientes cli on fk_empleado_rep_ventas = id_empleado
        where cli.ciudad = 'Fuenlabrada' or cli.region = 'fuenlabrada') cli_emp on ofi.id_oficina = fk_oficina
group by ofi.id_oficina
;


-- 29 Devuelve un listado de todos los pedidos que fueron rechazados en 2009.

select *
from pedidos ped
where estado = 'rechazado' and year(fecha_pedido) = 2008;

-- 30 Devuelve un listado con todas las formas de pago que aparecen en la tabla pago. Tenga en cuenta que no deben aparecer formas de pago repetidas.
-- 31 Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.
-- 32 Devuelve un listado con los clientes que han realizado algún pedido pero no han realizado ningún pago.
-- 33 Calcula la suma de la cantidad total de todos los productos que aparecen en cada uno de los pedidos.
-- 34 Devuelve un listado de las diferentes gamas de producto que ha comprado cada cliente.
-- 35 Devuelve un listado que muestre solamente los empleados que no tienen un cliente asociado.
-- 36 Devuelve un listado con los distintos estados por los que puede pasar un pedido.
-- 37 Devuelve un listado con todos los productos que pertenecen a la gama Ornamentales y que tienen más de 100 unidades en stock. El listado deberá estar ordenado por su precio de venta, mostrando en primer lugar los de mayor precio.
-- 38 Calcula el precio de venta del producto más caro y más barato en una misma consulta.
-- 39 Devuelve el nombre de los clientes y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.
-- 40 Devuelve el nombre de los representantes de ventas y el número de clientes al que atiende cada uno.
-- 41 Devuelve el nombre del cliente, el nombre y primer apellido de su representante de ventas y el número de teléfono de la oficina del representante de ventas, de aquellos clientes que no hayan realizado ningún pago.
-- 42 Devuelve el nombre de los clientes que hayan hecho pedidos en 2008 ordenados alfabéticamente de menor a mayor.
-- 43 Devuelve el nombre, los apellidos y el email de los empleados que están a cargo de Alberto Soria.
-- 44 Devuelve un listado de los productos que han aparecido en un pedido alguna vez.
-- 45 Devuelve el nombre de los clientes que han hecho pagos y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.
-- 46 Devuelve un listado de los 20 productos más vendidos y el número total de unidades que se han vendido de cada uno. El listado deberá estar ordenado por el número total de unidades vendidas.
-- 47 Devuelve el listado de clientes donde aparezca el nombre del cliente, el nombre y primer apellido de su representante de ventas y la ciudad donde está su oficina.
-- 48 Devuelve un listado con el código de cliente de aquellos clientes que realizaron algún pago en 2008. Tenga en cuenta que deberá eliminar aquellos códigos de cliente que aparezcan repetidos. Resuelva la consulta: Utilizando la función YEAR de MySQL., Utilizando la función DATE_FORMAT de MySQL., Sin utilizar ninguna de las funciones anteriores.
-- 49 Obtén un listado con el nombre de cada cliente y el nombre y apellido de su representante de ventas.
-- 50 Calcula la fecha del primer y último pago realizado por cada uno de los clientes. El listado deberá mostrar el nombre y los apellidos de cada cliente.
-- 51 Los clientes cuyo límite de crédito sea mayor que los pagos que haya realizado. (Sin utilizar INNER JOIN).
-- 52 Devuelve un listado con el nombre de los empleados junto con el nombre de sus jefes.
-- 53 ¿Cuántos pedidos hay en cada estado? Ordena el resultado de forma descendente por el número de pedidos.
-- 54 Devuelve las oficinas donde no trabajan ninguno de los empleados que hayan sido los representantes de ventas de algún cliente que haya realizado la compra de algún producto de la gama Frutales.
-- 55 Devuelve un listado con el nombre de los todos los clientes españoles.
-- 56 Devuelve un listado que muestre solamente los empleados que no tienen un cliente asociado junto con los datos de la oficina donde trabajan.
-- 57 Devuelve el producto que menos unidades tiene en stock.
-- 58 Calcula cuántos clientes tiene cada una de las ciudades que empiezan por M
-- 59 Devuelve un listado de todos los pedidos que han sido entregados en el mes de enero de cualquier año.
-- 60 ¿Cuál fue el pago medio en 2009?
-- 61 Devuelve el nombre del cliente con mayor límite de crédito.
-- 62 Devuelve el listado de clientes indicando el nombre del cliente y cuántos pedidos ha realizado. Tenga en cuenta que pueden existir clientes que no han realizado ningún pedido.
-- 63 Devuelve un listado de los productos que nunca han aparecido en un pedido. El resultado debe mostrar el nombre y la descripción.
-- 64 Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos empleados que no sean representante de ventas de ningún cliente.
-- 65 Devuelve un listado que muestre el nombre de cada empleados, el nombre de su jefe y el nombre del jefe de sus jefe.
-- 66 Muestre la suma total de todos los pagos que se realizaron para cada uno de los años que aparecen en la tabla pagos.
-- 67 Devuelve un listado que muestre solamente los clientes que no han realizado ningún pedido.
-- 68 Devuelve el nombre del cliente con mayor límite de crédito utilizando una subconsulta
-- 69 Devuelve un listado con el código de pedido, código de cliente, fecha esperada y fecha de entrega de los pedidos cuya fecha de entrega ha sido al menos dos días antes de la fecha esperada. Utilizando la función ADDDATE de MySQL., Utilizando la función DATEDIFF de MySQL., ¿Sería posible resolver esta consulta utilizando el operador de suma + o resta -?
-- 70 Devuelve el nombre, apellido1 y cargo de los empleados que no representen a ningún cliente.
-- 71 Devuelve el nombre del producto que tenga el precio de venta más caro utilizando una subconsulta
-- 72 Devuelve un listado con los nombres de los clientes y el total pagado por cada uno de ellos. Tenga en cuenta que pueden existir clientes que no han realizado ningún pago.
-- 73 ¿Cuántos clientes tiene cada país?
-- 74 La misma información que en la pregunta anterior, pero agrupada por código de producto filtrada por los códigos que empiecen por OR.
-- 75 Lista las ventas totales de los productos que hayan facturado más de 3000 euros. Se mostrará el nombre, unidades vendidas, total facturado y total facturado con impuestos (21% IVA).
-- 76 Calcula el número de productos diferentes que hay en cada uno de los pedidos.
-- 77 ¿Cuántos empleados hay en la compañía?
-- 78 Devuelve el nombre de los clientes a los que no se les ha entregado a tiempo un pedido.
-- 79 Devuelve un listado que muestre solamente los empleados que no tienen una oficina asociada.

-- *** Vistas ***
-- 80 Escriba una vista que se llame listado_pagos_clientes que muestre un listado donde aparezcan todos los clientes y los pagos que ha realizado cada uno de ellos. La vista deberá tener las siguientes columnas: nombre y apellidos del cliente concatenados, teléfono, ciudad, pais, fecha_pago, total del pago, id de la transacción
-- 81 Escriba una vista que se llame listado_pedidos_clientes que muestre un listado donde aparezcan todos los clientes y los pedidos que ha realizado cada uno de ellos. La vista deáber tener las siguientes columnas: nombre y apellidos del cliente concatendados, teléfono, ciudad, pais, código del pedido, fecha del pedido, fecha esperada, fecha de entrega y la cantidad total del pedido, que será la suma del producto de todas las cantidades por el precio de cada unidad, que aparecen en cada línea de pedido.
-- 82 Utilice las vistas que ha creado en los pasos anteriores para devolver un listado de los clientes de la ciudad de Madrid que han realizado pagos.
-- 83 Utilice las vistas que ha creado en los pasos anteriores para devolver un listado de los clientes que todavía no han recibido su pedido.
-- 84 Utilice las vistas que ha creado en los pasos anteriores para calcular el número de pedidos que se ha realizado cada uno de los clientes.
-- 85 Utilice las vistas que ha creado en los pasos anteriores para calcular el valor del pedido máximo y mínimo que ha realizado cada cliente.

