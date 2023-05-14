create database Formaggio
go
use Formaggio

go

Create table Localidad
(
id_localidad int identity(1,1) not null,
localidad varchar(100) not null,
baja_logica int,
constraint pk_idLocalidad primary key(id_localidad)
)

create table Clasificacion
(
id_clasificacion int identity(1,1) not null,
clasificacion varchar(50) not null,
baja_logica int,
constraint pk_id_clasificacion primary key (id_clasificacion)
)

Create table Tipo_producto
(
id_tipo_producto int identity(1,1) not null,
tipo_producto varchar(50) not null,
baja_logica int,
constraint pk_id_tipo_p primary key(id_tipo_producto)
)

go

Create table Unidad_Medida
(
id_unidad_medida int identity(1,1) not null,
Unidad_Medida varchar(50) not null,
baja_logica int,
constraint pk_id_unidad_medida primary key(id_unidad_medida)
)
go

Create table Producto
(
id_producto int identity (1,1) not null,
nombre varchar(100) not null,
precio money not null,
detalle varchar(600) not null,
stock int not null,
id_unidad_medida int not null,
id_tipo_producto int not null,
id_clasificacion int not null,
baja_logica int,
constraint pk_id_producto primary key(id_producto),
constraint fk_id_tipo_producto foreign key (id_tipo_producto) references Tipo_producto,
constraint fk_id_clasificacion foreign key (id_clasificacion) references Clasificacion,
constraint fk_id_unidad_medida foreign key (id_unidad_medida) references Unidad_Medida
)
go
Create table Socio 
(
id_socio int identity (1,1) not null,
DNI bigint not null,
email varchar(100) not null,
fecha_adhesion datetime not null,
baja_logica int
constraint pk_id_socio primary key (id_socio)
)
go
create table tipo_cliente(
id_tipo_cliente int identity(1,1),
tipo_cliente varchar(10),
constraint pk_id_tipo_cliente primary key(id_tipo_cliente)
)

go

Create table Cliente
(
id_cliente int identity(1,1) not null,
id_tipo_cliente int not null,
nombre varchar(50) not null,
apellido varchar(50) not null,
telefono varchar(100),
id_socio int ,
baja_logica int,
calle varchar(500),
altura int,
departamento varchar(50),
piso int,
id_localidad int
constraint pk_id_cliente primary key (id_cliente),
constraint fk_id_tipo_cliente foreign key(id_tipo_cliente)  references tipo_cliente,
constraint fk_id_pueblo foreign key (id_localidad) references Localidad(id_localidad)
)
go
Create table Roles
(
id_rol int identity (1,1) not null,
roles varchar(50) not null,
descripcion varchar(600) not null,
baja_logica int,
ROLES_EN varchar(50)
constraint pk_id_rol primary key (id_rol)
)
go
Create table Empleado(
id_empleado int identity(1,1) not null,
dni bigint not null,
nombre varchar(150) not null,
apellido varchar(150) not null,
direccion varchar(150) not null,
fecha_nac datetime not null,
telefono bigint not null,
baja_logica int,
id_localidad int,
altura int,
piso int,
departamento varchar(100),
constraint pk_id_empleado primary key (id_empleado)
)
go
Create table Descuento(
id_descuento int identity (1,1) not null,
nombre_dia varchar(10) not null,
porcentaje_descuento money not null,
baja_logica int
constraint pk_id_descuento primary key (id_descuento)
)go

Create table Usuarios(
id_usuario int identity (1,1) not null,
alias varchar(150) not null,
contraseña varchar(32) not null,
id_empleado int not null,
id_rol int not null,
baja_logica int,
fechaAlta Datetime,
fechaBaja Datetime,
constraint pk_id_usuario primary key (id_usuario),
constraint fk_id_empleado foreign key (id_empleado) references Empleado,
constraint fk_id_rol foreign key (id_rol) references Roles
)go

Create table Bitacora(
id_bitacora int identity (1,1) not null,
id_usuario int not null,
fecha datetime not null,
accion varchar(200) not null,
constraint pk_id_bitacora primary key (id_bitacora),
constraint fk_id_usuario foreign key (id_usuario) references Usuarios
)go


