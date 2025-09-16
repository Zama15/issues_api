/**
 * ISSUES STORED PROCEDURES
 * - countIssuesByIdIssueTypes: Count all issues with a specific IdIssueTypes
 *   - The Argument is `IdIssueTypes` counted
 * - countIssuesWithoutContent: Count all issues with No/Null sContent
 * - getIssuesAfterDate: Get all issues after a date by date
 * - getIssueWithMaxContent: Get the Issue with the largest sContent
 * - getIssuesOrderByDate: Get all the issues order by tDate
 * - searchIssuesByContent: Search a keyword on sContent
 *   - The search is insensitive
 *   - The keyword can be anywhere in the text (even inside other word)
 * - updateIssueStatusById: Update a Issue status by iIdIssue
 * - updateIssueContentById: Update a Issue content by iIdIssue
 * - updateOldForReviewIssuesToCancelled: Update all old issues with a FOR_REVIEW eStatus
 *   - Compares NOW - `tDate` equal to 365 (a year)
 *   - PATCH all issues `eStatus` = FOR_REVIEW to CANCELLED
 * - deleteCancelledIssues: Delete all Issues with a CANCELLED eStatus
 *   - Internally a PATCH is made
 *   - Update `bStateUsers` to FALSE
 */

-- ================ COUNT ISSUE BY ISSUE_TYPE ID ================
DROP PROCEDURE IF EXISTS countIssuesByIdIssueTypes;
DELIMITER $$
CREATE PROCEDURE countIssuesByIdIssueTypes(IN pIdIssueTypes INT)
BEGIN
	SELECT
	  it.iIdIssuesTypes,
	  it.sNameIssuesTypes,
	  COUNT(i.fkIdIssueTypes) as "issuesCounted"
    FROM Issues i
    LEFT JOIN Issue_Types it
    ON i.fkIdIssueTypes = it.iIdIssuesTypes
    WHERE
      i.fkIdIssueTypes = pIdIssueTypes;
END $$
DELIMITER ;
CALL countIssuesByIdIssueTypes(1);
-- ================ UPDATE ISSUE STATUS BY ID ================
DROP PROCEDURE IF EXISTS updateIssueStatusById;
DELIMITER $$
CREATE PROCEDURE updateIssueStatusById(
  IN pIdIssue INT,
  IN pStatus TEXT
)
BEGIN
  UPDATE Issues
	SET
      eStatus = pStatus,
      dtUpdatedAtIssues = NOW()
    WHERE
      iIdIssues = pIdIssue;
END $$
DELIMITER ;
SELECT * FROM Issues i ;
-- CALL updateIssueStatusById(1, "REVIEWED");
-- ================ GET ALL ISSUES AFTER DATE ================
DROP PROCEDURE IF EXISTS getIssuesAfterDate;
DELIMITER $$
CREATE PROCEDURE getIssuesAfterDate(
  IN pDate DATETIME
)
BEGIN
	SELECT
		i.iIdIssues,
		i.tDate,
		i.sIssueContent,
		i.eStatus,
		it.sNameIssuesTypes,
		s.sNameSeverities,
		c.sNameClassrooms,
		urt.sFullNameUsers as "userRegister",
		urv.sFullNameUsers as "userReviewer"
	FROM Issues i
	LEFT JOIN Issue_Types it
		ON i.fkIdIssueTypes = it.iIdIssuesTypes
	LEFT JOIN Severities s
		ON i.fkIdIssueTypes = s.iIdSeverities
	LEFT JOIN Classrooms c
		ON i.fkIdClassrooms = c.iIdClassrooms
	LEFT JOIN Users urt
		ON i.fkIdUserRegister = urt.iIdUsers
	LEFT JOIN Users urv
		ON i.fkIdUserReviewer = urv.iIdUsers
	WHERE
	  i.tDate > pDate;
END $$
DELIMITER ;
CALL getIssuesAfterDate("2025-04-10 20:00:00.000");
-- ================ UPDATE ISSUE CONTENT BY ID ================
DROP PROCEDURE IF EXISTS updateIssueContentById;
DELIMITER $$
CREATE PROCEDURE updateIssueContentById(
  IN pIdIssue INT,
  IN pContent TEXT
)
BEGIN
  UPDATE Issues
	SET
      sIssueContent = pContent,
      dtUpdatedAtIssues = NOW()
    WHERE
      iIdIssues = pIdIssue;
