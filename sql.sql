/*
enterprise sistema, 524PB	core-based
BI			128GB	524PB	server + cal
Stantard	128GB	524PB   Core-Based o server +cal
web			64GB	524PB
Express		1GB		10GB

master informacion del servidor para una isntancia determinada
msdb	usada por el servidor para la programacion de atreas y alertas
model	sirve como plantilla nuevas base de datos
tempdb	mantiene objetos temporales y resultados intermedios
resource	es una BD de solo lectura

procedimientos
permiten obtener informacion de la bae de datos y sus objetos

unidad fundamental de almacenamiento pagina 8kb(8060 bytes)
paginas: Mixtas y uniformes

squemas	permiten agrupar de manera logica las tablas, procedimientos almacenados y vistas

snapshots	vista estatica y e solo lectura
*/
CREATE PARTITION FUNCTION pf_fecha(date)
AS RANGE LEFT
FOR VALUES ('01/01/2005','01/01/2010', '01/01/2015')

CREATE PARTITION SCHEME ps_fecha
AS PARTITION pf_fecha
TO ('FG01','FG02','FG03','FG04')

CREATE TABLE Usuarios(
	id int not null,
	nombres varchar(125),
	apellidos varchar(125),
	direccion varchar(250),
	fechaRegistro DATE,
	estado tinyint
) ON ps_fecha(fechaRegistro)


alter partition scheme ps_fecha
next used FG05

alter partition function pf_fecha()
split range ('01/01/2017')

alter partition function pf_fecha()
merge range ('01/01/2005')


CREATE TABLE UsuariosHistoricos1(
	id int not null,
	nombres varchar(125),
	apellidos varchar(125),
	direccion varchar(250),
	fechaRegistro DATE,
	estado tinyint
) on FG03

ALTER TABLE Usuarios
SWITCH PARTITION 3
TO UsuariosHistoricos1


create table personas(
	id int identity primary key,
	nombres varchar(75) not null,
	apellido varchar(75) not null,
	dni varchar(8) unique,
	fecharegistro datetime default getdate(),
	edad int check(edad >= 18)
)

alter table personas
add constraint [ck_leng_dni] check(len(dni)=8)
GO

SP_HELPDB Parcial

create database Parcial_ss on 
(
	name ='Parcial_data01',
	filename ='C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\Semana02_data01_ss_1903280842.ss'
),
(
	name ='Parcial_data02',
	filename ='C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\Semana02_data02_ss_1903280842.ss'
)
as snapshot of Parcial


CREATE TRIGGER tr_EliminaCategoria ON categorias
INSTEAD OF DELETE
AS
BEGIN
    SET NOCOUNT ON
	declare @categoriaID int 
	if exists(select *from deleted)
	begin
		set @categoriaID =(select id from deleted)
		update categorias
		set estado = 2
		where id =@categoriaID

		update productos
		set estado = 2
		where categoria_id = @categoriaID
	end
END
GO

CREATE PROCEDURE dbo.Actu_inser_Cliente 
     @nombres varchar(50), @apellidos varchar(50), @sexo tinyint, 
	@pais varchar(20), @estado int, @clienteID int output
AS
	set nocount on
	
	if @clienteID < 0
	begin
		insert into  clientes values (@nombres, @apellidos, @sexo, @pais, 1)
		set @clienteID = SCOPE_IDENTITY()
		insert into LogEventos values(@clienteID,'Insert',GETDATE())
		return 0
	end
	else
	begin
		update clientes
		set nombres = @nombres,
			apellidos = @apellidos,
			sexo = @sexo,
			pais = @pais,
			estado = @estado
		where id = @clienteID
		insert into LogEventos values(@clienteID,'update',GETDATE())		
		return 1
	end
go

declare @IDCliente int
declare @ReturnValue int
set @IDCliente = 16   --  idCliente negativo es para insertar  //  positivo y existente para actualizar
exec @ReturnValue = Actu_inser_Cliente @nombres='nombre02', @apellidos='Apellido02',@sexo=0, @pais='pais02', @estado=0, @clienteID = @IDCliente output

print @IDCliente
print @ReturnValue
