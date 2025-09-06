DROP PROCEDURE IF EXISTS get_incidences_by_classroom;
DELIMITER $$
CREATE PROCEDURE get_incidences_by_classroom()
BEGIN
  SELECT 
    c.classroom_id,
    COUNT(r.report_id) AS total_incidences
  FROM Classroom c
  LEFT JOIN Reports r ON r.classroomId = c.classroom_id
  GROUP BY c.classroom_id
  ORDER BY total_incidences DESC;
END $$
DELIMITER ;
-- call as: CALL get_incidences_by_classroom();

DROP PROCEDURE IF EXISTS get_severe_incidences_by_alumn;
DELIMITER $$
CREATE PROCEDURE get_severe_incidences_by_alumn(
  IN p_alumn_id TEXT,
  IN p_gravity INT
)
BEGIN
  SELECT 
    a.university_id,
    a.firstname,
    a.lastname,
    r.report_id,
    r.date,
    r.observations,
    r.gravity
  FROM Alumns a
  INNER JOIN Alumn_Reports ar ON a.university_id = ar.alumn_id
  INNER JOIN Reports r ON r.report_id = ar.report_id
  WHERE a.university_id = p_alumn_id
    AND r.gravity >= p_gravity
  ORDER BY r.date DESC;
END $$
DELIMITER ;
-- call as: CALL get_severe_incidences_by_alumn('ALUMN001', 3);

DROP PROCEDURE IF EXISTS get_incidence_statistics;
DELIMITER $$
CREATE PROCEDURE get_incidence_statistics()
BEGIN
  SELECT 
    i.incidence_id,
    COUNT(r.report_id) AS total_reports
  FROM Incidences i
  LEFT JOIN Reports r ON r.gravity = i.incidence_id
  GROUP BY i.incidence_id
  ORDER BY total_reports DESC;
END $$
DELIMITER ;
-- call as: CALL get_incidence_statistics();

DROP PROCEDURE IF EXISTS get_reports_with_professor;
DELIMITER $$
CREATE PROCEDURE get_reports_with_professor()
BEGIN
  SELECT 
    r.report_id,
    r.date,
    r.observations,
    p.university_id AS professor_id,
    p.firstname AS professor_firstname,
    p.lastname AS professor_lastname
  FROM Reports r
  INNER JOIN Professors p ON r.professor_recorded = p.university_id
  ORDER BY r.date DESC;
END $$
DELIMITER ;
-- call as: CALL get_reports_with_professor();
