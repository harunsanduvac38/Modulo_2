-- *** BBDD 09_jardineria ***

-- 1 Devuelve el nombre de los clientes que no hayan hecho pagos y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.
select distinct cl.id_cliente, cl.nombre_cliente, o.ciudad
from clientes cl
left join pagos pg on cl.id_cliente = pg.fk_cliente
join empleados em on cl.fk_empleado_rep_ventas = em.id_empleado
join oficinas o on em.fk_oficina = o.id_oficina
where pg.fk_cliente is null;

-- 2 Devuelve un listado que muestre los clientes que no han realizado ningún pago ni han realizado ningún pedido.
select distinct c.*
from clientes c
left join pagos p on c.id_cliente = p.fk_cliente
left join pedidos ped on c.id_cliente = ped.fk_cliente
where p.id_transaccion is null and ped.id_pedido is null;

select c.*
from clientes c
where c.id_cliente not in (select distinct fk_cliente from pagos) and
	  c.id_cliente not in (select distinct fk_cliente from pedidos);

-- 3 Devuelve un listado que muestre solamente los clientes que sí han realizado algún pago.
select distinct c.*
from clientes c
join pagos p on c.id_cliente = p.fk_cliente;

-- 4 Calcula el número de clientes que tiene la empresa.
select count(*) cant_clientes
from clientes;

-- 5 Devuelve el nombre del producto que tenga el precio de venta más caro.
	-- Mayor precio
    select max(precio_venta) from productos;
    
    select p.*
    from productos p
    where p.precio_venta = (select max(precio_venta) from productos);
    
-- 6 Devuelve un listado indicando todas las ciudades donde hay oficinas y el número de empleados que tiene.
select o.ciudad, count(e.id_empleado) cant
from oficinas o
join empleados e on o.id_oficina = e.fk_oficina
group by o.ciudad;

-- 7 Devuelve un listado con el código de pedido, código de cliente, fecha esperada y fecha de entrega de los pedidos que no han sido entregados a tiempo.
select p.id_pedido, p.fecha_esperada, p.fecha_entrega, p.fk_cliente
from pedidos p
where timestampdiff(day, p.fecha_esperada, p.fecha_entrega) > 0;

-- 8 Devuelve un listado de los productos que nunca han aparecido en un pedido.
select p.*
from productos p
left join detalles_pedido dp on p.id_producto = dp.fk_producto
where dp.fk_producto is null;

select *
from productos p
where p.id_producto not in (select fk_producto from detalles_pedido);

select *
from productos p
where not exists (select * from detalles_pedido where fk_producto = p.id_producto);

-- 9 Calcula el número de clientes que no tiene asignado representante de ventas.
select count(*)
from clientes
where fk_empleado_rep_ventas is null;

-- 10 Devuelve un listado con el nombre, apellidos y puesto de aquellos empleados que no sean representantes de ventas.
select *
from empleados
where not exists (select * from clientes where fk_empleado_rep_ventas = id_empleado);

-- 11 Devuelve un listado con todos los clientes que sean de la ciudad de Madrid y cuyo representante de ventas tenga el código de empleado 11 o 30.
select *
from clientes
where ciudad = 'Madrid' and fk_empleado_rep_ventas in (11, 30);

-- 12 Devuelve el nombre del puesto, nombre, apellidos y email del jefe de la empresa.
select *
from empleados
where fk_jefe is null;

-- 13 Devuelve un listado con los clientes que han realizado algún pedido pero no han realizado ningún pago, utilizando una subconsulta
select distinct c.*
from clientes c
join pedidos p on c.id_cliente = p.fk_cliente
where c.id_cliente not in (select fk_cliente from pagos);

	-- sin subconsulta
select distinct c.*
from clientes c
join pedidos p on c.id_cliente = p.fk_cliente
left join pagos pg on c.id_cliente = pg.fk_cliente
where pg.id_transaccion is null;

-- 14 Devuelve un listado con todos los pagos que se realizaron en el año 2008 mediante Paypal. Ordene el resultado de mayor a menor.
select *
from pagos
where year(fecha_pago) = 2008 and forma_pago like 'paypal';

-- 15 Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos empleados que no sean representante de ventas de ningún cliente, utilizando una subconsulta
select e.*, o.*
from empleados e
join oficinas o on e.fk_oficina = o.id_oficina
where e.id_empleado not in (select fk_empleado_rep_ventas from clientes);

