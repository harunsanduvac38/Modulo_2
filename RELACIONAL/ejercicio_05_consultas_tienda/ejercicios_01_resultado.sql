use 02_tienda;

-- Lista el nombre de todos los productos que hay en la tabla producto.
select producto
from productos;
-- Lista los nombres y los precios de todos los productos de la tabla producto.
select producto, precio
from productos;
-- Lista todas las columnas de la tabla producto.
select *
from productos;
-- Lista el nombre de los productos, el precio en euros y el precio en dólares estadounidenses (USD).
select producto, precio as precio_euro, precio * 1.109 as precio_dolar
from productos;
-- Lista el nombre de los productos, el precio en euros y el precio en dólares estadounidenses (USD). Utiliza los siguientes alias para las columnas: nombre de producto, euros, dólares.
select producto as 'nombre de producto', precio 'euros', precio * 1.109 'dólares'
from productos;
-- Lista los nombres y los precios de todos los productos de la tabla producto, convirtiendo los nombres a mayúscula.
select upper(producto) as 'nombres', precio
from productos;
-- Lista los nombres y los precios de todos los productos de la tabla producto, convirtiendo los nombres a minúscula.
select lower(producto) 'nombres', precio
from productos;
-- Lista el nombre de todos los fabricantes en una columna, y en otra columna obtenga en mayúsculas los dos primeros caracteres del nombre del fabricante.
select fabricante, upper(substring(fabricante, 1,2)) '2 Caracteres'
from fabricantes;
-- Lista los nombres y los precios de todos los productos de la tabla producto, redondeando el valor del precio.
select producto, round(precio) 'Precio Rounded'
from productos;
-- Lista los nombres y los precios de todos los productos de la tabla producto, truncando el valor del precio para mostrarlo sin ninguna cifra decimal.
select producto, truncate(precio, 0) 'Precio Truncando'
from productos;
-- Lista el código de los fabricantes que tienen productos en la tabla producto.
select p.fk_fabricante
from productos p;
-- Lista el código de los fabricantes que tienen productos en la tabla producto, eliminando los códigos que aparecen repetidos.
select distinct fk_fabricante
from productos;

-- Lista los nombres de los fabricantes ordenados de forma ascendente.
select *
from fabricantes f
order by fabricante;
-- Lista los nombres de los fabricantes ordenados de forma descendente.
select *
from fabricantes f
order by fabricante desc;
-- Lista los nombres de los productos ordenados en primer lugar por el nombre de forma ascendente y en segundo lugar por el precio de forma descendente.
select distinct pasc.producto 'Prod_Ascedente', pdesc.producto 'Prod_Descendente'
from productos pasc
join productos pdesc
order by pasc.producto asc, pdesc.producto desc;
-- Devuelve una lista con las 5 primeras filas de la tabla fabricante.
select *
from fabricantes f
order by id_fabricante
limit 5;
-- Devuelve una lista con 2 filas a partir de la cuarta fila de la tabla fabricante. La cuarta fila también se debe incluir en la respuesta.
select *
from fabricantes f
order by id_fabricante
limit 3, 2;
-- Lista el nombre y el precio del producto más barato. (Utilice solamente las cláusulas ORDER BY y LIMIT)
select *
from productos p
order by precio asc
limit 1;
-- Lista el nombre y el precio del producto más caro. (Utilice solamente las cláusulas ORDER BY y LIMIT)
select *
from productos p
order by precio desc
limit 1;
-- Lista el nombre de todos los productos del fabricante cuyo código de fabricante es igual a 2.
select p.id_producto, p.producto, p.precio 
from productos p
where fk_fabricante = 2;
-- Lista el nombre de los productos que tienen un precio menor o igual a 120€.
select *
from productos p
where precio <= 120;
-- Lista el nombre de los productos que tienen un precio mayor o igual a 400€.
select *
from productos p
where precio >= 400;
-- Lista el nombre de los productos que no tienen un precio mayor o igual a 400€.
select *
from productos p
where not precio >= 400;
-- Lista todos los productos que tengan un precio entre 80€ y 300€. Sin utilizar el operador BETWEEN.
select *
from productos p
where precio > 300 or precio < 80;
-- Lista todos los productos que tengan un precio entre 60€ y 200€. Utilizando el operador BETWEEN.
select *
from productos p
where precio between 60 and 200;
-- Lista todos los productos que tengan un precio mayor que 200€ y que el código de fabricante sea igual a 6.
select *
from productos p
where precio > 200 and p.fk_fabricante = 6;
-- Lista todos los productos donde el código de fabricante sea 1, 3 o 5. Sin utilizar el operador IN.
select *
from productos p
where fk_fabricante = 1 or fk_fabricante = 3 or fk_fabricante = 5;
-- Lista todos los productos donde el código de fabricante sea 1, 3 o 5. Utilizando el operador IN.
select *
from productos p
where fk_fabricante in (1,3,5);
-- Lista el nombre y el precio de los productos en céntimos (Habrá que multiplicar por 100 el valor del precio). Cree un alias para la columna que contiene el precio que se llame céntimos.
select p.producto, p.precio * 100 'Céntimos'
from productos p;
-- Lista los nombres de los fabricantes cuyo nombre empiece por la letra S.
select *
from fabricantes f
where fabricante like 'S%';
-- Lista los nombres de los fabricantes cuyo nombre termine por la vocal e.
select *
from fabricantes f
where fabricante like '%e';
-- Lista los nombres de los fabricantes cuyo nombre contenga el carácter w.
select *
from fabricantes f
where fabricante like '%w%';
-- Lista los nombres de los fabricantes cuyo nombre sea de 4 caracteres.
select *
from fabricantes f
where fabricante like '____';
-- where char_length(fabricante) = 4 ;

-- Devuelve una lista con el nombre de todos los productos que contienen la cadena Portátil en el nombre.
select *
from productos p
where producto like '%portátil%';
-- Devuelve una lista con el nombre de todos los productos que contienen la cadena Monitor en el nombre y tienen un precio inferior a 215 €.
select *
from productos p
where producto like '%monitor%' and precio < 215;
-- Lista el nombre y el precio de todos los productos que tengan un precio mayor o igual a 180€. Ordene el resultado en primer lugar por el precio (en orden descendente) y en segundo lugar por el nombre (en orden ascendente).
select p.precio, p.producto
from productos p
where precio >=180
order by p.precio desc, p.producto;