Create table Forma_compra(
id_forma_compra int identity(1,1) not null,
forma_compra varchar(50) not null,
constraint pk_id_forma_compra primary key (id_forma_compra),
)go

Create table forma_entrega(
id_forma_entrega int identity (1,1) not null,
forma_entrega varchar(50) not null,
constraint pk_id_forma_entrega primary key (id_forma_entrega)
)
go


Create table Factura
(
nro_factura int identity(1,1) not null,
fecha datetime not null,
id_cliente int,
id_usuario int not null,
id_forma_compra int not null,
id_forma_entrega int  not null,
id_descuento int,
baja_logica int,
nombre varchar(50),
apellido varchar(50),
id_localidad int,
calle varchar(500),
altura int,
piso int,
departamento varchar(50),
dni bigint,
telefono bigint,
descuento money,
Constraint pk_id_nro_factura primary key (nro_factura),
constraint fk_id_usuarios foreign key (id_usuario) references usuarios,
constraint fk_id_forma_compra foreign key (id_forma_compra) references forma_compra,
constraint fk_id_forma_entrega foreign key (id_forma_entrega) references forma_entrega,
constraint fk_id_descuento foreign key (id_descuento) references Descuento,
constraint fk_id_localidadd foreign key(id_localidad) references Localidad(id_localidad)
)go

Create table detalle_factura(
id_detalle_factura int identity (1,1) not null,
nro_factura int not null,
id_producto int not null,
cantidad int not null,
importe money,
descripcion varchar(600) not null,
baja_logica int,
constraint pk_id_detalle_factura primary key(id_detalle_factura),
constraint fk_nro_factura foreign key(nro_factura) references factura,
constraint fk_id_producto foreign key (id_producto) references producto
)go

create table Configuracion(
id_configuracion int,
descuentos_socios int,
compras_presenciales int,
Email varchar(50),
youtube varchar(50),
instagram varchar(50),
twitter varchar(50),
facebook varchar(50),
contraseña varchar(50)
)

go

create or alter procedure SP_Insertar_UsuarioEmpleado(
	@DNI bigint,
	@nombre varchar(150),
	@apellido varchar(150),
	@direccion varchar(150),
	@fecha_nacimiento datetime,
	@telefono bigint,
	@alias varchar(150),
	@contraseña varchar(32),
	@id_rol int,
	@baja_logica_user int,
	@baja_logica_empleado int,
	@id_usuario_admin int
)as
begin
	declare @UltimoId int

	insert into Empleado values(@DNI,@nombre,@apellido,@direccion,@fecha_nacimiento,@telefono,@baja_logica_empleado)
	
	set @UltimoId = SCOPE_IDENTITY()

	insert into Usuarios values(@alias,@contraseña,@UltimoId,@id_rol,@baja_logica_user)
	insert into Bitacora values(@id_usuario_admin,GETDATE(),'Registrar usuario')

end

go

create procedure SP_Actualizar_UsuarioEmpleado(
	@id_empleado int,
	@id_usuario int,
	@direccion varchar(150),
	@telefono bigint,
	@alias varchar(150),
	@contraseña varchar(32),
	@id_rol int,
	@baja_logica_usuario int,
	@baja_logica_empleado int,
	@id_usuario_admin int

)as
begin
	update Usuarios
	set alias = @alias,
		contraseña = @contraseña,
		id_rol = @id_rol, 
		baja_logica= @baja_logica_usuario
	where id_usuario = @id_usuario

	update Empleado
	set direccion =@direccion,
		telefono = @telefono,
		baja_logica = @baja_logica_empleado
	where id_empleado = @id_empleado	

	insert into Bitacora values(@id_usuario_admin,GETDATE(),'Modificar Usuario')
end

go

