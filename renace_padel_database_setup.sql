-- CREACIÓN DE LA BASE DE DATOS
CREATE DATABASE IF NOT EXISTS RenacePadelDB;

USE RenacePadelDB;

-- CREACIÓN DE LAS TABLAS

-- Tabla de jugadores
CREATE TABLE IF NOT EXISTS jugador (
  id_jugador INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(100),
  apellido VARCHAR(100),
  email VARCHAR(100) UNIQUE,
  telefono VARCHAR(15),
  fecha_nacimiento DATE,
  dni VARCHAR(20),
  observaciones TEXT,
  fecha_alta DATE,
  estado ENUM('activo', 'inactivo', 'baneado') -- Estado del jugador
);

-- Tabla de canchas
CREATE TABLE IF NOT EXISTS cancha (
  id_cancha INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(100),
  estado ENUM('activa', 'mantenimiento'),
  superficie VARCHAR(30),
  cubierta BOOLEAN,
  iluminacion BOOLEAN
);

-- Tabla de turnos (reservas)
CREATE TABLE IF NOT EXISTS turno (
  id_turno INT PRIMARY KEY AUTO_INCREMENT,
  fecha DATE,
  hora_inicio TIME,
  duracion INT,
  estado ENUM('pendiente', 'confirmado', 'cancelado'),
  id_cancha INT,
  id_jugador_responsable INT,
  FOREIGN KEY (id_cancha) REFERENCES cancha(id_cancha), -- Relación con 'cancha'
  FOREIGN KEY (id_jugador_responsable) REFERENCES jugador(id_jugador) -- Relación con 'jugador'
);

-- Tabla de pagos
CREATE TABLE IF NOT EXISTS pago (
  id_pago INT PRIMARY KEY AUTO_INCREMENT,
  fecha DATE,
  metodo_pago ENUM('efectivo', 'tarjeta', 'transferencia'),
  id_turno INT,
  FOREIGN KEY (id_turno) REFERENCES turno(id_turno) -- Relación con 'turno'
);

-- Tabla de detalle de pagos
CREATE TABLE IF NOT EXISTS pago_item (
  id_item INT PRIMARY KEY AUTO_INCREMENT,
  id_pago INT,
  id_jugador INT,
  concepto VARCHAR(100),
  monto DECIMAL(10, 2),
  FOREIGN KEY (id_pago) REFERENCES pago(id_pago), -- Relación con 'pago'
  FOREIGN KEY (id_jugador) REFERENCES jugador(id_jugador) -- Relación con 'jugador'
);

-- Tabla de clases
CREATE TABLE IF NOT EXISTS clase (
  id_clase INT PRIMARY KEY AUTO_INCREMENT,
  fecha DATE,
  hora_inicio TIME,
  duracion INT,
  tipo VARCHAR(100),
  categoria VARCHAR(50),
  id_entrenador INT,
  FOREIGN KEY (id_entrenador) REFERENCES entrenador(id_entrenador) -- Relación con 'entrenador'
);

-- Tabla de entrenadores
CREATE TABLE IF NOT EXISTS entrenador (
  id_entrenador INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(100),
  tipo VARCHAR(50),
  disponibilidad TEXT
);

-- Tabla de relación entre jugadores y clases (asistencia)
CREATE TABLE IF NOT EXISTS jugador_clase (
  id_jugador INT,
  id_clase INT,
  asistencia BOOLEAN,
  PRIMARY KEY (id_jugador, id_clase),
  FOREIGN KEY (id_jugador) REFERENCES jugador(id_jugador), -- Relación con 'jugador'
  FOREIGN KEY (id_clase) REFERENCES clase(id_clase) -- Relación con 'clase'
);

-- Tabla de equipos
CREATE TABLE IF NOT EXISTS equipo (
  id_equipo INT PRIMARY KEY AUTO_INCREMENT,
  nombre_equipo VARCHAR(100)
);

-- Tabla de relación entre jugadores y equipos
CREATE TABLE IF NOT EXISTS jugador_equipo (
  id_jugador INT,
  id_equipo INT,
  PRIMARY KEY (id_jugador, id_equipo),
  FOREIGN KEY (id_jugador) REFERENCES jugador(id_jugador), -- Relación con 'jugador'
  FOREIGN KEY (id_equipo) REFERENCES equipo(id_equipo) -- Relación con 'equipo'
);

-- Tabla de participación en torneos
CREATE TABLE IF NOT EXISTS participacion_torneo (
  id_participacion INT PRIMARY KEY AUTO_INCREMENT,
  id_torneo INT,
  id_equipo INT,
  resultado VARCHAR(50),
  FOREIGN KEY (id_torneo) REFERENCES torneo(id_torneo), -- Relación con 'torneo'
  FOREIGN KEY (id_equipo) REFERENCES equipo(id_equipo) -- Relación con 'equipo'
);

-- Tabla de torneos
CREATE TABLE IF NOT EXISTS torneo (
  id_torneo INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(100),
  tipo VARCHAR(50),
  fecha_inicio DATE,
  fecha_fin DATE,
  reglas TEXT,
  categoria VARCHAR(50),
  estado ENUM('inscripcion', 'en_juego', 'finalizado')
);

