-- --------------------------------------------------------
-- Hôte:                         127.0.0.1
-- Version du serveur:           5.7.33 - MySQL Community Server (GPL)
-- SE du serveur:                Win64
-- HeidiSQL Version:             11.2.0.6213
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Listage de la structure de la base pour movie-pdo-01
CREATE DATABASE IF NOT EXISTS `movie-pdo-01` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_bin */;
USE `movie-pdo-01`;

-- Listage de la structure de la table movie-pdo-01. actor
CREATE TABLE IF NOT EXISTS `actor` (
  `id_actor` int(11) NOT NULL AUTO_INCREMENT,
  `staff_id` int(11) NOT NULL,
  PRIMARY KEY (`id_actor`),
  UNIQUE KEY `staff_id` (`staff_id`),
  CONSTRAINT `actor_ibfk_1` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`id_staff`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Listage des données de la table movie-pdo-01.actor : ~16 rows (environ)
/*!40000 ALTER TABLE `actor` DISABLE KEYS */;
INSERT INTO `actor` (`id_actor`, `staff_id`) VALUES
	(1, 5),
	(2, 6),
	(3, 7),
	(4, 8),
	(5, 9),
	(6, 10),
	(7, 11),
	(8, 12),
	(9, 13),
	(10, 14),
	(11, 15),
	(12, 16),
	(13, 17),
	(14, 18),
	(15, 21),
	(16, 22);
/*!40000 ALTER TABLE `actor` ENABLE KEYS */;

-- Listage de la structure de la table movie-pdo-01. casting
CREATE TABLE IF NOT EXISTS `casting` (
  `movie_id` int(11) NOT NULL,
  `actor_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  PRIMARY KEY (`movie_id`,`actor_id`,`role_id`),
  KEY `actor_id` (`actor_id`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `casting_ibfk_1` FOREIGN KEY (`movie_id`) REFERENCES `movie` (`id_movie`),
  CONSTRAINT `casting_ibfk_2` FOREIGN KEY (`actor_id`) REFERENCES `actor` (`id_actor`),
  CONSTRAINT `casting_ibfk_3` FOREIGN KEY (`role_id`) REFERENCES `role` (`id_role`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Listage des données de la table movie-pdo-01.casting : ~23 rows (environ)
/*!40000 ALTER TABLE `casting` DISABLE KEYS */;
INSERT INTO `casting` (`movie_id`, `actor_id`, `role_id`) VALUES
	(1, 1, 1),
	(1, 2, 2),
	(10, 2, 19),
	(1, 3, 3),
	(2, 4, 4),
	(9, 4, 18),
	(2, 5, 5),
	(2, 6, 6),
	(3, 7, 7),
	(11, 7, 20),
	(3, 8, 8),
	(3, 9, 9),
	(4, 10, 10),
	(4, 11, 11),
	(4, 12, 12),
	(5, 13, 13),
	(6, 14, 14),
	(8, 14, 17),
	(7, 15, 15),
	(12, 15, 21),
	(13, 15, 22),
	(14, 15, 23),
	(7, 16, 16);
/*!40000 ALTER TABLE `casting` ENABLE KEYS */;

-- Listage de la structure de la table movie-pdo-01. director
CREATE TABLE IF NOT EXISTS `director` (
  `id_director` int(11) NOT NULL AUTO_INCREMENT,
  `staff_id` int(11) NOT NULL,
  PRIMARY KEY (`id_director`),
  UNIQUE KEY `staff_id` (`staff_id`),
  CONSTRAINT `director_ibfk_1` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`id_staff`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Listage des données de la table movie-pdo-01.director : ~10 rows (environ)
/*!40000 ALTER TABLE `director` DISABLE KEYS */;
INSERT INTO `director` (`id_director`, `staff_id`) VALUES
	(1, 1),
	(2, 2),
	(3, 3),
	(4, 4),
	(5, 17),
	(8, 18),
	(6, 19),
	(7, 20),
	(9, 23),
	(10, 24);
/*!40000 ALTER TABLE `director` ENABLE KEYS */;

-- Listage de la structure de la table movie-pdo-01. genre
CREATE TABLE IF NOT EXISTS `genre` (
  `id_genre` int(11) NOT NULL AUTO_INCREMENT,
  `label` varchar(30) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id_genre`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Listage des données de la table movie-pdo-01.genre : ~6 rows (environ)
/*!40000 ALTER TABLE `genre` DISABLE KEYS */;
INSERT INTO `genre` (`id_genre`, `label`) VALUES
	(1, 'Science-Fiction'),
	(2, 'Drame'),
	(3, 'Aventure'),
	(4, 'Comédie'),
	(5, 'Horreur'),
	(6, 'Action');
/*!40000 ALTER TABLE `genre` ENABLE KEYS */;

-- Listage de la structure de la table movie-pdo-01. movie
CREATE TABLE IF NOT EXISTS `movie` (
  `id_movie` int(11) NOT NULL AUTO_INCREMENT,
  `director_id` int(11) NOT NULL,
  `title` varchar(30) COLLATE utf8_bin NOT NULL,
  `duration` int(11) NOT NULL,
  `release_date` date NOT NULL,
  `notation` decimal(2,1) DEFAULT NULL,
  `synopsis` text COLLATE utf8_bin,
  `poster` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id_movie`),
  KEY `director_id` (`director_id`),
  CONSTRAINT `movie_ibfk_1` FOREIGN KEY (`director_id`) REFERENCES `director` (`id_director`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Listage des données de la table movie-pdo-01.movie : ~14 rows (environ)
/*!40000 ALTER TABLE `movie` DISABLE KEYS */;
INSERT INTO `movie` (`id_movie`, `director_id`, `title`, `duration`, `release_date`, `notation`, `synopsis`, `poster`) VALUES
	(1, 1, 'Star Wars Vol1', 136, '1999-10-13', 6.2, 'Dans une galaxie une entre les Chevaliers Jedi et les Seigneurs noirs des Sith, personnes sensibles à la Force.', 'film1.jpg'),
	(2, 2, 'Indiana Jones Vol1', 116, '1981-09-22', 7.7, 'Pérou, 1936. Le professeur Henry Walton Jones Jr (dit « Indiana », ou « Indy »), un éminent archéologue américain et expert en occultisme, est sur le point de mettre la main sur une idole Chachapoyan.', 'film2.jpg'),
	(3, 3, 'Batman Vol1', 126, '1989-09-13', 7.1, 'Enfant, le milliardaire Bruce Wayne voit ses parents assassinés par un voleur des rues, qui en voulait au collier de perles de sa mère.', 'film3.jpg'),
	(4, 4, 'X-Men Vol1', 104, '2000-10-30', 6.5, '1944, dans un camp de concentration. Séparé par la force de ses parents, le jeune Erik Magnus Lehnsherr se découvre ses pouvoirs sous le coup de la colère : il peut contrôler les métaux.', 'film4.jpg'),
	(5, 5, 'Grand Torino', 116, '2008-06-15', 7.7, 'Walt Kowalski, vétéran de la guerre de Corée, raciste et irascible, vient de perdre sa femme. Une nuit, il surprend Thao, un de ses jeunes voisins Hmong, en train de voler sa Ford Gran Torino de 1972.', 'film5.jpg'),
	(6, 6, 'Mad Max', 85, '1979-08-21', 6.8, 'Un criminel, Montazano, membre du gang de motards « Aigles de la route » , fuit en tuant un agent de la police routière.', 'film6.jpg'),
	(7, 7, 'Légende d\'automne', 133, '1994-02-03', 8.3, 'Dans le Montana dans les années 1960, un vieil indien raconte les secrets de la famille Ludlow.', 'film7.jpg'),
	(8, 8, 'Braveheart', 178, '1995-01-20', 8.0, 'Au XIIIe siècle, le roi Edouard Ier sempare du trône dEcosse et instaure un régime répressif.', 'film8.jpg'),
	(9, 1, 'Star Wars Vol4', 121, '1977-12-12', 7.7, 'Dans une galaxie une guerre entre les Chevaliers Jedi et les Seigneurs noirs des Sith, personnes sensibles à la Force.', 'film9.jpg'),
	(10, 2, 'La liste de Schindler', 195, '1933-06-12', 8.1, 'En 1939, les Allemands installés en Pologne, regroupent les juifs dans des ghettos dans le but de les utiliser comme des esclaves. ', 'film10.jpg'),
	(11, 3, 'Dumbo', 72, '2019-03-27', 5.8, 'dans le Missouri. Holt Farrier, ancien cavalier de cirque, mancho, revient au cirque Medici Brothers, dirigé par Max Medici, après la Première Guerre mondiale. ', 'film11.jpg'),
	(12, 9, 'Bullet Train', 126, '2022-02-15', 6.5, 'Coccinelle est un assassin malchanceux et particulièrement déterminé à accomplir sa nouvelle mission paisiblement après que la plupart des ses missions aient déraillé.', 'film12.jpg'),
	(13, 10, 'Once Upon a time...', 181, '2019-03-23', 7.2, 'En 1969, la star de télévision Rick Dalton et le cascadeur Cliff Booth, sa doublure de longue date, poursuivent leurs carrières au sein d’une industrie qui a changé. ', 'film13.jpg'),
	(14, 10, 'Inglourious Basterds', 153, '2009-12-12', 7.4, 'Dans la France occupée de 1940, Shosanna Dreyfus assiste à la mort de sa famille tombée entre les mains du colonel nazi Hans Landa.', 'film14.jpg');
/*!40000 ALTER TABLE `movie` ENABLE KEYS */;

-- Listage de la structure de la table movie-pdo-01. movie_genre_link
CREATE TABLE IF NOT EXISTS `movie_genre_link` (
  `movie_id` int(11) NOT NULL,
  `genre_id` int(11) NOT NULL,
  PRIMARY KEY (`movie_id`,`genre_id`) USING BTREE,
  KEY `type_id` (`genre_id`) USING BTREE,
  CONSTRAINT `movie_genre_link_ibfk_1` FOREIGN KEY (`movie_id`) REFERENCES `movie` (`id_movie`),
  CONSTRAINT `movie_genre_link_ibfk_2` FOREIGN KEY (`genre_id`) REFERENCES `genre` (`id_genre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Listage des données de la table movie-pdo-01.movie_genre_link : ~14 rows (environ)
/*!40000 ALTER TABLE `movie_genre_link` DISABLE KEYS */;
INSERT INTO `movie_genre_link` (`movie_id`, `genre_id`) VALUES
	(1, 1),
	(2, 1),
	(4, 1),
	(9, 1),
	(11, 1),
	(5, 2),
	(7, 2),
	(8, 2),
	(10, 2),
	(14, 2),
	(3, 3),
	(12, 4),
	(13, 4),
	(6, 6);
/*!40000 ALTER TABLE `movie_genre_link` ENABLE KEYS */;

-- Listage de la structure de la table movie-pdo-01. role
CREATE TABLE IF NOT EXISTS `role` (
  `id_role` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id_role`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Listage des données de la table movie-pdo-01.role : ~23 rows (environ)
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` (`id_role`, `name`) VALUES
	(1, 'Obiwan Kenobi'),
	(2, 'Qui Jon Jim'),
	(3, 'Princess Amidala'),
	(4, 'Dr Jones (indy)'),
	(5, 'Marion Ravenwood'),
	(6, 'Marcus Brody'),
	(7, 'Bruce Wayne (Batman)'),
	(8, 'Joker'),
	(9, 'Vicki Vale'),
	(10, 'Professeur Charles Xavier'),
	(11, 'Logan'),
	(12, 'Magnetto'),
	(13, 'Walt Kowalski'),
	(14, 'Mad Max'),
	(15, 'Tristan Ludlow'),
	(16, 'William Ludlow'),
	(17, 'William Wallace'),
	(18, 'Han Solo'),
	(19, 'Oskar Schindler'),
	(20, 'V.A. Vandevere'),
	(21, 'Coccinelle'),
	(22, 'Cliff Booth'),
	(23, 'Aldo Raine');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;

-- Listage de la structure de la table movie-pdo-01. staff
CREATE TABLE IF NOT EXISTS `staff` (
  `id_staff` int(11) NOT NULL AUTO_INCREMENT,
  `firstname` varchar(100) COLLATE utf8_bin NOT NULL,
  `lastname` varchar(100) COLLATE utf8_bin NOT NULL,
  `birthdate` date NOT NULL,
  `gender` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `is_alive` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id_staff`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Listage des données de la table movie-pdo-01.staff : ~24 rows (environ)
/*!40000 ALTER TABLE `staff` DISABLE KEYS */;
INSERT INTO `staff` (`id_staff`, `firstname`, `lastname`, `birthdate`, `gender`, `is_alive`) VALUES
	(1, 'George', 'Lucas', '1944-05-14', 'Masculin', NULL),
	(2, 'Steven', 'Spielberg', '1946-12-18', 'Masculin', NULL),
	(3, 'Tim', 'Burton', '1958-08-25', 'Masculin', NULL),
	(4, 'Bryan', 'Singer', '1965-09-17', 'Masculin', NULL),
	(5, 'Ewan', 'McGregor', '1971-03-31', 'Masculin', NULL),
	(6, 'Liam', 'Neeson', '1952-06-07', 'Masculin', NULL),
	(7, 'Nathalie', 'Portmann', '1981-06-09', 'Feminin', NULL),
	(8, 'Harisson', 'Ford', '1942-07-13', 'Masculin', NULL),
	(9, 'Karen', 'Allen', '1951-10-05', 'Feminin', NULL),
	(10, 'Eliott', 'Denholm', '1922-05-31', 'Masculin', NULL),
	(11, 'Mickael', 'Keaton', '1951-09-05', 'Masculin', NULL),
	(12, 'Jack', 'Nicholson', '1937-04-22', 'Masculin', NULL),
	(13, 'Kim', 'Basinger', '1953-12-08', 'Feminin', NULL),
	(14, 'Patrick', 'Stewart', '1940-07-13', 'Masculin', NULL),
	(15, 'Hugh', 'Jackman', '1968-10-12', 'Masculin', NULL),
	(16, 'Ian', 'McKellen', '1939-05-25', 'Masculin', NULL),
	(17, 'Clint', 'Eastwood', '1930-05-31', 'Masculin', NULL),
	(18, 'Mel', 'Gibson', '1956-01-03', 'Masculin', NULL),
	(19, 'George', 'Miller', '1945-03-03', 'Masculin', NULL),
	(20, 'Edward', 'Zwick', '1952-10-08', 'Masculin', NULL),
	(21, 'Brad', 'Pitt', '1963-12-18', 'Masculin', NULL),
	(22, 'Anthony', 'Hopkins', '1937-12-31', 'Masculin', NULL),
	(23, 'David', 'Leitch', '1975-11-16', 'Masculin', NULL),
	(24, 'Quentin', 'Tarantino', '1963-03-27', 'Masculin', NULL);
/*!40000 ALTER TABLE `staff` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