create  procedure SP_Obtener_usuarios(
	@condicion int
)
as
begin
	
	if @condicion = 1
	begin
	select e.id_empleado,u.id_usuario,dni,nombre,apellido,direccion,fecha_nac,telefono,e.baja_logica,alias,contraseña,r.id_rol,u.baja_logica, r.roles
	from Usuarios u
	join Empleado E on e.id_empleado = u.id_empleado
	join Roles r on r.id_rol = u.id_rol
	where u.baja_logica = 1
	end

	if @condicion = 0
	begin
	select e.id_empleado,u.id_usuario,dni,nombre,apellido,direccion,fecha_nac,telefono,e.baja_logica,alias,contraseña,r.id_rol,u.baja_logica, r.roles
	from Usuarios u
	join Empleado E on e.id_empleado = u.id_empleado
	join Roles r on r.id_rol = u.id_rol
	where u.baja_logica = 0
	end

	if @condicion != 1 and @condicion != 0
	begin
	select e.id_empleado,u.id_usuario,dni,nombre,apellido,direccion,fecha_nac,telefono,e.baja_logica,alias,contraseña,r.id_rol,u.baja_logica, r.roles
	from Usuarios u
	join Empleado E on e.id_empleado = u.id_empleado
	join Roles r on r.id_rol = u.id_rol
	end

end

go

create procedure SP_Buscar_usuario(
	@id int
)as
	select id_usuario
	from Usuarios
	where @id = id_usuario

go


create procedure SP_Obtener_Roles
as
	select * from Roles

go

create  procedure SP_Obtener_Configuracion
as
select * from Configuracion


go

create procedure SP_Actualizar_Redes(
	@email varchar(50),
	@instagram varchar(50),
	@facebook varchar(50),
	@twitter varchar(50),
	@youtube varchar(50),
	@contraseña varchar(50)
)as
	update Configuracion
	set Email = @email,
		instagram = @instagram,
		facebook = @facebook,
		twitter = @twitter,
		youtube = @youtube,
		contraseña = @contraseña
	where id_configuracion = 1


go


create procedure SP_Obtener_Descuentos
as
select * from Descuento


go


create  procedure SP_ActualizarConfigDescuentos(
	@dia1 int,
	@dia2 int,
	@dia3 int,
	@dia4 int,
	@dia5 int,
	@dia6 int,
	@dia7 int,
	@descuentoSocio int,
	@descuentoPresencial int
)as
	update Descuento
	set porcentaje_descuento = @dia1
	where id_descuento = 1

	update Descuento
	set porcentaje_descuento = @dia2
	where id_descuento = 2	

	update Descuento
	set porcentaje_descuento = @dia3
	where id_descuento = 3	

	update Descuento
	set porcentaje_descuento = @dia4
	where id_descuento = 4	
	
	update Descuento
	set porcentaje_descuento = @dia5
	where id_descuento = 5
	
	update Descuento
	set porcentaje_descuento = @dia6
	where id_descuento = 6	
	
	update Descuento
	set porcentaje_descuento = @dia7
	where id_descuento = 7

	update Configuracion
	set descuentos_socios = @descuentoSocio,
		compras_presenciales = @descuentoPresencial
	where id_configuracion = 1

go

create procedure SP_Obtener_Bitacora
as
	select id_bitacora, u.id_usuario, e.nombre,e.apellido,fecha,accion from Bitacora b
	join Usuarios u on  b.id_usuario =u.id_usuario
	join Empleado e on e.id_empleado = u.id_empleado
	order by fecha desc


go

create procedure SP_Verificar_Login(
	@alias varchar(150),
	@contraseña varchar(32)
)as
	select id_usuario
	from Usuarios
	where (@alias = alias and contraseña = @contraseña) and baja_logica = 0
go

create procedure SP_DatosUserLogin(
	@alias varchar(150),
	@contraseña varchar(32)
)as

	select id_usuario, nombre,apellido,dni,direccion,fecha_nac,telefono,e.baja_logica,u.baja_logica, u.id_rol
	from Usuarios u
	join Empleado e on e.id_empleado = u.id_empleado
	where @alias = alias and contraseña = @contraseña
go

create procedure SP_Insertar_Cliente(
	@id_tipo_cliente int,
	@nombre varchar(50),
	@apellido varchar(50),
	@direccion varchar(150),
	@telefono bigint,
	@id_usuario int
)as
	insert into Cliente values(@id_tipo_cliente,@nombre,@apellido,@direccion,@telefono, null,0)
		insert into Bitacora values(@id_usuario,GETDATE(),'Ingreso Cliente')


go


