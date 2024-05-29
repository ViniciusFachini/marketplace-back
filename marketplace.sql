-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 29, 2024 at 11:03 PM
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
-- Database: `marketplace`
--

-- --------------------------------------------------------

--
-- Table structure for table `addresses`
--

CREATE TABLE `addresses` (
  `id` int(11) NOT NULL,
  `street` varchar(255) DEFAULT NULL,
  `neighbourhood` varchar(255) DEFAULT NULL,
  `number` int(11) DEFAULT NULL,
  `city` varchar(100) NOT NULL,
  `state` varchar(100) NOT NULL,
  `postal_code` varchar(20) NOT NULL,
  `country` varchar(100) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

--
-- Dumping data for table `addresses`
--

INSERT INTO `addresses` (`id`, `street`, `neighbourhood`, `number`, `city`, `state`, `postal_code`, `country`, `created_at`) VALUES
(1, 'Marechal Rondon', 'Centro', 525, 'Osvaldo Cruz', 'São Paulo', '17700-000', 'Brasil', '2024-05-22 19:52:15'),
(2, 'Marechal Rondon', 'Centro', 525, 'Tupã', 'São Paulo', '17700-000', 'Brasil', '2024-05-22 20:00:08'),
(3, 'Praça Hermínio Elorza', 'Centro', 448, 'Osvaldo Cruz', 'São Paulo', '17700-000', 'Brasil', '2024-05-23 15:41:36'),
(4, 'Praça Hermínio Elorza', 'Centro', 448, 'Osvaldo Cruz', 'São Paulo', '17700-000', 'Brasil', '2024-05-25 17:34:27'),
(5, 'Praça Hermínio Elorza', 'Centro', 448, 'Osvaldo Cruz', 'São Paulo', '17700-000', 'Brasil', '2024-05-25 17:34:29'),
(6, '17700000', 'Centro', 525, 'Osvaldo Cruz', 'São Paulo', '17700000', 'Brasil', '2024-05-28 18:13:18');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `parent_category_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

--
-- Dumping data for table `categories`
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
(12, 'Children\'s Books', 'Books for children and young readers', 3, '2024-03-21 01:03:14'),
(13, 'Patrocinados', 'Produtos Patrocinados', NULL, '2024-05-19 20:41:32'),
(15, 'Melhores da Semana - Patrocinados', 'Os melhores da semana para você! Todos os produtos selecionados e aprovados pela Desa Shop!', 13, '2024-05-19 22:13:09');

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `id` int(11) NOT NULL,
  `sender_id` int(11) DEFAULT NULL,
  `receiver_id` int(11) DEFAULT NULL,
  `content` text DEFAULT NULL,
  `is_read` tinyint(1) DEFAULT 0,
  `timestamp` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `seller_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `brand` varchar(255) DEFAULT NULL,
  `model` varchar(255) DEFAULT NULL,
  `product_condition` varchar(100) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `available` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `sku` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `seller_id`, `name`, `description`, `brand`, `model`, `product_condition`, `price`, `available`, `created_at`, `sku`, `slug`) VALUES
