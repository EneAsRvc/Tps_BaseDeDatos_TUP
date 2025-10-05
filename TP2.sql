DROP DATABASE IF EXISTS TP2;
CREATE DATABASE TP2;
USE TP2;

-- Creación de las tablas del club náutico
CREATE TABLE Socios (
  id_socio INT PRIMARY KEY,
  nombre VARCHAR(100),
  direccion VARCHAR(255)
);

CREATE TABLE Barcos (
  matricula VARCHAR(20) PRIMARY KEY,
  nombre VARCHAR(100),
  numero_amarre INT,
  cuota DECIMAL(10, 2),
  id_socio INT,
  FOREIGN KEY (id_socio) REFERENCES Socios(id_socio)
);

CREATE TABLE Salidas (
  id_salida INT PRIMARY KEY,
  matricula VARCHAR(20),
  fecha_salida DATE,
  hora_salida TIME,
  destino VARCHAR(100),
  patron_nombre VARCHAR(100),
  patron_direccion VARCHAR(255),
  FOREIGN KEY (matricula) REFERENCES Barcos(matricula)
);

-- Populación de las tablas del club náutico
INSERT INTO Socios (id_socio, nombre, direccion)
VALUES
(1, 'Juan Pérez', 'Calle Mayor 1, Madrid'),
(2, 'Ana García', 'Calle Luna 5, Barcelona'),
(3, 'Luis Fernández', 'Avenida del Sol 10, Valencia'),
(4, 'Laura Sánchez', 'Plaza del Mar 3, Alicante'),
(5, 'Carlos López', 'Calle Río 8, Sevilla'),
(6, 'Marta Díaz', 'Calle de la Sierra 12, Zaragoza'),
(7, 'Pedro Gómez', 'Calle Nueva 20, Bilbao'),
(8, 'Lucía Jiménez', 'Calle Real 30, Madrid'),
(9, 'María Torres', 'Calle Verde 15, Málaga'),
(10, 'Fernando Martín', 'Calle Azul 25, Murcia');

INSERT INTO Barcos (matricula, nombre, numero_amarre, cuota, id_socio)
VALUES
('ABC123', 'El Viento', 12, 600.50, 1),
('DEF456', 'La Brisa', 8, 450.00, 2),
('GHI789', 'El Sol', 15, 700.00, 3),
('JKL012', 'El Mar', 10, 550.75, 4),
('MNO345', 'La Luna', 18, 620.30, 5),
('PQR678', 'El Horizonte', 20, 780.90, 6),
('STU901', 'El Amanecer', 5, 400.00, 7),
('VWX234', 'La Estrella', 7, 520.50, 8),
('YZA567', 'La Marea', 14, 480.75, 9),
('BCD890', 'El Océano', 6, 630.80, 10);

INSERT INTO Salidas (id_salida, matricula, fecha_salida, hora_salida, destino, patron_nombre, patron_direccion)
VALUES
(1, 'ABC123', '2023-07-15', '10:30:00', 'Mallorca', 'Patrón 1', 'Calle de la Playa 1, Palma'),
(2, 'DEF456', '2023-07-20', '09:00:00', 'Ibiza', 'Patrón 2', 'Avenida del Puerto 3, Valencia'),
(3, 'GHI789', '2023-07-22', '08:45:00', 'Menorca', 'Patrón 3', 'Calle de la Costa 10, Alicante'),
(4, 'JKL012', '2023-07-25', '11:15:00', 'Mallorca', 'Patrón 4', 'Plaza del Faro 5, Barcelona'),
(5, 'MNO345', '2023-08-01', '14:00:00', 'Formentera', 'Patrón 5', 'Calle del Puerto 20, Ibiza'),
(6, 'PQR678', '2023-08-05', '07:30:00', 'Mallorca', 'Patrón 6', 'Calle de las Olas 15, Palma'),
(7, 'STU901', '2023-08-10', '12:00:00', 'Ibiza', 'Patrón 7', 'Avenida de la Marina 7, Barcelona'),
(8, 'VWX234', '2023-08-12', '09:30:00', 'Cabrera', 'Patrón 8', 'Calle del Mar 12, Alicante'),
(9, 'YZA567', '2023-08-15', '10:00:00', 'Formentera', 'Patrón 9', 'Calle del Sol 4, Ibiza'),
(10, 'BCD890', '2023-08-20', '08:00:00', 'Menorca', 'Patrón 10', 'Plaza del Faro 2, Palma');

