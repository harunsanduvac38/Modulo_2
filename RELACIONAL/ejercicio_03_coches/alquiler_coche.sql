drop database if exists 03_alquiler_coches;
create database 03_alquiler_coches;
use 03_alquiler_coches;

drop table if exists clientes, reservas, coches, marcas, modelos;

create table marcas(
id_marca int auto_increment,
marca varchar(45) not null,
primary key (`id_marca`)
);

create table modelos(
id_modelo int auto_increment,
modelo varchar(45) not null,
fk_marcas int not null,
primary key(`id_modelo`),
constraint modelos_marcas foreign key(`fk_marcas`)
references marcas (`id_marca`)
);

create table coches(
id_coche int auto_increment,
matricula varchar(15) not null,
color varchar(30) not null,
precio_alq decimal(8,2) not null,
fk_modelos int not null,
primary key (id_coche),
unique `matricula_unique`(matricula),
constraint coches_modelos foreign key (fk_modelos)
 references modelos(id_modelo)
);


create table clientes(
id_cliente int auto_increment,
dni varchar(25) not null,
nombre varchar(25) not null,
apellido varchar(25) not null,
telefono varchar(20) not null,
direccion varchar(100) not null,
primary key (id_cliente),
unique cliente_unique (dni)
);


create table reservas(
id_reserva int auto_increment,
fecha_inicio date not null,
fecha_fin date,
precio_total decimal(12,2) not null,
fk_clientes int not null,
primary key(id_reserva),
constraint reservas_clientes foreign key(fk_clientes) references clientes(id_cliente)
);

create table coches_reservas(
litros_gasolina decimal(5,2) not null,
km_inicio decimal(10,2) not null,
km_fin decimal(10,2),
fk_coches int not null,
fk_reservas int not null,
primary key(fk_coches, fk_reservas),
constraint coches_reservas foreign key (fk_coches) references coches (id_coche),
constraint reservas_coches foreign key (fk_reservas) references reservas (id_reserva)
);



create table reservas_clientes(
porcentaje decimal(5,2),
fk_reservas int not null,
fk_clientes int not null,
primary key (fk_reservas, fk_clientes),
constraint de_reservas foreign key(fk_reservas) references reservas(id_reserva),
constraint de_clientes foreign key(fk_clientes) references clientes(id_cliente)
);



