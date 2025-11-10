DROP DATABASE IF EXISTS Banco;
CREATE DATABASE Banco;
USE Banco;

-- 1) Creacion de las tablas:

CREATE TABLE Clientes (
numero_cliente INT PRIMARY KEY,
dni INT NOT NULL,
apellido VARCHAR(60) NOT NULL,
nombre VARCHAR(60) NOT NULL
);

CREATE TABLE Cuentas (
numero_cuenta INT PRIMARY KEY,
numero_cliente int NOT NULL,
saldo DECIMAL(10, 2) NOT NULL,
CONSTRAINT fk_cuenta_cliente FOREIGN KEY (numero_cliente) REFERENCES Clientes(numero_cliente)
);

CREATE TABLE Movimientos (
numero_movimiento INT AUTO_INCREMENT PRIMARY KEY,
numero_cuenta INT NOT NULL,
fecha DATE NOT NULL,
tipo ENUM('CREDITO', 'DEBITO') NOT NULL,
importe DECIMAL(10, 2) NOT NULL,
CONSTRAINT fk_movimiento_cuenta FOREIGN KEY (numero_cuenta) REFERENCES Cuentas(numero_cuenta)
);

CREATE TABLE Historial_movimientos (
id INT PRIMARY KEY,
numero_cuenta INT NOT NULL,
numero_movimiento INT NOT NULL,
saldo_anterior DECIMAL(10, 2) NOT NULL,
saldo_actual DECIMAL(10, 2) NOT NULL,
CONSTRAINT fk_historial_cuenta FOREIGN KEY (numero_cuenta) REFERENCES Cuentas(numero_cuenta),
CONSTRAINT fk_historial_movimiento FOREIGN KEY (numero_movimiento) REFERENCES Movimientos(numero_movimiento)
);

-- 2) Inserts en las tablas creadas:

INSERT INTO Clientes (numero_cliente, dni, apellido, nombre) VALUES
(1, 20345678, 'Pérez', 'Carlos'),
(2, 21456789, 'Gómez', 'Ana'),
(3, 22567890, 'Torres', 'Luis'),
(4, 23678901, 'Fernández', 'Carla'),
(5, 24789012, 'Ramos', 'Sofía'),
(6, 25890123, 'Alvarez', 'Diego'),
(7, 26901234, 'Martínez', 'Lucía'),
(8, 27912345, 'García', 'Mariano');

INSERT INTO Cuentas (numero_cuenta, numero_cliente, saldo) VALUES
(1001, 1, 1500.00),
(1002, 2, 3200.00),
(1003, 3, 800.00),
(1004, 4, 5000.00),
(1005, 5, 2500.00),
(1006, 6, 1200.00),
(1007, 7, 950.00),
(1008, 8, 4000.00),
(1009, 1, 700.00),   -- Carlos Pérez tiene dos cuentas
(1010, 5, 1500.00);  -- Sofía Ramos tiene dos cuentas

INSERT INTO Movimientos (numero_cuenta, fecha, tipo, importe) VALUES
(1001, '2025-01-05', 'CREDITO', 500.00),
(1001, '2025-01-10', 'DEBITO', 200.00),
(1002, '2025-01-12', 'CREDITO', 1000.00),
(1003, '2025-01-15', 'DEBITO', 100.00),
(1004, '2025-02-01', 'CREDITO', 1500.00),
(1004, '2025-02-10', 'DEBITO', 300.00),
(1005, '2025-02-05', 'CREDITO', 700.00),
(1006, '2025-02-15', 'DEBITO', 100.00),
(1007, '2025-03-01', 'CREDITO', 250.00),
(1008, '2025-03-02', 'DEBITO', 500.00),
(1009, '2025-03-10', 'CREDITO', 200.00),
(1010, '2025-03-12', 'DEBITO', 150.00),
(1002, '2025-03-15', 'DEBITO', 400.00),
(1005, '2025-03-16', 'CREDITO', 300.00),
(1008, '2025-10-20', 'CREDITO', 600.00),
(1002, '2025-10-21', 'credito', 1000),
(1002, '2025-10-21', 'debito', 900),
(1001, '2025-10-05', 'CREDITO', 500.00),
(1001, '2025-10-10', 'DEBITO', 200.00),
(1002, '2025-10-12', 'CREDITO', 1000.00),
(1003, '2025-10-15', 'DEBITO', 100.00),
(1004, '2025-10-01', 'CREDITO', 1500.00),
(1004, '2025-10-10', 'DEBITO', 300.00),
(1005, '2025-10-05', 'CREDITO', 700.00),
(1006, '2025-10-15', 'DEBITO', 100.00),
(1007, '2025-10-01', 'CREDITO', 250.00),
(1008, '2025-10-02', 'DEBITO', 500.00),
(1009, '2025-10-10', 'CREDITO', 200.00),
(1010, '2025-10-12', 'DEBITO', 150.00),
(1002, '2025-10-15', 'DEBITO', 400.00),
(1005, '2025-10-16', 'CREDITO', 300.00),
(1008, '2025-10-20', 'CREDITO', 600.00),
(1002, '2025-10-21', 'credito', 3000),
(1002, '2025-10-21', 'debito', 1000);

