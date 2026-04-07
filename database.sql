-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 07, 2026 at 10:40 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `palatiw_elementary`
--

-- --------------------------------------------------------

--
-- Table structure for table `tblaccounts`
--

CREATE TABLE `tblaccounts` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `usertype` varchar(20) NOT NULL,
  `section` varchar(50) DEFAULT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'active',
  `createdby` varchar(50) NOT NULL,
  `datecreated` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tblaccounts`
--

INSERT INTO `tblaccounts` (`id`, `username`, `password`, `usertype`, `section`, `status`, `createdby`, `datecreated`) VALUES
(1, 'admin', '123456', 'admin', '', 'active', 'system', '2025-11-22 20:08:23'),
(2, 'teacher1', '123456', 'teacher', 'Abokado', 'active', 'admin', '2025-11-22 20:08:23'),
(7, 'abokado', 'abokado', 'teacher', 'Abokado', 'active', 'admin', '2026-03-20 07:45:22');

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade1abokado`
--

CREATE TABLE `tblgrade1abokado` (
  `id` int(10) UNSIGNED NOT NULL,
  `lrn_number` varchar(20) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) NOT NULL,
  `age` int(10) UNSIGNED NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `contact_number` varchar(15) NOT NULL,
  `parent_name` varchar(100) NOT NULL,
  `parent_contact` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tblgrade1abokado`
--

INSERT INTO `tblgrade1abokado` (`id`, `lrn_number`, `last_name`, `first_name`, `middle_name`, `age`, `gender`, `contact_number`, `parent_name`, `parent_contact`) VALUES
(92, '136700000001', 'Santos', 'Juan', 'Reyes', 7, 'MALE', '09171234567', 'Maria Santos', '09981234567'),
(93, '136700000002', 'Cruz', 'Ana', 'Lopez', 6, 'FEMALE', '09182345678', 'Pedro Cruz', '09982345678'),
(94, '136700000003', 'Garcia', 'Mark', 'Dela Cruz', 7, 'MALE', '09193456789', 'Liza Garcia', '09983456789'),
(95, '136700000004', 'Reyes', 'Angela', 'Torres', 6, 'FEMALE', '09204567890', 'Ramon Reyes', '09984567890'),
(96, '136700000005', 'Torres', 'Paul', 'Santos', 7, 'MALE', '09215678901', 'Nina Torres', '09985678901'),
(97, '136700000006', 'Flores', 'Kyle', 'Rivera', 6, 'MALE', '09226789012', 'Grace Flores', '09986789012'),
(98, '136700000007', 'Rivera', 'Jasmine', 'Gomez', 7, 'FEMALE', '09237890123', 'Leo Rivera', '09987890123'),
(99, '136700000008', 'Gomez', 'Nathan', 'Perez', 6, 'MALE', '09248901234', 'Cora Gomez', '09988901234'),
(100, '136700000009', 'Perez', 'Sophia', 'Diaz', 7, 'FEMALE', '09259012345', 'Rudy Perez', '09989012345'),
(101, '136700000010', 'Diaz', 'Ethan', 'Castro', 6, 'MALE', '09260123456', 'Mila Diaz', '09990123456'),
(102, '136700000011', 'Castro', 'Chloe', 'Ramos', 7, 'FEMALE', '09271234567', 'Ben Castro', '09991234567'),
(103, '136700000012', 'Ramos', 'Daniel', 'Aquino', 6, 'MALE', '09282345678', 'Lina Ramos', '09992345678'),
(104, '136700000013', 'Aquino', 'Ella', 'Morales', 7, 'FEMALE', '09293456789', 'Tony Aquino', '09993456789'),
(105, '136700000014', 'Morales', 'Joshua', 'Valdez', 6, 'MALE', '09304567890', 'Ivy Morales', '09994567890'),
(106, '136700000015', 'Valdez', 'Mia', 'Domingo', 7, 'FEMALE', '09315678901', 'Arman Valdez', '09995678901'),
(107, '136700000016', 'Domingo', 'Noah', 'Salazar', 6, 'MALE', '09326789012', 'Rica Domingo', '09996789012'),
(108, '136700000017', 'Salazar', 'Ava', 'Gutierrez', 7, 'FEMALE', '09337890123', 'Joel Salazar', '09997890123'),
(109, '136700000018', 'Gutierrez', 'Lucas', 'Navarro', 6, 'MALE', '09348901234', 'Beth Gutierrez', '09998901234'),
(110, '136700000019', 'Navarro', 'Isabella', 'Mendoza', 7, 'FEMALE', '09359012345', 'Eric Navarro', '09999012345'),
(111, '136700000020', 'Mendoza', 'Liam', 'Villanueva', 6, 'MALE', '09360123456', 'Kaye Mendoza', '09990112233'),
(112, '136700000021', 'Villanueva', 'Zoe', 'Ortega', 7, 'FEMALE', '09371234567', 'Dan Villanueva', '09991223344'),
(113, '136700000022', 'Ortega', 'James', 'Padilla', 6, 'MALE', '09382345678', 'Tess Ortega', '09992334455'),
(114, '136700000023', 'Padilla', 'Lily', 'Aguilar', 7, 'FEMALE', '09393456789', 'Mark Padilla', '09993445566'),
(115, '136700000024', 'Aguilar', 'Henry', 'Vega', 6, 'MALE', '09404567890', 'Anne Aguilar', '09994556677'),
(116, '136700000025', 'Vega', 'Grace', 'Silva', 7, 'FEMALE', '09415678901', 'Ralph Vega', '09995667788'),
(117, '136700000026', 'Silva', 'Aaron', 'Cortez', 6, 'MALE', '09426789012', 'Ella Silva', '09996778899'),
(118, '136700000027', 'Cortez', 'Hannah', 'Bautista', 7, 'FEMALE', '09437890123', 'Noel Cortez', '09997889900'),
(119, '136700000028', 'Bautista', 'David', 'Rosales', 6, 'MALE', '09448901234', 'Maya Bautista', '09998990011'),
(120, '136700000029', 'Rosales', 'Faith', 'Serrano', 7, 'FEMALE', '09459012345', 'Omar Rosales', '09999001122'),
(121, '136700000030', 'Serrano', 'Caleb', 'Pascual', 6, 'MALE', '09460123456', 'Joy Serrano', '09990112244');

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade1abokadosupplies`
--

CREATE TABLE `tblgrade1abokadosupplies` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `notebooks` varchar(50) DEFAULT NULL,
  `padpaper` varchar(50) DEFAULT NULL,
  `bag` varchar(50) DEFAULT NULL,
  `ballpen` varchar(50) DEFAULT NULL,
  `pencil` varchar(50) DEFAULT NULL,
  `sharpener` varchar(50) DEFAULT NULL,
  `crayons` varchar(50) DEFAULT NULL,
  `eraser` varchar(50) DEFAULT NULL,
  `ruler` varchar(50) DEFAULT NULL,
  `scissors` varchar(50) DEFAULT NULL,
  `glue` varchar(50) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tblgrade1abokadosupplies`
--

INSERT INTO `tblgrade1abokadosupplies` (`id`, `lrn`, `student_name`, `notebooks`, `padpaper`, `bag`, `ballpen`, `pencil`, `sharpener`, `crayons`, `eraser`, `ruler`, `scissors`, `glue`, `created_by`, `date_updated`) VALUES
(1, '136700000001', 'Santos, Juan Reyes', '8', '2', '1', '2', '2', '1', '1', '1', '1', '1', '1', 'Admin', '2026-02-25 21:17:48'),
(2, '136700000002', 'Cruz, Ana Lopez', '8', '2', '1', '2', '2', '1', '1', '1', '1', '1', '1', 'Admin', '2026-02-25 21:17:48'),
(3, '136700000003', 'Garcia, Mark Dela Cruz', '8', '2', '1', '2', '2', '1', '1', '1', '1', '1', '1', 'Admin', '2026-02-25 21:17:48'),
(4, '136700000004', 'Reyes, Angela Torres', '8', '2', '1', '2', '2', '1', '1', '1', '1', '1', '1', 'Admin', '2026-02-25 21:17:48'),
(5, '136700000005', 'Torres, Paul Santos', '8', '2', '1', '2', '2', '1', '1', '1', '1', '1', '1', 'Admin', '2026-02-25 21:17:48'),
(6, '136700000006', 'Flores, Kyle Rivera', '8', '2', '1', '2', '2', '1', '1', '1', '1', '1', '1', 'Admin', '2026-02-25 21:17:48'),
(7, '136700000007', 'Rivera, Jasmine Gomez', '8', '2', '1', '2', '2', '1', '1', '1', '1', '1', '1', 'Admin', '2026-02-25 21:17:48'),
(8, '136700000008', 'Gomez, Nathan Perez', '8', '2', '1', '2', '2', '1', '1', '1', '1', '1', '1', 'Admin', '2026-02-25 21:17:48'),
(9, '136700000009', 'Perez, Sophia Diaz', '8', '2', '1', '2', '2', '1', '1', '1', '1', '1', '1', 'Admin', '2026-02-25 21:17:48'),
(10, '136700000010', 'Diaz, Ethan Castro', '8', '2', '1', '2', '2', '1', '1', '1', '1', '1', '1', 'Admin', '2026-02-25 21:17:48'),
(11, '136700000011', 'Castro, Chloe Ramos', '8', '2', '1', '2', '2', '1', '1', '1', '1', '1', '1', 'Admin', '2026-02-25 21:17:48'),
(12, '136700000012', 'Ramos, Daniel Aquino', '8', '2', '1', '2', '2', '1', '1', '1', '1', '1', '1', 'Admin', '2026-02-25 21:17:48'),
(13, '136700000013', 'Aquino, Ella Morales', '8', '2', '1', '2', '2', '1', '1', '1', '1', '1', '1', 'Admin', '2026-02-25 21:17:48'),
(14, '136700000014', 'Morales, Joshua Valdez', '8', '2', '1', '2', '2', '1', '1', '1', '1', '1', '1', 'Admin', '2026-02-25 21:17:48'),
(15, '136700000015', 'Valdez, Mia Domingo', '8', '2', '1', '2', '2', '1', '1', '1', '1', '1', '1', 'Admin', '2026-02-25 21:17:48'),
(16, '136700000016', 'Domingo, Noah Salazar', '8', '2', '1', '2', '2', '1', '1', '1', '1', '1', '1', 'Admin', '2026-02-25 21:17:48'),
(17, '136700000017', 'Salazar, Ava Gutierrez', '8', '2', '1', '2', '2', '1', '1', '1', '1', '1', '1', 'Admin', '2026-02-25 21:17:48'),
(18, '136700000018', 'Gutierrez, Lucas Navarro', '8', '2', '1', '2', '2', '1', '1', '1', '1', '1', '1', 'Admin', '2026-02-25 21:17:48'),
(19, '136700000019', 'Navarro, Isabella Mendoza', '8', '2', '1', '2', '2', '1', '1', '1', '1', '1', '1', 'Admin', '2026-02-25 21:17:48'),
(20, '136700000020', 'Mendoza, Liam Villanueva', '8', '2', '1', '2', '2', '1', '1', '1', '1', '1', '1', 'Admin', '2026-02-25 21:17:48'),
(21, '136700000021', 'Villanueva, Zoe Ortega', '8', '2', '1', '2', '2', '1', '1', '1', '1', '1', '1', 'Admin', '2026-02-25 21:17:48'),
(22, '136700000022', 'Ortega, James Padilla', '8', '2', '1', '2', '2', '1', '1', '1', '1', '1', '1', 'Admin', '2026-02-25 21:17:48'),
(23, '136700000023', 'Padilla, Lily Aguilar', '8', '2', '1', '2', '2', '1', '1', '1', '1', '1', '1', 'Admin', '2026-02-25 21:17:48'),
(24, '136700000024', 'Aguilar, Henry Vega', '8', '2', '1', '2', '1', '1', '1', '1', '1', '1', '1', 'abokado', '2026-03-20 06:46:38'),
(25, '136700000025', 'Vega, Grace Silva', '8', '2', '1', '2', '2', '1', '1', '1', '1', '1', '1', 'Admin', '2026-02-25 21:17:48'),
(26, '136700000026', 'Silva, Aaron Cortez', '8', '2', '1', '2', '2', '1', '1', '1', '1', '1', '1', 'Admin', '2026-02-25 21:17:48'),
(27, '136700000027', 'Cortez, Hannah Bautista', '8', '2', '1', '2', '2', '1', '1', '1', '1', '1', '1', 'Admin', '2026-02-25 21:17:48'),
(28, '136700000028', 'Bautista, David Rosales', '8', '2', '1', '2', '2', '1', '1', '1', '1', '1', '1', 'Admin', '2026-02-25 21:17:48'),
(29, '136700000029', 'Rosales, Faith Serrano', '8', '2', '1', '2', '2', '1', '1', '1', '1', '1', '1', 'Admin', '2026-02-25 21:17:48'),
(30, '136700000030', 'Serrano, Caleb Pascual', '8', '2', '1', '2', '2', '1', '1', '1', '1', '1', '1', 'Admin', '2026-02-25 21:17:48');

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade1abokadouniform`
--

CREATE TABLE `tblgrade1abokadouniform` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `pe_tshirt` varchar(10) DEFAULT NULL,
  `pe_pants` varchar(10) DEFAULT NULL,
  `socks` varchar(10) DEFAULT NULL,
  `shoes` varchar(10) DEFAULT NULL,
  `school_uniform` varchar(10) DEFAULT NULL,
  `uniform_bottom` varchar(10) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tblgrade1abokadouniform`
--

INSERT INTO `tblgrade1abokadouniform` (`id`, `lrn`, `student_name`, `gender`, `pe_tshirt`, `pe_pants`, `socks`, `shoes`, `school_uniform`, `uniform_bottom`, `created_by`, `date_updated`) VALUES
(32, '136700000001', 'Santos, Juan Reyes', 'MALE', 'M', 'M', 'M', '26', 'M', 'M', 'Admin', '2026-02-25 21:35:39'),
(33, '136700000002', 'Cruz, Ana Lopez', 'FEMALE', 'S', 'S', 'S', '25', 'S', 'S', 'Admin', '2026-02-25 21:35:39'),
(34, '136700000003', 'Garcia, Mark Dela Cruz', 'MALE', 'M', 'M', 'M', '26', 'M', 'M', 'Admin', '2026-02-25 21:35:39'),
(35, '136700000004', 'Reyes, Angela Torres', 'FEMALE', 'S', 'S', 'S', '25', 'S', 'S', 'Admin', '2026-02-25 21:35:39'),
(36, '136700000005', 'Torres, Paul Santos', 'MALE', 'M', 'M', 'M', '26', 'M', 'M', 'Admin', '2026-02-25 21:35:39'),
(37, '136700000006', 'Flores, Kyle Rivera', 'MALE', 'S', 'S', 'S', '25', 'S', 'S', 'Admin', '2026-02-25 21:35:39'),
(38, '136700000007', 'Rivera, Jasmine Gomez', 'FEMALE', 'M', 'M', 'M', '26', 'M', 'M', 'Admin', '2026-02-25 21:35:39'),
(39, '136700000008', 'Gomez, Nathan Perez', 'MALE', 'S', 'S', 'S', '25', 'S', 'S', 'Admin', '2026-02-25 21:35:39'),
(40, '136700000009', 'Perez, Sophia Diaz', 'FEMALE', 'M', 'M', 'M', '26', 'M', 'M', 'Admin', '2026-02-25 21:35:39'),
(41, '136700000010', 'Diaz, Ethan Castro', 'MALE', 'S', 'S', 'S', '25', 'S', 'S', 'Admin', '2026-02-25 21:35:39'),
(42, '136700000011', 'Castro, Chloe Ramos', 'FEMALE', 'M', 'M', 'M', '26', 'M', 'M', 'Admin', '2026-02-25 21:35:39'),
(43, '136700000012', 'Ramos, Daniel Aquino', 'MALE', 'S', 'S', 'S', '25', 'S', 'S', 'Admin', '2026-02-25 21:35:39'),
(44, '136700000013', 'Aquino, Ella Morales', 'FEMALE', 'M', 'M', 'M', '26', 'M', 'M', 'Admin', '2026-02-25 21:35:39'),
(45, '136700000014', 'Morales, Joshua Valdez', 'MALE', 'S', 'S', 'S', '25', 'S', 'S', 'Admin', '2026-02-25 21:35:39'),
(46, '136700000015', 'Valdez, Mia Domingo', 'FEMALE', 'M', 'M', 'M', '26', 'M', 'M', 'Admin', '2026-02-25 21:35:39'),
(47, '136700000016', 'Domingo, Noah Salazar', 'MALE', 'S', 'S', 'S', '25', 'S', 'S', 'Admin', '2026-02-25 21:35:39'),
(48, '136700000017', 'Salazar, Ava Gutierrez', 'FEMALE', 'M', 'M', 'M', '26', 'M', 'M', 'Admin', '2026-02-25 21:35:39'),
(49, '136700000018', 'Gutierrez, Lucas Navarro', 'MALE', 'S', 'S', 'S', '25', 'S', 'S', 'Admin', '2026-02-25 21:35:39'),
(50, '136700000019', 'Navarro, Isabella Mendoza', 'FEMALE', 'M', 'M', 'M', '26', 'M', 'M', 'Admin', '2026-02-25 21:35:39'),
(51, '136700000020', 'Mendoza, Liam Villanueva', 'MALE', 'S', 'S', 'S', '25', 'S', 'S', 'Admin', '2026-02-25 21:35:39'),
(52, '136700000021', 'Villanueva, Zoe Ortega', 'FEMALE', 'M', 'M', 'M', '26', 'M', 'M', 'Admin', '2026-02-25 21:35:39'),
(53, '136700000022', 'Ortega, James Padilla', 'MALE', 'S', 'S', 'S', '25', 'S', 'S', 'Admin', '2026-02-25 21:35:39'),
(54, '136700000023', 'Padilla, Lily Aguilar', 'FEMALE', 'M', 'M', 'M', '26', 'M', 'M', 'Admin', '2026-02-25 21:35:39'),
(55, '136700000024', 'Aguilar, Henry Vega', 'MALE', 'S', 'S', 'S', '25', 'S', 'S', 'Admin', '2026-02-25 21:35:39'),
(56, '136700000025', 'Vega, Grace Silva', 'FEMALE', 'M', 'M', 'M', '26', 'M', 'M', 'Admin', '2026-02-25 21:35:39'),
(57, '136700000026', 'Silva, Aaron Cortez', 'MALE', 'S', 'S', 'S', '25', 'S', 'S', 'Admin', '2026-02-25 21:35:39'),
(58, '136700000027', 'Cortez, Hannah Bautista', 'FEMALE', 'M', 'M', 'M', '26', 'M', 'M', 'Admin', '2026-02-25 21:35:39'),
(59, '136700000028', 'Bautista, David Rosales', 'MALE', 'S', 'S', 'S', '25', 'S', 'S', 'Admin', '2026-02-25 21:35:39'),
(60, '136700000029', 'Rosales, Faith Serrano', 'FEMALE', 'M', 'M', 'M', '26', 'M', 'M', 'Admin', '2026-02-25 21:35:39'),
(61, '136700000030', 'Serrano, Caleb Pascual', 'MALE', 'S', 'S', 'S', '25', 'S', 'S', 'Admin', '2026-02-25 21:35:39');

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade1buko`
--

CREATE TABLE `tblgrade1buko` (
  `id` int(10) UNSIGNED NOT NULL,
  `lrn_number` varchar(20) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) NOT NULL,
  `age` int(10) UNSIGNED NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `contact_number` varchar(15) NOT NULL,
  `parent_name` varchar(100) NOT NULL,
  `parent_contact` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tblgrade1buko`
--

INSERT INTO `tblgrade1buko` (`id`, `lrn_number`, `last_name`, `first_name`, `middle_name`, `age`, `gender`, `contact_number`, `parent_name`, `parent_contact`) VALUES
(62, '136700000031', 'Dela Cruz', 'Miguel', 'Santos', 7, 'MALE', '09511234567', 'Rosa Dela Cruz', '09981230001'),
(63, '136700000032', 'Lopez', 'Camila', 'Reyes', 6, 'FEMALE', '09512345678', 'Jose Lopez', '09981230002'),
(64, '136700000033', 'Ramos', 'Adrian', 'Torres', 7, 'MALE', '09513456789', 'Lani Ramos', '09981230003'),
(65, '136700000034', 'Torres', 'Bea', 'Garcia', 6, 'FEMALE', '09514567890', 'Marco Torres', '09981230004'),
(66, '136700000035', 'Garcia', 'Ken', 'Rivera', 7, 'MALE', '09515678901', 'Joy Garcia', '09981230005'),
(67, '136700000036', 'Rivera', 'Nicole', 'Flores', 6, 'FEMALE', '09516789012', 'Paul Rivera', '09981230006'),
(68, '136700000037', 'Flores', 'Bryan', 'Diaz', 7, 'MALE', '09517890123', 'Anna Flores', '09981230007'),
(69, '136700000038', 'Diaz', 'Ella', 'Gomez', 6, 'FEMALE', '09518901234', 'Rico Diaz', '09981230008'),
(70, '136700000039', 'Gomez', 'Lance', 'Perez', 7, 'MALE', '09519012345', 'Cindy Gomez', '09981230009'),
(71, '136700000040', 'Perez', 'Trish', 'Castro', 6, 'FEMALE', '09510123456', 'Owen Perez', '09981230010'),
(72, '136700000041', 'Castro', 'Ivan', 'Morales', 7, 'MALE', '09521234567', 'Liza Castro', '09981230011'),
(73, '136700000042', 'Morales', 'Kate', 'Valdez', 6, 'FEMALE', '09522345678', 'Ramon Morales', '09981230012'),
(74, '136700000043', 'Valdez', 'Sean', 'Domingo', 7, 'MALE', '09523456789', 'Mina Valdez', '09981230013'),
(75, '136700000044', 'Domingo', 'Faith', 'Aquino', 6, 'FEMALE', '09524567890', 'Ben Domingo', '09981230014'),
(76, '136700000045', 'Aquino', 'Josh', 'Navarro', 7, 'MALE', '09525678901', 'Rhea Aquino', '09981230015'),
(77, '136700000046', 'Navarro', 'Mia', 'Salazar', 6, 'FEMALE', '09526789012', 'Joel Navarro', '09981230016'),
(78, '136700000047', 'Salazar', 'Noah', 'Ortega', 7, 'MALE', '09527890123', 'Ivy Salazar', '09981230017'),
(79, '136700000048', 'Ortega', 'Ava', 'Padilla', 6, 'FEMALE', '09528901234', 'Dan Ortega', '09981230018'),
(80, '136700000049', 'Padilla', 'Eli', 'Vega', 7, 'MALE', '09529012345', 'Tina Padilla', '09981230019'),
(81, '136700000050', 'Vega', 'Zoe', 'Silva', 6, 'FEMALE', '09520123456', 'Ralph Vega', '09981230020'),
(82, '136700000051', 'Silva', 'Kyle', 'Cortez', 7, 'MALE', '09531234567', 'Ella Silva', '09981230021'),
(83, '136700000052', 'Cortez', 'Hannah', 'Bautista', 6, 'FEMALE', '09532345678', 'Noel Cortez', '09981230022'),
(84, '136700000053', 'Bautista', 'Aaron', 'Rosales', 7, 'MALE', '09533456789', 'Maya Bautista', '09981230023'),
(85, '136700000054', 'Rosales', 'Lily', 'Serrano', 6, 'FEMALE', '09534567890', 'Omar Rosales', '09981230024'),
(86, '136700000055', 'Serrano', 'Caleb', 'Pascual', 7, 'MALE', '09535678901', 'Joy Serrano', '09981230025'),
(87, '136700000056', 'Pascual', 'Leah', 'Villanueva', 6, 'FEMALE', '09536789012', 'Dan Pascual', '09981230026'),
(88, '136700000057', 'Villanueva', 'James', 'Mendoza', 7, 'MALE', '09537890123', 'Kaye Villanueva', '09981230027'),
(89, '136700000058', 'Mendoza', 'Grace', 'Gutierrez', 6, 'FEMALE', '09538901234', 'Eric Mendoza', '09981230028'),
(90, '136700000059', 'Gutierrez', 'Daniel', 'Aguilar', 7, 'MALE', '09539012345', 'Beth Gutierrez', '09981230029'),
(91, '136700000060', 'Aguilar', 'Chloe', 'Reyes', 6, 'FEMALE', '09530123456', 'Anne Aguilar', '09981230030');

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade1bukosupplies`
--

CREATE TABLE `tblgrade1bukosupplies` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `notebooks` varchar(50) DEFAULT NULL,
  `padpaper` varchar(50) DEFAULT NULL,
  `bag` varchar(50) DEFAULT NULL,
  `ballpen` varchar(50) DEFAULT NULL,
  `pencil` varchar(50) DEFAULT NULL,
  `sharpener` varchar(50) DEFAULT NULL,
  `crayons` varchar(50) DEFAULT NULL,
  `eraser` varchar(50) DEFAULT NULL,
  `ruler` varchar(50) DEFAULT NULL,
  `scissors` varchar(50) DEFAULT NULL,
  `glue` varchar(50) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade1bukouniform`
--

CREATE TABLE `tblgrade1bukouniform` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `pe_tshirt` varchar(10) DEFAULT NULL,
  `pe_pants` varchar(10) DEFAULT NULL,
  `socks` varchar(10) DEFAULT NULL,
  `shoes` varchar(10) DEFAULT NULL,
  `school_uniform` varchar(10) DEFAULT NULL,
  `uniform_bottom` varchar(10) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade1dalandan`
