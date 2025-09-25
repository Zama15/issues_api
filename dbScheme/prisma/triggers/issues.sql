-- ========== BEFORE | INSERT | USER | CHECK EMAIL DOMAIN ========== 
DROP TRIGGER IF EXISTS trgBeforeInsertUsers_checkEmailsDomain;
DELIMITER $$
CREATE TRIGGER trgBeforeInsertUsers_checkEmailsDomain
BEFORE INSERT ON Users
FOR EACH ROW
BEGIN
	IF NEW.sInstitutionalEmail NOT LIKE "%@ucol.mx" THEN
		SIGNAL SQLSTATE "45000"
		SET MESSAGE_TEXT = "The institutional must end with '@ucol.mx'";
	END IF;
END $$
DELIMITER ;
-- ========== BEFORE | INSERT | ISSUES | SET CREATED_AT IF NULL ==========
DROP TRIGGER IF EXISTS trgBeforeInsertIssues_setCreatedAtIfNull;
DELIMITER $$
CREATE TRIGGER trgBeforeInsertIssues_setCreatedAtIfNull
BEFORE INSERT ON Issues
FOR EACH ROW
BEGIN
	IF NEW.dtCreatedAtIssues IS NULL THEN
		SET NEW.dtCreatedAtIssues = NOW();
	END IF;
END $$
DELIMITER ;
-- ========== BEFORE | UPDATE | ISSUES | SET UPDATED_AT ==========
DROP TRIGGER IF EXISTS trgBeforeUpdateIssues_setUpdatedAt;
DELIMITER $$
CREATE TRIGGER trgBeforeUpdateIssues_setUpdatedAt
BEFORE UPDATE ON Issues
FOR EACH ROW
BEGIN
	SET NEW.dtUpdatedAtIssues = NOW();
END $$
DELIMITER ;
-- ========== AFTER | INSERT | ISSUES | INSERT HISTORY_LOG RECORD ==========
DROP TRIGGER IF EXISTS trgAfterInsertIssues_insertHistoryLog;
DELIMITER $$
CREATE TRIGGER trgAfterInsertIssues_insertHistoryLog
AFTER INSERT ON Issues
FOR EACH ROW
BEGIN
	INSERT
	INTO History_Logs
      	(sTableName,
     	iRecordId,
      	eActionType,
      	tDetails)
	VALUES
		("Issues",
		NEW.iIdIssues,
		"CREATE",
		JSON_OBJECT(
            'fkIdUserRegister', NEW.fkIdUserRegister,
            'fkIdUserReviewer', NEW.fkIdUserReviewer,
            'sIssueContent', NEW.sIssueContent,
            'eStatus', NEW.eStatus,
            'tDate', NEW.tDate));
END $$
DELIMITER ;
-- ========== AFTER | UPDATE | ISSUES | INSERT HISTORY_LOG RECORD ==========
DROP TRIGGER IF EXISTS trgAfterUpdateIssues_insertHistoryLog;
DELIMITER $$
CREATE TRIGGER trgAfterUpdateIssues_insertHistoryLog
AFTER UPDATE ON Issues
FOR EACH ROW
BEGIN
    IF OLD.eStatus != NEW.eStatus OR 
       OLD.sIssueContent != NEW.sIssueContent OR 
       OLD.fkIdUserReviewer != NEW.fkIdUserReviewer OR
       OLD.fkIdSeverities != NEW.fkIdSeverities OR
       OLD.fkIdIssueTypes != NEW.fkIdIssueTypes OR
       OLD.tDate != NEW.tDate 
    THEN
        INSERT
        INTO History_Logs
        	(fkIdUser,
            sTableName,
            iRecordId,
            eActionType,
            tDetails)
        VALUES
        	('Issues',
            NEW.iIdIssues,
            'UPDATE',
            JSON_OBJECT(
                'status_old', OLD.eStatus,
                'status_new', NEW.eStatus,
                'content_old', OLD.sIssueContent,
                'content_new', NEW.sIssueContent,
                'reviewer_old', OLD.fkIdUserReviewer,
                'reviewer_new', NEW.fkIdUserReviewer,
                'severity_old', OLD.fkIdSeverities,
                'severity_new', NEW.fkIdSeverities,
                'issueType_old', OLD.fkIdIssueTypes,
                'issueType_new', NEW.fkIdIssueTypes,
                'date_old', OLD.tDate,
                'date_new', NEW.tDate));
    END IF;
END $$
DELIMITER ;
-- ========== BEFORE | DELETE | ISSUES | BLOCK IF STATUS IS RESOLVED ==========
DROP TRIGGER IF EXISTS trgBeforeDeleteIssues_BlockClosed;
DELIMITER $$
CREATE TRIGGER trgBeforeDeleteIssues_BlockResolved
BEFORE DELETE ON Issues
FOR EACH ROW
BEGIN
    IF OLD.eStatus = 'RESOLVED' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot delete an issue that status is RESOLVED.';
    END IF;
END $$
DELIMITER ;
-- ========== BEFORE | DELETE | ISSUES | BACKUP ==========
DROP TRIGGER IF EXISTS trgBeforeDeleteIssues_Backup;
DELIMITER $$
CREATE TRIGGER trgBeforeDeleteIssues_Backup
BEFORE DELETE ON Issues
FOR EACH ROW
BEGIN
    INSERT INTO Issues_Backup (
        iIdOriginalIssue,
        tDate,
        sIssueContent,
        eStatus,
        fkIdIssueTypes,
        fkIdSeverities,
        fkIdClassrooms,
        fkIdUserRegister,
        fkIdUserReviewer
    )
    VALUES (
        OLD.iIdIssues,
        OLD.tDate,
        OLD.sIssueContent,
        OLD.eStatus,
        OLD.fkIdIssueTypes,
        OLD.fkIdSeverities,
        OLD.fkIdClassrooms,
        OLD.fkIdUserRegister,
        OLD.fkIdUserReviewer
    );
END $$
DELIMITER ;
-- ========== BEFORE | INSERT | ISSUES | BACKUP ==========
DROP TRIGGER IF EXISTS trgBeforeInsertIssues_ValidateSeverity;
DELIMITER $$
CREATE TRIGGER trgBeforeInsertIssues_ValidateSeverity
BEFORE INSERT ON Issues
FOR EACH ROW
BEGIN
    DECLARE minSeverityId INT DEFAULT 1;
    IF NEW.fkIdSeverities < minSeverityId THEN
        SET NEW.fkIdSeverities = minSeverityId;
    END IF;
END $$
DELIMITER ;
-- ========== BEFORE | DELETE | ISSUES_CULPRITS | INCREMENT USER ISSUES REPORTED COUNT ==========
DROP TRIGGER IF EXISTS trgAfterInsertIssuesCulprits_IncrementUserIssuesReportedCount;
DELIMITER $$
CREATE TRIGGER trgAfterInsertIssues_IncrementUserIssuesReportedCount
AFTER INSERT ON Issue_Culprits
FOR EACH ROW
BEGIN
    UPDATE Users
    SET iIssuesCulpritCount = iIssuesCulpritCount + 1
    WHERE iIdUsers = NEW.fkIdUsers;
END $$
DELIMITER ;
