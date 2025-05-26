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

select cli.id_cliente, cli.nombre_cliente, emp.id_empleado, emp.nombre nombre_empleado
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

select distinct ofi.id_oficina, ofi.oficina, ofi.ciudad, ofi.pais, ofi.telefono, ofi.linea_direccion1, coalesce(ofi.linea_direccion2, ' ')
from oficinas ofi
join (select * 
		from empleados 
        join clientes cli on fk_empleado_rep_ventas = id_empleado
        where cli.ciudad = 'Fuenlabrada') cli_emp on ofi.id_oficina = fk_oficina
group by ofi.id_oficina
;


-- 29 Devuelve un listado de todos los pedidos que fueron rechazados en 2009.

select *
from pedidos ped
where estado = 'rechazado' and year(fecha_pedido) = 2008;

-- 30 Devuelve un listado con todas las formas de pago que aparecen en la tabla pago. 
   -- Tenga en cuenta que no deben aparecer formas de pago repetidas.
   
   select distinct forma_pago
   from pagos
   ;
   
-- 31 Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.

select cli.*
from clientes cli
where cli.id_cliente not in (select fk_cliente from pagos)
order by cli.id_cliente;

-- 32 Devuelve un listado con los clientes que han realizado algún pedido pero no han realizado ningún pago.

select cli.*
from clientes cli
join pedidos ped on ped.fk_cliente = cli.id_cliente
left join pagos pag on pag.fk_cliente = cli.id_cliente
where pag.fk_cliente is null ;

-- 33 Calcula la suma de la cantidad total de todos los productos que aparecen en cada uno de los pedidos.

select det.fk_pedido, sum(det.cantidad) total_producto
from detalles_pedido det
group by det.fk_pedido
order by det.fk_pedido;

-- 34 Devuelve un listado de las diferentes gamas de producto que ha comprado cada cliente.

select distinct gamas.gama
from clientes cli
join pedidos ped on ped.fk_cliente = cli.id_cliente
join detalles_pedido det on det.fk_pedido = ped.id_pedido
join (select * from productos pro join gamas_productos gam on gam.id_gama = pro.fk_gama) gamas on gamas.id_producto = det.fk_producto
;


-- 35 Devuelve un listado que muestre solamente los empleados que no tienen un cliente asociado.

select emp.*
from empleados emp
left join clientes cli on cli.fk_empleado_rep_ventas = emp.id_empleado
where cli.fk_empleado_rep_ventas is null;

-- 36 Devuelve un listado con los distintos estados por los que puede pasar un pedido.

select distinct estado
from pedidos;

-- 37 Devuelve un listado con todos los productos que pertenecen a la gama Ornamentales y 
   -- que tienen más de 100 unidades en stock. 
   -- El listado deberá estar ordenado por su precio de venta, mostrando en primer lugar los de mayor precio.
   
   select pro.*
   from productos pro
   join (select * from gamas_productos where gama = 'Ornamentales') ornam on ornam.id_gama = pro.fk_gama
   where pro.cantidad_en_stock > 100
   order by precio_venta desc; 
   
   
-- 38 Calcula el precio de venta del producto más caro y más barato en una misma consulta.

select pro.precio_venta mas_caro, (select  distinct pro.precio_venta mas_barato
								  from productos pro
								  where pro.precio_venta <= all (select min(precio_venta) mas_barato from productos)) mas_barato
from productos pro
where pro.precio_venta >=(select max(precio_venta) from productos)
;


select max(precio_venta), min(precio_venta)
from productos;

select *
from productos
where precio_venta = (select max(precio_venta) from productos)
   or precio_venta = (select min(precio_venta) from productos);

-- 39 Devuelve el nombre de los clientes y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.

