--*******************************************
--Bases de datos : Introduccion SQL
--*******************************************

--1.0 CREADNO TABLAS
--1.1 Creando tabla hotel
/*CREATE TABLE HOTEL (
id INT, 
nombre VARCHAR(50), 
direccion VARCHAR(50), 
telefono CHAR(12)
);

--1.1.1 Mostrando la tabla
-- Opción 1
SELECT id, nombre, direccion, telefono FROM HOTEL;
-- Opción 2
SELECT * FROM HOTEL;
-- Opción 3
SELECT  nombre, telefono FROM HOTEL;

--1.2 Insertando datos en tabla
	/*
	Id: 1
	Hotel: Real Inrtercontinental 
	Dirección: San Salvador
	Teléfono: +50324234992
	*/
	/*
	Id: 2
	Hotel: Crowne Plaza
	Dirección: ---
	Teléfono: +50325008446
	*/
	/*
	Id: ---
	Hotel: Quiality Hotel Real Aeropuerto
	Dirección: ---
	Teléfono: +50325008446
	*/
	INSERT INTO HOTEL (id, nombre, direccion, telefono)
	VALUES (1, 'Real Intercontinental', 'San Salvador', '+50324234992' );
	INSERT INTO HOTEL (id, nombre, direccion, telefono)
	VALUES (2, 'Crowne Plaza', 'NULL', '+50325008446' );
	INSERT INTO HOTEL ( nombre,  telefono)
	VALUES ('Quality Hotel Real Aeropuerto', '+50325008446' );
	INSERT INTO HOTEL (id, nombre, direccion, telefono)
	VALUES (2, 'Crowne Plaza', 'NULL', '+50325008446' );
--Mostrando datos
SELECT * FROM HOTEL;

-- 1.3 Mosrtar toda la información de la tabla
--1.1.1 Mostrando la tabla
-- Opción 1
SELECT id, nombre, direccion, telefono FROM HOTEL;
-- Opción 2
SELECT * FROM HOTEL;

--1.4 Mostrando algunas columnas
-- Opción 3
SELECT  nombre, telefono FROM HOTEL;
--1.5 El orden de selecicion de columnas no importa
SELECT  direccion, nombre, telefono, id FROM HOTEL;

--1.6 Borrando tabla
DROP TABLE HOTEL;	
--2.0 Restricciones
--2.1 Creando tabla HOTEL con columnas NULL (por defecto)/NOT NULL (Insertar hoteles 1,2 y 3)
CREATE TABLE HOTEL (
id INT NULL, 
nombre VARCHAR(50) NOT NULL, 
direccion VARCHAR(50) NULL, 
telefono CHAR(12) NOT NULL
);
--2.2 Creando llave primaria
--2.2.1 A través del comando ALTER
ALTER TABLE HOTEL ADD CONSTRAINT pk_hotel PRIMARY KEY (id);--esto falla
--Modificando tabla para poder configurar llave primaria
ALTER TABLE HOTEL ALTER COLUMN id INT NOT NULL;
ALTER TABLE HOTEL ADD CONSTRAINT pk_hotel PRIMARY KEY (id);
--Insertando informacion
	INSERT INTO HOTEL (id, nombre, direccion, telefono)
	VALUES (1, 'Real Intercontinental', 'San Salvador', '+50324234992' );
	INSERT INTO HOTEL (id, nombre, direccion, telefono)
	VALUES (2, 'Crowne Plaza', 'NULL', '+50325008446' );
	INSERT INTO HOTEL ( nombre, direccion, telefono)
	VALUES ('Quality Hotel Real Aeropuerto','direccion 123', '+50325008446' );
	INSERT INTO HOTEL (id, nombre, direccion, telefono)
	VALUES (2, 'Crowne Plaza', 'NULL', '+50325008446' );
	-- mostrnado tabla
	SELECT * FROM HOTEL;
	-- eliminando tabla
	DROP TABLE HOTEL;*/
	-- 2.2.3 Definir llave primaria cuando se crea tabla (forma mas sencilla)
CREATE TABLE HOTEL (
	id INT PRIMARY KEY,--LLAVE PRIMARIA 
	nombre VARCHAR(50) NOT NULL, 
	direccion VARCHAR(50) NULL DEFAULT 'Direccion no definida', --DEFAULT ES PARA QUE TIRE UN DATO EN EL NULL 
	telefono CHAR(12) NOT NULL UNIQUE --UNIQUE ES PARA QUE NO SE REPITAN DATOS
);
DROP TABLE HOTEL;
	INSERT INTO HOTEL (id, nombre, direccion, telefono)
	VALUES (1, 'Real Intercontinental', 'San Salvador', '+50324234992' );
	INSERT INTO HOTEL (id, nombre, direccion, telefono)
	VALUES (2, 'Crowne Plaza', NULL, '+50325008446' );
	INSERT INTO HOTEL ( id, nombre, telefono)
	VALUES (3, 'Quality Hotel Real Aeropuerto', '+50325008445' );
SELECT * FROM HOTEL;
	-- 2.2.4 Definir llave primaria al final de la definicion de la tabla (insertar)
