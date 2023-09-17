INSERT INTO `jobs`(`name`, `label`) VALUES
	('police', "LSPD")
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('police', 0, 'cadet', 'Cadet', 500, '{}', '{}'),
	('police', 1, 'officer', 'Officer 1', 500, '{}', '{}'),
	('police', 2, 'officer', 'Officer 2', 500, '{}', '{}'),
	('police', 3, 'officer', 'Officer 3', 500, '{}', '{}'),
	('police', 4, 'sergeant', 'Sergeant 1', 500, '{}', '{}'),
	('police', 5, 'sergeant', 'Sergeant 2', 500, '{}', '{}'),
	('police', 6, 'sergeant', 'Sergeant 3', 500, '{}', '{}'),
	('police', 7, 'lieutenant', 'Lieutenant 1', 500, '{}', '{}'),
	('police', 8, 'lieutenant', 'Lieutenant 2', 500, '{}', '{}'),
	('police', 9, 'lieutenant', 'Lieutenant 3', 500, '{}', '{}'),
	('police', 10, 'captain', 'Captain 1', 500, '{}', '{}'),
	('police', 11, 'captain', 'Captain 2', 500, '{}', '{}'),
	('police', 12, 'captain', 'Captain 3', 500, '{}', '{}'),
	('police', 13, 'deputy', 'Deputy Commander', 500, '{}', '{}'),
	('police', 14, 'boss', 'Commander', 500, '{}', '{}'),
	('police', 15, 'boss', 'Deputy Chief of Police', 500, '{}', '{}'),
	('police', 16, 'boss', 'Assistant Chief of Police', 500, '{}', '{}'),
	('police', 17, 'boss', 'Chief of Police', 500, '{}', '{}'),
;
INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_police', "LSPD", 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_police', "LSPD", 1),
	('society_policehaw', 'LSPDHAW', 1),
	('society_policewu', 'LSPDWU', 1),
	('society_policezbrojownia', 'LSPDZBROJOWNIA', 1);
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_police', "LSPD", 1)
;

CREATE TABLE IF NOT EXISTS `godzinysluzba` (
  `hex` varchar(50) DEFAULT NULL,
  `czas` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

ALTER TABLE users
ADD odznaka varchar(3);

INSERT INTO `licenses` (`type`, `label`) VALUES ('asu', 'Air Support Unit');
INSERT INTO `licenses` (`type`, `label`) VALUES ('haw', 'Heavy Assault Weapon');
INSERT INTO `licenses` (`type`, `label`) VALUES ('waterunit', 'Water Unit');