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

-- Vista para obtener los pagos realizados por un jugador específico
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