(1, 1, 'Tênis Nike Structure 25 Masculino\n\n', 'Com estabilidade onde você precisa, amortecimento onde você quer, o Structure 25 proporciona suporte para longas quilometragens, corridas curtas e até mesmo descanso antes do final do dia. Ele tem a estabilidade que você busca, lealdade desde a primeira amarração, testada e confiável, com um sistema de mediopé que oferece suporte total e amortecimento mais confortável do que antes.', 'Nike', 'Nike Structure', 'Novo', 721.99, 0, '2024-05-18 23:11:41', 'tenis-nike-structure-25-masculino-1', 'tenis-nike-structure-25-masculino-1'),
(2, 1, 'Tênis Nike Structure 25 Masculino\n\n', 'Com estabilidade onde você precisa, amortecimento onde você quer, o Structure 25 proporciona suporte para longas quilometragens, corridas curtas e até mesmo descanso antes do final do dia. Ele tem a estabilidade que você busca, lealdade desde a primeira amarração, testada e confiável, com um sistema de mediopé que oferece suporte total e amortecimento mais confortável do que antes.', 'Nike', 'Nike Structure', 'Novo', 721.99, 0, '2024-05-18 23:13:39', 'tenis-nike-structure-25-masculino-2', 'tenis-nike-structure-25-masculino-2'),
(3, 1, 'Tênis Nike Structure 25 Masculino\n\n', 'Com estabilidade onde você precisa, amortecimento onde você quer, o Structure 25 proporciona suporte para longas quilometragens, corridas curtas e até mesmo descanso antes do final do dia. Ele tem a estabilidade que você busca, lealdade desde a primeira amarração, testada e confiável, com um sistema de mediopé que oferece suporte total e amortecimento mais confortável do que antes.', 'Nike', 'Nike Structure', 'Novo', 721.99, 0, '2024-05-18 23:13:40', 'tenis-nike-structure-25-masculino-3', 'tenis-nike-structure-25-masculino-3'),
(4, 1, 'Tênis Nike Structure 25 Masculino\n\n', 'Com estabilidade onde você precisa, amortecimento onde você quer, o Structure 25 proporciona suporte para longas quilometragens, corridas curtas e até mesmo descanso antes do final do dia. Ele tem a estabilidade que você busca, lealdade desde a primeira amarração, testada e confiável, com um sistema de mediopé que oferece suporte total e amortecimento mais confortável do que antes.', 'Nike', 'Nike Structure', 'Novo', 721.99, 0, '2024-05-18 23:13:40', 'tenis-nike-structure-25-masculino-4', 'tenis-nike-structure-25-masculino-4'),
(5, 1, 'Tênis Nike Structure 25 Masculino\n\n', 'Com estabilidade onde você precisa, amortecimento onde você quer, o Structure 25 proporciona suporte para longas quilometragens, corridas curtas e até mesmo descanso antes do final do dia. Ele tem a estabilidade que você busca, lealdade desde a primeira amarração, testada e confiável, com um sistema de mediopé que oferece suporte total e amortecimento mais confortável do que antes.', 'Nike', 'Nike Structure', 'Novo', 721.99, 0, '2024-05-18 23:13:41', 'tenis-nike-structure-25-masculino-5', 'tenis-nike-structure-25-masculino-5'),
(6, 1, 'Tênis Nike Structure 25 Masculino\n\n', 'Com estabilidade onde você precisa, amortecimento onde você quer, o Structure 25 proporciona suporte para longas quilometragens, corridas curtas e até mesmo descanso antes do final do dia. Ele tem a estabilidade que você busca, lealdade desde a primeira amarração, testada e confiável, com um sistema de mediopé que oferece suporte total e amortecimento mais confortável do que antes.', 'Nike', 'Nike Structure', 'Novo', 721.99, 1, '2024-05-18 23:13:42', 'tenis-nike-structure-25-masculino-6', 'tenis-nike-structure-25-masculino-6'),
(7, 1, 'Tênis Nike Structure 25 Masculino\n\n', 'Com estabilidade onde você precisa, amortecimento onde você quer, o Structure 25 proporciona suporte para longas quilometragens, corridas curtas e até mesmo descanso antes do final do dia. Ele tem a estabilidade que você busca, lealdade desde a primeira amarração, testada e confiável, com um sistema de mediopé que oferece suporte total e amortecimento mais confortável do que antes.', 'Nike', 'Nike Structure', 'Novo', 721.99, 1, '2024-05-18 23:13:42', 'tenis-nike-structure-25-masculino-7', 'tenis-nike-structure-25-masculino-7'),
(8, 1, 'Tênis Nike Structure 25 Masculino\n\n', 'Com estabilidade onde você precisa, amortecimento onde você quer, o Structure 25 proporciona suporte para longas quilometragens, corridas curtas e até mesmo descanso antes do final do dia. Ele tem a estabilidade que você busca, lealdade desde a primeira amarração, testada e confiável, com um sistema de mediopé que oferece suporte total e amortecimento mais confortável do que antes.', 'Nike', 'Nike Structure', 'Novo', 721.99, 1, '2024-05-18 23:13:43', 'tenis-nike-structure-25-masculino-8', 'tenis-nike-structure-25-masculino-8'),
(9, 1, 'Tênis Nike Structure 25 Masculino\n\n', 'Com estabilidade onde você precisa, amortecimento onde você quer, o Structure 25 proporciona suporte para longas quilometragens, corridas curtas e até mesmo descanso antes do final do dia. Ele tem a estabilidade que você busca, lealdade desde a primeira amarração, testada e confiável, com um sistema de mediopé que oferece suporte total e amortecimento mais confortável do que antes.', 'Nike', 'Nike Structure', 'Novo', 721.99, 1, '2024-05-18 23:13:45', 'tenis-nike-structure-25-masculino-9', 'tenis-nike-structure-25-masculino-9'),
(10, 1, 'Tênis Nike Structure 25 Masculino\n\n', 'Com estabilidade onde você precisa, amortecimento onde você quer, o Structure 25 proporciona suporte para longas quilometragens, corridas curtas e até mesmo descanso antes do final do dia. Ele tem a estabilidade que você busca, lealdade desde a primeira amarração, testada e confiável, com um sistema de mediopé que oferece suporte total e amortecimento mais confortável do que antes.', 'Nike', 'Nike Structure', 'Novo', 721.99, 1, '2024-05-18 23:13:46', 'tenis-nike-structure-25-masculino-10', 'tenis-nike-structure-25-masculino-10'),
(11, 1, 'Tênis Nike Structure 25 Masculino\n\n', 'Com estabilidade onde você precisa, amortecimento onde você quer, o Structure 25 proporciona suporte para longas quilometragens, corridas curtas e até mesmo descanso antes do final do dia. Ele tem a estabilidade que você busca, lealdade desde a primeira amarração, testada e confiável, com um sistema de mediopé que oferece suporte total e amortecimento mais confortável do que antes.', 'Nike', 'Nike Structure', 'Novo', 721.99, 1, '2024-05-18 23:13:46', 'tenis-nike-structure-25-masculino-11', 'tenis-nike-structure-25-masculino-11'),
(12, 1, 'Tênis Nike Structure 25 Masculino\n\n', 'Com estabilidade onde você precisa, amortecimento onde você quer, o Structure 25 proporciona suporte para longas quilometragens, corridas curtas e até mesmo descanso antes do final do dia. Ele tem a estabilidade que você busca, lealdade desde a primeira amarração, testada e confiável, com um sistema de mediopé que oferece suporte total e amortecimento mais confortável do que antes.', 'Nike', 'Nike Structure', 'Novo', 721.99, 1, '2024-05-18 23:13:47', 'tenis-nike-structure-25-masculino-12', 'tenis-nike-structure-25-masculino-12'),
(13, 1, 'Tênis Nike Structure 25 Masculino\n\n', 'Com estabilidade onde você precisa, amortecimento onde você quer, o Structure 25 proporciona suporte para longas quilometragens, corridas curtas e até mesmo descanso antes do final do dia. Ele tem a estabilidade que você busca, lealdade desde a primeira amarração, testada e confiável, com um sistema de mediopé que oferece suporte total e amortecimento mais confortável do que antes.', 'Nike', 'Nike Structure', 'Novo', 721.99, 1, '2024-05-18 23:13:48', 'tenis-nike-structure-25-masculino-13', 'tenis-nike-structure-25-masculino-13'),
(14, 1, 'Tênis Nike Structure 25 Masculino\n\n', 'Com estabilidade onde você precisa, amortecimento onde você quer, o Structure 25 proporciona suporte para longas quilometragens, corridas curtas e até mesmo descanso antes do final do dia. Ele tem a estabilidade que você busca, lealdade desde a primeira amarração, testada e confiável, com um sistema de mediopé que oferece suporte total e amortecimento mais confortável do que antes.', 'Nike', 'Nike Structure', 'Novo', 721.99, 1, '2024-05-18 23:13:48', 'tenis-nike-structure-25-masculino-14', 'tenis-nike-structure-25-masculino-14'),
(15, 1, 'Tênis Nike Structure 25 Masculino\n\n', 'Com estabilidade onde você precisa, amortecimento onde você quer, o Structure 25 proporciona suporte para longas quilometragens, corridas curtas e até mesmo descanso antes do final do dia. Ele tem a estabilidade que você busca, lealdade desde a primeira amarração, testada e confiável, com um sistema de mediopé que oferece suporte total e amortecimento mais confortável do que antes.', 'Nike', 'Nike Structure', 'Novo', 721.99, 1, '2024-05-18 23:13:49', 'tenis-nike-structure-25-masculino-15', 'tenis-nike-structure-25-masculino-15'),
(16, 1, 'Tênis Nike Structure 25 Masculino\n\n', 'Com estabilidade onde você precisa, amortecimento onde você quer, o Structure 25 proporciona suporte para longas quilometragens, corridas curtas e até mesmo descanso antes do final do dia. Ele tem a estabilidade que você busca, lealdade desde a primeira amarração, testada e confiável, com um sistema de mediopé que oferece suporte total e amortecimento mais confortável do que antes.', 'Nike', 'Nike Structure', 'Novo', 721.99, 1, '2024-05-18 23:13:50', 'tenis-nike-structure-25-masculino-16', 'tenis-nike-structure-25-masculino-16'),
(17, 1, 'Tênis Nike Structure 25 Masculino\n\n', 'Com estabilidade onde você precisa, amortecimento onde você quer, o Structure 25 proporciona suporte para longas quilometragens, corridas curtas e até mesmo descanso antes do final do dia. Ele tem a estabilidade que você busca, lealdade desde a primeira amarração, testada e confiável, com um sistema de mediopé que oferece suporte total e amortecimento mais confortável do que antes.', 'Nike', 'Nike Structure', 'Novo', 721.99, 1, '2024-05-18 23:40:29', 'tenis-nike-structure-25-masculino-17', 'tenis-nike-structure-25-masculino-17'),
(18, 1, 'Bota Eliane Cano Curto Salto Médio Gelo\n', 'Elegante e fashion. Com a Bota Cano Curto Eliane Salto Médio Gelo, você estará sempre pronta para qualquer ocasião, sem abrir mão do conforto. O gelo é uma tendência neutra e suave que transmite serenidade ao look. Leve e flexível, esse modelo foi pensado nas necessidades de todas as mulheres. O acabamento confortável e o forro superfofinho torna-a indispensável para quem precisa ficar horas de pé no trabalho. Ela também oferece máxima absorção controlando tanto umidade quanto temperatura. Já o superamortecimento da bota proporciona maior absorção de impactos. Para as mulheres que não dispensam o jeans, use esse modelo e dobre as barras da calça para realçar os seus pés. PICCADILLY, caminhe em direção ao novo e se surpreenda com o conforto! Você sabia que todos os produtos da PICCADILLY têm o Calce Perfeito? É um conjunto de benefícios exclusivos que respeita a anatomia do pé, diminui o cansaço e permite que você vá mais longe nas suas jornadas diárias.\n', 'Piccadilly', 'Nike Structure', 'Usado', 389.90, 1, '2024-05-19 21:17:35', 'bota-eliane-cano-curto-salto-medio-gelo-18', 'bota-eliane-cano-curto-salto-medio-gelo-18'),
(19, 1, 'Bota Eliane Cano Curto Salto Médio Gelo\n', 'Elegante e fashion. Com a Bota Cano Curto Eliane Salto Médio Gelo, você estará sempre pronta para qualquer ocasião, sem abrir mão do conforto. O gelo é uma tendência neutra e suave que transmite serenidade ao look. Leve e flexível, esse modelo foi pensado nas necessidades de todas as mulheres. O acabamento confortável e o forro superfofinho torna-a indispensável para quem precisa ficar horas de pé no trabalho. Ela também oferece máxima absorção controlando tanto umidade quanto temperatura. Já o superamortecimento da bota proporciona maior absorção de impactos. Para as mulheres que não dispensam o jeans, use esse modelo e dobre as barras da calça para realçar os seus pés. PICCADILLY, caminhe em direção ao novo e se surpreenda com o conforto! Você sabia que todos os produtos da PICCADILLY têm o Calce Perfeito? É um conjunto de benefícios exclusivos que respeita a anatomia do pé, diminui o cansaço e permite que você vá mais longe nas suas jornadas diárias.\n', 'Piccadilly', 'Nike Structure', 'Usado', 389.90, 1, '2024-05-19 21:18:25', 'bota-eliane-cano-curto-salto-medio-gelo-19', 'bota-eliane-cano-curto-salto-medio-gelo-19'),
(20, 1, 'Bota Eliane Cano Curto Salto Médio Gelo\n', 'Elegante e fashion. Com a Bota Cano Curto Eliane Salto Médio Gelo, você estará sempre pronta para qualquer ocasião, sem abrir mão do conforto. O gelo é uma tendência neutra e suave que transmite serenidade ao look. Leve e flexível, esse modelo foi pensado nas necessidades de todas as mulheres. O acabamento confortável e o forro superfofinho torna-a indispensável para quem precisa ficar horas de pé no trabalho. Ela também oferece máxima absorção controlando tanto umidade quanto temperatura. Já o superamortecimento da bota proporciona maior absorção de impactos. Para as mulheres que não dispensam o jeans, use esse modelo e dobre as barras da calça para realçar os seus pés. PICCADILLY, caminhe em direção ao novo e se surpreenda com o conforto! Você sabia que todos os produtos da PICCADILLY têm o Calce Perfeito? É um conjunto de benefícios exclusivos que respeita a anatomia do pé, diminui o cansaço e permite que você vá mais longe nas suas jornadas diárias.\n', 'Piccadilly', 'Nike Structure', 'Usado', 389.90, 1, '2024-05-19 21:21:02', 'bota-eliane-cano-curto-salto-medio-gelo-20', 'bota-eliane-cano-curto-salto-medio-gelo-20'),
(21, 1, 'Bota Eliane Cano Curto Salto Médio Gelo\n', 'Elegante e fashion. Com a Bota Cano Curto Eliane Salto Médio Gelo, você estará sempre pronta para qualquer ocasião, sem abrir mão do conforto. O gelo é uma tendência neutra e suave que transmite serenidade ao look. Leve e flexível, esse modelo foi pensado nas necessidades de todas as mulheres. O acabamento confortável e o forro superfofinho torna-a indispensável para quem precisa ficar horas de pé no trabalho. Ela também oferece máxima absorção controlando tanto umidade quanto temperatura. Já o superamortecimento da bota proporciona maior absorção de impactos. Para as mulheres que não dispensam o jeans, use esse modelo e dobre as barras da calça para realçar os seus pés. PICCADILLY, caminhe em direção ao novo e se surpreenda com o conforto! Você sabia que todos os produtos da PICCADILLY têm o Calce Perfeito? É um conjunto de benefícios exclusivos que respeita a anatomia do pé, diminui o cansaço e permite que você vá mais longe nas suas jornadas diárias.\n', 'Piccadilly', 'Nike Structure', 'Usado', 389.90, 1, '2024-05-19 21:21:42', 'bota-eliane-cano-curto-salto-medio-gelo-21', 'bota-eliane-cano-curto-salto-medio-gelo-21'),
(22, 1, 'Bota Eliane Cano Curto Salto Médio Gelo\n', 'Elegante e fashion. Com a Bota Cano Curto Eliane Salto Médio Gelo, você estará sempre pronta para qualquer ocasião, sem abrir mão do conforto. O gelo é uma tendência neutra e suave que transmite serenidade ao look. Leve e flexível, esse modelo foi pensado nas necessidades de todas as mulheres. O acabamento confortável e o forro superfofinho torna-a indispensável para quem precisa ficar horas de pé no trabalho. Ela também oferece máxima absorção controlando tanto umidade quanto temperatura. Já o superamortecimento da bota proporciona maior absorção de impactos. Para as mulheres que não dispensam o jeans, use esse modelo e dobre as barras da calça para realçar os seus pés. PICCADILLY, caminhe em direção ao novo e se surpreenda com o conforto! Você sabia que todos os produtos da PICCADILLY têm o Calce Perfeito? É um conjunto de benefícios exclusivos que respeita a anatomia do pé, diminui o cansaço e permite que você vá mais longe nas suas jornadas diárias.\n', 'Piccadilly', 'Nike Structure', 'Usado', 389.90, 1, '2024-05-19 21:22:42', 'bota-eliane-cano-curto-salto-medio-gelo-22', 'bota-eliane-cano-curto-salto-medio-gelo-22'),
(23, 1, 'Bota Eliane Cano Curto Salto Médio Gelo\n', 'Elegante e fashion. Com a Bota Cano Curto Eliane Salto Médio Gelo, você estará sempre pronta para qualquer ocasião, sem abrir mão do conforto. O gelo é uma tendência neutra e suave que transmite serenidade ao look. Leve e flexível, esse modelo foi pensado nas necessidades de todas as mulheres. O acabamento confortável e o forro superfofinho torna-a indispensável para quem precisa ficar horas de pé no trabalho. Ela também oferece máxima absorção controlando tanto umidade quanto temperatura. Já o superamortecimento da bota proporciona maior absorção de impactos. Para as mulheres que não dispensam o jeans, use esse modelo e dobre as barras da calça para realçar os seus pés. PICCADILLY, caminhe em direção ao novo e se surpreenda com o conforto! Você sabia que todos os produtos da PICCADILLY têm o Calce Perfeito? É um conjunto de benefícios exclusivos que respeita a anatomia do pé, diminui o cansaço e permite que você vá mais longe nas suas jornadas diárias.\n', 'Piccadilly', 'Nike Structure', 'Usado', 389.90, 1, '2024-05-19 21:22:44', 'bota-eliane-cano-curto-salto-medio-gelo-23', 'bota-eliane-cano-curto-salto-medio-gelo-23'),
(24, 1, 'Bota Eliane Cano Curto Salto Médio Gelo\n', 'Elegante e fashion. Com a Bota Cano Curto Eliane Salto Médio Gelo, você estará sempre pronta para qualquer ocasião, sem abrir mão do conforto. O gelo é uma tendência neutra e suave que transmite serenidade ao look. Leve e flexível, esse modelo foi pensado nas necessidades de todas as mulheres. O acabamento confortável e o forro superfofinho torna-a indispensável para quem precisa ficar horas de pé no trabalho. Ela também oferece máxima absorção controlando tanto umidade quanto temperatura. Já o superamortecimento da bota proporciona maior absorção de impactos. Para as mulheres que não dispensam o jeans, use esse modelo e dobre as barras da calça para realçar os seus pés. PICCADILLY, caminhe em direção ao novo e se surpreenda com o conforto! Você sabia que todos os produtos da PICCADILLY têm o Calce Perfeito? É um conjunto de benefícios exclusivos que respeita a anatomia do pé, diminui o cansaço e permite que você vá mais longe nas suas jornadas diárias.\n', 'Piccadilly', 'Nike Structure', 'Usado', 389.90, 1, '2024-05-19 21:25:20', 'bota-eliane-cano-curto-salto-medio-gelo-24', 'bota-eliane-cano-curto-salto-medio-gelo-24'),
(25, 1, 'Bota Eliane Cano Curto Salto Médio Gelo\n', 'Elegante e fashion. Com a Bota Cano Curto Eliane Salto Médio Gelo, você estará sempre pronta para qualquer ocasião, sem abrir mão do conforto. O gelo é uma tendência neutra e suave que transmite serenidade ao look. Leve e flexível, esse modelo foi pensado nas necessidades de todas as mulheres. O acabamento confortável e o forro superfofinho torna-a indispensável para quem precisa ficar horas de pé no trabalho. Ela também oferece máxima absorção controlando tanto umidade quanto temperatura. Já o superamortecimento da bota proporciona maior absorção de impactos. Para as mulheres que não dispensam o jeans, use esse modelo e dobre as barras da calça para realçar os seus pés. PICCADILLY, caminhe em direção ao novo e se surpreenda com o conforto! Você sabia que todos os produtos da PICCADILLY têm o Calce Perfeito? É um conjunto de benefícios exclusivos que respeita a anatomia do pé, diminui o cansaço e permite que você vá mais longe nas suas jornadas diárias.\n', 'Piccadilly', 'Nike Structure', 'Usado', 389.90, 1, '2024-05-19 21:28:10', 'bota-eliane-cano-curto-salto-medio-gelo-25', 'bota-eliane-cano-curto-salto-medio-gelo-25'),
(32, 2, 'Bóta de Segürança Elegância à Adventure em Couro', 'Cabedal confeccionado em couro Premium com padrão internacional de qualidade, cor dark brown, tecido e sintético de alta resistência, taloneira em TPU, costuras reforçadas, forração interna e colarinho acolchoado para maior conforto.', 'Estival', 'Coturno', 'Novo', 320.50, 1, '2024-05-22 17:37:55', '2-bota-de-seguranca-elegancia-a-adventure-em-couro-estival-coturno-8758-32', 'bota-de-seguranca-elegancia-a-adventure-em-couro-32'),
(33, 2, 'Bóta de Segürança Elegância à Adventure em Couro', 'Cabedal confeccionado em couro Premium com padrão internacional de qualidade, cor dark brown, tecido e sintético de alta resistência, taloneira em TPU, costuras reforçadas, forração interna e colarinho acolchoado para maior conforto.', 'Estival', 'Coturno', 'Novo', 320.50, 1, '2024-05-22 18:28:05', '2-bota-de-seguranca-elegancia-a-adventure-em-couro-estival-coturno-2674', 'bota-de-seguranca-elegancia-a-adventure-em-couro-33'),
(34, 2, 'Bóta de Segürança Elegância à Adventure em Couro', 'Cabedal confeccionado em couro Premium com padrão internacional de qualidade, cor dark brown, tecido e sintético de alta resistência, taloneira em TPU, costuras reforçadas, forração interna e colarinho acolchoado para maior conforto.', 'Estival', 'Coturno', 'Novo', 320.50, 1, '2024-05-22 18:57:04', '[object Promise]', 'bota-de-seguranca-elegancia-a-adventure-em-couro-34'),
(35, 2, 'Bóta de Segürança Elegância à Adventure em Couro', 'Cabedal confeccionado em couro Premium com padrão internacional de qualidade, cor dark brown, tecido e sintético de alta resistência, taloneira em TPU, costuras reforçadas, forração interna e colarinho acolchoado para maior conforto.', 'Estival', 'Coturno', 'Novo', 320.50, 1, '2024-05-22 18:57:23', '0000002351743734', 'bota-de-seguranca-elegancia-a-adventure-em-couro-35'),
(36, 1, 'Bóta de Segürança Elegância à Adventure em Couro', 'Cabedal confeccionado em couro Premium com padrão internacional de qualidade, cor dark brown, tecido e sintético de alta resistência, taloneira em TPU, costuras reforçadas, forração interna e colarinho acolchoado para maior conforto.', 'Estival', 'Coturno', 'Novo', 320.50, 1, '2024-05-22 19:59:03', '0000001361547521', 'bota-de-seguranca-elegancia-a-adventure-em-couro-36'),
(37, 7, 'Roupão Gg Microfibra Masculino Marc Alain - Azul Profundo', 'Aliados do conforto, os roupões são peças versáteis, que podem ser utilizadas em diversas ocasiões. Desde o pós-banho até para relaxar o dia inteiro em um domingo chuvoso, o produto acompanha o dono por todos os cantos da casa. E os roupões da Marc Alain são perfeitos para isso!\n\nCaracterísticas\nConteúdo: Roupão Adulto \nMaterial: Microfibra \nComposição: 100% Poliéster \nAntialérgico: Sim \nQuantidade de Peças: 1 peça \nTamanho: GG\n', 'Marc Alain', 'Adulto', 'Novo', 400.00, 1, '2024-05-23 15:58:42', '0000007370365171', 'roupao-gg-microfibra-masculino-marc-alain---azul-profundo-37'),
(38, 7, 'Roupão Gg Microfibra Masculino Marc Alain - Azul Profundo', 'Aliados do conforto, os roupões são peças versáteis, que podem ser utilizadas em diversas ocasiões. Desde o pós-banho até para relaxar o dia inteiro em um domingo chuvoso, o produto acompanha o dono por todos os cantos da casa. E os roupões da Marc Alain são perfeitos para isso!\n\nCaracterísticas\nConteúdo: Roupão Adulto \nMaterial: Microfibra \nComposição: 100% Poliéster \nAntialérgico: Sim \nQuantidade de Peças: 1 peça \nTamanho: GG\n', 'Marc Alain', 'Adulto', 'Novo', 400.00, 1, '2024-05-24 18:57:05', '0000007381981542', 'roupao-gg-microfibra-masculino-marc-alain---azul-profundo-38'),
(39, 1, '1', '2', '4', '5', 'novo', 6.00, 1, '2024-05-24 20:23:02', '0000001391359098', '1-39'),
(40, 1, '1', '2', '4', '5', 'usado', 6.00, 1, '2024-05-24 20:28:08', '0000001401768586', '1-40'),
(41, 1, '1', '2', '4', '5', 'usado', 6.00, 1, '2024-05-24 20:29:25', '0000001411300286', '1-41'),
(42, 1, '1', '2', '4', '5', 'usado', 61.00, 1, '2024-05-24 20:35:02', '0000001421250330', '1-42'),
(43, 1, '1', '2', '4', '5', 'usado', 5.00, 1, '2024-05-24 20:36:11', '0000001431741113', '1-43'),
(44, 1, '1', '2', '4', '5', 'usado', 612.00, 1, '2024-05-25 21:24:26', '0000001441749161', '1-44'),
(45, 1, 'Vibrador Dildo Prótese 20,3cm x 4,1cm Ponto G Texturizado 10 Modos de Vibração com Controle Remoto - LILO', 'Vibrador Dildo Prótese 20,3cm x 4,1cm Ponto G Texturizado 10 Modos de Vibração com Controle Remoto Alta flexibilidade permitindo criar diversos movimentos. Surpreende pelo seu realismo e incrível semelhança com um pênis real. Produto com altíssima qualidade levando em consideração prazer e segurança. Sua maciez é incontestável com toque agradável e suave. Possui escroto e ventosa que permite fixação em superfícies lisas. A ventosa permite mãos livres para maior liberdade e usabilidade do produto. Pode-se fixá-lo no box do banheiro por exemplo ou mesmo no revestimento da parede desde que seja liso, resistente à água, o controle remoto não, então quando for usá-lo no banheiro por exemplo, tome cuidado. Composto por vibrador multivelocidade com 10 intensidades de vibração. Confeccionado em TPE 100% atóxico. Formato levando em consideração a riqueza de detalhes como glande, saliências e veias. A vibração fica por conta de um motor potente e silencioso que emite ondas vibrantes e altamente excitantes que proporcionam um prazer inigualável. O manuseio do vibrador é simples e descomplicado, com simples toques é possível acionar o vibrador e alternar os estágios de estimulação. O controle remoto com fio permite seu parceiro ou parceira intensificar e diversificar a brincadeira a dois.  Pênis com glande saltada, escroto e ventosa resistente.Possui 10 níveis de vibração que podem ser controlados através do controle remoto que acompanha o produto.Confeccionado em material macio, possui veias e texturas no corpo da protese, trazendo naturalidade e realismo. Medidas 20,3 cm de comprimento, 4,1cm de largura (medidas aproximadas) Peso: 299g Material: TPE Utiliza:Cabo USB incluso,2 pilhas AAA para controle não inclusas Higienização: Lavar com água e sabão neutro antes e após o uso, evite molhar o compartimento de recarga Seque com papel toalha ou deixe secar naturalmente.', 'Lilo', 'Lilo', 'novo', 99999999.99, 1, '2024-05-26 19:11:35', '0000001451987515', 'vibrador-dildo-protese-203cm-x-41cm-ponto-g-texturizado-10-modos-de-vibracao-com-controle-remoto---lilo-45'),
(46, 15, 'Vagner Com V', 'Boneco de manequim', 'Vagner', 'Vagner Com V', 'semi_novo', 3400.00, 1, '2024-05-28 20:31:28', '0000015460366646', 'vagner-com-v-46');