INSERT INTO Historial_movimientos(id,numero_cuenta,numero_movimiento,saldo_anterior,saldo_actual) VALUES
(1,1001,1,1500.00,2000.00),
(2,1001,2,2000.00,1800.00),
(3,1002,3,3200.00,4200.00),
(4,1003,4,800.00,700.00),
(5,1004,5,5000.00,6500.00),
(6,1004,6,6500.00,6200.00),
(7,1005,7,2500.00,3200.00),
(8,1006,8,1200.00,1100.00),
(9,1007,9,950.00,1200.00),
(10,1008,10,4000.00,3500.00),
(11,1009,11,700.00,900.00),
(12,1010,12,1500.00,1350.00),
(13,1002,13,4200.00,3800.00),
(14,1005,14,3200.00,3500.00),
(15,1008,15,3500.00,4100.00),
(16,1002,16,3800.00,4800.00),
(17,1002,17,4800.00,3900.00),
(18,1001,18,1800.00,2300.00),
(19,1001,19,2300.00,2100.00),
(20,1002,20,3900.00,4900.00),
(21,1003,21,700.00,600.00),
(22,1004,22,6200.00,7700.00),
(23,1004,23,7700.00,7400.00),
(24,1005,24,3500.00,4200.00),
(25,1006,25,1100.00,1000.00),
(26,1007,26,1200.00,1450.00),
(27,1008,27,4100.00,3600.00),
(28,1009,28,900.00,1100.00),
(29,1010,29,1350.00,1200.00),
(30,1002,30,4900.00,4500.00),
(31,1005,31,4200.00,4500.00),
(32,1008,32,3600.00,4200.00),
(33,1002,33,4500.00,7500.00),
(34,1002,34,7500.00,6500.00);

-- 3) Procedimiento para mostrar todas las cuentas con su saldo actual:

DELIMITER //
CREATE PROCEDURE VerCuentas()
BEGIN
  SELECT numero_cuenta, saldo FROM Cuentas;
END//
DELIMITER ;

CALL VerCuentas();

-- 4) Procedimiento para mostrar las cuentas con saldo mayor a un valor recibido.
-- Por ejemplo, busquemos cuentas con saldo mayor a 2000.00:

DELIMITER //
CREATE PROCEDURE CuentasConSaldoMayorQue(IN limite DECIMAL(10, 2))
BEGIN
  SELECT numero_cuenta, saldo FROM Cuentas
    WHERE saldo > limite;
END//
DELIMITER ;

CALL CuentasConSaldoMayorQue(2000.00);

-- 5) Procedimiento que recibe una cuenta y devuelve todos los movimientos en el mes SIN usar cursores.
-- Tomemos como ejemplo el mes 10 y la cuenta 1002:

