-- --------------------------------------------------------
-- HeidiSQL Version:             12.6.0.6765
-- --------------------------------------------------------

-- Exportiere Datenbank-Struktur für amt
CREATE DATABASE IF NOT EXISTS `amt` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `amt`;

-- Exportiere Struktur von Tabelle amt.changelog
CREATE TABLE IF NOT EXISTS `changelog` (
  `tpye` tinytext NOT NULL COMMENT 'Possible: "add", "remove", "neutral"',
  `comment` mediumtext NOT NULL COMMENT 'Comment on the action performed',
  `by` tinytext NOT NULL COMMENT 'Name of the staff member',
  `timestamp` datetime NOT NULL COMMENT 'Timestamp'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Internal changelogs only for admins and developers';

-- Exportiere Daten aus Tabelle amt.changelog: ~0 rows (ungefähr)

-- Exportiere Struktur von Tabelle amt.modlog
CREATE TABLE IF NOT EXISTS `modlog` (
  `user` tinytext NOT NULL COMMENT 'License of the player',
  `mod` tinytext NOT NULL COMMENT 'Name of the moderator',
  `action` tinytext NOT NULL COMMENT 'Possible: "warn", "kick", "ban", "dctimeout", "dewhitelist", "note", "other"',
  `reason` mediumtext NOT NULL COMMENT 'Reason of the action or the note or the performed action and reason',
  `timestamp` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Log of moderation actions';

-- Exportiere Daten aus Tabelle amt.modlog: ~0 rows (ungefähr)

-- Exportiere Struktur von Tabelle amt.players
CREATE TABLE IF NOT EXISTS `players` (
  `license` tinytext NOT NULL COMMENT 'License1 of the player',
  `name` text NOT NULL COMMENT 'Gamertag of the player',
  `alias` text DEFAULT NULL COMMENT 'Player known by an alias?',
  `discordid` tinytext NOT NULL COMMENT 'DiscordID of the player',
  `streamid` tinytext DEFAULT NULL COMMENT 'SteamID of the player',
  `banned` bit(1) NOT NULL,
  `banreason` mediumtext DEFAULT NULL,
  KEY `license` (`license`(255))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Stores all players';

-- Exportiere Daten aus Tabelle amt.players: ~0 rows (ungefähr)

-- Exportiere Struktur von Tabelle amt.settings
CREATE TABLE IF NOT EXISTS `settings` (
  `setting` text NOT NULL COMMENT 'Setting',
  `state` text NOT NULL COMMENT 'State of the setting',
  `discribtion` text NOT NULL COMMENT 'What does this do?'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Global settings';

-- Exportiere Daten aus Tabelle amt.settings: ~4 rows (ungefähr)
INSERT INTO `settings` (`setting`, `state`, `discribtion`) VALUES
	('wl_question_count', 'Insert count here!', 'How many whitelist questions will be asked?'),
	('community_name', 'Insert Name here!', 'Set the name of your community'),
	('motd', 'Insert your MOTD here!', 'The message of the day visible to your staff'),
	('warns_to_ban', 'Insert count here!', 'Number of warns until a user gets banned');

-- Exportiere Struktur von Tabelle amt.supportlog
CREATE TABLE IF NOT EXISTS `supportlog` (
  `user` tinytext NOT NULL COMMENT 'License of main player involved',
  `staff` tinytext NOT NULL COMMENT 'Name of leading staff',
  `reason` text NOT NULL COMMENT 'Reason of the support talk',
  `notes` mediumtext NOT NULL COMMENT 'Notes on the topic',
  `solution` mediumtext DEFAULT NULL COMMENT 'How the problem was resolved',
  `involved` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'JSON of the licences of other involved players',
  `other_staff` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'JSON of the names of other involved staff',
  `timestamp` datetime NOT NULL COMMENT 'When was the log created'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='A log of every support happening in a voice channel';

-- Exportiere Daten aus Tabelle amt.supportlog: ~0 rows (ungefähr)

-- Exportiere Struktur von Tabelle amt.users
CREATE TABLE IF NOT EXISTS `users` (
  `name` tinytext NOT NULL COMMENT 'Username',
  `rank` tinytext NOT NULL COMMENT 'Rank of the user. Options: "supporter", "moderator", "admin", "developer", "owner"',
  `password` mediumtext NOT NULL COMMENT 'Hashed password, only password for default user remains unhashed',
  `locked` bit(1) NOT NULL DEFAULT b'0' COMMENT 'Is the account locked out?',
  UNIQUE KEY `name` (`name`) USING HASH
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='This tabel saves all the AMT users. Operations will run over the mysql user set at first start.';

-- Exportiere Daten aus Tabelle amt.users: ~1 rows (ungefähr)
INSERT INTO `users` (`name`, `rank`, `password`, `locked`) VALUES
	('default', 'INITACC', 'password', b'0');

-- Exportiere Struktur von Tabelle amt.whitelist
CREATE TABLE IF NOT EXISTS `whitelist` (
  `license` tinytext NOT NULL COMMENT 'License of the user',
  `whitelisted` bit(1) NOT NULL DEFAULT b'0' COMMENT 'Is the user whitelisted?',
  `by` tinytext DEFAULT NULL COMMENT 'Staff member who whitelisted him',
  UNIQUE KEY `license` (`license`) USING HASH
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Current whitelist';

-- Exportiere Daten aus Tabelle amt.whitelist: ~0 rows (ungefähr)

-- Exportiere Struktur von Tabelle amt.whitelist_log
CREATE TABLE IF NOT EXISTS `whitelist_log` (
  `user` tinytext NOT NULL COMMENT 'Discord ID of the user who tries the whitelist',
  `staff` tinytext NOT NULL COMMENT 'Name of the staff',
  `asked` mediumtext NOT NULL COMMENT 'The asked questions',
  `passed` bit(1) NOT NULL DEFAULT b'0',
  `timestamp` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Log of every whitelist attempt happening';

-- Exportiere Daten aus Tabelle amt.whitelist_log: ~0 rows (ungefähr)

-- Exportiere Struktur von Tabelle amt.whitelist_questions
CREATE TABLE IF NOT EXISTS `whitelist_questions` (
  `question` mediumtext NOT NULL COMMENT 'A question',
  `answer` mediumtext NOT NULL COMMENT 'The correct answer'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Possible questions to ask the user in a whitelist talk';

-- Exportiere Daten aus Tabelle amt.whitelist_questions: ~0 rows (ungefähr)
