-- Función: fn_calcularEdadJugador
-- Descripción: Devuelve la edad actual de un jugador según su fecha de nacimiento.
-- Objetivo: Obtener la edad de un jugador para informes o vistas.
-- Tablas usadas: jugador

DELIMITER //

CREATE FUNCTION fn_calcularEdadJugador(jugadorId INT) 
RETURNS INT
DETERMINISTIC
BEGIN
  DECLARE edad INT;
  
  SELECT TIMESTAMPDIFF(YEAR, fecha_nacimiento, CURDATE())
  INTO edad
  FROM jugador
  WHERE id_jugador = jugadorId;

  RETURN edad;
END //

DELIMITER ;

-- Función: fn_pagoTotalJugador
-- Descripción: Devuelve el total pagado por un jugador sumando los conceptos en la tabla pago_item.
-- Objetivo: Calcular cuánto dinero ha pagado un jugador.
-- Tablas usadas: pago_item

DELIMITER //

CREATE FUNCTION fn_pagoTotalJugador(jugadorId INT) 
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
  DECLARE total DECIMAL(10,2);

  SELECT IFNULL(SUM(monto), 0)
  INTO total
  FROM pago_item
  WHERE id_jugador = jugadorId;

  RETURN total;
END //

DELIMITER ;

-- Función: fn_participacionesJugador
-- Descripción: Devuelve la cantidad de torneos en los que participó un jugador.
-- Objetivo: Saber en cuántos torneos jugó un jugador, mediante su equipo.
-- Tablas usadas: jugador_equipo, participacion_torneo

DELIMITER //

CREATE FUNCTION fn_participacionesJugador(jugadorId INT) 
RETURNS INT
DETERMINISTIC
BEGIN
  DECLARE participaciones INT;

  SELECT COUNT(DISTINCT pt.id_torneo)
  INTO participaciones
  FROM jugador_equipo je
  JOIN participacion_torneo pt ON je.id_equipo = pt.id_equipo
  WHERE je.id_jugador = jugadorId;

  RETURN participaciones;
END //

DELIMITER ;

-- Función: fn_totalClasesJugador
-- Descripción: Devuelve la cantidad de clases a las que asistió un jugador.
-- Objetivo: Contar solo las clases donde la asistencia es TRUE.
-- Tablas usadas: jugador_clase

DELIMITER //

CREATE FUNCTION fn_totalClasesJugador(jugadorId INT) 
RETURNS INT
DETERMINISTIC
BEGIN
  DECLARE total INT;

  SELECT COUNT(*)
  INTO total
  FROM jugador_clase
  WHERE id_jugador = jugadorId AND asistencia = TRUE;

  RETURN total;
END //

DELIMITER ;

-- Stored Procedure: sp_crear_turno
-- Descripción: Inserta un nuevo turno (reserva) validando que la cancha esté activa.
-- Objetivo: Permitir crear un turno solo si la cancha está disponible.
-- Tablas usadas: turno, cancha

DELIMITER //

-- Ejemplo de llamadas a funciones
SELECT fn_calcularEdadJugador(1);
SELECT fn_pagoTotalJugador(1);
SELECT fn_participacionesJugador(1);
SELECT fn_totalClasesJugador(3);

CREATE PROCEDURE sp_crear_turno(
  IN p_fecha DATE,
  IN p_hora_inicio TIME,
  IN p_duracion INT,
  IN p_estado ENUM('pendiente', 'confirmado', 'cancelado'),
  IN p_id_cancha INT,
  IN p_id_jugador_responsable INT
)
BEGIN
  DECLARE v_estado_cancha ENUM('activa', 'mantenimiento');

  -- Verificar que la cancha esté activa
  SELECT estado INTO v_estado_cancha
  FROM cancha
  WHERE id_cancha = p_id_cancha;

  IF v_estado_cancha IS NULL THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Error: La cancha no existe';
  ELSEIF v_estado_cancha != 'activa' THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Error: La cancha no está activa';
  ELSE
    -- Insertar el turno
    INSERT INTO turno (fecha, hora_inicio, duracion, estado, id_cancha, id_jugador_responsable)
    VALUES (p_fecha, p_hora_inicio, p_duracion, p_estado, p_id_cancha, p_id_jugador_responsable);
  END IF;
END //

DELIMITER ;

-- Stored Procedure: sp_confirmar_turno
-- Descripción: Cambia el estado de un turno a 'confirmado' solo si el turno existe y no está cancelado.
-- Objetivo: Confirmar la reserva de un turno validando su existencia y estado.
-- Tablas usadas: turno

DELIMITER //

CREATE PROCEDURE sp_confirmar_turno(
  IN p_id_turno INT
)
BEGIN
  DECLARE v_estado_turno ENUM('pendiente', 'confirmado', 'cancelado');

  -- Verificar que el turno exista
  SELECT estado INTO v_estado_turno
  FROM turno
  WHERE id_turno = p_id_turno;

  IF v_estado_turno IS NULL THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Error: El turno no existe';
  ELSEIF v_estado_turno = 'cancelado' THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Error: No se puede confirmar un turno cancelado';
  ELSE
    -- Actualizar el turno a 'confirmado'
    UPDATE turno
    SET estado = 'confirmado'
    WHERE id_turno = p_id_turno;
  END IF;
END //

DELIMITER ;

-- Stored Procedure: sp_registrar_pago
-- Descripción: Registra un pago asociado a un turno, con detalles por jugador, y crea un movimiento en caja.
-- Objetivo: Procesar un pago completo, registrando en las tablas pago, pago_item y caja.
-- Tablas usadas: pago, pago_item, caja, turno

DELIMITER //

