/**
 * USERS STORED PROCEDURES
 * - getAllUsers: Get all the Users
 *   - Selected fields will be returned
 *   - `bStateUsers` = FALSE are excluded
 * - getUserById: Get a User by its id
 *   - Selected fields will be returned
 * - insertUser: Add a user
 * - updateUser: Update the record of a User by its id
 *   - `bStateUsers` can't be updated using this SP
 * - deleteUser: Delete a User by its id
 *   - Internally a PATCH is made
 *   - Update `bStateUsers` to FALSE
 */

-- ================ GET ALL ================
DROP PROCEDURE IF EXISTS getAllUsers;
DELIMITER $$
CREATE PROCEDURE getAllUsers()
BEGIN
	SELECT
      iIdUsers,
      sFullNameUsers,
      iEnrollmentUsers,
      sGender,
      sInstitutionalEmail,
      sPhone,
      sLocation
    FROM Users
	WHERE bStateUsers = TRUE;
END $$
DELIMITER ;
CALL getAllUsers();
-- ================ GET BY ID ================
DROP PROCEDURE IF EXISTS getUserById;
DELIMITER $$
CREATE PROCEDURE getUserById(IN pUserId INT)
BEGIN
	SELECT
      iIdUsers,
      sFullNameUsers,
      iEnrollmentUsers,
      sGender,
      sInstitutionalEmail,
      sPhone,
      sLocation
    FROM Users
	WHERE iIdUsers = pUserId;
END $$
DELIMITER ;
CALL getUserById(1);
-- ================ POST ================
DROP PROCEDURE IF EXISTS insertUser;
DELIMITER $$
CREATE PROCEDURE insertUser(
	IN pFullName TEXT,
	IN pEnrollment INT,
	IN pPassword TEXT,
	IN pGender TEXT,
	IN pInstitutionalEmail TEXT,
	IN pPhone TEXT,
	IN pLocation TEXT
)
BEGIN
	INSERT
      INTO Users
        (sFullNameUsers,
        iEnrollmentUsers,
        sPasswordUser,
        sGender,
        sInstitutionalEmail,
        sPhone,
        sLocation,
        dtUpdatedAtUsers)
      Values
      	(pFullName,
      	pEnrollment,
      	pPassword,
      	pGender,
      	pInstitutionalEmail,
      	pPhone,
      	pLocation,
      	NOW());
END $$
DELIMITER ;
-- CALL insertUser("dummy", 12345678, 1234, "D", "dummy@fake.com", "+1234567890", "dummy location");
-- ================ PUT ================
DROP PROCEDURE IF EXISTS updateUser;
DELIMITER $$
CREATE PROCEDURE updateUser(
	IN pIdUsers INT,
	IN pFullName TEXT,
	IN pEnrollment INT,
	IN pPassword TEXT,
	IN pGender TEXT,
	IN pInstitutionalEmail TEXT,
	IN pPhone TEXT,
	IN pLocation TEXT
)
BEGIN
	UPDATE Users
	  SET
        sFullNameUsers = pFullName,
        iEnrollmentUsers = pEnrollment,
        sPasswordUser = pPassword,
        sGender = pGender,
        sInstitutionalEmail = pInstitutionalEmail,
        sPhone = pPhone,
        sLocation = pLocation,
        dtUpdatedAtUsers = NOW()
      WHERE
        iIdUsers = pIdUsers;
END $$
DELIMITER ;
-- CALL updateUser(1, CONCAT('Alice Admin (', NOW(), ')'), 1000, "password123", "F", "alice.admin@uni.edu", "+5215550001000", "Main campus");
-- CALL getAllUsers();
-- ================ DELETE ================
DROP PROCEDURE IF EXISTS deleteUser;
DELIMITER $$
CREATE PROCEDURE deleteUser(
  IN pIdUsers INT
)
BEGIN
  UPDATE Users
	SET
      bStateUsers = FALSE,
      dtUpdatedAtUsers = NOW()
    WHERE
      iIdUsers = pIdUsers;
END $$
DELIMITER ;
-- CALL deleteUser(1);
-- CALL getAllUsers();
