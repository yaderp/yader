
CREATE PARTITION FUNCTION pf_clientes (char(8))
AS RANGE LEFT 
FOR VALUES ('09203040', '10203040', '40203040');
GO

CREATE PARTITION SCHEME ps_clientes
AS PARTITION pf_clientes 
TO ('FG02','FG01','FG04','FG03') 
GO

create table Clientes(
	id int,
	nombres varchar(125),
	apellidos varchar(125),
	dni char(8),
	fechaNacimiento date
) on ps_clientes(dni)

create table ClientesHistorico (
	id int,
	nombres varchar(125),
	apellidos varchar(125),
	dni char(8),
	fechaNacimiento date
)on FG04

alter table Clientes
switch partition 3
to ClientesHistorico

alter partition scheme ps_clientes
next used 'FG05'

alter partition function pf_clientes()
split range ('45203040')

alter partition function pf_clientes()
merge range ('09203040')

CREATE NONCLUSTERED INDEX NonClustered_Ape
ON Clientes (apellidos)
INCLUDE (nombres)
WITH (FILLFACTOR = 70, ONLINE = ON); 
GO


DECLARE @intXML INT;
DECLARE @textXML VARCHAR(MAX);
SET @textXML='
<Contactos>
	<Contacto id="10">
		<Nombre>Juan</Nombre>
		<Apellido>Perez</Apellido>
		<Edad>20</Edad>
	</Contacto>	
</Contactos>
';
EXEC sp_xml_preparedocument @intXML OUTPUT, @textXML;

--Print @intXMl a partir de una tabla
--INSERT INTO Contactos
SELECT * FROM OPENXML (@intXML, 'Contactos/Contacto',3)
WITH Contactos



declare @intXML int;
declare @textXML varchar(max);
set @textXML='<Lista codigo="S01">
				<Contacto id="10"><Nombre>Juan</Nombre><Apellido>Perez</Apellido><Edad>20</Edad></Contacto>
	<Contacto id="11"><Nombre>Juana</Nombre><Apellido>Pereyra</Apellido><Edad>30</Edad></Contacto>
	<Contacto id="12"><Nombre>John</Nombre><Apellido>Doe</Apellido><Edad>25</Edad></Contacto>
         	     	
</Lista>';
exec sp_xml_preparedocument @intXML output, @textXML;
--insert into pedidos1 --(Una vez verificado se inserta)
select * from openxml (@intXML, 'Lista/Contacto', 3) -- with pedidos1 --(Una tabla que ya esta)
with (
   	total varchar(10) 'Nombre',
   	cliente int '@id',
   	sucursal char(3) '../@codigo'
   	)

Declare @dataXML as XML;
Set @dataxML= '<Contactos>
	<Contacto id="10"><Nombre>Juan</Nombre><Apellido>Perez</Apellido><Edad>20</Edad></Contacto>
	<Contacto id="11"><Nombre>Juana</Nombre><Apellido>Pereyra</Apellido><Edad>30</Edad></Contacto>
	<Contacto id="12"><Nombre>John</Nombre><Apellido>Doe</Apellido><Edad>25</Edad></Contacto>
</Contactos>'
Select @dataXML.query('for $i in //Contactos 
return 
<Resumen>
<Maxima>{ max($i/Contacto/Edad) }</Maxima>
<Minima>{ min($i/Contacto/Edad) }</Minima>
<Promedio>{ avg($i/Contacto/Edad) }</Promedio>
<Contactos>{ count($i/Contacto) }</Contactos>
</Resumen>')

/*
2. Genere el Siguente XML

<ListadoClientes>
	<Cliente ID="4">
		<Detalle Nombre="Kimberly">
			<Genero>Femenino</Genero>
		</Detalle>
		<Venta ID="3">
			<Total>3876.00</Total>
			<Fecha>2014-09-23T00:00:00</Fecha>
		</Venta>
	</Cliente>
</ListadoClientes>


Solución:
select
   	c.id as "@ID",
   	c.nombres + ' ' + c.apellidos as "Detalle/@Nombre",
   	case sexo when 0 then 'Femenino' when 1 then 'Masculino' end as "Detalle/Genero",
   	v.id as "Venta/@ID",
   	v.total as "Venta/Total",
   	v.fecha as "Venta/Fecha"
from clientes c
inner join ventas v on v.cliente_id=c.id
for xml path ('Cliente') , root('ListadoClientes')
*/

/* Tablas particinadas
Es una tabla en la que los datos se separan horizontalmente en varias ubicaciones físicas.
Las ubicaciones físicas para las particiones son los filegroups.
Ventajas -> Se puede obtener acceso a un subconjunto de datos de forma más rápida.
Mejorar el rendimiento de las consultas en función a los tipos de consultas que se ejecutan de forma más seguida.
Componentes -> Función de partición  Esquema de partición Columna de partición
Índices uso de índices para mejorar el desempeño de una base de datos. Permiten la rápida ubicación de los datos que son solicitados a través de consultas.
C->Los datos se ordenan físicamente de acuerdo al índice creado.
NC->Los índices de este tipo no afectan el orden de las filas de datos.
>5% y <= 30%  REORGANIZE - > 30% REBUILD
Qué es XML -> un estándar para el intercambio de información entre plataformas.
FOR XML Cuando ejecutamos una sentencia SELECT en la base de datos, el resultado se nos presenta como un conjunto de filas.
OPENXML  Nos brinda un conjunto de filas en documentos XML en memoria.
XQuery se utiliza para poder realizar consultas a datos XML que están almacenados en tipos de datos o variables xml en SQL Server.
Esta construido sobre el lenguaje XPath.
Copias de seguridad
El objetivo de realizar una copia de seguridad a una base de datos es que pueda ser recuperada cuando ocurra una pérdida de datos o no pueda ser accedida ante algún desastre.
Al realizar copias de seguridad se busca minimizar la pérdida de datos
Full Todo se registra.
Bulk – logged  Sólo las operaciones en volumen no se registran.
Simple El log de transacciones sólo sirve para soportar las transacciones y regularmente es truncado.
Full backup - Full + Differential backup  - Full + Differential + Transaction log backup
Report services SSRS es una plataforma de reportes basada en servidor que nos permite generar reportes desde varios orígenes de datos.
Report Builder Es un entorno de creación de informes destinado a los usuarios que prefieren trabajar en un entorno del tipo Microsoft Office.
data source proporciona detalles acerca de cómo conectarse a un origen de datos.
Un dataset especifica los campos del origen de datos que se van a usar en el informe.

Matriz Permiten mostrar resúmenes de datos agregados, que se encuentren agrupados en filas y columnas.
*/