select cli.id_cliente, cli.nombre_cliente, cli.nombre_contacto cli_nombre_contacto, cli.apellido_contacto cli_apell_contacto,
 emp.id_empleado, emp.nombre nombre_empleado, concat(emp.apellido1, coalesce(emp.apellido2, ' ')) apellido_empleado,
 ofi.oficina , ofi.ciudad ciudad_oficina, ofi.pais pais_oficina
 from clientes cli
 join empleados emp on emp.id_empleado = cli.fk_empleado_rep_ventas
 join oficinas ofi on ofi.id_oficina = emp.fk_oficina;
 
 select c.id_cliente, c.nombre_cliente, e.id_empleado, e.nombre, o.oficina
from clientes c
join empleados e on c.fk_empleado_rep_ventas = e.id_empleado
join oficinas o on e.fk_oficina = o.id_oficina;
 

-- 40 Devuelve el nombre de los representantes de ventas y el número de clientes al que atiende cada uno.

select emp.id_empleado, emp.nombre, concat(apellido1, coalesce(apellido2, ' ')) apellidos, count(cli.fk_empleado_rep_ventas) nro_clientes
from empleados emp
join clientes cli on cli.fk_empleado_rep_ventas = emp.id_empleado
group by emp.id_empleado;

select e.id_empleado, e.nombre, count(c.id_cliente)
from clientes c
join empleados e on c.fk_empleado_rep_ventas = e.id_empleado
group by e.id_empleado;

-- 41 Devuelve el nombre del cliente, el nombre y primer apellido de su representante de ventas y
   --  el número de teléfono de la oficina del representante de ventas, de aquellos clientes que no hayan realizado ningún pago.
   
   select concat(cli.nombre_cliente, ' - ', cli.nombre_contacto, cli.apellido_contacto) cliente,
		  emp_ofi.nombre empleado, emp_ofi.apellido1 apellido_empleado, emp_ofi.telefono tel_oficina
	from (select * from clientes cli
			left join pagos pag on pag.fk_cliente = cli.id_cliente
            where pag.fk_cliente is null) cli
	join (select * from empleados emp join oficinas ofi on emp.fk_oficina = ofi.id_oficina) emp_ofi on emp_ofi.id_empleado = cli.fk_empleado_rep_ventas;
    
    
select cli.id_cliente, cli.nombre_cliente, e.id_empleado, e.nombre, e.apellido1, o.telefono
from (select id_cliente, nombre_cliente, fk_empleado_rep_ventas 
	  from clientes left join pagos on id_cliente = fk_cliente 
      where id_transaccion is null) cli
join empleados e on cli.fk_empleado_rep_ventas = e.id_empleado
join oficinas o on e.fk_oficina = o.id_oficina;
    
-- 42 Devuelve el nombre de los clientes que hayan hecho pedidos en 2008 ordenados alfabéticamente de menor a mayor.

select distinct cli_ped.id_cliente, cli_ped.nombre_cliente, cli_ped.nombre_contacto, cli_ped.apellido_contacto
from (select * from clientes cli join pedidos ped on cli.id_cliente = ped.fk_cliente) cli_ped
where year(cli_ped.fecha_pedido) = 2008
order by cli_ped.nombre_cliente asc;

-- sin subconsulta, solo con join
    select distinct c.*
	from clientes c
	join pedidos ped on c.id_cliente = ped.fk_cliente
	where year(fecha_pedido) = 2008
    order by c.nombre_cliente;
    
select *
from clientes c
join (select distinct fk_cliente from pedidos where year(fecha_pedido) = 2008) ped on c.id_cliente = ped.fk_cliente
order by c.nombre_cliente;

select *
from clientes c
where id_cliente in (select fk_cliente from pedidos where year(fecha_pedido) = 2008)
order by c.nombre_cliente;

-- 43 Devuelve el nombre, los apellidos y el email de los empleados que están a cargo de Alberto Soria.

select emp.nombre, concat(emp.apellido1, coalesce(emp.apellido2, ' ')), emp.email
from empleados emp
join empleados jef on jef.id_empleado = emp.fk_jefe
where jef.nombre = 'Alberto' and jef.apellido1 = 'Soria';