--

CREATE TABLE `tblgrade1dalandan` (
  `id` int(10) UNSIGNED NOT NULL,
  `lrn_number` varchar(20) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) NOT NULL,
  `age` int(10) UNSIGNED NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `contact_number` varchar(15) NOT NULL,
  `parent_name` varchar(100) NOT NULL,
  `parent_contact` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tblgrade1dalandan`
--

INSERT INTO `tblgrade1dalandan` (`id`, `lrn_number`, `last_name`, `first_name`, `middle_name`, `age`, `gender`, `contact_number`, `parent_name`, `parent_contact`) VALUES
(31, '136700000061', 'Santos', 'Leo', 'Garcia', 7, 'MALE', '09611234567', 'Maria Santos', '09981240001'),
(32, '136700000062', 'Cruz', 'Alyssa', 'Torres', 6, 'FEMALE', '09612345678', 'Pedro Cruz', '09981240002'),
(33, '136700000063', 'Garcia', 'Mark', 'Lopez', 7, 'MALE', '09613456789', 'Liza Garcia', '09981240003'),
(34, '136700000064', 'Reyes', 'Angela', 'Rivera', 6, 'FEMALE', '09614567890', 'Ramon Reyes', '09981240004'),
(35, '136700000065', 'Torres', 'Paul', 'Flores', 7, 'MALE', '09615678901', 'Nina Torres', '09981240005'),
(36, '136700000066', 'Flores', 'Kyle', 'Diaz', 6, 'MALE', '09616789012', 'Grace Flores', '09981240006'),
(37, '136700000067', 'Rivera', 'Jasmine', 'Gomez', 7, 'FEMALE', '09617890123', 'Leo Rivera', '09981240007'),
(38, '136700000068', 'Gomez', 'Nathan', 'Perez', 6, 'MALE', '09618901234', 'Cora Gomez', '09981240008'),
(39, '136700000069', 'Perez', 'Sophia', 'Castro', 7, 'FEMALE', '09619012345', 'Rudy Perez', '09981240009'),
(40, '136700000070', 'Diaz', 'Ethan', 'Ramos', 6, 'MALE', '09610123456', 'Mila Diaz', '09981240010'),
(41, '136700000071', 'Castro', 'Chloe', 'Aquino', 7, 'FEMALE', '09621234567', 'Ben Castro', '09981240011'),
(42, '136700000072', 'Ramos', 'Daniel', 'Morales', 6, 'MALE', '09622345678', 'Lina Ramos', '09981240012'),
(43, '136700000073', 'Aquino', 'Ella', 'Valdez', 7, 'FEMALE', '09623456789', 'Tony Aquino', '09981240013'),
(44, '136700000074', 'Morales', 'Joshua', 'Domingo', 6, 'MALE', '09624567890', 'Ivy Morales', '09981240014'),
(45, '136700000075', 'Valdez', 'Mia', 'Salazar', 7, 'FEMALE', '09625678901', 'Arman Valdez', '09981240015'),
(46, '136700000076', 'Domingo', 'Noah', 'Gutierrez', 6, 'MALE', '09626789012', 'Rica Domingo', '09981240016'),
(47, '136700000077', 'Salazar', 'Ava', 'Navarro', 7, 'FEMALE', '09627890123', 'Joel Salazar', '09981240017'),
(48, '136700000078', 'Gutierrez', 'Lucas', 'Mendoza', 6, 'MALE', '09628901234', 'Beth Gutierrez', '09981240018'),
(49, '136700000079', 'Navarro', 'Isabella', 'Villanueva', 7, 'FEMALE', '09629012345', 'Eric Navarro', '09981240019'),
(50, '136700000080', 'Mendoza', 'Liam', 'Ortega', 6, 'MALE', '09620123456', 'Kaye Mendoza', '09981240020'),
(51, '136700000081', 'Villanueva', 'Zoe', 'Padilla', 7, 'FEMALE', '09631234567', 'Dan Villanueva', '09981240021'),
(52, '136700000082', 'Ortega', 'James', 'Aguilar', 6, 'MALE', '09632345678', 'Tess Ortega', '09981240022'),
(53, '136700000083', 'Padilla', 'Lily', 'Vega', 7, 'FEMALE', '09633456789', 'Mark Padilla', '09981240023'),
(54, '136700000084', 'Aguilar', 'Henry', 'Silva', 6, 'MALE', '09634567890', 'Anne Aguilar', '09981240024'),
(55, '136700000085', 'Vega', 'Grace', 'Cortez', 7, 'FEMALE', '09635678901', 'Ralph Vega', '09981240025'),
(56, '136700000086', 'Silva', 'Aaron', 'Bautista', 6, 'MALE', '09636789012', 'Ella Silva', '09981240026'),
(57, '136700000087', 'Cortez', 'Hannah', 'Rosales', 7, 'FEMALE', '09637890123', 'Noel Cortez', '09981240027'),
(58, '136700000088', 'Bautista', 'David', 'Serrano', 6, 'MALE', '09638901234', 'Maya Bautista', '09981240028'),
(59, '136700000089', 'Rosales', 'Faith', 'Pascual', 7, 'FEMALE', '09639012345', 'Omar Rosales', '09981240029'),
(60, '136700000090', 'Serrano', 'Caleb', 'Reyes', 6, 'MALE', '09630123456', 'Joy Serrano', '09981240030');

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade1dalandansupplies`
--

CREATE TABLE `tblgrade1dalandansupplies` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `notebooks` varchar(50) DEFAULT NULL,
  `padpaper` varchar(50) DEFAULT NULL,
  `bag` varchar(50) DEFAULT NULL,
  `ballpen` varchar(50) DEFAULT NULL,
  `pencil` varchar(50) DEFAULT NULL,
  `sharpener` varchar(50) DEFAULT NULL,
  `crayons` varchar(50) DEFAULT NULL,
  `eraser` varchar(50) DEFAULT NULL,
  `ruler` varchar(50) DEFAULT NULL,
  `scissors` varchar(50) DEFAULT NULL,
  `glue` varchar(50) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade1dalandanuniform`
--

CREATE TABLE `tblgrade1dalandanuniform` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `pe_tshirt` varchar(10) DEFAULT NULL,
  `pe_pants` varchar(10) DEFAULT NULL,
  `socks` varchar(10) DEFAULT NULL,
  `shoes` varchar(10) DEFAULT NULL,
  `school_uniform` varchar(10) DEFAULT NULL,
  `uniform_bottom` varchar(10) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade1guyabano`
--

CREATE TABLE `tblgrade1guyabano` (
  `id` int(10) UNSIGNED NOT NULL,
  `lrn_number` varchar(20) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) NOT NULL,
  `age` int(10) UNSIGNED NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `contact_number` varchar(15) NOT NULL,
  `parent_name` varchar(100) NOT NULL,
  `parent_contact` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tblgrade1guyabano`
--

INSERT INTO `tblgrade1guyabano` (`id`, `lrn_number`, `last_name`, `first_name`, `middle_name`, `age`, `gender`, `contact_number`, `parent_name`, `parent_contact`) VALUES
(31, '136700001001', 'Santos', 'Miguel', 'Reyes', 6, 'MALE', '09651100001', 'Ana Santos', '09981110001'),
(32, '136700001002', 'Cruz', 'Aira', 'Lopez', 7, 'FEMALE', '09651100002', 'Marco Cruz', '09981110002'),
(33, '136700001003', 'Garcia', 'John', 'Torres', 6, 'MALE', '09651100003', 'Liza Garcia', '09981110003'),
(34, '136700001004', 'Reyes', 'Bea', 'Castro', 7, 'FEMALE', '09651100004', 'Ron Reyes', '09981110004'),
(35, '136700001005', 'Torres', 'Ivan', 'Diaz', 6, 'MALE', '09651100005', 'Nina Torres', '09981110005'),
(36, '136700001006', 'Flores', 'Kate', 'Morales', 7, 'FEMALE', '09651100006', 'Ben Flores', '09981110006'),
(37, '136700001007', 'Rivera', 'Sean', 'Gomez', 6, 'MALE', '09651100007', 'Mila Rivera', '09981110007'),
(38, '136700001008', 'Gomez', 'Lia', 'Perez', 7, 'FEMALE', '09651100008', 'Eric Gomez', '09981110008'),
(39, '136700001009', 'Perez', 'Ryan', 'Ramos', 6, 'MALE', '09651100009', 'Joy Perez', '09981110009'),
(40, '136700001010', 'Diaz', 'Ella', 'Aquino', 7, 'FEMALE', '09651100010', 'Tony Diaz', '09981110010'),
(41, '136700001011', 'Castro', 'Noah', 'Valdez', 6, 'MALE', '09651100011', 'Ivy Castro', '09981110011'),
(42, '136700001012', 'Ramos', 'Zia', 'Domingo', 7, 'FEMALE', '09651100012', 'Leo Ramos', '09981110012'),
(43, '136700001013', 'Aquino', 'Eli', 'Salazar', 6, 'MALE', '09651100013', 'Rica Aquino', '09981110013'),
(44, '136700001014', 'Morales', 'Mia', 'Navarro', 7, 'FEMALE', '09651100014', 'Dan Morales', '09981110014'),
(45, '136700001015', 'Valdez', 'Kyle', 'Mendoza', 6, 'MALE', '09651100015', 'Beth Valdez', '09981110015'),
(46, '136700001016', 'Domingo', 'Nina', 'Ortega', 7, 'FEMALE', '09651100016', 'Paul Domingo', '09981110016'),
(47, '136700001017', 'Salazar', 'Luke', 'Aguilar', 6, 'MALE', '09651100017', 'Anne Salazar', '09981110017'),
(48, '136700001018', 'Navarro', 'Yana', 'Padilla', 7, 'FEMALE', '09651100018', 'Eric Navarro', '09981110018'),
(49, '136700001019', 'Mendoza', 'Mark', 'Vega', 6, 'MALE', '09651100019', 'Kaye Mendoza', '09981110019'),
(50, '136700001020', 'Ortega', 'Faye', 'Silva', 7, 'FEMALE', '09651100020', 'Tess Ortega', '09981110020'),
(51, '136700001021', 'Padilla', 'Neil', 'Cortez', 6, 'MALE', '09651100021', 'Mark Padilla', '09981110021'),
(52, '136700001022', 'Aguilar', 'Rose', 'Bautista', 7, 'FEMALE', '09651100022', 'Anne Aguilar', '09981110022'),
(53, '136700001023', 'Vega', 'Paul', 'Rosales', 6, 'MALE', '09651100023', 'Ralph Vega', '09981110023'),
(54, '136700001024', 'Silva', 'Aly', 'Serrano', 7, 'FEMALE', '09651100024', 'Ella Silva', '09981110024'),
(55, '136700001025', 'Cortez', 'Ian', 'Pascual', 6, 'MALE', '09651100025', 'Noel Cortez', '09981110025'),
(56, '136700001026', 'Bautista', 'Rin', 'Reyes', 7, 'FEMALE', '09651100026', 'Maya Bautista', '09981110026'),
(57, '136700001027', 'Rosales', 'Tom', 'Garcia', 6, 'MALE', '09651100027', 'Omar Rosales', '09981110027'),
(58, '136700001028', 'Serrano', 'Luna', 'Cruz', 7, 'FEMALE', '09651100028', 'Joy Serrano', '09981110028'),
(59, '136700001029', 'Pascual', 'Jude', 'Flores', 6, 'MALE', '09651100029', 'Nico Pascual', '09981110029'),
(60, '136700001030', 'Reyes', 'Ava', 'Rivera', 7, 'FEMALE', '09651100030', 'Liam Reyes', '09981110030');

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade1guyabanosupplies`
--

CREATE TABLE `tblgrade1guyabanosupplies` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `notebooks` varchar(50) DEFAULT NULL,
  `padpaper` varchar(50) DEFAULT NULL,
  `bag` varchar(50) DEFAULT NULL,
  `ballpen` varchar(50) DEFAULT NULL,
  `pencil` varchar(50) DEFAULT NULL,
  `sharpener` varchar(50) DEFAULT NULL,
  `crayons` varchar(50) DEFAULT NULL,
  `eraser` varchar(50) DEFAULT NULL,
  `ruler` varchar(50) DEFAULT NULL,
  `scissors` varchar(50) DEFAULT NULL,
  `glue` varchar(50) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade1guyabanouniform`
--

CREATE TABLE `tblgrade1guyabanouniform` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `pe_tshirt` varchar(10) DEFAULT NULL,
  `pe_pants` varchar(10) DEFAULT NULL,
  `socks` varchar(10) DEFAULT NULL,
  `shoes` varchar(10) DEFAULT NULL,
  `school_uniform` varchar(10) DEFAULT NULL,
  `uniform_bottom` varchar(10) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade1kasoy`
--

CREATE TABLE `tblgrade1kasoy` (
  `id` int(10) UNSIGNED NOT NULL,
  `lrn_number` varchar(20) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) NOT NULL,
  `age` int(10) UNSIGNED NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `contact_number` varchar(15) NOT NULL,
  `parent_name` varchar(100) NOT NULL,
  `parent_contact` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tblgrade1kasoy`
--

INSERT INTO `tblgrade1kasoy` (`id`, `lrn_number`, `last_name`, `first_name`, `middle_name`, `age`, `gender`, `contact_number`, `parent_name`, `parent_contact`) VALUES
(31, '136700002001', 'Santos', 'Evan', 'Lopez', 6, 'MALE', '09652200001', 'Ana Santos', '09982220001'),
(32, '136700002002', 'Cruz', 'Mika', 'Torres', 7, 'FEMALE', '09652200002', 'Marco Cruz', '09982220002'),
(33, '136700002003', 'Garcia', 'Leo', 'Diaz', 6, 'MALE', '09652200003', 'Liza Garcia', '09982220003'),
(34, '136700002004', 'Reyes', 'Nia', 'Morales', 7, 'FEMALE', '09652200004', 'Ron Reyes', '09982220004'),
(35, '136700002005', 'Torres', 'Josh', 'Gomez', 6, 'MALE', '09652200005', 'Nina Torres', '09982220005'),
(36, '136700002006', 'Flores', 'Ivy', 'Perez', 7, 'FEMALE', '09652200006', 'Ben Flores', '09982220006'),
(37, '136700002007', 'Rivera', 'Ken', 'Ramos', 6, 'MALE', '09652200007', 'Mila Rivera', '09982220007'),
(38, '136700002008', 'Gomez', 'Ara', 'Aquino', 7, 'FEMALE', '09652200008', 'Eric Gomez', '09982220008'),
(39, '136700002009', 'Perez', 'Luke', 'Valdez', 6, 'MALE', '09652200009', 'Joy Perez', '09982220009'),
(40, '136700002010', 'Diaz', 'Fiona', 'Domingo', 7, 'FEMALE', '09652200010', 'Tony Diaz', '09982220010'),
(41, '136700002011', 'Castro', 'Noel', 'Salazar', 6, 'MALE', '09652200011', 'Ivy Castro', '09982220011'),
(42, '136700002012', 'Ramos', 'Zoe', 'Navarro', 7, 'FEMALE', '09652200012', 'Leo Ramos', '09982220012'),
(43, '136700002013', 'Aquino', 'Alex', 'Mendoza', 6, 'MALE', '09652200013', 'Rica Aquino', '09982220013'),
(44, '136700002014', 'Morales', 'Lyn', 'Ortega', 7, 'FEMALE', '09652200014', 'Dan Morales', '09982220014'),
(45, '136700002015', 'Valdez', 'Ben', 'Aguilar', 6, 'MALE', '09652200015', 'Beth Valdez', '09982220015'),
(46, '136700002016', 'Domingo', 'May', 'Padilla', 7, 'FEMALE', '09652200016', 'Paul Domingo', '09982220016'),
(47, '136700002017', 'Salazar', 'Tim', 'Vega', 6, 'MALE', '09652200017', 'Anne Salazar', '09982220017'),
(48, '136700002018', 'Navarro', 'Rhea', 'Silva', 7, 'FEMALE', '09652200018', 'Eric Navarro', '09982220018'),
(49, '136700002019', 'Mendoza', 'Owen', 'Cortez', 6, 'MALE', '09652200019', 'Kaye Mendoza', '09982220019'),
(50, '136700002020', 'Ortega', 'Belle', 'Bautista', 7, 'FEMALE', '09652200020', 'Tess Ortega', '09982220020'),
(51, '136700002021', 'Padilla', 'Sean', 'Rosales', 6, 'MALE', '09652200021', 'Mark Padilla', '09982220021'),
(52, '136700002022', 'Aguilar', 'Yen', 'Serrano', 7, 'FEMALE', '09652200022', 'Anne Aguilar', '09982220022'),
(53, '136700002023', 'Vega', 'Paul', 'Pascual', 6, 'MALE', '09652200023', 'Ralph Vega', '09982220023'),
(54, '136700002024', 'Silva', 'Gia', 'Reyes', 7, 'FEMALE', '09652200024', 'Ella Silva', '09982220024'),
(55, '136700002025', 'Cortez', 'Ian', 'Garcia', 6, 'MALE', '09652200025', 'Noel Cortez', '09982220025'),
(56, '136700002026', 'Bautista', 'Kyla', 'Cruz', 7, 'FEMALE', '09652200026', 'Maya Bautista', '09982220026'),
(57, '136700002027', 'Rosales', 'Mark', 'Flores', 6, 'MALE', '09652200027', 'Omar Rosales', '09982220027'),
(58, '136700002028', 'Serrano', 'Liza', 'Rivera', 7, 'FEMALE', '09652200028', 'Joy Serrano', '09982220028'),
(59, '136700002029', 'Pascual', 'Jude', 'Gomez', 6, 'MALE', '09652200029', 'Nico Pascual', '09982220029'),
(60, '136700002030', 'Reyes', 'Ava', 'Perez', 7, 'FEMALE', '09652200030', 'Liam Reyes', '09982220030');

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade1kasoysupplies`
--

CREATE TABLE `tblgrade1kasoysupplies` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `notebooks` varchar(50) DEFAULT NULL,
  `padpaper` varchar(50) DEFAULT NULL,
  `bag` varchar(50) DEFAULT NULL,
  `ballpen` varchar(50) DEFAULT NULL,
  `pencil` varchar(50) DEFAULT NULL,
  `sharpener` varchar(50) DEFAULT NULL,
  `crayons` varchar(50) DEFAULT NULL,
  `eraser` varchar(50) DEFAULT NULL,
  `ruler` varchar(50) DEFAULT NULL,
  `scissors` varchar(50) DEFAULT NULL,
  `glue` varchar(50) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade1kasoyuniform`
--

CREATE TABLE `tblgrade1kasoyuniform` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `pe_tshirt` varchar(10) DEFAULT NULL,
  `pe_pants` varchar(10) DEFAULT NULL,
  `socks` varchar(10) DEFAULT NULL,
  `shoes` varchar(10) DEFAULT NULL,
  `school_uniform` varchar(10) DEFAULT NULL,
  `uniform_bottom` varchar(10) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade1lansones`
--

CREATE TABLE `tblgrade1lansones` (
  `id` int(10) UNSIGNED NOT NULL,
  `lrn_number` varchar(20) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) NOT NULL,
  `age` int(10) UNSIGNED NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `contact_number` varchar(15) NOT NULL,
  `parent_name` varchar(100) NOT NULL,
  `parent_contact` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tblgrade1lansones`
--

INSERT INTO `tblgrade1lansones` (`id`, `lrn_number`, `last_name`, `first_name`, `middle_name`, `age`, `gender`, `contact_number`, `parent_name`, `parent_contact`) VALUES
(31, '136700003001', 'Santos', 'Aaron', 'Lopez', 6, 'MALE', '09653300001', 'Ana Santos', '09983330001'),
(32, '136700003002', 'Cruz', 'Bianca', 'Torres', 7, 'FEMALE', '09653300002', 'Marco Cruz', '09983330002'),
(33, '136700003003', 'Garcia', 'Noel', 'Diaz', 6, 'MALE', '09653300003', 'Liza Garcia', '09983330003'),
(34, '136700003004', 'Reyes', 'Kyra', 'Morales', 7, 'FEMALE', '09653300004', 'Ron Reyes', '09983330004'),
(35, '136700003005', 'Torres', 'Ivan', 'Gomez', 6, 'MALE', '09653300005', 'Nina Torres', '09983330005'),
(36, '136700003006', 'Flores', 'Aly', 'Perez', 7, 'FEMALE', '09653300006', 'Ben Flores', '09983330006'),
(37, '136700003007', 'Rivera', 'Caleb', 'Ramos', 6, 'MALE', '09653300007', 'Mila Rivera', '09983330007'),
(38, '136700003008', 'Gomez', 'Rhea', 'Aquino', 7, 'FEMALE', '09653300008', 'Eric Gomez', '09983330008'),
(39, '136700003009', 'Perez', 'Liam', 'Valdez', 6, 'MALE', '09653300009', 'Joy Perez', '09983330009'),
(40, '136700003010', 'Diaz', 'Nina', 'Domingo', 7, 'FEMALE', '09653300010', 'Tony Diaz', '09983330010'),
(41, '136700003011', 'Castro', 'Ethan', 'Salazar', 6, 'MALE', '09653300011', 'Ivy Castro', '09983330011'),
(42, '136700003012', 'Ramos', 'Zoe', 'Navarro', 7, 'FEMALE', '09653300012', 'Leo Ramos', '09983330012'),
(43, '136700003013', 'Aquino', 'Mark', 'Mendoza', 6, 'MALE', '09653300013', 'Rica Aquino', '09983330013'),
(44, '136700003014', 'Morales', 'Luna', 'Ortega', 7, 'FEMALE', '09653300014', 'Dan Morales', '09983330014'),
(45, '136700003015', 'Valdez', 'Sean', 'Aguilar', 6, 'MALE', '09653300015', 'Beth Valdez', '09983330015'),
(46, '136700003016', 'Domingo', 'Faye', 'Padilla', 7, 'FEMALE', '09653300016', 'Paul Domingo', '09983330016'),
(47, '136700003017', 'Salazar', 'Luke', 'Vega', 6, 'MALE', '09653300017', 'Anne Salazar', '09983330017'),
(48, '136700003018', 'Navarro', 'Iris', 'Silva', 7, 'FEMALE', '09653300018', 'Eric Navarro', '09983330018'),
(49, '136700003019', 'Mendoza', 'Paul', 'Cortez', 6, 'MALE', '09653300019', 'Kaye Mendoza', '09983330019'),
(50, '136700003020', 'Ortega', 'Mia', 'Bautista', 7, 'FEMALE', '09653300020', 'Tess Ortega', '09983330020'),
(51, '136700003021', 'Padilla', 'Noah', 'Rosales', 6, 'MALE', '09653300021', 'Mark Padilla', '09983330021'),
(52, '136700003022', 'Aguilar', 'Elle', 'Serrano', 7, 'FEMALE', '09653300022', 'Anne Aguilar', '09983330022'),
(53, '136700003023', 'Vega', 'Ryan', 'Pascual', 6, 'MALE', '09653300023', 'Ralph Vega', '09983330023'),
(54, '136700003024', 'Silva', 'Gia', 'Reyes', 7, 'FEMALE', '09653300024', 'Ella Silva', '09983330024'),
(55, '136700003025', 'Cortez', 'Ian', 'Garcia', 6, 'MALE', '09653300025', 'Noel Cortez', '09983330025'),
(56, '136700003026', 'Bautista', 'Kara', 'Cruz', 7, 'FEMALE', '09653300026', 'Maya Bautista', '09983330026'),
(57, '136700003027', 'Rosales', 'Tom', 'Flores', 6, 'MALE', '09653300027', 'Omar Rosales', '09983330027'),
(58, '136700003028', 'Serrano', 'Liza', 'Rivera', 7, 'FEMALE', '09653300028', 'Joy Serrano', '09983330028'),
(59, '136700003029', 'Pascual', 'Jude', 'Gomez', 6, 'MALE', '09653300029', 'Nico Pascual', '09983330029'),
(60, '136700003030', 'Reyes', 'Ava', 'Perez', 7, 'FEMALE', '09653300030', 'Liam Reyes', '09983330030');

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade1lansonessupplies`
--

CREATE TABLE `tblgrade1lansonessupplies` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `notebooks` varchar(50) DEFAULT NULL,
  `padpaper` varchar(50) DEFAULT NULL,
  `bag` varchar(50) DEFAULT NULL,
  `ballpen` varchar(50) DEFAULT NULL,
  `pencil` varchar(50) DEFAULT NULL,
  `sharpener` varchar(50) DEFAULT NULL,
  `crayons` varchar(50) DEFAULT NULL,
  `eraser` varchar(50) DEFAULT NULL,
  `ruler` varchar(50) DEFAULT NULL,
  `scissors` varchar(50) DEFAULT NULL,
  `glue` varchar(50) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade1lansonesuniform`
--

CREATE TABLE `tblgrade1lansonesuniform` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `pe_tshirt` varchar(10) DEFAULT NULL,
  `pe_pants` varchar(10) DEFAULT NULL,
  `socks` varchar(10) DEFAULT NULL,
  `shoes` varchar(10) DEFAULT NULL,
  `school_uniform` varchar(10) DEFAULT NULL,
  `uniform_bottom` varchar(10) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade1mansanas`
