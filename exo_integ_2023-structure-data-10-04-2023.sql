-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 04, 2023 at 11:21 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `exo_integ_2023`
--

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `id` int(10) UNSIGNED NOT NULL,
  `login` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `login`, `password`) VALUES
(1, 'admin', '$2y$10$.PLLM2z7ZUraSHcaSazj2uA.mXvYVgQlgYxJXYM1nwRxU013GRTfy');

-- --------------------------------------------------------

--
-- Table structure for table `formations`
--

CREATE TABLE `formations` (
  `id_formation` int(11) NOT NULL,
  `intitule` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `formations`
--

INSERT INTO `formations` (`id_formation`, `intitule`) VALUES
(1, 'D\'oh Doctrine'),
(2, 'Mmm... Donuts Basics'),
(3, 'Bart\'s Skateboarding Mastery'),
(4, 'Lisa\'s Saxophone Sessions'),
(5, 'Maggie\'s Silent Strategies'),
(6, 'Moe\'s Mixology Mastery'),
(7, 'Springfield Nuclear Safety'),
(8, 'Groundskeeper Willie’s Gardening'),
(9, 'Mr. Burns Money Making'),
(10, 'Flanders’ Neighborly Know-hows');

-- --------------------------------------------------------

--
-- Table structure for table `historique_visites`
--

CREATE TABLE `historique_visites` (
  `id_visite` int(11) NOT NULL,
  `id_visiteur` int(11) DEFAULT NULL,
  `id_session` int(11) DEFAULT NULL,
  `id_personnel` int(11) DEFAULT NULL,
  `date_entree` datetime DEFAULT current_timestamp(),
  `date_sortie` datetime DEFAULT NULL,
  `objet_visite` enum('visite_personnel','formation') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `historique_visites`
--

INSERT INTO `historique_visites` (`id_visite`, `id_visiteur`, `id_session`, `id_personnel`, `date_entree`, `date_sortie`, `objet_visite`) VALUES
(1, 1, 7, NULL, '2023-09-18 09:00:00', '2023-09-18 16:00:00', 'formation'),
(2, 2, 3, NULL, '2023-09-19 09:00:00', '2023-09-19 16:00:00', 'formation'),
(3, 3, 6, NULL, '2023-09-20 09:00:00', '2023-09-20 16:00:00', 'formation'),
(4, 4, 9, NULL, '2023-09-21 09:00:00', '2023-09-21 16:00:00', 'formation'),
(5, 5, 4, NULL, '2023-09-22 09:00:00', '2023-09-22 16:00:00', 'formation'),
(6, 1, NULL, 3, '2023-09-19 10:00:00', '2023-09-19 11:00:00', 'visite_personnel'),
(7, 2, NULL, 7, '2023-09-20 14:00:00', '2023-09-20 15:00:00', 'visite_personnel'),
(8, 3, NULL, 2, '2023-09-21 10:30:00', '2023-09-21 11:30:00', 'visite_personnel'),
(9, 4, NULL, 9, '2023-09-22 13:00:00', '2023-09-22 14:00:00', 'visite_personnel'),
(10, 5, NULL, 5, '2023-09-23 14:30:00', '2023-09-23 15:30:00', 'visite_personnel'),
(11, 16, 6, NULL, '2023-09-24 23:44:15', '2023-09-27 19:39:13', 'formation'),
(13, 20, 3, NULL, '2023-09-25 01:22:41', NULL, 'formation'),
(14, 21, 9, NULL, '2023-09-25 01:27:06', NULL, 'formation'),
(15, 22, NULL, 4, '2023-09-25 02:14:20', NULL, 'visite_personnel'),
(16, 23, 4, NULL, '2023-09-25 02:17:24', NULL, 'formation'),
(17, 24, NULL, 10, '2023-09-25 02:20:28', '2023-09-28 21:39:03', 'visite_personnel'),
(18, 25, NULL, 9, '2023-09-25 02:22:34', NULL, 'visite_personnel'),
(19, 26, 3, NULL, '2023-09-25 02:27:26', NULL, 'formation'),
(20, 27, 4, NULL, '2023-09-25 02:28:33', NULL, 'formation'),
(21, 28, NULL, 7, '2023-09-25 02:47:07', NULL, 'visite_personnel'),
(22, 29, NULL, 8, '2023-09-25 02:54:57', NULL, 'visite_personnel'),
(23, 30, 2, NULL, '2023-09-25 02:59:24', NULL, 'formation'),
(24, 31, NULL, 2, '2023-09-25 03:02:00', NULL, 'visite_personnel'),
(25, 32, NULL, 5, '2023-09-25 03:05:25', '2023-09-27 20:21:47', 'visite_personnel'),
(26, 33, NULL, 4, '2023-09-25 03:06:29', NULL, 'visite_personnel'),
(27, 34, NULL, 9, '2023-09-25 03:09:21', NULL, 'visite_personnel'),
(28, 35, 6, NULL, '2023-09-25 03:17:51', NULL, 'formation'),
(29, 36, 7, NULL, '2023-09-25 03:26:55', NULL, 'formation'),
(30, 37, NULL, 5, '2023-09-26 20:03:29', '2023-09-27 20:20:01', 'visite_personnel'),
(31, 38, 3, NULL, '2023-09-26 20:09:24', NULL, 'formation'),
(32, 39, NULL, 7, '2023-09-26 20:12:00', NULL, 'visite_personnel'),
(33, 40, 4, NULL, '2023-09-26 20:24:11', '2023-10-03 21:31:20', 'formation'),
(34, 40, 4, NULL, '2023-09-26 20:24:34', '2023-10-03 21:32:05', 'formation'),
(35, 41, 6, NULL, '2023-09-26 20:27:17', NULL, 'formation'),
(36, 42, NULL, 5, '2023-09-26 20:42:17', NULL, 'visite_personnel'),
(37, 43, 6, NULL, '2023-09-26 20:43:14', '2023-09-27 16:43:55', 'formation'),
(38, 43, 1, NULL, '2023-09-27 15:58:44', NULL, 'formation'),
(39, 37, NULL, 5, '2023-09-27 16:15:29', '2023-09-27 20:20:52', 'visite_personnel'),
(40, 37, 8, NULL, '2023-09-27 16:16:44', '2023-09-27 17:12:25', 'formation'),
(47, 45, 4, NULL, '2023-09-27 17:05:39', '2023-09-27 17:06:22', 'formation'),
(48, 46, NULL, 3, '2023-09-27 22:00:37', '2023-09-27 22:06:11', 'visite_personnel'),
(49, 46, 7, NULL, '2023-09-27 22:03:27', '2023-09-27 22:07:57', 'formation'),
(56, 54, 4, NULL, '2023-10-03 19:30:07', NULL, 'formation'),
(57, 55, 7, NULL, '2023-10-03 21:25:51', '2023-10-03 21:28:26', 'formation'),
(58, 55, NULL, 3, '2023-10-03 21:27:42', '2023-10-03 21:29:17', 'visite_personnel');

-- --------------------------------------------------------

--
-- Stand-in structure for view `is_there`
-- (See below for the actual view)
--
CREATE TABLE `is_there` (
`date_entree` datetime
,`date_sortie` datetime
,`objet_visite` enum('visite_personnel','formation')
,`nom` varchar(255)
,`prenom` varchar(255)
,`email` varchar(255)
);

-- --------------------------------------------------------

--
-- Table structure for table `personnel`
--

CREATE TABLE `personnel` (
  `id_personnel` int(11) NOT NULL,
  `nom` varchar(255) NOT NULL,
  `prenom` varchar(255) NOT NULL,
  `fonction` enum('formateur','administration') NOT NULL,
  `local` varchar(255) NOT NULL,
  `tel_interne` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `personnel`
--

INSERT INTO `personnel` (`id_personnel`, `nom`, `prenom`, `fonction`, `local`, `tel_interne`) VALUES
(1, 'Hibbert', 'Julius', 'formateur', 'A', '1101'),
(2, 'Simpson', 'Homer', 'formateur', 'B', '1102'),
(3, 'Simpson', 'Bart', 'formateur', 'Cours de récrée', '1203'),
(4, 'Simpson', 'Lisa', 'formateur', 'D', '1204'),
(5, 'Simpson', 'Maggie', 'administration', 'D', '1105'),
(6, 'Szyslak', 'Moe', 'formateur', 'B', '1206'),
(7, 'Leonard', 'Lenny', 'formateur', 'A', '1107'),
(8, 'MacDougal', 'Willie', 'formateur', 'Cours de récrée', '1108'),
(9, 'Burns', 'Montgomery', 'formateur', 'E', '1109'),
(10, 'Flanders', 'Ned', 'administration', 'E', '1110');

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id_session` int(11) NOT NULL,
  `date_debut` date NOT NULL,
  `date_fin` date NOT NULL,
  `id_formateur` int(11) DEFAULT NULL,
  `id_formation` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id_session`, `date_debut`, `date_fin`, `id_formateur`, `id_formation`) VALUES
(1, '2023-09-18', '2023-10-13', 1, 1),
(2, '2023-09-18', '2023-10-13', 2, 2),
(3, '2023-09-18', '2023-10-13', 3, 3),
(4, '2023-09-18', '2023-10-13', 4, 4),
(5, '2023-09-18', '2023-10-13', 5, 5),
(6, '2023-09-18', '2023-10-13', 6, 6),
(7, '2023-09-18', '2023-10-13', 7, 7),
(8, '2023-09-18', '2023-10-13', 8, 8),
(9, '2023-09-18', '2023-10-13', 9, 9),
(10, '2023-10-02', '2023-10-13', 10, 10);

-- --------------------------------------------------------

--
-- Table structure for table `stagiaires_sessions`
--

CREATE TABLE `stagiaires_sessions` (
  `id_session` int(11) NOT NULL,
  `id_visiteur` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `stagiaires_sessions`
--

INSERT INTO `stagiaires_sessions` (`id_session`, `id_visiteur`) VALUES
(1, 10),
(1, 43),
(2, 8),
(2, 15),
(2, 30),
(3, 2),
(3, 11),
(3, 20),
(3, 26),
(3, 38),
(4, 5),
(4, 23),
(4, 27),
(4, 40),
(4, 45),
(4, 54),
(5, 7),
(5, 14),
(6, 3),
(6, 12),
(6, 16),
(6, 35),
(6, 41),
(6, 43),
(7, 1),
(7, 13),
(7, 36),
(7, 46),
(7, 55),
(8, 6),
(8, 37),
(8, 44),
(9, 4),
(9, 21),
(10, 9);

-- --------------------------------------------------------

--
-- Table structure for table `visiteurs`
--

CREATE TABLE `visiteurs` (
  `id_visiteur` int(11) NOT NULL,
  `nom` varchar(255) NOT NULL,
  `prenom` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `visiteurs`
--

INSERT INTO `visiteurs` (`id_visiteur`, `nom`, `prenom`, `email`) VALUES
(1, 'Wiggum', 'Clancy', 'clancy.wiggum@springfield.com'),
(2, 'Bouvier', 'Selma', 'selma.bouvier@springfield.com'),
(3, 'Bouvier', 'Patty', 'patty.bouvier@springfield.com'),
(4, 'Szyslak', 'Barney', 'barney.szyslak@springfield.com'),
(5, 'Krabappel', 'Edna', 'edna.krabappel@springfield.com'),
(6, 'Nahasapeemapetilon', 'Apu', 'apu.nahasapeemapetilon@springfield.com'),
(7, 'Brockman', 'Kent', 'kent.brockman@springfield.com'),
(8, 'Gumble', 'Barney', 'barney.gumble@springfield.com'),
(9, 'Spuckler', 'Brandine', 'brandine.spuckler@springfield.com'),
(10, 'Terwilliger', 'Robert', 'robert.terwilliger@springfield.com'),
(11, 'Winfield', 'Sarah', 'sarah.winfield@springfield.com'),
(12, 'Ziff', 'Artie', 'artie.ziff@springfield.com'),
(13, 'Skinner', 'Agnes', 'agnes.skinner@springfield.com'),
(14, 'Van Houten', 'Milhouse', 'milhouse.vanhouten@springfield.com'),
(15, 'Prince', 'Martin', 'martin.prince@springfield.com'),
(16, 'Spuckler', 'Cletus', 'cletus.spuckler@springfield.com'),
(20, 'Sheldon', 'Skinner', 'sheldon.skinner@springfield.com'),
(21, 'Herbert', 'Powell', 'herbert.powell@springfield.com'),
(22, 'Coco', 'Powell', 'coco.powell@springfield.com'),
(23, 'Wanda', 'Powell', 'wanda.powell@springfield.com'),
(24, 'Carla', 'Powell', 'carla.powell@springfield.com'),
(25, 'Mililani', 'Powell', 'mililani.powell@springfield.com'),
(26, 'Snake', 'Jailbird', 'snake.jailbird@springfield.com'),
(27, 'Gloria', 'Jailbird', 'gloria.jailbird@springfield.com'),
(28, 'Jeremy', 'Jailbird', 'jeremy.jailbird@springfield.com'),
(29, 'Joey', 'Quimby', 'joey.quimby@springfield.com'),
(30, 'Joe', 'Quimby', 'joe.quimby@springfield.com'),
(31, 'Martha', 'Quimby', 'martha.quimby@springfield.com'),
(32, 'Cookie', 'Kwan', 'cookie.kwan@springfield.com'),
(33, 'Rose', 'Quimby', 'rose.quimby@springfield.com'),
(34, 'Freddy', 'Quimby', 'freddy.quimby@springfield.com'),
(35, 'Onus', 'Quimby', 'onus.quimby@springfield.com'),
(36, 'Jonathan', 'Frink', 'jonathan.frink@springfield.com'),
(37, 'Mirza', 'Hassan', 'hassanmirza@outlook.be'),
(38, 'Koopa', 'Troopa', 'koopa.troopa@springfield.com'),
(39, 'Jimbo', 'Jones', 'jimbo.jones@springfield.com'),
(40, 'Carol', 'Jones', 'carol.jones@springfield.com'),
(41, 'Sancho', 'Hernandes', 'sancho.hernandes@springfield.com'),
(42, 'Pepita', 'Hernandes', 'pepita.hernandes@springfield.com'),
(43, 'Cornelia', 'Hernandes', 'cornelia.hernandes@springfield.com'),
(44, 'Ned', 'Springfield', 'ned.springfield@springfield.com'),
(45, 'Olive', 'Springfield', 'olive.springfield@springfield.com'),
(46, 'Abdul-Ilah', 'Mirza', 'ambaccessory@gmail.com'),
(54, 'Zzyzwicz', 'Kearney', 'kearney.zzyzwicz@springfield.com'),
(55, 'Ziyani Taibi', 'Omar', 'omarziyani58@gmail.com');

-- --------------------------------------------------------

--
-- Stand-in structure for view `visiteur_personnel_info`
-- (See below for the actual view)
--
CREATE TABLE `visiteur_personnel_info` (
`visiteur_prenom` varchar(255)
,`visiteur_nom` varchar(255)
,`id_visiteur` int(11)
,`personnel_prenom` varchar(255)
,`personnel_nom` varchar(255)
,`local` varchar(255)
,`id_visite` int(11)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `visiteur_session_info`
-- (See below for the actual view)
--
CREATE TABLE `visiteur_session_info` (
`visiteur_nom` varchar(255)
,`visiteur_prenom` varchar(255)
,`id_visiteur` int(11)
,`personnel_nom` varchar(255)
,`personnel_prenom` varchar(255)
,`local` varchar(255)
,`intitule` varchar(255)
,`id_session` int(11)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `visite_details`
-- (See below for the actual view)
--
CREATE TABLE `visite_details` (
`nom_visiteur` varchar(255)
,`prenom_visiteur` varchar(255)
,`email` varchar(255)
,`entree` datetime
,`sortie` datetime
,`objet` enum('visite_personnel','formation')
,`nom_personnel` varchar(255)
,`prenom_personnel` varchar(255)
);

-- --------------------------------------------------------

--
-- Structure for view `is_there`
--
DROP TABLE IF EXISTS `is_there`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `is_there`  AS SELECT DISTINCT `hv`.`date_entree` AS `date_entree`, `hv`.`date_sortie` AS `date_sortie`, `hv`.`objet_visite` AS `objet_visite`, `v`.`nom` AS `nom`, `v`.`prenom` AS `prenom`, `v`.`email` AS `email` FROM (`historique_visites` `hv` join `visiteurs` `v` on(`v`.`id_visiteur` = `hv`.`id_visiteur`)) WHERE `hv`.`date_sortie` is null GROUP BY `v`.`nom`, `v`.`prenom` ;

-- --------------------------------------------------------

--
-- Structure for view `visiteur_personnel_info`
--
DROP TABLE IF EXISTS `visiteur_personnel_info`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `visiteur_personnel_info`  AS SELECT `v`.`prenom` AS `visiteur_prenom`, `v`.`nom` AS `visiteur_nom`, `v`.`id_visiteur` AS `id_visiteur`, `p`.`prenom` AS `personnel_prenom`, `p`.`nom` AS `personnel_nom`, `p`.`local` AS `local`, `hv`.`id_visite` AS `id_visite` FROM ((`visiteurs` `v` join `historique_visites` `hv` on(`v`.`id_visiteur` = `hv`.`id_visiteur`)) join `personnel` `p` on(`hv`.`id_personnel` = `p`.`id_personnel`)) ;

-- --------------------------------------------------------

--
-- Structure for view `visiteur_session_info`
--
DROP TABLE IF EXISTS `visiteur_session_info`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `visiteur_session_info`  AS SELECT `v`.`nom` AS `visiteur_nom`, `v`.`prenom` AS `visiteur_prenom`, `v`.`id_visiteur` AS `id_visiteur`, `p`.`nom` AS `personnel_nom`, `p`.`prenom` AS `personnel_prenom`, `p`.`local` AS `local`, `f`.`intitule` AS `intitule`, `s`.`id_session` AS `id_session` FROM ((((`visiteurs` `v` join `stagiaires_sessions` `ss` on(`v`.`id_visiteur` = `ss`.`id_visiteur`)) join `sessions` `s` on(`ss`.`id_session` = `s`.`id_session`)) join `personnel` `p` on(`s`.`id_formateur` = `p`.`id_personnel`)) join `formations` `f` on(`s`.`id_formation` = `f`.`id_formation`)) ;

-- --------------------------------------------------------

--
-- Structure for view `visite_details`
--
DROP TABLE IF EXISTS `visite_details`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `visite_details`  AS SELECT `v`.`nom` AS `nom_visiteur`, `v`.`prenom` AS `prenom_visiteur`, `v`.`email` AS `email`, `hv`.`date_entree` AS `entree`, `hv`.`date_sortie` AS `sortie`, `hv`.`objet_visite` AS `objet`, `p`.`nom` AS `nom_personnel`, `p`.`prenom` AS `prenom_personnel` FROM ((`historique_visites` `hv` join `visiteurs` `v` on(`hv`.`id_visiteur` = `v`.`id_visiteur`)) join `personnel` `p` on(`hv`.`id_personnel` = `p`.`id_personnel`)) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `formations`
--
ALTER TABLE `formations`
  ADD PRIMARY KEY (`id_formation`);

--
-- Indexes for table `historique_visites`
--
ALTER TABLE `historique_visites`
  ADD PRIMARY KEY (`id_visite`),
  ADD KEY `fk_hv_visiteur` (`id_visiteur`),
  ADD KEY `fk_hv_session` (`id_session`),
  ADD KEY `fk_hv_personnel` (`id_personnel`);

--
-- Indexes for table `personnel`
--
ALTER TABLE `personnel`
  ADD PRIMARY KEY (`id_personnel`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id_session`),
  ADD KEY `fk_sessions_formation` (`id_formation`),
  ADD KEY `fk_sessions_formateur` (`id_formateur`);

--
-- Indexes for table `stagiaires_sessions`
--
ALTER TABLE `stagiaires_sessions`
  ADD PRIMARY KEY (`id_session`,`id_visiteur`),
  ADD KEY `fk_ss_visiteur` (`id_visiteur`);

--
-- Indexes for table `visiteurs`
--
ALTER TABLE `visiteurs`
  ADD PRIMARY KEY (`id_visiteur`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `formations`
--
ALTER TABLE `formations`
  MODIFY `id_formation` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `historique_visites`
--
ALTER TABLE `historique_visites`
  MODIFY `id_visite` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=59;

--
-- AUTO_INCREMENT for table `personnel`
--
ALTER TABLE `personnel`
  MODIFY `id_personnel` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `sessions`
--
ALTER TABLE `sessions`
  MODIFY `id_session` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `visiteurs`
--
ALTER TABLE `visiteurs`
  MODIFY `id_visiteur` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `historique_visites`
--
ALTER TABLE `historique_visites`
  ADD CONSTRAINT `fk_hv_personnel` FOREIGN KEY (`id_personnel`) REFERENCES `personnel` (`id_personnel`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_hv_session` FOREIGN KEY (`id_session`) REFERENCES `sessions` (`id_session`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_hv_visiteur` FOREIGN KEY (`id_visiteur`) REFERENCES `visiteurs` (`id_visiteur`) ON UPDATE CASCADE;

--
-- Constraints for table `sessions`
--
ALTER TABLE `sessions`
  ADD CONSTRAINT `fk_sessions_formateur` FOREIGN KEY (`id_formateur`) REFERENCES `personnel` (`id_personnel`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_sessions_formation` FOREIGN KEY (`id_formation`) REFERENCES `formations` (`id_formation`) ON UPDATE CASCADE;

--
-- Constraints for table `stagiaires_sessions`
--
ALTER TABLE `stagiaires_sessions`
  ADD CONSTRAINT `fk_ss_session` FOREIGN KEY (`id_session`) REFERENCES `sessions` (`id_session`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_ss_visiteur` FOREIGN KEY (`id_visiteur`) REFERENCES `visiteurs` (`id_visiteur`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
