CREATE DATABASE Proyecto_BD2
GO

USE Proyecto_BD2
GO

Alter authorization on database::Proyecto_BD2 to sa 
SET DATEFORMAT dmy
SET LANGUAGE spanish
GO

CREATE TABLE Sucursales(
	ID_Sucursal  INT IDENTITY(1,1) NOT NULL,
	Nombre  VARCHAR (30) NULL,
	Telefono   INT NULL,
	Localidad  VARCHAR (30) NULL,

	CONSTRAINT PK_ID_Sucursal PRIMARY KEY (ID_Sucursal ASC),
)
GO

CREATE TABLE Distribuidores(
	ID_Distribuidor  INT IDENTITY(1,1) NOT NULL,
	Nombre  VARCHAR (30) NULL,
	Telefono   INT NULL,
	Email  VARCHAR (50) NULL,
	ID_Sucursal  INT  NOT NULL,

	CONSTRAINT PK_ID_Distribuidor PRIMARY KEY (ID_Distribuidor ASC),
	CONSTRAINT FK_ID_Sucursal_Distribuidores  FOREIGN KEY (ID_Sucursal) REFERENCES Sucursales(ID_Sucursal),
)
GO

CREATE TABLE Repuestos(
	ID_Repuestos  INT IDENTITY(1,1) NOT NULL,
	Nombre  VARCHAR (30) NULL,
	Cantidad INT NULL,
	Marca  VARCHAR (30) NULL,
	Precio INT NULL,
	Descripcion  VARCHAR (150) NULL,
	ID_Distribuidor INT  NOT NULL,

	CONSTRAINT PK PRIMARY KEY (ID_Repuestos ASC),
	CONSTRAINT FK_ID_Distribuidor_Repuestos FOREIGN KEY (ID_Distribuidor) REFERENCES Distribuidores(ID_Distribuidor),

)
GO

CREATE TABLE Inventario(
	ID_Inventario INT IDENTITY(1,1) NOT NULL,
	ID_Repuestos INT  NOT NULL,

	CONSTRAINT PK_ID_Inventario PRIMARY KEY (ID_Inventario ASC),
	CONSTRAINT FK_ID_Repuestos_Inventario FOREIGN KEY (ID_Repuestos) REFERENCES Repuestos(ID_Repuestos),
)
GO

CREATE TABLE Cita(
    ID_Cita INT IDENTITY(1,1) NOT NULL,
    Fecha_Cita DATETIME NULL,
    Asistencia BIT NULL,

    CONSTRAINT PK_ID_Cita PRIMARY KEY (ID_Cita ASC),
)
GO

CREATE TABLE Revision(
    ID_Revision INT IDENTITY(1,1) NOT NULL, 
    Descripcion VARCHAR(150) NULL,

    CONSTRAINT PK_ID_Revision PRIMARY KEY (ID_Revision ASC),
)
GO

CREATE TABLE Personal(
    ID_Personal INT IDENTITY(1,1) NOT NULL, 
    Nombre VARCHAR(30) NULL, 
    Apellido VARCHAR(50) NULL,
    Puesto VARCHAR(20) NULL, 
    Telefono INT NULL, 
    Email VARCHAR(50) NULL, 
	ID_Cita INT NOT NULL,
	ID_Revision INT NOT NULL,


    CONSTRAINT PK_ID_Personal PRIMARY KEY (ID_Personal ASC),
	CONSTRAINT FK_Cita_Personal FOREIGN KEY (ID_Cita) REFERENCES Cita(ID_Cita),
	CONSTRAINT FK_Revision_Personal FOREIGN KEY (ID_Personal) REFERENCES Revision (ID_Revision),
)
GO

CREATE TABLE Tipo_Vehiculo (
	ID_Tipo_Vehiculo INT NOT NULL,
	Modelo VARCHAR (20) NULL,
	Traccion VARCHAR(50) NULL,
	Transmision VARCHAR(50) NULL,
	Año INT NULL,

	CONSTRAINT PK_Tipo_Vehiculo PRIMARY KEY(ID_Tipo_Vehiculo ASC),
)
GO


CREATE TABLE Vehiculo(
	Placa VARCHAR (20) NOT NULL,
	Falla VARCHAR (150) NULL,
	Color VARCHAR (20) NULL,
	ID_Personal INT NOT NULL,
	ID_Tipo_Vehiculo INT NOT NULL,

	CONSTRAINT PK_Placa PRIMARY KEY (Placa),
	CONSTRAINT FK_Personal_Vehiculo FOREIGN KEY (ID_Personal) REFERENCES Personal (ID_Personal),
	CONSTRAINT FK_Tipo_Vehiculo_Vehiculo FOREIGN KEY (ID_Tipo_Vehiculo) REFERENCES Tipo_Vehiculo (ID_Tipo_Vehiculo),
)
GO

CREATE TABLE Cliente(
	ID_Cliente INT IDENTITY(1,1) NOT NULL,
	Nombre VARCHAR(30) NULL,
	Apellido VARCHAR(50) NULL,
	Telefono INT NULL,
	Domicilio VARCHAR(100) NULL,
	Email VARCHAR(50) NULL,
	ID_Cita INT NOT NULL,
	ID_Revision INT NOT NULL,

	CONSTRAINT PK_ID_Cliente PRIMARY KEY(ID_Cliente),
	CONSTRAINT FK_ID_Revision_Cliente FOREIGN KEY (ID_Revision) REFERENCES Revision (ID_Revision),
	CONSTRAINT FK_ID_Cita_Cliente FOREIGN KEY (ID_Cita) REFERENCES Cita (ID_Cita),
)
GO

CREATE TABLE Ventas (
	ID_Ventas INT IDENTITY(1,1) NOT NULL,
	Costo_Total INT NULL,
	ID_Repuestos  INT NOT NULL,
	ID_Personal INT NOT NULL,
	ID_Cliente INT NOT NULL,

	CONSTRAINT PK_ID_Ventas PRIMARY KEY(ID_Ventas),
	CONSTRAINT FK_Repuestos_Ventas FOREIGN KEY (ID_Repuestos) REFERENCES Repuestos (ID_Repuestos),
	CONSTRAINT FK_Personal_Ventas FOREIGN KEY (ID_Personal) REFERENCES Personal (ID_Personal),
	CONSTRAINT FK_Cliente_Ventas FOREIGN KEY (ID_Cliente) REFERENCES Cliente (ID_Cliente),
)
GO