select e.id_empleado, e.nombre, e.apellido1, e.apellido2, e.email
from empleados e
join empleados j on e.fk_jefe = j.id_empleado
where j.nombre = 'Alberto' and j.apellido1 = 'Soria';

-- 44 Devuelve un listado de los productos que han aparecido en un pedido alguna vez.

select distinct pro.id_producto, pro.codigo_internacional_producto, pro.nombre, pro.proveedor, pro.descripcion
from productos pro
join detalles_pedido ped on ped.fk_producto = pro.id_producto;
        
select distinct p.*
from productos p
join detalles_pedido dp on p.id_producto = dp.fk_producto;


-- 45 Devuelve el nombre de los clientes que han hecho pagos y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.

select distinct cli.id_cliente, cli.nombre_cliente, emp_ofi.nombre representante, emp_ofi.oficina, emp_ofi.ciudad ciudad_oficina
from clientes cli
join (select * from empleados emp join oficinas ofi on ofi.id_oficina = emp.fk_oficina) emp_ofi on cli.fk_empleado_rep_ventas = emp_ofi.id_empleado
join pagos pag on pag.fk_cliente = cli.id_cliente;

select distinct c.id_cliente, c.nombre_cliente, e.id_empleado, e.nombre, o.ciudad
from clientes c
join pagos p on c.id_cliente = p.fk_cliente
join empleados e on c.fk_empleado_rep_ventas = e.id_empleado
join oficinas o on e.fk_oficina = o.id_oficina;


-- 46 Devuelve un listado de los 20 productos más vendidos y el número total de unidades que se han vendido de cada uno. 
   -- El listado deberá estar ordenado por el número total de unidades vendidas.
   
   select pro.id_producto, pro.nombre, sum(det.cantidad) total_venta
   from productos pro
   join detalles_pedido det on det.fk_producto = pro.id_producto
   group by pro.id_producto
   order by total_venta desc
   limit 20;
   
   
   select p.id_producto, p.nombre, sum(dp.cantidad) cant
from productos p
join detalles_pedido dp on p.id_producto = dp.fk_producto
group by p.id_producto
order by cant desc
limit 20;
   
-- 47 Devuelve el listado de clientes donde aparezca el nombre del cliente, 
   -- el nombre y primer apellido de su representante de ventas y la ciudad donde está su oficina.
   
   select cli.id_cliente, cli.nombre_cliente, concat(cli.nombre_contacto, ' ', cli.apellido_contacto) contactos_cliente,
   emp_ofi.nombre nombre_rep, emp_ofi.apellido1 apellido_rep, emp_ofi.ciudad ciudad_oficina
   from clientes cli
   join (select * from empleados emp join oficinas ofi on ofi.id_oficina = emp.fk_oficina) emp_ofi 
   on emp_ofi.id_empleado = cli.fk_empleado_rep_ventas;
   
   select distinct c.id_cliente, c.nombre_cliente, e.id_empleado, e.nombre, o.ciudad
from clientes c
join empleados e on c.fk_empleado_rep_ventas = e.id_empleado
join oficinas o on e.fk_oficina = o.id_oficina;
   
   
-- 48 Devuelve un listado con el código de cliente de aquellos clientes que realizaron algún pago en 2008.
    -- Tenga en cuenta que deberá eliminar aquellos códigos de cliente que aparezcan repetidos. 
    -- Resuelva la consulta: Utilizando la función YEAR de MySQL., Utilizando la función DATE_FORMAT de MySQL., 
    -- Sin utilizar ninguna de las funciones anteriores.
    
    select distinct cli.id_cliente, DATE_FORMAT(pag.fecha_pago, "%D %M %Y") year_pago
    from pagos pag
    join clientes cli on cli.id_cliente = pag.fk_cliente
    where year(pag.fecha_pago) = '2008';
    
    
    select distinct c.id_cliente, c.nombre_cliente, p.fecha_pago