-- 16 Muestra el nombre de los clientes que hayan realizado pagos junto con el nombre de sus representantes de ventas.
select distinct c.*, e.*
from clientes c
join pagos p on c.id_cliente = p.fk_cliente
join empleados e on c.fk_empleado_rep_ventas = e.id_empleado;

select *
from clientes c
join empleados e on c.fk_empleado_rep_ventas = e.id_empleado
where c.id_cliente in (select fk_cliente from pagos);

-- 17 Devuelve el nombre del producto del que se han vendido más unidades. (Tenga en cuenta que tendrá que calcular cuál es el número total de unidades que se han vendido de cada producto a partir de los datos de la tabla detalle_pedido)
	-- cantidad vendida de cada producto
    select sum(cantidad) cant
    from detalles_pedido
    group by fk_producto;
    
    -- cantidad vendida maxima
    select max(cant) cant_max
    from (select sum(cantidad) cant
		  from detalles_pedido
		  group by fk_producto) maxima;
	
    select p.*, sum(cantidad) cant
    from productos p
    join detalles_pedido on p.id_producto = fk_producto
    group by p.id_producto
    having cant = (select max(cant) cant_max
				  from (select sum(cantidad) cant
						from detalles_pedido
						group by fk_producto) maxima);

-- 18 Devuelve un listado que muestre los empleados que no tienen una oficina asociada y los que no tienen un cliente asociado.
select *
from empleados
where fk_oficina is not null 
	and id_empleado not in (select fk_empleado_rep_ventas from clientes);

-- 20 ¿Cuántos clientes existen con domicilio en la ciudad de Madrid?
select count(*) cant
from clientes
where ciudad = 'Madrid';

-- 21 Devuelve un listado con el código de oficina y la ciudad donde hay oficinas.
select *
from oficinas;

-- 22 Devuelve un listado con los datos de los empleados que no tienen clientes asociados y el nombre de su jefe asociado.
select *
from empleados e
left join empleados j on e.fk_jefe = j.id_empleado
where e.id_empleado not in (select fk_empleado_rep_ventas from clientes);

-- 23 Devuelve el producto que más unidades tiene en stock.
	-- cantidad maxima en stock
    select max(cantidad_en_stock) cant_max from productos;
    
select *
from productos
where cantidad_en_stock = (select max(cantidad_en_stock) cant_max from productos);

-- 24 Muestra el nombre de los clientes que no hayan realizado pagos junto con el nombre de sus representantes de ventas.
select cli.id_cliente, cli.nombre_cliente, e.id_empleado, e.nombre nombre_representante
from (select * from clientes c
	  left join pagos pg on c.id_cliente = pg.fk_cliente
	  where pg.fk_cliente is null) cli
join empleados e on cli.fk_empleado_rep_ventas = e.id_empleado;

-- 25 Devuelve un listado con la ciudad y el teléfono de las oficinas de España.
select * from oficinas;

-- 26 La facturación que ha tenido la empresa en toda la historia, indicando la base imponible, el IVA y el total facturado. 
	-- La base imponible se calcula sumando el coste del producto por el número de unidades vendidas de la tabla detalle_pedido. 
    -- El IVA es el 21 % de la base imponible, y el total la suma de los dos campos anteriores.
select sum(cantidad * precio_unidad) base_imponible, round(sum(cantidad * precio_unidad) * 0.21, 2) iva, sum(cantidad * precio_unidad) + round(sum(cantidad * precio_unidad) * 0.21, 2) total
from detalles_pedido;

-- 27 Devuelve un listado con el nombre, apellidos y email de los empleados cuyo jefe tiene un código de jefe igual a 7.
select *
from empleados
where fk_jefe = 7;

-- 28 Lista la dirección de las oficinas que tengan clientes en Fuenlabrada.
select distinct *
from oficinas o
join empleados e on o.id_oficina = e.fk_oficina
join (select fk_empleado_rep_ventas fk_emp from clientes where ciudad = 'Fuenlabrada') cli on e.id_empleado = cli.fk_emp;

-- 29 Devuelve un listado de todos los pedidos que fueron rechazados en 2009.
select * 
from pedidos
where estado = 'Rechazado' and year(fecha_pedido) = 2009;

