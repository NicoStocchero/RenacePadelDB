-- DATOS DE EJEMPLO

-- Insertar jugadores de ejemplo
INSERT INTO jugador (nombre, apellido, email, telefono, fecha_nacimiento, dni, observaciones, fecha_alta, estado)
VALUES
  ('María', 'Lopez', 'maria.lopez@gmail.com', '+5493511773001', '1995-08-21', '30214567', 'Jugador frecuente', '2024-04-15', 'activo'),
  ('Pablo', 'Fernandez', 'pablof@gmail.com', '+5493511773002', '1987-11-02', '28451234', 'Pago pendiente', '2024-04-16', 'inactivo'),
  ('Lucía', 'Gonzalez', 'lucia.g@gmail.com', '+5493511773003', '2001-03-14', '39214567', 'Nueva socia', '2024-05-01', 'activo'),
  ('Mateo', 'Ramirez', 'mateo.ramirez@gmail.com', '+5493511773004', '1992-06-30', '35287451', 'Participó en torneo', '2024-04-20', 'activo'),
  ('Valentina', 'Sosa', 'valentina.sosa@gmail.com', '+5493511773005', '1999-12-05', '34127583', 'Clases semanales', '2024-04-22', 'activo'),
  ('Diego', 'Torres', 'diego.torres@gmail.com', '+5493511773006', '1985-05-11', '32514896', 'Jugador lesionado', '2024-04-25', 'inactivo'),
  ('Camila', 'Perez', 'camila.perez@gmail.com', '+5493511773007', '2000-10-30', '33251478', 'Asistencia irregular', '2024-05-02', 'activo'),
  ('Facundo', 'Alvarez', 'facundo.alvarez@gmail.com', '+5493511773008', '1994-04-15', '31258749', 'Jugador nuevo', '2024-05-05', 'activo'),
  ('Sofia', 'Diaz', 'sofia.diaz@gmail.com', '+5493511773009', '1998-07-21', '29587412', 'Sin deudas', '2024-05-06', 'activo'),
  ('Martin', 'Herrera', 'martin.herrera@gmail.com', '+5493511773010', '1983-01-19', '27895146', 'Jugador retirado', '2024-05-07', 'inactivo'),
  ('Agustina', 'Mendez', 'agustina.mendez@gmail.com', '+5493511773011', '1997-09-12', '30254789', 'Clases avanzadas', '2024-05-10', 'activo'),
  ('Franco', 'Vega', 'franco.vega@gmail.com', '+5493511773012', '1990-04-04', '29876543', 'Jugador ocasional', '2024-05-12', 'inactivo'),
  ('Carla', 'Paredes', 'carla.paredes@gmail.com', '+5493511773013', '1988-01-17', '28876543', 'Participante de torneos', '2024-05-14', 'activo'),
  ('Nicolas', 'Ortiz', 'nicolas.ortiz@gmail.com', '+5493511773014', '1995-05-05', '30987654', 'Asistencia irregular', '2024-05-16', 'activo'),
  ('Julia', 'Moreno', 'julia.moreno@gmail.com', '+5493511773015', '1993-11-23', '31548762', 'Nueva socia', '2024-05-18', 'activo'),
  ('Fernando', 'Suarez', 'fernando.suarez@gmail.com', '+5493511773016', '1984-03-09', '29874561', 'Deuda pendiente', '2024-05-20', 'inactivo'),
  ('Lautaro', 'Lopez', 'lautaro.lopez@gmail.com', '+5493511773017', '1999-07-14', '32547896', 'Asistencia regular', '2024-05-22', 'activo'),
  ('Isabella', 'Martinez', 'isabella.martinez@gmail.com', '+5493511773018', '2003-10-30', '33659874', 'Jugadora junior', '2024-05-24', 'activo'),
  ('Emiliano', 'Castro', 'emiliano.castro@gmail.com', '+5493511773019', '1982-06-12', '29587416', 'Jugador retirado', '2024-05-26', 'inactivo'),
  ('Florencia', 'Rojas', 'florencia.rojas@gmail.com', '+5493511773020', '2000-02-18', '31258796', 'Pagos al día', '2024-05-28', 'activo');