CREATE PROCEDURE sp_registrar_pago(
  IN p_fecha DATE,
  IN p_metodo_pago ENUM('efectivo', 'tarjeta', 'transferencia'),
  IN p_id_turno INT,
  IN p_id_jugador INT,
  IN p_concepto VARCHAR(100),
  IN p_monto DECIMAL(10,2),
  IN p_id_empleado INT
)
BEGIN
  DECLARE v_estado_turno ENUM('pendiente', 'confirmado', 'cancelado');
  DECLARE v_id_pago INT;

  -- Validar existencia y estado del turno
  SELECT estado INTO v_estado_turno
  FROM turno
  WHERE id_turno = p_id_turno;

  IF v_estado_turno IS NULL THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Error: El turno no existe';
  ELSEIF v_estado_turno != 'confirmado' THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Error: Solo se puede registrar pagos de turnos confirmados';
  ELSE
    -- Insertar el pago
    INSERT INTO pago (fecha, metodo_pago, id_turno)
    VALUES (p_fecha, p_metodo_pago, p_id_turno);

    SET v_id_pago = LAST_INSERT_ID();

    -- Insertar detalle del pago
    INSERT INTO pago_item (id_pago, id_jugador, concepto, monto)
    VALUES (v_id_pago, p_id_jugador, p_concepto, p_monto);

    -- Registrar movimiento en caja
    INSERT INTO caja (fecha, tipo, concepto, monto, id_empleado)
    VALUES (p_fecha, 'ingreso', CONCAT('Pago de turno ID ', p_id_turno, ' - ', p_concepto), p_monto, p_id_empleado);
  END IF;
END //

DELIMITER ;

-- Stored Procedure: sp_eliminar_jugador
-- Descripción: Elimina un jugador y limpia sus datos relacionados en clases, equipos y pagos.
-- Objetivo: Borrar la información de un jugador y evitar datos huérfanos.
-- Tablas usadas: jugador, jugador_clase, jugador_equipo, pago_item

DELIMITER //

CREATE PROCEDURE sp_eliminar_jugador(
  IN p_id_jugador INT
)
BEGIN
  DECLARE v_jugador_existente INT;

  -- Verificar que el jugador exista
  SELECT COUNT(*) INTO v_jugador_existente
  FROM jugador
  WHERE id_jugador = p_id_jugador;

  IF v_jugador_existente = 0 THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Error: El jugador no existe';
  ELSE
    -- Eliminar de jugador_clase
    DELETE FROM jugador_clase WHERE id_jugador = p_id_jugador;

    -- Eliminar de jugador_equipo
    DELETE FROM jugador_equipo WHERE id_jugador = p_id_jugador;

    -- Eliminar de pago_item
    DELETE FROM pago_item WHERE id_jugador = p_id_jugador;

    -- Finalmente, eliminar de jugador
    DELETE FROM jugador WHERE id_jugador = p_id_jugador;
  END IF;
END //

DELIMITER ;

-- Ejemplo de llamada a Stored Procedures
CALL sp_crear_turno(CURDATE(), '15:00:00', 60, 'pendiente', 1, 1);
CALL sp_confirmar_turno(3); -- Cambia el ID del turno según tus datos
CALL sp_registrar_pago(CURDATE(), 'efectivo', 1, 1, 'Pago de prueba', 2500.00, 1);
CALL sp_eliminar_jugador(2); -- Cuidado, elimina al jugador 2 y su info asociada

-- Trigger: trg_pago_insert
-- Descripción: Al insertar un pago, crea automáticamente un movimiento en caja.
-- Objetivo: Registrar los ingresos de pagos en la caja.
-- Tablas afectadas: pago, caja

DELIMITER //

CREATE TRIGGER trg_pago_insert
AFTER INSERT ON pago
FOR EACH ROW
BEGIN
  INSERT INTO caja (fecha, tipo, concepto, monto, id_empleado)
  VALUES (
    NEW.fecha,
    'ingreso',
    CONCAT('Pago registrado - ID Turno ', NEW.id_turno),
    -- Monto total del pago: sumamos los items del pago
    (SELECT IFNULL(SUM(monto), 0) FROM pago_item WHERE id_pago = NEW.id_pago),
    NULL -- Empleado no asignado por ahora (podés adaptarlo)
  );
END //

DELIMITER ;

-- Trigger: trg_turno_insert
-- Descripción: Valida que la cancha esté activa al intentar insertar un nuevo turno.
-- Objetivo: Evitar la creación de turnos en canchas que no están disponibles.
-- Tablas afectadas: turno, cancha

-- 												¡¡¡NOTA id_empleado!!! 
-- Actualmente se inserta como NULL porque no hay integración de usuarios logueados en el sistema.
-- En una futura mejora, podrías:
-- 1. Tener una variable de sesión o contexto (ej: @usuario_actual) que contenga el ID del empleado logueado.
-- 2. Pasar ese ID como parámetro en las funciones/procedures o setearlo dinámicamente.
-- 3. Adaptar la estructura del sistema para que cada acción registre el usuario responsable (en tablas como caja, pago, etc.).

-- Por ahora, dejamos el id_empleado como NULL para no romper la integridad referencial.

DELIMITER //

CREATE TRIGGER trg_turno_insert
BEFORE INSERT ON turno
FOR EACH ROW
BEGIN
  DECLARE v_estado_cancha ENUM('activa', 'mantenimiento');

  -- Obtener el estado de la cancha
  SELECT estado INTO v_estado_cancha
  FROM cancha
  WHERE id_cancha = NEW.id_cancha;

  -- Validar el estado
  IF v_estado_cancha IS NULL THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Error: La cancha no existe';
  ELSEIF v_estado_cancha != 'activa' THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Error: No se pueden crear turnos en canchas en mantenimiento';
  END IF;
END //

DELIMITER ;

