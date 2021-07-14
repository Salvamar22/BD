--****************************************************
-- Bases de datos: 14 Joins
-- Autor: Erick Varela
-- Correspondencia: evarela@uca.edu.sv
-- Version: 1.0
--****************************************************
USE HotelManagementDB;
SET LANGUAGE us_english
--*****************************************************

-- 1.0 Descubriendo la utilidad de cada JOIN
-- 1.1 Antes agregamos un par de clientes sin tener definido un pais de procedencia: 
INSERT INTO cliente VALUES(26,'Finley Armstrong',NULL,'farm@maiw.yom',3);
INSERT INTO cliente VALUES(27,'Naomi Lee',NULL,'kkkk@mail.net',4);

SELECT * FROM CLIENTE;

-- 1.2 INNER JOIN
SELECT PAIS.id, PAIS.pais, CLIENTE.nombre, CLIENTE.id_pais, CLIENTE.correo
FROM PAIS 
	INNER JOIN CLIENTE 
ON PAIS.id = CLIENTE.id_pais;

-- 1.3 LEFT JOIN
SELECT PAIS.id, PAIS.pais, CLIENTE.nombre, CLIENTE.id_pais, CLIENTE.correo
FROM PAIS 
	LEFT JOIN CLIENTE 
ON PAIS.id = CLIENTE.id_pais;

-- 1.3.1 LEFT JOIN
SELECT PAIS.id, PAIS.pais, CLIENTE.nombre, CLIENTE.id_pais, CLIENTE.correo
FROM PAIS 
	LEFT JOIN CLIENTE 
ON PAIS.id = CLIENTE.id_pais
WHERE CLIENTE.id_pais IS NULL;

-- 1.3.2 LEFT JOIN
SELECT PAIS.id, PAIS.pais
FROM PAIS 
	LEFT JOIN CLIENTE 
ON PAIS.id = CLIENTE.id_pais
WHERE CLIENTE.id_pais IS NULL;

-- 1.4 RIGHT JOIN
SELECT PAIS.id, PAIS.pais, CLIENTE.nombre, CLIENTE.id_pais, CLIENTE.correo
FROM PAIS 
	RIGHT JOIN CLIENTE 
ON PAIS.id = CLIENTE.id_pais;

-- 1.4.1 RIGHT JOIN
SELECT  CLIENTE.nombre, CLIENTE.correo
FROM PAIS 
	RIGHT JOIN CLIENTE 
ON PAIS.id = CLIENTE.id_pais
WHERE PAIS.id IS NULL;

-- 1.5 FULL JOIN
SELECT PAIS.id, PAIS.pais, CLIENTE.nombre, CLIENTE.id_pais, CLIENTE.correo
FROM PAIS 
	FULL JOIN CLIENTE 
ON PAIS.id = CLIENTE.id_pais
WHERE PAIS.id IS NULL OR CLIENTE.id IS NULL;
-- 1.5.1 FULL JOIN
SELECT PAIS.id, PAIS.pais, CLIENTE.nombre, CLIENTE.id_pais, CLIENTE.correo
FROM PAIS 
	INNER JOIN CLIENTE 
ON PAIS.id = CLIENTE.id_pais;

-- 2.0 Utilizando JOINS para realizar consultas
-- 2.1 Mostrar el id, nombre de cada hotel y el titulo de la categoría a la que pertenece:
SELECT H.id, H.nombre, C.categoria
FROM HOTEL H 
	INNER JOIN CATEGORIA C
ON H.id_categoria = C.id;

-- 2.2 Mostrar toda la información de cada cliente excepto el correo electrónico, 
-- Mostrar el nombre del pais al cual pertenece y el tipo de cliente que es.
-- Consulta convencional
/*
SELECT c.id, c.nombre, p.pais, tp.tipo
FROM cliente c, pais p, tipo_cliente tp
WHERE c.id_pais = p.id
	AND c.tipo_cliente = tp.id;
*/

SELECT C.id, C.nombre, P.pais, TC.tipo
FROM CLIENTE C 
	INNER JOIN PAIS P
ON C.id_pais = P.id
	INNER JOIN TIPO_CLIENTE TC
ON C.tipo_cliente = TC.id;

-- 2.3 Mostrar la información de los clientes tipo "Viajero" (omitir el correo electrónico) 
-- Mostrar el nombre del pais al cual pertenece, el tipo de cliente que es.
SELECT C.id, C.nombre, P.pais, TC.tipo
FROM CLIENTE C 
	INNER JOIN PAIS P