DELIMITER //
CREATE PROCEDURE TotalMovimientosDelMesSinCursor(IN cuenta INT, OUT total DECIMAL(10, 2))
BEGIN
  DECLARE mes_actual INT;
  DECLARE creditos DECIMAL(10, 2);
  DECLARE debitos DECIMAL(10, 2);
  SET mes_actual = 10;
    SELECT SUM(importe) INTO creditos FROM Movimientos
      WHERE numero_cuenta = cuenta AND MONTH(fecha) = mes_actual AND tipo = 'CREDITO';
	SELECT SUM(importe) INTO debitos FROM Movimientos
      WHERE numero_cuenta = cuenta AND MONTH(fecha) = mes_actual AND tipo = 'DEBITO';
  SET total = creditos - debitos;
END//
DELIMITER ;

CALL TotalMovimientosDelMesSinCursor(1002, @total);
SELECT @total AS total

-- 6) Procedimiento para depositar una cantidad dada en una cuenta determinada.
-- Por ejemplo, depositemos 1000.00 en la cuenta 1007:

DELIMITER //
CREATE PROCEDURE Depositar(IN cuenta INT, IN monto DECIMAL(10, 2))
BEGIN
  UPDATE Cuentas
  SET saldo = saldo + monto
  WHERE numero_cuenta = cuenta;
  INSERT INTO Movimientos (numero_cuenta, fecha, tipo, importe) VALUES
  (cuenta, CURDATE(), 'CREDITO', monto);
  SELECT numero_cuenta, saldo FROM Cuentas
    WHERE numero_cuenta = cuenta;
END//
DELIMITER ;

CALL Depositar(1007, 1000.00)

-- 7) Procedimiento para extraer una cantidad dada de dinero de una cuenta especifica siempre y cuando el saldo sea mayor a la cantidad a retirar.
-- Por ejemplo, quitemosle los 1000.00 que le depositamos a la cuenta 1007:

DELIMITER //
CREATE PROCEDURE Extraer(IN cuenta INT, IN monto DECIMAL(10, 2))
BEGIN
  IF (SELECT saldo FROM Cuentas WHERE numero_cuenta = cuenta) > monto
    THEN
      UPDATE Cuentas
      SET saldo = saldo - monto
      WHERE numero_cuenta = cuenta;
      INSERT INTO Movimientos (numero_cuenta, fecha, tipo, importe) VALUES
      (cuenta, CURDATE(), 'DEBITO', monto);
  END IF; -- En caso de no tener saldo suficiente la tabla no se actualiza.
  SELECT numero_cuenta, saldo FROM Cuentas
    WHERE numero_cuenta = cuenta;
END//
DELIMITER ;

CALL Extraer(1007, 1000.00);

-- 8) Trigger que actualiza el saldo de la cuenta luego de cada movimiento.
-- Realizamos algunos movimientos como ejemplos:

DELIMITER //
CREATE TRIGGER ActualizarSaldo
AFTER INSERT ON Movimientos
FOR EACH ROW
BEGIN
  IF NEW.tipo = 'CREDITO'
    THEN
      UPDATE Cuentas
      SET saldo = saldo - NEW.importe
      WHERE numero_cuenta = NEW.numero_cuenta;
	ELSE -- En caso de no ser de tipo 'CREDITO', debe ser si o si de tipo 'DEBITO'
      IF (SELECT saldo FROM Cuentas WHERE numero_cuenta = NEW.numero_cuenta) > NEW.importe
      THEN
        UPDATE Cuentas
        SET saldo = saldo - NEW.importe
        WHERE numero_cuenta = NEW.numero_cuenta;
	  END IF;
  END IF;
END//
DELIMITER ;

CALL Depositar(1002, 1000.00);
CALL Extraer(1005, 500.00);
CALL Depositar(1007, 2000.00);
SELECT numero_cuenta, saldo FROM Cuentas;

-- 9) Modificacion del trigger anteriormente implementado.
-- Realizamos los mismos movimientos que en el punto anterior:

