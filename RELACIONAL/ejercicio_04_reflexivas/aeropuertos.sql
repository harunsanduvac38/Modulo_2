use 04_reflexivas;

create table aeropuertos(
id_aeropuerto int primary key auto_increment,
aeropuerto varchar(45) not null unique,
ciudad varchar(35) not null
);

create table conexiones(
fk_aeropuerto_origen int,
fk_aeropuerto_destino int,
primary key(fk_aeropuerto_origen, fk_aeropuerto_destino),
foreign key (fk_aeropuerto_origen) references aeropuertos(id_aeropuerto),
foreign key (fk_aeropuerto_destino) references aeropuertos(id_aeropuerto)
);

insert into aeropuertos values(null, 'Barajas', 'Madrid');
insert into aeropuertos values(null, 'El Prat', 'Barcelona');
insert into aeropuertos values(null, 'Ezeiza', 'Buenos Aires');
insert into aeropuertos values(null, 'El de Sevilla', 'Sevilla');
insert into aeropuertos values (null, 'DeGol', 'Paris');

insert into conexiones values(1,3);
insert into conexiones values (3,1);
insert into conexiones values (2,5);
insert into conexiones values (5,2);