create procedure SP_Insertar_ClienteSocio(
	@id_tipo_cliente int,
	@nombre varchar(50),
	@apellido varchar(50),
	@direccion varchar(150),
	@telefono bigint,
	@DNI bigint,
	@email varchar (100),
	@id_usuario int
)as
	insert into Socio values(@DNI,@email,GETDATE(),0)
	declare @cod int
	set @cod = SCOPE_IDENTITY()


	insert into Cliente values(@id_tipo_cliente,@nombre,@apellido,@direccion,@telefono, @cod,0)
	insert into Bitacora values(@id_usuario,GETDATE(),'Adhesion al club')

go


create procedure SP_Cargar_TodosCLientes
as
	select id_cliente,s.id_socio, nombre, apellido,direccion,telefono, s.DNI,s.email, s.fecha_adhesion, s.baja_logica,id_tipo_cliente
	from Cliente c
	left join Socio s on s.id_socio = c.id_socio
	ORDER by id_cliente desc


go

create procedure SP_ModificarSocio(
	@id_cliente int,
	@id_tipo_cliente int,
	@direccion varchar(150),
	@telefono bigint,
	@email varchar (100),
	@id_usuario int
)as
	update Cliente
	set direccion = @direccion,
		telefono= @telefono,
		id_tipo_cliente = @id_tipo_cliente
	where id_cliente = @id_cliente

	update socio
	set email = @email
	where id_socio in (select id_socio
							from Cliente
							where id_cliente = @id_cliente)


	if(@id_tipo_cliente = 2)
	begin
		update Socio
		set baja_logica = 1
		where id_socio in (select id_socio
							from Cliente
							where id_cliente = @id_cliente)

		update Cliente
		set id_tipo_cliente = @id_tipo_cliente
		where id_cliente = @id_cliente
	end

	if (@id_tipo_cliente = 1)
	begin
		update Socio
		set baja_logica = 0
		where id_socio in (select id_socio
							from Cliente
							where id_cliente = @id_cliente)

		update Cliente
		set id_tipo_cliente = @id_tipo_cliente
		where id_cliente = @id_cliente
	end
	insert into Bitacora values(@id_usuario,GETDATE(),'Modificacion Cliente')

go


create procedure SP_Insertar_Socio(
	@id_cliente int,
	@dni bigint,
	@email varchar(100),
	@id_usuario int
)as	
	insert into Socio VALUES(@dni,@email,GETDATE(),0)

	declare @cod_socio int

	set @cod_socio = SCOPE_IDENTITY()

	update Cliente
	set id_socio = @cod_socio,
		id_tipo_cliente = 1
	where id_cliente = @id_cliente
	insert into Bitacora values(@id_usuario,GETDATE(),'Adhesion al club')



go

create procedure SP_BuscarSocioDni(
	 @DNI bigint
)as
	select id_socio
	from Socio
	where DNI = @DNI

go	

create procedure SP_BuscarCliente(
	@id int
)as
	select id_cliente
	from Cliente
	where id_cliente = @id

go

create procedure SP_Traer_TipoCliente
as
	select* from tipo_cliente

go

create procedure SP_BuscarUsuarioDNI(
	 @DNI bigint
)as
	select id_empleado
	from Empleado 
	where DNI = @DNI

go

create procedure SP_BuscarUsuarioAlias(
	 @Alias varchar(50)
)as
	select id_usuario
	from Usuarios 
	where alias = @Alias

go
create procedure SP_BuscarUsuarioID(
	 @id int,
	 @alias varchar(50)
)as
	select id_usuario
	from Usuarios 
	where id_usuario = @id and alias = @alias

go


create procedure SP_ObtenerClasificacion
as
	select * from Clasificacion where baja_logica = 0


go
create procedure SP_ObtenerTipoProducto
as
	select * from Tipo_producto where baja_logica = 0

go
create procedure SP_ObtenerUnidadMedida
as
	select * from Unidad_Medida where baja_logica = 0

go



