-- phpMyAdmin SQL Dump
-- version 4.8.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: 18-Maio-2024 às 00:14
-- Versão do servidor: 5.7.24
-- versão do PHP: 7.2.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `marketplace`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `addresses`
--

DROP TABLE IF EXISTS `addresses`;
CREATE TABLE IF NOT EXISTS `addresses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `street` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `neighbourhood` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `number` int(11) DEFAULT NULL,
  `city` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `state` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `postal_code` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `country` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `categories`
--

DROP TABLE IF EXISTS `categories`;
CREATE TABLE IF NOT EXISTS `categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_520_ci,
  `parent_category_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_category_parent` (`parent_category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

--
-- Extraindo dados da tabela `categories`
--

INSERT INTO `categories` (`id`, `name`, `description`, `parent_category_id`, `created_at`) VALUES
(1, 'Electronics', 'Electronic devices and accessories', NULL, '2024-03-21 01:03:14'),
(2, 'Clothing', 'Apparel and fashion accessories', NULL, '2024-03-21 01:03:14'),
(3, 'Books', 'Books in various genres', NULL, '2024-03-21 01:03:14'),
(4, 'Smartphones', 'Mobile phones and smartphones', 1, '2024-03-21 01:03:14'),
(5, 'Laptops', 'Laptops and notebook computers', 1, '2024-03-21 01:03:14'),
(6, 'Headphones', 'Headphones and audio accessories', 1, '2024-03-21 01:03:14'),
(7, 'Shirts', 'Men\'s and women\'s shirts and tops', 2, '2024-03-21 01:03:14'),
(8, 'Dresses', 'Women\'s dresses and gowns', 2, '2024-03-21 01:03:14'),
(9, 'Jeans', 'Men\'s and women\'s jeans', 2, '2024-03-21 01:03:14'),
(10, 'Fiction', 'Fiction books in various genres', 3, '2024-03-21 01:03:14'),
(11, 'Non-Fiction', 'Non-fiction books on various topics', 3, '2024-03-21 01:03:14'),
(12, 'Children\'s Books', 'Books for children and young readers', 3, '2024-03-21 01:03:14');

-- --------------------------------------------------------

--
-- Estrutura da tabela `messages`
--

DROP TABLE IF EXISTS `messages`;
CREATE TABLE IF NOT EXISTS `messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sender_id` int(11) DEFAULT NULL,
  `receiver_id` int(11) DEFAULT NULL,
  `content` text COLLATE utf8mb4_unicode_520_ci,
  `is_read` tinyint(1) DEFAULT '0',
  `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `sender_id` (`sender_id`),
  KEY `receiver_id` (`receiver_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `products`
--

DROP TABLE IF EXISTS `products`;
CREATE TABLE IF NOT EXISTS `products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `seller_id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_520_ci,
  `category_id` int(11) DEFAULT NULL,
  `brand` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `model` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `product_condition` varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `available` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `is_seller_verified` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_product_seller` (`seller_id`),
  KEY `fk_product_category` (`category_id`),
  KEY `fk_is_seller_verified` (`is_seller_verified`)
) ENGINE=MyISAM AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

--
-- Extraindo dados da tabela `products`
--

INSERT INTO `products` (`id`, `seller_id`, `name`, `description`, `category_id`, `brand`, `model`, `product_condition`, `price`, `available`, `created_at`, `is_seller_verified`) VALUES
(1, 1, 'TÊNIS QIX CHORÃO PARK', 'O tênis CHORÃO QIX PARK possui cabedal em camurça de couro natural, solado em borracha natural vulcanizada, palmilha e espuma de alta densidade garantem o conforto e mais durabilidade, a forração interna é feita em tecido poliéster de excelente gramatura dublada em espuma, oferecendo ainda mais conforto. A soleta do tênis CHORÃO QIX PARK possui um design exclusivo e divertido fazendo uma combinação moderna e bicolor. ', 7, 'QIX ', 'QIX PARK', 'Novo', '299.90', 1, '2024-05-17 22:47:26', 1),
(2, 1, 'TÊNIS QIX CHORÃO PARK', 'O tênis CHORÃO QIX PARK possui cabedal em camurça de couro natural, solado em borracha natural vulcanizada, palmilha e espuma de alta densidade garantem o conforto e mais durabilidade, a forração interna é feita em tecido poliéster de excelente gramatura dublada em espuma, oferecendo ainda mais conforto. A soleta do tênis CHORÃO QIX PARK possui um design exclusivo e divertido fazendo uma combinação moderna e bicolor. ', 7, 'QIX ', 'QIX PARK', 'Novo', '299.90', 1, '2024-05-17 22:48:55', 1),
(3, 1, 'TÊNIS QIX CHORÃO PARK', 'O tênis CHORÃO QIX PARK possui cabedal em camurça de couro natural, solado em borracha natural vulcanizada, palmilha e espuma de alta densidade garantem o conforto e mais durabilidade, a forração interna é feita em tecido poliéster de excelente gramatura dublada em espuma, oferecendo ainda mais conforto. A soleta do tênis CHORÃO QIX PARK possui um design exclusivo e divertido fazendo uma combinação moderna e bicolor. ', 7, 'QIX ', 'QIX PARK', 'Novo', '299.90', 1, '2024-05-17 22:48:57', 1),
(4, 1, 'TÊNIS QIX CHORÃO PARK', 'O tênis CHORÃO QIX PARK possui cabedal em camurça de couro natural, solado em borracha natural vulcanizada, palmilha e espuma de alta densidade garantem o conforto e mais durabilidade, a forração interna é feita em tecido poliéster de excelente gramatura dublada em espuma, oferecendo ainda mais conforto. A soleta do tênis CHORÃO QIX PARK possui um design exclusivo e divertido fazendo uma combinação moderna e bicolor. ', 7, 'QIX ', 'QIX PARK', 'Novo', '299.90', 1, '2024-05-17 22:48:58', 1),
(5, 1, 'TÊNIS QIX CHORÃO PARK', 'O tênis CHORÃO QIX PARK possui cabedal em camurça de couro natural, solado em borracha natural vulcanizada, palmilha e espuma de alta densidade garantem o conforto e mais durabilidade, a forração interna é feita em tecido poliéster de excelente gramatura dublada em espuma, oferecendo ainda mais conforto. A soleta do tênis CHORÃO QIX PARK possui um design exclusivo e divertido fazendo uma combinação moderna e bicolor. ', 7, 'QIX ', 'QIX PARK', 'Novo', '299.90', 1, '2024-05-17 22:48:59', 1),
(6, 1, 'TÊNIS QIX CHORÃO PARK', 'O tênis CHORÃO QIX PARK possui cabedal em camurça de couro natural, solado em borracha natural vulcanizada, palmilha e espuma de alta densidade garantem o conforto e mais durabilidade, a forração interna é feita em tecido poliéster de excelente gramatura dublada em espuma, oferecendo ainda mais conforto. A soleta do tênis CHORÃO QIX PARK possui um design exclusivo e divertido fazendo uma combinação moderna e bicolor. ', 7, 'QIX ', 'QIX PARK', 'Novo', '299.90', 1, '2024-05-17 22:48:59', 1),
(7, 1, 'TÊNIS QIX CHORÃO PARK', 'O tênis CHORÃO QIX PARK possui cabedal em camurça de couro natural, solado em borracha natural vulcanizada, palmilha e espuma de alta densidade garantem o conforto e mais durabilidade, a forração interna é feita em tecido poliéster de excelente gramatura dublada em espuma, oferecendo ainda mais conforto. A soleta do tênis CHORÃO QIX PARK possui um design exclusivo e divertido fazendo uma combinação moderna e bicolor. ', 7, 'QIX ', 'QIX PARK', 'Novo', '299.90', 1, '2024-05-17 22:49:00', 1),
(8, 1, 'TÊNIS QIX CHORÃO PARK', 'O tênis CHORÃO QIX PARK possui cabedal em camurça de couro natural, solado em borracha natural vulcanizada, palmilha e espuma de alta densidade garantem o conforto e mais durabilidade, a forração interna é feita em tecido poliéster de excelente gramatura dublada em espuma, oferecendo ainda mais conforto. A soleta do tênis CHORÃO QIX PARK possui um design exclusivo e divertido fazendo uma combinação moderna e bicolor. ', 7, 'QIX ', 'QIX PARK', 'Novo', '299.90', 1, '2024-05-17 22:49:01', 1),
(9, 1, 'TÊNIS QIX CHORÃO PARK', 'O tênis CHORÃO QIX PARK possui cabedal em camurça de couro natural, solado em borracha natural vulcanizada, palmilha e espuma de alta densidade garantem o conforto e mais durabilidade, a forração interna é feita em tecido poliéster de excelente gramatura dublada em espuma, oferecendo ainda mais conforto. A soleta do tênis CHORÃO QIX PARK possui um design exclusivo e divertido fazendo uma combinação moderna e bicolor. ', 7, 'QIX ', 'QIX PARK', 'Novo', '299.90', 1, '2024-05-17 22:49:01', 1),
(10, 1, 'TÊNIS QIX CHORÃO PARK', 'O tênis CHORÃO QIX PARK possui cabedal em camurça de couro natural, solado em borracha natural vulcanizada, palmilha e espuma de alta densidade garantem o conforto e mais durabilidade, a forração interna é feita em tecido poliéster de excelente gramatura dublada em espuma, oferecendo ainda mais conforto. A soleta do tênis CHORÃO QIX PARK possui um design exclusivo e divertido fazendo uma combinação moderna e bicolor. ', 7, 'QIX ', 'QIX PARK', 'Novo', '299.90', 1, '2024-05-17 22:49:02', 1),
(11, 1, 'TÊNIS QIX CHORÃO PARK', 'O tênis CHORÃO QIX PARK possui cabedal em camurça de couro natural, solado em borracha natural vulcanizada, palmilha e espuma de alta densidade garantem o conforto e mais durabilidade, a forração interna é feita em tecido poliéster de excelente gramatura dublada em espuma, oferecendo ainda mais conforto. A soleta do tênis CHORÃO QIX PARK possui um design exclusivo e divertido fazendo uma combinação moderna e bicolor. ', 7, 'QIX ', 'QIX PARK', 'Novo', '299.90', 1, '2024-05-17 22:49:03', 1),
(12, 1, 'TÊNIS QIX CHORÃO PARK', 'O tênis CHORÃO QIX PARK possui cabedal em camurça de couro natural, solado em borracha natural vulcanizada, palmilha e espuma de alta densidade garantem o conforto e mais durabilidade, a forração interna é feita em tecido poliéster de excelente gramatura dublada em espuma, oferecendo ainda mais conforto. A soleta do tênis CHORÃO QIX PARK possui um design exclusivo e divertido fazendo uma combinação moderna e bicolor. ', 7, 'QIX ', 'QIX PARK', 'Novo', '299.90', 1, '2024-05-17 22:49:03', 1),
(13, 1, 'TÊNIS QIX CHORÃO PARK', 'O tênis CHORÃO QIX PARK possui cabedal em camurça de couro natural, solado em borracha natural vulcanizada, palmilha e espuma de alta densidade garantem o conforto e mais durabilidade, a forração interna é feita em tecido poliéster de excelente gramatura dublada em espuma, oferecendo ainda mais conforto. A soleta do tênis CHORÃO QIX PARK possui um design exclusivo e divertido fazendo uma combinação moderna e bicolor. ', 7, 'QIX ', 'QIX PARK', 'Novo', '299.90', 1, '2024-05-17 22:49:04', 1),
(14, 1, 'TÊNIS QIX CHORÃO PARK', 'O tênis CHORÃO QIX PARK possui cabedal em camurça de couro natural, solado em borracha natural vulcanizada, palmilha e espuma de alta densidade garantem o conforto e mais durabilidade, a forração interna é feita em tecido poliéster de excelente gramatura dublada em espuma, oferecendo ainda mais conforto. A soleta do tênis CHORÃO QIX PARK possui um design exclusivo e divertido fazendo uma combinação moderna e bicolor. ', 7, 'QIX ', 'QIX PARK', 'Novo', '299.90', 1, '2024-05-17 22:49:05', 1),
(15, 1, 'TÊNIS QIX CHORÃO PARK', 'O tênis CHORÃO QIX PARK possui cabedal em camurça de couro natural, solado em borracha natural vulcanizada, palmilha e espuma de alta densidade garantem o conforto e mais durabilidade, a forração interna é feita em tecido poliéster de excelente gramatura dublada em espuma, oferecendo ainda mais conforto. A soleta do tênis CHORÃO QIX PARK possui um design exclusivo e divertido fazendo uma combinação moderna e bicolor. ', 7, 'QIX ', 'QIX PARK', 'Novo', '299.90', 1, '2024-05-17 22:49:06', 1),
(16, 1, 'TÊNIS QIX CHORÃO PARK', 'O tênis CHORÃO QIX PARK possui cabedal em camurça de couro natural, solado em borracha natural vulcanizada, palmilha e espuma de alta densidade garantem o conforto e mais durabilidade, a forração interna é feita em tecido poliéster de excelente gramatura dublada em espuma, oferecendo ainda mais conforto. A soleta do tênis CHORÃO QIX PARK possui um design exclusivo e divertido fazendo uma combinação moderna e bicolor. ', 7, 'QIX ', 'QIX PARK', 'Novo', '299.90', 1, '2024-05-17 22:49:07', 1),
(17, 1, 'TÊNIS QIX CHORÃO PARK', 'O tênis CHORÃO QIX PARK possui cabedal em camurça de couro natural, solado em borracha natural vulcanizada, palmilha e espuma de alta densidade garantem o conforto e mais durabilidade, a forração interna é feita em tecido poliéster de excelente gramatura dublada em espuma, oferecendo ainda mais conforto. A soleta do tênis CHORÃO QIX PARK possui um design exclusivo e divertido fazendo uma combinação moderna e bicolor. ', 7, 'QIX ', 'QIX PARK', 'Novo', '299.90', 1, '2024-05-17 22:49:07', 1),
(18, 1, 'TÊNIS QIX CHORÃO PARK', 'O tênis CHORÃO QIX PARK possui cabedal em camurça de couro natural, solado em borracha natural vulcanizada, palmilha e espuma de alta densidade garantem o conforto e mais durabilidade, a forração interna é feita em tecido poliéster de excelente gramatura dublada em espuma, oferecendo ainda mais conforto. A soleta do tênis CHORÃO QIX PARK possui um design exclusivo e divertido fazendo uma combinação moderna e bicolor. ', 7, 'QIX ', 'QIX PARK', 'Novo', '299.90', 1, '2024-05-17 22:49:08', 1),
(19, 1, 'TÊNIS QIX CHORÃO PARK', 'O tênis CHORÃO QIX PARK possui cabedal em camurça de couro natural, solado em borracha natural vulcanizada, palmilha e espuma de alta densidade garantem o conforto e mais durabilidade, a forração interna é feita em tecido poliéster de excelente gramatura dublada em espuma, oferecendo ainda mais conforto. A soleta do tênis CHORÃO QIX PARK possui um design exclusivo e divertido fazendo uma combinação moderna e bicolor. ', 7, 'QIX ', 'QIX PARK', 'Novo', '299.90', 1, '2024-05-17 22:49:09', 1),
(20, 1, 'TÊNIS QIX CHORÃO PARK', 'O tênis CHORÃO QIX PARK possui cabedal em camurça de couro natural, solado em borracha natural vulcanizada, palmilha e espuma de alta densidade garantem o conforto e mais durabilidade, a forração interna é feita em tecido poliéster de excelente gramatura dublada em espuma, oferecendo ainda mais conforto. A soleta do tênis CHORÃO QIX PARK possui um design exclusivo e divertido fazendo uma combinação moderna e bicolor. ', 7, 'QIX ', 'QIX PARK', 'Novo', '299.90', 1, '2024-05-17 22:49:10', 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `product_images`
--

DROP TABLE IF EXISTS `product_images`;
CREATE TABLE IF NOT EXISTS `product_images` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) DEFAULT NULL,
  `image_link` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`)
) ENGINE=MyISAM AUTO_INCREMENT=121 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

--
-- Extraindo dados da tabela `product_images`
--

INSERT INTO `product_images` (`id`, `product_id`, `image_link`) VALUES
(1, 1, '394d04e2-1a31-41bf-a86a-ac68e9365f01.jpg'),
(2, 1, 'fb6bac35-5335-46d0-91e8-2d78bb762e5d.webp'),
(3, 1, '16cb98f5-c732-4556-9b88-538373669f47.webp'),
(4, 1, '5f9d2a9c-cdd2-4521-b026-32be82fe8457.jpg'),
(5, 1, '6039db91-4bd3-4601-9b7e-a740059453a0.webp'),
(6, 1, '181a5d40-7441-4a73-a0f1-2021c883a815.jpg'),
(7, 2, 'f1d35a38-4be5-45b3-83ec-5336b52ccef4.jpg'),
(8, 2, '74a7ae60-76e0-4300-b8e9-5eeb31749154.webp'),
(9, 2, 'eeea7bdf-9572-4681-b525-6cea8521300c.webp'),
(10, 2, '7c75fef9-2a69-463f-9f53-81589f309abf.jpg'),
(11, 2, '3d2789fb-9b3a-468e-a896-f8a14a25e08d.webp'),
(12, 2, '16ce8ed5-a995-4a61-8806-ef9b081eac13.jpg'),
(13, 3, '56f668fd-bbc0-4517-94c0-4bfb09df09a7.jpg'),
(14, 3, 'dff88146-bbde-4a6b-a3c5-980adc668f0e.webp'),
(15, 3, '01c9932e-370b-4e2b-b589-8d434602efd1.webp'),
(16, 3, '90e888ab-c29d-499a-931b-f58d18d682d6.jpg'),
(17, 3, 'b4199cdd-1e1a-4e56-99bf-c47915f3f1d4.webp'),
(18, 3, 'c94fa715-a343-4a81-bd65-d8c9e483c188.jpg'),
(19, 4, 'ba31652e-adba-4ff6-8399-d658dcbe8550.jpg'),
(20, 4, 'b7a59ef2-7233-48db-bb22-2676f20f3472.webp'),
(21, 4, 'a6d3c6de-3ac3-4269-aab7-73212f6e0d14.webp'),
(22, 4, '203fe67b-e3e1-43d4-9f96-a481b95c9cc7.jpg'),
(23, 4, '44ca0386-5a99-4104-86a3-390a7609762e.webp'),
(24, 4, '820be96a-437b-41c7-aba0-69db5c2e3f3d.jpg'),
(25, 5, 'b5c4211c-9796-4193-8f63-5ece4d8b9818.jpg'),
(26, 5, '961b967f-ee11-4349-b72c-18277e9e1660.webp'),
(27, 5, '5f534a9e-85fe-41fd-a2ef-e7a31c1401ab.webp'),
(28, 5, '0bbda3f8-1b17-4fde-84a5-38e205aaf06b.jpg'),
(29, 5, 'c65b3159-6bf7-471e-8cf0-2a91c991e7fe.webp'),
(30, 5, '159a1595-03d0-4604-818d-201b8e552f7c.jpg'),
(31, 6, 'b1a3bddc-b00e-4be5-b02f-b806110ad34f.jpg'),
(32, 6, '1c47e602-5412-459d-99c5-5eccc467c585.webp'),
(33, 6, '4f0688aa-b228-4106-9777-d8a8a97cd2bb.webp'),
(34, 6, 'c812de11-7c19-4e49-8f70-53569ffc571b.jpg'),
(35, 6, 'a19ee133-1de1-4568-a642-027734b202d7.webp'),
(36, 6, '1cb111af-d4de-4925-be94-4f39bc2053d4.jpg'),
(37, 7, '2fd18f17-f0ca-4c6f-b655-e85af99faec4.jpg'),
(38, 7, '46fbdc14-7592-44f0-b177-71817b330d39.webp'),
(39, 7, '9a54b197-a7eb-443a-ac7b-9fc038aca080.webp'),
(40, 7, 'e1b7d1bf-fc30-4461-80c7-b579965f4965.jpg'),
(41, 7, '72ed10fa-34d5-44ef-8235-c36ffeb0871d.webp'),
(42, 7, '2e85aa8f-e529-4a68-a62e-44b0be33cfe2.jpg'),
(43, 8, '74cdbb54-bf52-426e-b721-380c212bfa14.jpg'),
(44, 8, '865c4b29-6323-4292-a906-3fbf13d5fb8c.webp'),
(45, 8, '6b474a56-f6a5-490e-8a97-3c2f68291401.webp'),
(46, 8, '286ae5a6-2f45-4d89-a4b0-6b51d6976522.jpg'),
(47, 8, 'a086c49c-3697-4e29-91ff-9a9129cbb298.webp'),
(48, 8, 'a380b3a7-81c7-4879-b41f-d66f633b3dc9.jpg'),
(49, 9, 'c7262ae4-9e53-4bc6-b5ae-0e612db4323e.jpg'),
(50, 9, 'a587e949-4924-4d04-bd88-e34020e6f2a3.webp'),
(51, 9, 'ea73297b-d713-4e16-a6bc-71cc7dbd7272.webp'),
(52, 9, 'b6f5285c-6a94-4d0d-bdb5-e5dee963bf5a.jpg'),
(53, 9, '284d4960-862c-4ce6-8768-7ab6f8b8bbed.webp'),
(54, 9, '9b2783f2-ef8d-4260-baa7-bad14b7501cc.jpg'),
(55, 10, 'd36c7dcd-d508-498b-93ed-9ef2c4f25a67.jpg'),
(56, 10, '2be89e4c-e7c5-4658-94d2-cbf0ced2dee7.webp'),
(57, 10, 'a24f5a5b-8301-4569-8d4f-2ed70b1ec90f.webp'),
(58, 10, '68e1bf70-3978-4763-9a39-1acd635ec541.jpg'),
(59, 10, '9264834f-2ea2-4bd3-93a1-78c884dcfd0d.webp'),
(60, 10, '308354ed-949e-4bd6-a558-6073a9da9ce4.jpg'),
(61, 11, 'def16033-61d9-4e0c-9312-cb8ab8b6c8df.jpg'),
(62, 11, 'd1a6d567-a34f-4135-97d9-9e12cb42797a.webp'),
(63, 11, '0dbfb68e-58ba-48c3-949c-d6f899793eb2.webp'),
(64, 11, 'e3483f59-dc0e-4352-b469-d96d104f2de7.jpg'),
(65, 11, '904b69ad-5478-45b1-9775-63ccc0015e50.webp'),
(66, 11, 'a9e5caf2-b024-4040-8451-625b6d4ec0e8.jpg'),
(67, 12, 'bf007424-33d3-482b-bf9e-797fdbb6f16c.jpg'),
(68, 12, '47c6cf7e-4555-4993-ae39-d38e0d501820.webp'),
(69, 12, '747b1404-361f-4211-bec7-9bebd891842d.webp'),
(70, 12, 'a753e32e-6d74-44f4-8441-16a53f941b22.jpg'),
(71, 12, '85d1073a-3b92-48e3-bc6b-2ac506a2f3ad.webp'),
(72, 12, 'ecc02347-b42b-48af-b2b6-8c88f51f3caf.jpg'),
(73, 13, '14a236f2-8dd8-47e6-9db4-46c96d3eaf8a.jpg'),
(74, 13, '6052408b-8839-4de4-b7d6-d3762fd503ce.webp'),
(75, 13, '45e1c4bd-3c84-4b0f-98e5-29994278ffb8.webp'),
(76, 13, 'f06900d0-94ee-477e-855c-2c016d5a3007.jpg'),
(77, 13, 'd93a7f8f-35d2-48d4-b0c6-2e8ef2426c1c.webp'),
(78, 13, '649d7bbf-4231-4f63-afd1-07f322e2cdf9.jpg'),
(79, 14, 'e53a38b6-d11e-497c-a082-391919ec2b98.jpg'),
(80, 14, 'e9dbdc32-6a13-4bf4-b93c-d28e72ba8c49.webp'),
(81, 14, 'd1800fd9-4a67-48d2-b7dd-99ee1497afee.webp'),
(82, 14, '4b838122-5bf0-46ef-99cd-f67591b8ab5c.jpg'),
(83, 14, '842f382f-9e74-4fc6-bc77-3a9b9fcca947.webp'),
(84, 14, 'd39b476e-8694-4e0a-b307-545e85980d29.jpg'),
(85, 15, '903660cf-f512-44ee-b349-9d46ce4722b7.jpg'),
(86, 15, '241cd2dd-216d-47d4-a15a-42454bbd019c.webp'),
(87, 15, '2630c0d4-b7d7-4d4f-9158-975443bdc5df.webp'),
(88, 15, '76029cc5-b494-429b-b6ae-11e534c2a848.jpg'),
(89, 15, '6b8c48a7-6235-494a-b8ae-ae94f522ad18.webp'),
(90, 15, '0bfe2ca2-0e43-4aab-99ca-0c4a02f994d1.jpg'),
(91, 16, 'c8511292-8cf9-4b84-a64b-9512eeb53da5.jpg'),
(92, 16, 'd7f969cf-fbcf-417e-bedd-dbecb2ee64a1.webp'),
(93, 16, '235d52d9-657e-4a55-92c9-c79d06237ea1.webp'),
(94, 16, '4db70d43-21e8-4f42-a4ed-1e5d6215c2ba.jpg'),
(95, 16, '632fd6eb-3ae7-4f6c-9d8c-a9929ea35fc7.webp'),
(96, 16, 'b5fc427b-0b67-4d18-99d1-3435684a26c2.jpg'),
(97, 17, '67c5643e-7fbc-41c6-b59f-ccb531dbcba8.jpg'),
(98, 17, 'b2524100-9ec3-4702-bf07-a643d55755f6.webp'),
(99, 17, '8b701d24-ab50-43f7-af84-a1f5ce68dfef.webp'),
(100, 17, '61ced1d7-aaf7-4bff-b489-89129f4f97ae.jpg'),
(101, 17, 'd6ff8351-2765-44ba-aa6e-0bdbb4f6802c.webp'),
(102, 17, 'ce1a4dcb-fa82-4638-967c-604f803f3956.jpg'),
(103, 18, '440e11c1-4e44-4b81-b9e6-95af22e76e9a.jpg'),
(104, 18, '977fa177-c812-4d61-a089-77d14e55a039.webp'),
(105, 18, '6627059b-b6b8-4045-83eb-84084ac78012.webp'),
(106, 18, '2f700d08-335b-4c30-9e15-00fb294eccf4.jpg'),
(107, 18, '09a35688-a1c1-46d7-b70f-be2a18baaa4f.webp'),
(108, 18, '7b452970-47b3-4696-b132-121f17337844.jpg'),
(109, 19, 'b789daa9-1517-4bad-873e-c834f3e3b96a.jpg'),
(110, 19, 'b5eb11c2-036e-4945-8175-49401d8dc7dd.webp'),
(111, 19, '54ca6002-4be2-4bf9-b460-167c9d92e5fc.webp'),
(112, 19, 'c9dd8be7-61e8-452d-95e5-5ccca85fd846.jpg'),
(113, 19, 'dcf913c9-0c9d-4387-aab9-085691a4ecbb.webp'),
(114, 19, '52ed9aef-c96c-4ea2-85ec-fc69cc829456.jpg'),
(115, 20, '8bfcecc6-738e-440c-915d-0011f3d5f966.jpg'),
(116, 20, '35a0f18b-59e8-4a0e-bccb-ac13fa39b055.webp'),
(117, 20, 'e8e86e60-e83c-4356-b4e4-2e48d862ea20.webp'),
(118, 20, '4d5d2e58-041c-4b62-a395-a76e6fef1542.jpg'),
(119, 20, '694147e8-5b4c-4f97-93c5-498b451fb568.webp'),
(120, 20, '0dbfc27d-0e9d-4bd2-a2a4-0bea36a278c0.jpg');

-- --------------------------------------------------------

--
-- Estrutura da tabela `reviews`
--

DROP TABLE IF EXISTS `reviews`;
CREATE TABLE IF NOT EXISTS `reviews` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `rating` int(11) NOT NULL,
  `comment` text COLLATE utf8mb4_unicode_520_ci,
  `is_helpful` tinyint(1) DEFAULT '0',
  `is_abusive_reported` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `product_id` (`product_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `showcases`
--

DROP TABLE IF EXISTS `showcases`;
CREATE TABLE IF NOT EXISTS `showcases` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `subtitle` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `link` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

--
-- Extraindo dados da tabela `showcases`
--

INSERT INTO `showcases` (`id`, `title`, `subtitle`, `link`) VALUES
(1, 'Ofertas do dia', NULL, '/ofertas'),
(2, 'Mais Vendidos', NULL, '/mais-vendidos');

-- --------------------------------------------------------

--
-- Estrutura da tabela `showcase_products`
--

DROP TABLE IF EXISTS `showcase_products`;
CREATE TABLE IF NOT EXISTS `showcase_products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) DEFAULT NULL,
  `showcase_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`),
  KEY `showcase_id` (`showcase_id`)
) ENGINE=MyISAM AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

--
-- Extraindo dados da tabela `showcase_products`
--

INSERT INTO `showcase_products` (`id`, `product_id`, `showcase_id`) VALUES
(4, 2, 1),
(3, 1, 1),
(5, 3, 1),
(6, 4, 1),
(7, 5, 1),
(8, 6, 1),
(9, 7, 1),
(10, 8, 1),
(11, 9, 1),
(12, 10, 1),
(13, 11, 2),
(14, 10, 2),
(15, 12, 2),
(16, 13, 2),
(17, 14, 2),
(18, 15, 2),
(19, 16, 2),
(20, 17, 2),
(21, 18, 2),
(22, 19, 2),
(23, 20, 2);

-- --------------------------------------------------------

--
-- Estrutura da tabela `transactions`
--

DROP TABLE IF EXISTS `transactions`;
CREATE TABLE IF NOT EXISTS `transactions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `buyer_id` int(11) DEFAULT NULL,
  `seller_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `transaction_type` enum('Compra','Venda','Troca') COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `buyer_address_id` int(11) DEFAULT NULL,
  `seller_address_id` int(11) DEFAULT NULL,
  `payment_method` varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `shipping_method` varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `status` varchar(50) COLLATE utf8mb4_unicode_520_ci DEFAULT 'Pendente',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `buyer_id` (`buyer_id`),
  KEY `seller_id` (`seller_id`),
  KEY `product_id` (`product_id`),
  KEY `buyer_address_id` (`buyer_address_id`),
  KEY `seller_address_id` (`seller_address_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `username` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `user_image` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `phone` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `user_type` enum('Vendedor','Comprador','Ambos','Admin') COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `address_id` int(11) DEFAULT NULL,
  `verified` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

--
-- Extraindo dados da tabela `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `username`, `user_image`, `created_at`, `updated_at`, `phone`, `user_type`, `address_id`, `verified`) VALUES
(1, 'Vinícius', 'vinniebrasil@gmail.com', '$2b$10$v8c51PRHrNdQAR74ZmNGmuLjZyYXDPypMGFKsLw7KJ.mX8aBAQf6a', 'vinnifachini', NULL, '2024-03-14 00:59:41', '2024-05-17 22:36:34', '+55 (18) 99624-8348', 'Admin', NULL, 1),
(2, 'Carlos', 'carlinhos@gmail.com', '$2b$10$89wBouRNsYecQ2EaGd3neOdwalAsxhq6a0nBpxrf6SRZReCVyOmGq', 'carlinhos', NULL, '2024-03-14 01:18:42', '2024-03-14 01:18:42', '+55 (18) 99624-8348', 'Vendedor', NULL, 0);

--
-- Constraints for dumped tables
--

--
-- Limitadores para a tabela `categories`
--
ALTER TABLE `categories`
  ADD CONSTRAINT `fk_category_parent` FOREIGN KEY (`parent_category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
