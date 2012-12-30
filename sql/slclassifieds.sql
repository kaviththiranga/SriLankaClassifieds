-- phpMyAdmin SQL Dump
-- version 3.4.10.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Dec 30, 2012 at 10:45 AM
-- Server version: 5.5.20
-- PHP Version: 5.3.10

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `slclassifieds`
--

-- --------------------------------------------------------

--
-- Table structure for table `ads`
--

CREATE TABLE IF NOT EXISTS `ads` (
  `AD_ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `CAT_ID` int(10) unsigned NOT NULL,
  `USER_ID` int(10) unsigned NOT NULL,
  `TITLE` varchar(200) NOT NULL,
  `DESC` varchar(2000) DEFAULT NULL,
  `PRICE` float NOT NULL,
  `IMG1` varchar(200) DEFAULT NULL,
  `IMG2` varchar(200) DEFAULT NULL,
  `IMG3` varchar(200) DEFAULT NULL,
  `CREATED` date NOT NULL,
  PRIMARY KEY (`AD_ID`),
  KEY `CAT_ID` (`CAT_ID`),
  KEY `USER_ID` (`USER_ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `ads`
--

INSERT INTO `ads` (`AD_ID`, `CAT_ID`, `USER_ID`, `TITLE`, `DESC`, `PRICE`, `IMG1`, `IMG2`, `IMG3`, `CREATED`) VALUES
(1, 1, 21, 'Ad Tinerefe', 'dfdfdf', 450, NULL, NULL, NULL, '2012-12-30');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE IF NOT EXISTS `categories` (
  `CAT_ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `CAT_NAME` varchar(100) NOT NULL,
  `DESC` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`CAT_ID`),
  UNIQUE KEY `CAT_NAME` (`CAT_NAME`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=11 ;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`CAT_ID`, `CAT_NAME`, `DESC`) VALUES
(1, 'Electronics', 'Find great deals for used electronics in Sri Lanka including mobile phones, computers, laptops, TVs, home theatres and much more.'),
(2, 'Used Cars & Vehicles', 'Buy and sell used cars, motorbikes and other vehicles in Sri Lanka. Choose from top brands including Toyota, Nissan, Honda and Suzuki.'),
(3, 'Property', 'View listings for property in Sri Lanka. Find the cheapest rates for apartments, commercial and residential properties, as well as for land and plots.'),
(4, 'Home & Personal Items', 'Buy and sell new and used home appliances including furniture, kitchen items, garden products and other household items in Sri Lanka.'),
(5, 'Jobs', 'Post and apply for jobs and career opportunities in Sri Lanka. Search for job vacancies in your city.'),
(6, 'Leisure, Sport & Hobby', 'Buy and sell used musical instruments, sports gear and accessories, art and collectibles, movies, music and more.'),
(7, 'Education', 'Buy and sell books and magazines, find tuition, classes and other educational resources in Sri Lanka.'),
(8, 'Animals', 'Search from the widest variety of pets in Sri Lanka. Select from dogs, puppies, cats, kittens, birds and other domesticated animals.'),
(9, 'Other', 'Free classified ads for miscellaneous products and items all over Sri Lanka. Buy and sell almost anything.'),
(10, 'Food & Agriculture', 'Find food and edible products, including fresh fruits and vegetables, meats, fish, seafood, crop seeds, plants and other agricultural products in Sri Lanka.');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE IF NOT EXISTS `roles` (
  `USER_ROLE_ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ROLE` varchar(45) NOT NULL,
  PRIMARY KEY (`USER_ROLE_ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`USER_ROLE_ID`, `ROLE`) VALUES
(1, 'ROLE_USER'),
(2, 'ROLE_ADMIN'),
(3, 'ROLE_MODERATOR');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `USER_ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `USERNAME` varchar(45) NOT NULL,
  `PASSWORD` varchar(45) NOT NULL,
  `ENABLED` tinyint(1) NOT NULL,
  `NAME` varchar(100) NOT NULL,
  `EMAIL` varchar(50) DEFAULT NULL,
  `CONTACT_NO` varchar(10) DEFAULT NULL,
  `DISTRICT` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`USER_ID`),
  UNIQUE KEY `USERNAME` (`USERNAME`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=29 ;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`USER_ID`, `USERNAME`, `PASSWORD`, `ENABLED`, `NAME`, `EMAIL`, `CONTACT_NO`, `DISTRICT`) VALUES
(21, 'pubudishanika', '123123', 1, 'Pubudi Shanika Wanigatunga', 'rc404mekt@gmail.com', '0714556402', 'Colombo'),
(22, 'kaviththiranga', '123456', 1, 'Pubudi Shanika Wanigatunga', 'rc404mekt@gmail.com', '0714556402', 'Monaragala'),
(23, 'pubudishanikaa', '123456', 1, 'Pubudi Shanika Wanigatunga', 'rc404mekt@gmail.com', '0714556402', 'Colombo'),
(24, 'pubudishanikafg', '123456', 1, 'Pubudi Shanika Wanigatunga', 'rc404mekt@gmail.com', '0714556402', 'Colombo'),
(25, 'pubudishanikadfdf', '123123', 1, 'Pubudi Shanika Wanigatunga', 'rc404mekt@gmail.com', '0714556402', 'Colombo'),
(26, 'vbnggngn', '123123', 1, 'Pubudi Shanika Wanigatunga', 'rc404mekt@gmail.com', '0714556402', 'Colombo'),
(27, 'dfdfdf', '232323', 1, 'Pubudi Shanika Wanigatunga', 'rc404mekt@gmail.com', '0714556402', 'Colombo'),
(28, 'kaviththirangadfdfdfdf', '123456', 1, 'Pubudi Shanika Wanigatunga', 'rc404mekt@gmail.com', '0714556402', 'Colombo');

-- --------------------------------------------------------

--
-- Table structure for table `user_role`
--

CREATE TABLE IF NOT EXISTS `user_role` (
  `USER_ID` int(10) unsigned NOT NULL,
  `USER_ROLE_ID` int(10) unsigned NOT NULL,
  KEY `USER_ID` (`USER_ID`,`USER_ROLE_ID`),
  KEY `USER_ROLE_ID` (`USER_ROLE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_role`
--

INSERT INTO `user_role` (`USER_ID`, `USER_ROLE_ID`) VALUES
(21, 1),
(21, 2),
(23, 1),
(24, 1),
(25, 1),
(26, 1),
(27, 1),
(28, 1);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `ads`
--
ALTER TABLE `ads`
  ADD CONSTRAINT `ads_ibfk_1` FOREIGN KEY (`CAT_ID`) REFERENCES `categories` (`CAT_ID`);

--
-- Constraints for table `user_role`
--
ALTER TABLE `user_role`
  ADD CONSTRAINT `user_role_ibfk_2` FOREIGN KEY (`USER_ROLE_ID`) REFERENCES `roles` (`USER_ROLE_ID`),
  ADD CONSTRAINT `user_role_ibfk_4` FOREIGN KEY (`USER_ID`) REFERENCES `users` (`USER_ID`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
