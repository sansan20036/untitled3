-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- 主機： 127.0.0.1
-- 產生時間： 2024-05-17 09:19:05
-- 伺服器版本： 10.4.32-MariaDB
-- PHP 版本： 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 資料庫： `testdb`
--

-- --------------------------------------------------------

--
-- 資料表結構 `class`
--

CREATE TABLE `class` (
  `Course` text NOT NULL,
  `Coursecode` text NOT NULL,
  `CourseTitle` text NOT NULL,
  `credit` int(11) NOT NULL,
  `Requiredelective` text NOT NULL,
  `Openingclass` int(11) NOT NULL,
  `Classtime` text NOT NULL,
  `classroom` text NOT NULL,
  `teacher` text NOT NULL,
  `Numberpeople` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=big5 COLLATE=big5_chinese_ci;

--
-- 傾印資料表的資料 `class`
--

INSERT INTO `class` (`Course`, `Coursecode`, `CourseTitle`, `credit`, `Requiredelective`, `Openingclass`, `Classtime`, `classroom`, `teacher`, `Numberpeople`) VALUES
('1287\r\n', 'IECS1009', '程式設計', 2, '必修\r\n\r\n', 1, '(三)06-07\r\n', '忠B03\r\n資電234(電腦實習室)', '劉明機', 0),
('1372', 'IECS1005', '計算機概論', 2, '必修', 1, '(一)06-07', '資電234(電腦實習室)', '林佩蓉', 10),
('1292', 'IEE1006	', '邏輯設計', 3, '必修', 1, '(四)09-10\r\n(五)07', '資電404\r\n資電504', '陳啟鏘', 20),
('1291', 'IEE1005', '線性代數', 3, '必修', 1, '(五)02-04', '資電404', '洪維志', 15),
('1314', 'IECS2025', '機率與統計', 3, '必修', 2, '(一)06-07\r\n(二)04', '科航206\r\n資電504', '游景盛', 25),
('1312', 'IECS2003', '系統程式', 3, '必修', 2, '(一)03-04\r\n(三)04', '資電402', '劉宗杰', 30),
('1324', 'IECS2072', 'Web程式設計', 3, '選修', 2, '(三)01-03', '資電234(電腦實習室)', '劉明機', 50),
('1395', 'IECS2001', '資料結構', 3, '必修', 2, '(一)03\r\n(二)03-04', '資電515\r\n資電B07', '劉怡芬', 45),
('1313', 'IECS3022', '資料庫系統', 3, '必修', 2, '(一)08-09\r\n(二)03', '資電511\r\n資電512', '許懷中', 45),
('1415', 'IECS2022', '物件導向設計', 2, '選修', 2, '(四)13-14', '資電234(電腦實習室) ', '曾昭文', 40),
('1339', 'IECS303', '計算機結構學', 3, '必修', 3, '(三)06 \r\n(五)06-07', '資電103\r\n資電403', '陳青文', 50),
('1340', 'IECS302	', '計算機演算法', 3, '必修', 3, '(二)08-09\r\n(三)07', '資電404', '黃秀芬', 60),
('1348', 'IECS359', '人工智慧導論', 3, '選修', 3, '(一)02-04', '資電234(電腦實習室)', '林峰正', 55),
('1359', 'IECS321', '程式語言', 3, '選修', 3, '(一)11-13', '資電248', '吳育倫', 65),
('1456', 'IECS478', '深度學習', 3, '選修', 4, '(一)02-04', '資電234(電腦實習室)', '林峰正', 70),
('1460', 'IECS461', '專題產業實習', 3, '選修', 4, '(五)00', '未排教室', '李榮三\r\n', 30);

-- --------------------------------------------------------

--
-- 資料表結構 `people`
--

CREATE TABLE `people` (
  `id` int(11) NOT NULL,
  `name` varchar(20) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=big5 COLLATE=big5_chinese_ci;

--
-- 傾印資料表的資料 `people`
--

INSERT INTO `people` (`id`, `name`, `description`) VALUES
(1, 'hj', 'Hsu, HJ'),
(2, 'help', 'Hung, Help'),
(3, 'desire', 'Chen, Desire'),
(4, 'broken', 'Yang, Broken One');

-- --------------------------------------------------------

--
-- 資料表結構 `student`
--

CREATE TABLE `student` (
  `Courseselection` text NOT NULL,
  `Openingclass` text NOT NULL,
  `Accountcode` text NOT NULL,
  `Subjectname` text NOT NULL,
  `Requiredelective` text NOT NULL,
  `credit` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=big5 COLLATE=big5_chinese_ci;

--
-- 傾印資料表的資料 `student`
--

INSERT INTO `student` (`Courseselection`, `Openingclass`, `Accountcode`, `Subjectname`, `Requiredelective`, `credit`) VALUES
('0811	', '創能學院綜合班', 'IINE2814', '當教育大數據遇見AI', '必修', 2),
('1311', '資訊二乙', 'GEID0010', '班級活動', '必修', 0),
('1312', '資訊二乙', 'IECS2003', '系統程式', '必修', 3),
('1313', '資訊二乙', 'IECS3022', '資料庫系統', '必修', 3),
('1314', '資訊二乙', 'IECS2025 ', '機率與統計', '必修', 3),
('1324', '資訊二合', 'IECS2072', 'Web程式設計', '選修', 3),
('1365', '資訊四合', 'IECS471', '程式設計與問題解決', '選修', 2),
('3303', '大二英文綜合班', 'ENGL1055 ', '大學精進英文(二)初級', '必修', 2),
('2963', '人文藝術與社會經典教育', 'GEH1059 ', '中國文物欣賞', '選修', 2),
('3528', '科技知識原理與趨勢浪潮', 'GEK1042', '生命起源與生物科技', '選修', 2),
('3144', '體育選修', 'ATHL3066', '體育—防身術', '選修', 1);

--
-- 已傾印資料表的索引
--

--
-- 資料表索引 `people`
--
ALTER TABLE `people`
  ADD PRIMARY KEY (`id`);

--
-- 在傾印的資料表使用自動遞增(AUTO_INCREMENT)
--

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `people`
--
ALTER TABLE `people`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
