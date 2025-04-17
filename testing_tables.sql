-- FUNCIONES PARA PROBAR TODAS LAS TABLAS

-- 1. Probar la Tabla jugador
-- Esta consulta muestra todos los jugadores con información completa.
SELECT * FROM jugador;
-- Comentario: Devuelve todos los registros de la tabla 'jugador', mostrando la información completa de los jugadores.

-- 2. Probar la Tabla cancha
-- Esta consulta muestra todas las canchas registradas, con su estado, superficie, y características.
SELECT * FROM cancha;
-- Comentario: Devuelve todos los registros de la tabla 'cancha', mostrando información de cada cancha disponible.

-- 3. Probar la Tabla turno
-- Esta consulta muestra todos los turnos registrados en la tabla, con detalles de la cancha y jugador responsable.
SELECT * FROM turno;
-- Comentario: Devuelve todos los registros de la tabla 'turno', mostrando los turnos de reserva con sus datos asociados.

-- 4. Probar la Tabla pago
-- Esta consulta muestra todos los pagos realizados por los jugadores, asociados a turnos.
SELECT * FROM pago;
-- Comentario: Devuelve todos los registros de la tabla 'pago', mostrando los pagos realizados por los jugadores y el turno correspondiente.

-- 5. Probar la Tabla pago_item
-- Esta consulta muestra los detalles de cada ítem de pago por jugador.
SELECT * FROM pago_item;
-- Comentario: Devuelve todos los registros de la tabla 'pago_item', mostrando el detalle de los pagos realizados por los jugadores.

-- 6. Probar la Tabla clase
-- Esta consulta muestra todas las clases registradas, incluyendo la fecha, hora, y el entrenador asignado.
SELECT * FROM clase;
-- Comentario: Devuelve todos los registros de la tabla 'clase', mostrando detalles sobre las clases ofrecidas en el club.

-- 7. Probar la Tabla entrenador
-- Esta consulta muestra todos los entrenadores registrados con sus detalles de disponibilidad.
SELECT * FROM entrenador;
-- Comentario: Devuelve todos los registros de la tabla 'entrenador', mostrando la información sobre los entrenadores del club.

-- 8. Probar la Tabla jugador_clase
-- Esta consulta muestra las relaciones entre jugadores y clases, incluyendo la asistencia.
SELECT * FROM jugador_clase;
-- Comentario: Devuelve todos los registros de la tabla 'jugador_clase', mostrando qué jugadores asistieron a qué clases.

-- 9. Probar la Tabla equipo
-- Esta consulta muestra todos los equipos registrados, incluyendo el nombre del equipo.
SELECT * FROM equipo;
-- Comentario: Devuelve todos los registros de la tabla 'equipo', mostrando los equipos disponibles en el club.

-- 10. Probar la Tabla jugador_equipo
-- Esta consulta muestra las relaciones entre jugadores y equipos, con su respectiva asociación.
SELECT * FROM jugador_equipo;
-- Comentario: Devuelve todos los registros de la tabla 'jugador_equipo', mostrando qué jugadores pertenecen a qué equipos.

-- 11. Probar la Tabla participacion_torneo
-- Esta consulta muestra todas las participaciones de equipos en torneos, con los resultados.
SELECT * FROM participacion_torneo;
-- Comentario: Devuelve todos los registros de la tabla 'participacion_torneo', mostrando la participación de equipos en torneos y sus resultados.

-- 12. Probar la Tabla torneo
-- Esta consulta muestra todos los torneos registrados, con sus detalles de fecha, reglas y estado.
SELECT * FROM torneo;
-- Comentario: Devuelve todos los registros de la tabla 'torneo', mostrando la información completa sobre los torneos organizados en el club.

-- 13. Probar la Tabla empleado
-- Esta consulta muestra todos los empleados registrados en el club, con su función y datos de contacto.
SELECT * FROM empleado;
-- Comentario: Devuelve todos los registros de la tabla 'empleado', mostrando los datos de los empleados administrativos del club.

-- 14. Probar la Tabla caja
-- Esta consulta muestra todos los movimientos de caja registrados, con detalles sobre el tipo de operación y el monto.
SELECT * FROM caja;
-- Comentario: Devuelve todos los registros de la tabla 'caja', mostrando los ingresos y egresos registrados en el club.