from clientes c
join pagos p on c.id_cliente = p.fk_cliente
where year(p.fecha_pago) = 2008; 

select distinct c.id_cliente, c.nombre_cliente, p.fecha_pago
from clientes c
join pagos p on c.id_cliente = p.fk_cliente
where date_format(p.fecha_pago, '%Y') = 2008; 

select distinct c.id_cliente, c.nombre_cliente, p.fecha_pago
from clientes c
join pagos p on c.id_cliente = p.fk_cliente
where fecha_pago between '2008-01-01' and '2008-12-31'; 
    
-- 49 Obtén un listado con el nombre de cada cliente y el nombre y apellido de su representante de ventas.

select cli.nombre_cliente, concat(cli.nombre_contacto, cli.apellido_contacto) contactos_cliente, 
        concat(emp.nombre, ' ', emp.apellido1, ' ', coalesce(emp.apellido2, ' ')) representante
from clientes cli
join empleados emp on emp.id_empleado = cli.fk_empleado_rep_ventas;

select c.id_cliente, c.nombre_cliente, e.id_empleado, e.nombre
from clientes c
join empleados e on c.fk_empleado_rep_ventas = e.id_empleado;

-- 50 Calcula la fecha del primer y último pago realizado por cada uno de los clientes.
  -- El listado deberá mostrar el nombre y los apellidos de cada cliente.
  
  select cli.id_cliente, cli.nombre_cliente, min(pag.fecha_pago) primer_pago, max(pag.fecha_pago) ultimo_pago 
  from pagos pag
  join clientes cli on cli.id_cliente = pag.fk_cliente
  group by cli.id_cliente;
  
  select c.id_cliente, c.nombre_cliente, min(p.fecha_pago) primera, max(p.fecha_pago) ultima
from clientes c
join pagos p on c.id_cliente = p.fk_cliente
group by c.id_cliente;
  

-- 51 Los clientes cuyo límite de crédito sea mayor que los pagos que haya realizado. (Sin utilizar INNER JOIN).

select cli.id_cliente, cli.nombre_cliente, concat(cli.nombre_contacto, cli.apellido_contacto) cliente_contacto, sum(pag.total) total_pago, cli.limite_credito
from clientes cli
join pagos pag on pag.fk_cliente = cli.id_cliente
group by cli.id_cliente
having total_pago < cli.limite_credito;

select *
from clientes cli
where cli.limite_credito > (select sum(total) from pagos where fk_cliente = cli.id_cliente);

-- 52 Devuelve un listado con el nombre de los empleados junto con el nombre de sus jefes.

select emp.id_empleado, emp.nombre empleado, concat(emp.apellido1, ' ', coalesce(emp.apellido2, ' ')) apellidos_emp,
		jef.id_empleado, jef.nombre nombre_jefe, concat(jef.apellido1, ' ', coalesce(jef.apellido2, ' ')) apellidos_jefe
from empleados emp
join empleados jef on jef.id_empleado = emp.fk_jefe;

select e.id_empleado, e.nombre, j.id_empleado id_jefe, j.nombre nombre_jefe
from empleados e
left join empleados j on e.fk_jefe = j.id_empleado;

-- 53 ¿Cuántos pedidos hay en cada estado? Ordena el resultado de forma descendente por el número de pedidos.

select ped.estado, count(ped.id_pedido) cant_pedido
from pedidos ped
group by ped.estado
order by cant_pedido desc;

select estado, count(*) cant
from pedidos
group by estado
order by cant desc;