-- Insertar canchas de ejemplo
INSERT INTO cancha (nombre, estado, superficie, cubierta, iluminacion)
VALUES
  ('Cancha 1', 'activa', 'sintética', TRUE, TRUE),
  ('Cancha 2', 'activa', 'cemento', FALSE, TRUE),
  ('Cancha 3', 'mantenimiento', 'sintética', TRUE, FALSE),
  ('Cancha 4', 'activa', 'sintética', TRUE, TRUE),
  ('Cancha 5', 'activa', 'césped', FALSE, TRUE),
  ('Cancha 6', 'mantenimiento', 'cemento', FALSE, FALSE),
  ('Cancha 7', 'activa', 'sintética', TRUE, FALSE),
  ('Cancha 8', 'activa', 'cemento', FALSE, TRUE);

-- Insertar entrenadores de ejemplo
INSERT INTO entrenador (nombre, tipo, disponibilidad)
VALUES
  ('Carlos Sánchez', 'Entrenador A', 'Lunes a Viernes de 10:00 a 14:00'),
  ('Ana Díaz', 'Entrenadora B', 'Martes y Jueves de 16:00 a 20:00'),
  ('Marcos Benítez', 'Entrenador C', 'Lunes, Miércoles y Viernes de 18:00 a 22:00'),
  ('Florencia Ríos', 'Entrenadora B', 'Martes y Jueves de 14:00 a 18:00'),
  ('Luciano Gómez', 'Entrenador A', 'Sábados de 9:00 a 13:00'),
  ('Julieta Torres', 'Entrenadora C', 'Lunes a Viernes de 10:00 a 14:00'),
  ('Federico Vargas', 'Entrenador B', 'Miércoles y Viernes de 16:00 a 20:00');

-- Insertar clases de ejemplo
INSERT INTO clase (fecha, hora_inicio, duracion, tipo, categoria, id_entrenador, evento_asociado)
VALUES
  ('2024-04-10', '10:00:00', 60, 'individual', '1ra', 1, FALSE),
  ('2024-04-11', '12:00:00', 90, 'grupal', '2da', 2, TRUE),
  ('2024-05-20', '09:00:00', 60, 'individual', '1ra', 1, FALSE),
  ('2024-05-21', '17:00:00', 90, 'grupal', '2da', 2, TRUE),
  ('2024-05-22', '11:00:00', 60, 'grupal', '3ra', 3, FALSE),
  ('2024-05-23', '18:30:00', 75, 'individual', '2da', 4, FALSE),
  ('2024-05-24', '15:00:00', 90, 'grupal', '1ra', 5, TRUE),
  ('2024-05-25', '10:00:00', 60, 'grupal', '3ra', 6, FALSE),
  ('2024-05-26', '14:00:00', 45, 'individual', '1ra', 7, FALSE),
  ('2024-05-27', '16:00:00', 60, 'grupal', '2da', 1, TRUE);

-- Insertar clases por jugador
INSERT INTO jugador_clase (id_jugador, id_clase, asistencia)
VALUES
  (1, 1, TRUE),
  (2, 1, FALSE),
  (1, 3, TRUE),
  (2, 4, TRUE),
  (3, 5, FALSE),
  (4, 6, TRUE),
  (5, 7, TRUE),
  (6, 8, FALSE),
  (7, 3, TRUE),
  (8, 4, FALSE),
  (9, 5, TRUE),
  (10, 6, TRUE),
  (1, 7, FALSE),
  (2, 8, TRUE),
  (3, 3, TRUE),
  (4, 4, FALSE),
  (5, 5, TRUE);

-- Insertar equipos de ejemplo
INSERT INTO equipo (nombre_equipo)
VALUES
  ('Equipo A'),
  ('Equipo B'),
  ('Los Lobos'),
  ('Fuerza Padel'),
  ('Doble Impacto'),
  ('Padel Power'),
  ('Los Retadores'),
  ('Gladiadores'),
  ('Reyes del Padel'),
  ('Los Cracks'),
  ('TopSpin'),
  ('Los Increíbles');

-- Insertar jugadores en equipos
INSERT INTO jugador_equipo (id_jugador, id_equipo)
VALUES
  (1, 1),
  (2, 2),
  (1, 3),
  (2, 4),
  (3, 5),
  (4, 6),
  (5, 7),
  (6, 8),
  (7, 9),
  (8, 10),
  (9, 3),
  (10, 4);

-- Insertar torneos de ejemplo
INSERT INTO torneo (nombre, tipo, fecha_inicio, fecha_fin, reglas, categoria, estado)
VALUES
  ('Torneo 1', 'Individual', '2024-04-15', '2024-04-18', 'Reglas básicas', '1ra', 'inscripcion'),
  ('Torneo 2', 'Por equipos', '2024-04-20', '2024-04-23', 'Reglamento torneo', '2da', 'inscripcion');