END $$
DELIMITER ;
SELECT * FROM Issues i ;
CALL updateIssueContentById(1, NULL);
CALL updateIssueContentById(6, NULL);
CALL updateIssueContentById(9, " ");
CALL updateIssueContentById(13, "");
-- ================ COUNT ISSUES WITHOUT CONTENT ================
DROP PROCEDURE IF EXISTS countIssuesWithoutContent;
DELIMITER $$
CREATE PROCEDURE countIssuesWithoutContent()
BEGIN
	SELECT
	  COUNT(iIdIssues) as "issuesWithoutContent"
    FROM Issues i
    WHERE
    	COALESCE(sIssueContent, "") = ""
	OR
		sIssueContent = " ";
END $$
DELIMITER ;
CALL countIssuesWithoutContent();
-- ================ GET ISSUE WITH MAX CONTENT ================
DROP PROCEDURE IF EXISTS getIssueWithMaxContent;
DELIMITER $$
CREATE PROCEDURE getIssueWithMaxContent()
BEGIN
	SELECT
		iIdIssues,
		tDate,
		sIssueContent,
		eStatus
	FROM Issues i
	ORDER BY LENGTH(sIssueContent) DESC
	LIMIT 1 OFFSET 0;
END $$
DELIMITER ;
CALL getIssueWithMaxContent();
-- ================ DELETE CANCELLED ISSUES ================
DROP PROCEDURE IF EXISTS deleteCancelledIssues;
DELIMITER $$
CREATE PROCEDURE deleteCancelledIssues()
BEGIN
  UPDATE Issues
	SET
      bStateIssues = FALSE,
      dtUpdatedAtIssues = NOW()
    WHERE
      eStatus = "CANCELLED";
END $$
DELIMITER ;
SELECT * FROM Issues i ;
CALL deleteCancelledIssues();
-- ================ UPDATE OLD FOR_REVIEW ISSUES TO CANCELLED ================
DROP PROCEDURE IF EXISTS updateOldForReviewIssuesToCancelled;
DELIMITER $$
CREATE PROCEDURE updateOldForReviewIssuesToCancelled()
BEGIN
  UPDATE Issues
	SET
      eStatus = "CANCELLED",
      dtUpdatedAtIssues = NOW()
    WHERE
      eStatus = "FOR_REVIEW"
	AND
	  DATEDIFF(NOW(), tDate) >= 365;
END $$
DELIMITER ;
SELECT * FROM Issues i ;
CALL updateOldForReviewIssuesToCancelled();
SELECT * FROM Issues i ;
-- ================ GET ISSUES ORDER BY DATE DESC ================
DROP PROCEDURE IF EXISTS getIssuesOrderByDate;
DELIMITER $$
CREATE PROCEDURE getIssuesOrderByDate()
BEGIN
	SELECT
		i.iIdIssues,
		i.tDate,
		i.sIssueContent,
		i.eStatus,
		it.sNameIssuesTypes,
		s.sNameSeverities,
		c.sNameClassrooms,
		urt.sFullNameUsers as "userRegister",
		urv.sFullNameUsers as "userReviewer"
	FROM Issues i
	LEFT JOIN Issue_Types it
		ON i.fkIdIssueTypes = it.iIdIssuesTypes
	LEFT JOIN Severities s
		ON i.fkIdIssueTypes = s.iIdSeverities
	LEFT JOIN Classrooms c
		ON i.fkIdClassrooms = c.iIdClassrooms
	LEFT JOIN Users urt
		ON i.fkIdUserRegister = urt.iIdUsers
	LEFT JOIN Users urv
		ON i.fkIdUserReviewer = urv.iIdUsers
	ORDER BY i.tDate DESC;
END $$
DELIMITER ;
CALL getIssuesOrderByDate();
-- ================ GET ISSUES ORDER BY DATE DESC ================
DROP PROCEDURE IF EXISTS searchIssuesByContent;
DELIMITER $$
CREATE PROCEDURE searchIssuesByContent(IN pKeyWord TEXT)
BEGIN
	SELECT
		iIdIssues,
		tDate,
		sIssueContent,
		eStatus
	FROM Issues i
	WHERE sIssueContent LIKE CONCAT("%", pKeyWord, "%");
END $$
DELIMITER ;
CALL searchIssuesByContent("lab");