--

CREATE TABLE `tblgrade1mansanas` (
  `id` int(10) UNSIGNED NOT NULL,
  `lrn_number` varchar(20) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) NOT NULL,
  `age` int(10) UNSIGNED NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `contact_number` varchar(15) NOT NULL,
  `parent_name` varchar(100) NOT NULL,
  `parent_contact` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tblgrade1mansanas`
--

INSERT INTO `tblgrade1mansanas` (`id`, `lrn_number`, `last_name`, `first_name`, `middle_name`, `age`, `gender`, `contact_number`, `parent_name`, `parent_contact`) VALUES
(31, '136700004001', 'Santos', 'Eli', 'Lopez', 6, 'MALE', '09654400001', 'Ana Santos', '09984440001'),
(32, '136700004002', 'Cruz', 'Mika', 'Torres', 7, 'FEMALE', '09654400002', 'Marco Cruz', '09984440002'),
(33, '136700004003', 'Garcia', 'Theo', 'Diaz', 6, 'MALE', '09654400003', 'Liza Garcia', '09984440003'),
(34, '136700004004', 'Reyes', 'Nora', 'Morales', 7, 'FEMALE', '09654400004', 'Ron Reyes', '09984440004'),
(35, '136700004005', 'Torres', 'Ivan', 'Gomez', 6, 'MALE', '09654400005', 'Nina Torres', '09984440005'),
(36, '136700004006', 'Flores', 'Aly', 'Perez', 7, 'FEMALE', '09654400006', 'Ben Flores', '09984440006'),
(37, '136700004007', 'Rivera', 'Caleb', 'Ramos', 6, 'MALE', '09654400007', 'Mila Rivera', '09984440007'),
(38, '136700004008', 'Gomez', 'Rhea', 'Aquino', 7, 'FEMALE', '09654400008', 'Eric Gomez', '09984440008'),
(39, '136700004009', 'Perez', 'Liam', 'Valdez', 6, 'MALE', '09654400009', 'Joy Perez', '09984440009'),
(40, '136700004010', 'Diaz', 'Nina', 'Domingo', 7, 'FEMALE', '09654400010', 'Tony Diaz', '09984440010'),
(41, '136700004011', 'Castro', 'Ethan', 'Salazar', 6, 'MALE', '09654400011', 'Ivy Castro', '09984440011'),
(42, '136700004012', 'Ramos', 'Zoe', 'Navarro', 7, 'FEMALE', '09654400012', 'Leo Ramos', '09984440012'),
(43, '136700004013', 'Aquino', 'Mark', 'Mendoza', 6, 'MALE', '09654440013', 'Rica Aquino', '09984440013'),
(44, '136700004014', 'Morales', 'Luna', 'Ortega', 7, 'FEMALE', '09654400014', 'Dan Morales', '09984440014'),
(45, '136700004015', 'Valdez', 'Sean', 'Aguilar', 6, 'MALE', '09654400015', 'Beth Valdez', '09984440015'),
(46, '136700004016', 'Domingo', 'Faye', 'Padilla', 7, 'FEMALE', '09654400016', 'Paul Domingo', '09984440016'),
(47, '136700004017', 'Salazar', 'Luke', 'Vega', 6, 'MALE', '09654400017', 'Anne Salazar', '09984440017'),
(48, '136700004018', 'Navarro', 'Iris', 'Silva', 7, 'FEMALE', '09654400018', 'Eric Navarro', '09984440018'),
(49, '136700004019', 'Mendoza', 'Paul', 'Cortez', 6, 'MALE', '09654400019', 'Kaye Mendoza', '09984440019'),
(50, '136700004020', 'Ortega', 'Mia', 'Bautista', 7, 'FEMALE', '09654400020', 'Tess Ortega', '09984440020'),
(51, '136700004021', 'Padilla', 'Noah', 'Rosales', 6, 'MALE', '09654400021', 'Mark Padilla', '09984440021'),
(52, '136700004022', 'Aguilar', 'Elle', 'Serrano', 7, 'FEMALE', '09654400022', 'Anne Aguilar', '09984440022'),
(53, '136700004023', 'Vega', 'Ryan', 'Pascual', 6, 'MALE', '09654400023', 'Ralph Vega', '09984440023'),
(54, '136700004024', 'Silva', 'Gia', 'Reyes', 7, 'FEMALE', '09654400024', 'Ella Silva', '09984440024'),
(55, '136700004025', 'Cortez', 'Ian', 'Garcia', 6, 'MALE', '09654400025', 'Noel Cortez', '09984440025'),
(56, '136700004026', 'Bautista', 'Kara', 'Cruz', 7, 'FEMALE', '09654400026', 'Maya Bautista', '09984440026'),
(57, '136700004027', 'Rosales', 'Tom', 'Flores', 6, 'MALE', '09654400027', 'Omar Rosales', '09984440027'),
(58, '136700004028', 'Serrano', 'Liza', 'Rivera', 7, 'FEMALE', '09654400028', 'Joy Serrano', '09984440028'),
(59, '136700004029', 'Pascual', 'Jude', 'Gomez', 6, 'MALE', '09654400029', 'Nico Pascual', '09984440029'),
(60, '136700004030', 'Reyes', 'Ava', 'Perez', 7, 'FEMALE', '09654400030', 'Liam Reyes', '09984440030');

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade1mansanassupplies`
--

CREATE TABLE `tblgrade1mansanassupplies` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `notebooks` varchar(50) DEFAULT NULL,
  `padpaper` varchar(50) DEFAULT NULL,
  `bag` varchar(50) DEFAULT NULL,
  `ballpen` varchar(50) DEFAULT NULL,
  `pencil` varchar(50) DEFAULT NULL,
  `sharpener` varchar(50) DEFAULT NULL,
  `crayons` varchar(50) DEFAULT NULL,
  `eraser` varchar(50) DEFAULT NULL,
  `ruler` varchar(50) DEFAULT NULL,
  `scissors` varchar(50) DEFAULT NULL,
  `glue` varchar(50) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade1mansanasuniform`
--

CREATE TABLE `tblgrade1mansanasuniform` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `pe_tshirt` varchar(10) DEFAULT NULL,
  `pe_pants` varchar(10) DEFAULT NULL,
  `socks` varchar(10) DEFAULT NULL,
  `shoes` varchar(10) DEFAULT NULL,
  `school_uniform` varchar(10) DEFAULT NULL,
  `uniform_bottom` varchar(10) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade1rambutan`
--

CREATE TABLE `tblgrade1rambutan` (
  `id` int(10) UNSIGNED NOT NULL,
  `lrn_number` varchar(20) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) NOT NULL,
  `age` int(10) UNSIGNED NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `contact_number` varchar(15) NOT NULL,
  `parent_name` varchar(100) NOT NULL,
  `parent_contact` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tblgrade1rambutan`
--

INSERT INTO `tblgrade1rambutan` (`id`, `lrn_number`, `last_name`, `first_name`, `middle_name`, `age`, `gender`, `contact_number`, `parent_name`, `parent_contact`) VALUES
(31, '136700005001', 'Santos', 'Marco', 'Lopez', 6, 'MALE', '09655500001', 'Ana Santos', '09985550001'),
(32, '136700005002', 'Cruz', 'Aira', 'Torres', 7, 'FEMALE', '09655500002', 'Marco Cruz', '09985550002'),
(33, '136700005003', 'Garcia', 'Theo', 'Diaz', 6, 'MALE', '09655500003', 'Liza Garcia', '09985550003'),
(34, '136700005004', 'Reyes', 'Nina', 'Morales', 7, 'FEMALE', '09655500004', 'Ron Reyes', '09985550004'),
(35, '136700005005', 'Torres', 'Ivan', 'Gomez', 6, 'MALE', '09655500005', 'Nina Torres', '09985550005'),
(36, '136700005006', 'Flores', 'Mia', 'Perez', 7, 'FEMALE', '09655500006', 'Ben Flores', '09985550006'),
(37, '136700005007', 'Rivera', 'Caleb', 'Ramos', 6, 'MALE', '09655500007', 'Mila Rivera', '09985550007'),
(38, '136700005008', 'Gomez', 'Rhea', 'Aquino', 7, 'FEMALE', '09655500008', 'Eric Gomez', '09985550008'),
(39, '136700005009', 'Perez', 'Liam', 'Valdez', 6, 'MALE', '09655500009', 'Joy Perez', '09985550009'),
(40, '136700005010', 'Diaz', 'Nora', 'Domingo', 7, 'FEMALE', '09655500010', 'Tony Diaz', '09985550010'),
(41, '136700005011', 'Castro', 'Ethan', 'Salazar', 6, 'MALE', '09655500011', 'Ivy Castro', '09985550011'),
(42, '136700005012', 'Ramos', 'Zoe', 'Navarro', 7, 'FEMALE', '09655500012', 'Leo Ramos', '09985550012'),
(43, '136700005013', 'Aquino', 'Mark', 'Mendoza', 6, 'MALE', '09655500013', 'Rica Aquino', '09985550013'),
(44, '136700005014', 'Morales', 'Luna', 'Ortega', 7, 'FEMALE', '09655500014', 'Dan Morales', '09985550014'),
(45, '136700005015', 'Valdez', 'Sean', 'Aguilar', 6, 'MALE', '09655500015', 'Beth Valdez', '09985550015'),
(46, '136700005016', 'Domingo', 'Faye', 'Padilla', 7, 'FEMALE', '09655500016', 'Paul Domingo', '09985550016'),
(47, '136700005017', 'Salazar', 'Luke', 'Vega', 6, 'MALE', '09655500017', 'Anne Salazar', '09985550017'),
(48, '136700005018', 'Navarro', 'Iris', 'Silva', 7, 'FEMALE', '09655500018', 'Eric Navarro', '09985550018'),
(49, '136700005019', 'Mendoza', 'Paul', 'Cortez', 6, 'MALE', '09655500019', 'Kaye Mendoza', '09985550019'),
(50, '136700005020', 'Ortega', 'Mia', 'Bautista', 7, 'FEMALE', '09655500020', 'Tess Ortega', '09985550020'),
(51, '136700005021', 'Padilla', 'Noah', 'Rosales', 6, 'MALE', '09655500021', 'Mark Padilla', '09985550021'),
(52, '136700005022', 'Aguilar', 'Elle', 'Serrano', 7, 'FEMALE', '09655500022', 'Anne Aguilar', '09985550022'),
(53, '136700005023', 'Vega', 'Ryan', 'Pascual', 6, 'MALE', '09655500023', 'Ralph Vega', '09985550023'),
(54, '136700005024', 'Silva', 'Gia', 'Reyes', 7, 'FEMALE', '09655500024', 'Ella Silva', '09985550024'),
(55, '136700005025', 'Cortez', 'Ian', 'Garcia', 6, 'MALE', '09655500025', 'Noel Cortez', '09985550025'),
(56, '136700005026', 'Bautista', 'Kara', 'Cruz', 7, 'FEMALE', '09655500026', 'Maya Bautista', '09985550026'),
(57, '136700005027', 'Rosales', 'Tom', 'Flores', 6, 'MALE', '09655500027', 'Omar Rosales', '09985550027'),
(58, '136700005028', 'Serrano', 'Liza', 'Rivera', 7, 'FEMALE', '09655500028', 'Joy Serrano', '09985550028'),
(59, '136700005029', 'Pascual', 'Jude', 'Gomez', 6, 'MALE', '09655500029', 'Nico Pascual', '09985550029'),
(60, '136700005030', 'Reyes', 'Ava', 'Perez', 7, 'FEMALE', '09655500030', 'Liam Reyes', '09985550030');

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade1rambutansupplies`
--

CREATE TABLE `tblgrade1rambutansupplies` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `notebooks` varchar(50) DEFAULT NULL,
  `padpaper` varchar(50) DEFAULT NULL,
  `bag` varchar(50) DEFAULT NULL,
  `ballpen` varchar(50) DEFAULT NULL,
  `pencil` varchar(50) DEFAULT NULL,
  `sharpener` varchar(50) DEFAULT NULL,
  `crayons` varchar(50) DEFAULT NULL,
  `eraser` varchar(50) DEFAULT NULL,
  `ruler` varchar(50) DEFAULT NULL,
  `scissors` varchar(50) DEFAULT NULL,
  `glue` varchar(50) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade1rambutanuniform`
--

CREATE TABLE `tblgrade1rambutanuniform` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `pe_tshirt` varchar(10) DEFAULT NULL,
  `pe_pants` varchar(10) DEFAULT NULL,
  `socks` varchar(10) DEFAULT NULL,
  `shoes` varchar(10) DEFAULT NULL,
  `school_uniform` varchar(10) DEFAULT NULL,
  `uniform_bottom` varchar(10) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade1saging`
--

CREATE TABLE `tblgrade1saging` (
  `id` int(10) UNSIGNED NOT NULL,
  `lrn_number` varchar(20) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) NOT NULL,
  `age` int(10) UNSIGNED NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `contact_number` varchar(15) NOT NULL,
  `parent_name` varchar(100) NOT NULL,
  `parent_contact` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tblgrade1saging`
--

INSERT INTO `tblgrade1saging` (`id`, `lrn_number`, `last_name`, `first_name`, `middle_name`, `age`, `gender`, `contact_number`, `parent_name`, `parent_contact`) VALUES
(31, '136700006001', 'Santos', 'Evan', 'Lopez', 6, 'MALE', '09656600001', 'Ana Santos', '09986660001'),
(32, '136700006002', 'Cruz', 'Mia', 'Torres', 7, 'FEMALE', '09656600002', 'Marco Cruz', '09986660002'),
(33, '136700006003', 'Garcia', 'Noah', 'Diaz', 6, 'MALE', '09656600003', 'Liza Garcia', '09986660003'),
(34, '136700006004', 'Reyes', 'Luna', 'Morales', 7, 'FEMALE', '09656600004', 'Ron Reyes', '09986660004'),
(35, '136700006005', 'Torres', 'Kyle', 'Gomez', 6, 'MALE', '09656600005', 'Nina Torres', '09986660005'),
(36, '136700006006', 'Flores', 'Ivy', 'Perez', 7, 'FEMALE', '09656600006', 'Ben Flores', '09986660006'),
(37, '136700006007', 'Rivera', 'Caleb', 'Ramos', 6, 'MALE', '09656600007', 'Mila Rivera', '09986660007'),
(38, '136700006008', 'Gomez', 'Rhea', 'Aquino', 7, 'FEMALE', '09656600008', 'Eric Gomez', '09986660008'),
(39, '136700006009', 'Perez', 'Liam', 'Valdez', 6, 'MALE', '09656600009', 'Joy Perez', '09986660009'),
(40, '136700006010', 'Diaz', 'Nina', 'Domingo', 7, 'FEMALE', '09656600010', 'Tony Diaz', '09986660010'),
(41, '136700006011', 'Castro', 'Ethan', 'Salazar', 6, 'MALE', '09656600011', 'Ivy Castro', '09986660011'),
(42, '136700006012', 'Ramos', 'Zoe', 'Navarro', 7, 'FEMALE', '09656600012', 'Leo Ramos', '09986660012'),
(43, '136700006013', 'Aquino', 'Mark', 'Mendoza', 6, 'MALE', '09656600013', 'Rica Aquino', '09986660013'),
(44, '136700006014', 'Morales', 'Faye', 'Ortega', 7, 'FEMALE', '09656600014', 'Dan Morales', '09986660014'),
(45, '136700006015', 'Valdez', 'Sean', 'Aguilar', 6, 'MALE', '09656600015', 'Beth Valdez', '09986660015'),
(46, '136700006016', 'Domingo', 'Iris', 'Padilla', 7, 'FEMALE', '09656600016', 'Paul Domingo', '09986660016'),
(47, '136700006017', 'Salazar', 'Luke', 'Vega', 6, 'MALE', '09656600017', 'Anne Salazar', '09986660017'),
(48, '136700006018', 'Navarro', 'Gia', 'Silva', 7, 'FEMALE', '09656600018', 'Eric Navarro', '09986660018'),
(49, '136700006019', 'Mendoza', 'Paul', 'Cortez', 6, 'MALE', '09656600019', 'Kaye Mendoza', '09986660019'),
(50, '136700006020', 'Ortega', 'Mia', 'Bautista', 7, 'FEMALE', '09656600020', 'Tess Ortega', '09986660020'),
(51, '136700006021', 'Padilla', 'Noah', 'Rosales', 6, 'MALE', '09656600021', 'Mark Padilla', '09986660021'),
(52, '136700006022', 'Aguilar', 'Elle', 'Serrano', 7, 'FEMALE', '09656600022', 'Anne Aguilar', '09986660022'),
(53, '136700006023', 'Vega', 'Ryan', 'Pascual', 6, 'MALE', '09656600023', 'Ralph Vega', '09986660023'),
(54, '136700006024', 'Silva', 'Aly', 'Reyes', 7, 'FEMALE', '09656600024', 'Ella Silva', '09986660024'),
(55, '136700006025', 'Cortez', 'Ian', 'Garcia', 6, 'MALE', '09656600025', 'Noel Cortez', '09986660025'),
(56, '136700006026', 'Bautista', 'Kara', 'Cruz', 7, 'FEMALE', '09656600026', 'Maya Bautista', '09986660026'),
(57, '136700006027', 'Rosales', 'Tom', 'Flores', 6, 'MALE', '09656600027', 'Omar Rosales', '09986660027'),
(58, '136700006028', 'Serrano', 'Liza', 'Rivera', 7, 'FEMALE', '09656600028', 'Joy Serrano', '09986660028'),
(59, '136700006029', 'Pascual', 'Jude', 'Gomez', 6, 'MALE', '09656600029', 'Nico Pascual', '09986660029'),
(60, '136700006030', 'Reyes', 'Ava', 'Perez', 7, 'FEMALE', '09656600030', 'Liam Reyes', '09986660030');

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade1sagingsupplies`
--

CREATE TABLE `tblgrade1sagingsupplies` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `notebooks` varchar(50) DEFAULT NULL,
  `padpaper` varchar(50) DEFAULT NULL,
  `bag` varchar(50) DEFAULT NULL,
  `ballpen` varchar(50) DEFAULT NULL,
  `pencil` varchar(50) DEFAULT NULL,
  `sharpener` varchar(50) DEFAULT NULL,
  `crayons` varchar(50) DEFAULT NULL,
  `eraser` varchar(50) DEFAULT NULL,
  `ruler` varchar(50) DEFAULT NULL,
  `scissors` varchar(50) DEFAULT NULL,
  `glue` varchar(50) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade1saginguniform`
--

CREATE TABLE `tblgrade1saginguniform` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `pe_tshirt` varchar(10) DEFAULT NULL,
  `pe_pants` varchar(10) DEFAULT NULL,
  `socks` varchar(10) DEFAULT NULL,
  `shoes` varchar(10) DEFAULT NULL,
  `school_uniform` varchar(10) DEFAULT NULL,
  `uniform_bottom` varchar(10) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade1tsiko`
--

CREATE TABLE `tblgrade1tsiko` (
  `id` int(10) UNSIGNED NOT NULL,
  `lrn_number` varchar(20) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) NOT NULL,
  `age` int(10) UNSIGNED NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `contact_number` varchar(15) NOT NULL,
  `parent_name` varchar(100) NOT NULL,
  `parent_contact` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tblgrade1tsiko`
--

INSERT INTO `tblgrade1tsiko` (`id`, `lrn_number`, `last_name`, `first_name`, `middle_name`, `age`, `gender`, `contact_number`, `parent_name`, `parent_contact`) VALUES
(31, '136700007001', 'Santos', 'Marco', 'Lopez', 6, 'MALE', '09657700001', 'Ana Santos', '09987770001'),
(32, '136700007002', 'Cruz', 'Aira', 'Torres', 7, 'FEMALE', '09657700002', 'Marco Cruz', '09987770002'),
(33, '136700007003', 'Garcia', 'Theo', 'Diaz', 6, 'MALE', '09657700003', 'Liza Garcia', '09987770003'),
(34, '136700007004', 'Reyes', 'Nina', 'Morales', 7, 'FEMALE', '09657700004', 'Ron Reyes', '09987770004'),
(35, '136700007005', 'Torres', 'Ivan', 'Gomez', 6, 'MALE', '09657700005', 'Nina Torres', '09987770005'),
(36, '136700007006', 'Flores', 'Mia', 'Perez', 7, 'FEMALE', '09657700006', 'Ben Flores', '09987770006'),
(37, '136700007007', 'Rivera', 'Caleb', 'Ramos', 6, 'MALE', '09657700007', 'Mila Rivera', '09987770007'),
(38, '136700007008', 'Gomez', 'Rhea', 'Aquino', 7, 'FEMALE', '09657700008', 'Eric Gomez', '09987770008'),
(39, '136700007009', 'Perez', 'Liam', 'Valdez', 6, 'MALE', '09657700009', 'Joy Perez', '09987770009'),
(40, '136700007010', 'Diaz', 'Nora', 'Domingo', 7, 'FEMALE', '09657700010', 'Tony Diaz', '09987770010'),
(41, '136700007011', 'Castro', 'Ethan', 'Salazar', 6, 'MALE', '09657700011', 'Ivy Castro', '09987770011'),
(42, '136700007012', 'Ramos', 'Zoe', 'Navarro', 7, 'FEMALE', '09657700012', 'Leo Ramos', '09987770012'),
(43, '136700007013', 'Aquino', 'Mark', 'Mendoza', 6, 'MALE', '09657700013', 'Rica Aquino', '09987770013'),
(44, '136700007014', 'Morales', 'Luna', 'Ortega', 7, 'FEMALE', '09657700014', 'Dan Morales', '09987770014'),
(45, '136700007015', 'Valdez', 'Sean', 'Aguilar', 6, 'MALE', '09657700015', 'Beth Valdez', '09987770015'),
(46, '136700007016', 'Domingo', 'Faye', 'Padilla', 7, 'FEMALE', '09657700016', 'Paul Domingo', '09987770016'),
(47, '136700007017', 'Salazar', 'Luke', 'Vega', 6, 'MALE', '09657700017', 'Anne Salazar', '09987770017'),
(48, '136700007018', 'Navarro', 'Iris', 'Silva', 7, 'FEMALE', '09657700018', 'Eric Navarro', '09987770018'),
(49, '136700007019', 'Mendoza', 'Paul', 'Cortez', 6, 'MALE', '09657700019', 'Kaye Mendoza', '09987770019'),
(50, '136700007020', 'Ortega', 'Mia', 'Bautista', 7, 'FEMALE', '09657700020', 'Tess Ortega', '09987770020'),
(51, '136700007021', 'Padilla', 'Noah', 'Rosales', 6, 'MALE', '09657700021', 'Mark Padilla', '09987770021'),
(52, '136700007022', 'Aguilar', 'Elle', 'Serrano', 7, 'FEMALE', '09657700022', 'Anne Aguilar', '09987770022'),
(53, '136700007023', 'Vega', 'Ryan', 'Pascual', 6, 'MALE', '09657700023', 'Ralph Vega', '09987770023'),
(54, '136700007024', 'Silva', 'Gia', 'Reyes', 7, 'FEMALE', '09657700024', 'Ella Silva', '09987770024'),
(55, '136700007025', 'Cortez', 'Ian', 'Garcia', 6, 'MALE', '09657700025', 'Noel Cortez', '09987770025'),
(56, '136700007026', 'Bautista', 'Kara', 'Cruz', 7, 'FEMALE', '09657700026', 'Maya Bautista', '09987770026'),
(57, '136700007027', 'Rosales', 'Tom', 'Flores', 6, 'MALE', '09657700027', 'Omar Rosales', '09987770027'),
(58, '136700007028', 'Serrano', 'Liza', 'Rivera', 7, 'FEMALE', '09657700028', 'Joy Serrano', '09987770028'),
(59, '136700007029', 'Pascual', 'Jude', 'Gomez', 6, 'MALE', '09657700029', 'Nico Pascual', '09987770029'),
(60, '136700007030', 'Reyes', 'Ava', 'Perez', 7, 'FEMALE', '09657700030', 'Liam Reyes', '09987770030');

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade1tsikosupplies`
--

CREATE TABLE `tblgrade1tsikosupplies` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `notebooks` varchar(50) DEFAULT NULL,
  `padpaper` varchar(50) DEFAULT NULL,
  `bag` varchar(50) DEFAULT NULL,
  `ballpen` varchar(50) DEFAULT NULL,
  `pencil` varchar(50) DEFAULT NULL,
  `sharpener` varchar(50) DEFAULT NULL,
  `crayons` varchar(50) DEFAULT NULL,
  `eraser` varchar(50) DEFAULT NULL,
  `ruler` varchar(50) DEFAULT NULL,
  `scissors` varchar(50) DEFAULT NULL,
  `glue` varchar(50) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade1tsikouniform`
--

CREATE TABLE `tblgrade1tsikouniform` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `pe_tshirt` varchar(10) DEFAULT NULL,
  `pe_pants` varchar(10) DEFAULT NULL,
  `socks` varchar(10) DEFAULT NULL,
  `shoes` varchar(10) DEFAULT NULL,
  `school_uniform` varchar(10) DEFAULT NULL,
  `uniform_bottom` varchar(10) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade1ubas`
