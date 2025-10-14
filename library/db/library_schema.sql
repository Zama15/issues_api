DROP TABLE IF EXISTS `AUDIT_LOGS`;

CREATE TABLE `AUDIT_LOGS` (
  `bigint_audit_log_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `int_staff_id` int(10) unsigned DEFAULT NULL,
  `str_action` varchar(50) NOT NULL,
  `str_table_name` varchar(100) NOT NULL,
  `int_record_pk` int(10) unsigned DEFAULT NULL,
  `json_old_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`json_old_data`)),
  `json_new_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`json_new_data`)),
  `dt_timestamp` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  PRIMARY KEY (`bigint_audit_log_id`),
  KEY `AUDIT_LOGS_int_staff_id_fkey` (`int_staff_id`),
  CONSTRAINT `AUDIT_LOGS_int_staff_id_fkey` FOREIGN KEY (`int_staff_id`) REFERENCES `STAFF` (`int_staff_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `AUTHORS`;

CREATE TABLE `AUTHORS` (
  `int_author_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `str_first_name` varchar(100) NOT NULL,
  `str_last_name` varchar(100) NOT NULL,
  `dt_birth_date` date DEFAULT NULL,
  `str_biography` text DEFAULT NULL,
  `bool_is_active` tinyint(1) NOT NULL DEFAULT 1,
  `dt_created_at` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `dt_updated_at` datetime(3) NOT NULL,
  PRIMARY KEY (`int_author_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `COPY_STATUSES`;

CREATE TABLE `COPY_STATUSES` (
  `int_copy_status_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `str_name` varchar(50) NOT NULL,
  `bool_is_active` tinyint(1) NOT NULL DEFAULT 1,
  `dt_created_at` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `dt_updated_at` datetime(3) NOT NULL,
  PRIMARY KEY (`int_copy_status_id`),
  UNIQUE KEY `COPY_STATUSES_str_name_key` (`str_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `DEPARTMENTS`;

CREATE TABLE `DEPARTMENTS` (
  `int_department_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `str_name` varchar(191) NOT NULL,
  `bool_is_active` tinyint(1) NOT NULL DEFAULT 1,
  `dt_created_at` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `dt_updated_at` datetime(3) NOT NULL,
  PRIMARY KEY (`int_department_id`),
  UNIQUE KEY `DEPARTMENTS_str_name_key` (`str_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `DIGITAL_RESOURCES`;

CREATE TABLE `DIGITAL_RESOURCES` (
  `int_digital_resource_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `int_item_id` int(10) unsigned NOT NULL,
  `str_view_url` varchar(2083) DEFAULT NULL,
  `bool_is_downloadable` tinyint(1) NOT NULL DEFAULT 0,
  `str_download_url` varchar(2083) DEFAULT NULL,
  `str_file_format` varchar(10) DEFAULT NULL,
  `int_file_size_in_kb` int(10) unsigned DEFAULT NULL,
  `str_access_type` varchar(50) DEFAULT NULL,
  `bool_is_active` tinyint(1) NOT NULL DEFAULT 1,
  `dt_created_at` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `dt_updated_at` datetime(3) NOT NULL,
  PRIMARY KEY (`int_digital_resource_id`),
  KEY `DIGITAL_RESOURCES_int_item_id_fkey` (`int_item_id`),
  CONSTRAINT `DIGITAL_RESOURCES_int_item_id_fkey` FOREIGN KEY (`int_item_id`) REFERENCES `ITEMS` (`int_item_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `FINES`;

CREATE TABLE `FINES` (
  `int_fine_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `int_loan_id` int(10) unsigned NOT NULL,
  `int_patron_id` int(10) unsigned NOT NULL,
  `dec_amount` decimal(10,2) NOT NULL,
  `str_reason` varchar(191) DEFAULT NULL,
  `dt_date_issued` date NOT NULL,
  `str_status` varchar(50) NOT NULL,
  `bool_is_active` tinyint(1) NOT NULL DEFAULT 1,
  `dt_created_at` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `dt_updated_at` datetime(3) NOT NULL,
  PRIMARY KEY (`int_fine_id`),
  UNIQUE KEY `FINES_int_loan_id_key` (`int_loan_id`),
  KEY `FINES_int_patron_id_fkey` (`int_patron_id`),
  CONSTRAINT `FINES_int_loan_id_fkey` FOREIGN KEY (`int_loan_id`) REFERENCES `LOANS` (`int_loan_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FINES_int_patron_id_fkey` FOREIGN KEY (`int_patron_id`) REFERENCES `PATRONS` (`int_patron_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `ITEMS`;

CREATE TABLE `ITEMS` (
  `int_item_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `str_title` varchar(191) NOT NULL,
  `int_publisher_id` int(10) unsigned DEFAULT NULL,
  `dt_publication_date` year(4) DEFAULT NULL,
  `str_edition` varchar(50) DEFAULT NULL,
  `str_isbn` varchar(13) DEFAULT NULL,
  `str_issn` varchar(9) DEFAULT NULL,
  `str_dewey_decimal_code` varchar(20) DEFAULT NULL,
  `int_item_type_id` int(10) unsigned NOT NULL,
  `int_series_id` int(10) unsigned DEFAULT NULL,
  `int_language_id` int(10) unsigned NOT NULL,
  `str_description` text DEFAULT NULL,
  `json_table_of_contents` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`json_table_of_contents`)),
  `bool_is_active` tinyint(1) NOT NULL DEFAULT 1,
  `dt_created_at` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `dt_updated_at` datetime(3) NOT NULL,
  PRIMARY KEY (`int_item_id`),
  UNIQUE KEY `ITEMS_str_isbn_key` (`str_isbn`),
  UNIQUE KEY `ITEMS_str_issn_key` (`str_issn`),
  KEY `ITEMS_int_publisher_id_fkey` (`int_publisher_id`),
  KEY `ITEMS_int_item_type_id_fkey` (`int_item_type_id`),
  KEY `ITEMS_int_series_id_fkey` (`int_series_id`),
  KEY `ITEMS_int_language_id_fkey` (`int_language_id`),
  CONSTRAINT `ITEMS_int_item_type_id_fkey` FOREIGN KEY (`int_item_type_id`) REFERENCES `ITEM_TYPES` (`int_item_type_id`) ON UPDATE CASCADE,
  CONSTRAINT `ITEMS_int_language_id_fkey` FOREIGN KEY (`int_language_id`) REFERENCES `LANGUAGES` (`int_language_id`) ON UPDATE CASCADE,
  CONSTRAINT `ITEMS_int_publisher_id_fkey` FOREIGN KEY (`int_publisher_id`) REFERENCES `PUBLISHERS` (`int_publisher_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `ITEMS_int_series_id_fkey` FOREIGN KEY (`int_series_id`) REFERENCES `SERIES` (`int_series_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `ITEM_AUTHORS`;

CREATE TABLE `ITEM_AUTHORS` (
  `int_item_id` int(10) unsigned NOT NULL,
  `int_author_id` int(10) unsigned NOT NULL,
  `dt_created_at` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  PRIMARY KEY (`int_item_id`,`int_author_id`),
  KEY `ITEM_AUTHORS_int_author_id_fkey` (`int_author_id`),
  CONSTRAINT `ITEM_AUTHORS_int_author_id_fkey` FOREIGN KEY (`int_author_id`) REFERENCES `AUTHORS` (`int_author_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ITEM_AUTHORS_int_item_id_fkey` FOREIGN KEY (`int_item_id`) REFERENCES `ITEMS` (`int_item_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `ITEM_COPIES`;

CREATE TABLE `ITEM_COPIES` (
  `int_item_copy_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `int_item_id` int(10) unsigned NOT NULL,
  `str_barcode` varchar(50) NOT NULL,
  `int_copy_status_id` int(10) unsigned NOT NULL,
  `str_location_info` varchar(191) DEFAULT NULL,
  `dt_date_acquired` date DEFAULT NULL,
  `dec_purchase_price` decimal(10,2) DEFAULT NULL,
  `bool_is_active` tinyint(1) NOT NULL DEFAULT 1,
  `dt_created_at` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `dt_updated_at` datetime(3) NOT NULL,
  PRIMARY KEY (`int_item_copy_id`),
  UNIQUE KEY `ITEM_COPIES_str_barcode_key` (`str_barcode`),
  KEY `ITEM_COPIES_int_item_id_fkey` (`int_item_id`),
  KEY `ITEM_COPIES_int_copy_status_id_fkey` (`int_copy_status_id`),
  CONSTRAINT `ITEM_COPIES_int_copy_status_id_fkey` FOREIGN KEY (`int_copy_status_id`) REFERENCES `COPY_STATUSES` (`int_copy_status_id`) ON UPDATE CASCADE,
  CONSTRAINT `ITEM_COPIES_int_item_id_fkey` FOREIGN KEY (`int_item_id`) REFERENCES `ITEMS` (`int_item_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `ITEM_SUBJECTS`;

CREATE TABLE `ITEM_SUBJECTS` (
  `int_item_id` int(10) unsigned NOT NULL,
  `int_subject_id` int(10) unsigned NOT NULL,
  `dt_created_at` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  PRIMARY KEY (`int_item_id`,`int_subject_id`),
  KEY `ITEM_SUBJECTS_int_subject_id_fkey` (`int_subject_id`),
  CONSTRAINT `ITEM_SUBJECTS_int_item_id_fkey` FOREIGN KEY (`int_item_id`) REFERENCES `ITEMS` (`int_item_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ITEM_SUBJECTS_int_subject_id_fkey` FOREIGN KEY (`int_subject_id`) REFERENCES `SUBJECTS` (`int_subject_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `ITEM_TYPES`;

CREATE TABLE `ITEM_TYPES` (
  `int_item_type_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `str_name` varchar(100) NOT NULL,
  `bool_is_active` tinyint(1) NOT NULL DEFAULT 1,
  `dt_created_at` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `dt_updated_at` datetime(3) NOT NULL,
  PRIMARY KEY (`int_item_type_id`),
  UNIQUE KEY `ITEM_TYPES_str_name_key` (`str_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `LANGUAGES`;

CREATE TABLE `LANGUAGES` (
  `int_language_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `str_name` varchar(100) NOT NULL,
  `str_iso_code` char(3) DEFAULT NULL,
  `bool_is_active` tinyint(1) NOT NULL DEFAULT 1,
  `dt_created_at` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `dt_updated_at` datetime(3) NOT NULL,
  PRIMARY KEY (`int_language_id`),
  UNIQUE KEY `LANGUAGES_str_name_key` (`str_name`),
  UNIQUE KEY `LANGUAGES_str_iso_code_key` (`str_iso_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `LIBRARY_BRANCHES`;

CREATE TABLE `LIBRARY_BRANCHES` (
  `int_library_branch_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `str_name` varchar(191) NOT NULL,
  `str_campus_location` varchar(191) DEFAULT NULL,
  `str_address` text DEFAULT NULL,
  `bool_is_active` tinyint(1) NOT NULL DEFAULT 1,
  `dt_created_at` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `dt_updated_at` datetime(3) NOT NULL,
  PRIMARY KEY (`int_library_branch_id`),
  UNIQUE KEY `LIBRARY_BRANCHES_str_name_key` (`str_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `LOANS`;

CREATE TABLE `LOANS` (
  `int_loan_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `int_item_copy_id` int(10) unsigned NOT NULL,
  `int_patron_id` int(10) unsigned NOT NULL,
  `dt_checkout_date` datetime(3) NOT NULL,
  `dt_due_date` datetime(3) NOT NULL,
  `dt_return_date` datetime(3) DEFAULT NULL,
  `int_renewals_count` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `int_checkout_staff_id` int(10) unsigned NOT NULL,
  `int_checkin_staff_id` int(10) unsigned DEFAULT NULL,
  `bool_is_active` tinyint(1) NOT NULL DEFAULT 1,
  `dt_created_at` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `dt_updated_at` datetime(3) NOT NULL,
  PRIMARY KEY (`int_loan_id`),
  KEY `LOANS_int_item_copy_id_fkey` (`int_item_copy_id`),
  KEY `LOANS_int_patron_id_fkey` (`int_patron_id`),
  KEY `LOANS_int_checkout_staff_id_fkey` (`int_checkout_staff_id`),
  KEY `LOANS_int_checkin_staff_id_fkey` (`int_checkin_staff_id`),
  CONSTRAINT `LOANS_int_checkin_staff_id_fkey` FOREIGN KEY (`int_checkin_staff_id`) REFERENCES `STAFF` (`int_staff_id`) ON UPDATE CASCADE,
  CONSTRAINT `LOANS_int_checkout_staff_id_fkey` FOREIGN KEY (`int_checkout_staff_id`) REFERENCES `STAFF` (`int_staff_id`) ON UPDATE CASCADE,
  CONSTRAINT `LOANS_int_item_copy_id_fkey` FOREIGN KEY (`int_item_copy_id`) REFERENCES `ITEM_COPIES` (`int_item_copy_id`) ON UPDATE CASCADE,
  CONSTRAINT `LOANS_int_patron_id_fkey` FOREIGN KEY (`int_patron_id`) REFERENCES `PATRONS` (`int_patron_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `LOAN_HISTORY`;

CREATE TABLE `LOAN_HISTORY` (
  `int_loan_history_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `int_loan_id` int(10) unsigned NOT NULL,
  `int_item_copy_id` int(10) unsigned NOT NULL,
  `int_patron_id` int(10) unsigned NOT NULL,
  `dt_checkout_date` datetime(3) NOT NULL,
  `dt_due_date` datetime(3) NOT NULL,
  `dt_return_date` datetime(3) DEFAULT NULL,
  `int_renewals_count` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `int_checkout_staff_id` int(10) unsigned NOT NULL,
  `int_checkin_staff_id` int(10) unsigned DEFAULT NULL,
  `dt_archived_at` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  PRIMARY KEY (`int_loan_history_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `PATRONS`;

CREATE TABLE `PATRONS` (
  `int_patron_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `int_university_id` int(10) unsigned NOT NULL,
  `str_first_name` varchar(100) NOT NULL,
  `str_last_name` varchar(100) NOT NULL,
  `str_email` varchar(191) NOT NULL,
  `str_phone_number` varchar(20) DEFAULT NULL,
  `int_patron_type_id` int(10) unsigned NOT NULL,
  `int_patron_account_status_id` int(10) unsigned NOT NULL,
  `dt_registration_date` date NOT NULL,
  `dt_expiry_date` date DEFAULT NULL,
  `bool_is_active` tinyint(1) NOT NULL DEFAULT 1,
  `dt_created_at` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `dt_updated_at` datetime(3) NOT NULL,
  PRIMARY KEY (`int_patron_id`),
  UNIQUE KEY `PATRONS_int_university_id_key` (`int_university_id`),
  UNIQUE KEY `PATRONS_str_email_key` (`str_email`),
  KEY `PATRONS_int_patron_type_id_fkey` (`int_patron_type_id`),
  KEY `PATRONS_int_patron_account_status_id_fkey` (`int_patron_account_status_id`),
  CONSTRAINT `PATRONS_int_patron_account_status_id_fkey` FOREIGN KEY (`int_patron_account_status_id`) REFERENCES `PATRON_ACCOUNT_STATUSES` (`int_patron_account_status_id`) ON UPDATE CASCADE,
  CONSTRAINT `PATRONS_int_patron_type_id_fkey` FOREIGN KEY (`int_patron_type_id`) REFERENCES `PATRON_TYPES` (`int_patron_type_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `PATRON_ACCOUNT_STATUSES`;

CREATE TABLE `PATRON_ACCOUNT_STATUSES` (
  `int_patron_account_status_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `str_name` varchar(50) NOT NULL,
  `str_description` text DEFAULT NULL,
  `bool_is_active` tinyint(1) NOT NULL DEFAULT 1,
  `dt_created_at` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `dt_updated_at` datetime(3) NOT NULL,
  PRIMARY KEY (`int_patron_account_status_id`),
  UNIQUE KEY `PATRON_ACCOUNT_STATUSES_str_name_key` (`str_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `PATRON_TYPES`;

CREATE TABLE `PATRON_TYPES` (
  `int_patron_type_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `str_name` varchar(50) NOT NULL,
  `int_loan_limit` int(10) unsigned DEFAULT NULL,
  `int_loan_duration_days` int(10) unsigned DEFAULT NULL,
  `bool_is_active` tinyint(1) NOT NULL DEFAULT 1,
  `dt_created_at` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `dt_updated_at` datetime(3) NOT NULL,
  PRIMARY KEY (`int_patron_type_id`),
  UNIQUE KEY `PATRON_TYPES_str_name_key` (`str_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `PAYMENTS`;

CREATE TABLE `PAYMENTS` (
  `int_payment_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `int_fine_id` int(10) unsigned NOT NULL,
  `int_patron_id` int(10) unsigned NOT NULL,
  `dec_amount_paid` decimal(10,2) NOT NULL,
  `dt_payment_date` datetime(3) NOT NULL,
  `str_payment_method` varchar(50) DEFAULT NULL,
  `int_processed_by_staff_id` int(10) unsigned NOT NULL,
  `bool_is_active` tinyint(1) NOT NULL DEFAULT 1,
  `dt_created_at` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `dt_updated_at` datetime(3) NOT NULL,
  PRIMARY KEY (`int_payment_id`),
  KEY `PAYMENTS_int_fine_id_fkey` (`int_fine_id`),
  KEY `PAYMENTS_int_patron_id_fkey` (`int_patron_id`),
  KEY `PAYMENTS_int_processed_by_staff_id_fkey` (`int_processed_by_staff_id`),
  CONSTRAINT `PAYMENTS_int_fine_id_fkey` FOREIGN KEY (`int_fine_id`) REFERENCES `FINES` (`int_fine_id`) ON UPDATE CASCADE,
  CONSTRAINT `PAYMENTS_int_patron_id_fkey` FOREIGN KEY (`int_patron_id`) REFERENCES `PATRONS` (`int_patron_id`) ON UPDATE CASCADE,
  CONSTRAINT `PAYMENTS_int_processed_by_staff_id_fkey` FOREIGN KEY (`int_processed_by_staff_id`) REFERENCES `STAFF` (`int_staff_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `PERMISSIONS`;

CREATE TABLE `PERMISSIONS` (
  `int_permission_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `str_name` varchar(100) NOT NULL,
  `str_description` text DEFAULT NULL,
  `bool_is_active` tinyint(1) NOT NULL DEFAULT 1,
  `dt_created_at` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `dt_updated_at` datetime(3) NOT NULL,
  PRIMARY KEY (`int_permission_id`),
  UNIQUE KEY `PERMISSIONS_str_name_key` (`str_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `PUBLISHERS`;

CREATE TABLE `PUBLISHERS` (
  `int_publisher_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `str_name` varchar(191) NOT NULL,
  `str_address` text DEFAULT NULL,
  `str_contact_info` varchar(191) DEFAULT NULL,
  `bool_is_active` tinyint(1) NOT NULL DEFAULT 1,
  `dt_created_at` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `dt_updated_at` datetime(3) NOT NULL,
  PRIMARY KEY (`int_publisher_id`),
  UNIQUE KEY `PUBLISHERS_str_name_key` (`str_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `RESERVATIONS`;

CREATE TABLE `RESERVATIONS` (
  `int_reservation_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `int_item_id` int(10) unsigned NOT NULL,
  `int_patron_id` int(10) unsigned NOT NULL,
  `dt_reservation_date` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `str_status` varchar(50) NOT NULL,
  `dt_notification_sent_date` datetime(3) DEFAULT NULL,
  `bool_is_active` tinyint(1) NOT NULL DEFAULT 1,
  `dt_created_at` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `dt_updated_at` datetime(3) NOT NULL,
  PRIMARY KEY (`int_reservation_id`),
  KEY `RESERVATIONS_int_item_id_fkey` (`int_item_id`),
  KEY `RESERVATIONS_int_patron_id_fkey` (`int_patron_id`),
  CONSTRAINT `RESERVATIONS_int_item_id_fkey` FOREIGN KEY (`int_item_id`) REFERENCES `ITEMS` (`int_item_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `RESERVATIONS_int_patron_id_fkey` FOREIGN KEY (`int_patron_id`) REFERENCES `PATRONS` (`int_patron_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `SERIES`;

CREATE TABLE `SERIES` (
  `int_series_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `str_name` varchar(191) NOT NULL,
  `str_description` text DEFAULT NULL,
  `bool_is_active` tinyint(1) NOT NULL DEFAULT 1,
  `dt_created_at` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `dt_updated_at` datetime(3) NOT NULL,
  PRIMARY KEY (`int_series_id`),
  UNIQUE KEY `SERIES_str_name_key` (`str_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `STAFF`;

CREATE TABLE `STAFF` (
  `int_staff_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `int_university_id` int(10) unsigned NOT NULL,
  `str_first_name` varchar(100) NOT NULL,
  `str_last_name` varchar(100) NOT NULL,
  `str_email` varchar(191) NOT NULL,
  `int_staff_role_id` int(10) unsigned NOT NULL,
  `bool_is_active` tinyint(1) NOT NULL DEFAULT 1,
  `dt_created_at` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `dt_updated_at` datetime(3) NOT NULL,
  PRIMARY KEY (`int_staff_id`),
  UNIQUE KEY `STAFF_int_university_id_key` (`int_university_id`),
  UNIQUE KEY `STAFF_str_email_key` (`str_email`),
  KEY `STAFF_int_staff_role_id_fkey` (`int_staff_role_id`),
  CONSTRAINT `STAFF_int_staff_role_id_fkey` FOREIGN KEY (`int_staff_role_id`) REFERENCES `STAFF_ROLES` (`int_staff_role_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `STAFF_ROLES`;

CREATE TABLE `STAFF_ROLES` (
  `int_staff_role_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `str_name` varchar(50) NOT NULL,
  `str_description` text DEFAULT NULL,
  `bool_is_active` tinyint(1) NOT NULL DEFAULT 1,
  `dt_created_at` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `dt_updated_at` datetime(3) NOT NULL,
  PRIMARY KEY (`int_staff_role_id`),
  UNIQUE KEY `STAFF_ROLES_str_name_key` (`str_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `STAFF_ROLE_PERMISSIONS`;

CREATE TABLE `STAFF_ROLE_PERMISSIONS` (
  `int_staff_role_id` int(10) unsigned NOT NULL,
  `int_permission_id` int(10) unsigned NOT NULL,
  `dt_created_at` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  PRIMARY KEY (`int_staff_role_id`,`int_permission_id`),
  KEY `STAFF_ROLE_PERMISSIONS_int_permission_id_fkey` (`int_permission_id`),
  CONSTRAINT `STAFF_ROLE_PERMISSIONS_int_permission_id_fkey` FOREIGN KEY (`int_permission_id`) REFERENCES `PERMISSIONS` (`int_permission_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `STAFF_ROLE_PERMISSIONS_int_staff_role_id_fkey` FOREIGN KEY (`int_staff_role_id`) REFERENCES `STAFF_ROLES` (`int_staff_role_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `SUBJECTS`;

CREATE TABLE `SUBJECTS` (
  `int_subject_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `str_name` varchar(191) NOT NULL,
  `str_code` varchar(50) DEFAULT NULL,
  `str_scheme` varchar(50) DEFAULT NULL,
  `bool_is_active` tinyint(1) NOT NULL DEFAULT 1,
  `dt_created_at` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `dt_updated_at` datetime(3) NOT NULL,
  PRIMARY KEY (`int_subject_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/** ================================================ PROCEDURES ================================================ */

/**
 * Creates a new item.
 * 
 * The procedure contains some optional parameters, passing NULL will set
 * that field as NULL, making the procedure more flexible.
 * 
 * Here i considerate that the possible form on the web client side will
 * be fill by a staff, so it wil be normal if the form is the complete
 * registration of an item, whether the form is completely fill or not.
 * 
 * Example Call:
 * CALL create_new_item(
 *   'New Book Title',
 *   1,
 *   1,
 *   1,
 *   2024,
 *   NULL,
 *   '1234567890123',
 *   NULL,
 *   NULL,
 *   NULL,
 *   'Description here',
 *   '[{"chapter": 1, "title": "Intro"}]'
 * );
 */
DROP PROCEDURE IF EXISTS sp_create_new_item;
DELIMITER $$
CREATE PROCEDURE sp_create_new_item (
    IN p_title VARCHAR(191),
    IN p_language_id INT,
    IN p_item_type_id INT,
    IN p_publisher_id INT DEFAULT NULL,
    IN p_publication_date YEAR DEFAULT NULL,
    IN p_edition VARCHAR(50) DEFAULT NULL,
    IN p_isbn VARCHAR(13) DEFAULT NULL,
    IN p_issn VARCHAR(9) DEFAULT NULL,
    IN p_dewey_decimal_code VARCHAR(20) DEFAULT NULL,
    IN p_series_id INT DEFAULT NULL,
    IN p_description TEXT DEFAULT NULL,
    IN p_table_of_contents JSON DEFAULT NULL
)
BEGIN
    INSERT INTO ITEMS (
        str_title,
        int_publisher_id,
        dt_publication_date,
        str_edition,
        str_isbn,
        str_issn,
        str_dewey_decimal_code,
        int_item_type_id,
        int_series_id,
        int_language_id,
        str_description,
        json_table_of_contents
    ) VALUES (
        p_title,
        p_publisher_id,
        p_publication_date,
        p_edition,
        p_isbn,
        p_issn,
        p_dewey_decimal_code,
        p_item_type_id,
        p_series_id,
        p_language_id,
        p_description,
        p_table_of_contents
    );
END $$
DELIMITER ;

/**
 * Creates a new patron with an 'Active' account status.
 * 
 * The consideration here is to provide a better UX the registration
 * form to sign up is expected to be as fast as possible to not frustrate
 * the user, so we just declare the minimal required field to create a new
 * patron.
 * 
 * Example Call:
 * CALL create_new_patron(
 *   20240001,
 *   'John',
 *   'Doe',
 *   'john.doe@university.edu',
 *   1
 * );
 */
DROP PROCEDURE IF EXISTS sp_create_new_patron;
DELIMITER $$
CREATE PROCEDURE sp_create_new_patron(
    IN p_university_id INT,
    IN p_first_name VARCHAR(100),
    IN p_last_name VARCHAR(100),
    IN p_email VARCHAR(255),
    IN p_patron_type_id INT
)
BEGIN
    DECLARE active_status_id INT;

    -- Find the ID for the 'Active' patron account status
    SELECT int_patron_account_status_id INTO active_status_id
    FROM PATRON_ACCOUNT_STATUSES
    WHERE str_name = 'Active'
    LIMIT 1;

    -- Insert the new patron
    INSERT INTO PATRONS (
        int_university_id,
        str_first_name,
        str_last_name,
        str_email,
        int_patron_type_id,
        int_patron_account_status_id,
        dt_registration_date
    ) VALUES (
        p_university_id,
        p_first_name,
        p_last_name,
        p_email,
        p_patron_type_id,
        active_status_id,
        CURDATE()
    );
END $$
DELIMITER ;

/**
 * Creates a new loan record and updates the item copy's status.
 * 
 * Contains business logic checks to prevent invalid loans.
 * - Check if the status of the copy is "Available"
 * - Check if the account status of the patron is "Active"
 * - Check if the patron already reach its loan limit
 * Thrown error if any of the checks is invalid
 * 
 * Example Call:
 * CALL make_loan(1, 1, 1);
 */
DROP PROCEDURE IF EXISTS sp_make_loan;
DELIMITER $$
CREATE PROCEDURE sp_make_loan(
    IN p_item_copy_id INT,
    IN p_patron_id INT,
    IN p_staff_id INT
)
BEGIN
    DECLARE v_copy_status_name VARCHAR(50);
    DECLARE v_patron_status_name VARCHAR(50);

    DECLARE v_loan_limit INT;
    DECLARE v_loan_duration INT;
    DECLARE v_active_loans INT;
    
    DECLARE on_loan_status_id INT;
    
    DECLARE v_due_date DATE;

    -- Get item copy status
    SELECT
      cs.str_name INTO v_copy_status_name
    FROM ITEM_COPIES ic
    LEFT JOIN COPY_STATUSES cs USING(int_copy_status_id) 
    WHERE ic.int_item_copy_id = p_item_copy_id;
    
    -- Get patron account status
    SELECT
      pas.str_name INTO v_patron_status_name
    FROM PATRONS p
    LEFT JOIN PATRON_ACCOUNT_STATUSES pas USING(int_patron_account_status_id)
    WHERE p.int_patron_id = p_patron_id;
    
    -- Business Rule Checks
    IF v_copy_status_name != 'Available' THEN
		SIGNAL SQLSTATE "45000"
		SET MESSAGE_TEXT = "Item is not available for loan.";
    ELSEIF v_patron_status_name != 'Active' THEN
		SIGNAL SQLSTATE "45000"
		SET MESSAGE_TEXT = "Account is not active.";
    ELSE
    
        -- Check loan limit
        SELECT pt.int_loan_limit, pt.int_loan_duration_days INTO v_loan_limit, v_loan_duration
        FROM PATRONS p
        LEFT JOIN PATRON_TYPES pt USING(int_patron_type_id)
        WHERE int_patron_id = p_patron_id;
        
        SELECT COUNT(*) INTO v_active_loans
        FROM LOANS
        WHERE
          int_patron_id = p_patron_id AND
          dt_return_date IS NULL;

        IF v_active_loans >= v_loan_limit THEN
			SIGNAL SQLSTATE "45000"
			SET MESSAGE_TEXT = "Patron has reached their loan limit.";
        ELSE
        
    		-- Get "On Loan" copy status ID
    		SELECT int_copy_status_id INTO on_loan_status_id
    		FROM COPY_STATUSES
    		WHERE str_name = 'On Loan' LIMIT 1;
    	
            -- All checks passed, proceed with transaction
            START TRANSACTION;

            -- Calculate due date
            SET v_due_date = DATE_ADD(CURDATE(), INTERVAL v_loan_duration DAY);

            -- Create the loan record
            INSERT INTO LOANS (
                int_item_copy_id,
                int_patron_id,
                dt_checkout_date,
                dt_due_date,
                int_checkout_staff_id
            ) VALUES (
                p_item_copy_id,
                p_patron_id,
                NOW(),
                v_due_date,
                p_staff_id);

            -- Update the item copy's status to 'On Loan'
            UPDATE ITEM_COPIES
            SET int_copy_status_id = on_loan_status_id
            WHERE int_item_copy_id = p_item_copy_id;

            COMMIT;
        END IF;
    END IF;
END $$
DELIMITER ;

/**
 * Processes the return of a loan, updates statuses, and creates fines if necessary.
 * 
 * It process the loan updating that was returned
 * If returned over due date
 *  - creates a Fine
 * If the item copy was reserved while on loan
 *  - Change the state of the copy from "On Loan" to "On Reserve"
 * Else
 *  - Change the state of the copy from "On Loan" to "Available"
 * 
 * Example Call:
 * CALL return_loan(1, 1, 100.50);
 */
DROP PROCEDURE IF EXISTS sp_return_loan;
DELIMITER $$
CREATE PROCEDURE sp_return_loan(
    IN p_item_copy_id INT,
    IN p_staff_id INT,
    IN p_fine_amount_per_day DECIMAL(10, 2) DEFAULT 50
)
BEGIN
    DECLARE v_loan_id INT;
    DECLARE v_patron_id INT;
    DECLARE v_item_id INT;
    DECLARE v_due_date DATE;

    DECLARE v_overdue_days INT;
    
    DECLARE next_reservation_exists BOOLEAN DEFAULT FALSE;
    
    DECLARE on_reserve_status_id INT;
    DECLARE available_status_id INT;

    -- Find the active loan for this copy
    SELECT
      l.int_loan_id,
      l.int_patron_id,
      ic.int_item_id,
      l.dt_due_date
    INTO
      v_loan_id,
      v_patron_id,
      v_item_id,
      v_due_date
    FROM LOANS l
    LEFT JOIN ITEM_COPIES ic USING(int_item_copy_id)
    WHERE l.int_item_copy_id = p_item_copy_id AND l.dt_return_date IS NULL
    LIMIT 1;

    IF v_loan_id IS NULL THEN
		SIGNAL SQLSTATE "45000"
		SET MESSAGE_TEXT = "No active loan found for this item copy.";
    ELSE
        -- Get "On Reserve" and "Available" item copy statuses ID
		SELECT
		    MAX(CASE WHEN str_name = 'On Reserve' THEN int_copy_status_id END),
		    MAX(CASE WHEN str_name = 'Available' THEN int_copy_status_id END)
		INTO
		    on_reserve_status_id,
		    available_status_id
		FROM COPY_STATUSES
		WHERE str_name IN ('On Reserve', 'Available');
    
        START TRANSACTION;

        -- Update the loan record with the return date
        UPDATE LOANS
        SET
          dt_return_date = NOW(),
          int_checkin_staff_id = p_staff_id
        WHERE int_loan_id = v_loan_id;

        -- Check for overdue and create a fine if necessary
        SET v_overdue_days = DATEDIFF(CURDATE(), v_due_date);
        IF v_overdue_days > 0 THEN
            INSERT INTO FINES (
              int_loan_id,
              int_patron_id,
              dec_amount,
              str_reason,
              dt_date_issued,
              str_status)
            VALUES (
        	  v_loan_id,
        	  v_patron_id,
        	  v_overdue_days * p_fine_amount_per_day,
        	  'Overdue return',
        	  CURDATE(),
        	  'Unpaid');
        END IF;

        -- Check for reservations on this item
        SELECT EXISTS (
            SELECT 1 FROM RESERVATIONS WHERE int_item_id = v_item_id AND str_status = 'Pending'
        ) INTO next_reservation_exists;

        -- Update item copy status
        IF next_reservation_exists THEN
            UPDATE ITEM_COPIES
        	SET int_copy_status_id = on_reserve_status_id
        	WHERE int_item_copy_id = p_item_copy_id;
        ELSE
            UPDATE ITEM_COPIES
            SET int_copy_status_id = available_status_id
            WHERE int_item_copy_id = p_item_copy_id;
        END IF;

        COMMIT;
    END IF;
END $$
DELIMITER ;


/** ================================================ FUNCTIONS ================================================ */

/**
 * Calculates the number of currently active (not returned) loans for a given patron.
 * This is not a deterministic function because the returned data could vary.
 * 
 * Example Usage:
 * SELECT calculate_patron_loan_count(1);
 */
DROP FUNCTION IF EXISTS fn_calculate_patron_loan_count;
DELIMITER $$
CREATE FUNCTION fn_calculate_patron_loan_count(
    p_patron_id INT
)
RETURNS INT
NOT DETERMINISTIC
BEGIN
    DECLARE loan_count INT;

    SELECT COUNT(*)
    INTO loan_count
    FROM LOANS
    WHERE
        int_patron_id = p_patron_id AND
        dt_return_date IS NULL;

    RETURN loan_count;
END $$
DELIMITER ;

/**
 * Checks if a specific item copy is currently available for loan.
 * This is a deterministic function because the returned value just have
 * two states (TRUE or FALSE)
 *
 * Example Usage:
 * SELECT is_item_copy_available(5);
 */
DROP FUNCTION IF EXISTS fn_is_item_copy_available;
DELIMITER $$
CREATE FUNCTION fn_is_item_copy_available(
    p_item_copy_id INT
)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE v_status_name VARCHAR(50);

    SELECT cs.str_name INTO v_status_name
    FROM ITEM_COPIES ic
    JOIN COPY_STATUSES cs USING(int_copy_status_id)
    WHERE ic.int_item_copy_id = p_item_copy_id;

    IF v_status_name = 'Available' THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END $$
DELIMITER ;


/**
 * Calculates the total number of all active (not returned) loans across the entire library system.
 * This is not a deterministic function because the returned data could vary.
 *
 * Example Usage:
 * SELECT get_total_active_loans();
 */
DROP FUNCTION IF EXISTS fn_get_total_active_loans;
DELIMITER $$
CREATE FUNCTION fn_get_total_active_loans()
RETURNS INT
READS SQL DATA
BEGIN
    DECLARE total_active_loans INT;

    SELECT COUNT(*)
    INTO total_active_loans
    FROM LOANS
    WHERE dt_return_date IS NULL;

    RETURN total_active_loans;
END $$
DELIMITER ;


/** ================================================ TRIGGERS ================================================ */

/**
 * Track a loan record changes inserting them into the LOAN_HISTORY table after
 * a loan is updated.
 *  
 * The AFTER INSERT was not created since was analyzed that the table LOANS can
 * preserve the recent data while the LOAN_HISTORY keeps the old data changed on
 * a loan, ensuring a control of the loans data.
 */
DROP TRIGGER IF EXISTS trg_track_loan_changes;
DELIMITER $$
CREATE TRIGGER trg_track_loan_changes
AFTER UPDATE ON LOANS
FOR EACH ROW
BEGIN
	INSERT INTO LOAN_HISTORY (
		int_loan_id,
		int_item_copy_id,
		int_patron_id,
		dt_checkout_date,
		dt_due_date,
		dt_return_date,
		int_renewals_count,
		int_checkout_staff_id,
		int_checkin_staff_id,
		dt_archived_at)
	VALUES (
		OLD.int_loan_id,
		OLD.int_item_copy_id,
		OLD.int_patron_id,
		OLD.dt_checkout_date,
		OLD.dt_due_date,
		OLD.dt_return_date,
		OLD.int_renewals_count,
		OLD.int_checkout_staff_id,
		OLD.int_checkin_staff_id,
		NOW());
END $$
DELIMITER ;


/**
 * Blocks the deletion of a record from the ITEMS table if any of its associated
 * copies are currently on loan or on reserve.
 * 
 * This prevent a possible error after deletion when the patron return the loaned
 * item. Or for patrons that reserved the item before the desicion of deleting the
 * item. Ensuring it is only deleted once the item is not required by patrons in a
 * period of time.
 */
DROP TRIGGER IF EXISTS trg_prevent_item_deletion;
DELIMITER $$
CREATE TRIGGER trg_prevent_item_deletion
BEFORE DELETE ON ITEMS
FOR EACH ROW
BEGIN
    DECLARE active_copy_count INT;

    -- Count how many of the item's copies have a status of 'On Loan' or 'On Reserve'
    SELECT COUNT(*)
    INTO active_copy_count
    FROM ITEM_COPIES ic
    JOIN COPY_STATUSES cs USING(int_copy_status_id)
    WHERE
        ic.int_item_id = OLD.int_item_id AND
        cs.str_name IN ('On Loan', 'On Reserve');

    -- If any copies are active, block the deletion by raising an error
    IF active_copy_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot delete item: One or more copies are currently on loan or reserved.';
    END IF;
END $$
DELIMITER ;


DROP TRIGGER IF EXISTS trg_set_items_updated_at;
DELIMITER $$
CREATE TRIGGER trg_set_items_updated_at
BEFORE INSERT ON ITEMS
FOR EACH ROW
BEGIN
	SET NEW.dt_created_at = NOW();
	SET NEW.dt_updated_at = NOW();
END $$
DELIMITER ;

DROP TRIGGER IF EXISTS trg_update_items_updated_at;
DELIMITER $$
CREATE TRIGGER trg_update_items_updated_at
BEFORE UPDATE ON ITEMS
FOR EACH ROW
BEGIN
	SET NEW.dt_updated_at = NOW();
END $$
DELIMITER ;


DROP TRIGGER IF EXISTS trg_set_patrons_updated_at;
DELIMITER $$
CREATE TRIGGER trg_set_patrons_updated_at
BEFORE INSERT ON PATRONS
FOR EACH ROW
BEGIN
	SET NEW.dt_created_at = NOW();
	SET NEW.dt_updated_at = NOW();
END $$
DELIMITER ;

DROP TRIGGER IF EXISTS trg_update_patrons_updated_at;
DELIMITER $$
CREATE TRIGGER trg_update_patrons_updated_at
BEFORE UPDATE ON PATRONS
FOR EACH ROW
BEGIN
	SET NEW.dt_updated_at = NOW();
END $$
DELIMITER ;

DROP TRIGGER IF EXISTS trg_set_loans_updated_at;
DELIMITER $$
CREATE TRIGGER trg_set_loans_updated_at
BEFORE INSERT ON LOANS
FOR EACH ROW
BEGIN
	SET NEW.dt_created_at = NOW();
	SET NEW.dt_updated_at = NOW();
END $$
DELIMITER ;

DROP TRIGGER IF EXISTS trg_update_loans_updated_at;
DELIMITER $$
CREATE TRIGGER trg_update_loans_updated_at
BEFORE UPDATE ON LOANS
FOR EACH ROW
BEGIN
	SET NEW.dt_updated_at = NOW();
END $$
DELIMITER ;

DROP TRIGGER IF EXISTS trg_set_fines_updated_at;
DELIMITER $$
CREATE TRIGGER trg_set_fines_updated_at
BEFORE INSERT ON FINES
FOR EACH ROW
BEGIN
	SET NEW.dt_created_at = NOW();
	SET NEW.dt_updated_at = NOW();
END $$
DELIMITER ;

DROP TRIGGER IF EXISTS trg_update_fines_updated_at;
DELIMITER $$
CREATE TRIGGER trg_update_fines_updated_at
BEFORE UPDATE ON FINES
FOR EACH ROW
BEGIN
	SET NEW.dt_updated_at = NOW();
END $$
DELIMITER ;

DROP TRIGGER IF EXISTS trg_update_item_copies_updated_at;
DELIMITER $$
CREATE TRIGGER trg_update_item_copies_updated_at
BEFORE UPDATE ON ITEM_COPIES
FOR EACH ROW
BEGIN
	SET NEW.dt_updated_at = NOW();
END $$
DELIMITER ;