-- 30 Devuelve un listado con todas las formas de pago que aparecen en la tabla pago. Tenga en cuenta que no deben aparecer formas de pago repetidas.
select distinct forma_pago
from pagos;

-- 31 Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.
select c.*
from clientes c
left join pagos on c.id_cliente = fk_cliente
where fk_cliente is null;

select c.*
from clientes c
where c.id_cliente != all (select fk_cliente from pagos);

select c.*
from clientes c
where not exists (select * from pagos where fk_cliente = c.id_cliente);

-- 33 Calcula la suma de la cantidad total de todos los productos que aparecen en cada uno de los pedidos.
select dp.fk_pedido, sum(dp.cantidad) cant
from detalles_pedido dp
group by dp.fk_pedido;

-- 34 Devuelve un listado de las diferentes gamas de producto que ha comprado cada cliente.
select distinct c.id_cliente, c.nombre_cliente, gp.id_gama, gp.gama
from clientes c
join pedidos p on c.id_cliente = p.fk_cliente
join detalles_pedido dp on p.id_pedido = dp.fk_pedido
join productos pro on dp.fk_producto = pro.id_producto
join gamas_productos gp on pro.fk_gama = gp.id_gama
order by c.id_cliente;

-- 35 (igual a la 18) Devuelve un listado que muestre solamente los empleados que no tienen un cliente asociado.
select *
from empleados
where id_empleado not in (select fk_empleado_rep_ventas from clientes);

-- 36 Devuelve un listado con los distintos estados por los que puede pasar un pedido.
select distinct estado
from pedidos;

-- 37 Devuelve un listado con todos los productos que pertenecen a la gama Ornamentales y que tienen más de 100 unidades en stock. 
	-- El listado deberá estar ordenado por su precio de venta, mostrando en primer lugar los de mayor precio.
select *
from productos p
where fk_gama in (select id_gama from gamas_productos where gama = 'Ornamentales')
	and p.cantidad_en_stock > 100
order by p.precio_venta desc;

select *
from productos p
join gamas_productos gp on p.fk_gama = gp.id_gama
where gp.gama = 'Ornamentales' and p.cantidad_en_stock > 100
order by p.precio_venta desc;

-- 38 Calcula el precio de venta del producto más caro y más barato en una misma consulta.
select max(precio_venta), min(precio_venta)
from productos;

select *
from productos
where precio_venta = (select max(precio_venta) from productos)
   or precio_venta = (select min(precio_venta) from productos);

-- 39 Devuelve el nombre de los clientes y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.
select c.id_cliente, c.nombre_cliente, e.id_empleado, e.nombre, o.oficina
from clientes c
join empleados e on c.fk_empleado_rep_ventas = e.id_empleado
join oficinas o on e.fk_oficina = o.id_oficina;

-- 40 Devuelve el nombre de los representantes de ventas y el número de clientes al que atiende cada uno.
select e.id_empleado, e.nombre, count(c.id_cliente)
from clientes c
join empleados e on c.fk_empleado_rep_ventas = e.id_empleado
group by e.id_empleado;

-- 41 Devuelve el nombre del cliente, el nombre y primer apellido de su representante de ventas y el número de teléfono de la oficina del representante de ventas, de aquellos clientes que no hayan realizado ningún pago.
select cli.id_cliente, cli.nombre_cliente, e.id_empleado, e.nombre, e.apellido1, o.telefono
from (select id_cliente, nombre_cliente, fk_empleado_rep_ventas 
	  from clientes left join pagos on id_cliente = fk_cliente 
      where id_transaccion is null) cli
join empleados e on cli.fk_empleado_rep_ventas = e.id_empleado
join oficinas o on e.fk_oficina = o.id_oficina;

-- 42 Devuelve el nombre de los clientes que hayan hecho pedidos en 2008 ordenados alfabéticamente de menor a mayor.
	
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
select e.id_empleado, e.nombre, e.apellido1, e.apellido2, e.email
from empleados e
join empleados j on e.fk_jefe = j.id_empleado
where j.nombre = 'Alberto' and j.apellido1 = 'Soria';

-- 44 Devuelve un listado de los productos que han aparecido en un pedido alguna vez.
select distinct p.*
from productos p
join detalles_pedido dp on p.id_producto = dp.fk_producto;