-- Tabla de empleados
CREATE TABLE IF NOT EXISTS empleado (
  id_empleado INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(100),
  dni VARCHAR(20),
  email VARCHAR(100),
  telefono VARCHAR(15),
  fecha_alta DATE,
  estado ENUM('activo', 'inactivo')
);

-- Tabla de movimientos de caja
CREATE TABLE IF NOT EXISTS caja (
  id_caja INT PRIMARY KEY AUTO_INCREMENT,
  fecha DATE,
  tipo ENUM('ingreso', 'egreso'),
  concepto TEXT,
  monto DECIMAL(10,2),
  id_empleado INT,
  FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado) -- Relación con 'empleado'
);

-- CREACIÓN DE LAS VISTAS

-- Vista de turnos del día para backend (para mostrar en el panel operador)
CREATE OR REPLACE VIEW api_turnos_hoy AS
SELECT 
  t.id_turno,
  t.hora_inicio,
  t.duracion,
  t.estado,
  j.id_jugador,
  CONCAT(j.nombre, ' ', j.apellido) AS jugador,
  c.nombre AS cancha
FROM turno t
JOIN jugador j ON t.id_jugador_responsable = j.id_jugador
JOIN cancha c ON t.id_cancha = c.id_cancha
WHERE t.fecha = CURDATE()
ORDER BY t.hora_inicio;

-- Vista para detalle completo de un turno específico (GET /turnos/:id)
CREATE OR REPLACE VIEW api_detalle_turno AS
SELECT 
  t.id_turno,
  t.fecha,
  t.hora_inicio,
  t.duracion,
  t.estado,
  j.id_jugador,
  CONCAT(j.nombre, ' ', j.apellido) AS jugador,
  j.email,
  j.telefono,
  c.id_cancha,
  c.nombre AS cancha,
  c.superficie,
  c.cubierta,
  c.iluminacion
FROM turno t
JOIN jugador j ON t.id_jugador_responsable = j.id_jugador
JOIN cancha c ON t.id_cancha = c.id_cancha;

-- Vista para obtener los jugadores básicos (como para buscador o dropdown)
CREATE OR REPLACE VIEW api_jugadores_basico AS
SELECT 
  id_jugador,
  CONCAT(nombre, ' ', apellido) AS nombre_completo,
  email,
  telefono,
  estado,
  fecha_alta
FROM jugador
ORDER BY apellido;

-- Vista para obtener los pagos realizados por un jugador específico (GET /jugador/:id/pagos)
CREATE OR REPLACE VIEW api_pago_jugador AS
SELECT 
  j.id_jugador,
  CONCAT(j.nombre, ' ', j.apellido) AS jugador,
  p.id_pago,
  p.fecha,
  p.metodo_pago,
  pi.concepto,
  pi.monto,
  t.id_turno
FROM pago p
JOIN pago_item pi ON p.id_pago = pi.id_pago
JOIN jugador j ON pi.id_jugador = j.id_jugador
LEFT JOIN turno t ON p.id_turno = t.id_turno
ORDER BY p.fecha DESC;

-- Vista para obtener el historial completo de un jugador
CREATE OR REPLACE VIEW api_historial_completo_jugador AS
SELECT 
  j.id_jugador,
  CONCAT(j.nombre, ' ', j.apellido) AS jugador,
  COUNT(DISTINCT t.id_turno) AS total_turnos,
  COUNT(DISTINCT jc.id_clase) AS total_clases,
  COUNT(DISTINCT pt.id_torneo) AS total_torneos,
  SUM(pi.monto) AS total_pagado
FROM jugador j
LEFT JOIN turno t ON j.id_jugador = t.id_jugador_responsable
LEFT JOIN jugador_clase jc ON jc.id_jugador = j.id_jugador AND jc.asistencia = TRUE
LEFT JOIN pago_item pi ON pi.id_jugador = j.id_jugador
LEFT JOIN jugador_equipo je ON je.id_jugador = j.id_jugador
LEFT JOIN participacion_torneo pt ON pt.id_equipo = je.id_equipo
GROUP BY j.id_jugador;

-- Vista para obtener los turnos confirmados del jugador
CREATE OR REPLACE VIEW api_contacto_proximo_turno AS
SELECT 
  j.id_jugador,
  CONCAT(j.nombre, ' ', j.apellido) AS jugador,
  j.email,
  j.telefono,
  t.fecha,
  t.hora_inicio
FROM turno t
JOIN jugador j ON t.id_jugador_responsable = j.id_jugador
WHERE t.fecha = CURDATE()
  AND t.estado = 'confirmado';

-- Vista para obtener los pagos realizados por un jugador específico (GET /jugador/:id/pagos)
CREATE OR REPLACE VIEW api_pago_jugador AS
SELECT 
  j.id_jugador,
  CONCAT(j.nombre, ' ', j.apellido) AS jugador,
  p.id_pago,
  p.fecha,
  p.metodo_pago,
  pi.concepto,
  pi.monto,
  t.id_turno
