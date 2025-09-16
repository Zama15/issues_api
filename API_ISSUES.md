# Endpoint de Incidencias

## Descripción General

API REST para gestión de incidencias con operaciones de consulta, actualización y eliminación.

## Endpoints

### Conteo de Incidencias

#### 1. Contar Incidencias por Tipo

**Procedimiento Almacenado:** `countIssuesByIdIssueTypes`
**Endpoint:** `/issues/count/by-type/:id`  
**Método HTTP:** `GET`  
**Descripción:** Cuenta todas las incidencias que corresponden a un tipo específico de incidencia.

**Parámetros de entrada:**
`/issues/count/by-type/1`

**Respuesta:**

```json
{
  "iIdIssuesTypes": 1,
  "sNameIssuesTypes": "BEHAVIOR",
  "issuesCounted": 4
}
```

#### 2. Contar Incidencias sin Contenido

**Procedimiento Almacenado:** `countIssuesWithoutContent`  
**Endpoint:** `/issues/count/without-content`  
**Método HTTP:** `GET`  
**Descripción:** Cuenta todas las incidencias que no tienen contenido (nulo, vacío o solo espacios).

**Parámetros de entrada:**
N/A

**Respuesta:**

```json
{
  "issuesWithoutContent": 4
}
```

### Consultas de Incidencias

#### 3. Obtener Incidencias Posteriores a una Fecha

**Procedimiento Almacenado:** `getIssuesAfterDate`  
**Endpoint:** `/issues/after/:date`  
**Método HTTP:** `GET`  
**Descripción:** Obtiene todas las incidencias registradas después de una fecha específica.

**Parámetros de entrada:**
`/issues/after/2025-04-10`

**Respuesta:**

```json
[
  {
    "iIdIssues": 3,
    "tDate": "2025-04-15T17:15:00.000Z",
    "sIssueContent": "Internet connection unstable in Lab 201",
    "eStatus": "FOR_REVIEW",
    "sNameIssuesTypes": "TECHNICAL",
    "sNameSeverities": "MEDIUM",
    "sNameClassrooms": "Lab 201",
    "userRegister": "Diana Student",
    "userReviewer": "Alice Admin"
  },
  {
    "iIdIssues": 9,
    "tDate": "2025-04-12T15:00:00.000Z",
    "sIssueContent": "Students arriving consistently late and disrupting class",
    "eStatus": "FOR_REVIEW",
    "sNameIssuesTypes": "BEHAVIOR",
    "sNameSeverities": "CRITICAL",
    "sNameClassrooms": "Room 101",
    "userRegister": "Dr. Bob Professor",
    "userReviewer": "Alice Admin"
  },
  {
    "iIdIssues": 12,
    "tDate": "2025-04-10T22:00:00.000Z",
    "sIssueContent": "Audio system not working properly in Room 101",
    "eStatus": "FOR_REVIEW",
    "sNameIssuesTypes": "TECHNICAL",
    "sNameSeverities": "MEDIUM",
    "sNameClassrooms": "Room 101",
    "userRegister": "Dr. Bob Professor",
    "userReviewer": "Alice Admin"
  },
  {
    "iIdIssues": 15,
    "tDate": "2025-04-14T19:45:00.000Z",
    "sIssueContent": "Suspicious activity near emergency exit in Lab 201",
    "eStatus": "FOR_REVIEW",
    "sNameIssuesTypes": "SECURITY",
    "sNameSeverities": "HIGH",
    "sNameClassrooms": "Lab 201",
    "userRegister": "Diana Student",
    "userReviewer": "Alice Admin"
  }
]
```

#### 4. Obtener Incidencia con Mayor Contenido

**Procedimiento Almacenado:** `getIssueWithMaxContent`  
**Endpoint:** `/issues/with-max-content`  
**Método HTTP:** `GET`  
**Descripción:** Obtiene la incidencia que tiene el contenido más extenso (mayor cantidad de caracteres).

**Parámetros de entrada:**
N/A

