/**
 * ISSUES FUNCTIONS
 * - fnEmailExist: Check if an Email exists
 *   - Find Email passed on the arguement
 *   - Return FALSE or TRUE
 * - fnCountIssuesByIdIssueTypes: Count Issues by Issue_Types ID
 *   - Return COUNT INT
 * - fnCountIssuesByForReviewStatus: Count Issues by FOR_REVIEW status
 *   - Filter issues eStatus = FOR_REVIEW
 *   - Return COUNT INT
 * - fnCountIssuesWithoutContent: Count Issues without content
 *   - sIssueContent = NULL OR sIssueContent = "" OR sIssueContent = " "
 *   - Return COUNT INT
 * - fnAverageIssuesSeverities: Average of Issues Severities
 *   - Severities is not a numeric data, so each severity was given a number and get the average based on that
 *   - Return AVG FLOAT
 * - fnAverageIssueContent: Average of Issues content length
 *   - RETURN AVG FLOAT
 * - fnLastIssueCreatedByIdUserRegister: Select the last issue created by idUserRegister
 *   - Return dtCreatedAtIssues DATETIME
 * - fnLastIssueCreated: Select the Last Issue Created
 *   - RETURN iIdIssue INT
 * - fnOldestIssueCreated: Select the Oldest Issue Created 
 *   - RETURN iIdIssue INT
 * - fnIssueWithLargestContent: Select Issue with largest length sIssueContent
 *   - RETURN iIdIssue INT
 * - fnUserWithMostIssuesRegistered: Select the most fkIdUserRegister repeated on Issues
 *   - RETURN fkIdUserRegister INT
 */

-- ================ EMAIL EXISTS => BOOL ================
DROP FUNCTION IF EXISTS fnEmailExist;
DELIMITER $$
CREATE FUNCTION fnEmailExist(pEmail VARCHAR(100))
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
	DECLARE vCount INT;
	SELECT COUNT(*) INTO vCount
	FROM Users
	WHERE
		sInstitutionalEmail = pEmail;
	RETURN vCount > 0;
END $$
DELIMITER ;
SELECT fnEmailExist("alice.admin@uni.edu");
-- ================ COUNT ISSUE BY ISSUE_TYPE ID => INT ================
DROP FUNCTION IF EXISTS fnCountIssuesByIdIssueTypes;
DELIMITER $$
CREATE FUNCTION fnCountIssuesByIdIssueTypes(pIdIssueTypes INT)
RETURNS INT
NOT DETERMINISTIC
BEGIN
	DECLARE vCount INT;
	SELECT
	  COUNT(i.fkIdIssueTypes) INTO vCount
    FROM Issues i
    LEFT JOIN Issue_Types it
    ON i.fkIdIssueTypes = it.iIdIssuesTypes
    WHERE
      i.fkIdIssueTypes = pIdIssueTypes;
	RETURN vCount;
END $$
DELIMITER ;
SELECT fnCountIssuesByIdIssueTypes(2);
-- ================ LAST ISSUE CREATED BY USER REGISTER => DATETIME ================
DROP FUNCTION IF EXISTS fnLastIssueCreatedByIdUserRegister;
DELIMITER $$
CREATE FUNCTION fnLastIssueCreatedByIdUserRegister(pIdUser INT)
RETURNS DATETIME
NOT DETERMINISTIC
BEGIN
	DECLARE vLastCreated DATETIME;
	SELECT
		i.dtCreatedAtIssues INTO vLastCreated
	FROM Issues i
	WHERE
		i.fkIdUserRegister = pIdUser
	ORDER BY i.dtCreatedAtIssues  DESC
	LIMIT 1 OFFSET 0;
	RETURN vLastCreated;
END $$
DELIMITER ;
SELECT fnLastIssueCreatedByIdUserRegister(1);
-- ================ COUNT ISSUES BY FOR_REVIEW STATUS => INT ================
DROP FUNCTION IF EXISTS fnCountIssuesByForReviewStatus;
DELIMITER $$
CREATE FUNCTION fnCountIssuesByForReviewStatus()
RETURNS INT
NOT DETERMINISTIC
BEGIN
	DECLARE vCount INT;
	SELECT
		COUNT(i.iIdIssues) INTO vCount
	FROM Issues i
	WHERE
		i.eStatus = "FOR_REVIEW";
	RETURN vCount;