-- Consultas SIN JOIN
-- 1) Socios con barcos amarrados en número de amarre mayor a 10
SELECT s.nombre FROM Socios s
  WHERE s.id_socio in (
    SELECT b.id_socio FROM Barcos b WHERE numero_amarre > 10
  );
  
-- 2) Nombres y cuotas de barcos pertenecientes a Juan Pérez
SELECT b.nombre, cuota FROM Barcos b
  WHERE b.id_socio IN (
    SELECT s.id_socio FROM Socios s WHERE s.nombre = 'Juan Pérez'
  );
  
-- 3) Cantidad de salidas del barco con matrícula ABC123
SELECT b.nombre AS barco, b.matricula, (SELECT COUNT(*) FROM Salidas s WHERE b.matricula = s.matricula and b.matricula = 'ABC123') AS salidas FROM Barcos b
  WHERE b.matricula = 'ABC123';
  
-- 4) Lista de barcos y socios con cuota mayor a 500
SELECT b.nombre AS barco, b.id_socio, cuota FROM Barcos b
  WHERE b.id_socio IN (
    SELECT s.id_socio FROM Socios s WHERE cuota > 500
  );
  
-- 5) Barcos con destino a Mallorca
SELECT b.nombre AS barco FROM Barcos b
  WHERE b.matricula IN (
    SELECT s.matricula FROM Salidas s WHERE destino = 'Mallorca'
  );
  
-- 6) Nombre y dirección de patrones que llevan barcos de dueños de Barcelona
SELECT patron_nombre ,patron_direccion FROM Salidas
  WHERE Salidas.matricula IN (
    SELECT Barcos.matricula FROM Barcos
      WHERE Barcos.id_socio IN (
        SELECT Socios.id_socio FROM Socios WHERE Socios.direccion LIKE '%Barcelona%'
      )
  );
  
-- Consultas CON JOIN
-- 1) Socios con barcos amarrados en número de amarre mayor a 10
SELECT s.nombre FROM Socios s INNER JOIN Barcos b ON
  b.numero_amarre > 10 and s.id_socio = b.id_socio;
  
-- 2) Nombres y cuotas de barcos pertenecientes a Juan Pérez
SELECT b.nombre, b.cuota FROM Barcos b INNER JOIN Socios s ON
  b.id_socio = s.id_socio and s.nombre = 'Juan Pérez';
  
-- 3) Cantidad de salidas del barco con matrícula ABC123
SELECT b.nombre AS barco, b.matricula, (SELECT COUNT(*) FROM Salidas s JOIN Barcos b ON s.matricula = b.matricula and b.matricula = 'ABC123') AS salidas FROM Barcos b
  WHERE b.matricula = 'ABC123';
  
-- 4) Lista de barcos y socios con cuota mayor a 500
SELECT b.nombre AS barco, b.id_socio, cuota FROM Barcos b INNER JOIN Socios s ON
  b.id_socio = s.id_socio and cuota > 500;
  
-- 5) Barcos con destino a Mallorca
SELECT b.nombre AS barco, s.destino FROM Barcos b INNER JOIN Salidas s ON
  b.matricula = s.matricula and s.destino = 'Mallorca';
  
-- 6) Nombre y dirección de patrones que llevan barcos de dueños de Barcelona
SELECT patron_nombre ,patron_direccion FROM Salidas
  JOIN Barcos ON Barcos.matricula = Salidas.matricula
  JOIN Socios ON Socios.id_socio = Barcos.id_socio AND Socios.direccion LIKE '%Barcelona%';
  
