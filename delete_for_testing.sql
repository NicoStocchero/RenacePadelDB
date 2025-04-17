--
SET SQL_SAFE_UPDATES = 0;

-- Desactivar la comprobación de claves foráneas
SET foreign_key_checks = 0;

-- Eliminar registros de las tablas en el orden correcto
DELETE FROM jugador_equipo;
DELETE FROM jugador_clase;
DELETE FROM participacion_torneo;
DELETE FROM pago_item;
DELETE FROM pago;
DELETE FROM turno;
DELETE FROM clase;
DELETE FROM entrenador;
DELETE FROM equipo;
DELETE FROM torneo;
DELETE FROM jugador;
DELETE FROM cancha;
DELETE FROM caja;
DELETE FROM empleado;

-- Habilitar la comprobación de claves foráneas nuevamente
SET foreign_key_checks = 1;
--
SET SQL_SAFE_UPDATES = 1;

-- Resetear auto increment de cada tabla
ALTER TABLE jugador AUTO_INCREMENT = 1;
ALTER TABLE cancha AUTO_INCREMENT = 1;
ALTER TABLE turno AUTO_INCREMENT = 1;
ALTER TABLE pago AUTO_INCREMENT = 1;
ALTER TABLE pago_item AUTO_INCREMENT = 1;
ALTER TABLE clase AUTO_INCREMENT = 1;
ALTER TABLE entrenador AUTO_INCREMENT = 1;
ALTER TABLE jugador_clase AUTO_INCREMENT = 1;
ALTER TABLE equipo AUTO_INCREMENT = 1;
ALTER TABLE jugador_equipo AUTO_INCREMENT = 1;
ALTER TABLE participacion_torneo AUTO_INCREMENT = 1;
ALTER TABLE torneo AUTO_INCREMENT = 1;
ALTER TABLE empleado AUTO_INCREMENT = 1;
ALTER TABLE caja AUTO_INCREMENT = 1;

