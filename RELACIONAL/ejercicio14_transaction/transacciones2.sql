select * from productos;

update productos set prod_precio = 100 where idproducto = 1;

update productos set prod_precio = 100 where idproducto = 2;
rollback;

delete from productos where idproducto = 1;
