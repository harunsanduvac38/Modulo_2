
select @@session.transaction_isolation;

set session transaction isolation level read uncommitted;
-- probamos dirty read
select * from productos;


rollback;

update productos set prod_precio = 255 where idproducto = 1;
select @@autocommit;

-- ----------------------

set session transaction isolation level read committed;

-- probamos dirty read
update productos set prod_precio = 255 where idproducto = 1;
rollback;
	-- no se da este problema
    
-- probamos non repeatable read
start transaction;
select * from productos where idproducto = 1;
	-- actualizar en otra transaccion
select * from productos where idproducto = 1;
commit;
	-- si se produce non repeatable read
    
-- ---------------

set session transaction isolation level repeatable read;
-- probamos non repeatable read
start transaction;
select * from productos where idproducto = 1; -- (precio_actual)
	-- actualizar en otra transaccion con commit
select * from productos where idproducto = 1; -- (el mismo precio)
commit;