**Respuesta:**

```json
{
  "iIdIssues": 10,
  "tDate": "2025-03-18T17:30:00.000Z",
  "sIssueContent": "Computers in Lab 201 running very slowly, affecting productivity",
  "eStatus": "FOR_REVIEW"
}
```

#### 5. Obtener Incidencias Ordenadas por Fecha

**Procedimiento Almacenado:** `getIssuesOrderByDate`  
**Endpoint:** `/issues/order-by-date`  
**Método HTTP:** `GET`  
**Descripción:** Obtiene todas las incidencias ordenadas por fecha de forma descendente (más recientes primero).

**Parámetros de entrada:**
N/A

**Respuesta:**

```json
[
  {
    "iIdIssues": 3,
    "tDate": "2025-04-15T17:15:00.000Z",
    "sIssueContent": "Internet connection unstable in Lab 201",
    "eStatus": "FOR_REVIEW",
    "sNameIssuesTypes": "TECHNICAL",
    "sNameSeverities": "MEDIUM",
    "sNameClassrooms": "Lab 201",
    "userRegister": "Diana Student",
    "userReviewer": "Alice Admin"
  },
  {
    "iIdIssues": 15,
    "tDate": "2025-04-14T19:45:00.000Z",
    "sIssueContent": "Suspicious activity near emergency exit in Lab 201",
    "eStatus": "FOR_REVIEW",
    "sNameIssuesTypes": "SECURITY",
    "sNameSeverities": "HIGH",
    "sNameClassrooms": "Lab 201",
    "userRegister": "Diana Student",
    "userReviewer": "Alice Admin"
  },
  {
    "iIdIssues": 9,
    "tDate": "2025-04-12T15:00:00.000Z",
    "sIssueContent": "Students arriving consistently late and disrupting class",
    "eStatus": "FOR_REVIEW",
    "sNameIssuesTypes": "BEHAVIOR",
    "sNameSeverities": "CRITICAL",
    "sNameClassrooms": "Room 101",
    "userRegister": "Dr. Bob Professor",
    "userReviewer": "Alice Admin"
  },
  {
    "iIdIssues": 12,
    "tDate": "2025-04-10T22:00:00.000Z",
    "sIssueContent": "Audio system not working properly in Room 101",
    "eStatus": "FOR_REVIEW",
    "sNameIssuesTypes": "TECHNICAL",
    "sNameSeverities": "MEDIUM",
    "sNameClassrooms": "Room 101",
    "userRegister": "Dr. Bob Professor",
    "userReviewer": "Alice Admin"
  },
  {
    "iIdIssues": 14,
    "tDate": "2025-04-07T13:30:00.000Z",
    "sIssueContent": "Door lock malfunction in Room 101, security concern",
    "eStatus": "FOR_REVIEW",
    "sNameIssuesTypes": "SECURITY",
    "sNameSeverities": "HIGH",
    "sNameClassrooms": "Room 101",
    "userRegister": "Carlos Tutor",
    "userReviewer": "Alice Admin"
  },
  {
    "iIdIssues": 6,
    "tDate": "2025-04-05T19:20:00.000Z",
    "sIssueContent": "Whiteboard markers dried out, need replacement",
    "eStatus": "RESOLVED",
    "sNameIssuesTypes": "MAINTENANCE",
    "sNameSeverities": "LOW",
    "sNameClassrooms": "Room 101",
    "userRegister": "Diana Student",
    "userReviewer": "Alice Admin"
  },
  {
    "iIdIssues": 7,
    "tDate": "2025-03-25T16:15:00.000Z",
    "sIssueContent": "Student using phone during lecture, disrupting others",
    "eStatus": "REVIEWED",
    "sNameIssuesTypes": "BEHAVIOR",
    "sNameSeverities": "CRITICAL",
    "sNameClassrooms": "Room 101",
    "userRegister": "Dr. Bob Professor",
    "userReviewer": "Alice Admin"
  },
  {
    "iIdIssues": 13,
    "tDate": "2025-03-22T18:00:00.000Z",
    "sIssueContent": "Unauthorized person found in Lab 201 after hours",
    "eStatus": "REVIEWED",
    "sNameIssuesTypes": "SECURITY",
    "sNameSeverities": "HIGH",
    "sNameClassrooms": "Lab 201",
    "userRegister": "Alice Admin",
    "userReviewer": "Alice Admin"
  },
  {
    "iIdIssues": 5,
    "tDate": "2025-03-20T22:30:00.000Z",
    "sIssueContent": "Broken chair in Lab 201, potential safety hazard",
    "eStatus": "RESOLVED",
    "sNameIssuesTypes": "MAINTENANCE",
    "sNameSeverities": "LOW",
    "sNameClassrooms": "Lab 201",
    "userRegister": "Carlos Tutor",
    "userReviewer": "Alice Admin"
  },
  {
    "iIdIssues": 10,
    "tDate": "2025-03-18T17:30:00.000Z",
    "sIssueContent": "Computers in Lab 201 running very slowly, affecting productivity",
    "eStatus": "FOR_REVIEW",
    "sNameIssuesTypes": "TECHNICAL",
    "sNameSeverities": "MEDIUM",
    "sNameClassrooms": "Lab 201",
    "userRegister": "Diana Student",
    "userReviewer": "Alice Admin"
  },
  {
    "iIdIssues": 1,
    "tDate": "2025-03-10T15:30:00.000Z",
    "sIssueContent": "Projector not working in Room 101",
    "eStatus": "FOR_REVIEW",
    "sNameIssuesTypes": "MAINTENANCE",
    "sNameSeverities": "LOW",
    "sNameClassrooms": "Room 101",
    "userRegister": "Diana Student",
    "userReviewer": "Alice Admin"
  },
  {
    "iIdIssues": 8,
    "tDate": "2024-04-08T21:45:00.000Z",
    "sIssueContent": "Inappropriate language and harassment towards classmates",
    "eStatus": "CANCELLED",
    "sNameIssuesTypes": "BEHAVIOR",
    "sNameSeverities": "CRITICAL",
    "sNameClassrooms": "Lab 201",
    "userRegister": "Carlos Tutor",
    "userReviewer": "Alice Admin"
  },
  {
    "iIdIssues": 11,
    "tDate": "2024-04-03T20:20:00.000Z",
    "sIssueContent": "Software license expired, unable to access required applications",
    "eStatus": "RESOLVED",
    "sNameIssuesTypes": "TECHNICAL",
    "sNameSeverities": "MEDIUM",
    "sNameClassrooms": "Lab 201",
    "userRegister": "Carlos Tutor",
    "userReviewer": "Alice Admin"
  },
  {
    "iIdIssues": 2,
    "tDate": "2024-04-01T20:00:00.000Z",
    "sIssueContent": "Disruptive behavior during Lab 201 session",
    "eStatus": "REVIEWED",
    "sNameIssuesTypes": "BEHAVIOR",
    "sNameSeverities": "CRITICAL",
    "sNameClassrooms": "Lab 201",
    "userRegister": "Carlos Tutor",
    "userReviewer": "Alice Admin"
  },
  {
    "iIdIssues": 4,
    "tDate": "2024-03-15T14:45:00.000Z",
    "sIssueContent": "Air conditioning unit making loud noises in Room 101",
    "eStatus": "CANCELLED",
    "sNameIssuesTypes": "MAINTENANCE",
    "sNameSeverities": "LOW",
    "sNameClassrooms": "Room 101",
    "userRegister": "Dr. Bob Professor",
    "userReviewer": "Alice Admin"
  }
]
```