FROM pago p
JOIN pago_item pi ON p.id_pago = pi.id_pago
JOIN jugador j ON pi.id_jugador = j.id_jugador
LEFT JOIN turno t ON p.id_turno = t.id_turno
ORDER BY p.fecha DESC;

-- Vista para obtener los turnos confirmados del jugador (recordatorio de turnos)
CREATE OR REPLACE VIEW api_contacto_proximo_turno AS
SELECT 
  j.id_jugador,
  CONCAT(j.nombre, ' ', j.apellido) AS jugador,
  j.email,
  j.telefono,
  t.fecha,
  t.hora_inicio
FROM turno t
JOIN jugador j ON t.id_jugador_responsable = j.id_jugador
WHERE t.fecha = CURDATE()
  AND t.estado = 'confirmado';

-- Vista para obtener detalle completo de un turno específico (GET /turnos/:id)
CREATE OR REPLACE VIEW api_detalle_turno AS
SELECT 
  t.id_turno,
  t.fecha,
  t.hora_inicio,
  t.duracion,
  t.estado,
  j.id_jugador,
  CONCAT(j.nombre, ' ', j.apellido) AS jugador,
  j.email,
  j.telefono,
  c.id_cancha,
  c.nombre AS cancha,
  c.superficie,
  c.cubierta,
  c.iluminacion
FROM turno t
JOIN jugador j ON t.id_jugador_responsable = j.id_jugador
JOIN cancha c ON t.id_cancha = c.id_cancha;

-- Vista para historial completo de un jugador (Turnos, pagos, clases, etc.)
CREATE OR REPLACE VIEW api_historial_completo_jugador AS
SELECT 
  j.id_jugador,
  CONCAT(j.nombre, ' ', j.apellido) AS jugador,
  COUNT(DISTINCT t.id_turno) AS total_turnos,
  COUNT(DISTINCT jc.id_clase) AS total_clases,
  COUNT(DISTINCT pt.id_torneo) AS total_torneos,
  SUM(pi.monto) AS total_pagado
FROM jugador j
LEFT JOIN turno t ON j.id_jugador = t.id_jugador_responsable
LEFT JOIN jugador_clase jc ON jc.id_jugador = j.id_jugador AND jc.asistencia = TRUE
LEFT JOIN pago_item pi ON pi.id_jugador = j.id_jugador
LEFT JOIN jugador_equipo je ON je.id_jugador = j.id_jugador
LEFT JOIN participacion_torneo pt ON pt.id_equipo = je.id_equipo
GROUP BY j.id_jugador;

-- Vista para obtener la lista de jugadores con los pagos realizados
CREATE OR REPLACE VIEW api_jugadores_basico AS
SELECT 
  id_jugador,
  CONCAT(nombre, ' ', apellido) AS nombre_completo,
  email,
  telefono,
  estado,
  fecha_alta
FROM jugador
ORDER BY apellido;

-- Vista para los turnos de hoy
CREATE OR REPLACE VIEW api_turnos_hoy AS
SELECT 
  t.id_turno,
  t.hora_inicio,
  t.duracion,
  t.estado,
  j.id_jugador,
  CONCAT(j.nombre, ' ', j.apellido) AS jugador,
  c.nombre AS cancha
FROM turno t
JOIN jugador j ON t.id_jugador_responsable = j.id_jugador
JOIN cancha c ON t.id_cancha = c.id_cancha
WHERE t.fecha = CURDATE()
ORDER BY t.hora_inicio;

-- Vista para los equipos que participan en los torneos y su resultado
CREATE OR REPLACE VIEW api_participacion_torneo AS
SELECT 
  t.nombre AS torneo,
  e.nombre_equipo AS equipo,
  pt.resultado
FROM participacion_torneo pt
JOIN torneo t ON pt.id_torneo = t.id_torneo
JOIN equipo e ON pt.id_equipo = e.id_equipo;

-- Vista para el estado de reservas
CREATE OR REPLACE VIEW api_estado_reservas AS
SELECT 
  t.id_turno,
  t.fecha,
  t.hora_inicio,
  t.duracion,
  t.estado,
  j.id_jugador,
  CONCAT(j.nombre, ' ', j.apellido) AS jugador,
  c.nombre AS cancha
FROM turno t
JOIN jugador j ON t.id_jugador_responsable = j.id_jugador
JOIN cancha c ON t.id_cancha = c.id_cancha
WHERE t.estado = 'confirmado'
ORDER BY t.fecha, t.hora_inicio;

-- Vista para los pagos de los jugadores por equipo
CREATE OR REPLACE VIEW api_pagos_por_equipo AS
SELECT 
  e.nombre_equipo,
  SUM(pi.monto) AS total_pagado
FROM pago_item pi
JOIN jugador j ON pi.id_jugador = j.id_jugador
JOIN jugador_equipo je ON je.id_jugador = j.id_jugador
JOIN equipo e ON je.id_equipo = e.id_equipo
GROUP BY e.nombre_equipo;

