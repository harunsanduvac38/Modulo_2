-- 1 Id ,Descripcion y stock de los productos cuyo stock es menor que 10.
select idproducto, prod_descripcion, prod_stock from productos where prod_stock < 10;

-- 2 Listado de precios de los portátiles
select * from productos where prod_familia = 'portatil';

-- 3 Id ,Descripcion, Marca, Modelo de los productos de la familia “Memoria USB”
select idproducto, prod_descripcion, prod_marca, prod_modelo from productos 
where prod_familia = 'Memoria USB';

-- 4 Listado de memorias usb de la marca “Toshiba”
select * from productos where prod_marca = 'toshiba';

-- 5 Listado de memorias usb en stock de la marca “Toshiba”
select * from productos 
where prod_marca = 'toshiba' and prod_familia = 'Memoria USB' and prod_stock > 0;

-- 6 Listado de productos con precios actualizados antes del año 2020
select * from productos where year(prod_fecha_precio) < 2020;
select * from productos where prod_fecha_precio < '2020-01-01';

-- 7 Listado de discos y memorias ordenados por cantidad en stock
select * from productos 
where prod_familia like '%disco%' or prod_familia like '%memoria%'
order by prod_stock;

-- 8 Listado de discos y memorias en stock de las maracas “Toshiba” y “Seagate”
select * from productos 
where (prod_familia like '%disco%' or prod_familia like '%memoria%') and (prod_marca = 'Toshiba' or prod_marca='Seagate') and prod_stock > 0;