ON C.id_pais = P.id
	INNER JOIN TIPO_CLIENTE TC
ON C.tipo_cliente = TC.id
WHERE TC.tipo = 'Viajero';

-- 2.4 Mostrar toda la información de cada cliente, que provengan de centroamérica. 
-- Mostrar el nombre del pais al cual pertenece y el tipo de cliente que es.
SELECT C.id, C.nombre, P.pais, TC.tipo
FROM CLIENTE C 
	INNER JOIN PAIS P
ON C.id_pais = P.id
	INNER JOIN TIPO_CLIENTE TC
ON C.tipo_cliente = TC.id
WHERE P.pais IN ('El Salvador','Guatemala','Honduras','Nicaragua','Costa Rica','Panama','Belice');

-- 2.5 Mostrar toda la información de cada cliente, que provengan de centroamérica. 
-- Mostrar el nombre del pais al cual pertenece y el tipo de cliente que es.
-- Incluir en la lista incluso los paises de los que no se tienen registros aun.
SELECT C.id, C.nombre, P.pais
FROM CLIENTE C
	RIGHT JOIN PAIS P
ON C.id_pais = P.id
WHERE P.pais IN ('El Salvador','Guatemala','Honduras','Nicaragua','Costa Rica','Panama','Belice');


SELECT C.id, C.nombre, P.pais, TC.tipo
FROM CLIENTE C
	RIGHT JOIN PAIS P
ON C.id_pais = P.id
	LEFT JOIN TIPO_CLIENTE TC
ON C.tipo_cliente = TC.id
WHERE P.pais IN ('El Salvador','Guatemala','Honduras','Nicaragua','Costa Rica','Panama','Belice');

-- 2.6 Mostrar todas las reservas que inician durante el mes abril de 2010 
-- Incluir el nombre del cliente que ha realizado la reserva.
SELECT R.id, R.checkin, R.checkout, C.nombre
FROM RESERVA R
	INNER JOIN CLIENTE C
ON R.id_cliente = C.id
WHERE R.checkin >= '2010-04-01' AND R.checkin <= '2010-04-30';

-- 2.7 Mostrar todas las reservas que inician durante el mes abril de 2010 
-- Incluir el nombre del cliente que ha realizado la reserva y que habitacion reservo.
SELECT R.id, R.checkin, R.checkout, C.nombre, H.numero AS 'número de habitación'
FROM RESERVA R
	INNER JOIN CLIENTE C
ON R.id_cliente = C.id
	INNER JOIN HABITACION H
ON R.id_habitacion = H.id
WHERE R.checkin >= '2010-04-01' AND R.checkin <= '2010-04-30';

-- 2.8 Mostrar todas las reservas que inician en el mes abril de 2010 
-- Incluir el nombre del cliente que ha realizado la reserva y que habitacion reservo.
-- Mostrar ademas el nombre del hotel donde reservo.
SELECT R.id, R.checkin, R.checkout, C.nombre, H.numero AS 'número de habitación', HO.nombre AS 'hotel'
FROM RESERVA R
	INNER JOIN CLIENTE C
ON R.id_cliente = C.id
	INNER JOIN HABITACION H
ON R.id_habitacion = H.id
	INNER JOIN HOTEL HO
ON H.id_hotel = HO.id
WHERE R.checkin >= '2010-04-01' AND R.checkin <= '2010-04-30';

-- NOTA. ordenando por fecha
SELECT R.id, R.checkin, R.checkout, C.nombre, H.numero AS 'número de habitación', HO.nombre AS 'hotel'
FROM RESERVA R
	INNER JOIN CLIENTE C
ON R.id_cliente = C.id
	INNER JOIN HABITACION H
ON R.id_habitacion = H.id
	INNER JOIN HOTEL HO
ON H.id_hotel = HO.id
WHERE R.checkin >= '2010-04-01' AND R.checkin <= '2010-04-30'
ORDER BY R.checkin ASC;

-- Mostrar el nombre del cliente y hotel en donde ha reservado
SELECT C.nombre, HO.nombre AS 'hotel'
FROM RESERVA R
	INNER JOIN CLIENTE C
ON R.id_cliente = C.id
	INNER JOIN HABITACION H
ON R.id_habitacion = H.id
	INNER JOIN HOTEL HO
ON H.id_hotel = HO.id
WHERE R.checkin >= '2010-04-01' AND R.checkin <= '2010-04-30';