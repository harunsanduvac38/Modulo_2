select productos.id_producto, productos.producto, productos.precio, fabricantes.id_fabricante, fabricantes.fabricante
from productos join fabricantes
on productos.fk_fabricante = fabricantes.id_fabricante;

select p.id_producto, p.producto, p.precio, f.id_fabricante, f.fabricante
from productos as p join fabricantes as f
on p.fk_fabricante = f.id_fabricante;

select upper(producto), precio, round(precio * 1.21, 2) as precio_con_iva 
from productos
where round(precio * 1.21, 2) > 200;

-- datos del producto y su fabricante de mayor precio
select 'hola'
from productos p join fabricantes f on p.fk_fabricante = f.id_fabricante
order by precio desc
limit 1;

