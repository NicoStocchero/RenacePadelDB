-- FUNCIONES PARA PROBAR TODAS LAS VISTAS

-- 1. Probar la Vista api_turnos_hoy
-- Esta consulta muestra todos los turnos para hoy, con detalles sobre el jugador y la cancha.
SELECT * FROM api_turnos_hoy;
-- Comentario: Devuelve todos los turnos del día actual, mostrando la información del jugador y la cancha asignada.


-- 2. Probar la Vista api_detalle_turno
-- Esta consulta muestra el detalle completo de un turno específico, como la fecha, hora, jugador, cancha, etc.
SELECT * FROM api_detalle_turno WHERE id_turno = 1; -- Cambia el ID del turno
-- Comentario: Devuelve los detalles de un turno específico (puedes cambiar el ID del turno).


-- 3. Probar la Vista api_jugadores_basico
-- Esta consulta muestra los jugadores con información básica como nombre, email, teléfono, estado y fecha de alta.
SELECT * FROM api_jugadores_basico;
-- Comentario: Muestra la lista de jugadores con la información básica (nombre, email, teléfono, estado, etc.).


-- 4. Probar la Vista api_pago_jugador
-- Esta consulta muestra los pagos realizados por un jugador específico.
SELECT * FROM api_pago_jugador WHERE id_jugador = 1; -- Cambia el ID del jugador
-- Comentario: Devuelve los pagos realizados por el jugador especificado, incluyendo el concepto, monto y turno.


-- 5. Probar la Vista api_historial_completo_jugador
-- Esta consulta devuelve un resumen completo de la actividad de un jugador: turnos, clases, torneos y pagos.
SELECT * FROM api_historial_completo_jugador WHERE id_jugador = 1; -- Cambia el ID del jugador
-- Comentario: Devuelve el historial completo de un jugador, incluyendo la cantidad de turnos, clases, torneos y el total pagado.


-- 6. Probar la Vista api_contacto_proximo_turno
-- Esta consulta devuelve los turnos confirmados de hoy para un jugador específico.
SELECT * FROM api_contacto_proximo_turno WHERE id_jugador = 1; -- Cambia el ID del jugador
-- Comentario: Devuelve el turno confirmado del día de hoy para el jugador especificado.


-- 7. Probar la Vista api_estado_reservas
-- Esta consulta devuelve todas las reservas confirmadas, con información sobre los jugadores y las canchas.
SELECT * FROM api_estado_reservas;
-- Comentario: Devuelve todas las reservas confirmadas, mostrando detalles del jugador y la cancha.


-- 8. Probar la Vista api_pagos_por_equipo
-- Esta consulta muestra el total pagado por cada equipo.
SELECT * FROM api_pagos_por_equipo;
-- Comentario: Devuelve el total pagado por cada equipo, sumando los montos de los pagos realizados por sus jugadores.


-- 9. Probar la Vista api_participacion_torneo
-- Esta consulta muestra la participación de los equipos en los torneos, incluyendo el resultado de su participación.
SELECT * FROM api_participacion_torneo;
-- Comentario: Devuelve los equipos y su resultado en cada torneo, mostrando el nombre del torneo y del equipo.