-- Insertar participación en torneos
INSERT INTO participacion_torneo (id_torneo, id_equipo, resultado)
VALUES
  (1, 1, 'Ganado'),
  (2, 2, 'Perdido'),
  (1, 3, 'Ganado'),
  (1, 4, 'Perdido'),
  (2, 5, 'Perdido'),
  (2, 6, 'No Presentado'),
  (1, 7, 'Retirado'),
  (2, 8, 'Ganado'),
  (1, 9, 'Perdido'),
  (2, 10, 'Ganado'),
  (1, 5, 'Perdido'),
  (2, 4, 'Ganado');
  
  -- Insertar turnos de ejemplo
INSERT INTO turno (fecha, hora_inicio, duracion, estado, id_cancha, id_jugador_responsable)
VALUES 
('2024-04-10', '10:00:00', 60, 'confirmado', 1, 1), 
('2024-04-12', '12:00:00', 90, 'confirmado', 2, 2),
('2025-05-19', '10:00:00', 60, 'confirmado', 1, 1),
('2025-05-19', '12:00:00', 60, 'confirmado', 2, 2),
('2025-05-19', '14:00:00', 60, 'confirmado', 3, 3),
('2025-05-19', '16:00:00', 60, 'confirmado', 1, 4),
('2025-05-19', '18:00:00', 60, 'confirmado', 2, 5),
('2025-05-20', '10:00:00', 60, 'confirmado', 3, 6),
('2025-05-20', '12:00:00', 60, 'confirmado', 1, 7),
('2025-05-20', '14:00:00', 60, 'confirmado', 2, 8),
('2025-05-20', '16:00:00', 60, 'confirmado', 3, 9),
('2025-05-20', '18:00:00', 60, 'confirmado', 1, 10),
('2025-05-21', '10:00:00', 60, 'confirmado', 2, 1),
('2025-05-21', '12:00:00', 60, 'confirmado', 3, 2),
('2025-05-21', '14:00:00', 60, 'confirmado', 1, 3),
('2025-05-21', '16:00:00', 60, 'confirmado', 2, 4),
('2025-05-21', '18:00:00', 60, 'confirmado', 3, 5),
('2025-05-22', '10:00:00', 60, 'confirmado', 1, 6),
('2025-05-22', '12:00:00', 60, 'confirmado', 2, 7),
('2025-05-22', '14:00:00', 60, 'confirmado', 3, 8),
('2025-05-22', '16:00:00', 60, 'confirmado', 1, 9),
('2025-05-22', '18:00:00', 60, 'confirmado', 2, 10),
('2025-05-23', '10:00:00', 60, 'confirmado', 3, 1),
('2025-05-23', '12:00:00', 60, 'confirmado', 1, 2),
('2025-05-23', '14:00:00', 60, 'confirmado', 2, 3);

-- Insertar turnos de prueba para el día actual
INSERT INTO turno (fecha, hora_inicio, duracion, estado, id_cancha, id_jugador_responsable)
VALUES 
  (CURDATE(), '10:00:00', 60, 'confirmado', 1, 1), 
  (CURDATE(), '12:00:00', 60, 'confirmado', 2, 2);


-- Insertar pagos de ejemplo
INSERT INTO pago (fecha, metodo_pago, id_turno)
VALUES
  ('2024-04-10', 'efectivo', 1),
  ('2024-04-12', 'tarjeta', 2),
  ('2025-05-19', 'efectivo', 1),
  ('2025-05-19', 'tarjeta', 2),
  ('2025-05-19', 'transferencia', 3),
  ('2025-05-19', 'efectivo', 4),
  ('2025-05-19', 'efectivo', 5),
  ('2025-05-20', 'tarjeta', 6),
  ('2025-05-20', 'transferencia', 7),
  ('2025-05-20', 'efectivo', 8),
  ('2025-05-20', 'tarjeta', 9),
  ('2025-05-20', 'efectivo', 10),
  ('2025-05-21', 'transferencia', 11),
  ('2025-05-21', 'efectivo', 12),
  ('2025-05-21', 'tarjeta', 13),
  ('2025-05-21', 'efectivo', 14),
  ('2025-05-21', 'transferencia', 15),
  ('2025-05-22', 'efectivo', 16),
  ('2025-05-22', 'tarjeta', 17),
  ('2025-05-22', 'transferencia', 18),
  ('2025-05-22', 'efectivo', 19),
  ('2025-05-22', 'efectivo', 20),
  ('2025-05-23', 'tarjeta', 21),
  ('2025-05-23', 'efectivo', 22),
  ('2025-05-23', 'transferencia', 23);