-- 54 Devuelve las oficinas donde no trabajan ninguno de los empleados que 
   -- hayan sido los representantes de ventas de algún cliente que haya realizado la compra de algún producto de la gama Frutales.
   
   
   select distinct ofi.id_oficina, ofi.oficina, ofi.ciudad, ofi.pais, ofi.region
   from oficinas ofi
	where ofi.id_oficina not in (select distinct emp.fk_oficina from empleados emp
				join clientes cli on cli.fk_empleado_rep_ventas = emp.id_empleado
				join pedidos ped on ped.fk_cliente = cli.id_cliente
				join detalles_pedido det on det.fk_pedido = ped.id_pedido
                join productos pro on det.fk_producto = pro.id_producto
                join gamas_productos gam on gam.id_gama = pro.fk_gama
                where gam.gama = 'Frutales');
				
  
   
   
-- 55 Devuelve un listado con el nombre de los todos los clientes españoles.

select cli.nombre_cliente, cli.nombre_contacto, cli.apellido_contacto
from clientes cli
where cli.pais = 'Spain';

select *
from clientes
where pais = 'Spain';

-- 56 Devuelve un listado que muestre solamente los empleados que no tienen un cliente asociado junto con los datos de la oficina donde trabajan.

select emp.id_empleado, emp.nombre, emp.apellido1, emp.apellido2, ofi.id_oficina, ofi.oficina, ofi.ciudad
from empleados emp
join oficinas ofi on emp.fk_oficina = ofi.id_oficina
left join clientes cli on cli.fk_empleado_rep_ventas = emp.id_empleado
where cli.fk_empleado_rep_ventas is null
order by emp.id_empleado;

select *
from empleados
join oficinas o on fk_oficina = id_oficina
where id_empleado not in (select distinct fk_empleado_rep_ventas 
						  from clientes 
                          where fk_empleado_rep_ventas is not null);

-- 57 Devuelve el producto que menos unidades tiene en stock.

select pro.id_producto, pro.nombre, pro.dimensiones, pro.cantidad_en_stock
from productos pro
where pro.cantidad_en_stock <= (select min(cantidad_en_stock) from productos);

select *
from productos
where cantidad_en_stock = (select min(cantidad_en_stock) from productos);

select *
from productos
where cantidad_en_stock <= all (select cantidad_en_stock from productos);


-- 58 Calcula cuántos clientes tiene cada una de las ciudades que empiezan por M

select cli.ciudad, count(cli.id_cliente) cant_cliente
from clientes cli
where cli.ciudad like 'M%'
group by cli.ciudad;

select ciudad, count(*)
from clientes
where ciudad like 'M%'
group by ciudad;

-- 59 Devuelve un listado de todos los pedidos que han sido entregados en el mes de enero de cualquier año.

select ped.id_pedido, ped.fecha_pedido, ped.fecha_entrega, ped.comentarios
from pedidos ped
where month(ped.fecha_entrega) = '1';

select *
from pedidos
where month(fecha_pedido) = 1;

-- 60 ¿Cuál fue el pago medio en 2009?

select year(pag.fecha_pago), avg(pag.total)
from pagos pag
where year(pag.fecha_pago) = '2009'
group by year(pag.fecha_pago);

select 2009, avg(total) media
from pagos
where year(fecha_pago) = 2009;

-- 61 Devuelve el nombre del cliente con mayor límite de crédito.

select cli.id_cliente, cli.nombre_cliente, cli.nombre_contacto, cli.apellido_contacto, cli.limite_credito
from clientes cli
where cli.limite_credito = (select max(limite_credito) from clientes );

select *
from clientes
where limite_credito = (select max(limite_credito) from clientes);

-- 62 Devuelve el listado de clientes indicando el nombre del cliente y cuántos pedidos ha realizado.
	-- Tenga en cuenta que pueden existir clientes que no han realizado ningún pedido.
    
    select cli.id_cliente, cli.nombre_cliente, cli.nombre_contacto, cli.apellido_contacto, count(ped.id_pedido) cant_pedido
    from clientes cli
    left join pedidos ped on ped.fk_cliente = cli.id_cliente
    group by cli.id_cliente;
    
    select c.id_cliente, c.nombre_cliente, count(p.id_pedido) cant_pedidos