-- 45 Devuelve el nombre de los clientes que han hecho pagos y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.
select distinct c.id_cliente, c.nombre_cliente, e.id_empleado, e.nombre, o.ciudad
from clientes c
join pagos p on c.id_cliente = p.fk_cliente
join empleados e on c.fk_empleado_rep_ventas = e.id_empleado
join oficinas o on e.fk_oficina = o.id_oficina;

-- 46 Devuelve un listado de los 20 productos más vendidos y el número total de unidades que se han vendido de cada uno. El listado deberá estar ordenado por el número total de unidades vendidas.
select p.id_producto, p.nombre, sum(dp.cantidad) cant
from productos p
join detalles_pedido dp on p.id_producto = dp.fk_producto
group by p.id_producto
order by cant desc
limit 20;

-- 47 Devuelve el listado de clientes donde aparezca el nombre del cliente, el nombre y primer apellido de su representante de ventas y la ciudad donde está su oficina.
select distinct c.id_cliente, c.nombre_cliente, e.id_empleado, e.nombre, o.ciudad
from clientes c
join empleados e on c.fk_empleado_rep_ventas = e.id_empleado
join oficinas o on e.fk_oficina = o.id_oficina;

-- 48 Devuelve un listado con el código de cliente de aquellos clientes que realizaron algún pago en 2008. Tenga en cuenta que deberá eliminar aquellos códigos de cliente que aparezcan repetidos. 
	-- Resuelva la consulta: Utilizando la función YEAR de MySQL., Utilizando la función DATE_FORMAT de MySQL., Sin utilizar ninguna de las funciones anteriores.
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
select c.id_cliente, c.nombre_cliente, e.id_empleado, e.nombre
from clientes c
join empleados e on c.fk_empleado_rep_ventas = e.id_empleado;

-- 50 Calcula la fecha del primer y último pago realizado por cada uno de los clientes. El listado deberá mostrar el nombre y los apellidos de cada cliente.
select c.id_cliente, c.nombre_cliente, min(p.fecha_pago) primera, max(p.fecha_pago) ultima
from clientes c
join pagos p on c.id_cliente = p.fk_cliente
group by c.id_cliente;

-- 51 Los clientes cuyo límite de crédito sea mayor que los pagos que haya realizado. (Sin utilizar INNER JOIN).
select *
from clientes c
where c.limite_credito > (select sum(total) from pagos where fk_cliente = c.id_cliente);

-- 52 Devuelve un listado con el nombre de los empleados junto con el nombre de sus jefes.
select e.id_empleado, e.nombre, j.id_empleado id_jefe, j.nombre nombre_jefe
from empleados e
left join empleados j on e.fk_jefe = j.id_empleado;

-- 53 ¿Cuántos pedidos hay en cada estado? Ordena el resultado de forma descendente por el número de pedidos.
select estado, count(*) cant
from pedidos
group by estado
order by cant desc;

-- 54 Devuelve las oficinas donde no trabajan ninguno de los empleados que hayan sido los representantes de ventas de algún cliente que haya realizado la compra de algún producto de la gama Frutales.
select *
from oficinas
where id_oficina not in(select distinct e.fk_oficina
						from empleados e
                        join clientes c on e.id_empleado = c.fk_empleado_rep_ventas
                        join pedidos p on c.id_cliente = p.fk_cliente
                        join detalles_pedido dp on p.id_pedido = dp.fk_pedido
                        join productos prod on dp.fk_producto = prod.id_producto
                        join gamas_productos gp on prod.fk_gama = gp.id_gama
                        where gp.gama = 'Frutales');

-- 55 Devuelve un listado con el nombre de los todos los clientes españoles.
select *
from clientes
where pais = 'Spain';

-- 56 Devuelve un listado que muestre solamente los empleados que no tienen un cliente asociado junto con los datos de la oficina donde trabajan.
select *
from empleados
join oficinas o on fk_oficina = id_oficina
where id_empleado not in (select distinct fk_empleado_rep_ventas 
						  from clientes 
                          where fk_empleado_rep_ventas is not null);

-- 57 Devuelve el producto que menos unidades tiene en stock.
select *
from productos
where cantidad_en_stock = (select min(cantidad_en_stock) from productos);

select *
from productos
where cantidad_en_stock <= all (select cantidad_en_stock from productos);

-- 58 Calcula cuántos clientes tiene cada una de las ciudades que empiezan por M
select ciudad, count(*)
from clientes
where ciudad like 'M%'
group by ciudad;