DROP TRIGGER IF EXISTS ActualizarSaldo;
DELIMITER //
CREATE TRIGGER ActualizarSaldo
AFTER INSERT ON Movimientos
FOR EACH ROW
BEGIN
  DECLARE saldoAnterior DECIMAL(10, 2);
  DECLARE saldoActual DECIMAL(10, 2);
  SET saldoAnterior = (SELECT saldo FROM Cuentas WHERE numero_cuenta = NEW.numero_cuenta);
  IF NEW.tipo = 'CREDITO'
    THEN
      UPDATE Cuentas
      SET saldo = saldo - NEW.importe
      WHERE numero_cuenta = NEW.numero_cuenta;
	ELSE -- En caso de no ser de tipo 'CREDITO', debe ser si o si de tipo 'DEBITO'
      IF (SELECT saldo FROM Cuentas WHERE numero_cuenta = NEW.numero_cuenta) > NEW.importe
      THEN
        UPDATE Cuentas
        SET saldo = saldo - NEW.importe
        WHERE numero_cuenta = NEW.numero_cuenta;
	  END IF;
  END IF;
  SET saldoActual = (SELECT saldo FROM Cuentas WHERE numero_cuenta = NEW.numero_cuenta);
  INSERT INTO Historial_movimientos (id, numero_cuenta, numero_movimiento, saldo_anterior, saldo_actual)
  VALUES (NEW.numero_movimiento, NEW.numero_cuenta, NEW.numero_movimiento, saldoAnterior, saldoActual);
END//
DELIMITER ;

CALL Depositar(1002, 1000.00);
CALL Extraer(1005, 500.00);
CALL Depositar(1007, 2000.00);
SELECT numero_cuenta, saldo FROM Cuentas;
SELECT * FROM Historial_Movimientos;

-- 10) Procedimiento que recibe una cuenta y devuelve el total de movimientos de la cuenta en el mes actual USANDO cursores.
-- Usemos el mismo ejemplo que en el procedimiento TotalMovimientosDelMesSinCursor:
 
DELIMITER //
CREATE PROCEDURE TotalMovimientosDelMesConCursor(IN cuenta INT, OUT total DECIMAL(10, 2))
BEGIN
  DECLARE fin_cursor BOOLEAN DEFAULT FALSE;
  DECLARE cursor_importes CURSOR FOR SELECT importe, tipo FROM Movimientos WHERE numero_cuenta = cuenta AND MONTH(fecha) = MONTH(CURDATE());
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin_cursor = TRUE;
  SET total = 0;
  OPEN cursor_importes;
  leer_importes: LOOP
    FETCH cursor_importes INTO importe_actual, tipo_actual;
    IF fin_cursor THEN
      LEAVE leer_creditos;
	END IF;
    IF tipo_actual = 'CREDITO' THEN
      SET total = total + importe_actual;
	ELSE
      SET total = total - importe_actual;
	END IF;
  END LOOP leer_importes;
  CLOSE cursor_importes;
END//
DELIMITER ;

CALL TotalMovimientosDelMesConCursor(1007, @total);
SELECT @total AS Total;

-- 11) Procedimiento que aplica un porcentaje de interes a todas las cuentas con saldo mayor al recibido por parametro.
-- Apliquemos el 2% de interes a las cuentas con saldo mayor a $100000.00:

DELIMITER // 
CREATE PROCEDURE AplicarInteres(IN interes INT, IN saldo_minimo DECIMAL(10, 2))
BEGIN
  DECLARE fin_cursor BOOLEAN DEFAULT FALSE;
  DECLARE saldo_actual DECIMAL(10, 2);
  DECLARE cuenta_actual INT;
  DECLARE cursor_saldos CURSOR FOR SELECT numero_cuenta, saldo FROM Cuentas;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin_cursor = TRUE;
  OPEN cursor_saldos;
  leer_saldos: LOOP
    FETCH cursor_saldos INTO cuenta_actual, saldo_actual;
    IF fin_cursor THEN
      LEAVE leer_saldos;
	END IF;
    IF saldo_actual > saldo_minimo THEN
      UPDATE Cuentas
      SET saldo = saldo + (saldo * interes) / 100
      WHERE numero_cuenta = cuenta_actual ;
    END IF;
  END LOOP leer_saldos;
  CLOSE cursor_saldos;
END//
DELIMITER ;
  
CALL AplicarInteres(2, 100000.00);
SELECT numero_cuenta, saldo FROM Cuentas;
  