from clientes c
left join pedidos p on c.id_cliente = p.fk_cliente
group by c.id_cliente
order by cant_pedidos;
    
-- 63 Devuelve un listado de los productos que nunca han aparecido en un pedido. 
     -- El resultado debe mostrar el nombre y la descripción.
     
     select pro.id_producto, pro.nombre, pro.dimensiones, pro.descripcion, pro.cantidad_en_stock
     from productos pro
     where pro.id_producto not in (select fk_producto from detalles_pedido);
     
     select *
from productos
where id_producto not in (select distinct fk_producto from detalles_pedido);
     
-- 64 Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos empleados que no sean representante de ventas de ningún cliente.

select distinct emp.id_empleado, emp.nombre, emp.apellido1, emp.apellido2, emp.puesto, ofi.oficina, ofi.telefono
from empleados emp
join oficinas ofi on ofi.id_oficina = emp.fk_oficina
where emp.id_empleado != ALL (select fk_empleado_rep_ventas from clientes)
order by emp.id_empleado;

-- IGUAL AL 56

-- 65 Devuelve un listado que muestre el nombre de cada empleados, el nombre de su jefe y el nombre del jefe de sus jefe.

select emp.id_empleado, emp.nombre empleado_nombre, concat(emp.apellido1, coalesce(emp.apellido2, ' ')) empleado_apellidos,
		jef1.id_empleado id_jefe1, jef1.nombre nombre_jefe1, jef2.id_empleado id_jefe2, jef2.nombre nombre_jefe2
from empleados emp
left join empleados jef1 on jef1.id_empleado = emp.fk_jefe
left join empleados jef2 on jef2.id_empleado = jef1.fk_jefe;

select emp.id_empleado, emp.nombre, jefes.id_empleado id_jefe, jefes.nombre jefe, jefazos.id_empleado id_jefazo, jefazos.nombre jefazo
from empleados emp
left join empleados jefes on emp.fk_jefe = jefes.id_empleado
left join empleados jefazos on jefes.fk_jefe = jefazos.id_empleado; 

-- 66 Muestre la suma total de todos los pagos que se realizaron para cada uno de los años que aparecen en la tabla pagos.

select year(pag.fecha_pago), sum(pag.total) total_pago
from pagos pag
group by year(pag.fecha_pago);

select year(fecha_pago) anyo, sum(total) total
from pagos
group by year(fecha_pago)
order by anyo;

-- 67 Devuelve un listado que muestre solamente los clientes que no han realizado ningún pedido.

select distinct cli.id_cliente, cli.nombre_cliente, cli.nombre_contacto, cli.apellido_contacto
from clientes cli
where cli.id_cliente not in (select fk_cliente from pedidos);

select c.*
from clientes c
left join pedidos on c.id_cliente = fk_cliente
where id_pedido is null;

-- 68 Devuelve el nombre del cliente con mayor límite de crédito utilizando una subconsulta

select cli.id_cliente, cli.nombre_cliente, cli.nombre_contacto, cli.apellido_contacto, cli.limite_credito
from clientes cli
where cli.limite_credito = (select max(limite_credito) from clientes);

select *
from clientes
where limite_credito = (select max(limite_credito) from clientes);


-- 69 Devuelve un listado con el código de pedido, código de cliente, fecha esperada y 
  -- fecha de entrega de los pedidos cuya fecha de entrega ha sido al menos dos días antes de la fecha esperada.
    -- Utilizando la función ADDDATE de MySQL., Utilizando la función DATEDIFF de MySQL., 
    -- ¿Sería posible resolver esta consulta utilizando el operador de suma + o resta -?
    
select ped.id_pedido, cli.id_cliente, cli.nombre_cliente, ped.fecha_esperada, ped.fecha_entrega
from pedidos ped
join clientes cli on cli.id_cliente = ped.fk_cliente
where adddate(fecha_entrega, interval 2 day) <= fecha_esperada;

