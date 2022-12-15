create database gym
go
use gym
go

create table provincia(
id_provincia int identity(1,1),
provincia varchar(50)
constraint pk_id_provincia primary key(id_provincia))

go

create table localidad(
id_localidad int identity(1,1),
localidad varchar(100),
id_provincia int
constraint pk_id_localidad primary key(id_localidad),
constraint fk_id_provincia foreign key (id_provincia) references provincia(id_provincia)
)

go

create table barrio(
id_barrio int identity(1,1),
barrio varchar(100),
id_localidad int
constraint pk_barrio primary key(id_barrio),
constraint fk_id_localidad foreign key (id_localidad) references localidad(id_localidad)
)

go

create table Personas(
DNI bigint,
nombre varchar(60),
apellido varchar(60),
sexo int,
fecha_nac date,
id_barrio int,
direccion varchar(500),
altura int,
foto image
constraint PK_DNI primary key(DNI),
constraint fk_id_barrio foreign key(id_barrio) references barrio(id_barrio))

go

create table Recepcionista(
usuario varchar(16),
DNI bigint,
baja_logica int
constraint pk_usuarioR primary key(usuario),
constraint fk_DNIR foreign key(DNI) references Personas(DNI)
)

go

create table Entrenador(
usuario varchar(16),
DNI bigint,
baja_logica int
constraint pk_usuarioE primary key(usuario),
constraint fk_DNIE foreign key(DNI) references Personas(DNI)
)

go

create table [Login](
usuario varchar(16),
contraseña varchar(16),
Administrador int,
baja_logica int,
constraint	pk_usuario_log primary key(usuario),
constraint fk_usuarioE foreign key(usuario) references Entrenador(usuario),
constraint fk_usuarioR foreign key(usuario) references Recepcionista(usuario)
)

go

create table Historial_login(
id_historial_login int identity(1,1),
usuario varchar(16),
fecha_log datetime
constraint pk_id_historail_login primary key (id_historial_login),
constraint fk_usuarioH foreign key (usuario) references [Login](usuario)
)

go

create table plan_alimenticio(
id_plan_alimenticio int identity(1,1),
fecha_ini date,
fecha_fin date
constraint pk_id_plan_alimenticio primary key(id_plan_alimenticio))

go

create table Detalle_plan_ali(
id_detalle_plan_ali int identity(1,1),
id_plan_alimenticio int,
comida varchar(50),
Detalle varchar(500)
constraint pk_id_detalle_plan_ali primary key(id_detalle_plan_ali),
constraint fk_id_plan_ali foreign key(id_plan_alimenticio) references plan_alimenticio(id_plan_alimenticio))

go

create table Cliente(
id_cliente int identity(1,1),
DNI bigint,
id_plan_ali int,
baja_logica int
constraint pk_id_cliente primary key(id_cliente),
constraint fk_dnis foreign key(DNI) references Personas(DNI),
constraint fk_id_plan_alimenticio foreign key(id_plan_ali) references plan_alimenticio(id_plan_alimenticio)
)

go 

create table Historial_Ingreso_cliente(
id_historial_ingreso_cliente int identity(1,1),
id_cliente int,
fecha_ingreso datetime
constraint pk_id_historial_ingreso_cliente primary key(id_historial_ingreso_cliente),
constraint fk_id_cliente foreign key(id_cliente) references Cliente(id_cliente)
) 

go

create table Tipo_Plan(
id_tipo_plan int identity(1,1),
tipo_plan varchar(150),
baja_logica int
constraint pk_id_tipo_plan primary key(id_tipo_plan))

go

create table Planes(
id_plan int identity(1,1),
nombre varchar(50),
descripcion varchar(2000),
duracion_dias int,
cant_dias_semana int,
cant_actividades int,
id_tipo_plan int,
baja_logica int
constraint pk_id_plan primary key(id_plan),
constraint fk_id_tipo_plan foreign key(id_tipo_plan) references Tipo_Plan(id_tipo_plan)
)

go

create table Forma_Pago(
id_forma_pago int identity(1,1),
Forma_Pago varchar(80),
Baja_Logica int,
constraint pk_id_forma_pago primary key(id_forma_pago)
)

go

create table Comprobante(
id_comprobante int identity(1,1),
id_cliente int,
id_plan int,
fecha_inicio date,
fecha_fin date,
usuario_entrenador varchar(16),
baja_logica int
constraint pk_id_comprobante primary key(id_comprobante),
constraint fk_id_client foreign key(id_cliente) references Cliente (id_cliente),
constraint fk_id_plan foreign key(id_plan) references Planes(id_plan),
constraint fk_entrenadors foreign key(usuario_entrenador) references Entrenador(usuario)
)

go

create table Pagos(
id_pago int identity(1,1),
fecha_pago datetime,
id_comprobante int,
monto money,
id_forma_pago int
constraint pk_id_pago primary key(id_pago),
constraint fk_id_comprobante foreign key(id_comprobante) references Comprobante(id_comprobante),
constraint fk_forma_pago foreign key(id_forma_pago) references Forma_Pago(id_forma_pago)
)

go

create table Horario(
id_horario int identity(1,1),
hora int,
dia varchar(15),
constraint pk_id_horario primary key(id_horario)
)

go

create table tipo_actividad(
id_tipo_actividad int identity(1,1),
Tipo_actividad varchar(100),
baja_logica int
constraint pk_id_tipo_actividad primary key(id_tipo_actividad)
)

go

create table actividad(
id_actividad int identity(1,1),
id_tipo_actividad int,
nombre varchar(100),
descripcion varchar(500),
monto money,
baja_logica int
constraint pk_id_actividad primary key(id_actividad)
constraint fk_id_tipo_actividad foreign key(id_tipo_actividad) references tipo_actividad(id_tipo_actividad)
)


go

create table Horario_Actividad(
id_horario_actividad int,
id_horario int,
id_actividad int,
baja_logica int,
constraint pk_id_horario_actividad primary key(id_horario_actividad),
constraint fk_id_horario foreign key(id_horario) references Horario(id_horario),
constraint fk_id_Actividad foreign key(id_actividad) references actividad(id_actividad)
)

go

create table Rutina(
id_rutina int identity(1,1),
id_actividad int, 
constraint pk_id_rutina primary key(id_rutina),
constraint fk_id_actividadd foreign key(id_actividad) references actividad(id_actividad)
)

go

create table Detalle_Rutina(
id_det_rutina int identity(1,1),
id_rutina int,
descripcion varchar(500),
repeticion int
constraint pk_id_det_rutina primary key(id_det_rutina),
constraint fk_id_rutina1 foreign key(id_rutina) references Rutina(id_rutina)
)

go

create table Detalle_Comprobante(
id_det_comprobante int identity(1,1),
id_comprobante int,
id_Rutina int,
monto money,
baja_logica int,
constraint pk_id_det_comprobante primary key(id_det_comprobante),
constraint fk_id_comprobant foreign key(id_comprobante) references Comprobante(id_comprobante),
constraint fk_id_rutina2 foreign key(id_Rutina) references Rutina (id_rutina)
)

go

create table Detalle_Horario(
id_det_horario int identity(1,1),
id_det_comprobante int,
id_horario_actividad int
constraint pk_id_det_horario primary key(id_det_horario),
constraint fk_id_det_comprobante2 foreign key(id_det_comprobante) references Detalle_Comprobante(id_det_comprobante),
constraint fk_id_horario_actividad foreign key (id_horario_actividad) references Horario_Actividad(id_horario_actividad)
)