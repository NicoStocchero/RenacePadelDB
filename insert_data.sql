-- DATOS DE EJEMPLO

-- Insertar jugadores de ejemplo
INSERT INTO jugador (nombre, apellido, email, telefono, fecha_nacimiento, dni, observaciones, fecha_alta, estado)
VALUES
  ('Juan', 'Pérez', 'juan@example.com', '+5493511773030', '1990-12-15', '12345678', 'Jugador activo', '2024-04-10', 'activo'),
  ('Rafael', 'Gomez', 'rafael@example.com', '+5493511773031', '1985-07-20', '87654321', 'Jugador suspendido', '2024-04-12', 'inactivo');

-- Insertar canchas de ejemplo
INSERT INTO cancha (nombre, estado, superficie, cubierta, iluminacion)
VALUES
  ('Cancha 1', 'activa', 'sintética', TRUE, TRUE),
  ('Cancha 2', 'activa', 'cemento', FALSE, TRUE),
  ('Cancha 3', 'mantenimiento', 'sintética', TRUE, FALSE);

-- Insertar entrenadores de ejemplo
INSERT INTO entrenador (nombre, tipo, disponibilidad)
VALUES
  ('Carlos Sánchez', 'Entrenador A', 'Lunes a Viernes de 10:00 a 14:00'),
  ('Ana Díaz', 'Entrenadora B', 'Martes y Jueves de 16:00 a 20:00');

-- Insertar clases de ejemplo
INSERT INTO clase (fecha, hora_inicio, duracion, tipo, categoria, id_entrenador, evento_asociado)
VALUES
  ('2024-04-10', '10:00:00', 60, 'individual', '1ra', 1, FALSE),
  ('2024-04-11', '12:00:00', 90, 'grupal', '2da', 2, TRUE);

-- Insertar clases por jugador
INSERT INTO jugador_clase (id_jugador, id_clase, asistencia)
VALUES
  (1, 1, TRUE),
  (2, 1, FALSE);

-- Insertar equipos de ejemplo
INSERT INTO equipo (nombre_equipo)
VALUES
  ('Equipo A'),
  ('Equipo B');

-- Insertar jugadores en equipos
INSERT INTO jugador_equipo (id_jugador, id_equipo)
VALUES
  (1, 1),
  (2, 2);

-- Insertar torneos de ejemplo
INSERT INTO torneo (nombre, tipo, fecha_inicio, fecha_fin, reglas, categoria, estado)
VALUES
  ('Torneo 1', 'Individual', '2024-04-15', '2024-04-18', 'Reglas básicas', '1ra', 'inscripcion'),
  ('Torneo 2', 'Por equipos', '2024-04-20', '2024-04-23', 'Reglamento torneo', '2da', 'inscripcion');

-- Insertar participación en torneos
INSERT INTO participacion_torneo (id_torneo, id_equipo, resultado)
VALUES
  (1, 1, 'Ganado'),
  (2, 2, 'Perdido');
  
  -- Insertar turnos de ejemplo
INSERT INTO turno (fecha, hora_inicio, duracion, estado, id_cancha, id_jugador_responsable)
VALUES 
('2024-04-10', '10:00:00', 60, 'confirmado', 1, 1), 
('2024-04-12', '12:00:00', 90, 'confirmado', 2, 2);

-- Insertar turnos de prueba para el día actual
INSERT INTO turno (fecha, hora_inicio, duracion, estado, id_cancha, id_jugador_responsable)
VALUES 
  (CURDATE(), '10:00:00', 60, 'confirmado', 1, 1), 
  (CURDATE(), '12:00:00', 60, 'confirmado', 2, 2);


-- Insertar pagos de ejemplo
INSERT INTO pago (fecha, metodo_pago, id_turno)
VALUES
  ('2024-04-10', 'efectivo', 1),
  ('2024-04-12', 'tarjeta', 2);

-- Insertar detalles de pagos de ejemplo
INSERT INTO pago_item (id_pago, id_jugador, concepto, monto)
VALUES
  (1, 1, 'reserva', 1500),
  (2, 2, 'reserva', 2000);

-- Insertar empleados de ejemplo
INSERT INTO empleado (nombre, rol, email, fecha_alta)
VALUES
  ('Laura Fernández', 'Administrativa', 'laura@example.com', '2024-03-01'),
  ('Pedro García', 'Operativo', 'pedro@example.com', '2024-03-05');

-- Insertar movimientos de caja de ejemplo
INSERT INTO caja (fecha, tipo, concepto, monto, id_empleado)
VALUES
  ('2024-04-10', 'ingreso', 'Pago por reserva', 1500.00, 1),
  ('2024-04-12', 'egreso', 'Compra de materiales', 500.00, 2);
