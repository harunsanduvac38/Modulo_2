drop database if exists 08_despacho;
CREATE DATABASE if not exists  08_despacho;

use 08_despacho;

-- drop table if exists personas;



create table personas(
id_persona int not null auto_increment,
nombre varchar(30) not null,
apellido1 varchar (30) not null,
apellido2 varchar(30) not null,
dni varchar(20) not null,
direccion varchar(45) not null,
telefon int not null,
tipo_doc varchar(30),
nro_doc varchar(30),
primary key (id_persona),

unique key persona_doc (nro_doc, tipo_doc)
);

-- drop table if exists epmleados;

create table empleados(
fk_persona int not null,
fecha_ingreso date not null,
primary key (fk_persona),
foreign key (fk_persona) references personas(id_persona)
);

-- drop table if exists clientes;

create table clientes(
fk_persona int,
fecha_alta date not null,
primary key (fk_persona),
foreign key (fk_persona) references personas (id_persona)
);


-- drop table if exists procuradores;

create table procuradores(
fk_empleado int not null,
nro_matriculo varchar(45) not null,
primary key (fk_empleado),
unique key (nro_matriculo),
foreign key (fk_empleado) references empleados (fk_persona)
);

-- drop table if exists abogados;

create table abogados(
fk_empleado int not null,
nro_matriculo varchar(45) not null,
primary key (fk_empleado),
unique key (nro_matriculo),
foreign key (fk_empleado) references empleados (fk_persona)
);

-- drop table if exists especialidades;

create table especialidades(
id_especialidad int auto_increment,
especialidad varchar(45) not null unique,
primary key (id_especialidad)
);

create table abogados_especialidades(
fk_abogado int not null,
fk_especialidad int not null,
primary key(fk_abogado, fk_especialidad),
foreign key (fk_abogado) references abogados(fk_empleado),
foreign key (fk_especialidad) references especialidades(id_especialidad)
);

-- drop table if exists expendientes;

create table estados(
id_estado int auto_increment,
estado varchar(45) not null,
primary key (id_estado)
);




create table expedientes(
id_expediente int not null,
descripcion varchar(25) not null,
descripcion_detallada text,
fecha_inicio date not null,
fecha_final date,
fk_abogado int not null,
fk_cliente int not null,
fk_estado int not null,
constraint pk_expediente primary key(id_expediente),
foreign key (fk_abogado) references abogados(fk_empleado),
foreign key (fk_cliente) references clientes(fk_persona),
foreign key (fk_estado) references estados(id_estado)
);


create table intervenciones(
fk_empleado int not null,
fk_expediente int not null,
fecha date,
hora time,
descripcion varchar(35) not null,
primary key(fk_empleado, fk_expediente, fecha, hora),
constraint inter_empleado foreign key (fk_empleado) references empleados (fk_persona),
constraint inter_expedientes foreign key  (fk_expediente) references expedientes(id_expediente)
);