create procedure SP_ObtenerProducto(
	@codicion int
)
as
	if (@codicion = 2)
	begin
		select id_producto,nombre,precio,detalle,stock,p.id_unidad_medida,um.unidad_Medida,c.id_clasificacion,c.clasificacion,tp.id_tipo_producto,tp.tipo_producto,p.baja_logica
		from Producto p 
		join unidad_Medida um on um.id_unidad_medida = p.id_unidad_medida
		join Clasificacion c on c.id_clasificacion = p.id_clasificacion
		join Tipo_producto tp on tp.id_tipo_producto = p.id_tipo_producto
	end
	else if(@codicion = 1)
	begin
		select id_producto,nombre,precio,detalle,stock,p.id_unidad_medida,um.unidad_Medida,c.id_clasificacion,c.clasificacion,tp.id_tipo_producto,tp.tipo_producto,p.baja_logica
		from Producto p 
		join unidad_Medida um on um.id_unidad_medida = p.id_unidad_medida
		join Clasificacion c on c.id_clasificacion = p.id_clasificacion
		join Tipo_producto tp on tp.id_tipo_producto = p.id_tipo_producto
		where p.baja_logica = 1

	end
	else if (@codicion = 0)
	begin
		select id_producto,nombre,precio,detalle,stock,p.id_unidad_medida,um.unidad_Medida,c.id_clasificacion,c.clasificacion,tp.id_tipo_producto,tp.tipo_producto,p.baja_logica
		from Producto p 
		join unidad_Medida um on um.id_unidad_medida = p.id_unidad_medida
		join Clasificacion c on c.id_clasificacion = p.id_clasificacion
		join Tipo_producto tp on tp.id_tipo_producto = p.id_tipo_producto
		where p.baja_logica = 0
	end

go

create procedure SP_AltaProducto(
	@nombre varchar(100) ,
	@precio money ,
	@detalle varchar(600),
	@stock int,
	@id_unidad_medida int,
	@id_tipo_producto int,
	@id_clasificacion int ,
	@baja_logica int,
	@id_usuario int
)as
	insert into Producto values (@nombre,@precio,@detalle,@stock,@id_unidad_medida,@id_tipo_producto,@id_clasificacion,@baja_logica)
	insert into Bitacora values(@id_usuario,GETDATE(),'Ingresar Producto')


go

create procedure SP_ModificarProducto(
	@id_producto int,
	@nombre varchar(100) ,
	@precio money ,
	@detalle varchar(600),
	@stock int,
	@id_unidad_medida int,
	@id_tipo_producto int,
	@id_clasificacion int ,
	@baja_logica int,
	@id_usuario int
)as
	update Producto
	set nombre = @nombre,
		precio = @precio,
		detalle = @detalle,
		stock = @stock,
		id_unidad_medida = @id_unidad_medida,
		id_tipo_producto = @id_tipo_producto,
		id_clasificacion = @id_clasificacion,
		baja_logica = @baja_logica
	where id_producto = @id_producto
	insert into Bitacora values(@id_usuario,GETDATE(),'Modificacion del producto')


go

create procedure SP_DetalleVenta(
	@id_nrofactura int,
	@id_producto int,
	@cantidad int,
	@importe money,
	@descripcion varchar(400)
)as
	insert into detalle_factura values (@id_nrofactura,@id_producto,@cantidad,@importe,@descripcion,0)

	update Producto
	set stock = stock - @cantidad
	where id_producto = @id_producto

	declare @stockactual int

	select @stockactual = stock 
	from Producto
	where id_producto = @id_producto

	if(@stockactual = 0)
	begin
		update Producto
		set baja_logica = 1
		where id_producto = @id_producto
	end


go
create  procedure SP_AltaVenta(
	@id_cliente int,
	@id_usuario int,
	@id_forma_compra int,
	@id_forma_entrega int,
	@tienedescuento int,
	@id_usuario_admin int,
	@IDFACTURA int Output
)as
	declare @diaweek int
	if (DATEPART(DW,GETDATE()) = 0)
		begin
			set @diaweek = 7
		end
	else
		begin
			set @diaweek = DATEPART(DW,GETDATE() - 1)
		end

	if(@tienedescuento = 0)
	begin 
		insert into Factura values(GETDATE(),@id_cliente,@id_usuario,@id_forma_compra,@id_forma_entrega,@diaweek,0)
	set @IDFACTURA = SCOPE_IDENTITY()
	end
	else
	begin
		insert into Factura values(GETDATE(),@id_cliente,@id_usuario,@id_forma_compra,@id_forma_entrega,null,0)
	set @IDFACTURA = SCOPE_IDENTITY()
	end

	insert into Bitacora values(@id_usuario_admin,GETDATE(),'Registro de venta')