#### 6. Buscar Incidencias por Contenido

**Procedimiento Almacenado:** `searchIssuesByContent`  
**Endpoint:** `/issues/search`  
**Método HTTP:** `GET`  
**Descripción:** Busca incidencias que contengan una palabra clave específica en su contenido (búsqueda insensible a mayúsculas/minúsculas).

**Parámetros de entrada:**
`/issues/search?q=Lab`

**Respuesta:**

```json
[
  {
    "iIdIssues": 2,
    "tDate": "2024-04-01T20:00:00.000Z",
    "sIssueContent": "Disruptive behavior during Lab 201 session",
    "eStatus": "REVIEWED"
  },
  {
    "iIdIssues": 3,
    "tDate": "2025-04-15T17:15:00.000Z",
    "sIssueContent": "Internet connection unstable in Lab 201",
    "eStatus": "FOR_REVIEW"
  },
  {
    "iIdIssues": 5,
    "tDate": "2025-03-20T22:30:00.000Z",
    "sIssueContent": "Broken chair in Lab 201, potential safety hazard",
    "eStatus": "RESOLVED"
  },
  {
    "iIdIssues": 10,
    "tDate": "2025-03-18T17:30:00.000Z",
    "sIssueContent": "Computers in Lab 201 running very slowly, affecting productivity",
    "eStatus": "FOR_REVIEW"
  },
  {
    "iIdIssues": 13,
    "tDate": "2025-03-22T18:00:00.000Z",
    "sIssueContent": "Unauthorized person found in Lab 201 after hours",
    "eStatus": "REVIEWED"
  },
  {
    "iIdIssues": 15,
    "tDate": "2025-04-14T19:45:00.000Z",
    "sIssueContent": "Suspicious activity near emergency exit in Lab 201",
    "eStatus": "FOR_REVIEW"
  }
]
```

