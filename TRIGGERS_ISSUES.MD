# Disparadores SQL de Incidencias

## `trgBeforeInsertIssues_setCreatedAtIfNull`

- **Descripción:** Asignar fecha de creación automática: Asegura que la columna de fecha de creación (`dtCreatedAtIssues`) tenga un valor, asignando la hora actual si no se proporciona uno.
- **Tabla Afectada:** `Issues`
- **Evento Disparador:** `BEFORE INSERT`
- **Acción Realizada:** Establece `NEW.dtCreatedAtIssues = NOW()` si el valor entrante es `NULL`.
- **Ejemplo de ejecución o situación que provocaría su disparo:**
  Se crea una nueva incidencia sin incluir la columna `dtCreatedAtIssues`. El trigger la rellena automáticamente.

## `trgBeforeUpdateIssues_setUpdatedAt`

- **Descripción:** Actualizar fecha de modificación: Actualiza automáticamente la fecha de última modificación (`dtUpdatedAtIssues`) cada vez que se realizan cambios en una incidencia.
- **Tabla Afectada:** `Issues`
- **Evento Disparador:** `BEFORE UPDATE`
- **Acción Realizada:** Establece `NEW.dtUpdatedAtIssues = NOW()`.
- **Ejemplo de ejecución o situación que provocaría su disparo:**
  Se cambia el `sIssueContent` de la incidencia 10. Antes de guardar, `dtUpdatedAtIssues` de la fila 10 se actualiza a la hora actual.

## `trgAfterInsertIssues_insertHistoryLog`

- **Descripción:** Registrar log de inserción: Registra en el log la creación completa de una nueva incidencia para fines de auditoría.
- **Tabla Afectada:** `Issues`
- **Evento Disparador:** `AFTER INSERT`
- **Acción Realizada:** Inserta un registro de tipo `'CREATE'` en `History_Logs` con el ID de la incidencia y un JSON (`tDetails`) que contiene los datos de la fila `NEW`.

> [!NOTE]
> Se agrego la tabla `History_Logs` para almacenar el historial de cambios de la tabla `Issues`.

- **Ejemplo de ejecución o situación que provocaría su disparo:**
  Un usuario registra una nueva incidencia. Una fila se añade a `History_Logs` con `eActionType = 'CREATE'`.

## `trgAfterUpdateIssues_insertHistoryLog`

- **Descripción:** Registrar log de actualización y Notificación de cambios críticos: Registra las modificaciones importantes de una incidencia en la tabla de historial, guardando los valores `OLD` y `NEW`.
- **Tabla Afectada:** `Issues`
- **Evento Disparador:** `AFTER UPDATE`
- **Acción Realizada:** Inserta un registro de tipo `'UPDATE'` en `History_Logs` si hay cambios en campos clave (estado, contenido, revisor, severidad, etc.).

> [!IMPORTANT]
> Este trigger cumple con el requerimiento de `"Notificación de cambios críticos"` porque ya revisa los cambios en `eStatus` y `fkIdSeverities` (entre otros) dentro del mismo log de actualización. También cumple con `"Histórico de descripciones"` al registrar `content_old` y `content_new` en el JSON.

- **Ejemplo de ejecución o situación que provocaría su disparo:**
  El revisor cambia `eStatus` de `'FOR_REVIEW'` a `'REVIEWED'`. Se añade un registro a `History_Logs` que indica: `status_old: 'FOR_REVIEW'`, `status_new: 'REVIEWED'`.

## `trgBeforeDeleteIssues_BlockResolved`

- **Descripción:** Bloquear eliminación de incidencias cerradas: Impide la eliminación de cualquier incidencia cuyo estado sea `'RESOLVED'` (o cerrado).
- **Tabla Afectada:** `Issues`
- **Evento Disparador:** `BEFORE DELETE`
- **Acción Realizada:** Bloquea la operación `DELETE` si `OLD.eStatus` es `'RESOLVED'`, emitiendo un error SQL `45000`.
- **Ejemplo de ejecución o situación que provocaría su disparo:**
  Se intenta eliminar la incidencia 11, cuyo estado es `'RESOLVED'`. La operación es bloqueada.

## `trgBeforeDeleteIssues_Backup`

- **Descripción:** Backup de incidencias eliminadas: Garantiza la persistencia de los datos de una incidencia eliminada, moviendo la información a una tabla de respaldo antes de que se borre permanentemente.
- **Tabla Afectada:** `Issues`
- **Evento Disparador:** `BEFORE DELETE`
- **Acción Realizada:** Copia todos los campos relevantes de la fila `OLD` a la tabla `Issues_Backup`.

> [!NOTE]
> Se agrego la tabla `Issues_Backup` para almacenar la copia de los datos.

- **Ejemplo de ejecución o situación que provocaría su disparo:**
  Se elimina la incidencia 4. Antes de que se complete el `DELETE`, una fila idéntica se inserta en `Issues_Backup`.

## `trgBeforeInsertIssues_ValidateSeverity`

- **Descripción:**
  **Control de gravedad.** Aplica una regla de negocio que asegura que el nivel de gravedad de una incidencia siempre cumpla con un valor mínimo preestablecido.
- **Tabla Afectada:** `Issues`
- **Evento Disparador:** `BEFORE INSERT`
- **Acción Realizada:** Establece `NEW.fkIdSeverities` al valor mínimo (`1`) si el valor entrante es menor a este.
- **Ejemplo de ejecución o situación que provocaría su disparo:**
  Se intenta crear una incidencia con `fkIdSeverities = 0`. El trigger corrige internamente el valor a `1` antes de la inserción.

## `trgAfterInsertIssuesCulprits_IncrementCount`

- **Descripción:**
  **Contador de incidencias por usuario (Culpables).** Mantiene un registro actualizado de cuántas veces cada usuario ha sido listado como culpable en una incidencia.
- **Tabla Afectada:** `Issue_Culprits`
- **Evento Disparador:** `AFTER INSERT`
- **Acción Realizada:** Incrementa el campo `iIssuesCulpritCount` en la tabla `Users` para el ID de usuario recién insertado en `Issue_Culprits`.

> [!NOTE]
> Se modifico la tabla `Users` agregando el campo `iIssuesCulpritCount`.

- **Ejemplo de ejecución o situación que provocaría su disparo:**
  Se registra una nueva fila en `Issue_Culprits` que asocia la incidencia 15 con el `fkIdUsers = 7`. El campo `Users.iIssuesCulpritCount` para el usuario 7 se incrementa en 1.