go

create  procedure SP_ObtenerFormaCompra
as
	select * from Forma_compra 

go

create  procedure SP_ObtenerFormaEntrega
as
	select * from forma_entrega 

go


create  procedure SP_ObtenerCondicionesDescuento
as
begin
	declare @diaweek int
	if (DATEPART(DW,GETDATE()) = 0)
		begin
			set @diaweek = 7
		end
	else
		begin
			set @diaweek = DATEPART(DW,GETDATE() - 1)
		end

	
	SELECT descuentos_socios,compras_presenciales, d.porcentaje_descuento
	from Configuracion C
	join Descuento d on d.id_descuento = @diaweek
end

go

create procedure SP_TraerClientesCbo(
	@socios int
)
as
	if(@socios = 0)
	begin
		select id_cliente, nombre + SPACE(1) + apellido'Nombre Completo'
		from Cliente c
		join Socio s on c.id_socio = s.id_socio
		where s.baja_logica = 0
	end
	else
	begin
		select id_cliente, c.nombre + SPACE(1) + c.apellido'Nombre Completo'
		from Cliente c
		left join Socio s on s.id_socio = c.id_socio
		where (s.id_socio is null) or (s.baja_logica = 1)
	end
go



create  procedure SP_ObtenerFactura
as
	select nro_factura, CONVERT(VARCHAR, fecha, 108)'Hora',CONVERT(VARCHAR, fecha, 105)'Fecha', c.nombre + SPACE(1) + c.apellido'Nombre_Completo'
	, e.nombre + SPACE(1) + e.apellido 'Nombre_CompletoUsuario', fc.forma_compra,fe.forma_entrega, d.porcentaje_descuento,fecha
	from Factura f
	left join Descuento d on f.id_descuento = d.id_descuento
	join Cliente c on c.id_cliente = f.id_cliente
	join Usuarios u on u.id_usuario = f.id_usuario
	join Empleado e on e.id_empleado = u.id_empleado
	join forma_entrega fe on fe.id_forma_entrega = f.id_forma_entrega
	join Forma_compra fc on fc.id_forma_compra = f.id_forma_compra

go

create procedure SP_ObtenerDetalles(
	@id_f int
)as
		select df.id_producto,nombre,detalle,p.id_unidad_medida,um.unidad_Medida,c.id_clasificacion,c.clasificacion,tp.id_tipo_producto,tp.tipo_producto,df.cantidad,df.descripcion,df.importe
		from Producto p 
		join unidad_Medida um on um.id_unidad_medida = p.id_unidad_medida
		join Clasificacion c on c.id_clasificacion = p.id_clasificacion
		join Tipo_producto tp on tp.id_tipo_producto = p.id_tipo_producto
		join detalle_factura df on df.id_producto = p.id_producto
		where nro_factura = @id_f

go


create  procedure SP_RegistroBitacoraLogin(
	@id_usuario int
)as
	insert into Bitacora values(@id_usuario,GETDATE(),'Inicio de sesion')


go

create procedure SP_RegistroBitacoraLogout(
	@id_usuario int
)as
	insert into Bitacora values(@id_usuario,GETDATE(),'Cierre de sesion')

go

create  procedure SP_GetTipoProducto(
	@a int
)as
	if(@a = 0)
	begin
		select * from Tipo_producto where baja_logica = 0
	end
	else if (@a = 1)
	begin
			select * from Tipo_producto where baja_logica = 1

	end
	else 
	begin
			select * from Tipo_producto
	end

go

create  procedure SP_GetClasificacion(
	@a int
)as
	if(@a = 0)
	begin
		select * from Clasificacion where baja_logica = 0
	end
	else if (@a = 1)
	begin
			select * from Clasificacion where baja_logica = 1

	end
	else 
	begin
			select * from Clasificacion
	end

go

create procedure SP_GetUnidadMedida(
	@a int
)as
	if(@a = 0)
	begin
		select * from Unidad_Medida where baja_logica = 0
	end
	else if (@a = 1)
	begin
			select * from Unidad_Medida where baja_logica = 1

	end
	else 
	begin
			select * from Unidad_Medida
	end