-- --------------------------------------------------------

--
-- Table structure for table `product_categories`
--

CREATE TABLE `product_categories` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

--
-- Dumping data for table `product_categories`
--

INSERT INTO `product_categories` (`id`, `product_id`, `category_id`) VALUES
(2, 1, 7),
(3, 1, 13),
(4, 2, 7),
(5, 2, 13),
(6, 3, 7),
(7, 3, 13),
(8, 4, 7),
(9, 4, 13),
(10, 5, 7),
(11, 5, 13),
(12, 6, 7),
(13, 6, 13),
(14, 7, 7),
(15, 7, 13),
(16, 8, 7),
(18, 9, 7),
(19, 9, 13),
(20, 10, 7),
(21, 10, 13),
(22, 11, 7),
(23, 11, 13),
(24, 12, 7),
(25, 12, 13),
(27, 13, 13),
(28, 14, 7),
(29, 14, 13),
(30, 15, 7),
(31, 15, 13),
(32, 16, 7),
(33, 16, 13),
(34, 17, 7),
(35, 17, 13),
(77, 25, 7),
(78, 25, 13),
(79, 25, 6),
(80, 25, 4),
(81, 26, 7),
(82, 26, 13),
(83, 27, 7),
(84, 27, 13),
(85, 28, 7),
(86, 28, 13),
(87, 29, 7),
(88, 29, 13),
(89, 30, 7),
(90, 30, 13),
(91, 31, 7),
(92, 31, 13),
(93, 32, 7),
(94, 32, 13),
(95, 33, 7),
(96, 33, 13),
(97, 34, 7),
(98, 34, 13),
(99, 35, 7),
(100, 35, 13),
(101, 36, 7),
(102, 36, 13),
(103, 37, 7),
(104, 38, 7),
(105, 43, 3),
(106, 44, 4),
(107, 45, 3),
(108, 46, 11);

