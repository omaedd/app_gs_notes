-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 11, 2022 at 05:31 PM
-- Server version: 10.4.18-MariaDB
-- PHP Version: 7.3.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `gs_notes_app`
--

-- --------------------------------------------------------

--
-- Table structure for table `cadreadministrateur`
--

CREATE TABLE `cadreadministrateur` (
  `grade` varchar(255) DEFAULT NULL,
  `idCardreAdmin` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `cadreadministrateur`
--

INSERT INTO `cadreadministrateur` (`grade`, `idCardreAdmin`) VALUES
('gradeeee', 8);

-- --------------------------------------------------------

--
-- Table structure for table `compte`
--

CREATE TABLE `compte` (
  `idCompte` bigint(20) NOT NULL,
  `accepteDemandeAutorisationAbsence` bit(1) NOT NULL,
  `accountNonExpired` bit(1) NOT NULL,
  `accountNonLocked` bit(1) NOT NULL,
  `afficheEmail` bit(1) NOT NULL,
  `affichePhoto` bit(1) NOT NULL,
  `credentialsNonExpired` bit(1) NOT NULL,
  `disconnectAccount` bit(1) NOT NULL,
  `enabled` bit(1) NOT NULL,
  `login` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `idUtilisateur` bigint(20) DEFAULT NULL,
  `idRole` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `compte`
--

INSERT INTO `compte` (`idCompte`, `accepteDemandeAutorisationAbsence`, `accountNonExpired`, `accountNonLocked`, `afficheEmail`, `affichePhoto`, `credentialsNonExpired`, `disconnectAccount`, `enabled`, `login`, `password`, `idUtilisateur`, `idRole`) VALUES
(8, b'0', b'1', b'1', b'0', b'0', b'1', b'0', b'1', 'admin', '$2a$10$f8JD2gC/aTag.TLHUDIUceELgs5yjsVX3VIntTUMasjzV5mon6/he', 8, 1),
(9, b'0', b'1', b'1', b'0', b'0', b'1', b'0', b'1', 'prof', '$2a$10$f8JD2gC/aTag.TLHUDIUceELgs5yjsVX3VIntTUMasjzV5mon6/he', 9, 2),
(12, b'0', b'1', b'1', b'0', b'0', b'1', b'0', b'1', 'student', '$2a$10$f8JD2gC/aTag.TLHUDIUceELgs5yjsVX3VIntTUMasjzV5mon6/he', 11, 4),
(13, b'0', b'1', b'1', b'0', b'0', b'1', b'0', b'1', 'cadre_admin', '$2a$10$f8JD2gC/aTag.TLHUDIUceELgs5yjsVX3VIntTUMasjzV5mon6/he', 11, 3),
(15, b'0', b'1', b'1', b'0', b'0', b'1', b'0', b'1', 'BOUDAATarik', '$2a$10$f8JD2gC/aTag.TLHUDIUceELgs5yjsVX3VIntTUMasjzV5mon6/he', 8, 2),
(16, b'0', b'1', b'1', b'0', b'0', b'1', b'0', b'1', 'BOUDAATarik_0', '$2a$10$f8JD2gC/aTag.TLHUDIUceELgs5yjsVX3VIntTUMasjzV5mon6/he', 8, 5),
(17, b'0', b'1', b'1', b'0', b'0', b'1', b'0', b'1', 'BOUDAATarik_1', '$2a$10$1FcRNwjCBvrLw3eBKmgjDeNhgTBm.UVlXgfaCeTRR8/2g.Bp5B/tu', 8, 1);

-- --------------------------------------------------------

--
-- Table structure for table `element`
--

CREATE TABLE `element` (
  `idMatiere` bigint(20) NOT NULL,
  `code` varchar(255) DEFAULT NULL,
  `currentCoefficient` double NOT NULL,
  `nom` varchar(255) DEFAULT NULL,
  `idModule` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `element`
--

INSERT INTO `element` (`idMatiere`, `code`, `currentCoefficient`, `nom`, `idModule`) VALUES
(1, 'vs', 0, 'veille strategique ', 8),
(2, 'dm', 0, 'data mining', 8),
(3, 'erp', 0, 'entreprise resources planning', 8),
(6, 'mg', 0, 'management', 7),
(8, 'cpt', 0, 'comptabilité', 7),
(11, 'jee', 0, 'Frameworks Java EE avancés', 1),
(12, '.net', 0, '.NET', 1),
(13, 'mkt', 0, 'marketing', 6),
(14, 'cg', 0, 'contrôle de gestion', 6),
(15, 'gl', 0, 'génie logiciel', 4),
(16, 'gp', 0, 'gestion de projet', 4),
(17, 'ml', 0, 'Machine Learning', 3),
(18, 'web', 0, 'Web1 : Technologies de Web et PHP5', 2),
(19, 'js', 0, 'Web 2 : Applications Web modernes', 9),
(20, 'se', 0, 'Système embarqué et temps réel', 10);

-- --------------------------------------------------------

--
-- Table structure for table `enseignant`
--

CREATE TABLE `enseignant` (
  `specialite` varchar(255) DEFAULT NULL,
  `idEnseighant` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `enseignant`
--

INSERT INTO `enseignant` (`specialite`, `idEnseighant`) VALUES
('math', 10);

-- --------------------------------------------------------

--
-- Table structure for table `etudiant`
--

CREATE TABLE `etudiant` (
  `cne` varchar(255) DEFAULT NULL,
  `dateNaissance` datetime(6) DEFAULT NULL,
  `idEtudiant` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `etudiant`
--

INSERT INTO `etudiant` (`cne`, `dateNaissance`, `idEtudiant`) VALUES
('d111', NULL, 8),
('aaaa', NULL, 9),
('bbbb', NULL, 11),
('zzz', NULL, 12),
('ssss', NULL, 13),
('s111', NULL, 14),
('s222', NULL, 15),
('s333', NULL, 16);

-- --------------------------------------------------------

--
-- Table structure for table `filiere`
--

CREATE TABLE `filiere` (
  `idFiliere` bigint(20) NOT NULL,
  `anneeFinaccreditation` int(11) NOT NULL,
  `anneeaccreditation` int(11) NOT NULL,
  `codeFiliere` varchar(255) DEFAULT NULL,
  `titreFiliere` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `filiere`
--

INSERT INTO `filiere` (`idFiliere`, `anneeFinaccreditation`, `anneeaccreditation`, `codeFiliere`, `titreFiliere`) VALUES
(1, 2030, 2008, 'GI', 'Génie informatique');

-- --------------------------------------------------------

--
-- Table structure for table `inscriptionannuelle`
--

CREATE TABLE `inscriptionannuelle` (
  `idInscription` bigint(20) NOT NULL,
  `annee` int(11) NOT NULL,
  `etat` int(11) NOT NULL,
  `mention` varchar(255) DEFAULT NULL,
  `plusInfos` varchar(255) DEFAULT NULL,
  `rang` int(11) NOT NULL,
  `type` varchar(255) DEFAULT NULL,
  `validation` varchar(255) DEFAULT NULL,
  `idEtudiant` bigint(20) DEFAULT NULL,
  `idNiveau` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `inscriptionannuelle`
--

INSERT INTO `inscriptionannuelle` (`idInscription`, `annee`, `etat`, `mention`, `plusInfos`, `rang`, `type`, `validation`, `idEtudiant`, `idNiveau`) VALUES
(2, 2022, 0, NULL, NULL, 0, NULL, NULL, 14, 1),
(3, 2022, 0, NULL, NULL, 0, NULL, NULL, 9, 2),
(7, 2022, 0, NULL, NULL, 0, NULL, NULL, 15, 2),
(8, 2022, 0, NULL, NULL, 0, NULL, NULL, 11, 3),
(11, 2022, 0, NULL, NULL, 0, NULL, NULL, 13, 1),
(12, 2022, 0, NULL, NULL, 0, NULL, NULL, 8, 1),
(13, 2022, 0, NULL, NULL, 0, NULL, NULL, 16, 2),
(14, 2022, 0, NULL, NULL, 0, NULL, NULL, 12, 3);

-- --------------------------------------------------------

--
-- Table structure for table `inscriptionmatiere`
--

CREATE TABLE `inscriptionmatiere` (
  `idInscriptionMatiere` bigint(20) NOT NULL,
  `coefficient` double NOT NULL,
  `noteFinale` double NOT NULL,
  `noteSN` double NOT NULL,
  `noteSR` double NOT NULL,
  `plusInfos` varchar(255) DEFAULT NULL,
  `validation` varchar(255) DEFAULT NULL,
  `idInscription` bigint(20) DEFAULT NULL,
  `idMatiere` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `inscriptionmatiere`
--

INSERT INTO `inscriptionmatiere` (`idInscriptionMatiere`, `coefficient`, `noteFinale`, `noteSN`, `noteSR`, `plusInfos`, `validation`, `idInscription`, `idMatiere`) VALUES
(1, 0, 14, 0, 0, NULL, NULL, 8, 3),
(2, 0, 12, 0, 0, NULL, NULL, 8, 2),
(3, 0, 16, 0, 0, NULL, NULL, 8, 1),
(4, 0, 10, 0, 0, NULL, NULL, 14, 2),
(5, 0, 12, 0, 0, NULL, NULL, 14, 3),
(6, 0, 11, 0, 0, NULL, NULL, 14, 1),
(8, 0, 15, 0, 0, NULL, NULL, 8, 20),
(11, 0, 0, 0, 0, NULL, NULL, 14, 20),
(17, 0, 12, 0, 0, NULL, NULL, 2, 6),
(18, 0, 15, 0, 0, NULL, NULL, 2, 8),
(19, 0, 12, 0, 0, NULL, NULL, 11, 6),
(20, 0, 17, 0, 0, NULL, NULL, 11, 8),
(21, 0, 10, 0, 0, NULL, NULL, 12, 6),
(22, 0, 10, 0, 0, NULL, NULL, 12, 8),
(23, 0, 14, 0, 0, NULL, NULL, 3, 15),
(24, 0, 18, 0, 0, NULL, NULL, 3, 16),
(25, 0, 12, 0, 0, NULL, NULL, 7, 15),
(26, 0, 12, 0, 0, NULL, NULL, 7, 16),
(27, 0, 12, 0, 0, NULL, NULL, 13, 15),
(28, 0, 12, 0, 0, NULL, NULL, 13, 16),
(29, 0, 17, 0, 0, NULL, NULL, 3, 17),
(30, 0, 15, 0, 0, NULL, NULL, 7, 17),
(31, 0, 10, 0, 0, NULL, NULL, 13, 17),
(32, 0, 15, 0, 0, NULL, NULL, 3, 19),
(33, 0, 14, 0, 0, NULL, NULL, 7, 19),
(34, 0, 12, 0, 0, NULL, NULL, 13, 19),
(35, 0, 16, 0, 0, NULL, NULL, 2, 18),
(36, 0, 14, 0, 0, NULL, NULL, 11, 18),
(37, 0, 12, 0, 0, NULL, NULL, 12, 18),
(40, 0, 14, 0, 0, NULL, NULL, 3, 11),
(41, 0, 12, 0, 0, NULL, NULL, 3, 12),
(42, 0, 15, 0, 0, NULL, NULL, 7, 11),
(43, 0, 12, 0, 0, NULL, NULL, 7, 12),
(44, 0, 11, 0, 0, NULL, NULL, 13, 11),
(45, 0, 14, 0, 0, NULL, NULL, 13, 12),
(46, 0, 17, 0, 0, NULL, NULL, 3, 13),
(47, 0, 13, 0, 0, NULL, NULL, 3, 14),
(48, 0, 14, 0, 0, NULL, NULL, 7, 13),
(49, 0, 14, 0, 0, NULL, NULL, 7, 14),
(50, 0, 11, 0, 0, NULL, NULL, 13, 13),
(51, 0, 10, 0, 0, NULL, NULL, 13, 14);

-- --------------------------------------------------------

--
-- Table structure for table `inscriptionmodule`
--

CREATE TABLE `inscriptionmodule` (
  `idInscriptionModule` bigint(20) NOT NULL,
  `noteFinale` double NOT NULL,
  `noteSN` double NOT NULL,
  `noteSR` double NOT NULL,
  `plusInfos` varchar(255) DEFAULT NULL,
  `validation` varchar(255) DEFAULT NULL,
  `idInscription` bigint(20) DEFAULT NULL,
  `idModule` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `module`
--

CREATE TABLE `module` (
  `idModule` bigint(20) NOT NULL,
  `code` varchar(255) DEFAULT NULL,
  `titre` varchar(255) DEFAULT NULL,
  `idNiveau` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `module`
--

INSERT INTO `module` (`idModule`, `code`, `titre`, `idNiveau`) VALUES
(1, 'jee&.net', 'Frameworks Java EE avancés et .Net', 2),
(2, 'web', 'Web1 : Technologies de Web et PHP5', 1),
(3, 'ml', 'Machine Learning', 2),
(4, 'gl&gp', 'génie logicielet Gestion de projet', 2),
(6, 'ent2', 'Entreprenariat 2', 2),
(7, 'ent1', 'Entreprenariat 1', 1),
(8, 'dm', 'Data Mining', 3),
(9, 'js', 'Web 2 : Applications Web modernes', 2),
(10, 'se', 'Système embarqué et temps réel', 3);

-- --------------------------------------------------------

--
-- Table structure for table `niveau`
--

CREATE TABLE `niveau` (
  `idNiveau` bigint(20) NOT NULL,
  `alias` varchar(255) DEFAULT NULL,
  `titre` varchar(255) DEFAULT NULL,
  `idFiliere` bigint(20) DEFAULT NULL,
  `niveauSuivant` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `niveau`
--

INSERT INTO `niveau` (`idNiveau`, `alias`, `titre`, `idFiliere`, `niveauSuivant`) VALUES
(1, 'GI1', 'Génie informatique 1', 1, 2),
(2, 'GI2', 'Génie informatique 2', 1, 3),
(3, 'GI3', 'Génie informatique 3', 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `role`
--

CREATE TABLE `role` (
  `idRole` bigint(20) NOT NULL,
  `nomRole` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `role`
--

INSERT INTO `role` (`idRole`, `nomRole`) VALUES
(1, 'ROLE_ADMIN'),
(2, 'ROLE_PROF'),
(3, 'ROLE_CADRE_ADMIN'),
(4, 'ROLE_STUDENT'),
(5, 'ROLE_BIBLIO');

-- --------------------------------------------------------

--
-- Table structure for table `utilisateur`
--

CREATE TABLE `utilisateur` (
  `idUtilisateur` bigint(20) NOT NULL,
  `cin` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `nom` varchar(255) DEFAULT NULL,
  `nomArabe` varchar(255) DEFAULT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `prenom` varchar(255) DEFAULT NULL,
  `prenomArabe` varchar(255) DEFAULT NULL,
  `telephone` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `utilisateur`
--

INSERT INTO `utilisateur` (`idUtilisateur`, `cin`, `email`, `nom`, `nomArabe`, `photo`, `prenom`, `prenomArabe`, `telephone`) VALUES
(8, 'rb000', 'tarik@tarik.fr', 'BOUDAA', 'Tarik', NULL, 'Tarik', 'Boudaa', '060000000'),
(9, 'rb111', 'med1@med.com', 'BOUDAA', 'med', NULL, 'Mohamed', 'med', '2522255'),
(10, 'rb222', 'hmd@hmd.com', 'EDDARRAJI', 'EDDARRAJI', NULL, 'Hamid', 'Hamid', '222222'),
(11, 'rb333', 'om@om.fr', 'EDDARRAJI', 'EDDARRAJI', NULL, 'Omaima', 'Omaima', '333333'),
(12, 'rb444', 'sfe@sfe.fr', 'ETTAJRINI', 'ETTAJRINI', NULL, 'Safae', 'Safae', '444444'),
(13, 'rb555', 'oo@oo.o', 'OULJI', 'OULJI', NULL, 'Manal', 'Manal', '555555'),
(14, 'rb666', 'hmt@hmt.fr', 'HAMOUTI', 'HAMOUTI', NULL, 'Silia', 'Silia', '060000'),
(15, 'rb777', 'alm@alm.com', 'ALAMI', 'ALAMI', NULL, 'Amin', 'Amin', '888888'),
(16, 'rb888', 'imn@imn.fr', 'SOULLAMI', 'SOULLAMI', NULL, 'Imane', 'Imane', '055555');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cadreadministrateur`
--
ALTER TABLE `cadreadministrateur`
  ADD PRIMARY KEY (`idCardreAdmin`);

--
-- Indexes for table `compte`
--
ALTER TABLE `compte`
  ADD PRIMARY KEY (`idCompte`),
  ADD KEY `FK4me3b7yms83bsk757qlkk5icm` (`idUtilisateur`),
  ADD KEY `FK6rqvo0g5sv97xlbrragf5rwn3` (`idRole`);

--
-- Indexes for table `element`
--
ALTER TABLE `element`
  ADD PRIMARY KEY (`idMatiere`),
  ADD KEY `FKpy7uud3qt1x365dnkff4f41l8` (`idModule`);

--
-- Indexes for table `enseignant`
--
ALTER TABLE `enseignant`
  ADD PRIMARY KEY (`idEnseighant`);

--
-- Indexes for table `etudiant`
--
ALTER TABLE `etudiant`
  ADD PRIMARY KEY (`idEtudiant`);

--
-- Indexes for table `filiere`
--
ALTER TABLE `filiere`
  ADD PRIMARY KEY (`idFiliere`);

--
-- Indexes for table `inscriptionannuelle`
--
ALTER TABLE `inscriptionannuelle`
  ADD PRIMARY KEY (`idInscription`),
  ADD KEY `FKge2xwqtfeqnojw9no8og6vbqn` (`idEtudiant`),
  ADD KEY `FK9lrdmhkam481adiwotdpqo8w` (`idNiveau`);

--
-- Indexes for table `inscriptionmatiere`
--
ALTER TABLE `inscriptionmatiere`
  ADD PRIMARY KEY (`idInscriptionMatiere`),
  ADD KEY `FKdrefbosgrrf561bghbosk681q` (`idInscription`),
  ADD KEY `FK6om7ooil7qy2ipbtocv7hqrwo` (`idMatiere`);

--
-- Indexes for table `inscriptionmodule`
--
ALTER TABLE `inscriptionmodule`
  ADD PRIMARY KEY (`idInscriptionModule`),
  ADD KEY `FK2rp4wu9gg4s1yvbannj858m3c` (`idInscription`),
  ADD KEY `FKsfog581rh033dgomu0u7xywgd` (`idModule`);

--
-- Indexes for table `module`
--
ALTER TABLE `module`
  ADD PRIMARY KEY (`idModule`),
  ADD KEY `FK2kgd6okkiatvq3do7akj1cm2k` (`idNiveau`);

--
-- Indexes for table `niveau`
--
ALTER TABLE `niveau`
  ADD PRIMARY KEY (`idNiveau`),
  ADD KEY `FK9qvkxk4ayqkjopclmlgoel8d9` (`idFiliere`),
  ADD KEY `FKfrb2mq89h77nivboif8tdqwtn` (`niveauSuivant`);

--
-- Indexes for table `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`idRole`);

--
-- Indexes for table `utilisateur`
--
ALTER TABLE `utilisateur`
  ADD PRIMARY KEY (`idUtilisateur`),
  ADD UNIQUE KEY `UK_s4m395xkorrxtrdbuk1upglup` (`cin`),
  ADD UNIQUE KEY `UK_35ysk0sh9ruwixrld3nc0weut` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `compte`
--
ALTER TABLE `compte`
  MODIFY `idCompte` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `element`
--
ALTER TABLE `element`
  MODIFY `idMatiere` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `filiere`
--
ALTER TABLE `filiere`
  MODIFY `idFiliere` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `inscriptionannuelle`
--
ALTER TABLE `inscriptionannuelle`
  MODIFY `idInscription` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `inscriptionmatiere`
--
ALTER TABLE `inscriptionmatiere`
  MODIFY `idInscriptionMatiere` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT for table `inscriptionmodule`
--
ALTER TABLE `inscriptionmodule`
  MODIFY `idInscriptionModule` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `module`
--
ALTER TABLE `module`
  MODIFY `idModule` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `niveau`
--
ALTER TABLE `niveau`
  MODIFY `idNiveau` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `role`
--
ALTER TABLE `role`
  MODIFY `idRole` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cadreadministrateur`
--
ALTER TABLE `cadreadministrateur`
  ADD CONSTRAINT `FKq2jdlid8esk1jlagny4qhrh2k` FOREIGN KEY (`idCardreAdmin`) REFERENCES `utilisateur` (`idUtilisateur`);

--
-- Constraints for table `compte`
--
ALTER TABLE `compte`
  ADD CONSTRAINT `FK4me3b7yms83bsk757qlkk5icm` FOREIGN KEY (`idUtilisateur`) REFERENCES `utilisateur` (`idUtilisateur`),
  ADD CONSTRAINT `FK6rqvo0g5sv97xlbrragf5rwn3` FOREIGN KEY (`idRole`) REFERENCES `role` (`idRole`);

--
-- Constraints for table `element`
--
ALTER TABLE `element`
  ADD CONSTRAINT `FKpy7uud3qt1x365dnkff4f41l8` FOREIGN KEY (`idModule`) REFERENCES `module` (`idModule`);

--
-- Constraints for table `enseignant`
--
ALTER TABLE `enseignant`
  ADD CONSTRAINT `FKk26kuxt8qhs6nqv41b2hiyqwb` FOREIGN KEY (`idEnseighant`) REFERENCES `utilisateur` (`idUtilisateur`);

--
-- Constraints for table `etudiant`
--
ALTER TABLE `etudiant`
  ADD CONSTRAINT `FKkku0boly4both705vo0fri81c` FOREIGN KEY (`idEtudiant`) REFERENCES `utilisateur` (`idUtilisateur`);

--
-- Constraints for table `inscriptionannuelle`
--
ALTER TABLE `inscriptionannuelle`
  ADD CONSTRAINT `FK9lrdmhkam481adiwotdpqo8w` FOREIGN KEY (`idNiveau`) REFERENCES `niveau` (`idNiveau`),
  ADD CONSTRAINT `FKge2xwqtfeqnojw9no8og6vbqn` FOREIGN KEY (`idEtudiant`) REFERENCES `etudiant` (`idEtudiant`);

--
-- Constraints for table `inscriptionmatiere`
--
ALTER TABLE `inscriptionmatiere`
  ADD CONSTRAINT `FK6om7ooil7qy2ipbtocv7hqrwo` FOREIGN KEY (`idMatiere`) REFERENCES `element` (`idMatiere`),
  ADD CONSTRAINT `FKdrefbosgrrf561bghbosk681q` FOREIGN KEY (`idInscription`) REFERENCES `inscriptionannuelle` (`idInscription`);

--
-- Constraints for table `inscriptionmodule`
--
ALTER TABLE `inscriptionmodule`
  ADD CONSTRAINT `FK2rp4wu9gg4s1yvbannj858m3c` FOREIGN KEY (`idInscription`) REFERENCES `inscriptionannuelle` (`idInscription`),
  ADD CONSTRAINT `FKsfog581rh033dgomu0u7xywgd` FOREIGN KEY (`idModule`) REFERENCES `module` (`idModule`);

--
-- Constraints for table `module`
--
ALTER TABLE `module`
  ADD CONSTRAINT `FK2kgd6okkiatvq3do7akj1cm2k` FOREIGN KEY (`idNiveau`) REFERENCES `niveau` (`idNiveau`);

--
-- Constraints for table `niveau`
--
ALTER TABLE `niveau`
  ADD CONSTRAINT `FK9qvkxk4ayqkjopclmlgoel8d9` FOREIGN KEY (`idFiliere`) REFERENCES `filiere` (`idFiliere`),
  ADD CONSTRAINT `FKfrb2mq89h77nivboif8tdqwtn` FOREIGN KEY (`niveauSuivant`) REFERENCES `niveau` (`idNiveau`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
