use 01_negocio;

select * from productos;

update productos set prod_precio = 12.5 where idproducto = 23;

rollback;
-- el rollback no hace efecto, estamos trabajando en modo autocommit


select @@autocommit;

set autocommit = 0;

select * from productos where idproducto = 23;

update productos set prod_precio = 100 where idproducto = 23;
rollback;

update productos set prod_precio = 25 where idproducto = 23;
commit;