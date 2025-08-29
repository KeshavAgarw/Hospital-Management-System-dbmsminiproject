-- Hospital Management System - Clean SQL Schema
-- No sample data, only tables + triggers

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

-- Database: `hms`
CREATE DATABASE IF NOT EXISTS `hms`;
USE `hms`;

-- --------------------------------------------------------
-- Table structure for table `doctors`
-- --------------------------------------------------------
CREATE TABLE `doctors` (
  `did` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(50) NOT NULL,
  `doctorname` varchar(50) NOT NULL,
  `dept` varchar(100) NOT NULL,
  PRIMARY KEY (`did`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------
-- Table structure for table `patients`
-- --------------------------------------------------------
CREATE TABLE `patients` (
  `pid` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `gender` varchar(50) NOT NULL,
  `slot` varchar(50) NOT NULL,
  `disease` varchar(50) NOT NULL,
  `time` time NOT NULL,
  `date` date NOT NULL,
  `dept` varchar(50) NOT NULL,
  `number` varchar(12) NOT NULL,
  PRIMARY KEY (`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Triggers for patients
DELIMITER $$
CREATE TRIGGER `PatientDelete` 
BEFORE DELETE ON `patients` 
FOR EACH ROW 
INSERT INTO trigr VALUES(NULL, OLD.pid, OLD.email, OLD.name, 'PATIENT DELETED', NOW());
$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER `PatientUpdate` 
AFTER UPDATE ON `patients` 
FOR EACH ROW 
INSERT INTO trigr VALUES(NULL, NEW.pid, NEW.email, NEW.name, 'PATIENT UPDATED', NOW());
$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER `patientinsertion` 
AFTER INSERT ON `patients` 
FOR EACH ROW 
INSERT INTO trigr VALUES(NULL, NEW.pid, NEW.email, NEW.name, 'PATIENT INSERTED', NOW());
$$
DELIMITER ;

-- --------------------------------------------------------
-- Table structure for table `test`
-- --------------------------------------------------------
CREATE TABLE `test` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `email` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------
-- Table structure for table `trigr`
-- --------------------------------------------------------
CREATE TABLE `trigr` (
  `tid` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL,
  `email` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `action` varchar(50) NOT NULL,
  `timestamp` datetime NOT NULL,
  PRIMARY KEY (`tid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------
-- Table structure for table `user`
-- --------------------------------------------------------
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `usertype` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL UNIQUE,
  `password` varchar(1000) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
