# Funciones SQL de Incidencias

## `fnEmailExist`

- **Descripción:**
  Verifica si un email existe en la tabla `Users`.
- **Entradas:**
  - `pEmail` (`VARCHAR(100)`) – Email institucional a verificar.
- **Salida:**
  - `BOOLEAN` – `TRUE` si el email existe, `FALSE` si no.
- **Ejemplo de ejecución:**
  ```sql
  SELECT fnEmailExist("alice.admin@uni.edu");
  ```

## `fnCountIssuesByIdIssueTypes`

- **Descripción:**
  Cuenta las incidencias (`Issues`) por ID de tipo de incidencia (`Issue_Types`).
- **Entradas:**
  - `pIdIssueTypes` (`INT`) – ID de `Issue_Types`.
- **Salida:**
  - `INT` – Número total de incidencias para ese tipo.
- **Ejemplo de ejecución:**
  ```sql
  SELECT fnCountIssuesByIdIssueTypes(2);
  ```

## `fnLastIssueCreatedByIdUserRegister`

- **Descripción:**
  Devuelve la fecha/hora de la última incidencia creada por un usuario específico.
- **Entradas:**
  - `pIdUser` (`INT`) – ID del usuario que registró la incidencia.
- **Salida:**
  - `DATETIME` – Fecha y hora de creación de la última incidencia.
- **Ejemplo de ejecución:**
  ```sql
  SELECT fnLastIssueCreatedByIdUserRegister(1);
  ```

## `fnCountIssuesByForReviewStatus`

- **Descripción:**
  Cuenta incidencias con estado `FOR_REVIEW`.
- **Entradas:**
  - `N/A`
- **Salida:**
  - `INT` – Número total de incidencias en estado `FOR_REVIEW`.
- **Ejemplo de ejecución:**
  ```sql
  SELECT fnCountIssuesByForReviewStatus();
  ```

## `fnAverageIssuesSeverities`

- **Descripción:**
  Calcula el promedio de severidades de las incidencias.
  (Las severidades se convierten a valores numéricos: `LOW=1`, `HIGH=2`, `MEDIUM=3`, `CRITICAL=4`).
- **Entradas:**
  - `N/A`
- **Salida:**
  - `FLOAT` – Promedio numérico de severidades.
- **Ejemplo de ejecución:**
  ```sql
  SELECT fnAverageIssuesSeverities();
  ```

## `fnLastIssueCreated`

- **Descripción:**
  Obtiene el ID de la última incidencia creada (más reciente).
- **Entradas:**
  - `N/A`
- **Salida:**
  - `INT` – ID de la incidencia más reciente.
- **Ejemplo de ejecución:**
  ```sql
  SELECT fnLastIssueCreated();
  ```

## `fnOldestIssueCreated`

- **Descripción:**
  Obtiene el ID de la incidencia más antigua creada.
- **Entradas:**
  - `N/A`
- **Salida:**
  - `INT` – ID de la incidencia más antigua.
- **Ejemplo de ejecución:**
  ```sql
  SELECT fnOldestIssueCreated();
  ```

## `fnUserWithMostIssuesRegistered`

- **Descripción:**
  Obtiene el ID del usuario que más incidencias ha registrado.
- **Entradas:**
  - `N/A`
- **Salida:**
  - `INT` – ID del usuario con más incidencias.
- **Ejemplo de ejecución:**
  ```sql
  SELECT fnUserWithMostIssuesRegistered();
  ```

## `fnAverageIssueContent`

- **Descripción:**
  Calcula el promedio de longitud del contenido de las incidencias (`sIssueContent`).
- **Entradas:**
  - `N/A`
- **Salida:**
  - `FLOAT` – Longitud promedio del contenido de las incidencias.
- **Ejemplo de ejecución:**
  ```sql
  SELECT fnAverageIssueContent();
  ```

## `fnCountIssuesWithoutContent`

- **Descripción:**
  Cuenta las incidencias sin contenido (contenido `NULL`, `""` o `" "`).
- **Entradas:**
  - `N/A`
- **Salida:**
  - `INT` – Número total de incidencias sin contenido.
- **Ejemplo de ejecución:**
  ```sql
  SELECT fnCountIssuesWithoutContent();
  ```

## `fnIssueWithLargestContent`

- **Descripción:**
  Devuelve el ID de la incidencia con mayor longitud de contenido.
- **Entradas:**
  - `N/A`
- **Salida:**
  - `INT` – ID de la incidencia con mayor contenido.
- **Ejemplo de ejecución:**
  ```sql
  SELECT fnIssueWithLargestContent();
  ```