-- 59 Devuelve un listado de todos los pedidos que han sido entregados en el mes de enero de cualquier año.
select *
from pedidos
where month(fecha_pedido) = 1;

-- 60 ¿Cuál fue el pago medio en 2009?
select 2009, avg(total) media
from pagos
where year(fecha_pago) = 2009;

-- 61 Devuelve el nombre del cliente con mayor límite de crédito.
select *
from clientes
where limite_credito = (select max(limite_credito) from clientes);

-- 62 Devuelve el listado de clientes indicando el nombre del cliente y cuántos pedidos ha realizado. Tenga en cuenta que pueden existir clientes que no han realizado ningún pedido.
select c.id_cliente, c.nombre_cliente, count(p.id_pedido) cant_pedidos
from clientes c
left join pedidos p on c.id_cliente = p.fk_cliente
group by c.id_cliente
order by cant_pedidos;

-- 63 Devuelve un listado de los productos que nunca han aparecido en un pedido. El resultado debe mostrar el nombre y la descripción.
select *
from productos
where id_producto not in (select distinct fk_producto from detalles_pedido);

-- 64 Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos empleados que no sean representante de ventas de ningún cliente.
	-- IGUAL AL 56

-- 65 Devuelve un listado que muestre el nombre de cada empleados, el nombre de su jefe y el nombre del jefe de sus jefe.
select emp.id_empleado, emp.nombre, jefes.id_empleado id_jefe, jefes.nombre jefe, jefazos.id_empleado id_jefazo, jefazos.nombre jefazo
from empleados emp
left join empleados jefes on emp.fk_jefe = jefes.id_empleado
left join empleados jefazos on jefes.fk_jefe = jefazos.id_empleado; 

-- 66 Muestre la suma total de todos los pagos que se realizaron para cada uno de los años que aparecen en la tabla pagos.
select year(fecha_pago) anyo, sum(total) total
from pagos
group by year(fecha_pago)
order by anyo;

-- 67 Devuelve un listado que muestre solamente los clientes que no han realizado ningún pedido.
select c.*
from clientes c
left join pedidos on c.id_cliente = fk_cliente
where id_pedido is null;

-- 68 Devuelve el nombre del cliente con mayor límite de crédito utilizando una subconsulta
select *
from clientes
where limite_credito = (select max(limite_credito) from clientes);

-- 69 Devuelve un listado con el código de pedido, código de cliente, fecha esperada y fecha de entrega de los pedidos cuya fecha de entrega ha sido al menos dos días antes de la fecha esperada. Utilizando la función ADDDATE de MySQL., Utilizando la función DATEDIFF de MySQL., ¿Sería posible resolver esta consulta utilizando el operador de suma + o resta -?
select p.id_pedido, p.fk_cliente, p.fecha_esperada, p.fecha_entrega
from pedidos p
where adddate(p.fecha_entrega, 2) <= p.fecha_esperada;

select p.id_pedido, p.fk_cliente, p.fecha_esperada, p.fecha_entrega
from pedidos p
where datediff(p.fecha_esperada, p.fecha_entrega) >= 2;

-- INCORRECTO!!!
select p.id_pedido, p.fk_cliente, p.fecha_esperada, p.fecha_entrega
from pedidos p
where p.fecha_esperada - p.fecha_entrega >= 2;

select datediff(date('2025-03-10'), date('2025-03-1')), date('2025-03-10') - date('2025-03-1');
select datediff(date('2025-03-10'), date('2025-02-28')), date('2025-03-10') - date('2025-02-28'), 20250310 - 20250228;

-- 70 Devuelve el nombre, apellido1 y cargo de los empleados que no representen a ningún cliente.
	-- YA ESTA HECHO

-- 71 Devuelve el nombre del producto que tenga el precio de venta más caro utilizando una subconsulta
select *
from productos
where precio_venta = (select max(precio_venta) from productos);

-- 72 Devuelve un listado con los nombres de los clientes y el total pagado por cada uno de ellos. Tenga en cuenta que pueden existir clientes que no han realizado ningún pago.
select id_cliente, nombre_cliente, sum(total), coalesce(sum(total), 0) total
from clientes
left join pagos on id_cliente = fk_cliente
group by id_cliente;