### Actualizaciones Individuales

#### 7. Actualizar Estado de Incidencia

**Procedimiento Almacenado:** `updateIssueStatusById`  
**Endpoint:** `/issues/:id/status`  
**Método HTTP:** `PATCH`  
**Descripción:** Actualiza el estado de una incidencia específica identificada por su ID.

**Parámetros de entrada:**
`/issues/1/status`

```json
{
  "eStatus": "RESOLVED"
}
```

**Respuesta:**

```json
{
  "Incidencia actualizada correctamente": 1
}
```

#### 8. Actualizar Contenido de Incidencia

**Procedimiento Almacenado:** `updateIssueContentById`  
**Endpoint:** `/issues/:id/content`  
**Método HTTP:** `PATCH`  
**Descripción:** Actualiza el contenido de una incidencia específica identificada por su ID.

**Parámetros de entrada:**
`/issues/1/content`

```json
{
  "sIssueContent": ""
}
```

**Respuesta:**

```json
{
  "Incidencia actualizada correctamente": 1
}
```

### Operaciones Masivas

#### 9. Actualizar Incidencias Antiguas en Revisión a Canceladas

**Procedimiento Almacenado:** `updateOldForReviewIssuesToCancelled`  
**Endpoint:** `/issues/bulk/old-for-review-to-cancelled`  
**Método HTTP:** `PATCH`  
**Descripción:** Actualiza masivamente todas las incidencias con estado "FOR_REVIEW" que tienen más de 365 días de antigüedad, cambiándolas a estado "CANCELLED".

**Parámetros de entrada:**
N/A

**Respuesta:**

```json
{
  "Incidencias actualizadas correctamente": 3
}
```

#### 10. Eliminar Incidencias Canceladas

**Procedimiento Almacenado:** `deleteCancelledIssues`  
**Endpoint:** `/issues/bulk/cancelled`  
**Método HTTP:** `DELETE`  
**Descripción:** Elimina lógicamente todas las incidencias con estado "CANCELLED" (actualiza el campo bStateIssues a FALSE).

**Parámetros de entrada:**
N/A

**Respuesta:**

```json
{
  "Incidencias eliminadas correctamente": 2
}
```

## Códigos de Estado HTTP

- `200` - Operación exitosa
- `400` - Solicitud incorrecta (formato de fecha inválido, palabra clave no válida)
- `404` - No se encontraron incidencias
