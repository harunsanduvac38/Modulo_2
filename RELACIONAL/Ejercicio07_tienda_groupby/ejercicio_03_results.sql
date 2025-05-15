use 02_tienda;
-- *** BBDD 02_tienda ***
-- 1 Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más barato.
select p.precio min_precio, p.id_producto, p.producto, f.fabricante
from productos p
join fabricantes f on p.fk_fabricante = f.id_fabricante
order by p.precio asc
limit 1;


-- 2 Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más caro.
select p.precio max_precio, p.producto, f.fabricante
from productos p
join fabricantes f on p.fk_fabricante = f.id_fabricante
order by p.precio desc
limit 1;

-- 3 Devuelve una lista de todos los productos del fabricante Lenovo.
select p.id_producto, p.producto, p.precio
from productos p
join fabricantes f on p.fk_fabricante = f.id_fabricante
where f.fabricante = 'Lenovo';

-- 4 Devuelve una lista de todos los productos del fabricante Crucial que tengan un precio mayor que 200€.
select p.id_producto, p.producto, p.precio
from productos p
join fabricantes f on p.fk_fabricante = f.id_fabricante
where f.fabricante = 'Crucial' and p.precio > 200;

-- 5 Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packard Seagate. Sin utilizar el operador IN.
select *
from productos p
join fabricantes f on f.id_fabricante = p.fk_fabricante
where f.fabricante = 'asus' or f.fabricante = 'Hewlett-Packard' or f.fabricante = 'Seagate';

-- 6 Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packardy Seagate. Utilizando el operador IN.
select *
from productos p
join fabricantes f on f.id_fabricante = p.fk_fabricante
where f.fabricante in ('asus', 'hewlett-packard', 'seagate');

-- 7 Devuelve un listado con el nombre y el precio de todos los productos de los fabricantes cuyo nombre termine por la vocal e.
select p.producto, p.precio, f.fabricante
from productos p
join fabricantes f on f.id_fabricante = p.fk_fabricante
where f.fabricante like '%e';

-- 8 Devuelve un listado con el nombre y el precio de todos los productos cuyo nombre de fabricante contenga el carácter w en su nombre.
select p.producto, p.precio, f.fabricante
from productos p
join fabricantes f on f.id_fabricante = p.fk_fabricante
where f.fabricante like '%w%';

-- 9 Devuelve un listado con el nombre de producto, precio y nombre de fabricante, de todos los productos que tengan un precio mayor o igual a 180€.
	-- Ordene el resultado en primer lugar por el precio (en orden descendente) y en segundo lugar por el nombre (en orden ascendente)
    select p.producto, p.precio, f.fabricante 
    from productos p
    join fabricantes f on f.id_fabricante = p.fk_fabricante
    where p.precio >= 180
    order by p.precio desc, p.producto;
    
-- 10 Devuelve un listado con el código y el nombre de fabricante, solamente de aquellos fabricantes que tienen productos asociados en la base de datos.
select distinct f.id_fabricante, f.fabricante
from fabricantes f
join productos p on p.fk_fabricante = f.id_fabricante;


-- 11 Devuelve un listado de todos los fabricantes que existen en la base de datos, junto con los productos que tiene cada uno de ellos. 
	-- El listado deberá mostrar también aquellos fabricantes que no tienen productos asociados.
    select f.id_fabricante, f.fabricante, p.producto, p.precio
    from fabricantes f
    left join productos p on p.fk_fabricante = f.id_fabricante
    order by id_fabricante;
    
-- 12 Devuelve un listado donde sólo aparezcan aquellos fabricantes que no tienen ningún producto asociado.
select f.id_fabricante, f.fabricante
from fabricantes f
left join productos p on p.fk_fabricante = f.id_fabricante
where p.fk_fabricante is null;

-- 13 Calcula el número total de productos que hay en la tabla productos.
select count(*) cant_prod
from productos p;

-- 14 Calcula el número total de fabricantes que hay en la tabla fabricante.
select count(*) cant_fabricantes
from fabricantes f;
-- 15 Calcula el número de valores distintos de código de fabricante aparecen en la tabla productos.
select f.id_fabricante, count(*)
from productos p
join fabricantes f on p.fk_fabricante = f.id_fabricante
group by f.id_fabricante;

select count(distinct fk_fabricante)
from productos;

-- 16 Calcula la media del precio de todos los productos.
select avg(p.precio) media_precio
from productos p;

-- 17 Calcula el precio más barato de todos los productos.
select min(p.precio) min_precio
from productos p;
-- 18 Calcula el precio más caro de todos los productos.
select max(p.precio) max_precio
from productos p;
-- x19 Lista el nombre y el precio del producto más barato.
-- x20 Lista el nombre y el precio del producto más caro.
-- 21 Calcula la suma de los precios de todos los productos.
select sum(p.precio) total_precio
from productos p;

-- 22 Calcula el número de productos que tiene el fabricante Asus.
select count(*)
from productos p
left join fabricantes f on p.fk_fabricante = f.id_fabricante
where f.fabricante = 'Asus';

-- 23 Calcula la media del precio de todos los productos del fabricante Asus.
select truncate(avg(p.precio), 2) media_precio
from productos p
left join fabricantes f on p.fk_fabricante = f.id_fabricante
where f.fabricante = 'Asus';

-- 24 Calcula el precio más barato de todos los productos del fabricante Asus.
select min(p.precio) min_precio
from productos p
join fabricantes f on p.fk_fabricante = f.id_fabricante
where f.fabricante = 'Asus';

