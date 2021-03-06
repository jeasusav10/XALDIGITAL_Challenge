/*
Created on Tue Dec 14 17:06:32 2021
XALDIGITAL_Challenge
Excercise 2. SQL

MYSQL
@author: Jesus Anaya
*/

CREATE SCHEMA IF NOT EXISTS XALDIGITAL;
USE XALDIGITAL;

CREATE TABLE IF NOT EXISTS AEROLINEAS (ID_AEROLINEA INT, NOMBRE_AEROLINEA VARCHAR(20));
INSERT INTO AEROLINEAS 
VALUES (1,'Volaris'), (2,'Aeromar'), (3, 'Interjet'), (4,'Aeromexico');

CREATE TABLE IF NOT EXISTS AEROPUERTOS (ID_AEROPUERTO INT, NOMBRE_AEROPUERTO VARCHAR(20));
INSERT INTO AEROPUERTOS 
VALUES (1,'Benito Juarez'), (2,'Guanajuato'), (3, 'La Paz'), (4,'Oaxaca');

CREATE TABLE IF NOT EXISTS MOVIMIENTOS (ID_MOVIMIENTO INT, DESCRIPCION VARCHAR(20));
INSERT INTO MOVIMIENTOS 
VALUES (1,'Salida'), (2,'Llegada');

CREATE TABLE IF NOT EXISTS VUELOS (ID_AEROLINEA INT, ID_AEROPUERTO INT, ID_MOVIMIENTO INT, DIA DATE);
INSERT INTO VUELOS 
VALUES (1,1,1,'2021-05-02'), (2,1,1, '2021-05-02'), (3,2,2,'2021-05-02'), (4,3,2,'2021-05-02'), 
(1,3,2,'2021-05-02'),(2,1,1,'2021-05-02'), (2,3,1,'2021-05-04'), (3,4,1,'2021-05-04'), (3,4,1,'2021-05-04');

#1. Which airport has the largest ammount of movements during the year?; 
SELECT NOMBRE_AEROPUERTO
FROM AEROPUERTOS
NATURAL JOIN 
(SELECT ID_AEROPUERTO
FROM VUELOS
GROUP BY ID_AEROPUERTO, YEAR(DIA)
HAVING COUNT(1) = (SELECT COUNT(1) FROM VUELOS 
				   GROUP BY ID_AEROPUERTO, YEAR(DIA) 
                   ORDER BY COUNT(1) DESC LIMIT 1 )) T1;
                   
#2. Which airline has the largest ammount of flights during the year ?
SELECT NOMBRE_AEROLINEA
FROM AEROLINEAS
NATURAL JOIN 
(SELECT ID_AEROLINEA
FROM VUELOS
GROUP BY ID_AEROLINEA, YEAR(DIA)
HAVING COUNT(1) = (SELECT COUNT(1) FROM VUELOS 
				   GROUP BY ID_AEROLINEA, YEAR(DIA) 
                   ORDER BY COUNT(1) DESC LIMIT 1 )) T1;

#3. Which day had the largest ammount of flights ?
SELECT DIA
FROM VUELOS
GROUP BY DIA
HAVING COUNT(1) = (SELECT COUNT(1) FROM VUELOS 
				   GROUP BY DIA   ORDER BY COUNT(1) 
                   DESC LIMIT 1);

#4.  Which airlines have more than two flights per day ?
SELECT NOMBRE_AEROLINEA
FROM VUELOS NATURAL JOIN AEROLINEAS
GROUP BY ID_AEROLINEA
HAVING COUNT(1) > 2;
