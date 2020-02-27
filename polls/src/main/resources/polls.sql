-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 27, 2020 at 09:26 AM
-- Server version: 10.4.8-MariaDB
-- PHP Version: 7.3.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `polls`
--

-- --------------------------------------------------------

--
-- Table structure for table `choices`
--

CREATE TABLE `choices` (
  `id` bigint(20) NOT NULL,
  `text` varchar(50) DEFAULT NULL,
  `poll_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `choices`
--

INSERT INTO `choices` (`id`, `text`, `poll_id`) VALUES
(17, 'Java', 7),
(18, '.Net', 7),
(19, 'Go', 7),
(20, 'PHP', 7),
(21, 'C', 7),
(22, 'Ruby', 7);

-- --------------------------------------------------------

--
-- Table structure for table `master_user`
--

CREATE TABLE `master_user` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `email` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `username` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `master_user`
--

INSERT INTO `master_user` (`id`, `created_at`, `updated_at`, `email`, `name`, `password`, `username`) VALUES
(1, '2020-02-26 00:00:00', '2020-02-26 00:00:00', 'ars@email.com', 'Aris', '$2a$10$XwZZT4PxZ/KPxhTYYHzlLOwINOJuwNV42QCRe8QRu6LK4xRNxh.fa', 'Aris'),
(2, '2020-02-26 00:00:00', '2020-02-26 00:00:00', 'setiawan@email.com', 'Setiawan', '$2a$10$XwZZT4PxZ/KPxhTYYHzlLOwINOJuwNV42QCRe8QRu6LK4xRNxh.fa', 'Setiawan'),
(3, '2020-02-27 11:41:58', '2020-02-27 11:41:58', 'asep@email.com', 'Asep', '$2a$10$XwZZT4PxZ/KPxhTYYHzlLOwINOJuwNV42QCRe8QRu6LK4xRNxh.fa', 'Asep');

-- --------------------------------------------------------

--
-- Table structure for table `polls`
--

CREATE TABLE `polls` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `created_by` bigint(20) DEFAULT NULL,
  `updated_by` bigint(20) DEFAULT NULL,
  `expiration_date_time` datetime NOT NULL,
  `question` varchar(150) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `polls`
--

INSERT INTO `polls` (`id`, `created_at`, `updated_at`, `created_by`, `updated_by`, `expiration_date_time`, `question`) VALUES
(7, '2020-02-27 13:47:51', '2020-02-27 13:47:51', 1, 1, '2020-02-28 13:46:36', 'The best database');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`) VALUES
(2, 'ROLE_ADMIN'),
(1, 'ROLE_USER');

-- --------------------------------------------------------

--
-- Table structure for table `user_roles`
--

CREATE TABLE `user_roles` (
  `user_id` bigint(20) NOT NULL,
  `role_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user_roles`
--

INSERT INTO `user_roles` (`user_id`, `role_id`) VALUES
(1, 2),
(2, 1),
(3, 1);

-- --------------------------------------------------------

--
-- Table structure for table `votes`
--

CREATE TABLE `votes` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `choice_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `poll_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `votes`
--

INSERT INTO `votes` (`id`, `created_at`, `updated_at`, `choice_id`, `user_id`, `poll_id`) VALUES
(1, '2020-02-27 15:15:00', '2020-02-27 15:15:00', 17, 2, 7),
(2, '2020-02-27 15:15:36', '2020-02-27 15:15:36', 17, 3, 7);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `choices`
--
ALTER TABLE `choices`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK1i68hpih40n447wqx4lpef6ot` (`poll_id`);

--
-- Indexes for table `master_user`
--
ALTER TABLE `master_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UK93b42onsq8gen9bba6uxdfb2x` (`username`),
  ADD UNIQUE KEY `UK164v0209gpjrsi5xw6fkk5a32` (`email`);

--
-- Indexes for table `polls`
--
ALTER TABLE `polls`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UK_nb4h0p6txrmfc0xbrd1kglp9t` (`name`);

--
-- Indexes for table `user_roles`
--
ALTER TABLE `user_roles`
  ADD PRIMARY KEY (`user_id`,`role_id`),
  ADD KEY `FKh8ciramu9cc9q3qcqiv4ue8a6` (`role_id`);

--
-- Indexes for table `votes`
--
ALTER TABLE `votes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UK8um9h2wxsdjrgx3rjjwvny676` (`poll_id`,`user_id`),
  ADD KEY `FKomskymhxde3qq9mcukyp1puio` (`choice_id`),
  ADD KEY `FKaorjh3ym23c168t4jfksj371m` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `choices`
--
ALTER TABLE `choices`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `master_user`
--
ALTER TABLE `master_user`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `polls`
--
ALTER TABLE `polls`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `votes`
--
ALTER TABLE `votes`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `choices`
--
ALTER TABLE `choices`
  ADD CONSTRAINT `FK1i68hpih40n447wqx4lpef6ot` FOREIGN KEY (`poll_id`) REFERENCES `polls` (`id`);

--
-- Constraints for table `user_roles`
--
ALTER TABLE `user_roles`
  ADD CONSTRAINT `FK2irkssr9sqwji8rrj0kv1fnm2` FOREIGN KEY (`user_id`) REFERENCES `master_user` (`id`),
  ADD CONSTRAINT `FKh8ciramu9cc9q3qcqiv4ue8a6` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`);

--
-- Constraints for table `votes`
--
ALTER TABLE `votes`
  ADD CONSTRAINT `FK7trt3uyihr4g13hva9d31puxg` FOREIGN KEY (`poll_id`) REFERENCES `polls` (`id`),
  ADD CONSTRAINT `FKaorjh3ym23c168t4jfksj371m` FOREIGN KEY (`user_id`) REFERENCES `master_user` (`id`),
  ADD CONSTRAINT `FKomskymhxde3qq9mcukyp1puio` FOREIGN KEY (`choice_id`) REFERENCES `choices` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