select ped.id_pedido, cli.id_cliente, cli.nombre_cliente, ped.fecha_esperada, ped.fecha_entrega, datediff(fecha_esperada, fecha_entrega) diferencia
from pedidos ped
join clientes cli on cli.id_cliente = ped.fk_cliente
where datediff(fecha_esperada, fecha_entrega) >= '2';

-- las fechas no se pueden restar o sumar!!
    select ped.id_pedido, cli.id_cliente, cli.nombre_cliente, ped.fecha_esperada, ped.fecha_entrega, (ped.fecha_entrega - ped.fecha_esperada) dife
    from pedidos ped
    join clientes cli on cli.id_cliente = ped.fk_cliente
    where (ped.fecha_esperada - ped.fecha_entrega) >= '2';
    
    
-- 70 Devuelve el nombre, apellido1 y cargo de los empleados que no representen a ningún cliente.

select emp.id_empleado, emp.nombre empleado, emp.apellido1, emp.puesto
from empleados emp
where emp.id_empleado != ALL (select fk_empleado_rep_ventas from clientes);

-- YA ESTA HECHO

-- 71 Devuelve el nombre del producto que tenga el precio de venta más caro utilizando una subconsulta

select pro.id_producto, pro.nombre, pro.descripcion, pro.precio_venta
from productos pro
where pro.precio_venta = (select max(precio_venta) from productos);

select *
from productos
where precio_venta = (select max(precio_venta) from productos);

-- 72 Devuelve un listado con los nombres de los clientes y el total pagado por cada uno de ellos. 
   -- Tenga en cuenta que pueden existir clientes que no han realizado ningún pago.
   
   select cli.id_cliente, cli.nombre_cliente, cli.nombre_contacto, coalesce(sum(pag.total), 0) total_pago
   from clientes cli
   left join pagos pag on pag.fk_cliente = cli.id_cliente
   group by cli.id_cliente;
   
   select id_cliente, nombre_cliente, sum(total), coalesce(sum(total), 0) total
from clientes
left join pagos on id_cliente = fk_cliente
group by id_cliente;
   
-- 73 ¿Cuántos clientes tiene cada país?

select  ofi.pais, count(distinct cli.id_cliente)
from clientes cli
join empleados emp on cli.fk_empleado_rep_ventas = emp.id_empleado
join oficinas ofi on ofi.id_oficina = emp.fk_oficina
group by ofi.pais;

select pais, count(*) cant
from clientes
group by pais;

select o.pais, count(distinct c.id_cliente) cant
from clientes c
join empleados e on c.fk_empleado_rep_ventas = e.id_empleado
right join oficinas o on e.fk_oficina = o.id_oficina
group by o.pais;

-- 74 La misma información que en la pregunta anterior, pero agrupada por código de producto filtrada por los códigos que empiecen por OR.



-- 75 Lista las ventas totales de los productos que hayan facturado más de 3000 euros. 
    -- Se mostrará el nombre, unidades vendidas, total facturado y total facturado con impuestos (21% IVA).
    
    select pro.id_producto, pro.nombre, sum(det.cantidad) cant_venta, sum(det.cantidad * det.precio_unidad) total_facturado, sum(det.cantidad * det.precio_unidad * 1.21) total_con_IVA
    from detalles_pedido det
    join productos pro on pro.id_producto = det.fk_producto
    group by pro.id_producto
    having total_facturado > 3000;
    
    select p.id_producto, p.nombre, sum(dp.cantidad) cant, sum(dp.cantidad * dp.precio_unidad) total, sum(dp.cantidad * dp.precio_unidad)* 1.21 con_iva
from productos p
join detalles_pedido dp on p.id_producto = dp.fk_producto
group by p.id_producto
having total > 3000;
    
    
-- 76 Calcula el número de productos diferentes que hay en cada uno de los pedidos.

select det.fk_pedido id_pedido, count(det.fk_producto) cant_producto
from detalles_pedido det
group by det.fk_pedido;