-- 73 ¿Cuántos clientes tiene cada país?
select pais, count(*) cant
from clientes
group by pais;

select o.pais, count(distinct c.id_cliente) cant
from clientes c
join empleados e on c.fk_empleado_rep_ventas = e.id_empleado
right join oficinas o on e.fk_oficina = o.id_oficina
group by o.pais;

-- 75 Lista las ventas totales de los productos que hayan facturado más de 3000 euros. Se mostrará el nombre, unidades vendidas, total facturado y total facturado con impuestos (21% IVA).
select p.id_producto, p.nombre, sum(dp.cantidad) cant, sum(dp.cantidad * dp.precio_unidad) total, sum(dp.cantidad * dp.precio_unidad)* 1.21 con_iva
from productos p
join detalles_pedido dp on p.id_producto = dp.fk_producto
group by p.id_producto
having total > 3000;

-- 76 Calcula el número de productos diferentes que hay en cada uno de los pedidos.
select fk_pedido, count(fk_producto)
from detalles_pedido
group by fk_pedido;

-- 77 ¿Cuántos empleados hay en la compañía?
select count(*) cant
from empleados;

-- 78 Devuelve el nombre de los clientes a los que no se les ha entregado a tiempo un pedido.
select distinct c.*
from clientes c
join pedidos p on c.id_cliente = p.fk_cliente
where p.fecha_entrega <= p.fecha_esperada;

-- 79 Devuelve un listado que muestre solamente los empleados que no tienen una oficina asociada.
	-- NO HAY. LA FK_OFICINA EN EMPLEADOS ES NOT NULL
    
-- *** Vistas ***
-- 80 Escriba una vista que se llame listado_pagos_clientes que muestre un listado donde aparezcan todos los clientes 
	-- y los pagos que ha realizado cada uno de ellos. La vista deberá tener las siguientes columnas: 
    -- nombre y apellidos del cliente concatenados, teléfono, ciudad, pais, fecha_pago, total del pago, id de la transacción
create or replace view listado_pagos_clientes as
select c.id_cliente, concat(c.nombre_contacto, ' ', c.apellido_contacto) contacto_cliente, c.telefono, c.ciudad, c.pais, p.fecha_pago, p.total, p.id_transaccion
from clientes c
join pagos p on c.id_cliente = p.fk_cliente;

-- 81 Escriba una vista que se llame listado_pedidos_clientes que muestre un listado donde aparezcan todos 
	-- los clientes y los pedidos que ha realizado cada uno de ellos. La vista deberá tener las siguientes columnas:
    -- nombre y apellidos del cliente concatendados, teléfono, ciudad, pais, código del pedido, fecha del pedido,
    -- fecha esperada, fecha de entrega y la cantidad total del pedido, que será la suma del producto de todas 
    -- las cantidades por el precio de cada unidad, que aparecen en cada línea de pedido.
create or replace view listado_pedidos_clientes as
select c.id_cliente, concat(c.nombre_contacto, ' ', c.apellido_contacto) contacto_cliente, c.telefono, c.ciudad, c.pais, 
				p.id_pedido, p.fecha_pedido, p.fecha_esperada, p.fecha_entrega, sum(dp.cantidad * dp.precio_unidad) total
from clientes c
join pedidos p on c.id_cliente = p.fk_cliente
join detalles_pedido dp on p.id_pedido = dp.fk_pedido
group by p.id_pedido;

-- 82 Utilice las vistas que ha creado en los pasos anteriores para devolver un listado de los clientes 
	-- de la ciudad de Madrid que han realizado pagos.
select id_cliente, contacto_cliente
from listado_pagos_clientes
where ciudad = 'Madrid';    

-- 83 Utilice las vistas que ha creado en los pasos anteriores para devolver un listado de los clientes 
	-- que todavía no han recibido su pedido.
select *
from listado_pedidos_clientes
where fecha_entrega is null;

-- 84 Utilice las vistas que ha creado en los pasos anteriores para calcular el número de pedidos que se ha realizado cada uno de los clientes.
select id_cliente, count(*) cant_pedidos
from listado_pedidos_clientes
group by id_cliente;

-- 85 Utilice las vistas que ha creado en los pasos anteriores para calcular el valor del pedido máximo y mínimo que ha realizado cada cliente.
select id_cliente, max(total) mayor, min(total) menor
from listado_pedidos_clientes
group by id_cliente;