/*CREATE TABLE HOTEL (
	id INT, 
	nombre VARCHAR(50) NOT NULL, 
	direccion VARCHAR(50) NULL, 
	telefono CHAR(12) NOT NULL
	CONSTRAINT pk_hotel PRIMARY KEY (id)
);*/
---Restricciones CHECK
---Crear las tables HOTEL Y HABITACIÓN con las siguientes restricciones:
---		-Campo teléfono de HOTEL debe tener el formato:
---			-Debe incluir el identificador de país +503
---			-El formato oficial de un teléfono debe iniciar con los digitos 2,6 y 7.
---			-El número de teléfono actualñ tiene 8 digitos de longitud.
---		-Campo número de HABITACIÓN debe tener el formato:
---			-Número mayor que 0

CREATE TABLE HABITACION(
	id INT PRIMARY KEY,
	numero INT NOT NULL CHECK(numero > 0),
	precio MONEY NOT NULL,
	id_hotel INT NULL
);

CREATE TABLE HOTEL (
	id INT PRIMARY KEY,--LLAVE PRIMARIA 
	nombre VARCHAR(50) NOT NULL, 
	direccion VARCHAR(50) NULL DEFAULT 'Direccion no definida', --DEFAULT ES PARA QUE TIRE UN DATO EN EL NULL 
	telefono CHAR(12) NOT NULL UNIQUE CHECK (telefono LIKE '+503[2|6|7][0-9][0-9][0-9][0-9][0-9][0-9][0-9]' )--UNIQUE ES PARA QUE NO SE REPITAN DATOS
);
--Insertando datos
	INSERT INTO HOTEL (id, nombre, direccion, telefono)
	VALUES (1, 'Real Intercontinental', 'San Salvador', '+50324234992' );
	INSERT INTO HOTEL (id, nombre, direccion, telefono)
	VALUES (2, 'Crowne Plaza', NULL, '+50325008446' );
	INSERT INTO HOTEL ( id, nombre, telefono)
	VALUES (3, 'Quality Hotel Real Aeropuerto', '+50325008445' );
SELECT * FROM HOTEL;

	INSERT INTO HABITACION (id, numero, precio, id_hotel)
	VALUES	(1, 1, 123.50, 1);
	INSERT INTO HABITACION (id, numero, precio, id_hotel)
	VALUES	(2, 2, 200.00, 1);
	INSERT INTO HABITACION (id, numero, precio, id_hotel)
	VALUES	(3, 5, 100.00,35);
	INSERT INTO HABITACION (id, numero, precio, id_hotel)
	VALUES	(4, 2, 123.50, NULL);
	SELECT * FROM HABITACION;
	SELECT * FROM HOTEL;

	DROP TABLE HOTEL;
	DROP TABLE HABITACION;

CREATE TABLE HOTEL (
	id INT PRIMARY KEY,--LLAVE PRIMARIA 
	nombre VARCHAR(50) NOT NULL, 
	direccion VARCHAR(50) NULL DEFAULT 'Direccion no definida', --DEFAULT ES PARA QUE TIRE UN DATO EN EL NULL 
	telefono CHAR(12) NOT NULL UNIQUE CHECK (telefono LIKE '+503[2|6|7][0-9][0-9][0-9][0-9][0-9][0-9][0-9]' )--UNIQUE ES PARA QUE NO SE REPITAN DATOS
);
CREATE TABLE HABITACION(
	id INT PRIMARY KEY,
	numero INT NOT NULL CHECK(numero > 0),
	precio MONEY NOT NULL,
	id_hotel INT NOT NULL,
	CONSTRAINT fk_hotel FOREIGN KEY (id_hotel) REFERENCES HOTEL (id) --FROMA DE LLAVE FORANEA
);

--Creando llave foranea
ALTER TABLE HABITACION ADD FOREIGN KEY (id_hotel) REFERENCES HOTEL (id) ON DELETE CASCADE;

--Intentado insertar bloque de informacion

	INSERT INTO HOTEL (id, nombre, direccion, telefono)
	VALUES (1, 'Real Intercontinental', 'San Salvador', '+50324234992' );
	INSERT INTO HOTEL (id, nombre, direccion, telefono)
	VALUES (2, 'Crowne Plaza', NULL, '+50325008446' );
	INSERT INTO HOTEL ( id, nombre, telefono)
	VALUES (3, 'Quality Hotel Real Aeropuerto', '+50325008445' );

	INSERT INTO HABITACION (id, numero, precio, id_hotel)
	VALUES	(1, 1, 123.50, 1);
	INSERT INTO HABITACION (id, numero, precio, id_hotel)
	VALUES	(2, 2, 200.00, 1);
	INSERT INTO HABITACION (id, numero, precio, id_hotel)
	VALUES	(3, 5, 100.00,3);
	INSERT INTO HABITACION (id, numero, precio, id_hotel)
	VALUES	(4, 2, 123.50, 2);
	SELECT * FROM HOTEL;
	SELECT * FROM HABITACION;
--Borrar hotel(se puede borrar si que tengan relación)
DELETE FROM HOTEL WHERE id = 1;	