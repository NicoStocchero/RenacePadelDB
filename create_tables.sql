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

-- Tabla de entrenadores
CREATE TABLE IF NOT EXISTS entrenador (
  id_entrenador INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(100),
  tipo VARCHAR(50),
  disponibilidad TEXT
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
  evento_asociado BOOLEAN,
  FOREIGN KEY (id_entrenador) REFERENCES entrenador(id_entrenador) -- Relación con 'entrenador'
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

-- Tabla de participación en torneos
CREATE TABLE IF NOT EXISTS participacion_torneo (
  id_participacion INT PRIMARY KEY AUTO_INCREMENT,
  id_torneo INT,
  id_equipo INT,
  resultado VARCHAR(50),
  FOREIGN KEY (id_torneo) REFERENCES torneo(id_torneo), -- Relación con 'torneo'
  FOREIGN KEY (id_equipo) REFERENCES equipo(id_equipo) -- Relación con 'equipo'
);

-- Tabla de empleados
CREATE TABLE IF NOT EXISTS empleado (
  id_empleado INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(100),
  rol VARCHAR(50),
  email VARCHAR(100),
  fecha_alta DATE
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