go


create  procedure SP_AltaClasificacion(
	@nombre varchar(50)
)as
	insert into Clasificacion values(@nombre,0)

go


create  procedure SP_AltaUnidadMed(
	@nombre varchar(50)
)as
	insert into Unidad_Medida values(@nombre,0)

go


create procedure SP_AltaTipoProd(
	@nombre varchar(50)
)as
	insert into Tipo_producto values(@nombre,0)


go

create  procedure SP_MODClasificacion(
	@id int,
	@nombre  varchar(50),
	@baja_logica int
)as	
	update Clasificacion
	set baja_logica = @baja_logica,
		clasificacion = @nombre
	where id_clasificacion = @id

go

create  procedure SP_MODUnidadMed(
	@id int,
	@nombre  varchar(50),
	@baja_logica int
)as	
	update Unidad_Medida
	set baja_logica = @baja_logica,
		Unidad_Medida = @nombre
	where id_unidad_medida = @id


go


create procedure SP_MODTipoProd(
	@id int,
	@nombre  varchar(50),
	@baja_logica int
)as	
	update Tipo_producto
	set baja_logica = @baja_logica,
		tipo_producto = @nombre
	where id_tipo_producto = @id

go


create  procedure SP_RecaudoDiario
as
	Select SUM(cantidad * importe)'Recaudado Hoy'
	from detalle_factura df
	join Factura f on df.nro_factura = f.nro_factura
	where day(f.fecha) = day(GETDATE()) and MONTH(f.fecha) = Month(GETDATE()) and YEAR(f.fecha) = Year(GETDATE())
	group by day(f.fecha), MONTH(f.fecha),YEAR(f.fecha)

go

create  procedure SP_VentasHoy
as
	Select COUNT(nro_factura)'Ventas Hoy'
	from Factura
	where day(fecha) = day(GETDATE()) and MONTH(fecha) = Month(GETDATE()) and YEAR(fecha) = Year(GETDATE())
	group by day(fecha), MONTH(fecha),YEAR(fecha)

go

create  procedure SP_VentasMes
as
	Select COUNT(nro_factura)'Ventas Mes'
	from Factura
	where MONTH(fecha) = Month(GETDATE()) and YEAR(fecha) = Year(GETDATE())
	group by MONTH(fecha),YEAR(fecha)

go


create  procedure SP_BajarAlias(
	@Alias varchar(50)
)as
	update Usuarios
	set baja_logica = 1
	where alias = @Alias

go


insert into Descuento values ('Lunes',0,0)
insert into Descuento values ('Martes',0,0)
insert into Descuento values ('Miercoles',0,0)
insert into Descuento values ('Jueves',0,0)
insert into Descuento values ('Viernes',0,0)
insert into Descuento values ('Sabado',0,0)
insert into Descuento values ('Domingo',0,0)


insert into Roles values('Gerente','Encargado de la gestión del negocio, teniendo acceso a todos los módulos del sistema',0)
insert into Roles values('Representante Tècnico','Responsable de darle mantenimiento y futuras actualizaciones al sistema',0)
insert into Roles values('Administrativo','Responsable de la parte administrativa del negocio',0)
insert into Roles values('Contador','Encargado de la parte contable, sólo tendrá acceso a los módulos de facturación y ventas',0)
insert into Roles values('Encargados','Encargados de controlar el Productos y a los vendedores',0)
insert into Roles values('Vendedores','Responsables de las ventas de los productos a los clientes, además de informar ofertas y beneficios. También adhieren o desligan miembros del Club',0)

insert into Configuracion values (1,0,0,'-','-','-','-','-','-')

insert into tipo_cliente values ('Socio')
insert into tipo_cliente values ('No Socio')

insert into forma_entrega values ('Delivery a Domicilio')
insert into forma_entrega values ('Retiro en el local')

insert into Forma_compra values ('Telefonica')
insert into Forma_compra values ('Presencial')


insert into Empleado values (22222,'Admin','Admin','Admin','2022/02/02',3333333,0)
insert into Usuarios values ('Admin','seQjY0IBoCE=',1,1,0)