END $$
DELIMITER ;
SELECT fnCountIssuesByForReviewStatus();
-- ================ AVERAGE ISSUES SEVERITIES => FLOAT ================
DROP FUNCTION IF EXISTS fnAverageIssuesSeverities;
DELIMITER $$
CREATE FUNCTION fnAverageIssuesSeverities()
RETURNS FLOAT
NOT DETERMINISTIC
BEGIN
	DECLARE vAverage FLOAT;
	SELECT
		AVG(
			CASE s.sNameSeverities
				WHEN "LOW" THEN 1
				WHEN "HIGH" THEN 2
				WHEN "MEDIUM" THEN 3
				WHEN "CRITICAL" THEN 4
			END
		) INTO vAverage
	FROM Issues i
	INNER JOIN Severities s 
	ON i.fkIdSeverities = s.iIdSeverities;
	RETURN vAverage;
END $$
DELIMITER ;
SELECT fnAverageIssuesSeverities();
-- ================ LAST ISSUE CREATED => INT ================
DROP FUNCTION IF EXISTS fnLastIssueCreated;
DELIMITER $$
CREATE FUNCTION fnLastIssueCreated()
RETURNS INT
NOT DETERMINISTIC
BEGIN
	DECLARE vLastCreated INT;
	SELECT
		i.iIdIssues INTO vLastCreated
	FROM Issues i
	ORDER BY i.dtCreatedAtIssues  DESC
	LIMIT 1 OFFSET 0;
	RETURN vLastCreated;
END $$
DELIMITER ;
SELECT fnLastIssueCreated();
-- ================ OLDEST ISSUE CREATED => INT ================
DROP FUNCTION IF EXISTS fnOldestIssueCreated;
DELIMITER $$
CREATE FUNCTION fnOldestIssueCreated()
RETURNS INT
NOT DETERMINISTIC
BEGIN
	DECLARE vOldestCreated INT;
	SELECT
		i.iIdIssues INTO vOldestCreated
	FROM Issues i
	ORDER BY i.dtCreatedAtIssues  ASC
	LIMIT 1 OFFSET 0;
	RETURN vOldestCreated;
END $$
DELIMITER ;
SELECT fnOldestIssueCreated();
-- ================ USER WITH MOST ISSUES REGISTERED => INT ================
DROP FUNCTION IF EXISTS fnUserWithMostIssuesRegistered;
DELIMITER $$
CREATE FUNCTION fnUserWithMostIssuesRegistered()
RETURNS INT
NOT DETERMINISTIC
BEGIN
	DECLARE vUserMostRepeated INT;
	SELECT
		i.fkIdUserRegister INTO vUserMostRepeated
	FROM Issues i
	GROUP BY i.fkIdUserRegister
	ORDER BY COUNT(i.iIdIssues) DESC
	LIMIT 1 OFFSET 0;
	RETURN vUserMostRepeated;
END $$
DELIMITER ;
SELECT fnUserWithMostIssuesRegistered();
-- ================ AVERAGE ISSUE CONTENT LENGTH => FLOAT ================
DROP FUNCTION IF EXISTS fnAverageIssueContent;
DELIMITER $$
CREATE FUNCTION fnAverageIssueContent()
RETURNS FLOAT
NOT DETERMINISTIC
BEGIN
	DECLARE vAverage FLOAT;
	SELECT
		AVG(LENGTH(i.sIssueContent)) INTO vAverage
	FROM Issues i;
	RETURN vAverage;
END $$
DELIMITER ;
SELECT fnAverageIssueContent();
-- ================ COUNT ISSUE WITHOUT CONTENT => INT ================
DROP FUNCTION IF EXISTS fnCountIssuesWithoutContent;
DELIMITER $$
CREATE FUNCTION fnCountIssuesWithoutContent()
RETURNS INT
NOT DETERMINISTIC
BEGIN
	DECLARE vCount INT;
	SELECT
	  COUNT(i.iIdIssues) INTO vCount
    FROM Issues i
    WHERE
    	COALESCE(i.sIssueContent, "") = ""
	OR
		i.sIssueContent = " ";
	RETURN vCount;
END $$
DELIMITER ;
SELECT fnCountIssuesWithoutContent();
-- ================ ISSUE WITH LARGEST CONTENT => INT ================
DROP FUNCTION IF EXISTS fnIssueWithLargestContent;
DELIMITER $$
CREATE FUNCTION fnIssueWithLargestContent()
RETURNS INT
NOT DETERMINISTIC
BEGIN
	DECLARE vIssueLargestContent INT;
	SELECT
		i.iIdIssues INTO vIssueLargestContent
	FROM Issues i
	ORDER BY LENGTH(i.sIssueContent) DESC
	LIMIT 1 OFFSET 0;
	RETURN vIssueLargestContent;
END $$
DELIMITER ;
SELECT fnIssueWithLargestContent();
