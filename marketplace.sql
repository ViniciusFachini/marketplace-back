-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 03, 2024 at 11:33 PM
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
(6, '17700000', 'Centro', 525, 'Osvaldo Cruz', 'São Paulo', '17700000', 'Brasil', '2024-05-28 18:13:18'),
(7, 'Rua dos Bobos', 'Centro', 0, 'Osvaldo Cruz', 'SP', '17700-000', 'Brasil', '2024-05-30 17:54:36');

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

--
-- Dumping data for table `messages`
--

INSERT INTO `messages` (`id`, `sender_id`, `receiver_id`, `content`, `is_read`, `timestamp`) VALUES
(1, 1, 1, 'O Produto: Tênis Nike Structure 25 Masculino\n\n do vendedor Vinícius não condiz com as regras.', 0, '2024-06-03 21:02:20'),
(2, 1, 1, 'O Produto: Tênis Nike Structure 25 Masculino\n\n do vendedor Vinícius não condiz com as regras.', 0, '2024-06-03 21:03:21'),
(3, 1, 1, 'O Produto: Tênis Nike Structure 25 Masculino\n\n do vendedor Vinícius não condiz com as regras.', 0, '2024-06-03 21:04:29'),
(4, 1, 1, 'O Produto: Tênis Nike Structure 25 Masculino\n\n do vendedor Vinícius não condiz com as regras.', 0, '2024-06-03 21:06:45'),
(5, 2, 1, 'O Produto: Tênis Nike Structure 25 Masculino\n\n do vendedor Vinícius não condiz com as regras.', 0, '2024-06-03 21:22:24'),
(6, 2, 1, 'O Produto: Tênis Nike Structure 25 Masculino\n\n do vendedor Vinícius não condiz com as regras.', 0, '2024-06-03 21:24:18'),
(7, 2, 1, 'O Produto: Tênis Nike Structure 25 Masculino\n\n do vendedor Vinícius não condiz com as regras.', 0, '2024-06-03 21:26:55'),
(8, 2, 1, 'O Produto: Tênis Nike Structure 25 Masculino\n\n do vendedor Vinícius não condiz com as regras.', 0, '2024-06-03 21:27:44'),
(9, 2, 1, 'O Produto: Tênis Nike Structure 25 Masculino\n\n do vendedor Vinícius não condiz com as regras.', 0, '2024-06-03 21:28:17'),
(10, 2, 1, 'O Produto: Tênis Nike Structure 25 Masculino\n\n do vendedor Vinícius não condiz com as regras.', 0, '2024-06-03 21:29:14'),
(11, 2, 1, 'O Produto: Tênis Nike Structure 25 Masculino\n\n do vendedor Vinícius não condiz com as regras.', 0, '2024-06-03 21:29:35'),
(12, 2, 1, 'O Produto: Tênis Nike Structure 25 Masculino\n\n do vendedor Vinícius não condiz com as regras.', 0, '2024-06-03 21:31:53'),
(13, 2, 1, 'O Produto: Tênis Nike Structure 25 Masculino\n\n do vendedor Vinícius não condiz com as regras.', 0, '2024-06-03 21:33:03');

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
(2, 1, 'Tênis Nike Structure Masculino', 'Com estabilidade onde você precisa, amortecimento onde você quer, o Structure 25 proporciona suporte para longas quilometragens, corridas curtas e até mesmo descanso antes do final do dia. Ele tem a estabilidade que você busca, lealdade desde a primeira amarração, testada e confiável, com um sistema de mediopé que oferece suporte total e amortecimento mais confortável do que antes.', 'Nike', 'Nike Structure Masculino', 'Novo', 789.90, 0, '2024-05-18 23:13:39', 'tenis-nike-structure-25-masculino-2', 'tenis-nike-structure-25-masculino-2'),
(3, 1, 'Tênis Nike Structure 25 Masculino\n\n', 'Com estabilidade onde você precisa, amortecimento onde você quer, o Structure 25 proporciona suporte para longas quilometragens, corridas curtas e até mesmo descanso antes do final do dia. Ele tem a estabilidade que você busca, lealdade desde a primeira amarração, testada e confiável, com um sistema de mediopé que oferece suporte total e amortecimento mais confortável do que antes.', 'Nike', 'Nike Structure', 'Novo', 721.99, 0, '2024-05-18 23:13:40', 'tenis-nike-structure-25-masculino-3', 'tenis-nike-structure-25-masculino-3'),
(4, 1, 'Tênis Nike Structure 25 Masculino\n\n', 'Com estabilidade onde você precisa, amortecimento onde você quer, o Structure 25 proporciona suporte para longas quilometragens, corridas curtas e até mesmo descanso antes do final do dia. Ele tem a estabilidade que você busca, lealdade desde a primeira amarração, testada e confiável, com um sistema de mediopé que oferece suporte total e amortecimento mais confortável do que antes.', 'Nike', 'Nike Structure', 'Novo', 721.99, 0, '2024-05-18 23:13:40', 'tenis-nike-structure-25-masculino-4', 'tenis-nike-structure-25-masculino-4'),
(5, 1, 'Tênis Nike Structure 25 Masculino\n\n', 'Com estabilidade onde você precisa, amortecimento onde você quer, o Structure 25 proporciona suporte para longas quilometragens, corridas curtas e até mesmo descanso antes do final do dia. Ele tem a estabilidade que você busca, lealdade desde a primeira amarração, testada e confiável, com um sistema de mediopé que oferece suporte total e amortecimento mais confortável do que antes.', 'Nike', 'Nike Structure', 'Novo', 721.99, 0, '2024-05-18 23:13:41', 'tenis-nike-structure-25-masculino-5', 'tenis-nike-structure-25-masculino-5'),
(6, 1, 'Tênis Nike Structure 25 Masculino\n\n', 'Com estabilidade onde você precisa, amortecimento onde você quer, o Structure 25 proporciona suporte para longas quilometragens, corridas curtas e até mesmo descanso antes do final do dia. Ele tem a estabilidade que você busca, lealdade desde a primeira amarração, testada e confiável, com um sistema de mediopé que oferece suporte total e amortecimento mais confortável do que antes.', 'Nike', 'Nike Structure', 'Novo', 721.99, 1, '2024-05-18 23:13:42', 'tenis-nike-structure-25-masculino-6', 'tenis-nike-structure-25-masculino-6'),
(7, 1, 'Tênis Nike Structure 25 Masculino\n\n', 'Com estabilidade onde você precisa, amortecimento onde você quer, o Structure 25 proporciona suporte para longas quilometragens, corridas curtas e até mesmo descanso antes do final do dia. Ele tem a estabilidade que você busca, lealdade desde a primeira amarração, testada e confiável, com um sistema de mediopé que oferece suporte total e amortecimento mais confortável do que antes.', 'Nike', 'Nike Structure', 'Novo', 721.99, 1, '2024-05-18 23:13:42', 'tenis-nike-structure-25-masculino-7', 'tenis-nike-structure-25-masculino-7'),
(8, 1, 'Tênis Nike Structure 25 Masculino\n\n', 'Com estabilidade onde você precisa, amortecimento onde você quer, o Structure 25 proporciona suporte para longas quilometragens, corridas curtas e até mesmo descanso antes do final do dia. Ele tem a estabilidade que você busca, lealdade desde a primeira amarração, testada e confiável, com um sistema de mediopé que oferece suporte total e amortecimento mais confortável do que antes.', 'Nike', 'Nike Structure', 'Novo', 721.99, 0, '2024-05-18 23:13:43', 'tenis-nike-structure-25-masculino-8', 'tenis-nike-structure-25-masculino-8'),
(9, 1, 'Tênis Nike Structure 25 Masculino\n\n', 'Com estabilidade onde você precisa, amortecimento onde você quer, o Structure 25 proporciona suporte para longas quilometragens, corridas curtas e até mesmo descanso antes do final do dia. Ele tem a estabilidade que você busca, lealdade desde a primeira amarração, testada e confiável, com um sistema de mediopé que oferece suporte total e amortecimento mais confortável do que antes.', 'Nike', 'Nike Structure', 'Novo', 721.99, 1, '2024-05-18 23:13:45', 'tenis-nike-structure-25-masculino-9', 'tenis-nike-structure-25-masculino-9'),
(10, 1, 'Tênis Nike Structure 25 Masculino\n\n', 'Com estabilidade onde você precisa, amortecimento onde você quer, o Structure 25 proporciona suporte para longas quilometragens, corridas curtas e até mesmo descanso antes do final do dia. Ele tem a estabilidade que você busca, lealdade desde a primeira amarração, testada e confiável, com um sistema de mediopé que oferece suporte total e amortecimento mais confortável do que antes.', 'Nike', 'Nike Structure', 'Novo', 721.99, 1, '2024-05-18 23:13:46', 'tenis-nike-structure-25-masculino-10', 'tenis-nike-structure-25-masculino-10'),
(11, 1, 'Tênis Nike Structure 25 Masculino\n\n', 'Com estabilidade onde você precisa, amortecimento onde você quer, o Structure 25 proporciona suporte para longas quilometragens, corridas curtas e até mesmo descanso antes do final do dia. Ele tem a estabilidade que você busca, lealdade desde a primeira amarração, testada e confiável, com um sistema de mediopé que oferece suporte total e amortecimento mais confortável do que antes.', 'Nike', 'Nike Structure', 'Novo', 721.99, 1, '2024-05-18 23:13:46', 'tenis-nike-structure-25-masculino-11', 'tenis-nike-structure-25-masculino-11'),
(12, 1, 'Tênis Nike Structure 25 Masculino\n\n', 'Com estabilidade onde você precisa, amortecimento onde você quer, o Structure 25 proporciona suporte para longas quilometragens, corridas curtas e até mesmo descanso antes do final do dia. Ele tem a estabilidade que você busca, lealdade desde a primeira amarração, testada e confiável, com um sistema de mediopé que oferece suporte total e amortecimento mais confortável do que antes.', 'Nike', 'Nike Structure', 'Novo', 721.99, 0, '2024-05-18 23:13:47', 'tenis-nike-structure-25-masculino-12', 'tenis-nike-structure-25-masculino-12'),
(13, 1, 'Tênis Nike Structure 25 Masculino\n\n', 'Com estabilidade onde você precisa, amortecimento onde você quer, o Structure 25 proporciona suporte para longas quilometragens, corridas curtas e até mesmo descanso antes do final do dia. Ele tem a estabilidade que você busca, lealdade desde a primeira amarração, testada e confiável, com um sistema de mediopé que oferece suporte total e amortecimento mais confortável do que antes.', 'Nike', 'Nike Structure', 'Novo', 721.99, 0, '2024-05-18 23:13:48', 'tenis-nike-structure-25-masculino-13', 'tenis-nike-structure-25-masculino-13'),
(14, 1, 'Tênis Nike Structure 25 Masculino\n\n', 'Com estabilidade onde você precisa, amortecimento onde você quer, o Structure 25 proporciona suporte para longas quilometragens, corridas curtas e até mesmo descanso antes do final do dia. Ele tem a estabilidade que você busca, lealdade desde a primeira amarração, testada e confiável, com um sistema de mediopé que oferece suporte total e amortecimento mais confortável do que antes.', 'Nike', 'Nike Structure', 'Novo', 721.99, 0, '2024-05-18 23:13:48', 'tenis-nike-structure-25-masculino-14', 'tenis-nike-structure-25-masculino-14'),
(15, 1, 'Tênis Nike Structure 25 Masculino\n\n', 'Com estabilidade onde você precisa, amortecimento onde você quer, o Structure 25 proporciona suporte para longas quilometragens, corridas curtas e até mesmo descanso antes do final do dia. Ele tem a estabilidade que você busca, lealdade desde a primeira amarração, testada e confiável, com um sistema de mediopé que oferece suporte total e amortecimento mais confortável do que antes.', 'Nike', 'Nike Structure', 'Novo', 721.99, 0, '2024-05-18 23:13:49', 'tenis-nike-structure-25-masculino-15', 'tenis-nike-structure-25-masculino-15'),
(16, 1, 'Tênis Nike Structure 25 Masculino\n\n', 'Com estabilidade onde você precisa, amortecimento onde você quer, o Structure 25 proporciona suporte para longas quilometragens, corridas curtas e até mesmo descanso antes do final do dia. Ele tem a estabilidade que você busca, lealdade desde a primeira amarração, testada e confiável, com um sistema de mediopé que oferece suporte total e amortecimento mais confortável do que antes.', 'Nike', 'Nike Structure', 'Novo', 721.99, 0, '2024-05-18 23:13:50', 'tenis-nike-structure-25-masculino-16', 'tenis-nike-structure-25-masculino-16'),
(17, 1, 'Tênis Nike Structure 25 Masculino\n\n', 'Com estabilidade onde você precisa, amortecimento onde você quer, o Structure 25 proporciona suporte para longas quilometragens, corridas curtas e até mesmo descanso antes do final do dia. Ele tem a estabilidade que você busca, lealdade desde a primeira amarração, testada e confiável, com um sistema de mediopé que oferece suporte total e amortecimento mais confortável do que antes.', 'Nike', 'Nike Structure', 'Novo', 721.99, 1, '2024-05-18 23:40:29', 'tenis-nike-structure-25-masculino-17', 'tenis-nike-structure-25-masculino-17'),
(18, 1, 'Bota Eliane Cano Curto Salto Médio Gelo\n', 'Elegante e fashion. Com a Bota Cano Curto Eliane Salto Médio Gelo, você estará sempre pronta para qualquer ocasião, sem abrir mão do conforto. O gelo é uma tendência neutra e suave que transmite serenidade ao look. Leve e flexível, esse modelo foi pensado nas necessidades de todas as mulheres. O acabamento confortável e o forro superfofinho torna-a indispensável para quem precisa ficar horas de pé no trabalho. Ela também oferece máxima absorção controlando tanto umidade quanto temperatura. Já o superamortecimento da bota proporciona maior absorção de impactos. Para as mulheres que não dispensam o jeans, use esse modelo e dobre as barras da calça para realçar os seus pés. PICCADILLY, caminhe em direção ao novo e se surpreenda com o conforto! Você sabia que todos os produtos da PICCADILLY têm o Calce Perfeito? É um conjunto de benefícios exclusivos que respeita a anatomia do pé, diminui o cansaço e permite que você vá mais longe nas suas jornadas diárias.\n', 'Piccadilly', 'Nike Structure', 'Usado', 389.90, 0, '2024-05-19 21:17:35', 'bota-eliane-cano-curto-salto-medio-gelo-18', 'bota-eliane-cano-curto-salto-medio-gelo-18'),
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
(39, 1, '1', '2', '4', '5', 'Usado', 6.00, 1, '2024-05-24 20:23:02', '0000001391359098', '1-39'),
(40, 1, '1', '2', '4', '5', 'Usado', 6.00, 1, '2024-05-24 20:28:08', '0000001401768586', '1-40'),
(41, 1, '1', '2', '4', '5', 'Semi Novo', 6.00, 1, '2024-05-24 20:29:25', '0000001411300286', '1-41'),
(42, 1, '1', '2', '4', '5', 'Semi Novo', 61.00, 1, '2024-05-24 20:35:02', '0000001421250330', '1-42'),
(43, 1, '1', '2', '4', '5', 'Semi Novo', 5.00, 1, '2024-05-24 20:36:11', '0000001431741113', '1-43'),
(44, 1, '1', '2', '4', '5', 'Usado', 612.00, 1, '2024-05-25 21:24:26', '0000001441749161', '1-44'),
(45, 1, 'Sapato Nike', 'Tênis brabo', 'Nike', 'Nike Air', 'Novo', 700.00, 0, '2024-05-26 19:11:35', '0000001451987515', 'vibrador-dildo-protese-203cm-x-41cm-ponto-g-texturizado-10-modos-de-vibracao-com-controle-remoto---lilo-45'),
(46, 15, 'Vagner Com V', 'Boneco de manequim', 'Vagner', 'Vagner Com V', 'Semi Novo', 3400.00, 1, '2024-05-28 20:31:28', '0000015460366646', 'vagner-com-v-46'),
(47, 1, 'Nova Botita', 'Botita braba', 'Bota', 'Bota', 'Semi Novo', 299.00, 1, '2024-06-02 05:13:30', '0000001471110902', 'nova-botita-47'),
(48, 1, 'Edredom Solteiro Altenburg Malha Fio Penteado - Branco', 'Confeccionado em tecido de malha 100% algodão, o Edredom Malha Fio Penteado é macio e garante uma noite de sono super aconchegante, além de complementar a decoração do quarto com um charme todo especial.\n\nFazendo parte dos produtos que combinam basicamente com tudo, o Edredom é extremamente prático e versátil, podendo ser combinado lindamente com todas as outras linhas e com todos os estilos da casa.', 'Altenburg', 'Malha Fio Penteado', 'Semi Novo', 300.00, 1, '2024-06-02 16:15:52', '0000001481514983', 'edredom-solteiro-altenburg-malha-fio-penteado---branco-48'),
(49, 1, 'Body Lipo Cirrê Marinho', 'Body Lipo Cirrê Marinho: Modelinho com bojos removíveis, maleáveis, que não absorvem água. Body muito versátil, pois pode ser usado como moda praia, como no dia a dia, possibilitando criar looks incríveis. Modelo com decote reto, que valoriza o pescoço e o ombro, possui calcinhas mais largas e não reguláveis, elásticos nas cavas e sem elástico empina bumbum, o modelo contém costuras nas cinturas o que valoriza mais ainda o corpo. Modelo que atende e valoriza todos os padrões de corpo.\n\n \n\nDesenvolvido em tecido cirrê que dispõe de tecnologia UV50 +, que oferece proteção solar para sua pele, bloqueando em até 98% a entrada de raios solares. Peça com acabamento sofisticado, costura invisível e forro em poliamida resultando em maior conforto à pele.\n\n \n\nObservações: Algumas telas de celulares e computadores podem distorcer o tom das cores do produto.\n\n', 'Via Sol', 'GG', 'Novo', 150.00, 1, '2024-06-03 02:17:07', '0000001491647427', 'body-lipo-cirre-marinho-49');

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
(109, 48, 2),
(118, 2, 12),
(119, 2, 13),
(120, 39, 2),
(121, 39, 3),
(122, 40, 2),
(123, 40, 3),
(124, 41, 3),
(125, 41, 4),
(126, 42, 1),
(127, 42, 2),
(128, 42, 3),
(131, 43, 3),
(132, 43, 4),
(133, 44, 3),
(134, 44, 8),
(135, 44, 9),
(138, 46, 4),
(139, 49, 2),
(140, 49, 13),
(141, 45, 2);

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
(26, 1, 'd0f59252-a2ba-4042-80f6-f0eda5caad5f.avif'),
(27, 1, '2947ef5f-3217-4e41-9c68-4934e82017d1.avif'),
(28, 1, 'd04101ab-4894-481b-8305-0fc814bad906.avif'),
(29, 1, '7a071a39-3f60-4664-8c6f-b8bff63b61dd.avif'),
(34, 3, '18d6d0e5-cd5a-4ae1-9edc-7612155da2f4.avif'),
(35, 3, 'a471296f-a36a-432a-8c25-5fe859159e3c.avif'),
(36, 3, '133cd679-2d8e-4d47-88ff-12c73e4d7663.avif'),
(37, 3, '2ae438c1-d588-4e5b-b00a-319307ba908e.avif'),
(38, 4, '0035c73b-40f4-48e5-afdd-d3591f80de06.avif'),
(39, 4, '623253b7-f4be-4230-874f-73057d672b95.avif'),
(40, 4, 'b9e6116b-730d-493a-a3cb-2863e3436469.avif'),
(41, 4, '16f7a173-0ad1-4674-aa95-81661b6793cf.avif'),
(42, 5, 'f14807c3-4452-49c1-ae90-2858add26491.avif'),
(43, 5, 'f2529746-a731-493f-84a1-6318fdb04f68.avif'),
(44, 5, 'a6604d1f-16de-4551-bedd-adb99a9c84a1.avif'),
(45, 5, 'fdd6bf49-894e-43b3-8c19-898024093eb0.avif'),
(46, 6, 'fb7aef41-ba79-421d-b00d-7c73fc682899.avif'),
(47, 6, '8b8814c9-f51e-4069-a811-b4c759cbef02.avif'),
(48, 6, '6bfeafa0-68fa-4b0d-9d3f-1501e6e68969.avif'),
(49, 6, 'f6f721e6-c6ac-41b8-86a1-d9bcc1a44c0f.avif'),
(50, 7, '2c15895e-36ae-437f-978e-27ec9b5f6807.avif'),
(51, 7, 'd402a71a-7bcb-4e4f-8926-3385b799a2ae.avif'),
(52, 7, '6ef3f917-7b0d-44b9-877f-fb5889609166.avif'),
(53, 7, 'c1f100c2-9f4f-4175-abee-b4054f7d7898.avif'),
(54, 8, '6276fa44-59fb-4527-8e6a-88d8e13c286f.avif'),
(55, 8, '72870eda-d565-4bc7-af32-1f093fe0cd5b.avif'),
(56, 8, 'c394c7eb-95a2-4288-a32e-d2e7dc8be5c8.avif'),
(57, 8, '3981d8fa-fee9-443e-93aa-b861cba9cb93.avif'),
(58, 9, '9ec0b8be-048f-4356-bb82-aaff199ce9ec.avif'),
(59, 9, '7e284baa-a2d3-4ccd-a829-39ff1da4ac00.avif'),
(60, 9, '3b6a84e4-acb9-4707-88d3-3caf6dac4300.avif'),
(61, 9, '950d3314-b0e8-473d-86f6-9087443ab225.avif'),
(62, 10, '2ec9fc95-ca0e-4827-a7cf-31709c43c8d4.avif'),
(63, 10, '584567a9-c778-4ca0-a7cf-798268641b5b.avif'),
(64, 10, '879a4717-eb76-44c1-b5e3-b6724c8bf9b9.avif'),
(65, 10, '454f5751-d3f0-4482-9b88-045deae113df.avif'),
(66, 11, 'ea8363a8-a9e0-4c41-b322-330a40e2cf29.avif'),
(67, 11, '5974337a-3b37-4321-a155-2e467b1af55a.avif'),
(68, 11, '051da293-702b-4cdd-b418-b146d9074a18.avif'),
(69, 11, '46ae32fa-e79d-4eae-a7cb-26fd0b41e839.avif'),
(70, 12, 'a3f79d7d-c277-4d10-9e8d-558a0fd213d2.avif'),
(71, 12, 'dfcdd702-4810-4375-8d3e-47a9bf4fb700.avif'),
(72, 12, 'e7f89ee8-ecf7-4349-8b9c-008590260585.avif'),
(73, 12, '2e6aff79-20a0-47cf-a2c9-2c544af11e1f.avif'),
(74, 13, '85e378ff-820d-48f4-8b2f-cd069832e584.avif'),
(75, 13, 'e1905e18-6380-4161-a52f-f9400add2968.avif'),
(76, 13, '62d0bf11-8471-4449-bf60-9284153e74cb.avif'),
(77, 13, '839d958d-00d3-4c49-854f-96b0297903af.avif'),
(86, 15, '279a94ea-ae3c-4f6d-8950-4c939aeab39e.avif'),
(87, 15, 'c971d08a-28cc-4d60-8d29-61faecba3128.avif'),
(88, 15, '14b4538a-0231-4d76-9d74-e8ce6ab7c14a.avif'),
(89, 15, '61815acc-d609-46dc-8399-da8e521867d3.avif'),
(90, 16, 'b1e673f7-20e4-4c62-9f5b-92b1458a02b3.avif'),
(91, 16, '10c5dbda-6069-4136-aeec-3d72459439b8.avif'),
(92, 16, '233d67e9-bec2-4e9a-abf4-4209dc5a37f6.avif'),
(93, 16, '95321bba-f571-49d5-97da-4743fb4fdc07.avif'),
(94, 17, '95d0108a-8021-4231-bab4-5ae0dc187cb6.avif'),
(95, 17, '78e232c3-37ee-41f3-b5ef-139802e54f3f.avif'),
(96, 17, '029d9d70-01ad-4ae5-97c7-533399b131ea.avif'),
(97, 17, '2c9d6c8b-1fe5-4ae2-a50e-22b2af3c5721.avif'),
(98, 18, '8ac2b17e-7ddd-4593-8077-d19632551539.webp'),
(99, 18, 'd3518fed-431d-4d74-af9b-2a72acfeb36c.webp'),
(100, 18, 'ea14a792-8cfc-4cee-a08f-8d2ae35a51c8.webp'),
(101, 18, '9cd9269b-1789-43c4-9668-bfc84fbd0768.webp'),
(102, 19, 'b6f91cc7-a4e0-4705-9564-357aaff5ff9e.webp'),
(103, 19, '7e5b16e9-e8d8-44bb-b4d9-d236f27cacaf.webp'),
(104, 19, 'eeaf9564-7055-4a82-bc0e-1d397bf6a418.webp'),
(105, 19, '8a66cfc1-5bd3-4442-9872-fa4fbf117e70.webp'),
(106, 20, '0dab53a1-8761-4531-82e4-d2512a408366.webp'),
(107, 20, '6ed4bb37-d839-4e91-bf64-05b0d664952b.webp'),
(108, 20, 'a2fe4e63-5823-4073-8d59-9ab124786e34.webp'),
(109, 20, 'af0b584e-98ca-4f98-8219-7ece49cbbff2.webp'),
(110, 21, '32ea77f1-709c-41e5-b238-37ade06cbbbc.webp'),
(111, 21, '23c3ec75-f6ad-4edc-b114-12bd24d9d261.webp'),
(112, 21, '8e281cca-f019-4bc2-a880-d40308992740.webp'),
(113, 21, 'c8981479-9643-4f7e-a459-de727bcd4f8b.webp'),
(114, 22, '2a319d58-6573-47b9-82e3-39d0349cf2d5.webp'),
(115, 22, 'c7f6a347-402d-448c-a374-de8487c05f6f.webp'),
(116, 22, '84dbf345-77b7-4770-bb19-1050de84c3fc.webp'),
(117, 22, 'b94b2f2e-0e5c-40ed-adff-c9b5a2dce15b.webp'),
(118, 23, '5785a673-171a-4637-8608-35bbaaef0e53.webp'),
(119, 23, '48195f87-5e55-491f-8d68-b93883ceb14b.webp'),
(120, 23, '64bc3f00-2895-43c5-b2db-7d420648af55.webp'),
(121, 23, 'cf91d215-4484-4a96-a517-2857e76bbaa4.webp'),
(122, 24, '408d3d80-f570-4e88-96d9-be535d2bcf24.webp'),
(123, 24, '8eca072f-1801-4519-bb64-30077a701caf.webp'),
(124, 24, 'd1c71b5f-a560-4da9-bda4-451ce19f124f.webp'),
(125, 24, 'd18b320e-25df-45cc-8966-c71ca104d585.webp'),
(126, 25, '0ae219a6-16fe-4d2d-b31b-aa7065065d3e.webp'),
(127, 25, 'e61fb4e2-5eb6-4c24-b48b-1992a5a955d9.webp'),
(128, 25, '3d9fb1b0-8e87-4627-9654-f282bd266473.webp'),
(129, 25, '44177788-b88f-4eb9-8231-92c1a88bbc12.webp'),
(130, 36, '9adf8df7-04e7-4483-bf49-c33017c806b3.avif'),
(131, 36, 'e4b99794-9d3b-4043-8bd3-8462154c833d.jpeg'),
(132, 36, '4edcd187-1508-47d2-a4d5-d48f3946bba9.jpeg'),
(133, 36, '6d301254-8112-4e6e-aa2c-499bf0008957.jpeg'),
(134, 35, 'aa8c98f8-c98e-42e2-8375-ebf1ee908a8f.jpeg'),
(135, 35, 'e5e8e901-79cc-4cae-b47d-ea4ac4d77267.jpeg'),
(136, 35, '35fa2edc-d96b-4525-b494-3e02d2559d4a.avif'),
(137, 35, '5d7803a9-4ae5-4a26-b90d-56b736152b06.jpeg'),
(138, 34, '914cb2d0-e0bf-4c00-a459-37515b23cb20.jpeg'),
(139, 34, 'a4e9c73c-26d3-4326-bdd3-22508ba3e73d.jpeg'),
(140, 34, 'fe22a6d9-6c97-45d3-8410-360e2dd4755d.jpeg'),
(141, 34, '9af7610b-ffe4-4bc5-b3e1-3541e62d461f.avif'),
(142, 33, 'f19d0b57-af75-48d1-bf46-30e11d6f77e7.jpeg'),
(143, 33, 'f2c4b849-90c9-4340-8f30-e1c976e1b104.jpeg'),
(144, 33, 'f119d8c2-c244-4e8f-ab4a-68ff111acbad.jpeg'),
(145, 33, '1662a238-2f9b-4990-8213-4f200832369b.avif'),
(146, 32, '83b84fbf-950c-4c66-9363-d2157be9cbf9.jpeg'),
(147, 32, 'b08d9e6c-1ad1-4db8-881f-ecad5aa3a029.jpeg'),
(148, 32, 'd658f669-b081-4b1a-9f9f-7291155005ae.jpeg'),
(149, 32, 'f7043195-4cd0-4ca4-a9dd-10b94dafe777.avif'),
(150, 39, 'da104919-8681-4b87-8e7e-688e4897e357.jpeg'),
(151, 39, 'aecb4fc5-9180-4e46-ac62-69cc7e2608c4.jpeg'),
(152, 39, '4c5c64f4-b3ff-4b2f-8e7b-7b387d1f94d5.avif'),
(153, 39, '63383c49-3901-48c9-a190-211558174f8e.jpeg'),
(154, 40, '39bc3791-01ad-479a-9428-57763c1fb54b.jpeg'),
(155, 40, '7c1466a9-73bc-4a35-b1d6-2dc21bf273be.jpeg'),
(156, 40, '9529de41-d863-40af-96b2-b42b28738155.jpeg'),
(157, 40, 'd32e0ba8-b33d-408c-8c13-2f98f53260ce.avif'),
(158, 41, 'be8808a0-fa57-4ab9-8a6b-dab369f47796.jpeg'),
(159, 41, '4d9c965e-1013-42db-8eeb-c7b8fa3a73b9.avif'),
(160, 41, '34627783-ad89-4232-b87f-95a68585925f.jpeg'),
(161, 41, 'a47abe28-1e81-4412-ae3c-567f97cd7cb3.jpeg'),
(162, 42, 'a5d28566-da43-4d26-8f92-4cb676369c00.jpeg'),
(163, 42, 'f0e36d1a-1903-4bf6-849d-239a71d7d251.jpeg'),
(164, 42, 'b1d3e68a-7d97-4bca-8119-cc9ad588d35f.jpeg'),
(165, 42, 'cf93f863-2a7d-42d3-a1ee-90f37e98d2a8.avif'),
(170, 43, '62b87af3-f2a6-4044-9bfb-7e225e5f3ce7.jpeg'),
(171, 43, '8846c740-543f-4c77-9f3f-c173ba9fde94.jpeg'),
(172, 43, '9d81606b-7ec1-412d-8eab-f4d98757aae3.jpeg'),
(173, 43, 'fa630198-4966-4155-b689-d73d1eb24e40.avif'),
(174, 44, '3e237ed9-0643-44f7-8892-9daee965eb45.jpeg'),
(175, 44, 'f53f97ae-306a-479d-836d-ad9529952810.avif'),
(176, 44, 'cb90c331-7090-4b3b-9e44-35001e38d067.jpeg'),
(177, 44, '931a4a1b-d2cd-4bad-9349-56e8fa7abb0a.jpeg'),
(182, 46, 'bd7f4cc0-ac55-424b-bbb8-9f0b7127e375.jpeg'),
(183, 46, '3c334dcf-3270-4f66-8ea2-f32cf44a6c73.jpeg'),
(184, 47, 'ed8d7b84-da70-4a73-bbf1-6632aeeda9aa.webp'),
(185, 47, 'c20ea949-a3b8-4010-8302-9bb6270062b3.webp'),
(186, 47, 'd5474b8b-97ab-4bbf-94c8-fabee76c9429.webp'),
(187, 47, 'e39e6fea-bca4-462e-a744-340a60179e44.webp'),
(188, 48, 'ff6307aa-6fbd-43fd-a417-2e8307064a52.jpeg'),
(189, 48, 'a709d42b-3ed0-48c0-bac0-d6b94b86421f.jpeg'),
(190, 37, 'fcdec9c5-0719-4283-8dc9-7aa993d1a780.avif'),
(191, 37, '722a1faf-e83c-42d0-a6df-4ab68db8c0ab.avif'),
(192, 37, '54ef0326-2688-42f6-856d-fc50d4d09ef2.avif'),
(193, 37, '93c948e2-90f8-4669-999d-a1324d360117.avif'),
(194, 37, '86132e2d-a28b-4d62-afd4-1c48c72cf8a7.jpeg'),
(195, 37, '2ca9ca1f-b3f9-4b3a-bf01-910ae99e4c62.jpeg'),
(196, 37, '88b8fa47-f126-497c-b3a7-02a548f609aa.jpeg'),
(197, 37, 'b8166643-2075-4c3f-8420-85ec4c25d0fb.jpeg'),
(198, 38, '161c5efe-e033-435a-a8e9-513718935ccd.avif'),
(199, 38, '8e9f5114-ccb8-4359-a2b5-c03109ee54d7.avif'),
(200, 38, 'dd1b9156-ac85-47f0-975f-ccca6d761fe6.avif'),
(201, 38, '6c8b8b6c-c728-4488-b56b-1e7cf8003b27.avif'),
(202, 38, '6a24dcdc-41fd-4a61-963a-2f3f33af7162.jpeg'),
(203, 38, '55969dad-38ce-4dd6-aa9d-dce717d5b542.jpeg'),
(204, 38, 'c57b8c69-f8eb-44f3-a97c-699a001cf955.jpeg'),
(205, 38, '78d38477-ab6e-4c5d-9bd4-d627dcb0a355.jpeg'),
(206, 38, 'dd516176-e0ef-41f1-a6da-f00c7a45b474.webp'),
(207, 38, '2d44ce37-ce06-436a-a6df-60c8e6e778fb.webp'),
(208, 38, '80f300ef-9c5e-4d00-9a3b-08692a599847.webp'),
(209, 38, 'f7a8fd0a-7a28-463c-a03a-4c0c1a05fc06.webp'),
(210, 2, 'd1e64a39-06e7-44d6-afeb-53969c1d6996.webp'),
(211, 2, '286669f5-b3c6-404c-ad8a-9060fe3ccd1c.webp'),
(212, 2, '027ba289-a8f1-4d45-8492-98c2de8a523c.webp'),
(213, 49, '058bb5da-e2c6-4a97-9dc0-5063b91291df.avif'),
(214, 49, '15e6d328-9343-4dac-9331-67731d7bac47.avif'),
(215, 49, '677b9a28-6408-42f0-b97e-3959b0e5e408.avif'),
(216, 49, '0085415b-949f-4986-b799-19a32ce582d6.avif'),
(224, 14, 'd6bf2a97-b05f-4b2d-ba8d-3792afae8c95.avif'),
(225, 14, '196482c4-ec4b-4823-9962-54d9834ece55.avif'),
(226, 14, 'c75485f4-9449-4550-86c7-59b3ea51a4ad.avif'),
(227, 14, 'd23bb136-2961-47aa-ba75-415ef14f0b27.avif'),
(228, 45, 'b3217571-6a63-4229-9b7d-e2d58ed92758.avif'),
(229, 45, '803769c5-2d6b-4a6a-b1e7-f398d5767e3a.avif'),
(230, 45, 'dab241f8-286e-4206-85d7-297eace799c0.avif'),
(231, 45, 'fa721718-fac8-4018-ab11-0913fd59cd37.avif');

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
(1, 7, 1, 1, 1, 721.99, 'Compra', 1, 4, 'Cartão de Débito', 'Envio Expresso', 'Concluído', '2024-05-29 20:12:17'),
(2, 7, 1, 5, 1, 721.99, 'Compra', 1, 4, 'Cartão de Débito', 'Envio Expresso', 'Concluído', '2024-05-29 20:12:17'),
(3, 7, 1, 2, 1, 721.99, 'Compra', 1, 4, 'Cartão de Débito', 'Envio Expresso', 'Concluído', '2024-05-29 20:12:17'),
(4, 7, 1, 3, 1, 721.99, 'Compra', 1, 4, 'Cartão de Débito', 'Envio Expresso', 'Concluído', '2024-05-29 20:12:17'),
(5, 7, 1, 4, 1, 721.99, 'Compra', 1, 4, 'Cartão de Débito', 'Envio Expresso', 'Concluído', '2024-05-29 20:12:17'),
(6, 7, 1, 15, 1, 721.99, 'Compra', 1, 4, 'Credito', 'Express', 'Concluído', '2024-05-30 14:34:41'),
(8, 7, 1, 17, 1, 721.99, 'Compra', 1, 4, 'Pix', 'Express', 'Cancelado', '2024-05-30 21:49:46'),
(9, 7, 1, 11, 1, 721.99, 'Compra', 1, 4, 'Pix', 'Express', 'Concluído', '2024-05-31 15:03:52'),
(10, 6, 1, 25, 1, 389.90, 'Compra', 5, 4, 'Boleto', 'Express', 'Cancelado', '2024-05-31 15:17:21'),
(11, 6, 1, 16, 1, 721.99, 'Compra', 5, 4, 'Boleto', 'Express', 'Concluído', '2024-05-31 15:17:21'),
(12, 6, 1, 14, 1, 721.99, 'Compra', 5, 4, 'Boleto', 'Express', 'Concluído', '2024-05-31 15:17:21'),
(13, 6, 1, 13, 1, 721.99, 'Compra', 5, 4, 'Boleto', 'Express', 'Concluído', '2024-05-31 15:17:21'),
(14, 6, 1, 12, 1, 721.99, 'Compra', 5, 4, 'Boleto', 'Express', 'Concluído', '2024-05-31 15:17:21'),
(15, 7, 1, 8, 1, 721.99, 'Compra', 1, 4, 'Pix', 'Normal', 'Concluído', '2024-06-03 01:33:45'),
(16, 7, 1, 18, 1, 389.90, 'Compra', 1, 4, 'Pix', 'Express', 'Concluído', '2024-06-03 02:34:23');

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
  `old_status` varchar(50) NOT NULL,
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
(5, 4, 'Aguardando Pagamento', 'Pagamento Recebido', '2024-05-29 20:59:54', 'root@localhost'),
(6, 2, 'Pagamento Recebido', 'Concluído', '2024-05-30 14:53:09', 'root@localhost'),
(7, 3, 'Pagamento Recebido', 'Concluído', '2024-05-30 17:02:36', 'root@localhost'),
(8, 7, 'Aguardando Pagamento', 'Pagamento Recebido', '2024-05-30 17:55:58', 'root@localhost'),
(9, 7, 'Pagamento Recebido', 'Concluído', '2024-05-30 17:56:10', 'root@localhost'),
(10, 6, 'Aguardando Pagamento', 'Concluído', '2024-05-30 20:16:34', 'root@localhost'),
(11, 4, 'Pagamento Recebido', 'Concluído', '2024-05-30 20:21:12', 'root@localhost'),
(12, 1, 'Pagamento Recebido', 'Concluído', '2024-05-30 20:26:37', 'root@localhost'),
(13, 5, 'Pagamento Recebido', 'Concluído', '2024-05-30 20:27:39', 'root@localhost'),
(14, 8, 'Aguardando Pagamento', 'Cancelado', '2024-05-31 14:58:12', 'root@localhost'),
(15, 9, 'Aguardando Pagamento', 'Pagamento Recebido', '2024-05-31 15:05:15', 'root@localhost'),
(16, 9, 'Pagamento Recebido', 'Processando', '2024-05-31 15:08:45', 'root@localhost'),
(17, 9, 'Processando', 'Cancelado', '2024-05-31 15:08:59', 'root@localhost'),
(18, 9, 'Cancelado', 'Concluído', '2024-05-31 15:10:55', 'root@localhost'),
(19, 10, 'Aguardando Pagamento', 'Pagamento Recebido', '2024-05-31 15:19:16', 'root@localhost'),
(20, 11, 'Aguardando Pagamento', 'Pagamento Recebido', '2024-05-31 15:19:17', 'root@localhost'),
(21, 12, 'Aguardando Pagamento', 'Pagamento Recebido', '2024-05-31 15:19:18', 'root@localhost'),
(22, 13, 'Aguardando Pagamento', 'Pagamento Recebido', '2024-05-31 15:19:19', 'root@localhost'),
(23, 14, 'Aguardando Pagamento', 'Pagamento Recebido', '2024-05-31 15:19:20', 'root@localhost'),
(24, 10, 'Pagamento Recebido', 'Cancelado', '2024-05-31 15:20:46', 'root@localhost'),
(25, 11, 'Pagamento Recebido', 'Enviado', '2024-05-31 15:21:02', 'root@localhost'),
(26, 12, 'Pagamento Recebido', 'Enviado', '2024-05-31 15:21:10', 'root@localhost'),
(27, 13, 'Pagamento Recebido', 'Enviado', '2024-05-31 15:21:15', 'root@localhost'),
(28, 14, 'Pagamento Recebido', 'Enviado', '2024-05-31 15:21:21', 'root@localhost'),
(29, 11, 'Enviado', 'Concluído', '2024-05-31 15:21:30', 'root@localhost'),
(30, 12, 'Enviado', 'Concluído', '2024-05-31 15:21:34', 'root@localhost'),
(31, 13, 'Enviado', 'Concluído', '2024-05-31 15:21:37', 'root@localhost'),
(32, 14, 'Enviado', 'Concluído', '2024-05-31 15:21:41', 'root@localhost'),
(33, 15, 'Aguardando Pagamento', 'Pagamento Recebido', '2024-06-03 01:35:02', 'root@localhost'),
(36, 15, 'Pagamento Recebido', 'Enviado', '2024-06-03 02:13:22', 'root@localhost'),
(37, 15, 'Enviado', 'Concluído', '2024-06-03 02:14:00', 'root@localhost'),
(38, 16, 'Aguardando Pagamento', 'Pagamento Recebido', '2024-06-03 02:35:52', 'root@localhost'),
(39, 16, 'Pagamento Recebido', 'Enviado', '2024-06-03 02:35:56', 'root@localhost'),
(40, 16, 'Enviado', 'Concluído', '2024-06-03 02:36:25', 'root@localhost');

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
(16, '1', '1@ga.com', '$2b$10$LFGOF2IQfC40j7j5DcjxGuFi6M8dHvhsaABn4JeQjv./uxSz86k.a', '1', NULL, '2024-05-28 20:20:41', '2024-05-28 20:20:41', '123', 'User', NULL, 0),
(17, 'Claudio', 'claudinho@gmail.com', '$2b$10$g2qDM8YYLQOKhlLYD5V.W.osN14jSghbhQ3G7BYtCgu23DziikeVq', 'claudinho', NULL, '2024-05-30 17:53:54', '2024-05-30 17:53:54', '123', 'User', NULL, 0);

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
(11, 15, 6, 'Trabalho', 1),
(12, 17, 7, 'Casa', 1);

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
(1, 2, 0.00, 0.00, '2024-05-26 01:50:30', '2024-05-31 15:08:25'),
(2, 5, 0.00, 0.00, '2024-05-26 01:50:30', '2024-05-26 01:50:30'),
(3, 6, 0.00, 0.00, '2024-05-26 01:50:30', '2024-05-31 15:23:46'),
(4, 7, 0.00, 0.00, '2024-05-26 01:50:30', '2024-05-31 15:24:06'),
(5, 3, 0.00, 0.00, '2024-05-26 01:50:30', '2024-05-26 01:50:30'),
(6, 4, 0.00, 0.00, '2024-05-26 01:50:30', '2024-05-26 01:50:30'),
(7, 1, 0.00, 0.00, '2024-05-26 01:50:30', '2024-06-03 02:36:53'),
(8, 8, 0.00, 0.00, '2024-05-28 17:31:50', '2024-05-28 17:31:50'),
(9, 14, 0.00, 0.00, '2024-05-28 18:09:04', '2024-05-28 18:09:04'),
(10, 15, 0.00, 0.00, '2024-05-28 18:13:18', '2024-05-28 18:13:18'),
(11, 16, 0.00, 0.00, '2024-05-28 20:20:41', '2024-05-28 20:20:41'),
(12, 17, 0.00, 0.00, '2024-05-30 17:53:54', '2024-05-30 17:53:54');

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- AUTO_INCREMENT for table `product_categories`
--
ALTER TABLE `product_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=142;

--
-- AUTO_INCREMENT for table `product_images`
--
ALTER TABLE `product_images`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=232;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `transaction_status_history`
--
ALTER TABLE `transaction_status_history`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `user_addresses`
--
ALTER TABLE `user_addresses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `wallets`
--
ALTER TABLE `wallets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `categories`
--
ALTER TABLE `categories`
  ADD CONSTRAINT `fk_category_parent` FOREIGN KEY (`parent_category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `user_addresses`
--
ALTER TABLE `user_addresses`
  ADD CONSTRAINT `user_addresses_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `user_addresses_ibfk_2` FOREIGN KEY (`address_id`) REFERENCES `addresses` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
