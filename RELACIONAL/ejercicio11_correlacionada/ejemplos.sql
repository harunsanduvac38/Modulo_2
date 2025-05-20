use 02_tienda;

-- subconsultas relacionadas

-- 1 

select p.producto, p.precio, (select avg() from productos
								where id_producto <> p.id_producto)
from productos p;