select fk_pedido, count(fk_producto)
from detalles_pedido
group by fk_pedido;

-- 77 ¿Cuántos empleados hay en la compañía?

select count(id_empleado) cant_empleado
from empleados;

select count(*) cant
from empleados;

-- 78 Devuelve el nombre de los clientes a los que no se les ha entregado a tiempo un pedido.

select distinct cli.id_cliente, cli.nombre_cliente, cli.nombre_contacto, cli.apellido_contacto
from clientes cli
join pedidos ped on ped.fk_cliente = cli.id_cliente
where ped.fecha_entrega > ped.fecha_esperada
order by cli.id_cliente;

select distinct c.*
from clientes c
join pedidos p on c.id_cliente = p.fk_cliente
where p.fecha_entrega <= p.fecha_esperada;

-- 79 Devuelve un listado que muestre solamente los empleados que no tienen una oficina asociada.

	-- empleados.fk_oficina is not null por tanto no hay ningun empleado que no tiene una oficina asociadoda.

-- *** Vistas ***
-- 80 Escriba una vista que se llame listado_pagos_clientes que muestre un listado donde aparezcan todos los clientes y los pagos que ha realizado cada uno de ellos.
    -- La vista deberá tener las siguientes columnas: nombre y apellidos del cliente concatenados, teléfono, ciudad, pais, fecha_pago, total del pago, id de la transacción
    
    create or replace view listado_pagos_clientes as
    select cli.id_cliente, concat(cli.nombre_contacto, ' ', cli.apellido_contacto) nombre_cliente, cli.telefono, cli.ciudad, cli.pais, pag.fecha_pago, pag.total, pag.id_transaccion
    from clientes cli
    join pagos pag on cli.id_cliente = pag.fk_cliente;
    
-- 81 Escriba una vista que se llame listado_pedidos_clientes que muestre un listado donde aparezcan todos los clientes y los pedidos que ha realizado cada uno de ellos. 
	-- La vista deber tener las siguientes columnas: nombre y apellidos del cliente concatendados, teléfono, ciudad, pais, código del pedido, fecha del pedido, fecha esperada,
	-- fecha de entrega y la cantidad total del pedido, que será la suma del producto de todas las cantidades por el precio de cada unidad, que aparecen en cada línea de pedido.
    
    create or replace view listado_pedidos_clientes as
    select cli.id_cliente, concat(nombre_cliente, ' ', apellido_contacto) nombre_cliente, cli.telefono, cli.ciudad, cli.pais,
				ped.id_pedido, ped.fecha_pedido, ped.fecha_esperada, ped.fecha_entrega, sum(det.precio_unidad * det.cantidad) total
	from clientes cli
	join pedidos ped on ped.fk_cliente = cli.id_cliente
	join detalles_pedido det on det.fk_pedido = ped.id_pedido
	group by ped.id_pedido;
    
-- 82 Utilice las vistas que ha creado en los pasos anteriores para devolver un listado de los clientes de la ciudad de Madrid que han realizado pagos.

select id_cliente, nombre_cliente
from listado_pagos_clientes
where ciudad = 'Madrid';
;


-- 83 Utilice las vistas que ha creado en los pasos anteriores para devolver un listado de los clientes que todavía no han recibido su pedido.

select *
from listado_pedidos_clientes
where fecha_entrega is null;

-- 84 Utilice las vistas que ha creado en los pasos anteriores para calcular el número de pedidos que se ha realizado cada uno de los clientes.

select id_cliente, nombre_cliente, count(id_pedido)
from listado_pedidos_clientes
group by id_cliente;


-- 85 Utilice las vistas que ha creado en los pasos anteriores para calcular el valor del pedido máximo y mínimo que ha realizado cada cliente.

select id_cliente, nombre_cliente, max(total) mayor, min(total) menor
from listado_pedidos_clientes
group by id_cliente;


