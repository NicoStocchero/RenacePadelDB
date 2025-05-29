# Renace Padel Club - Base de Datos

**Renace Padel Club** es un proyecto académico que implementa una base de datos relacional para gestionar integralmente un club deportivo especializado en pádel. El sistema permite centralizar reservas, pagos, clases, torneos y movimientos financieros, facilitando la administración diaria del club y mejorando la experiencia de los jugadores.

El diseño de la base de datos sigue buenas prácticas de modelado, con normalización, claves foráneas bien definidas y mecanismos para asegurar integridad referencial. Se incluyen vistas, funciones, stored procedures y triggers para optimizar consultas y operaciones recurrentes.

---

## 🎯 Objetivos del Proyecto

✅ Centralizar la información operativa, deportiva y financiera del club  
✅ Prevenir errores y duplicados en las reservas y pagos  
✅ Permitir consultas eficientes y reportes analíticos  
✅ Facilitar futuras integraciones como notificaciones o un panel administrativo  

---

## 🗂️ Estructura del Repositorio

```plaintext
RenacePadelDB/
├── create_tables.sql                   # Estructura de tablas con claves y restricciones
├── create_views.sql                    # Vistas para consultas complejas
├── functions_procedures_triggers.sql   # Funciones, procedimientos y triggers
├── insert_data.sql                     # Datos de prueba para poblar las tablas
├── delete_for_testing.sql              # Script para limpiar datos de prueba
├── testing_tables.sql                  # Consultas para verificar las tablas
├── testing_views.sql                   # Consultas para verificar las vistas
```

---

## 🏗️ Contenidos principales

### 📋 Tablas

- `jugador` – Información personal de los jugadores
- `cancha` – Datos de canchas disponibles
- `turno` – Turnos reservados con control de superposición
- `clase` – Clases dictadas por entrenadores
- `jugador_clase` – Relación jugador-clase
- `torneo` – Torneos organizados
- `equipo` – Equipos de jugadores
- `jugador_equipo` – Relación jugador-equipo
- `participacion_torneo` – Participación de equipos en torneos
- `pago` – Pagos realizados
- `pago_item` – Detalle de pagos por jugador y concepto
- `empleado` – Empleados del club
- `caja` – Movimientos financieros
- `entrenador` – Datos de entrenadores

---

### 👓 Vistas destacadas

| Nombre                | Descripción                                            | Objetivo                                 |
| --------------------- | ------------------------------------------------------ | --------------------------------------- |
| `vw_turnos_confirmados` | Turnos confirmados con datos de jugador y cancha     | Filtrar reservas activas por jugador o fecha |
| `vw_pagos_jugadores`  | Total pagado por jugador con desglose de conceptos    | Visualizar ingresos individuales         |
| `vw_asistencias_clases` | Asistencias de jugadores a clases                   | Analizar participación y actividad       |

---

### 🛠️ Funciones y procedimientos

- `fn_calcularEdadJugador` – Devuelve la edad actual de un jugador  
- `fn_pagoTotalJugador` – Total pagado por un jugador  
- `fn_participacionesJugador` – Cantidad de torneos jugados  
- `fn_totalClasesJugador` – Clases a las que asistió un jugador  
- `sp_crear_turno` – Valida y crea un turno  
- `sp_confirmar_turno` – Cambia estado de turno a confirmado  
- `sp_registrar_pago` – Registra pago y movimiento de caja  
- `sp_eliminar_jugador` – Elimina jugador y sus relaciones  
- `trg_pago_insert` – Trigger: al crear pago, genera movimiento en caja  
- `trg_turno_insert` – Trigger: valida cancha activa antes de insertar turno  

---

## 🧠 Aprendizajes Clave

- Modelado relacional en SQL
- Integridad referencial con claves foráneas
- Vistas SQL para consultas específicas
- Funciones y procedimientos almacenados para lógica de negocio
- Triggers para automatización de procesos
- Generación de datos realistas para testing

---

## 📦 Cómo usar este proyecto

1️⃣ Clona el repositorio  
```bash
git clone https://github.com/NicoStocchero/RenacePadelDB
```

2️⃣ Abre tu cliente SQL (MySQL Workbench recomendado)

3️⃣ Ejecuta los scripts en orden:
```
1. create_tables.sql – Estructura de la base de datos

2. insert_data.sql – Datos de prueba

3. functions_procedures_triggers.sql – Funciones, procedimientos y triggers

4. create_views.sql – Vistas para consultas complejas
```

4️⃣ Ejecuta consultas, procedimientos o pruebas con los archivos testing_* según necesidad

## 📚 Tecnologías utilizadas

- MySQL 8.x
- SQL Scripts (DDL, DML, DCL)
- Modelado relacional y normalización

## Licencia
Este proyecto fue desarrollado con fines educativos como parte de un trabajo académico. Puedes utilizarlo como referencia para tus propios proyectos, pero no está destinado para uso comercial directo sin adaptaciones.