-- --------------------------------------------------------

--
-- Table structure for table `product_images`
--

CREATE TABLE `product_images` (
  `id` int(11) NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `image_link` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

--
-- Dumping data for table `product_images`
--

INSERT INTO `product_images` (`id`, `product_id`, `image_link`) VALUES
(1, 1, '0b84cf21-4f8f-479a-9bbd-dbc150e67296.avif'),
(2, 1, 'e2e7aca6-bec4-4c90-a926-1bd22d958454.avif'),
(3, 1, 'ee3785ff-824c-49c2-9997-edb54fd92443.avif'),
(4, 1, '198dd494-42dc-4f1b-b632-d28ff60ab87c.avif'),
(5, 2, 'ef007d6d-a9fb-4b72-82ff-7eff513fd926.avif'),
(6, 2, '1f6295e3-0922-4815-9987-11d038b14686.avif'),
(7, 2, 'b7a2bdf7-757c-4498-b198-d8dd96b9cb2a.avif'),
(8, 2, 'e12c8462-458b-46b5-9fd6-7c809536e41a.avif'),
(9, 3, 'e88762fc-35f1-4783-a323-55f400ec2d42.avif'),
(10, 3, 'fc9cdd50-0b35-469c-bdcd-abe0f987210f.avif'),
(11, 3, '207cfdd8-cad4-4f10-9a7c-0abee523b441.avif'),
(12, 3, 'eba80725-bdce-4854-ba01-d6c839935773.avif'),
(13, 4, '07fa22aa-0104-4309-a84b-1dc6824f76cc.avif'),
(14, 4, '608155b2-5eba-49be-ab1d-9a9fc6a8b44f.avif'),
(15, 4, '9de619e3-ddd1-4e18-9dbe-186bd975bb22.avif'),
(16, 4, 'fc341144-ce58-4c4b-a23b-4eb752f38b41.avif'),
(17, 5, 'ca8ab297-0740-422f-8d8b-66df0a541768.avif'),
(18, 5, '726e4dda-9176-49b8-b6e4-77dfa18ae61b.avif'),
(19, 5, '547ed818-3f06-43a1-8225-4d6371d30a6b.avif'),
(20, 5, '4eddd9d3-3b58-42a5-967d-704683115c78.avif'),
(21, 6, '250dbcd8-99f3-4b70-90c3-81f9264e23cf.avif'),
(22, 6, '606dd1f6-990d-47a0-9207-3b4f61975938.avif'),
(23, 6, '23706fa7-2ccf-4a2f-a06e-4d4f75b7df1a.avif'),
(24, 6, 'ba8b1cfb-4882-44b7-87dc-f0da6c90b247.avif'),
(25, 7, '304939d4-2e0d-4376-a3b8-bbccffd3d8a8.avif'),
(26, 7, '910d1377-5d9d-40dc-9a74-15d0cce9aabd.avif'),
(27, 7, 'e642538c-608b-4b6a-b6fa-09dae2a9e8ab.avif'),
(28, 7, '1b1d419f-7aca-41f3-8347-007b8de7d763.avif'),
(29, 8, 'f60e6c2d-720d-4ac9-b3b4-4911e07164fa.avif'),
(30, 8, 'a6acdb31-9398-4320-9b49-3433ef17f3d7.avif'),
(31, 8, 'ccce109a-8929-4837-b7e1-37eaaa7fb169.avif'),
(32, 8, '7f79a39d-b3a4-4bb0-90af-ce3d5208a064.avif'),
(33, 9, '309ec943-fab3-4280-b278-10de529e7235.avif'),
(34, 9, '82246e37-dcb9-4769-8438-2b7e8c091b1f.avif'),
(35, 9, '51d95be1-7cf8-4960-a25c-49638a36bed9.avif'),
(36, 9, 'fbae2070-360f-4a54-b62f-b66a8e8191e1.avif'),
(37, 10, 'cf594a3a-a702-47eb-a267-9ae2372334b3.avif'),
(38, 10, 'b7238f9c-375f-4217-9aa8-42983bed0e06.avif'),
(39, 10, '7661b4ac-2b29-4c2e-8c85-22a65bf422aa.avif'),
(40, 10, '478a8910-ee91-422e-9706-55e8d2497305.avif'),
(41, 11, 'be470e8d-259e-402c-847e-84666d047aad.avif'),
(42, 11, '95209911-fd8b-40f6-87ec-135cbc752895.avif'),
(43, 11, '6fd3424f-4d97-4085-9c09-bd47548474c5.avif'),
(44, 11, '6e4c974a-2025-4ef7-bc39-d3d4fbeb4aa9.avif'),
(45, 12, '88f3213e-f5cc-4452-9c88-980a04a1e20c.avif'),
(46, 12, '7b1af261-34df-4388-bc48-ad332cad5544.avif'),
(47, 12, '7335bad9-2a2e-4453-af77-f8f7d374464d.avif'),
(48, 12, 'd3839084-bb17-401a-9c0f-f42d32ab505a.avif'),
(49, 13, 'a3e9f9cf-a965-433d-a3b3-c155d9c90f2f.avif'),
(50, 13, 'dd17ff1d-a1c9-40ec-ba93-226a3beaa7d0.avif'),
(51, 13, '6aca82a7-4575-4242-aef5-f656d62fb10c.avif'),
(52, 13, '5224b5c9-e410-4450-bf50-f138b11c7e31.avif'),
(53, 14, 'c6707c24-ccd1-419b-8ad3-febe20584f18.avif'),
(54, 14, 'b4537069-ca44-4e36-bf57-3d58957cec68.avif'),
(55, 14, '3e17bd22-9cf9-48c9-9711-113c0eee04cc.avif'),
(56, 14, '1081428d-17be-4e03-9bde-5d200d1cdd6f.avif'),
(57, 15, '7924b230-0dca-404a-97e6-1b2a841005e2.avif'),
(58, 15, 'fd5e5eee-3f0c-4576-a0a7-1dd58938ae6a.avif'),
(59, 15, '9d3f0bcb-e2d1-4a72-9dbe-0dabca89cc92.avif'),
(60, 15, 'a59679e5-9966-4ad4-ad09-b5840405c2af.avif'),
(61, 16, 'f7d1112a-2a15-4ecd-815c-24b4ab32ea06.avif'),
(62, 16, 'b28a66bd-c5fc-4bb2-8421-1e474ecd1193.avif'),
(63, 16, '1541f794-c105-48ce-9086-f2bcfd93c9b4.avif'),
(64, 16, 'cf695148-e960-4566-9e3a-de8f36bc39bb.avif'),
(65, 17, 'af96fcd0-1b28-4d31-a1ed-2671ef1b3bbb.jpeg'),
(66, 17, 'aa30a106-f6f1-430b-86f0-b653c8860955.avif'),
(67, 19, '88de4aea-6296-48c2-8b85-9ae177571e6e.webp'),
(68, 19, '1d2fcb6f-f9e6-40ee-936f-028fbca5ef9e.webp'),
(69, 19, 'd3a11405-9c6c-42d5-bfbb-632585ee1e4e.webp'),
(70, 19, 'e1ea1d53-d57f-4cae-9f58-de5e13138c5b.webp'),
(71, 20, '128c53b9-d9b5-4a4b-9aab-0339797b0471.webp'),
(72, 20, '4a33ce66-3479-4f3f-bcde-4483894d88cd.webp'),
(73, 20, 'f8a97f5d-9fb5-4169-a511-7b41069e2c70.webp'),
(74, 20, '059e108d-7bc9-430d-8198-09888cfd4d78.webp'),
(75, 25, 'f1344295-90d4-44c4-a0c8-bfb3551cbf0b.webp'),
(76, 25, '950e6450-a89e-4da2-b975-a9b41bf06107.webp'),
(77, 25, '4709c1e0-a8b9-4be7-818f-2fd2d2c0850a.webp'),
(78, 25, 'eb3b888d-e096-4048-9699-dd4e09b4040e.webp'),
(79, 26, '36b23e22-f76b-4e5a-a555-d7d07e965988.jpg'),
(80, 26, '8a57fd01-b6bf-4104-b19e-6cdc9eeabba3.jpg'),
(81, 26, 'efa795af-d634-4e3c-95ae-ae197551457a.jpg'),
(82, 26, '7c84cc35-6c91-46d5-b7a0-c4d6745a137f.avif'),
(83, 27, 'd3dbdf79-45a4-4db2-aa9e-8e9d1af4300e.jpg'),
(84, 27, '8022f7fa-d879-47c4-99db-3f668fa402f6.jpg'),
(85, 27, 'e1d5b3f1-8ad2-4ed4-9fba-5d469fbe2a39.jpg'),
(86, 27, '2982576b-8dde-47ad-a058-25dda6cdd2b2.avif'),
(87, 28, '1a04e26d-8b62-4ba5-8703-076e5ec1fa79.jpg'),
(88, 28, '2dd6d244-75da-47cf-9a43-3dd4a11892dd.jpg'),
(89, 28, 'db51699e-de56-4d9a-bf8a-2815470c522a.jpg'),
(90, 28, '81edfcc0-eecc-4e04-956f-9b5355554eb0.avif'),
(91, 29, '717b35b1-1a6c-4c18-991c-4dd3f8e6677d.jpg'),
(92, 29, 'a4f98f92-7de0-474b-b99c-3c7de8a08e00.jpg'),
(93, 29, 'c833d724-51f3-44ae-826c-76bf3160df2c.jpg'),
(94, 29, 'a2467861-c078-4fef-afa5-b1ab586a1a14.avif'),
(95, 30, 'd58ad2d6-47d0-4b06-8eaf-73ea1440560b.jpg'),
(96, 30, 'ff9db83c-212f-4702-9027-6b39434f24de.jpg'),
(97, 30, '2eb4e589-5009-438b-94e0-563a68e5a072.jpg'),
(98, 30, 'ce23faf4-76b2-46d0-957a-59b45c8626e4.avif'),
(99, 31, 'e7509b2e-7457-4d78-a305-53a431af5831.jpg'),
(100, 31, '5392f48c-9632-42b6-bb15-50bd83058582.jpg'),
(101, 31, '3464c71b-4b49-46cd-9440-939b1298a20a.jpg'),
(102, 31, 'de8d3f59-1a33-40d4-b6ce-c1587d14b2f5.avif'),
(103, 32, '05817582-7953-4af9-8284-52b54c5e672b.jpg'),
(104, 32, '6d1519a4-b002-4706-bc37-0b2a43004257.jpg'),
(105, 32, '91ee2e84-2820-47b0-844e-8e8d3e155d71.jpg'),
(106, 32, '068d195f-e74a-4029-b70a-046d5abfa023.avif'),
(107, 33, 'f92b1a6d-b72c-4e0c-a0dc-14879858f9ba.jpg'),
(108, 33, '459deb24-a169-48e3-aab3-1806db0ff9e3.jpg'),
(109, 33, '67af8c26-9adb-46d6-9c57-79c66ae7e5ca.jpg'),
(110, 33, '69e60dea-056f-4535-bf31-551c55d043af.avif'),
(111, 34, '852e349c-8722-4cf1-9e62-99d95696091f.jpg'),
(112, 34, 'a95b3a88-ef02-47df-8bdc-643c2a4054e1.jpg'),
(113, 34, '4ef05ae6-d3d3-4f97-9a87-69a498430f32.jpg'),
(114, 34, '25a486d1-7411-4042-b3d8-15353f5b5a9d.avif'),
(115, 35, '6652a7c1-387a-429a-8be1-31c33870780b.jpg'),
(116, 35, 'b8929bf4-e8d1-4301-a00b-860c7ba42a77.jpg'),
(117, 35, '1ab8ca5f-5e14-4409-bf95-6c2bf1eba341.jpg'),
(118, 35, 'be57eb08-7e99-4823-9049-e21018ceddf3.avif'),
(119, 36, 'e1cda15a-950a-4c56-b072-c13dff843e52.jpg'),
(120, 36, 'f66d7d63-b279-433a-bae9-9d36e39fd75c.jpg'),
(121, 36, '21653c0d-35f1-47aa-b2d6-5602ffe65543.jpg'),
(122, 36, 'ccc03156-7ff2-4773-9abd-3766bc7f5c79.avif'),
(123, 37, 'd3a8626d-f15b-46ca-852e-91dbc37fe26c.jpg'),
(124, 37, '82ac8c6c-ae1e-4386-98d2-9d8d3f693686.webp'),
(125, 37, '922dc6b6-4041-476b-ab8b-4539160d8060.webp'),
(126, 37, 'bc710432-f234-4adb-b5b6-5b3703f5f918.webp'),
(127, 38, 'b4e70ba1-bd62-4fba-b396-9186d7e9eff0.jpg'),
(128, 38, '3b7cc830-e7f3-42d0-8f9a-f1b74b9ad07f.webp'),
(129, 38, '663570ca-f7c3-4157-85a4-4b47ad313f2b.webp'),
(130, 38, '2121df7d-5fc8-47eb-99e5-3a25e2ca3adb.webp'),
(131, 39, 'e9f6e8aa-c92e-4dc2-a7c2-c8f1b8664af8.jpeg'),
(132, 39, '07025a55-2ff7-437f-b021-08cb5687df60.jpeg'),
(133, 39, '67d5c20b-8db7-42d3-ba8d-239de5b57216.jpeg'),
(134, 39, '1509f901-224b-4fa6-abb6-b435436b1ea5.avif'),
(135, 40, '80794539-5fbb-47cb-8899-f542e8eae633.webp'),
(136, 40, '79958dfe-9d08-41e2-bc98-b2d5eaadd26f.webp'),
(137, 40, '60d4d50c-5f67-4862-ba71-880f390b6aaf.webp'),
(138, 40, '5e2a7775-13c9-4688-9062-8d65f55ac3ed.webp'),
(139, 41, 'fb76b0b1-b056-4303-ba31-d92e58e05736.webp'),
(140, 41, 'a8a898d6-25d7-451f-bb56-b2c9ce5a3b3d.webp'),
(141, 41, '1c9e5046-35dc-44cc-8af3-26946965253b.webp'),
(142, 41, '986c1f17-d740-4299-b5fa-126237a9b389.webp'),
(143, 42, '67d576c3-32f8-468c-bac5-8e986d976443.jpeg'),
(144, 42, '4339aed2-dfc8-43d4-ad26-084a23e8e32a.webp'),
(145, 42, '7784bd38-4066-4984-801f-7ea58cc616e8.webp'),
(146, 42, '7c488446-7ce0-4e18-ae56-4c13f0abc2af.webp'),
(147, 43, '450a5b42-9845-4027-855f-8905820222a1.jpeg'),
(148, 43, '76829251-5e39-4d87-9923-1a24626c7d5d.webp'),
(149, 43, 'b62af458-37fc-4d30-bf92-02a2bb0a1944.webp'),
(150, 43, '6226fee3-b4af-405b-9f1f-22a15d9fc3f6.webp'),
(151, 44, '3f0d6ca6-17f4-42f3-b198-e8e1c6fc40a2.webp'),
(152, 44, '21382a47-6a5b-46d5-9309-2cd9e9cb2c20.webp'),
(153, 44, '3f166190-1f1e-4235-bfd5-9a349ebe1026.webp'),
(154, 44, '9eea4441-e11c-4803-a8c6-38719baf8ec8.jpeg'),
(155, 45, '456e2194-5b6e-48de-bba3-d4c36b92c9f1.webp'),
(156, 45, 'cec3fb30-4695-47df-a373-45b677c5cbb3.webp'),
(157, 45, '8b267698-5519-40ec-8f89-c048484e6114.webp'),
(158, 45, '790adba4-73d1-4667-8a11-24c5a1606eb0.webp'),
(159, 46, '4fc6eed2-7d30-4535-af78-b4dce919cf71.jpeg'),
(160, 46, 'd0e64dc8-f6cc-481a-a837-d9f8e2f2b549.jpeg');

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

CREATE TABLE `reviews` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `seller_id` int(11) DEFAULT NULL,
  `rating` int(11) NOT NULL,
  `comment` text DEFAULT NULL,
  `is_helpful` tinyint(1) DEFAULT 0,
  `is_abusive_reported` tinyint(1) DEFAULT 0,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

--
-- Dumping data for table `reviews`
--

INSERT INTO `reviews` (`id`, `user_id`, `seller_id`, `rating`, `comment`, `is_helpful`, `is_abusive_reported`, `created_at`) VALUES
(1, 3, 1, 5, 'Great seller!', 1, 0, '2024-05-26 01:57:45'),
(2, 7, 1, 4, 'Good service.', 1, 0, '2024-05-26 01:57:45'),
(3, 6, 1, 4, 'Fast delivery, thanks!', 1, 0, '2024-05-26 01:57:45'),
(4, 2, 1, 5, 'Excellent communication.', 1, 0, '2024-05-26 01:57:45'),
(5, 7, 1, 3, 'Product quality could be better.', 1, 0, '2024-05-26 01:57:45'),
(6, 7, 1, 5, 'Highly recommended!', 1, 0, '2024-05-26 01:57:45'),
(7, 4, 1, 4, 'Smooth transaction.', 1, 0, '2024-05-26 01:57:45'),
(8, 5, 1, 5, 'Very satisfied with the purchase.', 1, 0, '2024-05-26 01:57:45'),
(9, 4, 1, 3, 'Average experience.', 1, 0, '2024-05-26 01:57:45'),
(10, 3, 1, 5, 'Will buy again!', 1, 0, '2024-05-26 01:57:45');

-- --------------------------------------------------------

--
-- Table structure for table `showcases`
--

CREATE TABLE `showcases` (
  `id` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `subtitle` varchar(255) DEFAULT NULL,
  `link` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

--
-- Dumping data for table `showcases`
--

INSERT INTO `showcases` (`id`, `title`, `subtitle`, `link`) VALUES
(1, 'Ofertas do dia', NULL, '/ofertas'),
(2, 'Mais Vendidos', NULL, '/mais-vendidos'),
(3, 'Mais Acessados Hoje', NULL, '/mais-acessados');

-- --------------------------------------------------------

--
-- Table structure for table `showcase_products`
--

CREATE TABLE `showcase_products` (
  `id` int(11) NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `showcase_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

--
-- Dumping data for table `showcase_products`
--

INSERT INTO `showcase_products` (`id`, `product_id`, `showcase_id`) VALUES
(1, 1, 1),
(2, 2, 1),
(3, 3, 1),
(4, 4, 1),
(5, 5, 1),
(6, 6, 1),
(7, 7, 1),
(8, 8, 1),
(9, 9, 2),
(10, 10, 2),
(11, 11, 2),
(12, 12, 2),
(13, 13, 2),
(14, 14, 2),
(15, 15, 2),
(16, 16, 2),
(17, 17, 2),
(18, 1, 3),
(19, 5, 3),
(20, 17, 3),
(21, 16, 3),
(22, 15, 3),
(23, 13, 3),
(24, 12, 3),
(25, 25, 3);

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `id` int(11) NOT NULL,
  `buyer_id` int(11) DEFAULT NULL,
  `seller_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `transaction_type` enum('Compra','Venda','Troca') NOT NULL,
  `buyer_address_id` int(11) DEFAULT NULL,
  `seller_address_id` int(11) DEFAULT NULL,
  `payment_method` varchar(100) DEFAULT NULL,
  `shipping_method` varchar(100) DEFAULT NULL,
  `status` varchar(50) DEFAULT 'Pendente',
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

--
-- Dumping data for table `transactions`
--

INSERT INTO `transactions` (`id`, `buyer_id`, `seller_id`, `product_id`, `quantity`, `total_amount`, `transaction_type`, `buyer_address_id`, `seller_address_id`, `payment_method`, `shipping_method`, `status`, `created_at`) VALUES
(1, 7, 1, 1, 1, 721.99, 'Compra', 1, 4, 'Cartão de Débito', 'Envio Expresso', 'Pagamento Recebido', '2024-05-29 20:12:17'),
(2, 7, 1, 5, 1, 721.99, 'Compra', 1, 4, 'Cartão de Débito', 'Envio Expresso', 'Pagamento Recebido', '2024-05-29 20:12:17'),
(3, 7, 1, 2, 1, 721.99, 'Compra', 1, 4, 'Cartão de Débito', 'Envio Expresso', 'Pagamento Recebido', '2024-05-29 20:12:17'),
(4, 7, 1, 3, 1, 721.99, 'Compra', 1, 4, 'Cartão de Débito', 'Envio Expresso', 'Pagamento Recebido', '2024-05-29 20:12:17'),
(5, 7, 1, 4, 1, 721.99, 'Compra', 1, 4, 'Cartão de Débito', 'Envio Expresso', 'Pagamento Recebido', '2024-05-29 20:12:17');

--
-- Triggers `transactions`
--
DELIMITER $$
CREATE TRIGGER `status_change_trigger` BEFORE UPDATE ON `transactions` FOR EACH ROW BEGIN
    IF NEW.status <> OLD.status THEN
        INSERT INTO transaction_status_history (
            transaction_id, old_status, new_status, changed_at, changed_by
        ) VALUES (
            OLD.id, OLD.status, NEW.status, CURRENT_TIMESTAMP, USER()
        );
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `transaction_status_history`
--

CREATE TABLE `transaction_status_history` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `transaction_id` int(11) NOT NULL,
  `old_status` varchar(50) DEFAULT NULL,
  `new_status` varchar(50) NOT NULL,
  `changed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `changed_by` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

--
-- Dumping data for table `transaction_status_history`
--

INSERT INTO `transaction_status_history` (`id`, `transaction_id`, `old_status`, `new_status`, `changed_at`, `changed_by`) VALUES
(1, 5, 'Aguardando Pagamento', 'Pagamento Recebido', '2024-05-29 20:59:35', 'root@localhost'),
(2, 1, 'Aguardando Pagamento', 'Pagamento Recebido', '2024-05-29 20:59:51', 'root@localhost'),
(3, 2, 'Aguardando Pagamento', 'Pagamento Recebido', '2024-05-29 20:59:52', 'root@localhost'),
(4, 3, 'Aguardando Pagamento', 'Pagamento Recebido', '2024-05-29 20:59:53', 'root@localhost'),
(5, 4, 'Aguardando Pagamento', 'Pagamento Recebido', '2024-05-29 20:59:54', 'root@localhost');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `user_image` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `phone` varchar(20) NOT NULL,
  `user_type` enum('User','Admin') NOT NULL,
  `address_id` int(11) DEFAULT NULL,
  `verified` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `username`, `user_image`, `created_at`, `updated_at`, `phone`, `user_type`, `address_id`, `verified`) VALUES
(1, 'Vinícius', 'vinniebrasil@gmail.com', '$2b$10$v8c51PRHrNdQAR74ZmNGmuLjZyYXDPypMGFKsLw7KJ.mX8aBAQf6a', 'vinnifachini', NULL, '2024-03-14 00:59:41', '2024-05-23 01:58:04', '+55 (18) 99624-8348', 'Admin', 1, 1),
(2, 'Carlos', 'carlinhos@gmail.com', '$2b$10$89wBouRNsYecQ2EaGd3neOdwalAsxhq6a0nBpxrf6SRZReCVyOmGq', 'carlinhos', NULL, '2024-03-14 01:18:42', '2024-05-28 18:10:30', '+55 (18) 99624-8348', 'User', 2, 1),
(3, 'Vinícius de Carvalho Fachini', 'vinicius.fachini@gmail.com', '$2b$10$6f5nqzAJ14GkixGOqBRgwe2GLEhe4MNTP0D1etJP9wFL.bVZZj7Qu', 'ViniciusFachini', NULL, '2024-05-23 14:56:35', '2024-05-23 15:00:30', '+55 (18) 99624-8348', 'Admin', 0, 0),
(4, 'Vinícius de Carvalho Fachini', 'vinicius.fachini01@gmail.com', '$2b$10$MFZhhfEflc2BNfGMLVV1P.sAsL9HULiR4cydn174lSelceQmSP2xG', 'SeuFax', NULL, '2024-05-23 15:12:56', '2024-05-23 15:12:56', '+55 (18) 99624-8348', 'Admin', NULL, 0),
(5, 'Vinícius de Carvalho Fachini', 'vinicius.fachini.01@gmail.com', '$2b$10$d7Po4WnvoZww5IOdYVuq.uzc3jjZdJryvHOvJjsyLi/zzFb69N2Ze', 'SeuFax2', NULL, '2024-05-23 15:14:42', '2024-05-23 15:14:42', '+55 (18) 99624-8348', 'Admin', NULL, 0),
(6, 'Vinícius de Carvalho Fachini', 'vinicius.fachini.02@gmail.com', '$2b$10$/pl2FtZ2KiMbew9dpI5SIefuHzs.jmMIUHEX/iuYCoKBA4QI.64IG', 'SeuFax3', '37df42a3-6078-4552-ae1d-d71cf253a4cb.jpg', '2024-05-23 15:16:14', '2024-05-23 15:16:14', '+55 (18) 99624-8348', 'Admin', NULL, 0),
(7, 'Vinícius de Carvalho Fachini', 'vinicius.fachini.03@gmail.com', '$2b$10$nmRUm50wFv4CvjLolR3il.AAGTHBNZWrQFp7RlzDMLIs/xcpvnYVi', 'SeuFax21', '09dcaf25-8790-48b9-9898-95022de9d124.jpg', '2024-05-23 15:17:29', '2024-05-23 16:36:12', '+55 (18) 99624-8348', 'Admin', NULL, 1),
(8, '', '', '', '', NULL, '2024-05-28 17:31:50', '2024-05-28 18:10:23', '', 'User', NULL, 0),
(14, '123', '123@123.123', '$2b$10$UcMbOY91Va9bF3QJdYpU4.pWLAzi1x1HE6nvcoz7OGLfFHD/LJVV2', '123', NULL, '2024-05-28 18:09:04', '2024-05-28 18:10:26', '123', 'User', NULL, 0),
(15, 'Maicon Küster', 'maiconkusteroficial@gmail.com', '$2b$10$CMCQFzAu8pDbFg8Ey/sJQuUZByF0IFQ6iuxLmXBWduuYcOJydMYcG', 'maiconkusterkk', NULL, '2024-05-28 18:13:18', '2024-05-28 18:13:18', '+55 (18) 99624-8348', 'User', NULL, 0),
(16, '1', '1@ga.com', '$2b$10$LFGOF2IQfC40j7j5DcjxGuFi6M8dHvhsaABn4JeQjv./uxSz86k.a', '1', NULL, '2024-05-28 20:20:41', '2024-05-28 20:20:41', '123', 'User', NULL, 0);

--
-- Triggers `users`
--
DELIMITER $$
CREATE TRIGGER `create_wallet_after_user_creation` AFTER INSERT ON `users` FOR EACH ROW BEGIN
    INSERT INTO Wallets (user_id, balance, withdrawable_amount)
    VALUES (NEW.id, 0.00, 0.00);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `user_addresses`
--

CREATE TABLE `user_addresses` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `address_id` int(11) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `main_address` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

--
-- Dumping data for table `user_addresses`
--

INSERT INTO `user_addresses` (`id`, `user_id`, `address_id`, `title`, `main_address`) VALUES
(1, 7, 1, 'Casa', 1),
(2, 7, 3, 'Trabalho', 0),
(3, 1, 4, 'Casa', 1),
(4, 1, 5, 'Empresa', 0),
(5, 2, 3, 'Casa', 1),
(6, 2, 4, 'Casa', 0),
(7, 1, 5, 'Casa', 0),
(8, 6, 5, 'Casa', 1),
(9, 6, 4, 'Casa', 0),
(10, 3, 4, NULL, 1),
(11, 15, 6, 'Trabalho', 1);

-- --------------------------------------------------------

--
-- Table structure for table `wallets`
--

CREATE TABLE `wallets` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `balance` decimal(10,2) DEFAULT 0.00,
  `withdrawable_amount` decimal(10,2) DEFAULT 0.00,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

--
-- Dumping data for table `wallets`
--

INSERT INTO `wallets` (`id`, `user_id`, `balance`, `withdrawable_amount`, `created_at`, `updated_at`) VALUES
(1, 2, 961.50, 0.00, '2024-05-26 01:50:30', '2024-05-26 03:54:35'),
(2, 5, 0.00, 0.00, '2024-05-26 01:50:30', '2024-05-26 01:50:30'),
(3, 6, 0.00, 0.00, '2024-05-26 01:50:30', '2024-05-26 01:50:30'),
(4, 7, 0.00, 0.00, '2024-05-26 01:50:30', '2024-05-26 01:50:30'),
(5, 3, 0.00, 0.00, '2024-05-26 01:50:30', '2024-05-26 01:50:30'),
(6, 4, 0.00, 0.00, '2024-05-26 01:50:30', '2024-05-26 01:50:30'),
(7, 1, 3609.95, 0.00, '2024-05-26 01:50:30', '2024-05-29 20:59:54'),
(8, 8, 0.00, 0.00, '2024-05-28 17:31:50', '2024-05-28 17:31:50'),
(9, 14, 0.00, 0.00, '2024-05-28 18:09:04', '2024-05-28 18:09:04'),
(10, 15, 0.00, 0.00, '2024-05-28 18:13:18', '2024-05-28 18:13:18'),
(11, 16, 0.00, 0.00, '2024-05-28 20:20:41', '2024-05-28 20:20:41');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `addresses`
--
ALTER TABLE `addresses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_category_parent` (`parent_category_id`);

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sender_id` (`sender_id`),
  ADD KEY `receiver_id` (`receiver_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_product_seller` (`seller_id`);

--
-- Indexes for table `product_categories`
--
ALTER TABLE `product_categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_product_id` (`product_id`),
  ADD KEY `fk_category_id` (`category_id`);

--
-- Indexes for table `product_images`
--
ALTER TABLE `product_images`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `product_id` (`seller_id`);

--
-- Indexes for table `showcases`
--
ALTER TABLE `showcases`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `showcase_products`
--
ALTER TABLE `showcase_products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `showcase_id` (`showcase_id`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `buyer_id` (`buyer_id`),
  ADD KEY `seller_id` (`seller_id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `buyer_address_id` (`buyer_address_id`),
  ADD KEY `seller_address_id` (`seller_address_id`);

--
-- Indexes for table `transaction_status_history`
--
ALTER TABLE `transaction_status_history`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `user_addresses`
--
ALTER TABLE `user_addresses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `address_id` (`address_id`);

--
-- Indexes for table `wallets`
--
ALTER TABLE `wallets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `addresses`
--
ALTER TABLE `addresses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT for table `product_categories`
--
ALTER TABLE `product_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=109;

--
-- AUTO_INCREMENT for table `product_images`
--
ALTER TABLE `product_images`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=161;

--
-- AUTO_INCREMENT for table `reviews`
--
ALTER TABLE `reviews`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `showcases`
--
ALTER TABLE `showcases`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `showcase_products`
--
ALTER TABLE `showcase_products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `transaction_status_history`
--
ALTER TABLE `transaction_status_history`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `user_addresses`
--
ALTER TABLE `user_addresses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `wallets`
--
ALTER TABLE `wallets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `categories`
--
ALTER TABLE `categories`
  ADD CONSTRAINT `fk_category_parent` FOREIGN KEY (`parent_category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `product_categories`
--
ALTER TABLE `product_categories`
  ADD CONSTRAINT `fk_category_id` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`),
  ADD CONSTRAINT `fk_product_id` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

--
-- Constraints for table `user_addresses`
--
ALTER TABLE `user_addresses`
  ADD CONSTRAINT `user_addresses_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `user_addresses_ibfk_2` FOREIGN KEY (`address_id`) REFERENCES `addresses` (`id`);

--
-- Constraints for table `wallets`
--
ALTER TABLE `wallets`
  ADD CONSTRAINT `wallets_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