--

CREATE TABLE `tblgrade1ubas` (
  `id` int(10) UNSIGNED NOT NULL,
  `lrn_number` varchar(20) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) NOT NULL,
  `age` int(10) UNSIGNED NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `contact_number` varchar(15) NOT NULL,
  `parent_name` varchar(100) NOT NULL,
  `parent_contact` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tblgrade1ubas`
--

INSERT INTO `tblgrade1ubas` (`id`, `lrn_number`, `last_name`, `first_name`, `middle_name`, `age`, `gender`, `contact_number`, `parent_name`, `parent_contact`) VALUES
(31, '136700008001', 'Santos', 'Evan', 'Lopez', 6, 'MALE', '09658800001', 'Ana Santos', '09988880001'),
(32, '136700008002', 'Cruz', 'Mia', 'Torres', 7, 'FEMALE', '09658800002', 'Marco Cruz', '09988880002'),
(33, '136700008003', 'Garcia', 'Noah', 'Diaz', 6, 'MALE', '09658800003', 'Liza Garcia', '09988880003'),
(34, '136700008004', 'Reyes', 'Luna', 'Morales', 7, 'FEMALE', '09658800004', 'Ron Reyes', '09988880004'),
(35, '136700008005', 'Torres', 'Kyle', 'Gomez', 6, 'MALE', '09658800005', 'Nina Torres', '09988880005'),
(36, '136700008006', 'Flores', 'Ivy', 'Perez', 7, 'FEMALE', '09658800006', 'Ben Flores', '09988880006'),
(37, '136700008007', 'Rivera', 'Caleb', 'Ramos', 6, 'MALE', '09658800007', 'Mila Rivera', '09988880007'),
(38, '136700008008', 'Gomez', 'Rhea', 'Aquino', 7, 'FEMALE', '09658800008', 'Eric Gomez', '09988880008'),
(39, '136700008009', 'Perez', 'Liam', 'Valdez', 6, 'MALE', '09658800009', 'Joy Perez', '09988880009'),
(40, '136700008010', 'Diaz', 'Nina', 'Domingo', 7, 'FEMALE', '09658800010', 'Tony Diaz', '09988880010'),
(41, '136700008011', 'Castro', 'Ethan', 'Salazar', 6, 'MALE', '09658800011', 'Ivy Castro', '09988880011'),
(42, '136700008012', 'Ramos', 'Zoe', 'Navarro', 7, 'FEMALE', '09658800012', 'Leo Ramos', '09988880012'),
(43, '136700008013', 'Aquino', 'Mark', 'Mendoza', 6, 'MALE', '09658800013', 'Rica Aquino', '09988880013'),
(44, '136700008014', 'Morales', 'Faye', 'Ortega', 7, 'FEMALE', '09658800014', 'Dan Morales', '09988880014'),
(45, '136700008015', 'Valdez', 'Sean', 'Aguilar', 6, 'MALE', '09658800015', 'Beth Valdez', '09988880015'),
(46, '136700008016', 'Domingo', 'Iris', 'Padilla', 7, 'FEMALE', '09658800016', 'Paul Domingo', '09988880016'),
(47, '136700008017', 'Salazar', 'Luke', 'Vega', 6, 'MALE', '09658800017', 'Anne Salazar', '09988880017'),
(48, '136700008018', 'Navarro', 'Gia', 'Silva', 7, 'FEMALE', '09658800018', 'Eric Navarro', '09988880018'),
(49, '136700008019', 'Mendoza', 'Paul', 'Cortez', 6, 'MALE', '09658800019', 'Kaye Mendoza', '09988880019'),
(50, '136700008020', 'Ortega', 'Mia', 'Bautista', 7, 'FEMALE', '09658800020', 'Tess Ortega', '09988880020'),
(51, '136700008021', 'Padilla', 'Noah', 'Rosales', 6, 'MALE', '09658800021', 'Mark Padilla', '09988880021'),
(52, '136700008022', 'Aguilar', 'Elle', 'Serrano', 7, 'FEMALE', '09658800022', 'Anne Aguilar', '09988880022'),
(53, '136700008023', 'Vega', 'Ryan', 'Pascual', 6, 'MALE', '09658800023', 'Ralph Vega', '09988880023'),
(54, '136700008024', 'Silva', 'Aly', 'Reyes', 7, 'FEMALE', '09658800024', 'Ella Silva', '09988880024'),
(55, '136700008025', 'Cortez', 'Ian', 'Garcia', 6, 'MALE', '09658800025', 'Noel Cortez', '09988880025'),
(56, '136700008026', 'Bautista', 'Kara', 'Cruz', 7, 'FEMALE', '09658800026', 'Maya Bautista', '09988880026'),
(57, '136700008027', 'Rosales', 'Tom', 'Flores', 6, 'MALE', '09658800027', 'Omar Rosales', '09988880027'),
(58, '136700008028', 'Serrano', 'Liza', 'Rivera', 7, 'FEMALE', '09658800028', 'Joy Serrano', '09988880028'),
(59, '136700008029', 'Pascual', 'Jude', 'Gomez', 6, 'MALE', '09658800029', 'Nico Pascual', '09988880029'),
(60, '136700008030', 'Reyes', 'Ava', 'Perez', 7, 'FEMALE', '09658800030', 'Liam Reyes', '09988880030');

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade1ubassupplies`
--

CREATE TABLE `tblgrade1ubassupplies` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `notebooks` varchar(50) DEFAULT NULL,
  `padpaper` varchar(50) DEFAULT NULL,
  `bag` varchar(50) DEFAULT NULL,
  `ballpen` varchar(50) DEFAULT NULL,
  `pencil` varchar(50) DEFAULT NULL,
  `sharpener` varchar(50) DEFAULT NULL,
  `crayons` varchar(50) DEFAULT NULL,
  `eraser` varchar(50) DEFAULT NULL,
  `ruler` varchar(50) DEFAULT NULL,
  `scissors` varchar(50) DEFAULT NULL,
  `glue` varchar(50) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade1ubasuniform`
--

CREATE TABLE `tblgrade1ubasuniform` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `pe_tshirt` varchar(10) DEFAULT NULL,
  `pe_pants` varchar(10) DEFAULT NULL,
  `socks` varchar(10) DEFAULT NULL,
  `shoes` varchar(10) DEFAULT NULL,
  `school_uniform` varchar(10) DEFAULT NULL,
  `uniform_bottom` varchar(10) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade2anthurium`
--

CREATE TABLE `tblgrade2anthurium` (
  `id` int(10) UNSIGNED NOT NULL,
  `lrn_number` varchar(20) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) NOT NULL,
  `age` int(10) UNSIGNED NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `contact_number` varchar(15) NOT NULL,
  `parent_name` varchar(100) NOT NULL,
  `parent_contact` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade2anthuriumsupplies`
--

CREATE TABLE `tblgrade2anthuriumsupplies` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `notebooks` varchar(50) DEFAULT NULL,
  `padpaper` varchar(50) DEFAULT NULL,
  `bag` varchar(50) DEFAULT NULL,
  `ballpen` varchar(50) DEFAULT NULL,
  `pencil` varchar(50) DEFAULT NULL,
  `sharpener` varchar(50) DEFAULT NULL,
  `crayons` varchar(50) DEFAULT NULL,
  `eraser` varchar(50) DEFAULT NULL,
  `ruler` varchar(50) DEFAULT NULL,
  `scissors` varchar(50) DEFAULT NULL,
  `glue` varchar(50) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade2anthuriumuniform`
--

CREATE TABLE `tblgrade2anthuriumuniform` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `pe_tshirt` varchar(10) DEFAULT NULL,
  `pe_pants` varchar(10) DEFAULT NULL,
  `socks` varchar(10) DEFAULT NULL,
  `shoes` varchar(10) DEFAULT NULL,
  `school_uniform` varchar(10) DEFAULT NULL,
  `uniform_bottom` varchar(10) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade2bougainvillea`
--

CREATE TABLE `tblgrade2bougainvillea` (
  `id` int(10) UNSIGNED NOT NULL,
  `lrn_number` varchar(20) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) NOT NULL,
  `age` int(10) UNSIGNED NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `contact_number` varchar(15) NOT NULL,
  `parent_name` varchar(100) NOT NULL,
  `parent_contact` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade2bougainvilleasupplies`
--

CREATE TABLE `tblgrade2bougainvilleasupplies` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `notebooks` varchar(50) DEFAULT NULL,
  `padpaper` varchar(50) DEFAULT NULL,
  `bag` varchar(50) DEFAULT NULL,
  `ballpen` varchar(50) DEFAULT NULL,
  `pencil` varchar(50) DEFAULT NULL,
  `sharpener` varchar(50) DEFAULT NULL,
  `crayons` varchar(50) DEFAULT NULL,
  `eraser` varchar(50) DEFAULT NULL,
  `ruler` varchar(50) DEFAULT NULL,
  `scissors` varchar(50) DEFAULT NULL,
  `glue` varchar(50) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade2bougainvilleauniform`
--

CREATE TABLE `tblgrade2bougainvilleauniform` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `pe_tshirt` varchar(10) DEFAULT NULL,
  `pe_pants` varchar(10) DEFAULT NULL,
  `socks` varchar(10) DEFAULT NULL,
  `shoes` varchar(10) DEFAULT NULL,
  `school_uniform` varchar(10) DEFAULT NULL,
  `uniform_bottom` varchar(10) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade2camia`
--

CREATE TABLE `tblgrade2camia` (
  `id` int(10) UNSIGNED NOT NULL,
  `lrn_number` varchar(20) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) NOT NULL,
  `age` int(10) UNSIGNED NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `contact_number` varchar(15) NOT NULL,
  `parent_name` varchar(100) NOT NULL,
  `parent_contact` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade2camiasupplies`
--

CREATE TABLE `tblgrade2camiasupplies` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `notebooks` varchar(50) DEFAULT NULL,
  `padpaper` varchar(50) DEFAULT NULL,
  `bag` varchar(50) DEFAULT NULL,
  `ballpen` varchar(50) DEFAULT NULL,
  `pencil` varchar(50) DEFAULT NULL,
  `sharpener` varchar(50) DEFAULT NULL,
  `crayons` varchar(50) DEFAULT NULL,
  `eraser` varchar(50) DEFAULT NULL,
  `ruler` varchar(50) DEFAULT NULL,
  `scissors` varchar(50) DEFAULT NULL,
  `glue` varchar(50) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade2camiauniform`
--

CREATE TABLE `tblgrade2camiauniform` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `pe_tshirt` varchar(10) DEFAULT NULL,
  `pe_pants` varchar(10) DEFAULT NULL,
  `socks` varchar(10) DEFAULT NULL,
  `shoes` varchar(10) DEFAULT NULL,
  `school_uniform` varchar(10) DEFAULT NULL,
  `uniform_bottom` varchar(10) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade2daisy`
--

CREATE TABLE `tblgrade2daisy` (
  `id` int(10) UNSIGNED NOT NULL,
  `lrn_number` varchar(20) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) NOT NULL,
  `age` int(10) UNSIGNED NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `contact_number` varchar(15) NOT NULL,
  `parent_name` varchar(100) NOT NULL,
  `parent_contact` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade2daisysupplies`
--

CREATE TABLE `tblgrade2daisysupplies` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `notebooks` varchar(50) DEFAULT NULL,
  `padpaper` varchar(50) DEFAULT NULL,
  `bag` varchar(50) DEFAULT NULL,
  `ballpen` varchar(50) DEFAULT NULL,
  `pencil` varchar(50) DEFAULT NULL,
  `sharpener` varchar(50) DEFAULT NULL,
  `crayons` varchar(50) DEFAULT NULL,
  `eraser` varchar(50) DEFAULT NULL,
  `ruler` varchar(50) DEFAULT NULL,
  `scissors` varchar(50) DEFAULT NULL,
  `glue` varchar(50) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade2daisyuniform`
--

CREATE TABLE `tblgrade2daisyuniform` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `pe_tshirt` varchar(10) DEFAULT NULL,
  `pe_pants` varchar(10) DEFAULT NULL,
  `socks` varchar(10) DEFAULT NULL,
  `shoes` varchar(10) DEFAULT NULL,
  `school_uniform` varchar(10) DEFAULT NULL,
  `uniform_bottom` varchar(10) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade2everlasting`
--

CREATE TABLE `tblgrade2everlasting` (
  `id` int(10) UNSIGNED NOT NULL,
  `lrn_number` varchar(20) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) NOT NULL,
  `age` int(10) UNSIGNED NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `contact_number` varchar(15) NOT NULL,
  `parent_name` varchar(100) NOT NULL,
  `parent_contact` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade2everlastingsupplies`
--

CREATE TABLE `tblgrade2everlastingsupplies` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `notebooks` varchar(50) DEFAULT NULL,
  `padpaper` varchar(50) DEFAULT NULL,
  `bag` varchar(50) DEFAULT NULL,
  `ballpen` varchar(50) DEFAULT NULL,
  `pencil` varchar(50) DEFAULT NULL,
  `sharpener` varchar(50) DEFAULT NULL,
  `crayons` varchar(50) DEFAULT NULL,
  `eraser` varchar(50) DEFAULT NULL,
  `ruler` varchar(50) DEFAULT NULL,
  `scissors` varchar(50) DEFAULT NULL,
  `glue` varchar(50) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade2everlastinguniform`
--

CREATE TABLE `tblgrade2everlastinguniform` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `pe_tshirt` varchar(10) DEFAULT NULL,
  `pe_pants` varchar(10) DEFAULT NULL,
  `socks` varchar(10) DEFAULT NULL,
  `shoes` varchar(10) DEFAULT NULL,
  `school_uniform` varchar(10) DEFAULT NULL,
  `uniform_bottom` varchar(10) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade2gumamela`
--

CREATE TABLE `tblgrade2gumamela` (
  `id` int(10) UNSIGNED NOT NULL,
  `lrn_number` varchar(20) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) NOT NULL,
  `age` int(10) UNSIGNED NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `contact_number` varchar(15) NOT NULL,
  `parent_name` varchar(100) NOT NULL,
  `parent_contact` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade2gumamelasupplies`
--

CREATE TABLE `tblgrade2gumamelasupplies` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `notebooks` varchar(50) DEFAULT NULL,
  `padpaper` varchar(50) DEFAULT NULL,
  `bag` varchar(50) DEFAULT NULL,
  `ballpen` varchar(50) DEFAULT NULL,
  `pencil` varchar(50) DEFAULT NULL,
  `sharpener` varchar(50) DEFAULT NULL,
  `crayons` varchar(50) DEFAULT NULL,
  `eraser` varchar(50) DEFAULT NULL,
  `ruler` varchar(50) DEFAULT NULL,
  `scissors` varchar(50) DEFAULT NULL,
  `glue` varchar(50) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade2gumamelauniform`
--

CREATE TABLE `tblgrade2gumamelauniform` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `pe_tshirt` varchar(10) DEFAULT NULL,
  `pe_pants` varchar(10) DEFAULT NULL,
  `socks` varchar(10) DEFAULT NULL,
  `shoes` varchar(10) DEFAULT NULL,
  `school_uniform` varchar(10) DEFAULT NULL,
  `uniform_bottom` varchar(10) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade2ilang_ilang`
--

CREATE TABLE `tblgrade2ilang_ilang` (
  `id` int(10) UNSIGNED NOT NULL,
  `lrn_number` varchar(20) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) NOT NULL,
  `age` int(10) UNSIGNED NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `contact_number` varchar(15) NOT NULL,
  `parent_name` varchar(100) NOT NULL,
  `parent_contact` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade2ilang_ilangsupplies`
--

CREATE TABLE `tblgrade2ilang_ilangsupplies` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `notebooks` varchar(50) DEFAULT NULL,
  `padpaper` varchar(50) DEFAULT NULL,
  `bag` varchar(50) DEFAULT NULL,
  `ballpen` varchar(50) DEFAULT NULL,
  `pencil` varchar(50) DEFAULT NULL,
  `sharpener` varchar(50) DEFAULT NULL,
  `crayons` varchar(50) DEFAULT NULL,
  `eraser` varchar(50) DEFAULT NULL,
  `ruler` varchar(50) DEFAULT NULL,
  `scissors` varchar(50) DEFAULT NULL,
  `glue` varchar(50) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade2ilang_ilanguniform`
--

CREATE TABLE `tblgrade2ilang_ilanguniform` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `pe_tshirt` varchar(10) DEFAULT NULL,
  `pe_pants` varchar(10) DEFAULT NULL,
  `socks` varchar(10) DEFAULT NULL,
  `shoes` varchar(10) DEFAULT NULL,
  `school_uniform` varchar(10) DEFAULT NULL,
  `uniform_bottom` varchar(10) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade2jasmine`
--

CREATE TABLE `tblgrade2jasmine` (
  `id` int(10) UNSIGNED NOT NULL,
  `lrn_number` varchar(20) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) NOT NULL,
  `age` int(10) UNSIGNED NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `contact_number` varchar(15) NOT NULL,
  `parent_name` varchar(100) NOT NULL,
  `parent_contact` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade2jasminesupplies`
--

CREATE TABLE `tblgrade2jasminesupplies` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `notebooks` varchar(50) DEFAULT NULL,
  `padpaper` varchar(50) DEFAULT NULL,
  `bag` varchar(50) DEFAULT NULL,
  `ballpen` varchar(50) DEFAULT NULL,
  `pencil` varchar(50) DEFAULT NULL,
  `sharpener` varchar(50) DEFAULT NULL,
  `crayons` varchar(50) DEFAULT NULL,
  `eraser` varchar(50) DEFAULT NULL,
  `ruler` varchar(50) DEFAULT NULL,
  `scissors` varchar(50) DEFAULT NULL,
  `glue` varchar(50) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade2jasmineuniform`
--

CREATE TABLE `tblgrade2jasmineuniform` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `pe_tshirt` varchar(10) DEFAULT NULL,
  `pe_pants` varchar(10) DEFAULT NULL,
  `socks` varchar(10) DEFAULT NULL,
  `shoes` varchar(10) DEFAULT NULL,
  `school_uniform` varchar(10) DEFAULT NULL,
  `uniform_bottom` varchar(10) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade2orchids`
--

CREATE TABLE `tblgrade2orchids` (
  `id` int(10) UNSIGNED NOT NULL,
  `lrn_number` varchar(20) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) NOT NULL,
  `age` int(10) UNSIGNED NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `contact_number` varchar(15) NOT NULL,
  `parent_name` varchar(100) NOT NULL,
  `parent_contact` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade2orchidssupplies`
--

CREATE TABLE `tblgrade2orchidssupplies` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `notebooks` varchar(50) DEFAULT NULL,
  `padpaper` varchar(50) DEFAULT NULL,
  `bag` varchar(50) DEFAULT NULL,
  `ballpen` varchar(50) DEFAULT NULL,
  `pencil` varchar(50) DEFAULT NULL,
  `sharpener` varchar(50) DEFAULT NULL,
  `crayons` varchar(50) DEFAULT NULL,
  `eraser` varchar(50) DEFAULT NULL,
  `ruler` varchar(50) DEFAULT NULL,
  `scissors` varchar(50) DEFAULT NULL,
  `glue` varchar(50) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade2orchidsuniform`
--

CREATE TABLE `tblgrade2orchidsuniform` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `pe_tshirt` varchar(10) DEFAULT NULL,
  `pe_pants` varchar(10) DEFAULT NULL,
  `socks` varchar(10) DEFAULT NULL,
  `shoes` varchar(10) DEFAULT NULL,
  `school_uniform` varchar(10) DEFAULT NULL,
  `uniform_bottom` varchar(10) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade2rose`
--

CREATE TABLE `tblgrade2rose` (
  `id` int(10) UNSIGNED NOT NULL,
  `lrn_number` varchar(20) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) NOT NULL,
  `age` int(10) UNSIGNED NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `contact_number` varchar(15) NOT NULL,
  `parent_name` varchar(100) NOT NULL,
  `parent_contact` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade2rosesupplies`
--

CREATE TABLE `tblgrade2rosesupplies` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `notebooks` varchar(50) DEFAULT NULL,
  `padpaper` varchar(50) DEFAULT NULL,
  `bag` varchar(50) DEFAULT NULL,
  `ballpen` varchar(50) DEFAULT NULL,
  `pencil` varchar(50) DEFAULT NULL,
  `sharpener` varchar(50) DEFAULT NULL,
  `crayons` varchar(50) DEFAULT NULL,
  `eraser` varchar(50) DEFAULT NULL,
  `ruler` varchar(50) DEFAULT NULL,
  `scissors` varchar(50) DEFAULT NULL,
  `glue` varchar(50) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade2roseuniform`
--

CREATE TABLE `tblgrade2roseuniform` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `pe_tshirt` varchar(10) DEFAULT NULL,
  `pe_pants` varchar(10) DEFAULT NULL,
  `socks` varchar(10) DEFAULT NULL,
  `shoes` varchar(10) DEFAULT NULL,
  `school_uniform` varchar(10) DEFAULT NULL,
  `uniform_bottom` varchar(10) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade2sampaguita`
--

CREATE TABLE `tblgrade2sampaguita` (
  `id` int(10) UNSIGNED NOT NULL,
  `lrn_number` varchar(20) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) NOT NULL,
  `age` int(10) UNSIGNED NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `contact_number` varchar(15) NOT NULL,
  `parent_name` varchar(100) NOT NULL,
  `parent_contact` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade2sampaguitasupplies`
--

CREATE TABLE `tblgrade2sampaguitasupplies` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `notebooks` varchar(50) DEFAULT NULL,
  `padpaper` varchar(50) DEFAULT NULL,
  `bag` varchar(50) DEFAULT NULL,
  `ballpen` varchar(50) DEFAULT NULL,
  `pencil` varchar(50) DEFAULT NULL,
  `sharpener` varchar(50) DEFAULT NULL,
  `crayons` varchar(50) DEFAULT NULL,
  `eraser` varchar(50) DEFAULT NULL,
  `ruler` varchar(50) DEFAULT NULL,
  `scissors` varchar(50) DEFAULT NULL,
  `glue` varchar(50) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade2sampaguitauniform`
--

CREATE TABLE `tblgrade2sampaguitauniform` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `pe_tshirt` varchar(10) DEFAULT NULL,
  `pe_pants` varchar(10) DEFAULT NULL,
  `socks` varchar(10) DEFAULT NULL,
  `shoes` varchar(10) DEFAULT NULL,
  `school_uniform` varchar(10) DEFAULT NULL,
  `uniform_bottom` varchar(10) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade2yellow_bell`
--

CREATE TABLE `tblgrade2yellow_bell` (
  `id` int(10) UNSIGNED NOT NULL,
  `lrn_number` varchar(20) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) NOT NULL,
  `age` int(10) UNSIGNED NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `contact_number` varchar(15) NOT NULL,
  `parent_name` varchar(100) NOT NULL,
  `parent_contact` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade2yellow_bellsupplies`
--

CREATE TABLE `tblgrade2yellow_bellsupplies` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `notebooks` varchar(50) DEFAULT NULL,
  `padpaper` varchar(50) DEFAULT NULL,
  `bag` varchar(50) DEFAULT NULL,
  `ballpen` varchar(50) DEFAULT NULL,
  `pencil` varchar(50) DEFAULT NULL,
  `sharpener` varchar(50) DEFAULT NULL,
  `crayons` varchar(50) DEFAULT NULL,
  `eraser` varchar(50) DEFAULT NULL,
  `ruler` varchar(50) DEFAULT NULL,
  `scissors` varchar(50) DEFAULT NULL,
  `glue` varchar(50) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade2yellow_belluniform`
--

CREATE TABLE `tblgrade2yellow_belluniform` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `pe_tshirt` varchar(10) DEFAULT NULL,
  `pe_pants` varchar(10) DEFAULT NULL,
  `socks` varchar(10) DEFAULT NULL,
  `shoes` varchar(10) DEFAULT NULL,
  `school_uniform` varchar(10) DEFAULT NULL,
  `uniform_bottom` varchar(10) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade2zinnia`
--

CREATE TABLE `tblgrade2zinnia` (
  `id` int(10) UNSIGNED NOT NULL,
  `lrn_number` varchar(20) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) NOT NULL,
  `age` int(10) UNSIGNED NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `contact_number` varchar(15) NOT NULL,
  `parent_name` varchar(100) NOT NULL,
  `parent_contact` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade2zinniasupplies`
--

CREATE TABLE `tblgrade2zinniasupplies` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `notebooks` varchar(50) DEFAULT NULL,
  `padpaper` varchar(50) DEFAULT NULL,
  `bag` varchar(50) DEFAULT NULL,
  `ballpen` varchar(50) DEFAULT NULL,
  `pencil` varchar(50) DEFAULT NULL,
  `sharpener` varchar(50) DEFAULT NULL,
  `crayons` varchar(50) DEFAULT NULL,
  `eraser` varchar(50) DEFAULT NULL,
  `ruler` varchar(50) DEFAULT NULL,
  `scissors` varchar(50) DEFAULT NULL,
  `glue` varchar(50) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade2zinniauniform`