-- 25 Calcula el precio más caro de todos los productos del fabricante Asus.
select max(p.precio) max_precio
from productos p
join fabricantes f on p.fk_fabricante = f.id_fabricante
where f.fabricante = 'Asus';

-- 26 Calcula la suma de todos los productos del fabricante Asus.
select sum(p.precio) total_precio
from productos p
join fabricantes f on p.fk_fabricante = f.id_fabricante
where f.fabricante = 'Asus';


-- 27 Muestra el precio máximo, precio mínimo, precio medio y el número total de productos que tiene el fabricante Crucial.
select max(p.precio) max_precio, min(p.precio) min_precio, truncate(avg(p.precio), 2) media_precio, count(p.id_producto) cant_prod
from productos p
join fabricantes f on p.fk_fabricante = f.id_fabricante
where f.fabricante = 'Crucial';


-- 28 Muestra el número total de productos que tiene cada uno de los fabricantes. El listado también debe incluir los fabricantes que no tienen ningún producto. 
	-- El resultado mostrará dos columnas, una con el nombre del fabricante y otra con el número de productos que tiene. Ordene el resultado descendentemente por el número de productos.
    select f.id_fabricante, f.fabricante, count(p.producto) cant_prod
    from fabricantes f
    left join productos p on f.id_fabricante = p.fk_fabricante
    group by f.fabricante
    order by cant_prod desc, f.id_fabricante;
    
-- 29 Muestra el precio máximo, precio mínimo y precio medio de los productos de cada uno de los fabricantes.
	-- El resultado mostrará el nombre del fabricante junto con los datos que se solicitan.
    select f.id_fabricante, f.fabricante, max(p.precio) max_precio, min(p.precio) min_precio, truncate(avg(p.precio), 2) media_precio
    from fabricantes f
    left join productos p on f.id_fabricante = p.fk_fabricante
    group by id_fabricante;
    
-- 30 Muestra el precio máximo, precio mínimo, precio medio y el número total de productos de los fabricantes que tienen un precio medio superior a 200€.
	-- No es necesario mostrar el nombre del fabricante, con el código del fabricante es suficiente.
    select f.id_fabricante, max(p.precio) max_precio, min(p.precio) min_precio, truncate(avg(p.precio), 2) media_precio, count(p.producto) cant_prod
    from fabricantes f
    left join productos p on p.fk_fabricante = f.id_fabricante
    group by f.id_fabricante
    having media_precio > 200;
    
-- 31 Muestra el nombre de cada fabricante, junto con el precio máximo, precio mínimo, precio medio y el número total de productos de los fabricantes que tienen un precio medio superior a 200€. 
	-- Es necesario mostrar el nombre del fabricante.
    select f.fabricante,  max(p.precio) max_precio, min(p.precio) min_precio, truncate(avg(p.precio), 2) media_precio, count(p.precio) cant_precio
    from fabricantes f
    left join productos p on f.id_fabricante = p.fk_fabricante
    group by f.fabricante
    having media_precio > 200;
    
-- 32 Calcula el número de productos que tienen un precio mayor o igual a 180€.
select count(*) cant_prod
from productos p
where p.precio >= 180;

-- 33 Calcula el número de productos que tiene cada fabricante con un precio mayor o igual a 180€.
select f.fabricante, count(p.producto) cant_prod
from fabricantes f
join productos p on p.fk_fabricante = f.id_fabricante
where p.precio >= 180
group by f.id_fabricante;

-- 34 Lista el precio medio los productos de cada fabricante, mostrando solamente el código del fabricante.
select f.id_fabricante, truncate(avg(p.precio),2) media_precio
from fabricantes f
left join productos p on p.fk_fabricante = f.id_fabricante
group by f.id_fabricante
order by f.id_fabricante;

-- 35 Lista el precio medio los productos de cada fabricante, mostrando solamente el nombre del fabricante.
select f.fabricante, truncate(avg(p.precio), 2) media_precio
from fabricantes f
left join productos p on p.fk_fabricante = f.id_fabricante
group by f.id_fabricante;

-- 36 Lista los nombres de los fabricantes cuyos productos tienen un precio medio mayor o igual a 150€.
select f.fabricante, truncate(avg(p.precio), 2) media_precio
from fabricantes f
join productos p on p.fk_fabricante = f.id_fabricante
group by f.id_fabricante
having media_precio >= 150;

-- 37 Devuelve un listado con los nombres de los fabricantes que tienen 2 o más productos.
select f.fabricante, count(p.producto) cant_prod
from fabricantes f
join productos p on p.fk_fabricante = f.id_fabricante
group by f.id_fabricante
having cant_prod >= 2;

-- 38 Devuelve un listado con los nombres de los fabricantes y el número de productos que tiene cada uno con un precio superior o igual a 220 €. 
	-- No es necesario mostrar el nombre de los fabricantes que no tienen productos que cumplan la condición.
    select f.fabricante, count(p.producto) cant_prod 
    from fabricantes f
    join productos p on p.fk_fabricante = f.id_fabricante
    where p.precio >= 220
    group by f.id_fabricante;
    
-- 39 Devuelve un listado con los nombres de los fabricantes y el número de productos que tiene cada uno
-- con un precio superior o igual a 220 € y que tengan mas de 1 producto con esas condiciones.
  select f.fabricante, count(p.producto) cant_prod 
    from fabricantes f
    join productos p on p.fk_fabricante = f.id_fabricante
    where p.precio >= 220
    group by f.id_fabricante
    having cant_prod > 1;

    