-- Creación de las tablas del gabinete de abogados
CREATE TABLE Clientes (
  dni INT PRIMARY KEY,
  nombre VARCHAR(100),
  direccion VARCHAR(255)
);

CREATE TABLE Asuntos (
  numero_expediente INT PRIMARY KEY,
  dni_cliente INT,
  fecha_inicio DATE,
  fecha_fin DATE,
  estado VARCHAR(20),
  FOREIGN KEY (dni_cliente) REFERENCES Clientes(dni_cliente)
);

CREATE TABLE Procuradores (
  id_procurador INT PRIMARY KEY,
  nombre VARCHAR(100),
  direccion VARCHAR(255)
);

CREATE TABLE Asuntos_Procuradores (
  id_procurador INT,
  numero_expediente INT,
  FOREIGN KEY (id_procurador) REFERENCES Procuradores(id_procurador),
  FOREIGN KEY (numero_expediente) REFERENCES Asuntos(numero_expediente)
);

-- Populación de las tablas del gabinete de abogados
-- Poblar la tabla Clientes
INSERT INTO Clientes (dni, nombre, direccion)
VALUES
('123456789', 'Juan Pérez', 'Calle Pueyrredón 3498, Buenos Aires'),
('987654321', 'Ana García', 'Calle 5 323, La Plata'),
('456123789', 'Luis Fernández', 'Avenida de Gral. Paz 1056, Bahía Blanca');

-- Poblar la tabla Asuntos
INSERT INTO Asuntos (numero_expediente, dni_cliente, fecha_inicio, fecha_fin, estado)
VALUES
(1, '123456789', '2023-01-15', '2023-07-20', 'Cerrado'),
(2, '987654321', '2023-05-10', NULL, 'Abierto'),
(3, '456123789', '2023-06-01', '2023-09-10', 'Cerrado');

-- Poblar la tabla Procuradores
INSERT INTO Procuradores (id_procurador, nombre, direccion)
VALUES
(1, 'Laura Sánchez', 'Calle Soler 3765, Buenos Aires'),
(2, 'Carlos López', 'Calle Estrellas 8, Mar del Plata'),
(3, 'Marta Díaz', 'Calle Estación 12, Olavarria');

-- Poblar la tabla Asuntos_Procuradores
INSERT INTO Asuntos_Procuradores (numero_expediente, id_procurador)
VALUES
(1, 1),
(2, 2),
(3, 3),
(2, 1);  -- Un asunto puede tener varios procuradores

-- Consultas CON JOIN
-- 1) Nombre y dirección de procuradores trabajando en casos abiertos
SELECT p.nombre, p.direccion FROM Procuradores p
  JOIN Asuntos_Procuradores r ON r.id_procurador = p.id_procurador
  JOIN Asuntos a ON r.numero_expediente = a.numero_expediente and a.estado = 'Abierto';
  
-- 2) Clientes con asuntos gestionados por Carlos López
SELECT c.nombre AS cliente, p.nombre AS procurador FROM Clientes c
  JOIN Asuntos a ON c.dni = a.dni_cliente
  JOIN Asuntos_Procuradores r ON r.numero_expediente = a.numero_expediente
  JOIN Procuradores p ON r.id_procurador = p.id_procurador AND p.nombre = 'Carlos López';
  
-- 3) Asuntos gestionados por cada procurador
SELECT p.nombre AS procurador, COUNT(*) AS asuntos FROM Procuradores p
  JOIN Asuntos_Procuradores r ON p.id_procurador = r.id_procurador
  GROUP BY p.id_procurador;
  
-- 4) Numeros de expediente y fechas de inicio de asuntos de clientes de Buenos Aires
SELECT a.numero_expediente, a.fecha_inicio FROM Asuntos a
  JOIN Clientes c ON a.dni_cliente = c.dni AND c.direccion LIKE '%Buenos Aires%';
  