--

CREATE TABLE `tblgrade2zinniauniform` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `pe_tshirt` varchar(10) DEFAULT NULL,
  `pe_pants` varchar(10) DEFAULT NULL,
  `socks` varchar(10) DEFAULT NULL,
  `shoes` varchar(10) DEFAULT NULL,
  `school_uniform` varchar(10) DEFAULT NULL,
  `uniform_bottom` varchar(10) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade3achiever`
--

CREATE TABLE `tblgrade3achiever` (
  `id` int(10) UNSIGNED NOT NULL,
  `lrn_number` varchar(20) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) NOT NULL,
  `age` int(10) UNSIGNED NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `contact_number` varchar(15) NOT NULL,
  `parent_name` varchar(100) NOT NULL,
  `parent_contact` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tblgrade3achiever`
--

INSERT INTO `tblgrade3achiever` (`id`, `lrn_number`, `last_name`, `first_name`, `middle_name`, `age`, `gender`, `contact_number`, `parent_name`, `parent_contact`) VALUES
(1, '3123123213123', 'Jacaba', 'Arvin ', 'Gahuman', 20, 'MALE', '09936194138', 'Art Jacaba', '09474926102');

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade3achieversupplies`
--

CREATE TABLE `tblgrade3achieversupplies` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `notebooks` varchar(50) DEFAULT NULL,
  `padpaper` varchar(50) DEFAULT NULL,
  `bag` varchar(50) DEFAULT NULL,
  `ballpen` varchar(50) DEFAULT NULL,
  `pencil` varchar(50) DEFAULT NULL,
  `sharpener` varchar(50) DEFAULT NULL,
  `crayons` varchar(50) DEFAULT NULL,
  `eraser` varchar(50) DEFAULT NULL,
  `ruler` varchar(50) DEFAULT NULL,
  `scissors` varchar(50) DEFAULT NULL,
  `glue` varchar(50) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tblgrade3achieversupplies`
--

