-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.4.24-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             12.1.0.6537
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for militia
CREATE DATABASE IF NOT EXISTS `militia` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `militia`;

-- Dumping structure for table militia.items
CREATE TABLE IF NOT EXISTS `items` (
  `name` varchar(50) NOT NULL,
  `label` varchar(50) NOT NULL,
  `weight` int(11) NOT NULL DEFAULT 1,
  `rare` tinyint(4) NOT NULL DEFAULT 0,
  `can_remove` tinyint(4) NOT NULL DEFAULT 1,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table militia.items: ~30 rows (approximately)
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES
	('autofarm', 'autofarm', 1, 0, 1),
	('brass', 'เเร่ทองเหลือง', 500, 0, 1),
	('brass_plate', 'เเผ่นทองเหลือง', 500, 0, 1),
	('cardx2', 'บัตรฟาร์มX2', 1, 0, 1),
	('cloth', 'ผ้า', 500, 0, 1),
	('cotton', 'ฝ้าย', 500, 0, 1),
	('crude_oil', 'น้ำมันดิบ', 500, 0, 1),
	('engine_oil', 'น้ำมันเครื่อง', 500, 0, 1),
	('exp', 'EXP', 1, 0, 1),
	('first_aidkit', 'ชุดปฐมพยาบาล', 500, 0, 1),
	('fuel_oil', 'น้ำมันเชื้อเพลิง', 500, 0, 1),
	('gauze', 'ผ้าพันแผล', 500, 0, 1),
	('gold_bar', 'ทองคำเเท่ง', 500, 0, 1),
	('gold_ore', 'เเร่ทองคำ', 500, 0, 1),
	('gunpowder', 'ดินปืน', 500, 0, 1),
	('humus', 'ดินดำ', 500, 0, 1),
	('iron_ore', 'เเร่เหล็ก', 500, 0, 1),
	('lead_ore', 'เเร่ตะกั่ว', 500, 0, 1),
	('lead_rod', 'เเท่งตะกั่ว', 500, 0, 1),
	('lunch_box', 'ข้าวกล่อง', 500, 0, 1),
	('medicine_box', 'กล่องยารักษาโรค', 500, 0, 1),
	('morphine', 'มอฟีน', 500, 0, 1),
	('mre', 'MRE', 500, 0, 1),
	('plastic', 'พลาสติก', 500, 0, 1),
	('steel_bar', 'เหล็กเส้น', 500, 0, 1),
	('steel_plate', 'เเผ่นเหล็ก', 500, 0, 1),
	('sulphur', 'กำมะถัน', 500, 0, 1),
	('water', 'น้ำเปล่า', 500, 0, 1),
	('wound_d', 'ยาล้างแผล', 500, 0, 1);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