-- Insertar detalles de pagos de ejemplo
INSERT INTO pago_item (id_pago, id_jugador, concepto, monto)
VALUES
  (1, 1, 'reserva', 15000),
  (2, 2, 'reserva', 20000),
  (3, 3, 'reserva', 18000),
  (4, 4, 'reserva', 17000),
  (5, 5, 'reserva', 19000),
  (6, 6, 'reserva', 21000),
  (7, 7, 'reserva', 16000),
  (8, 8, 'reserva', 20000),
  (9, 9, 'reserva', 22000),
  (10, 10, 'reserva', 18000),
  (11, 1, 'reserva', 17500),
  (12, 2, 'reserva', 19000),
  (13, 3, 'reserva', 18500),
  (14, 4, 'reserva', 19500),
  (15, 5, 'reserva', 17000),
  (16, 6, 'reserva', 16000),
  (17, 7, 'reserva', 15500),
  (18, 8, 'reserva', 16500),
  (19, 9, 'reserva', 17500),
  (20, 10, 'reserva', 18500),
  (21, 1, 'reserva', 19500),
  (22, 2, 'reserva', 20000),
  (23, 3, 'reserva', 18000),
  (24, 4, 'reserva', 17000),
  (25, 5, 'reserva', 18000);

-- Insertar empleados de ejemplo
INSERT INTO empleado (nombre, rol, email, fecha_alta)
VALUES
  ('Laura Fernández', 'Administrativa', 'laura@example.com', '2024-03-01'),
  ('Pedro García', 'Operativo', 'pedro@example.com', '2024-03-05');

-- Insertar movimientos de caja de ejemplo
INSERT INTO caja (fecha, tipo, concepto, monto, id_empleado)
VALUES
  ('2024-04-10', 'ingreso', 'Pago por reserva', 1500.00, 1),
  ('2024-04-12', 'egreso', 'Compra de materiales', 500.00, 2),
  ('2025-05-19', 'ingreso', 'Pago por reserva - turno 1', 1500, 1),
  ('2025-05-19', 'ingreso', 'Pago por reserva - turno 2', 2000, 1),
  ('2025-05-19', 'ingreso', 'Pago por reserva - turno 3', 1800, 2),
  ('2025-05-19', 'ingreso', 'Pago por reserva - turno 4', 1700, 1),
  ('2025-05-19', 'ingreso', 'Pago por reserva - turno 5', 1900, 2),
  ('2025-05-20', 'ingreso', 'Pago por reserva - turno 6', 2100, 1),
  ('2025-05-20', 'ingreso', 'Pago por reserva - turno 7', 1600, 2),
  ('2025-05-20', 'ingreso', 'Pago por reserva - turno 8', 2000, 1),
  ('2025-05-20', 'ingreso', 'Pago por reserva - turno 9', 2200, 2),
  ('2025-05-20', 'ingreso', 'Pago por reserva - turno 10', 1800, 1),
  ('2025-05-21', 'ingreso', 'Pago por reserva - turno 11', 1750, 2),
  ('2025-05-21', 'ingreso', 'Pago por reserva - turno 12', 1900, 1),
  ('2025-05-21', 'ingreso', 'Pago por reserva - turno 13', 1850, 2),
  ('2025-05-21', 'ingreso', 'Pago por reserva - turno 14', 1950, 1),
  ('2025-05-21', 'ingreso', 'Pago por reserva - turno 15', 1700, 2),
  ('2025-05-22', 'ingreso', 'Pago por reserva - turno 16', 1600, 1),
  ('2025-05-22', 'ingreso', 'Pago por reserva - turno 17', 1550, 2),
  ('2025-05-22', 'ingreso', 'Pago por reserva - turno 18', 1650, 1),
  ('2025-05-22', 'ingreso', 'Pago por reserva - turno 19', 1750, 2),
  ('2025-05-22', 'ingreso', 'Pago por reserva - turno 20', 1850, 1),
  ('2025-05-23', 'ingreso', 'Pago por reserva - turno 21', 1950, 2),
  ('2025-05-23', 'ingreso', 'Pago por reserva - turno 22', 2000, 1),
  ('2025-05-23', 'ingreso', 'Pago por reserva - turno 23', 1800, 2);
