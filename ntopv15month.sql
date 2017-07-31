-- phpMyAdmin SQL Dump
-- version 4.0.10deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jul 31, 2017 at 11:45 AM
-- Server version: 5.5.44-0ubuntu0.14.04.1
-- PHP Version: 5.5.9-1ubuntu4.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `bandwidth`
--

-- --------------------------------------------------------

--
-- Table structure for table `ntopv15month`
--

CREATE TABLE IF NOT EXISTS `ntopv15month` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(25) NOT NULL,
  `hostResolvedName` varchar(25) NOT NULL,
  `pktsSent` varchar(25) NOT NULL,
  `pktsRcvd` varchar(25) NOT NULL,
  `ipv4BytesSent` varchar(25) NOT NULL,
  `ipv4BytesRcvd` varchar(25) NOT NULL,
  `bytesMulticastSent` varchar(25) NOT NULL,
  `pktsMulticastSent` varchar(25) NOT NULL,
  `bytesMulticastRcvd` varchar(25) NOT NULL,
  `pktsMulticastRcvd` varchar(25) NOT NULL,
  `bytesSent` varchar(25) NOT NULL,
  `bytesRcvd` varchar(25) NOT NULL,
  `ipv6BytesSent` varchar(25) NOT NULL,
  `ipv6BytesRcvd` varchar(25) NOT NULL,
  `tcpBytesSent` varchar(25) NOT NULL,
  `tcpBytesRcvd` varchar(25) NOT NULL,
  `udpBytesSent` varchar(25) NOT NULL,
  `udpBytesRcvd` varchar(25) NOT NULL,
  `icmpSent` varchar(25) NOT NULL,
  `icmpRcvd` varchar(25) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ethAddressString` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
