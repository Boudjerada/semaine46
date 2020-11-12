SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `OTO`
--

-- --------------------------------------------------------
--
-- Structure de la table `salarie`
--

DROP TABLE IF EXISTS `salarie`;
CREATE TABLE IF NOT EXISTS `salarie`(
  `sal_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Clé de la table salarié',
  `com_nom` varchar(30) NOT NULL COMMENT 'Nom du salarié',
  `com_prenom` varchar(20) NOT NULL COMMENT 'Prénom du salarié',
  `com_tel` int(10) COMMENT 'Téléphone du salarié',
  `sal_adr` varchar(200) NOT NULL COMMENT 'Adresse du salarié',
  `sal_mail` varchar(100) COMMENT 'Adresse mail du salarie',
  `sal_d_naiss` date COMMENT  'Date de naissance du salarié',
  `sal_status` varchar(15) COMMENT 'Status du salarié',
  PRIMARY KEY (`sal_id`)
  );

-- --------------------------------------------------------
--
-- Structure de la table `client`
--

DROP TABLE IF EXISTS `client`;
CREATE TABLE IF NOT EXISTS `client`(
  `cli_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Clé de la table client',
  `cli_nom` varchar(50) NOT NULL COMMENT 'Nom ou raison social du client',
  `cli_prenom` varchar(20) COMMENT 'Prénom du client',
  `cli_adresse` varchar(250) NOT NULL COMMENT 'Adresse du client',
  `cli_d_naiss` date NOT NULL COMMENT 'Date de naissance du client',
  `cli_tel` int(10) COMMENT 'Téléphone du client',
  `cli_mail` varchar(100) COMMENT 'Adresse mail du client',
  `cli_status` varchar(20) COMMENT 'Status du client',
  PRIMARY KEY (`cli_id`)
  );

-- --------------------------------------------------------
--
-- Structure de la table `accesoire`
--

DROP TABLE IF EXISTS `accesoire`;
CREATE TABLE IF NOT EXISTS `accesoire`(
  `acce_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Clé de la table accesoire',
  `acce_nom` varchar(50) NOT NULL COMMENT 'Nom accesoire',
  `acce_prix` decimal(7,2) NOT NULL COMMENT 'Prix accesoire',
  `acce_ref` varchar(100) NOT NULL COMMENT 'Description accesoire',
  PRIMARY KEY (`acce_id`),
  UNIQUE KEY `idx_acce_ref` (`acce_ref`)
  );

-- --------------------------------------------------------
--
-- Structure de la table `marque`
--

DROP TABLE IF EXISTS `marque`;
CREATE TABLE IF NOT EXISTS `marque`(
  `marq_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Clé de la table marque',
  `marq_nom` VARCHAR(20) NOT NULL COMMENT 'Nom de la marque',
  PRIMARY KEY (`marq_id`)
);

-- --------------------------------------------------------
--
-- Structure de la table `service`
--

DROP TABLE IF EXISTS `service`;
CREATE TABLE IF NOT EXISTS `service`(
  `serv_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Clé de la table service',
  `serv_nom` VARCHAR(20) NOT NULL COMMENT 'Nom du service',
  `serv_prix` decimal(6,2) NOT NULL COMMENT 'Prix du service',
  PRIMARY KEY (`serv_id`)
);






-- --------------------------------------------------------
--
-- Structure de la table `commande`
--

DROP TABLE IF EXISTS `commande`;
CREATE TABLE IF NOT EXISTS `commande`(
    `com_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Clé de la table commande',
    `com_d_achat` date NOT NULL COMMENT 'Date achat',
    `com_paie` varchar (10) NOT NULL COMMENT 'Moyen de paiement',
    `com_cli_id` int(10) NOT NULL COMMENT 'Identifiant du client',
    `com_sal_id` int(10) NOT NULL COMMENT 'Identifiant du salarié',
    PRIMARY KEY (`com_id`),
    FOREIGN KEY (`com_cli_id`) REFERENCES `client` (`cli_id`),
    FOREIGN KEY(`com_sal_id`) REFERENCES `salarie`(`sal_id`)
);


-- --------------------------------------------------------
--
-- Structure de la table `modele`
--

DROP TABLE IF EXISTS `modele`;
CREATE TABLE IF NOT EXISTS `modele`(
  `mod_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Clé de la table modele',
  `mod_nom` VARCHAR(50) NOT NULL COMMENT 'Nom du modéle',
  `mod_annee` INT(4) NOT NULL COMMENT 'Année du modèle',
  `mod_marq_id` INT(10) NOT NULL COMMENT 'Identifiant de la marque',
   PRIMARY KEY(`mod_id`),
   FOREIGN KEY(`mod_marq_id`) REFERENCES `marque`(`marq_id`)
);


-- --------------------------------------------------------
--
-- Structure de la table `vehicule`
--

DROP TABLE IF EXISTS `vehicule`;
CREATE TABLE IF NOT EXISTS `vehicule`(
  `veh_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Clé de la table véhicule',
  `veh_couleur` VARCHAR(20) NOT NULL COMMENT 'Couleur du véhicule',
  `veh_prix` DECIMAL(8,2) NOT NULL COMMENT 'Prix du véhicule',
  `veh_ref` VARCHAR(50) NOT NULL COMMENT 'Référence du véhicule',
  `veh_etat`VARCHAR(10) NOT NULL COMMENT 'Etat du véhicule',
  `veh_age` INT(2) COMMENT 'Age du véhicule',
  `veh_mod_id` INT(10) NOT NULL COMMENT 'Identifiant modéle véhicule',
   PRIMARY KEY(`veh_id`),
   UNIQUE KEY `idx_veh_ref` (`veh_ref`),
   FOREIGN KEY(`veh_mod_id`) REFERENCES `modele`(`mod_id`)
);


-- --------------------------------------------------------
--
-- Structure de la table `comprend`
--

DROP TABLE IF EXISTS `comprend`;
CREATE TABLE IF NOT EXISTS `comprend`(
  `comp_acce_id` int(10)  NOT NULL  COMMENT 'Identifiant accesoire de la table comprend',
  `comp_serv_id` int(10)  NOT NULL  COMMENT 'Identifiant service de la table comprend',
  PRIMARY KEY(`comp_acce_id`,`comp_serv_id`),
  FOREIGN KEY(`comp_acce_id`) REFERENCES `accesoire`(`acce_id`),
  FOREIGN KEY(`comp_serv_id`) REFERENCES `service`(`serv_id`)
);

-- --------------------------------------------------------
--
-- Structure de la table `lignecom`
--

DROP TABLE IF EXISTS `lignecom`;
CREATE TABLE IF NOT EXISTS `lignecom`(
  `lignecom_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Clé de la table lignecom',
  `lignecom_qte` INT(3) NOT NULL COMMENT 'Quantité du produit commandé',
  `lignecom_serv_id` INT(10) NOT NULL COMMENT 'Identifiant service',
  `lignecom_veh_id` INT(10) NOT NULL COMMENT 'Identifiant véhicule',
  `lignecom_com_id` INT(10) NOT NULL COMMENT 'Identifiant commande',
  PRIMARY KEY(`lignecom_id`),
  FOREIGN KEY(`lignecom_serv_id`) REFERENCES `service`(`serv_id`),
  FOREIGN KEY(`lignecom_veh_id`) REFERENCES `vehicule`(`veh_id`),
  FOREIGN KEY(`lignecom_com_id`) REFERENCES `commande`(`com_id`)
);


/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;




