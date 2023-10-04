-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 24, 2023 at 11:42 PM
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
(6, 'Moe\'s Mixology Classes'),
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
(10, 5, NULL, 5, '2023-09-23 14:30:00', '2023-09-23 15:30:00', 'visite_personnel');

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
(3, 'Simpson', 'Bart', 'formateur', 'Cours de récrée', '1103'),
(4, 'Simpson', 'Lisa', 'formateur', 'D', '1104'),
(5, 'Simpson', 'Maggie', 'formateur', 'D', '1105'),
(6, 'Szyslak', 'Moe', 'formateur', 'B', '1106'),
(7, 'Leonard', 'Lenny', 'formateur', 'A', '1107'),
(8, 'MacDougal', 'Willie', 'formateur', 'Cours de récrée', '1108'),
(9, 'Burns', 'Montgomery', 'formateur', 'E', '1109'),
(10, 'Flanders', 'Ned', 'formateur', 'E', '1110');

-- --------------------------------------------------------

--
-- Stand-in structure for view `select visiteurs_sessions`
-- (See below for the actual view)
--
CREATE TABLE `select visiteurs_sessions` (
);

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
(1, '2023-09-18', '2023-09-29', 1, 1),
(2, '2023-09-18', '2023-09-29', 2, 2),
(3, '2023-09-18', '2023-09-29', 3, 3),
(4, '2023-09-18', '2023-09-29', 4, 4),
(5, '2023-09-18', '2023-09-29', 5, 5),
(6, '2023-09-18', '2023-09-29', 6, 6),
(7, '2023-09-18', '2023-09-29', 7, 7),
(8, '2023-09-18', '2023-09-29', 8, 8),
(9, '2023-09-18', '2023-09-29', 9, 9),
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
(2, 8),
(2, 15),
(3, 2),
(3, 11),
(4, 5),
(5, 7),
(5, 14),
(6, 3),
(6, 12),
(7, 1),
(7, 13),
(8, 6),
(9, 4),
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
(14, 'Houten', 'Milhouse Van', 'milhouse.vanhouten@springfield.com'),
(15, 'Prince', 'Martin', 'martin.prince@springfield.com');

-- --------------------------------------------------------

--
-- Structure for view `select visiteurs_sessions`
--
DROP TABLE IF EXISTS `select visiteurs_sessions`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `select visiteurs_sessions`  AS SELECT `visiteurs`.`id_visiteur` AS `id_visiteur`, `visiteurs`.`nom` AS `nom`, `visiteurs`.`prenom` AS `prenom`, `visiteurs`.`email` AS `email`, `sessions`.`id_session` AS `id_session`, `sessions`.`date_debut` AS `date_debut`, `sessions`.`date_fin` AS `date_fin`, `sessions`.`local` AS `local`, `sessions`.`id_formateur` AS `id_formateur`, `sessions`.`id_formation` AS `id_formation` FROM ((`stagiaires_sessions` join `visiteurs` on(`stagiaires_sessions`.`id_visiteur` = `visiteurs`.`id_visiteur`)) join `sessions` on(`stagiaires_sessions`.`id_session` = `sessions`.`id_session`)) ;

--
-- Indexes for dumped tables
--

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
-- AUTO_INCREMENT for table `formations`
--
ALTER TABLE `formations`
  MODIFY `id_formation` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `historique_visites`
--
ALTER TABLE `historique_visites`
  MODIFY `id_visite` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

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
  MODIFY `id_visiteur` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

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
