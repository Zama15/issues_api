/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19-12.0.2-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: issues
-- ------------------------------------------------------
-- Server version	12.0.2-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*M!100616 SET @OLD_NOTE_VERBOSITY=@@NOTE_VERBOSITY, NOTE_VERBOSITY=0 */;

--
-- Table structure for table `Careers`
--

DROP TABLE IF EXISTS `Careers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Careers` (
  `iIdCareers` int(11) NOT NULL AUTO_INCREMENT,
  `sNameCareers` varchar(191) NOT NULL,
  `bStateCareers` tinyint(1) NOT NULL DEFAULT 0,
  `dtCreatedAtCareers` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `dtUpdatedAtCareers` datetime(3) NOT NULL,
  `fkIdCareerCoord` int(11) NOT NULL,
  `fkIdFaculties` int(11) NOT NULL,
  PRIMARY KEY (`iIdCareers`),
  KEY `Careers_fkIdCareerCoord_fkey` (`fkIdCareerCoord`),
  KEY `Careers_fkIdFaculties_fkey` (`fkIdFaculties`),
  CONSTRAINT `Careers_fkIdCareerCoord_fkey` FOREIGN KEY (`fkIdCareerCoord`) REFERENCES `Users` (`iIdUsers`) ON UPDATE CASCADE,
  CONSTRAINT `Careers_fkIdFaculties_fkey` FOREIGN KEY (`fkIdFaculties`) REFERENCES `Faculties` (`iIdFaculties`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Classroom_Types`
--

DROP TABLE IF EXISTS `Classroom_Types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Classroom_Types` (
  `iIdClassroomTypes` int(11) NOT NULL AUTO_INCREMENT,
  `sNameClassroomTypes` varchar(191) NOT NULL,
  `bStateClassroomTypes` tinyint(1) NOT NULL DEFAULT 0,
  `dtCreatedAtClassroomTypes` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `dtUpdatedAtClassroomTypes` datetime(3) NOT NULL,
  PRIMARY KEY (`iIdClassroomTypes`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Classrooms`
--

DROP TABLE IF EXISTS `Classrooms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Classrooms` (
  `iIdClassrooms` int(11) NOT NULL AUTO_INCREMENT,
  `sNameClassrooms` varchar(191) NOT NULL,
  `bStateClassrooms` tinyint(1) NOT NULL DEFAULT 0,
  `dtCreatedAtClassrooms` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `dtUpdatedAtClassrooms` datetime(3) NOT NULL,
  `fkIdClassroomTypes` int(11) NOT NULL,
  `fkIdGrades` int(11) NOT NULL,
  `fkIdGroups` int(11) NOT NULL,
  PRIMARY KEY (`iIdClassrooms`),
  UNIQUE KEY `Classrooms_fkIdGroups_key` (`fkIdGroups`),
  KEY `Classrooms_fkIdClassroomTypes_fkey` (`fkIdClassroomTypes`),
  KEY `Classrooms_fkIdGrades_fkey` (`fkIdGrades`),
  CONSTRAINT `Classrooms_fkIdClassroomTypes_fkey` FOREIGN KEY (`fkIdClassroomTypes`) REFERENCES `Classroom_Types` (`iIdClassroomTypes`) ON UPDATE CASCADE,
  CONSTRAINT `Classrooms_fkIdGrades_fkey` FOREIGN KEY (`fkIdGrades`) REFERENCES `Grades` (`iIdGrades`) ON UPDATE CASCADE,
  CONSTRAINT `Classrooms_fkIdGroups_fkey` FOREIGN KEY (`fkIdGroups`) REFERENCES `Groups` (`iIdGroups`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Course_Assignments`
--

DROP TABLE IF EXISTS `Course_Assignments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Course_Assignments` (
  `iIdCourseAssignments` int(11) NOT NULL AUTO_INCREMENT,
  `iCourseTotalHours` int(11) NOT NULL,
  `bStateCourses` tinyint(1) NOT NULL DEFAULT 0,
  `dtCreatedAtCourses` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `dtUpdatedAtCourses` datetime(3) NOT NULL,
  `fkIdCourses` int(11) NOT NULL,
  `fkIdProfessor` int(11) NOT NULL,
  PRIMARY KEY (`iIdCourseAssignments`),
  KEY `Course_Assignments_fkIdCourses_fkey` (`fkIdCourses`),
  KEY `Course_Assignments_fkIdProfessor_fkey` (`fkIdProfessor`),
  CONSTRAINT `Course_Assignments_fkIdCourses_fkey` FOREIGN KEY (`fkIdCourses`) REFERENCES `Courses` (`iIdCourses`) ON UPDATE CASCADE,
  CONSTRAINT `Course_Assignments_fkIdProfessor_fkey` FOREIGN KEY (`fkIdProfessor`) REFERENCES `Users` (`iIdUsers`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Courses`
--

DROP TABLE IF EXISTS `Courses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Courses` (
  `iIdCourses` int(11) NOT NULL AUTO_INCREMENT,
  `sNameCourses` varchar(191) NOT NULL,
  `bStateCourses` tinyint(1) NOT NULL DEFAULT 0,
  `dtCreatedAtCourses` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `dtUpdatedAtCourses` datetime(3) NOT NULL,
  PRIMARY KEY (`iIdCourses`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Cycles`
--

DROP TABLE IF EXISTS `Cycles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Cycles` (
  `iIdCycles` int(11) NOT NULL AUTO_INCREMENT,
  `sNameCycles` varchar(191) NOT NULL,
  `bStateCycles` tinyint(1) NOT NULL DEFAULT 0,
  `dtCreatedAtCycles` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `dtUpdatedAtCycles` datetime(3) NOT NULL,
  PRIMARY KEY (`iIdCycles`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Faculties`
--

DROP TABLE IF EXISTS `Faculties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Faculties` (
  `iIdFaculties` int(11) NOT NULL AUTO_INCREMENT,
  `sNameFaculties` varchar(191) NOT NULL,
  `bStateFaculties` tinyint(1) NOT NULL DEFAULT 0,
  `dtCreatedAtFaculties` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `dtUpdatedAtFaculties` datetime(3) NOT NULL,
  PRIMARY KEY (`iIdFaculties`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Grades`
--

DROP TABLE IF EXISTS `Grades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Grades` (
  `iIdGrades` int(11) NOT NULL AUTO_INCREMENT,
  `sNameGrades` varchar(191) NOT NULL,
  `bStateGrades` tinyint(1) NOT NULL DEFAULT 0,
  `dtCreatedAtGrades` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `dtUpdatedAtGrades` datetime(3) NOT NULL,
  `fkIdGroups` int(11) NOT NULL,
  PRIMARY KEY (`iIdGrades`),
  KEY `Grades_fkIdGroups_fkey` (`fkIdGroups`),
  CONSTRAINT `Grades_fkIdGroups_fkey` FOREIGN KEY (`fkIdGroups`) REFERENCES `Groups` (`iIdGroups`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Groups`
--

DROP TABLE IF EXISTS `Groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Groups` (
  `iIdGroups` int(11) NOT NULL AUTO_INCREMENT,
  `sNameGroups` varchar(191) NOT NULL,
  `bStateGroups` tinyint(1) NOT NULL DEFAULT 0,
  `dtCreatedAtGroups` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `dtUpdatedAtGroups` datetime(3) NOT NULL,
  `fkIdCareers` int(11) NOT NULL,
  `fkIdTutor` int(11) NOT NULL,
  PRIMARY KEY (`iIdGroups`),
  KEY `Groups_fkIdCareers_fkey` (`fkIdCareers`),
  KEY `Groups_fkIdTutor_fkey` (`fkIdTutor`),
  CONSTRAINT `Groups_fkIdCareers_fkey` FOREIGN KEY (`fkIdCareers`) REFERENCES `Careers` (`iIdCareers`) ON UPDATE CASCADE,
  CONSTRAINT `Groups_fkIdTutor_fkey` FOREIGN KEY (`fkIdTutor`) REFERENCES `Users` (`iIdUsers`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Issue_Affected`
--

DROP TABLE IF EXISTS `Issue_Affected`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Issue_Affected` (
  `fkIdIssues` int(11) NOT NULL,
  `fkIdUsers` int(11) NOT NULL,
  PRIMARY KEY (`fkIdIssues`,`fkIdUsers`),
  KEY `Issue_Affected_fkIdUsers_fkey` (`fkIdUsers`),
  CONSTRAINT `Issue_Affected_fkIdIssues_fkey` FOREIGN KEY (`fkIdIssues`) REFERENCES `Issues` (`iIdIssues`) ON UPDATE CASCADE,
  CONSTRAINT `Issue_Affected_fkIdUsers_fkey` FOREIGN KEY (`fkIdUsers`) REFERENCES `Users` (`iIdUsers`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Issue_Culprits`
--

DROP TABLE IF EXISTS `Issue_Culprits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Issue_Culprits` (
  `fkIdIssues` int(11) NOT NULL,
  `fkIdUsers` int(11) NOT NULL,
  PRIMARY KEY (`fkIdIssues`,`fkIdUsers`),
  KEY `Issue_Culprits_fkIdUsers_fkey` (`fkIdUsers`),
  CONSTRAINT `Issue_Culprits_fkIdIssues_fkey` FOREIGN KEY (`fkIdIssues`) REFERENCES `Issues` (`iIdIssues`) ON UPDATE CASCADE,
  CONSTRAINT `Issue_Culprits_fkIdUsers_fkey` FOREIGN KEY (`fkIdUsers`) REFERENCES `Users` (`iIdUsers`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Issue_Types`
--

DROP TABLE IF EXISTS `Issue_Types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Issue_Types` (
  `iIdIssuesTypes` int(11) NOT NULL AUTO_INCREMENT,
  `sNameIssuesTypes` varchar(191) NOT NULL,
  `sDescriptionIssuesTypes` varchar(191) NOT NULL,
  `bStateIssuesTypes` tinyint(1) NOT NULL DEFAULT 0,
  `dtCreatedAtIssuesTypes` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `dtUpdatedAtIssuesTypes` datetime(3) NOT NULL,
  PRIMARY KEY (`iIdIssuesTypes`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Issues`
--

DROP TABLE IF EXISTS `Issues`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Issues` (
  `iIdIssues` int(11) NOT NULL AUTO_INCREMENT,
  `tDate` datetime(3) NOT NULL,
  `sIssueContent` varchar(191) NOT NULL,
  `eStatus` enum('FOR_REVIEW','REVIEWED','CANCELLED') NOT NULL,
  `bStateIssues` tinyint(1) NOT NULL DEFAULT 0,
  `dtCreatedAtIssues` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `dtUpdatedAtIssues` datetime(3) NOT NULL,
  `fkIdIssueTypes` int(11) NOT NULL,
  `fkIdSeverities` int(11) NOT NULL,
  `fkIdClassrooms` int(11) NOT NULL,
  `fkIdUserRegister` int(11) NOT NULL,
  `fkIdUserReviewer` int(11) NOT NULL,
  PRIMARY KEY (`iIdIssues`),
  KEY `Issues_fkIdIssueTypes_fkey` (`fkIdIssueTypes`),
  KEY `Issues_fkIdSeverities_fkey` (`fkIdSeverities`),
  KEY `Issues_fkIdClassrooms_fkey` (`fkIdClassrooms`),
  KEY `Issues_fkIdUserRegister_fkey` (`fkIdUserRegister`),
  KEY `Issues_fkIdUserReviewer_fkey` (`fkIdUserReviewer`),
  CONSTRAINT `Issues_fkIdClassrooms_fkey` FOREIGN KEY (`fkIdClassrooms`) REFERENCES `Classrooms` (`iIdClassrooms`) ON UPDATE CASCADE,
  CONSTRAINT `Issues_fkIdIssueTypes_fkey` FOREIGN KEY (`fkIdIssueTypes`) REFERENCES `Issue_Types` (`iIdIssuesTypes`) ON UPDATE CASCADE,
  CONSTRAINT `Issues_fkIdSeverities_fkey` FOREIGN KEY (`fkIdSeverities`) REFERENCES `Severities` (`iIdSeverities`) ON UPDATE CASCADE,
  CONSTRAINT `Issues_fkIdUserRegister_fkey` FOREIGN KEY (`fkIdUserRegister`) REFERENCES `Users` (`iIdUsers`) ON UPDATE CASCADE,
  CONSTRAINT `Issues_fkIdUserReviewer_fkey` FOREIGN KEY (`fkIdUserReviewer`) REFERENCES `Users` (`iIdUsers`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Schedules`
--

DROP TABLE IF EXISTS `Schedules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Schedules` (
  `iIdSchedules` int(11) NOT NULL AUTO_INCREMENT,
  `dtStartCourses` datetime(3) NOT NULL,
  `dtEndCourses` datetime(3) NOT NULL,
  `fkIdCycles` int(11) NOT NULL,
  `fkIdClassrooms` int(11) NOT NULL,
  `fkIdCourseAssignments` int(11) NOT NULL,
  PRIMARY KEY (`iIdSchedules`),
  KEY `Schedules_fkIdCycles_fkey` (`fkIdCycles`),
  KEY `Schedules_fkIdClassrooms_fkey` (`fkIdClassrooms`),
  KEY `Schedules_fkIdCourseAssignments_fkey` (`fkIdCourseAssignments`),
  CONSTRAINT `Schedules_fkIdClassrooms_fkey` FOREIGN KEY (`fkIdClassrooms`) REFERENCES `Classrooms` (`iIdClassrooms`) ON UPDATE CASCADE,
  CONSTRAINT `Schedules_fkIdCourseAssignments_fkey` FOREIGN KEY (`fkIdCourseAssignments`) REFERENCES `Course_Assignments` (`iIdCourseAssignments`) ON UPDATE CASCADE,
  CONSTRAINT `Schedules_fkIdCycles_fkey` FOREIGN KEY (`fkIdCycles`) REFERENCES `Cycles` (`iIdCycles`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Severities`
--

DROP TABLE IF EXISTS `Severities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Severities` (
  `iIdSeverities` int(11) NOT NULL AUTO_INCREMENT,
  `sNameSeverities` varchar(191) NOT NULL,
  `bStateSeverities` tinyint(1) NOT NULL DEFAULT 0,
  `dtCreatedAtSeverities` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `dtUpdatedAtSeverities` datetime(3) NOT NULL,
  PRIMARY KEY (`iIdSeverities`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `User_Types`
--

DROP TABLE IF EXISTS `User_Types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `User_Types` (
  `iIdUserTypes` int(11) NOT NULL AUTO_INCREMENT,
  `sNameUserTypes` varchar(191) NOT NULL,
  `bStateUserTypes` tinyint(1) NOT NULL DEFAULT 0,
  `dtCreatedAtUserTypes` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `dtUpdatedAtUserTypes` datetime(3) NOT NULL,
  PRIMARY KEY (`iIdUserTypes`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Users`
--

DROP TABLE IF EXISTS `Users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Users` (
  `iIdUsers` int(11) NOT NULL AUTO_INCREMENT,
  `sFullNameUsers` varchar(191) NOT NULL,
  `iEnrollmentUsers` int(11) NOT NULL,
  `sPasswordUser` varchar(191) NOT NULL,
  `sGender` varchar(191) NOT NULL,
  `sInstitutionalEmail` varchar(191) NOT NULL,
  `sPhone` varchar(191) NOT NULL,
  `sLocation` varchar(191) NOT NULL,
  `bStateUsers` tinyint(1) NOT NULL DEFAULT 0,
  `dtCreatedAtUsers` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `dtUpdatedAtUsers` datetime(3) NOT NULL,
  `fkIdUserTypes` int(11) DEFAULT NULL,
  PRIMARY KEY (`iIdUsers`),
  KEY `Users_fkIdUserTypes_fkey` (`fkIdUserTypes`),
  CONSTRAINT `Users_fkIdUserTypes_fkey` FOREIGN KEY (`fkIdUserTypes`) REFERENCES `User_Types` (`iIdUserTypes`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*M!100616 SET NOTE_VERBOSITY=@OLD_NOTE_VERBOSITY */;

-- Dump completed on 2025-09-05 22:52:16