INSERT INTO `tblgrade3achieversupplies` (`id`, `lrn`, `student_name`, `notebooks`, `padpaper`, `bag`, `ballpen`, `pencil`, `sharpener`, `crayons`, `eraser`, `ruler`, `scissors`, `glue`, `created_by`, `date_updated`) VALUES
(1, '3123123213123', 'Jacaba, Arvin  G.', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', 'admin', '2026-02-01 04:37:51');

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade3achieveruniform`
--

CREATE TABLE `tblgrade3achieveruniform` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `pe_tshirt` varchar(10) DEFAULT NULL,
  `pe_pants` varchar(10) DEFAULT NULL,
  `socks` varchar(10) DEFAULT NULL,
  `shoes` varchar(10) DEFAULT NULL,
  `school_uniform` varchar(10) DEFAULT NULL,
  `uniform_bottom` varchar(10) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tblgrade3achieveruniform`
--

INSERT INTO `tblgrade3achieveruniform` (`id`, `lrn`, `student_name`, `gender`, `pe_tshirt`, `pe_pants`, `socks`, `shoes`, `school_uniform`, `uniform_bottom`, `created_by`, `date_updated`) VALUES
(1, '3123123213123', 'Jacaba, Arvin  G.', 'MALE', 'M', 'L', 'M', '33', 'S', 'M', 'teacher1', '2026-02-01 21:59:41');

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade3brave`
--

CREATE TABLE `tblgrade3brave` (
  `id` int(10) UNSIGNED NOT NULL,
  `lrn_number` varchar(20) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) NOT NULL,
  `age` int(10) UNSIGNED NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `contact_number` varchar(15) NOT NULL,
  `parent_name` varchar(100) NOT NULL,
  `parent_contact` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade3bravesupplies`
--

CREATE TABLE `tblgrade3bravesupplies` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `notebooks` varchar(50) DEFAULT NULL,
  `padpaper` varchar(50) DEFAULT NULL,
  `bag` varchar(50) DEFAULT NULL,
  `ballpen` varchar(50) DEFAULT NULL,
  `pencil` varchar(50) DEFAULT NULL,
  `sharpener` varchar(50) DEFAULT NULL,
  `crayons` varchar(50) DEFAULT NULL,
  `eraser` varchar(50) DEFAULT NULL,
  `ruler` varchar(50) DEFAULT NULL,
  `scissors` varchar(50) DEFAULT NULL,
  `glue` varchar(50) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade3braveuniform`
--

CREATE TABLE `tblgrade3braveuniform` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `pe_tshirt` varchar(10) DEFAULT NULL,
  `pe_pants` varchar(10) DEFAULT NULL,
  `socks` varchar(10) DEFAULT NULL,
  `shoes` varchar(10) DEFAULT NULL,
  `school_uniform` varchar(10) DEFAULT NULL,
  `uniform_bottom` varchar(10) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade3courteous`
--

CREATE TABLE `tblgrade3courteous` (
  `id` int(10) UNSIGNED NOT NULL,
  `lrn_number` varchar(20) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) NOT NULL,
  `age` int(10) UNSIGNED NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `contact_number` varchar(15) NOT NULL,
  `parent_name` varchar(100) NOT NULL,
  `parent_contact` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade3courteoussupplies`
--

CREATE TABLE `tblgrade3courteoussupplies` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `notebooks` varchar(50) DEFAULT NULL,
  `padpaper` varchar(50) DEFAULT NULL,
  `bag` varchar(50) DEFAULT NULL,
  `ballpen` varchar(50) DEFAULT NULL,
  `pencil` varchar(50) DEFAULT NULL,
  `sharpener` varchar(50) DEFAULT NULL,
  `crayons` varchar(50) DEFAULT NULL,
  `eraser` varchar(50) DEFAULT NULL,
  `ruler` varchar(50) DEFAULT NULL,
  `scissors` varchar(50) DEFAULT NULL,
  `glue` varchar(50) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade3courteousuniform`
--

CREATE TABLE `tblgrade3courteousuniform` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `pe_tshirt` varchar(10) DEFAULT NULL,
  `pe_pants` varchar(10) DEFAULT NULL,
  `socks` varchar(10) DEFAULT NULL,
  `shoes` varchar(10) DEFAULT NULL,
  `school_uniform` varchar(10) DEFAULT NULL,
  `uniform_bottom` varchar(10) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade3friendly`
--

CREATE TABLE `tblgrade3friendly` (
  `id` int(10) UNSIGNED NOT NULL,
  `lrn_number` varchar(20) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) NOT NULL,
  `age` int(10) UNSIGNED NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `contact_number` varchar(15) NOT NULL,
  `parent_name` varchar(100) NOT NULL,
  `parent_contact` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade3friendlysupplies`
--

CREATE TABLE `tblgrade3friendlysupplies` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `notebooks` varchar(50) DEFAULT NULL,
  `padpaper` varchar(50) DEFAULT NULL,
  `bag` varchar(50) DEFAULT NULL,
  `ballpen` varchar(50) DEFAULT NULL,
  `pencil` varchar(50) DEFAULT NULL,
  `sharpener` varchar(50) DEFAULT NULL,
  `crayons` varchar(50) DEFAULT NULL,
  `eraser` varchar(50) DEFAULT NULL,
  `ruler` varchar(50) DEFAULT NULL,
  `scissors` varchar(50) DEFAULT NULL,
  `glue` varchar(50) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade3friendlyuniform`
--

CREATE TABLE `tblgrade3friendlyuniform` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `pe_tshirt` varchar(10) DEFAULT NULL,
  `pe_pants` varchar(10) DEFAULT NULL,
  `socks` varchar(10) DEFAULT NULL,
  `shoes` varchar(10) DEFAULT NULL,
  `school_uniform` varchar(10) DEFAULT NULL,
  `uniform_bottom` varchar(10) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade3generous`
--

CREATE TABLE `tblgrade3generous` (
  `id` int(10) UNSIGNED NOT NULL,
  `lrn_number` varchar(20) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) NOT NULL,
  `age` int(10) UNSIGNED NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `contact_number` varchar(15) NOT NULL,
  `parent_name` varchar(100) NOT NULL,
  `parent_contact` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade3generoussupplies`
--

CREATE TABLE `tblgrade3generoussupplies` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `notebooks` varchar(50) DEFAULT NULL,
  `padpaper` varchar(50) DEFAULT NULL,
  `bag` varchar(50) DEFAULT NULL,
  `ballpen` varchar(50) DEFAULT NULL,
  `pencil` varchar(50) DEFAULT NULL,
  `sharpener` varchar(50) DEFAULT NULL,
  `crayons` varchar(50) DEFAULT NULL,
  `eraser` varchar(50) DEFAULT NULL,
  `ruler` varchar(50) DEFAULT NULL,
  `scissors` varchar(50) DEFAULT NULL,
  `glue` varchar(50) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade3generousuniform`
--

CREATE TABLE `tblgrade3generousuniform` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `pe_tshirt` varchar(10) DEFAULT NULL,
  `pe_pants` varchar(10) DEFAULT NULL,
  `socks` varchar(10) DEFAULT NULL,
  `shoes` varchar(10) DEFAULT NULL,
  `school_uniform` varchar(10) DEFAULT NULL,
  `uniform_bottom` varchar(10) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade3honest`
--

CREATE TABLE `tblgrade3honest` (
  `id` int(10) UNSIGNED NOT NULL,
  `lrn_number` varchar(20) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) NOT NULL,
  `age` int(10) UNSIGNED NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `contact_number` varchar(15) NOT NULL,
  `parent_name` varchar(100) NOT NULL,
  `parent_contact` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade3honestsupplies`
--

CREATE TABLE `tblgrade3honestsupplies` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `notebooks` varchar(50) DEFAULT NULL,
  `padpaper` varchar(50) DEFAULT NULL,
  `bag` varchar(50) DEFAULT NULL,
  `ballpen` varchar(50) DEFAULT NULL,
  `pencil` varchar(50) DEFAULT NULL,
  `sharpener` varchar(50) DEFAULT NULL,
  `crayons` varchar(50) DEFAULT NULL,
  `eraser` varchar(50) DEFAULT NULL,
  `ruler` varchar(50) DEFAULT NULL,
  `scissors` varchar(50) DEFAULT NULL,
  `glue` varchar(50) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade3honestuniform`
--

CREATE TABLE `tblgrade3honestuniform` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `pe_tshirt` varchar(10) DEFAULT NULL,
  `pe_pants` varchar(10) DEFAULT NULL,
  `socks` varchar(10) DEFAULT NULL,
  `shoes` varchar(10) DEFAULT NULL,
  `school_uniform` varchar(10) DEFAULT NULL,
  `uniform_bottom` varchar(10) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade3industrious`
--

CREATE TABLE `tblgrade3industrious` (
  `id` int(10) UNSIGNED NOT NULL,
  `lrn_number` varchar(20) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) NOT NULL,
  `age` int(10) UNSIGNED NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `contact_number` varchar(15) NOT NULL,
  `parent_name` varchar(100) NOT NULL,
  `parent_contact` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade3industrioussupplies`
--

CREATE TABLE `tblgrade3industrioussupplies` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `notebooks` varchar(50) DEFAULT NULL,
  `padpaper` varchar(50) DEFAULT NULL,
  `bag` varchar(50) DEFAULT NULL,
  `ballpen` varchar(50) DEFAULT NULL,
  `pencil` varchar(50) DEFAULT NULL,
  `sharpener` varchar(50) DEFAULT NULL,
  `crayons` varchar(50) DEFAULT NULL,
  `eraser` varchar(50) DEFAULT NULL,
  `ruler` varchar(50) DEFAULT NULL,
  `scissors` varchar(50) DEFAULT NULL,
  `glue` varchar(50) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade3industriousuniform`
--

CREATE TABLE `tblgrade3industriousuniform` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `pe_tshirt` varchar(10) DEFAULT NULL,
  `pe_pants` varchar(10) DEFAULT NULL,
  `socks` varchar(10) DEFAULT NULL,
  `shoes` varchar(10) DEFAULT NULL,
  `school_uniform` varchar(10) DEFAULT NULL,
  `uniform_bottom` varchar(10) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade3lovely`
--

CREATE TABLE `tblgrade3lovely` (
  `id` int(10) UNSIGNED NOT NULL,
  `lrn_number` varchar(20) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) NOT NULL,
  `age` int(10) UNSIGNED NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `contact_number` varchar(15) NOT NULL,
  `parent_name` varchar(100) NOT NULL,
  `parent_contact` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade3lovelysupplies`
--

CREATE TABLE `tblgrade3lovelysupplies` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `notebooks` varchar(50) DEFAULT NULL,
  `padpaper` varchar(50) DEFAULT NULL,
  `bag` varchar(50) DEFAULT NULL,
  `ballpen` varchar(50) DEFAULT NULL,
  `pencil` varchar(50) DEFAULT NULL,
  `sharpener` varchar(50) DEFAULT NULL,
  `crayons` varchar(50) DEFAULT NULL,
  `eraser` varchar(50) DEFAULT NULL,
  `ruler` varchar(50) DEFAULT NULL,
  `scissors` varchar(50) DEFAULT NULL,
  `glue` varchar(50) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade3lovelyuniform`
--

CREATE TABLE `tblgrade3lovelyuniform` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `pe_tshirt` varchar(10) DEFAULT NULL,
  `pe_pants` varchar(10) DEFAULT NULL,
  `socks` varchar(10) DEFAULT NULL,
  `shoes` varchar(10) DEFAULT NULL,
  `school_uniform` varchar(10) DEFAULT NULL,
  `uniform_bottom` varchar(10) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade4andres_bonifacio`
--

CREATE TABLE `tblgrade4andres_bonifacio` (
  `id` int(10) UNSIGNED NOT NULL,
  `lrn_number` varchar(20) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) NOT NULL,
  `age` int(10) UNSIGNED NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `contact_number` varchar(15) NOT NULL,
  `parent_name` varchar(100) NOT NULL,
  `parent_contact` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tblgrade4andres_bonifacio`
--

INSERT INTO `tblgrade4andres_bonifacio` (`id`, `lrn_number`, `last_name`, `first_name`, `middle_name`, `age`, `gender`, `contact_number`, `parent_name`, `parent_contact`) VALUES
(1, '312039120391', 'Cuyayacoat', 'Joemarizz', 'Gyu', 14, 'MALE', '09676575676', 'Cuvacot Joeriz', '09474926102');

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade4andres_bonifaciosupplies`
--

CREATE TABLE `tblgrade4andres_bonifaciosupplies` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `notebooks` varchar(50) DEFAULT NULL,
  `padpaper` varchar(50) DEFAULT NULL,
  `bag` varchar(50) DEFAULT NULL,
  `ballpen` varchar(50) DEFAULT NULL,
  `pencil` varchar(50) DEFAULT NULL,
  `sharpener` varchar(50) DEFAULT NULL,
  `crayons` varchar(50) DEFAULT NULL,
  `eraser` varchar(50) DEFAULT NULL,
  `ruler` varchar(50) DEFAULT NULL,
  `scissors` varchar(50) DEFAULT NULL,
  `glue` varchar(50) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade4andres_bonifaciouniform`
--

CREATE TABLE `tblgrade4andres_bonifaciouniform` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `pe_tshirt` varchar(10) DEFAULT NULL,
  `pe_pants` varchar(10) DEFAULT NULL,
  `socks` varchar(10) DEFAULT NULL,
  `shoes` varchar(10) DEFAULT NULL,
  `school_uniform` varchar(10) DEFAULT NULL,
  `uniform_bottom` varchar(10) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tblgrade4andres_bonifaciouniform`
--

INSERT INTO `tblgrade4andres_bonifaciouniform` (`id`, `lrn`, `student_name`, `gender`, `pe_tshirt`, `pe_pants`, `socks`, `shoes`, `school_uniform`, `uniform_bottom`, `created_by`, `date_updated`) VALUES
(1, '312039120391', 'Cuyayacoat, Joemarizz G.', 'MALE', '', '', '', '50', '', '', 'admin', '2026-03-08 06:03:49');

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade4apolinario_mabini`
--

CREATE TABLE `tblgrade4apolinario_mabini` (
  `id` int(10) UNSIGNED NOT NULL,
  `lrn_number` varchar(20) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) NOT NULL,
  `age` int(10) UNSIGNED NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `contact_number` varchar(15) NOT NULL,
  `parent_name` varchar(100) NOT NULL,
  `parent_contact` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade4apolinario_mabinisupplies`
--

CREATE TABLE `tblgrade4apolinario_mabinisupplies` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `notebooks` varchar(50) DEFAULT NULL,
  `padpaper` varchar(50) DEFAULT NULL,
  `bag` varchar(50) DEFAULT NULL,
  `ballpen` varchar(50) DEFAULT NULL,
  `pencil` varchar(50) DEFAULT NULL,
  `sharpener` varchar(50) DEFAULT NULL,
  `crayons` varchar(50) DEFAULT NULL,
  `eraser` varchar(50) DEFAULT NULL,
  `ruler` varchar(50) DEFAULT NULL,
  `scissors` varchar(50) DEFAULT NULL,
  `glue` varchar(50) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade4apolinario_mabiniuniform`
--

CREATE TABLE `tblgrade4apolinario_mabiniuniform` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `pe_tshirt` varchar(10) DEFAULT NULL,
  `pe_pants` varchar(10) DEFAULT NULL,
  `socks` varchar(10) DEFAULT NULL,
  `shoes` varchar(10) DEFAULT NULL,
  `school_uniform` varchar(10) DEFAULT NULL,
  `uniform_bottom` varchar(10) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade4emilio_jacinto`
--

CREATE TABLE `tblgrade4emilio_jacinto` (
  `id` int(10) UNSIGNED NOT NULL,
  `lrn_number` varchar(20) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) NOT NULL,
  `age` int(10) UNSIGNED NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `contact_number` varchar(15) NOT NULL,
  `parent_name` varchar(100) NOT NULL,
  `parent_contact` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade4emilio_jacintosupplies`
--

CREATE TABLE `tblgrade4emilio_jacintosupplies` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `notebooks` varchar(50) DEFAULT NULL,
  `padpaper` varchar(50) DEFAULT NULL,
  `bag` varchar(50) DEFAULT NULL,
  `ballpen` varchar(50) DEFAULT NULL,
  `pencil` varchar(50) DEFAULT NULL,
  `sharpener` varchar(50) DEFAULT NULL,
  `crayons` varchar(50) DEFAULT NULL,
  `eraser` varchar(50) DEFAULT NULL,
  `ruler` varchar(50) DEFAULT NULL,
  `scissors` varchar(50) DEFAULT NULL,
  `glue` varchar(50) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade4emilio_jacintouniform`
--

CREATE TABLE `tblgrade4emilio_jacintouniform` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `pe_tshirt` varchar(10) DEFAULT NULL,
  `pe_pants` varchar(10) DEFAULT NULL,
  `socks` varchar(10) DEFAULT NULL,
  `shoes` varchar(10) DEFAULT NULL,
  `school_uniform` varchar(10) DEFAULT NULL,
  `uniform_bottom` varchar(10) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade4gabriela_silang`
--

CREATE TABLE `tblgrade4gabriela_silang` (
  `id` int(10) UNSIGNED NOT NULL,
  `lrn_number` varchar(20) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) NOT NULL,
  `age` int(10) UNSIGNED NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `contact_number` varchar(15) NOT NULL,
  `parent_name` varchar(100) NOT NULL,
  `parent_contact` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade4gabriela_silangsupplies`
--

CREATE TABLE `tblgrade4gabriela_silangsupplies` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `notebooks` varchar(50) DEFAULT NULL,
  `padpaper` varchar(50) DEFAULT NULL,
  `bag` varchar(50) DEFAULT NULL,
  `ballpen` varchar(50) DEFAULT NULL,
  `pencil` varchar(50) DEFAULT NULL,
  `sharpener` varchar(50) DEFAULT NULL,
  `crayons` varchar(50) DEFAULT NULL,
  `eraser` varchar(50) DEFAULT NULL,
  `ruler` varchar(50) DEFAULT NULL,
  `scissors` varchar(50) DEFAULT NULL,
  `glue` varchar(50) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade4gabriela_silanguniform`
--

CREATE TABLE `tblgrade4gabriela_silanguniform` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `pe_tshirt` varchar(10) DEFAULT NULL,
  `pe_pants` varchar(10) DEFAULT NULL,
  `socks` varchar(10) DEFAULT NULL,
  `shoes` varchar(10) DEFAULT NULL,
  `school_uniform` varchar(10) DEFAULT NULL,
  `uniform_bottom` varchar(10) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade4gregorio_del_pilar`
--

CREATE TABLE `tblgrade4gregorio_del_pilar` (
  `id` int(10) UNSIGNED NOT NULL,
  `lrn_number` varchar(20) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) NOT NULL,
  `age` int(10) UNSIGNED NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `contact_number` varchar(15) NOT NULL,
  `parent_name` varchar(100) NOT NULL,
  `parent_contact` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade4gregorio_del_pilarsupplies`
--

CREATE TABLE `tblgrade4gregorio_del_pilarsupplies` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `notebooks` varchar(50) DEFAULT NULL,
  `padpaper` varchar(50) DEFAULT NULL,
  `bag` varchar(50) DEFAULT NULL,
  `ballpen` varchar(50) DEFAULT NULL,
  `pencil` varchar(50) DEFAULT NULL,
  `sharpener` varchar(50) DEFAULT NULL,
  `crayons` varchar(50) DEFAULT NULL,
  `eraser` varchar(50) DEFAULT NULL,
  `ruler` varchar(50) DEFAULT NULL,
  `scissors` varchar(50) DEFAULT NULL,
  `glue` varchar(50) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade4gregorio_del_pilaruniform`
--

CREATE TABLE `tblgrade4gregorio_del_pilaruniform` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `pe_tshirt` varchar(10) DEFAULT NULL,
  `pe_pants` varchar(10) DEFAULT NULL,
  `socks` varchar(10) DEFAULT NULL,
  `shoes` varchar(10) DEFAULT NULL,
  `school_uniform` varchar(10) DEFAULT NULL,
  `uniform_bottom` varchar(10) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade4jose_palma`
--

CREATE TABLE `tblgrade4jose_palma` (
  `id` int(10) UNSIGNED NOT NULL,
  `lrn_number` varchar(20) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) NOT NULL,
  `age` int(10) UNSIGNED NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `contact_number` varchar(15) NOT NULL,
  `parent_name` varchar(100) NOT NULL,
  `parent_contact` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade4jose_palmasupplies`
--

CREATE TABLE `tblgrade4jose_palmasupplies` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `notebooks` varchar(50) DEFAULT NULL,
  `padpaper` varchar(50) DEFAULT NULL,
  `bag` varchar(50) DEFAULT NULL,
  `ballpen` varchar(50) DEFAULT NULL,
  `pencil` varchar(50) DEFAULT NULL,
  `sharpener` varchar(50) DEFAULT NULL,
  `crayons` varchar(50) DEFAULT NULL,
  `eraser` varchar(50) DEFAULT NULL,
  `ruler` varchar(50) DEFAULT NULL,
  `scissors` varchar(50) DEFAULT NULL,
  `glue` varchar(50) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade4jose_palmauniform`
--

CREATE TABLE `tblgrade4jose_palmauniform` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `pe_tshirt` varchar(10) DEFAULT NULL,
  `pe_pants` varchar(10) DEFAULT NULL,
  `socks` varchar(10) DEFAULT NULL,
  `shoes` varchar(10) DEFAULT NULL,
  `school_uniform` varchar(10) DEFAULT NULL,
  `uniform_bottom` varchar(10) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade4jose_rizal`
--

CREATE TABLE `tblgrade4jose_rizal` (
  `id` int(10) UNSIGNED NOT NULL,
  `lrn_number` varchar(20) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) NOT NULL,
  `age` int(10) UNSIGNED NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `contact_number` varchar(15) NOT NULL,
  `parent_name` varchar(100) NOT NULL,
  `parent_contact` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade4jose_rizalsupplies`
--

CREATE TABLE `tblgrade4jose_rizalsupplies` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `notebooks` varchar(50) DEFAULT NULL,
  `padpaper` varchar(50) DEFAULT NULL,
  `bag` varchar(50) DEFAULT NULL,
  `ballpen` varchar(50) DEFAULT NULL,
  `pencil` varchar(50) DEFAULT NULL,
  `sharpener` varchar(50) DEFAULT NULL,
  `crayons` varchar(50) DEFAULT NULL,
  `eraser` varchar(50) DEFAULT NULL,
  `ruler` varchar(50) DEFAULT NULL,
  `scissors` varchar(50) DEFAULT NULL,
  `glue` varchar(50) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade4jose_rizaluniform`
--

CREATE TABLE `tblgrade4jose_rizaluniform` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `pe_tshirt` varchar(10) DEFAULT NULL,
  `pe_pants` varchar(10) DEFAULT NULL,
  `socks` varchar(10) DEFAULT NULL,
  `shoes` varchar(10) DEFAULT NULL,
  `school_uniform` varchar(10) DEFAULT NULL,
  `uniform_bottom` varchar(10) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade4juan_luna`
--

CREATE TABLE `tblgrade4juan_luna` (
  `id` int(10) UNSIGNED NOT NULL,
  `lrn_number` varchar(20) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) NOT NULL,
  `age` int(10) UNSIGNED NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `contact_number` varchar(15) NOT NULL,
  `parent_name` varchar(100) NOT NULL,
  `parent_contact` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade4juan_lunasupplies`
--

CREATE TABLE `tblgrade4juan_lunasupplies` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `notebooks` varchar(50) DEFAULT NULL,
  `padpaper` varchar(50) DEFAULT NULL,
  `bag` varchar(50) DEFAULT NULL,
  `ballpen` varchar(50) DEFAULT NULL,
  `pencil` varchar(50) DEFAULT NULL,
  `sharpener` varchar(50) DEFAULT NULL,
  `crayons` varchar(50) DEFAULT NULL,
  `eraser` varchar(50) DEFAULT NULL,
  `ruler` varchar(50) DEFAULT NULL,
  `scissors` varchar(50) DEFAULT NULL,
  `glue` varchar(50) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade4juan_lunauniform`
--

CREATE TABLE `tblgrade4juan_lunauniform` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `pe_tshirt` varchar(10) DEFAULT NULL,
  `pe_pants` varchar(10) DEFAULT NULL,
  `socks` varchar(10) DEFAULT NULL,
  `shoes` varchar(10) DEFAULT NULL,
  `school_uniform` varchar(10) DEFAULT NULL,
  `uniform_bottom` varchar(10) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade4lapu_lapu`
--

CREATE TABLE `tblgrade4lapu_lapu` (
  `id` int(10) UNSIGNED NOT NULL,
  `lrn_number` varchar(20) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) NOT NULL,
  `age` int(10) UNSIGNED NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `contact_number` varchar(15) NOT NULL,
  `parent_name` varchar(100) NOT NULL,
  `parent_contact` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade4lapu_lapusupplies`
--

CREATE TABLE `tblgrade4lapu_lapusupplies` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `notebooks` varchar(50) DEFAULT NULL,
  `padpaper` varchar(50) DEFAULT NULL,
  `bag` varchar(50) DEFAULT NULL,
  `ballpen` varchar(50) DEFAULT NULL,
  `pencil` varchar(50) DEFAULT NULL,
  `sharpener` varchar(50) DEFAULT NULL,
  `crayons` varchar(50) DEFAULT NULL,
  `eraser` varchar(50) DEFAULT NULL,
  `ruler` varchar(50) DEFAULT NULL,
  `scissors` varchar(50) DEFAULT NULL,
  `glue` varchar(50) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade4lapu_lapuuniform`
--

CREATE TABLE `tblgrade4lapu_lapuuniform` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `pe_tshirt` varchar(10) DEFAULT NULL,
  `pe_pants` varchar(10) DEFAULT NULL,
  `socks` varchar(10) DEFAULT NULL,
  `shoes` varchar(10) DEFAULT NULL,
  `school_uniform` varchar(10) DEFAULT NULL,
  `uniform_bottom` varchar(10) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade4marcelo_del_pilar`
--

CREATE TABLE `tblgrade4marcelo_del_pilar` (
  `id` int(10) UNSIGNED NOT NULL,
  `lrn_number` varchar(20) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) NOT NULL,
  `age` int(10) UNSIGNED NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `contact_number` varchar(15) NOT NULL,
  `parent_name` varchar(100) NOT NULL,
  `parent_contact` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade4marcelo_del_pilarsupplies`
--

CREATE TABLE `tblgrade4marcelo_del_pilarsupplies` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `notebooks` varchar(50) DEFAULT NULL,
  `padpaper` varchar(50) DEFAULT NULL,
  `bag` varchar(50) DEFAULT NULL,
  `ballpen` varchar(50) DEFAULT NULL,
  `pencil` varchar(50) DEFAULT NULL,
  `sharpener` varchar(50) DEFAULT NULL,
  `crayons` varchar(50) DEFAULT NULL,
  `eraser` varchar(50) DEFAULT NULL,
  `ruler` varchar(50) DEFAULT NULL,
  `scissors` varchar(50) DEFAULT NULL,
  `glue` varchar(50) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade4marcelo_del_pilaruniform`
--

CREATE TABLE `tblgrade4marcelo_del_pilaruniform` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `pe_tshirt` varchar(10) DEFAULT NULL,
  `pe_pants` varchar(10) DEFAULT NULL,
  `socks` varchar(10) DEFAULT NULL,
  `shoes` varchar(10) DEFAULT NULL,
  `school_uniform` varchar(10) DEFAULT NULL,
  `uniform_bottom` varchar(10) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade4sultan_kudarat`
--

CREATE TABLE `tblgrade4sultan_kudarat` (
  `id` int(10) UNSIGNED NOT NULL,
  `lrn_number` varchar(20) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) NOT NULL,
  `age` int(10) UNSIGNED NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `contact_number` varchar(15) NOT NULL,
  `parent_name` varchar(100) NOT NULL,
  `parent_contact` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade4sultan_kudaratsupplies`
--

CREATE TABLE `tblgrade4sultan_kudaratsupplies` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `notebooks` varchar(50) DEFAULT NULL,
  `padpaper` varchar(50) DEFAULT NULL,
  `bag` varchar(50) DEFAULT NULL,
  `ballpen` varchar(50) DEFAULT NULL,
  `pencil` varchar(50) DEFAULT NULL,
  `sharpener` varchar(50) DEFAULT NULL,
  `crayons` varchar(50) DEFAULT NULL,
  `eraser` varchar(50) DEFAULT NULL,
  `ruler` varchar(50) DEFAULT NULL,
  `scissors` varchar(50) DEFAULT NULL,
  `glue` varchar(50) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade4sultan_kudaratuniform`
--

CREATE TABLE `tblgrade4sultan_kudaratuniform` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `pe_tshirt` varchar(10) DEFAULT NULL,
  `pe_pants` varchar(10) DEFAULT NULL,
  `socks` varchar(10) DEFAULT NULL,
  `shoes` varchar(10) DEFAULT NULL,
  `school_uniform` varchar(10) DEFAULT NULL,
  `uniform_bottom` varchar(10) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade5aguinaldo`
--

CREATE TABLE `tblgrade5aguinaldo` (
  `id` int(10) UNSIGNED NOT NULL,
  `lrn_number` varchar(20) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) NOT NULL,
  `age` int(10) UNSIGNED NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `contact_number` varchar(15) NOT NULL,
  `parent_name` varchar(100) NOT NULL,
  `parent_contact` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tblgrade5aguinaldo`
--

INSERT INTO `tblgrade5aguinaldo` (`id`, `lrn_number`, `last_name`, `first_name`, `middle_name`, `age`, `gender`, `contact_number`, `parent_name`, `parent_contact`) VALUES
(1, '312039120391', 'Cuyacot', 'Joemari', 'Gahuman', 12, 'FEMALE', '09023913822', 'Liana Angeles', '09473284731');

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade5aguinaldosupplies`
--

CREATE TABLE `tblgrade5aguinaldosupplies` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `notebooks` varchar(50) DEFAULT NULL,
  `padpaper` varchar(50) DEFAULT NULL,
  `bag` varchar(50) DEFAULT NULL,
  `ballpen` varchar(50) DEFAULT NULL,
  `pencil` varchar(50) DEFAULT NULL,
  `sharpener` varchar(50) DEFAULT NULL,
  `crayons` varchar(50) DEFAULT NULL,
  `eraser` varchar(50) DEFAULT NULL,
  `ruler` varchar(50) DEFAULT NULL,
  `scissors` varchar(50) DEFAULT NULL,
  `glue` varchar(50) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tblgrade5aguinaldosupplies`
--

INSERT INTO `tblgrade5aguinaldosupplies` (`id`, `lrn`, `student_name`, `notebooks`, `padpaper`, `bag`, `ballpen`, `pencil`, `sharpener`, `crayons`, `eraser`, `ruler`, `scissors`, `glue`, `created_by`, `date_updated`) VALUES
(1, '312039120391', 'Cuyacot, Joemari G.', '2', '1', '1', '2', '2', '2', '1', '2', '1', '1', '1', 'admin', '2026-03-20 06:24:27');

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade5aguinaldouniform`
--

CREATE TABLE `tblgrade5aguinaldouniform` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `pe_tshirt` varchar(10) DEFAULT NULL,
  `pe_pants` varchar(10) DEFAULT NULL,
  `socks` varchar(10) DEFAULT NULL,
  `shoes` varchar(10) DEFAULT NULL,
  `school_uniform` varchar(10) DEFAULT NULL,
  `uniform_bottom` varchar(10) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade5garcia`
--

CREATE TABLE `tblgrade5garcia` (
  `id` int(10) UNSIGNED NOT NULL,
  `lrn_number` varchar(20) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) NOT NULL,
  `age` int(10) UNSIGNED NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `contact_number` varchar(15) NOT NULL,
  `parent_name` varchar(100) NOT NULL,
  `parent_contact` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade5garciasupplies`
--

CREATE TABLE `tblgrade5garciasupplies` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `notebooks` varchar(50) DEFAULT NULL,
  `padpaper` varchar(50) DEFAULT NULL,
  `bag` varchar(50) DEFAULT NULL,
  `ballpen` varchar(50) DEFAULT NULL,
  `pencil` varchar(50) DEFAULT NULL,
  `sharpener` varchar(50) DEFAULT NULL,
  `crayons` varchar(50) DEFAULT NULL,
  `eraser` varchar(50) DEFAULT NULL,
  `ruler` varchar(50) DEFAULT NULL,
  `scissors` varchar(50) DEFAULT NULL,
  `glue` varchar(50) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade5garciauniform`
--

CREATE TABLE `tblgrade5garciauniform` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `pe_tshirt` varchar(10) DEFAULT NULL,
  `pe_pants` varchar(10) DEFAULT NULL,
  `socks` varchar(10) DEFAULT NULL,
  `shoes` varchar(10) DEFAULT NULL,
  `school_uniform` varchar(10) DEFAULT NULL,
  `uniform_bottom` varchar(10) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade5laurel`
--

CREATE TABLE `tblgrade5laurel` (
  `id` int(10) UNSIGNED NOT NULL,
  `lrn_number` varchar(20) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) NOT NULL,
  `age` int(10) UNSIGNED NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `contact_number` varchar(15) NOT NULL,
  `parent_name` varchar(100) NOT NULL,
  `parent_contact` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade5laurelsupplies`
--

CREATE TABLE `tblgrade5laurelsupplies` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `notebooks` varchar(50) DEFAULT NULL,
  `padpaper` varchar(50) DEFAULT NULL,
  `bag` varchar(50) DEFAULT NULL,
  `ballpen` varchar(50) DEFAULT NULL,
  `pencil` varchar(50) DEFAULT NULL,
  `sharpener` varchar(50) DEFAULT NULL,
  `crayons` varchar(50) DEFAULT NULL,
  `eraser` varchar(50) DEFAULT NULL,
  `ruler` varchar(50) DEFAULT NULL,
  `scissors` varchar(50) DEFAULT NULL,
  `glue` varchar(50) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade5laureluniform`
--

CREATE TABLE `tblgrade5laureluniform` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `pe_tshirt` varchar(10) DEFAULT NULL,
  `pe_pants` varchar(10) DEFAULT NULL,
  `socks` varchar(10) DEFAULT NULL,
  `shoes` varchar(10) DEFAULT NULL,
  `school_uniform` varchar(10) DEFAULT NULL,
  `uniform_bottom` varchar(10) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade5macapagal`
--

CREATE TABLE `tblgrade5macapagal` (
  `id` int(10) UNSIGNED NOT NULL,
  `lrn_number` varchar(20) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) NOT NULL,
  `age` int(10) UNSIGNED NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `contact_number` varchar(15) NOT NULL,
  `parent_name` varchar(100) NOT NULL,
  `parent_contact` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade5macapagalsupplies`
--

CREATE TABLE `tblgrade5macapagalsupplies` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `notebooks` varchar(50) DEFAULT NULL,
  `padpaper` varchar(50) DEFAULT NULL,
  `bag` varchar(50) DEFAULT NULL,
  `ballpen` varchar(50) DEFAULT NULL,
  `pencil` varchar(50) DEFAULT NULL,
  `sharpener` varchar(50) DEFAULT NULL,
  `crayons` varchar(50) DEFAULT NULL,
  `eraser` varchar(50) DEFAULT NULL,
  `ruler` varchar(50) DEFAULT NULL,
  `scissors` varchar(50) DEFAULT NULL,
  `glue` varchar(50) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade5macapagaluniform`
--

CREATE TABLE `tblgrade5macapagaluniform` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `pe_tshirt` varchar(10) DEFAULT NULL,
  `pe_pants` varchar(10) DEFAULT NULL,
  `socks` varchar(10) DEFAULT NULL,
  `shoes` varchar(10) DEFAULT NULL,
  `school_uniform` varchar(10) DEFAULT NULL,
  `uniform_bottom` varchar(10) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade5magsaysay`
--

CREATE TABLE `tblgrade5magsaysay` (
  `id` int(10) UNSIGNED NOT NULL,
  `lrn_number` varchar(20) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) NOT NULL,
  `age` int(10) UNSIGNED NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `contact_number` varchar(15) NOT NULL,
  `parent_name` varchar(100) NOT NULL,
  `parent_contact` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade5magsaysaysupplies`
--

CREATE TABLE `tblgrade5magsaysaysupplies` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `notebooks` varchar(50) DEFAULT NULL,
  `padpaper` varchar(50) DEFAULT NULL,
  `bag` varchar(50) DEFAULT NULL,
  `ballpen` varchar(50) DEFAULT NULL,
  `pencil` varchar(50) DEFAULT NULL,
  `sharpener` varchar(50) DEFAULT NULL,
  `crayons` varchar(50) DEFAULT NULL,
  `eraser` varchar(50) DEFAULT NULL,
  `ruler` varchar(50) DEFAULT NULL,
  `scissors` varchar(50) DEFAULT NULL,
  `glue` varchar(50) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade5magsaysayuniform`
--

CREATE TABLE `tblgrade5magsaysayuniform` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `pe_tshirt` varchar(10) DEFAULT NULL,
  `pe_pants` varchar(10) DEFAULT NULL,
  `socks` varchar(10) DEFAULT NULL,
  `shoes` varchar(10) DEFAULT NULL,
  `school_uniform` varchar(10) DEFAULT NULL,
  `uniform_bottom` varchar(10) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade5marcos`
--

CREATE TABLE `tblgrade5marcos` (
  `id` int(10) UNSIGNED NOT NULL,
  `lrn_number` varchar(20) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) NOT NULL,
  `age` int(10) UNSIGNED NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `contact_number` varchar(15) NOT NULL,
  `parent_name` varchar(100) NOT NULL,
  `parent_contact` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade5marcossupplies`
--

CREATE TABLE `tblgrade5marcossupplies` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `notebooks` varchar(50) DEFAULT NULL,
  `padpaper` varchar(50) DEFAULT NULL,
  `bag` varchar(50) DEFAULT NULL,
  `ballpen` varchar(50) DEFAULT NULL,
  `pencil` varchar(50) DEFAULT NULL,
  `sharpener` varchar(50) DEFAULT NULL,
  `crayons` varchar(50) DEFAULT NULL,
  `eraser` varchar(50) DEFAULT NULL,
  `ruler` varchar(50) DEFAULT NULL,
  `scissors` varchar(50) DEFAULT NULL,
  `glue` varchar(50) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade5marcosuniform`
--

CREATE TABLE `tblgrade5marcosuniform` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `pe_tshirt` varchar(10) DEFAULT NULL,
  `pe_pants` varchar(10) DEFAULT NULL,
  `socks` varchar(10) DEFAULT NULL,
  `shoes` varchar(10) DEFAULT NULL,
  `school_uniform` varchar(10) DEFAULT NULL,
  `uniform_bottom` varchar(10) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade5osmena`
--

CREATE TABLE `tblgrade5osmena` (
  `id` int(10) UNSIGNED NOT NULL,
  `lrn_number` varchar(20) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) NOT NULL,
  `age` int(10) UNSIGNED NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `contact_number` varchar(15) NOT NULL,
  `parent_name` varchar(100) NOT NULL,
  `parent_contact` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade5osmenasupplies`
--

CREATE TABLE `tblgrade5osmenasupplies` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `notebooks` varchar(50) DEFAULT NULL,
  `padpaper` varchar(50) DEFAULT NULL,
  `bag` varchar(50) DEFAULT NULL,
  `ballpen` varchar(50) DEFAULT NULL,
  `pencil` varchar(50) DEFAULT NULL,
  `sharpener` varchar(50) DEFAULT NULL,
  `crayons` varchar(50) DEFAULT NULL,
  `eraser` varchar(50) DEFAULT NULL,
  `ruler` varchar(50) DEFAULT NULL,
  `scissors` varchar(50) DEFAULT NULL,
  `glue` varchar(50) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade5osmenauniform`
--

CREATE TABLE `tblgrade5osmenauniform` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `pe_tshirt` varchar(10) DEFAULT NULL,
  `pe_pants` varchar(10) DEFAULT NULL,
  `socks` varchar(10) DEFAULT NULL,
  `shoes` varchar(10) DEFAULT NULL,
  `school_uniform` varchar(10) DEFAULT NULL,
  `uniform_bottom` varchar(10) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade5quezon`
--

CREATE TABLE `tblgrade5quezon` (
  `id` int(10) UNSIGNED NOT NULL,
  `lrn_number` varchar(20) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) NOT NULL,
  `age` int(10) UNSIGNED NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `contact_number` varchar(15) NOT NULL,
  `parent_name` varchar(100) NOT NULL,
  `parent_contact` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade5quezonsupplies`
--

CREATE TABLE `tblgrade5quezonsupplies` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `notebooks` varchar(50) DEFAULT NULL,
  `padpaper` varchar(50) DEFAULT NULL,
  `bag` varchar(50) DEFAULT NULL,
  `ballpen` varchar(50) DEFAULT NULL,
  `pencil` varchar(50) DEFAULT NULL,
  `sharpener` varchar(50) DEFAULT NULL,
  `crayons` varchar(50) DEFAULT NULL,
  `eraser` varchar(50) DEFAULT NULL,
  `ruler` varchar(50) DEFAULT NULL,
  `scissors` varchar(50) DEFAULT NULL,
  `glue` varchar(50) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade5quezonuniform`
--

CREATE TABLE `tblgrade5quezonuniform` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `pe_tshirt` varchar(10) DEFAULT NULL,
  `pe_pants` varchar(10) DEFAULT NULL,
  `socks` varchar(10) DEFAULT NULL,
  `shoes` varchar(10) DEFAULT NULL,
  `school_uniform` varchar(10) DEFAULT NULL,
  `uniform_bottom` varchar(10) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade5quirino`
--

CREATE TABLE `tblgrade5quirino` (
  `id` int(10) UNSIGNED NOT NULL,
  `lrn_number` varchar(20) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) NOT NULL,
  `age` int(10) UNSIGNED NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `contact_number` varchar(15) NOT NULL,
  `parent_name` varchar(100) NOT NULL,
  `parent_contact` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade5quirinosupplies`
--

CREATE TABLE `tblgrade5quirinosupplies` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `notebooks` varchar(50) DEFAULT NULL,
  `padpaper` varchar(50) DEFAULT NULL,
  `bag` varchar(50) DEFAULT NULL,
  `ballpen` varchar(50) DEFAULT NULL,
  `pencil` varchar(50) DEFAULT NULL,
  `sharpener` varchar(50) DEFAULT NULL,
  `crayons` varchar(50) DEFAULT NULL,
  `eraser` varchar(50) DEFAULT NULL,
  `ruler` varchar(50) DEFAULT NULL,
  `scissors` varchar(50) DEFAULT NULL,
  `glue` varchar(50) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade5quirinouniform`
--

CREATE TABLE `tblgrade5quirinouniform` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `pe_tshirt` varchar(10) DEFAULT NULL,
  `pe_pants` varchar(10) DEFAULT NULL,
  `socks` varchar(10) DEFAULT NULL,
  `shoes` varchar(10) DEFAULT NULL,
  `school_uniform` varchar(10) DEFAULT NULL,
  `uniform_bottom` varchar(10) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade5roxas`
--

CREATE TABLE `tblgrade5roxas` (
  `id` int(10) UNSIGNED NOT NULL,
  `lrn_number` varchar(20) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) NOT NULL,
  `age` int(10) UNSIGNED NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `contact_number` varchar(15) NOT NULL,
  `parent_name` varchar(100) NOT NULL,
  `parent_contact` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade5roxassupplies`
--

CREATE TABLE `tblgrade5roxassupplies` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `notebooks` varchar(50) DEFAULT NULL,
  `padpaper` varchar(50) DEFAULT NULL,
  `bag` varchar(50) DEFAULT NULL,
  `ballpen` varchar(50) DEFAULT NULL,
  `pencil` varchar(50) DEFAULT NULL,
  `sharpener` varchar(50) DEFAULT NULL,
  `crayons` varchar(50) DEFAULT NULL,
  `eraser` varchar(50) DEFAULT NULL,
  `ruler` varchar(50) DEFAULT NULL,
  `scissors` varchar(50) DEFAULT NULL,
  `glue` varchar(50) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade5roxasuniform`
--

CREATE TABLE `tblgrade5roxasuniform` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `pe_tshirt` varchar(10) DEFAULT NULL,
  `pe_pants` varchar(10) DEFAULT NULL,
  `socks` varchar(10) DEFAULT NULL,
  `shoes` varchar(10) DEFAULT NULL,
  `school_uniform` varchar(10) DEFAULT NULL,
  `uniform_bottom` varchar(10) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade6amethyst`
--

CREATE TABLE `tblgrade6amethyst` (
  `id` int(10) UNSIGNED NOT NULL,
  `lrn_number` varchar(20) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) NOT NULL,
  `age` int(10) UNSIGNED NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `contact_number` varchar(15) NOT NULL,
  `parent_name` varchar(100) NOT NULL,
  `parent_contact` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade6amethystsupplies`
--

CREATE TABLE `tblgrade6amethystsupplies` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `notebooks` varchar(50) DEFAULT NULL,
  `padpaper` varchar(50) DEFAULT NULL,
  `bag` varchar(50) DEFAULT NULL,
  `ballpen` varchar(50) DEFAULT NULL,
  `pencil` varchar(50) DEFAULT NULL,
  `sharpener` varchar(50) DEFAULT NULL,
  `crayons` varchar(50) DEFAULT NULL,
  `eraser` varchar(50) DEFAULT NULL,
  `ruler` varchar(50) DEFAULT NULL,
  `scissors` varchar(50) DEFAULT NULL,
  `glue` varchar(50) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade6amethystuniform`
--

CREATE TABLE `tblgrade6amethystuniform` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `pe_tshirt` varchar(10) DEFAULT NULL,
  `pe_pants` varchar(10) DEFAULT NULL,
  `socks` varchar(10) DEFAULT NULL,
  `shoes` varchar(10) DEFAULT NULL,
  `school_uniform` varchar(10) DEFAULT NULL,
  `uniform_bottom` varchar(10) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade6beryl`
--

CREATE TABLE `tblgrade6beryl` (
  `id` int(10) UNSIGNED NOT NULL,
  `lrn_number` varchar(20) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) NOT NULL,
  `age` int(10) UNSIGNED NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `contact_number` varchar(15) NOT NULL,
  `parent_name` varchar(100) NOT NULL,
  `parent_contact` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade6berylsupplies`
--

CREATE TABLE `tblgrade6berylsupplies` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `notebooks` varchar(50) DEFAULT NULL,
  `padpaper` varchar(50) DEFAULT NULL,
  `bag` varchar(50) DEFAULT NULL,
  `ballpen` varchar(50) DEFAULT NULL,
  `pencil` varchar(50) DEFAULT NULL,
  `sharpener` varchar(50) DEFAULT NULL,
  `crayons` varchar(50) DEFAULT NULL,
  `eraser` varchar(50) DEFAULT NULL,
  `ruler` varchar(50) DEFAULT NULL,
  `scissors` varchar(50) DEFAULT NULL,
  `glue` varchar(50) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade6beryluniform`
--

CREATE TABLE `tblgrade6beryluniform` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `pe_tshirt` varchar(10) DEFAULT NULL,
  `pe_pants` varchar(10) DEFAULT NULL,
  `socks` varchar(10) DEFAULT NULL,
  `shoes` varchar(10) DEFAULT NULL,
  `school_uniform` varchar(10) DEFAULT NULL,
  `uniform_bottom` varchar(10) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade6citrine`
--

CREATE TABLE `tblgrade6citrine` (
  `id` int(10) UNSIGNED NOT NULL,
  `lrn_number` varchar(20) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) NOT NULL,
  `age` int(10) UNSIGNED NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `contact_number` varchar(15) NOT NULL,
  `parent_name` varchar(100) NOT NULL,
  `parent_contact` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade6citrinesupplies`
--

CREATE TABLE `tblgrade6citrinesupplies` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `notebooks` varchar(50) DEFAULT NULL,
  `padpaper` varchar(50) DEFAULT NULL,
  `bag` varchar(50) DEFAULT NULL,
  `ballpen` varchar(50) DEFAULT NULL,
  `pencil` varchar(50) DEFAULT NULL,
  `sharpener` varchar(50) DEFAULT NULL,
  `crayons` varchar(50) DEFAULT NULL,
  `eraser` varchar(50) DEFAULT NULL,
  `ruler` varchar(50) DEFAULT NULL,
  `scissors` varchar(50) DEFAULT NULL,
  `glue` varchar(50) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade6citrineuniform`
--

CREATE TABLE `tblgrade6citrineuniform` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `pe_tshirt` varchar(10) DEFAULT NULL,
  `pe_pants` varchar(10) DEFAULT NULL,
  `socks` varchar(10) DEFAULT NULL,
  `shoes` varchar(10) DEFAULT NULL,
  `school_uniform` varchar(10) DEFAULT NULL,
  `uniform_bottom` varchar(10) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade6diamond`
--

CREATE TABLE `tblgrade6diamond` (
  `id` int(10) UNSIGNED NOT NULL,
  `lrn_number` varchar(20) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) NOT NULL,
  `age` int(10) UNSIGNED NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `contact_number` varchar(15) NOT NULL,
  `parent_name` varchar(100) NOT NULL,
  `parent_contact` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade6diamondsupplies`
--

CREATE TABLE `tblgrade6diamondsupplies` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `notebooks` varchar(50) DEFAULT NULL,
  `padpaper` varchar(50) DEFAULT NULL,
  `bag` varchar(50) DEFAULT NULL,
  `ballpen` varchar(50) DEFAULT NULL,
  `pencil` varchar(50) DEFAULT NULL,
  `sharpener` varchar(50) DEFAULT NULL,
  `crayons` varchar(50) DEFAULT NULL,
  `eraser` varchar(50) DEFAULT NULL,
  `ruler` varchar(50) DEFAULT NULL,
  `scissors` varchar(50) DEFAULT NULL,
  `glue` varchar(50) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade6diamonduniform`
--

CREATE TABLE `tblgrade6diamonduniform` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `pe_tshirt` varchar(10) DEFAULT NULL,
  `pe_pants` varchar(10) DEFAULT NULL,
  `socks` varchar(10) DEFAULT NULL,
  `shoes` varchar(10) DEFAULT NULL,
  `school_uniform` varchar(10) DEFAULT NULL,
  `uniform_bottom` varchar(10) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade6emerald`
--

CREATE TABLE `tblgrade6emerald` (
  `id` int(10) UNSIGNED NOT NULL,
  `lrn_number` varchar(20) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) NOT NULL,
  `age` int(10) UNSIGNED NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `contact_number` varchar(15) NOT NULL,
  `parent_name` varchar(100) NOT NULL,
  `parent_contact` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade6emeraldsupplies`
--

CREATE TABLE `tblgrade6emeraldsupplies` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `notebooks` varchar(50) DEFAULT NULL,
  `padpaper` varchar(50) DEFAULT NULL,
  `bag` varchar(50) DEFAULT NULL,
  `ballpen` varchar(50) DEFAULT NULL,
  `pencil` varchar(50) DEFAULT NULL,
  `sharpener` varchar(50) DEFAULT NULL,
  `crayons` varchar(50) DEFAULT NULL,
  `eraser` varchar(50) DEFAULT NULL,
  `ruler` varchar(50) DEFAULT NULL,
  `scissors` varchar(50) DEFAULT NULL,
  `glue` varchar(50) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade6emeralduniform`
--

CREATE TABLE `tblgrade6emeralduniform` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `pe_tshirt` varchar(10) DEFAULT NULL,
  `pe_pants` varchar(10) DEFAULT NULL,
  `socks` varchar(10) DEFAULT NULL,
  `shoes` varchar(10) DEFAULT NULL,
  `school_uniform` varchar(10) DEFAULT NULL,
  `uniform_bottom` varchar(10) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade6jade`
--

CREATE TABLE `tblgrade6jade` (
  `id` int(10) UNSIGNED NOT NULL,
  `lrn_number` varchar(20) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) NOT NULL,
  `age` int(10) UNSIGNED NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `contact_number` varchar(15) NOT NULL,
  `parent_name` varchar(100) NOT NULL,
  `parent_contact` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade6jadesupplies`
--

CREATE TABLE `tblgrade6jadesupplies` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `notebooks` varchar(50) DEFAULT NULL,
  `padpaper` varchar(50) DEFAULT NULL,
  `bag` varchar(50) DEFAULT NULL,
  `ballpen` varchar(50) DEFAULT NULL,
  `pencil` varchar(50) DEFAULT NULL,
  `sharpener` varchar(50) DEFAULT NULL,
  `crayons` varchar(50) DEFAULT NULL,
  `eraser` varchar(50) DEFAULT NULL,
  `ruler` varchar(50) DEFAULT NULL,
  `scissors` varchar(50) DEFAULT NULL,
  `glue` varchar(50) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade6jadeuniform`
--

CREATE TABLE `tblgrade6jadeuniform` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `pe_tshirt` varchar(10) DEFAULT NULL,
  `pe_pants` varchar(10) DEFAULT NULL,
  `socks` varchar(10) DEFAULT NULL,
  `shoes` varchar(10) DEFAULT NULL,
  `school_uniform` varchar(10) DEFAULT NULL,
  `uniform_bottom` varchar(10) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade6morganite`
--

CREATE TABLE `tblgrade6morganite` (
  `id` int(10) UNSIGNED NOT NULL,
  `lrn_number` varchar(20) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) NOT NULL,
  `age` int(10) UNSIGNED NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `contact_number` varchar(15) NOT NULL,
  `parent_name` varchar(100) NOT NULL,
  `parent_contact` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade6morganitesupplies`
--

CREATE TABLE `tblgrade6morganitesupplies` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `notebooks` varchar(50) DEFAULT NULL,
  `padpaper` varchar(50) DEFAULT NULL,
  `bag` varchar(50) DEFAULT NULL,
  `ballpen` varchar(50) DEFAULT NULL,
  `pencil` varchar(50) DEFAULT NULL,
  `sharpener` varchar(50) DEFAULT NULL,
  `crayons` varchar(50) DEFAULT NULL,
  `eraser` varchar(50) DEFAULT NULL,
  `ruler` varchar(50) DEFAULT NULL,
  `scissors` varchar(50) DEFAULT NULL,
  `glue` varchar(50) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade6morganiteuniform`
--

CREATE TABLE `tblgrade6morganiteuniform` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `pe_tshirt` varchar(10) DEFAULT NULL,
  `pe_pants` varchar(10) DEFAULT NULL,
  `socks` varchar(10) DEFAULT NULL,
  `shoes` varchar(10) DEFAULT NULL,
  `school_uniform` varchar(10) DEFAULT NULL,
  `uniform_bottom` varchar(10) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade6pearl`
--

CREATE TABLE `tblgrade6pearl` (
  `id` int(10) UNSIGNED NOT NULL,
  `lrn_number` varchar(20) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) NOT NULL,
  `age` int(10) UNSIGNED NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `contact_number` varchar(15) NOT NULL,
  `parent_name` varchar(100) NOT NULL,
  `parent_contact` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade6pearlsupplies`
--

CREATE TABLE `tblgrade6pearlsupplies` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `notebooks` varchar(50) DEFAULT NULL,
  `padpaper` varchar(50) DEFAULT NULL,
  `bag` varchar(50) DEFAULT NULL,
  `ballpen` varchar(50) DEFAULT NULL,
  `pencil` varchar(50) DEFAULT NULL,
  `sharpener` varchar(50) DEFAULT NULL,
  `crayons` varchar(50) DEFAULT NULL,
  `eraser` varchar(50) DEFAULT NULL,
  `ruler` varchar(50) DEFAULT NULL,
  `scissors` varchar(50) DEFAULT NULL,
  `glue` varchar(50) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade6pearluniform`
--

CREATE TABLE `tblgrade6pearluniform` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `pe_tshirt` varchar(10) DEFAULT NULL,
  `pe_pants` varchar(10) DEFAULT NULL,
  `socks` varchar(10) DEFAULT NULL,
  `shoes` varchar(10) DEFAULT NULL,
  `school_uniform` varchar(10) DEFAULT NULL,
  `uniform_bottom` varchar(10) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade6ruby`
--

CREATE TABLE `tblgrade6ruby` (
  `id` int(10) UNSIGNED NOT NULL,
  `lrn_number` varchar(20) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) NOT NULL,
  `age` int(10) UNSIGNED NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `contact_number` varchar(15) NOT NULL,
  `parent_name` varchar(100) NOT NULL,
  `parent_contact` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade6rubysupplies`
--

CREATE TABLE `tblgrade6rubysupplies` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `notebooks` varchar(50) DEFAULT NULL,
  `padpaper` varchar(50) DEFAULT NULL,
  `bag` varchar(50) DEFAULT NULL,
  `ballpen` varchar(50) DEFAULT NULL,
  `pencil` varchar(50) DEFAULT NULL,
  `sharpener` varchar(50) DEFAULT NULL,
  `crayons` varchar(50) DEFAULT NULL,
  `eraser` varchar(50) DEFAULT NULL,
  `ruler` varchar(50) DEFAULT NULL,
  `scissors` varchar(50) DEFAULT NULL,
  `glue` varchar(50) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade6rubyuniform`
--

CREATE TABLE `tblgrade6rubyuniform` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `pe_tshirt` varchar(10) DEFAULT NULL,
  `pe_pants` varchar(10) DEFAULT NULL,
  `socks` varchar(10) DEFAULT NULL,
  `shoes` varchar(10) DEFAULT NULL,
  `school_uniform` varchar(10) DEFAULT NULL,
  `uniform_bottom` varchar(10) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade6sapphire`
--

CREATE TABLE `tblgrade6sapphire` (
  `id` int(10) UNSIGNED NOT NULL,
  `lrn_number` varchar(20) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) NOT NULL,
  `age` int(10) UNSIGNED NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `contact_number` varchar(15) NOT NULL,
  `parent_name` varchar(100) NOT NULL,
  `parent_contact` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade6sapphiresupplies`
--

CREATE TABLE `tblgrade6sapphiresupplies` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `notebooks` varchar(50) DEFAULT NULL,
  `padpaper` varchar(50) DEFAULT NULL,
  `bag` varchar(50) DEFAULT NULL,
  `ballpen` varchar(50) DEFAULT NULL,
  `pencil` varchar(50) DEFAULT NULL,
  `sharpener` varchar(50) DEFAULT NULL,
  `crayons` varchar(50) DEFAULT NULL,
  `eraser` varchar(50) DEFAULT NULL,
  `ruler` varchar(50) DEFAULT NULL,
  `scissors` varchar(50) DEFAULT NULL,
  `glue` varchar(50) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblgrade6sapphireuniform`
--

CREATE TABLE `tblgrade6sapphireuniform` (
  `id` int(11) NOT NULL,
  `lrn` varchar(50) NOT NULL,
  `student_name` varchar(255) NOT NULL,
  `gender` enum('MALE','FEMALE') NOT NULL,
  `pe_tshirt` varchar(10) DEFAULT NULL,
  `pe_pants` varchar(10) DEFAULT NULL,
  `socks` varchar(10) DEFAULT NULL,
  `shoes` varchar(10) DEFAULT NULL,
  `school_uniform` varchar(10) DEFAULT NULL,
  `uniform_bottom` varchar(10) DEFAULT NULL,
  `created_by` varchar(100) DEFAULT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbllogs`
--

CREATE TABLE `tbllogs` (
  `id` int(11) NOT NULL,
  `action_type` varchar(50) NOT NULL,
  `section` varchar(100) NOT NULL,
  `student_name` varchar(255) DEFAULT NULL,
  `details` text DEFAULT NULL,
  `created_by` varchar(100) NOT NULL,
  `date_created` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tbllogs`
--

INSERT INTO `tbllogs` (`id`, `action_type`, `section`, `student_name`, `details`, `created_by`, `date_created`) VALUES
(5, 'EDIT', 'Grade 1 - Sampaguita (Uniform)', 'Alvarez, Benjamin R.', 'Updated uniform record', 'admin', '2026-01-06 04:32:39'),
(6, 'EDIT', 'Grade 1 - Sampaguita (Uniform)', 'Alvarez, Benjamin R.', 'Updated uniform record', 'admin', '2026-01-06 04:32:53'),
(9, 'ADD', 'Grade 2 - Rizal (Supplies)', 'Castillo, Ryan M.', 'Added new supply record', 'admin', '2026-01-06 08:53:54'),
(10, 'EDIT', 'Grade 2 - Rizal (Supplies)', 'Castillo, Ryan M.', 'Updated supply record', 'admin', '2026-01-06 08:53:59'),
(12, 'ADD', 'Grade 2 - Rizal (Supplies)', 'Dela Cruz, Juan S.', 'Added new supply record', 'admin', '2026-01-06 08:54:06'),
(14, 'ADD', 'Grade 2 - Rizal (Uniform)', 'Castillo, Ryan M.', 'Added new uniform record', 'admin', '2026-01-06 09:00:01'),
(15, 'EDIT', 'Grade 2 - Rizal (Uniform)', 'Castillo, Ryan M.', 'Updated uniform record', 'admin', '2026-01-06 09:00:06'),
(17, 'ADD', 'Grade 3 - Honesty (Supplies)', 'Dela Cruz, Juan S.', 'Added new supply record', 'admin', '2026-01-06 09:23:16'),
(18, 'EDIT', 'Grade 3 - Honesty (Supplies)', 'Dela Cruz, Juan S.', 'Updated supply record', 'admin', '2026-01-06 09:23:25'),
(20, 'ADD', 'Grade 4 - Andres_Bonifacio (Uniform)', 'Cuyayacoat, Joemarizz G.', 'Added new uniform record', 'admin', '2026-03-08 07:03:49'),
(21, 'ADD', 'Grade 5 - Aguinaldo (Supplies)', 'Cuyacot, Joemari G.', 'Added new supply record', 'admin', '2026-03-20 07:24:27'),
(22, 'EDIT', 'Grade 1 - Abokado (Supplies)', 'Aguilar, Henry Vega', 'Updated supply record', 'abokado', '2026-03-20 07:46:38');

-- --------------------------------------------------------

--
-- Table structure for table `tblsections`
--

CREATE TABLE `tblsections` (
  `id` int(11) NOT NULL,
  `grade` int(11) NOT NULL,
  `section` varchar(50) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tblsections`
--

INSERT INTO `tblsections` (`id`, `grade`, `section`, `created_at`) VALUES
(1, 1, 'Abokado', '2026-02-02 18:47:56'),
(2, 1, 'Buko', '2026-02-02 18:47:56'),
(3, 1, 'Kasoy', '2026-02-02 18:47:56'),
(4, 1, 'Dalandan', '2026-02-02 18:47:56'),
(5, 1, 'Guyabano', '2026-02-02 18:47:56'),
(6, 1, 'Lansones', '2026-02-02 18:47:56'),
(7, 1, 'Mansanas', '2026-02-02 18:47:56'),
(8, 1, 'Rambutan', '2026-02-02 18:47:56'),
(9, 1, 'Saging', '2026-02-02 18:47:56'),
(10, 1, 'Tsiko', '2026-02-02 18:47:56'),
(11, 1, 'Ubas', '2026-02-02 18:47:56'),
(12, 2, 'Anthurium', '2026-02-02 18:47:56'),
(13, 2, 'Bougainvillea', '2026-02-02 18:47:56'),
(14, 2, 'Camia', '2026-02-02 18:47:56'),
(15, 2, 'Daisy', '2026-02-02 18:47:56'),
(16, 2, 'Everlasting', '2026-02-02 18:47:56'),
(17, 2, 'Gumamela', '2026-02-02 18:47:56'),
(18, 2, 'Ilang_Ilang', '2026-02-02 18:47:56'),
(19, 2, 'Jasmine', '2026-02-02 18:47:56'),
(20, 2, 'Orchids', '2026-02-02 18:47:56'),
(21, 2, 'Rose', '2026-02-02 18:47:56'),
(22, 2, 'Sampaguita', '2026-02-02 18:47:56'),
(23, 2, 'Yellow_Bell', '2026-02-02 18:47:56'),
(24, 2, 'Zinnia', '2026-02-02 18:47:56'),
(25, 3, 'Achiever', '2026-02-02 18:47:56'),
(26, 3, 'Brave', '2026-02-02 18:47:56'),
(27, 3, 'Courteous', '2026-02-02 18:47:56'),
(28, 3, 'Friendly', '2026-02-02 18:47:56'),
(29, 3, 'Honest', '2026-02-02 18:47:56'),
(30, 3, 'Generous', '2026-02-02 18:47:56'),
(31, 3, 'Industrious', '2026-02-02 18:47:56'),
(32, 3, 'Lovely', '2026-02-02 18:47:56'),
(33, 4, 'Jose_Rizal', '2026-02-02 18:47:56'),
(34, 4, 'Andres_Bonifacio', '2026-02-02 18:47:56'),
(35, 4, 'Apolinario_Mabini', '2026-02-02 18:47:56'),
(36, 4, 'Lapu_Lapu', '2026-02-02 18:47:56'),
(37, 4, 'Sultan_Kudarat', '2026-02-02 18:47:56'),
(38, 4, 'Jose_Palma', '2026-02-02 18:47:56'),
(39, 4, 'Marcelo_Del_Pilar', '2026-02-02 18:47:56'),
(40, 4, 'Gabriela_Silang', '2026-02-02 18:47:56'),
(41, 4, 'Juan_Luna', '2026-02-02 18:47:56'),
(42, 4, 'Emilio_Jacinto', '2026-02-02 18:47:56'),
(43, 4, 'Gregorio_Del_Pilar', '2026-02-02 18:47:56'),
(44, 5, 'Aguinaldo', '2026-02-02 18:47:56'),
(45, 5, 'Quezon', '2026-02-02 18:47:56'),
(46, 5, 'Laurel', '2026-02-02 18:47:56'),
(47, 5, 'Osmena', '2026-02-02 18:47:56'),
(48, 5, 'Roxas', '2026-02-02 18:47:56'),
(49, 5, 'Quirino', '2026-02-02 18:47:56'),
(50, 5, 'Magsaysay', '2026-02-02 18:47:56'),
(51, 5, 'Garcia', '2026-02-02 18:47:56'),
(52, 5, 'Macapagal', '2026-02-02 18:47:56'),
(53, 5, 'Marcos', '2026-02-02 18:47:56'),
(54, 6, 'Amethyst', '2026-02-02 18:47:56'),
(55, 6, 'Citrine', '2026-02-02 18:47:56'),
(56, 6, 'Beryl', '2026-02-02 18:47:56'),
(57, 6, 'Ruby', '2026-02-02 18:47:56'),
(58, 6, 'Diamond', '2026-02-02 18:47:56'),
(59, 6, 'Sapphire', '2026-02-02 18:47:56'),
(60, 6, 'Pearl', '2026-02-02 18:47:56'),
(61, 6, 'Morganite', '2026-02-02 18:47:56'),
(62, 6, 'Jade', '2026-02-02 18:47:56'),
(63, 6, 'Emerald', '2026-02-02 18:47:56');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tblaccounts`
--
ALTER TABLE `tblaccounts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `tblgrade1abokado`
--
ALTER TABLE `tblgrade1abokado`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lrn_number` (`lrn_number`);

--
-- Indexes for table `tblgrade1abokadosupplies`
--
ALTER TABLE `tblgrade1abokadosupplies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade1abokadouniform`
--
ALTER TABLE `tblgrade1abokadouniform`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade1buko`
--
ALTER TABLE `tblgrade1buko`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lrn_number` (`lrn_number`);

--
-- Indexes for table `tblgrade1bukosupplies`
--
ALTER TABLE `tblgrade1bukosupplies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade1bukouniform`
--
ALTER TABLE `tblgrade1bukouniform`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade1dalandan`
--
ALTER TABLE `tblgrade1dalandan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lrn_number` (`lrn_number`);

--
-- Indexes for table `tblgrade1dalandansupplies`
--
ALTER TABLE `tblgrade1dalandansupplies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade1dalandanuniform`
--
ALTER TABLE `tblgrade1dalandanuniform`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade1guyabano`
--
ALTER TABLE `tblgrade1guyabano`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lrn_number` (`lrn_number`);

--
-- Indexes for table `tblgrade1guyabanosupplies`
--
ALTER TABLE `tblgrade1guyabanosupplies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade1guyabanouniform`
--
ALTER TABLE `tblgrade1guyabanouniform`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade1kasoy`
--
ALTER TABLE `tblgrade1kasoy`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lrn_number` (`lrn_number`);

--
-- Indexes for table `tblgrade1kasoysupplies`
--
ALTER TABLE `tblgrade1kasoysupplies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade1kasoyuniform`
--
ALTER TABLE `tblgrade1kasoyuniform`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade1lansones`
--
ALTER TABLE `tblgrade1lansones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lrn_number` (`lrn_number`);

--
-- Indexes for table `tblgrade1lansonessupplies`
--
ALTER TABLE `tblgrade1lansonessupplies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade1lansonesuniform`
--
ALTER TABLE `tblgrade1lansonesuniform`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade1mansanas`
--
ALTER TABLE `tblgrade1mansanas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lrn_number` (`lrn_number`);

--
-- Indexes for table `tblgrade1mansanassupplies`
--
ALTER TABLE `tblgrade1mansanassupplies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade1mansanasuniform`
--
ALTER TABLE `tblgrade1mansanasuniform`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade1rambutan`
--
ALTER TABLE `tblgrade1rambutan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lrn_number` (`lrn_number`);

--
-- Indexes for table `tblgrade1rambutansupplies`
--
ALTER TABLE `tblgrade1rambutansupplies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade1rambutanuniform`
--
ALTER TABLE `tblgrade1rambutanuniform`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade1saging`
--
ALTER TABLE `tblgrade1saging`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lrn_number` (`lrn_number`);

--
-- Indexes for table `tblgrade1sagingsupplies`
--
ALTER TABLE `tblgrade1sagingsupplies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade1saginguniform`
--
ALTER TABLE `tblgrade1saginguniform`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade1tsiko`
--
ALTER TABLE `tblgrade1tsiko`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lrn_number` (`lrn_number`);

--
-- Indexes for table `tblgrade1tsikosupplies`
--
ALTER TABLE `tblgrade1tsikosupplies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade1tsikouniform`
--
ALTER TABLE `tblgrade1tsikouniform`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade1ubas`
--
ALTER TABLE `tblgrade1ubas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lrn_number` (`lrn_number`);

--
-- Indexes for table `tblgrade1ubassupplies`
--
ALTER TABLE `tblgrade1ubassupplies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade1ubasuniform`
--
ALTER TABLE `tblgrade1ubasuniform`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade3achiever`
--
ALTER TABLE `tblgrade3achiever`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lrn_number` (`lrn_number`);

--
-- Indexes for table `tblgrade3achieversupplies`
--
ALTER TABLE `tblgrade3achieversupplies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade3achieveruniform`
--
ALTER TABLE `tblgrade3achieveruniform`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade3brave`
--
ALTER TABLE `tblgrade3brave`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lrn_number` (`lrn_number`);

--
-- Indexes for table `tblgrade3bravesupplies`
--
ALTER TABLE `tblgrade3bravesupplies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade3braveuniform`
--
ALTER TABLE `tblgrade3braveuniform`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade3courteous`
--
ALTER TABLE `tblgrade3courteous`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lrn_number` (`lrn_number`);

--
-- Indexes for table `tblgrade3courteoussupplies`
--
ALTER TABLE `tblgrade3courteoussupplies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade3courteousuniform`
--
ALTER TABLE `tblgrade3courteousuniform`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade3friendly`
--
ALTER TABLE `tblgrade3friendly`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lrn_number` (`lrn_number`);

--
-- Indexes for table `tblgrade3friendlysupplies`
--
ALTER TABLE `tblgrade3friendlysupplies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade3friendlyuniform`
--
ALTER TABLE `tblgrade3friendlyuniform`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade3generous`
--
ALTER TABLE `tblgrade3generous`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lrn_number` (`lrn_number`);

--
-- Indexes for table `tblgrade3generoussupplies`
--
ALTER TABLE `tblgrade3generoussupplies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade3generousuniform`
--
ALTER TABLE `tblgrade3generousuniform`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade3honest`
--
ALTER TABLE `tblgrade3honest`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lrn_number` (`lrn_number`);

--
-- Indexes for table `tblgrade3honestsupplies`
--
ALTER TABLE `tblgrade3honestsupplies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade3honestuniform`
--
ALTER TABLE `tblgrade3honestuniform`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade3industrious`
--
ALTER TABLE `tblgrade3industrious`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lrn_number` (`lrn_number`);

--
-- Indexes for table `tblgrade3industrioussupplies`
--
ALTER TABLE `tblgrade3industrioussupplies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade3industriousuniform`
--
ALTER TABLE `tblgrade3industriousuniform`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade3lovely`
--
ALTER TABLE `tblgrade3lovely`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lrn_number` (`lrn_number`);

--
-- Indexes for table `tblgrade3lovelysupplies`
--
ALTER TABLE `tblgrade3lovelysupplies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade3lovelyuniform`
--
ALTER TABLE `tblgrade3lovelyuniform`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade4andres_bonifacio`
--
ALTER TABLE `tblgrade4andres_bonifacio`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lrn_number` (`lrn_number`);

--
-- Indexes for table `tblgrade4andres_bonifaciosupplies`
--
ALTER TABLE `tblgrade4andres_bonifaciosupplies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade4andres_bonifaciouniform`
--
ALTER TABLE `tblgrade4andres_bonifaciouniform`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade4apolinario_mabini`
--
ALTER TABLE `tblgrade4apolinario_mabini`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lrn_number` (`lrn_number`);

--
-- Indexes for table `tblgrade4apolinario_mabinisupplies`
--
ALTER TABLE `tblgrade4apolinario_mabinisupplies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade4apolinario_mabiniuniform`
--
ALTER TABLE `tblgrade4apolinario_mabiniuniform`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade4emilio_jacinto`
--
ALTER TABLE `tblgrade4emilio_jacinto`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lrn_number` (`lrn_number`);

--
-- Indexes for table `tblgrade4emilio_jacintosupplies`
--
ALTER TABLE `tblgrade4emilio_jacintosupplies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade4emilio_jacintouniform`
--
ALTER TABLE `tblgrade4emilio_jacintouniform`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade4gabriela_silang`
--
ALTER TABLE `tblgrade4gabriela_silang`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lrn_number` (`lrn_number`);

--
-- Indexes for table `tblgrade4gabriela_silangsupplies`
--
ALTER TABLE `tblgrade4gabriela_silangsupplies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade4gabriela_silanguniform`
--
ALTER TABLE `tblgrade4gabriela_silanguniform`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade4gregorio_del_pilar`
--
ALTER TABLE `tblgrade4gregorio_del_pilar`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lrn_number` (`lrn_number`);

--
-- Indexes for table `tblgrade4gregorio_del_pilarsupplies`
--
ALTER TABLE `tblgrade4gregorio_del_pilarsupplies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade4gregorio_del_pilaruniform`
--
ALTER TABLE `tblgrade4gregorio_del_pilaruniform`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade4jose_palma`
--
ALTER TABLE `tblgrade4jose_palma`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lrn_number` (`lrn_number`);

--
-- Indexes for table `tblgrade4jose_palmasupplies`
--
ALTER TABLE `tblgrade4jose_palmasupplies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade4jose_palmauniform`
--
ALTER TABLE `tblgrade4jose_palmauniform`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade4jose_rizal`
--
ALTER TABLE `tblgrade4jose_rizal`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lrn_number` (`lrn_number`);

--
-- Indexes for table `tblgrade4jose_rizalsupplies`
--
ALTER TABLE `tblgrade4jose_rizalsupplies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade4jose_rizaluniform`
--
ALTER TABLE `tblgrade4jose_rizaluniform`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade4juan_luna`
--
ALTER TABLE `tblgrade4juan_luna`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lrn_number` (`lrn_number`);

--
-- Indexes for table `tblgrade4juan_lunasupplies`
--
ALTER TABLE `tblgrade4juan_lunasupplies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade4juan_lunauniform`
--
ALTER TABLE `tblgrade4juan_lunauniform`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade4lapu_lapu`
--
ALTER TABLE `tblgrade4lapu_lapu`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lrn_number` (`lrn_number`);

--
-- Indexes for table `tblgrade4lapu_lapusupplies`
--
ALTER TABLE `tblgrade4lapu_lapusupplies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade4lapu_lapuuniform`
--
ALTER TABLE `tblgrade4lapu_lapuuniform`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade4marcelo_del_pilar`
--
ALTER TABLE `tblgrade4marcelo_del_pilar`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lrn_number` (`lrn_number`);

--
-- Indexes for table `tblgrade4marcelo_del_pilarsupplies`
--
ALTER TABLE `tblgrade4marcelo_del_pilarsupplies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade4marcelo_del_pilaruniform`
--
ALTER TABLE `tblgrade4marcelo_del_pilaruniform`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade4sultan_kudarat`
--
ALTER TABLE `tblgrade4sultan_kudarat`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lrn_number` (`lrn_number`);

--
-- Indexes for table `tblgrade4sultan_kudaratsupplies`
--
ALTER TABLE `tblgrade4sultan_kudaratsupplies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade4sultan_kudaratuniform`
--
ALTER TABLE `tblgrade4sultan_kudaratuniform`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade5aguinaldo`
--
ALTER TABLE `tblgrade5aguinaldo`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lrn_number` (`lrn_number`);

--
-- Indexes for table `tblgrade5aguinaldosupplies`
--
ALTER TABLE `tblgrade5aguinaldosupplies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade5aguinaldouniform`
--
ALTER TABLE `tblgrade5aguinaldouniform`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade5garcia`
--
ALTER TABLE `tblgrade5garcia`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lrn_number` (`lrn_number`);

--
-- Indexes for table `tblgrade5garciasupplies`
--
ALTER TABLE `tblgrade5garciasupplies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade5garciauniform`
--
ALTER TABLE `tblgrade5garciauniform`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade5laurel`
--
ALTER TABLE `tblgrade5laurel`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lrn_number` (`lrn_number`);

--
-- Indexes for table `tblgrade5laurelsupplies`
--
ALTER TABLE `tblgrade5laurelsupplies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade5laureluniform`
--
ALTER TABLE `tblgrade5laureluniform`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade5macapagal`
--
ALTER TABLE `tblgrade5macapagal`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lrn_number` (`lrn_number`);

--
-- Indexes for table `tblgrade5macapagalsupplies`
--
ALTER TABLE `tblgrade5macapagalsupplies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade5macapagaluniform`
--
ALTER TABLE `tblgrade5macapagaluniform`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade5magsaysay`
--
ALTER TABLE `tblgrade5magsaysay`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lrn_number` (`lrn_number`);

--
-- Indexes for table `tblgrade5magsaysaysupplies`
--
ALTER TABLE `tblgrade5magsaysaysupplies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade5magsaysayuniform`
--
ALTER TABLE `tblgrade5magsaysayuniform`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade5marcos`
--
ALTER TABLE `tblgrade5marcos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lrn_number` (`lrn_number`);

--
-- Indexes for table `tblgrade5marcossupplies`
--
ALTER TABLE `tblgrade5marcossupplies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade5marcosuniform`
--
ALTER TABLE `tblgrade5marcosuniform`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade5osmena`
--
ALTER TABLE `tblgrade5osmena`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lrn_number` (`lrn_number`);

--
-- Indexes for table `tblgrade5osmenasupplies`
--
ALTER TABLE `tblgrade5osmenasupplies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade5osmenauniform`
--
ALTER TABLE `tblgrade5osmenauniform`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade5quezon`
--
ALTER TABLE `tblgrade5quezon`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lrn_number` (`lrn_number`);

--
-- Indexes for table `tblgrade5quezonsupplies`
--
ALTER TABLE `tblgrade5quezonsupplies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade5quezonuniform`
--
ALTER TABLE `tblgrade5quezonuniform`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade5quirino`
--
ALTER TABLE `tblgrade5quirino`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lrn_number` (`lrn_number`);

--
-- Indexes for table `tblgrade5quirinosupplies`
--
ALTER TABLE `tblgrade5quirinosupplies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade5quirinouniform`
--
ALTER TABLE `tblgrade5quirinouniform`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade5roxas`
--
ALTER TABLE `tblgrade5roxas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lrn_number` (`lrn_number`);

--
-- Indexes for table `tblgrade5roxassupplies`
--
ALTER TABLE `tblgrade5roxassupplies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade5roxasuniform`
--
ALTER TABLE `tblgrade5roxasuniform`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade6amethyst`
--
ALTER TABLE `tblgrade6amethyst`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lrn_number` (`lrn_number`);

--
-- Indexes for table `tblgrade6amethystsupplies`
--
ALTER TABLE `tblgrade6amethystsupplies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade6amethystuniform`
--
ALTER TABLE `tblgrade6amethystuniform`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade6beryl`
--
ALTER TABLE `tblgrade6beryl`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lrn_number` (`lrn_number`);

--
-- Indexes for table `tblgrade6berylsupplies`
--
ALTER TABLE `tblgrade6berylsupplies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade6beryluniform`
--
ALTER TABLE `tblgrade6beryluniform`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade6citrine`
--
ALTER TABLE `tblgrade6citrine`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lrn_number` (`lrn_number`);

--
-- Indexes for table `tblgrade6citrinesupplies`
--
ALTER TABLE `tblgrade6citrinesupplies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade6citrineuniform`
--
ALTER TABLE `tblgrade6citrineuniform`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade6diamond`
--
ALTER TABLE `tblgrade6diamond`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lrn_number` (`lrn_number`);

--
-- Indexes for table `tblgrade6diamondsupplies`
--
ALTER TABLE `tblgrade6diamondsupplies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade6diamonduniform`
--
ALTER TABLE `tblgrade6diamonduniform`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade6emerald`
--
ALTER TABLE `tblgrade6emerald`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lrn_number` (`lrn_number`);

--
-- Indexes for table `tblgrade6emeraldsupplies`
--
ALTER TABLE `tblgrade6emeraldsupplies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade6emeralduniform`
--
ALTER TABLE `tblgrade6emeralduniform`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade6jade`
--
ALTER TABLE `tblgrade6jade`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lrn_number` (`lrn_number`);

--
-- Indexes for table `tblgrade6jadesupplies`
--
ALTER TABLE `tblgrade6jadesupplies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade6jadeuniform`
--
ALTER TABLE `tblgrade6jadeuniform`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade6morganite`
--
ALTER TABLE `tblgrade6morganite`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lrn_number` (`lrn_number`);

--
-- Indexes for table `tblgrade6morganitesupplies`
--
ALTER TABLE `tblgrade6morganitesupplies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade6morganiteuniform`
--
ALTER TABLE `tblgrade6morganiteuniform`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade6pearl`
--
ALTER TABLE `tblgrade6pearl`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lrn_number` (`lrn_number`);

--
-- Indexes for table `tblgrade6pearlsupplies`
--
ALTER TABLE `tblgrade6pearlsupplies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade6pearluniform`
--
ALTER TABLE `tblgrade6pearluniform`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade6ruby`
--
ALTER TABLE `tblgrade6ruby`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lrn_number` (`lrn_number`);

--
-- Indexes for table `tblgrade6rubysupplies`
--
ALTER TABLE `tblgrade6rubysupplies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade6rubyuniform`
--
ALTER TABLE `tblgrade6rubyuniform`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade6sapphire`
--
ALTER TABLE `tblgrade6sapphire`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lrn_number` (`lrn_number`);

--
-- Indexes for table `tblgrade6sapphiresupplies`
--
ALTER TABLE `tblgrade6sapphiresupplies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblgrade6sapphireuniform`
--
ALTER TABLE `tblgrade6sapphireuniform`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbllogs`
--
ALTER TABLE `tbllogs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_section` (`section`),
  ADD KEY `idx_created_by` (`created_by`),
  ADD KEY `idx_date` (`date_created`);

--
-- Indexes for table `tblsections`
--
ALTER TABLE `tblsections`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tblaccounts`
--
ALTER TABLE `tblaccounts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `tblgrade1abokado`
--
ALTER TABLE `tblgrade1abokado`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=124;

--
-- AUTO_INCREMENT for table `tblgrade1abokadosupplies`
--
ALTER TABLE `tblgrade1abokadosupplies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `tblgrade1abokadouniform`
--
ALTER TABLE `tblgrade1abokadouniform`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=62;

--
-- AUTO_INCREMENT for table `tblgrade1buko`
--
ALTER TABLE `tblgrade1buko`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=92;

--
-- AUTO_INCREMENT for table `tblgrade1bukosupplies`
--
ALTER TABLE `tblgrade1bukosupplies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `tblgrade1bukouniform`
--
ALTER TABLE `tblgrade1bukouniform`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade1dalandan`
--
ALTER TABLE `tblgrade1dalandan`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT for table `tblgrade1dalandansupplies`
--
ALTER TABLE `tblgrade1dalandansupplies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade1dalandanuniform`
--
ALTER TABLE `tblgrade1dalandanuniform`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade1guyabano`
--
ALTER TABLE `tblgrade1guyabano`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT for table `tblgrade1guyabanosupplies`
--
ALTER TABLE `tblgrade1guyabanosupplies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade1guyabanouniform`
--
ALTER TABLE `tblgrade1guyabanouniform`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade1kasoy`
--
ALTER TABLE `tblgrade1kasoy`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT for table `tblgrade1kasoysupplies`
--
ALTER TABLE `tblgrade1kasoysupplies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade1kasoyuniform`
--
ALTER TABLE `tblgrade1kasoyuniform`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade1lansones`
--
ALTER TABLE `tblgrade1lansones`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT for table `tblgrade1lansonessupplies`
--
ALTER TABLE `tblgrade1lansonessupplies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade1lansonesuniform`
--
ALTER TABLE `tblgrade1lansonesuniform`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade1mansanas`
--
ALTER TABLE `tblgrade1mansanas`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT for table `tblgrade1mansanassupplies`
--
ALTER TABLE `tblgrade1mansanassupplies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade1mansanasuniform`
--
ALTER TABLE `tblgrade1mansanasuniform`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade1rambutan`
--
ALTER TABLE `tblgrade1rambutan`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT for table `tblgrade1rambutansupplies`
--
ALTER TABLE `tblgrade1rambutansupplies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade1rambutanuniform`
--
ALTER TABLE `tblgrade1rambutanuniform`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade1saging`
--
ALTER TABLE `tblgrade1saging`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT for table `tblgrade1sagingsupplies`
--
ALTER TABLE `tblgrade1sagingsupplies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade1saginguniform`
--
ALTER TABLE `tblgrade1saginguniform`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade1tsiko`
--
ALTER TABLE `tblgrade1tsiko`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT for table `tblgrade1tsikosupplies`
--
ALTER TABLE `tblgrade1tsikosupplies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade1tsikouniform`
--
ALTER TABLE `tblgrade1tsikouniform`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade1ubas`
--
ALTER TABLE `tblgrade1ubas`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT for table `tblgrade1ubassupplies`
--
ALTER TABLE `tblgrade1ubassupplies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade1ubasuniform`
--
ALTER TABLE `tblgrade1ubasuniform`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade3achiever`
--
ALTER TABLE `tblgrade3achiever`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tblgrade3achieversupplies`
--
ALTER TABLE `tblgrade3achieversupplies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tblgrade3achieveruniform`
--
ALTER TABLE `tblgrade3achieveruniform`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tblgrade3brave`
--
ALTER TABLE `tblgrade3brave`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade3bravesupplies`
--
ALTER TABLE `tblgrade3bravesupplies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade3braveuniform`
--
ALTER TABLE `tblgrade3braveuniform`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade3courteous`
--
ALTER TABLE `tblgrade3courteous`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade3courteoussupplies`
--
ALTER TABLE `tblgrade3courteoussupplies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade3courteousuniform`
--
ALTER TABLE `tblgrade3courteousuniform`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade3friendly`
--
ALTER TABLE `tblgrade3friendly`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade3friendlysupplies`
--
ALTER TABLE `tblgrade3friendlysupplies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade3friendlyuniform`
--
ALTER TABLE `tblgrade3friendlyuniform`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade3generous`
--
ALTER TABLE `tblgrade3generous`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade3generoussupplies`
--
ALTER TABLE `tblgrade3generoussupplies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade3generousuniform`
--
ALTER TABLE `tblgrade3generousuniform`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade3honest`
--
ALTER TABLE `tblgrade3honest`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade3honestsupplies`
--
ALTER TABLE `tblgrade3honestsupplies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade3honestuniform`
--
ALTER TABLE `tblgrade3honestuniform`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade3industrious`
--
ALTER TABLE `tblgrade3industrious`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade3industrioussupplies`
--
ALTER TABLE `tblgrade3industrioussupplies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade3industriousuniform`
--
ALTER TABLE `tblgrade3industriousuniform`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade3lovely`
--
ALTER TABLE `tblgrade3lovely`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade3lovelysupplies`
--
ALTER TABLE `tblgrade3lovelysupplies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade3lovelyuniform`
--
ALTER TABLE `tblgrade3lovelyuniform`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade4andres_bonifacio`
--
ALTER TABLE `tblgrade4andres_bonifacio`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tblgrade4andres_bonifaciosupplies`
--
ALTER TABLE `tblgrade4andres_bonifaciosupplies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade4andres_bonifaciouniform`
--
ALTER TABLE `tblgrade4andres_bonifaciouniform`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tblgrade4apolinario_mabini`
--
ALTER TABLE `tblgrade4apolinario_mabini`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade4apolinario_mabinisupplies`
--
ALTER TABLE `tblgrade4apolinario_mabinisupplies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade4apolinario_mabiniuniform`
--
ALTER TABLE `tblgrade4apolinario_mabiniuniform`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade4emilio_jacinto`
--
ALTER TABLE `tblgrade4emilio_jacinto`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade4emilio_jacintosupplies`
--
ALTER TABLE `tblgrade4emilio_jacintosupplies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade4emilio_jacintouniform`
--
ALTER TABLE `tblgrade4emilio_jacintouniform`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade4gabriela_silang`
--
ALTER TABLE `tblgrade4gabriela_silang`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade4gabriela_silangsupplies`
--
ALTER TABLE `tblgrade4gabriela_silangsupplies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade4gabriela_silanguniform`
--
ALTER TABLE `tblgrade4gabriela_silanguniform`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade4gregorio_del_pilar`
--
ALTER TABLE `tblgrade4gregorio_del_pilar`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade4gregorio_del_pilarsupplies`
--
ALTER TABLE `tblgrade4gregorio_del_pilarsupplies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade4gregorio_del_pilaruniform`
--
ALTER TABLE `tblgrade4gregorio_del_pilaruniform`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade4jose_palma`
--
ALTER TABLE `tblgrade4jose_palma`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade4jose_palmasupplies`
--
ALTER TABLE `tblgrade4jose_palmasupplies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade4jose_palmauniform`
--
ALTER TABLE `tblgrade4jose_palmauniform`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade4jose_rizal`
--
ALTER TABLE `tblgrade4jose_rizal`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade4jose_rizalsupplies`
--
ALTER TABLE `tblgrade4jose_rizalsupplies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade4jose_rizaluniform`
--
ALTER TABLE `tblgrade4jose_rizaluniform`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade4juan_luna`
--
ALTER TABLE `tblgrade4juan_luna`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade4juan_lunasupplies`
--
ALTER TABLE `tblgrade4juan_lunasupplies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade4juan_lunauniform`
--
ALTER TABLE `tblgrade4juan_lunauniform`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade4lapu_lapu`
--
ALTER TABLE `tblgrade4lapu_lapu`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade4lapu_lapusupplies`
--
ALTER TABLE `tblgrade4lapu_lapusupplies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade4lapu_lapuuniform`
--
ALTER TABLE `tblgrade4lapu_lapuuniform`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade4marcelo_del_pilar`
--
ALTER TABLE `tblgrade4marcelo_del_pilar`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade4marcelo_del_pilarsupplies`
--
ALTER TABLE `tblgrade4marcelo_del_pilarsupplies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade4marcelo_del_pilaruniform`
--
ALTER TABLE `tblgrade4marcelo_del_pilaruniform`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade4sultan_kudarat`
--
ALTER TABLE `tblgrade4sultan_kudarat`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade4sultan_kudaratsupplies`
--
ALTER TABLE `tblgrade4sultan_kudaratsupplies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade4sultan_kudaratuniform`
--
ALTER TABLE `tblgrade4sultan_kudaratuniform`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade5aguinaldo`
--
ALTER TABLE `tblgrade5aguinaldo`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tblgrade5aguinaldosupplies`
--
ALTER TABLE `tblgrade5aguinaldosupplies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tblgrade5aguinaldouniform`
--
ALTER TABLE `tblgrade5aguinaldouniform`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade5garcia`
--
ALTER TABLE `tblgrade5garcia`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade5garciasupplies`
--
ALTER TABLE `tblgrade5garciasupplies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade5garciauniform`
--
ALTER TABLE `tblgrade5garciauniform`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade5laurel`
--
ALTER TABLE `tblgrade5laurel`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade5laurelsupplies`
--
ALTER TABLE `tblgrade5laurelsupplies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade5laureluniform`
--
ALTER TABLE `tblgrade5laureluniform`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade5macapagal`
--
ALTER TABLE `tblgrade5macapagal`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade5macapagalsupplies`
--
ALTER TABLE `tblgrade5macapagalsupplies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade5macapagaluniform`
--
ALTER TABLE `tblgrade5macapagaluniform`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade5magsaysay`
--
ALTER TABLE `tblgrade5magsaysay`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade5magsaysaysupplies`
--
ALTER TABLE `tblgrade5magsaysaysupplies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade5magsaysayuniform`
--
ALTER TABLE `tblgrade5magsaysayuniform`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade5marcos`
--
ALTER TABLE `tblgrade5marcos`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade5marcossupplies`
--
ALTER TABLE `tblgrade5marcossupplies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade5marcosuniform`
--
ALTER TABLE `tblgrade5marcosuniform`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade5osmena`
--
ALTER TABLE `tblgrade5osmena`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade5osmenasupplies`
--
ALTER TABLE `tblgrade5osmenasupplies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade5osmenauniform`
--
ALTER TABLE `tblgrade5osmenauniform`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade5quezon`
--
ALTER TABLE `tblgrade5quezon`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade5quezonsupplies`
--
ALTER TABLE `tblgrade5quezonsupplies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade5quezonuniform`
--
ALTER TABLE `tblgrade5quezonuniform`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade5quirino`
--
ALTER TABLE `tblgrade5quirino`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade5quirinosupplies`
--
ALTER TABLE `tblgrade5quirinosupplies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade5quirinouniform`
--
ALTER TABLE `tblgrade5quirinouniform`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade5roxas`
--
ALTER TABLE `tblgrade5roxas`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade5roxassupplies`
--
ALTER TABLE `tblgrade5roxassupplies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade5roxasuniform`
--
ALTER TABLE `tblgrade5roxasuniform`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade6amethyst`
--
ALTER TABLE `tblgrade6amethyst`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade6amethystsupplies`
--
ALTER TABLE `tblgrade6amethystsupplies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade6amethystuniform`
--
ALTER TABLE `tblgrade6amethystuniform`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade6beryl`
--
ALTER TABLE `tblgrade6beryl`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade6berylsupplies`
--
ALTER TABLE `tblgrade6berylsupplies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade6beryluniform`
--
ALTER TABLE `tblgrade6beryluniform`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade6citrine`
--
ALTER TABLE `tblgrade6citrine`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade6citrinesupplies`
--
ALTER TABLE `tblgrade6citrinesupplies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade6citrineuniform`
--
ALTER TABLE `tblgrade6citrineuniform`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade6diamond`
--
ALTER TABLE `tblgrade6diamond`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade6diamondsupplies`
--
ALTER TABLE `tblgrade6diamondsupplies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade6diamonduniform`
--
ALTER TABLE `tblgrade6diamonduniform`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade6emerald`
--
ALTER TABLE `tblgrade6emerald`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade6emeraldsupplies`
--
ALTER TABLE `tblgrade6emeraldsupplies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade6emeralduniform`
--
ALTER TABLE `tblgrade6emeralduniform`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade6jade`
--
ALTER TABLE `tblgrade6jade`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade6jadesupplies`
--
ALTER TABLE `tblgrade6jadesupplies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade6jadeuniform`
--
ALTER TABLE `tblgrade6jadeuniform`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade6morganite`
--
ALTER TABLE `tblgrade6morganite`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade6morganitesupplies`
--
ALTER TABLE `tblgrade6morganitesupplies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade6morganiteuniform`
--
ALTER TABLE `tblgrade6morganiteuniform`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade6pearl`
--
ALTER TABLE `tblgrade6pearl`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade6pearlsupplies`
--
ALTER TABLE `tblgrade6pearlsupplies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade6pearluniform`
--
ALTER TABLE `tblgrade6pearluniform`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade6ruby`
--
ALTER TABLE `tblgrade6ruby`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade6rubysupplies`
--
ALTER TABLE `tblgrade6rubysupplies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade6rubyuniform`
--
ALTER TABLE `tblgrade6rubyuniform`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade6sapphire`
--
ALTER TABLE `tblgrade6sapphire`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade6sapphiresupplies`
--
ALTER TABLE `tblgrade6sapphiresupplies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblgrade6sapphireuniform`
--
ALTER TABLE `tblgrade6sapphireuniform`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbllogs`
--
ALTER TABLE `tbllogs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `tblsections`
--
ALTER TABLE `tblsections`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
