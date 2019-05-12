-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 12, 2019 at 09:33 PM
-- Server version: 10.1.37-MariaDB
-- PHP Version: 7.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sipjw_schedule`
--

-- --------------------------------------------------------

--
-- Table structure for table `jadwal`
--

CREATE TABLE `jadwal` (
  `id` int(12) NOT NULL,
  `tanggal` varchar(24) NOT NULL,
  `waktu` varchar(12) NOT NULL,
  `tempat` varchar(32) NOT NULL,
  `acara` varchar(32) NOT NULL,
  `tujuan_undangan` varchar(32) NOT NULL,
  `penanggung_jawab` varchar(32) NOT NULL,
  `yang_menghadiri` varchar(32) NOT NULL,
  `keterangan` varchar(32) NOT NULL,
  `pejabat` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `jadwal`
--

INSERT INTO `jadwal` (`id`, `tanggal`, `waktu`, `tempat`, `acara`, `tujuan_undangan`, `penanggung_jawab`, `yang_menghadiri`, `keterangan`, `pejabat`) VALUES
(2, '', '', '', 'Hm', '', '', '', '', ''),
(3, '', '', '', 'Yes', '', '', '', '', ''),
(4, '', '', '', 'Ulala', '', '', '', '', ''),
(10, '', '', '', 'Yes or yes', '', '', '', '', ''),
(11, '', '', '', 'Yes or yes', '', '', '', '', ''),
(12, '', '', '', 'Henry', '', '', '', '', ''),
(13, '', '', '', 'Kael', '', '', '', '', ''),
(14, '', '', '', '', '', '', '', '', ''),
(15, '', '', '', '', '', '', '', '', ''),
(16, '', '', '', '', '', '', '', '', ''),
(17, '', '', '', '', '', '', '', '', ''),
(18, '', '', '', '', '', '', '', '', '');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `jadwal`
--
ALTER TABLE `jadwal`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `jadwal`
--
ALTER TABLE `jadwal`
  MODIFY `id` int(12) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
