-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: monorail.proxy.rlwy.net    Database: asm2
-- ------------------------------------------------------
-- Server version	8.3.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

drop database if exists `asm2`;
create database `asm2`;
use `asm2`;

--
-- Table structure for table `applypost`
--

DROP TABLE IF EXISTS `applypost`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `applypost` (
  `id` int NOT NULL AUTO_INCREMENT,
  `created_at` date NOT NULL,
  `name_cv` varchar(255) NOT NULL,
  `status` int NOT NULL,
  `text` text,
  `recruitment_id` int NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `recruitment_id` (`recruitment_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `applypost_ibfk_1` FOREIGN KEY (`recruitment_id`) REFERENCES `recruitment` (`id`) ON DELETE CASCADE,
  CONSTRAINT `applypost_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `applypost`
--

LOCK TABLES `applypost` WRITE;
/*!40000 ALTER TABLE `applypost` DISABLE KEYS */;
INSERT INTO `applypost` VALUES (5,'2024-04-11','https://storage.googleapis.com/download/storage/v1/b/workcv-data/o/applyPost%2Fuser1@gmail.com%2Frecruitment_1%2Fcv%2FCV_Ngo_Tien_Trien_Beinco.pdf?generation=1712798731387876&alt=media',0,'beinco\r\n							',1,6),(6,'2024-04-11','https://storage.googleapis.com/download/storage/v1/b/workcv-data/o/user%2Fuser2@gmail.com%2Fcv%2FCV_Ngo_Tien_Trien.pdf?generation=1712798469761514&alt=media',0,'							',1,5);
/*!40000 ALTER TABLE `applypost` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'Python'),(2,'ASP.NET'),(3,'C/C++'),(4,'Java'),(5,'PHP'),(6,'NoteJs'),(7,'Ruby');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `company`
--

DROP TABLE IF EXISTS `company`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `company` (
  `id` int NOT NULL AUTO_INCREMENT,
  `address` varchar(255) NOT NULL,
  `description` text,
  `email` varchar(255) NOT NULL,
  `logo` varchar(255) NOT NULL,
  `name_company` varchar(255) NOT NULL,
  `phone_company` varchar(255) NOT NULL,
  `status` int NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `company_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `company`
--

LOCK TABLES `company` WRITE;
/*!40000 ALTER TABLE `company` DISABLE KEYS */;
INSERT INTO `company` VALUES (1,'KCN Giao Long, Bến Tre, Việt Nam','<p><strong>Elio </strong>là một công ty sản xuất đồng hồ đẳng cấp, nổi tiếng với sự kết hợp tinh tế giữa thiết kế hiện đại và chất lượng tốt nhất. Với nhiều năm kinh nghiệm trong ngành công nghiệp đồng hồ, <strong>Elio</strong> đã tạo ra những sản phẩm mang phong cách độc đáo và đẳng cấp, thu hút sự chú ý của người yêu thời trang trên khắp thế giới.</p><p><strong>Elio </strong>không chỉ làm chủ về thiết kế mà còn chú trọng vào việc sử dụng các nguyên liệu và công nghệ tiên tiến nhất để sản xuất ra những chiếc đồng hồ chất lượng cao và đáng tin cậy. Từ các bộ máy cơ truyền thống đến công nghệ đồng hồ thông minh, Elio luôn đảm bảo rằng mỗi sản phẩm đều mang đến trải nghiệm tuyệt vời nhất cho người dùng.</p><p>Với tầm nhìn làm nên sự khác biệt và cam kết đem lại sự hài lòng tuyệt đối cho khách hàng, Elio không ngừng nỗ lực để phát triển và định vị mình là một trong những thương hiệu đồng hồ hàng đầu trên thị trường toàn cầu.</p>','elio@gmai.com','https://storage.googleapis.com/download/storage/v1/b/workcv-data/o/user%2Ftriennt97@gmail.com%2Flogo%2Felio-logo.jfif?generation=1712718938545246&alt=media','Elio','0908909997',0,1),(2,'Tòa nhà Byte, 123 Đường Công Nghệ, Quận 1, TP. Hồ Chí Minh','<p>Byte Venture chuyên phát triển các giải pháp phần mềm tùy chỉnh, từ ứng dụng di động đến hệ thống quản lý doanh nghiệp.</p>','contact@byteventure.com','https://storage.googleapis.com/download/storage/v1/b/workcv-data/o/user%2Ftrienntfx21143@funix.edu.vn%2Flogo%2FByteVenture-logo.jfif?generation=1712800266656172&alt=media','Byte Venture','02812345678',0,7),(3,'Lầu 20, Tòa nhà Fusion, 456 Đường Lập Trình, Quận 3, TP. Hà Nội','<p>Code Fusion cung cấp các dịch vụ tích hợp hệ thống và phát triển phần mềm với một đội ngũ chuyên gia hàng đầu.</p>','support@codefusion.tech','https://storage.googleapis.com/download/storage/v1/b/workcv-data/o/user%2Fadmin1@gmail.com%2Flogo%2FcodeFusion-logo.jfif?generation=1712802867715753&alt=media','Code Fusion','02456789101',0,8),(4,'Khu Công Nghệ Cao, Lô 789, Phố Mạng, Quận 7, TP. Đà Nẵng','<p>Cyber Nexus là một công ty an ninh mạng, cung cấp các giải pháp bảo mật toàn diện cho doanh nghiệp.</p>','info@cybernexus.net','https://storage.googleapis.com/download/storage/v1/b/workcv-data/o/user%2Fadmin2@gmail.com%2Flogo%2FCyberNexus-logo.jfif?generation=1712803496208733&alt=media','Cyber Nexus','02367891011',0,9),(5,'Tầng 5, Tòa nhà Sphere, 789 Đường Dữ Liệu, Quận 5, TP. Cần Thơ','<p>Data Sphere chuyên về khoa học dữ liệu và phân tích dữ liệu lớn, giúp doanh nghiệp hiểu rõ hơn về thông tin khách hàng và thị trường.</p>','inquiry@datasphere.org','https://storage.googleapis.com/download/storage/v1/b/workcv-data/o/user%2Fadmin3@gmail.com%2Flogo%2FdataSphere-logo.jfif?generation=1712884444433210&alt=media','Data Sphere','02910111213',0,10),(6,'Tòa nhà Matrix, 321 Đường Thông Tin, Quận 10, TP. Biên Hòa','<p>Infor Matrix cung cấp các giải pháp ERP tiên tiến, giúp tự động hóa và tối ưu hóa các quy trình kinh doanh.</p>','service@infomatrix.io','https://storage.googleapis.com/download/storage/v1/b/workcv-data/o/user%2Fadmin4@gmail.com%2Flogo%2FinforMatrix-logo.jfif?generation=1712888287713098&alt=media','Infor Matrix','02512131415',0,11);
/*!40000 ALTER TABLE `company` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cv`
--

DROP TABLE IF EXISTS `cv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cv` (
  `id` int NOT NULL AUTO_INCREMENT,
  `file_name` varchar(255) NOT NULL,
  `file_path` varchar(255) NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `cv_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cv`
--

LOCK TABLES `cv` WRITE;
/*!40000 ALTER TABLE `cv` DISABLE KEYS */;
INSERT INTO `cv` VALUES (11,'CV_Ngo_Tien_Trien.pdf','https://storage.googleapis.com/download/storage/v1/b/workcv-data/o/user%2Fuser2@gmail.com%2Fcv%2FCV_Ngo_Tien_Trien.pdf?generation=1712798469761514&alt=media',5),(12,'CV - Ngô Tiến Triển.pdf','https://storage.googleapis.com/download/storage/v1/b/workcv-data/o/user%2Fuser1@gmail.com%2Fcv%2FCV%20-%20Ng%C3%B4%20Ti%E1%BA%BFn%20Tri%E1%BB%83n.pdf?generation=1712798682431495&alt=media',6);
/*!40000 ALTER TABLE `cv` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `follow_company`
--

DROP TABLE IF EXISTS `follow_company`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `follow_company` (
  `id` int NOT NULL AUTO_INCREMENT,
  `company_id` int NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `company_id` (`company_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `follow_company_ibfk_1` FOREIGN KEY (`company_id`) REFERENCES `company` (`id`),
  CONSTRAINT `follow_company_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `follow_company`
--

LOCK TABLES `follow_company` WRITE;
/*!40000 ALTER TABLE `follow_company` DISABLE KEYS */;
/*!40000 ALTER TABLE `follow_company` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recruitment`
--

DROP TABLE IF EXISTS `recruitment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recruitment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `address` varchar(255) NOT NULL,
  `created_at` date DEFAULT NULL,
  `description` text,
  `experience` text,
  `quantity` int DEFAULT NULL,
  `recruitment_rank` varchar(255) DEFAULT NULL,
  `status` int DEFAULT NULL,
  `salary` varchar(255) DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `type` varchar(255) DEFAULT NULL,
  `view` int DEFAULT NULL,
  `category_id` int NOT NULL,
  `company_id` int DEFAULT NULL,
  `deadline` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `category_id` (`category_id`),
  KEY `company_id` (`company_id`),
  CONSTRAINT `recruitment_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`),
  CONSTRAINT `recruitment_ibfk_2` FOREIGN KEY (`company_id`) REFERENCES `company` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recruitment`
--

LOCK TABLES `recruitment` WRITE;
/*!40000 ALTER TABLE `recruitment` DISABLE KEYS */;
INSERT INTO `recruitment` VALUES (1,'KCN giao long, bến tre','2024-04-04','<p>Kinh nghiệm làm việc với Java và các công nghệ liên quan như Spring, Hibernate...Hiểu biết vững về các nguyên tắc lập trình hướng đối tượng (OOP)Kỹ năng giải quyết vấn đề và làm việc độc lập cũng như trong nhómKiến thức về các công cụ quản lý mã nguồn như GitTiếng Anh giao tiếp tốt</p>','1 năm',3,NULL,0,'15000000','Lập trình viên Java','Full time',0,4,1,'2024-04-14'),(2,'Tòa nhà Byte, 123 Đường Công Nghệ, Quận 1, TP. Hồ Chí Minh','2024-04-11','<p><strong>Mục tiêu:</strong> Tìm kiếm chuyên viên phát triển phần mềm có kỹ năng vững vàng trong lập trình để tham gia vào dự án phát triển phần mềm quan trọng của công ty.</p><p><strong>Mô tả công việc:</strong></p><ul><li>Phát triển và duy trì các ứng dụng phần mềm.</li><li>Tham gia vào quá trình thiết kế, lập trình và kiểm thử.</li><li>Tối ưu hóa hiệu suất và đảm bảo tính ổn định của ứng dụng.</li></ul>','Ít nhất 2 năm kinh nghiệm làm việc trong phát triển phần mềm. Sử dụng thành thạo các ngôn ngữ lập trình như Java, Python, hoặc C++. Hiểu biết về cơ sở dữ liệu và kỹ năng làm việc với các công cụ quản lý mã nguồn như Git.',3,NULL,0,'Thỏa thuận','Chuyên viên phát triển phần mềm','Full time',0,4,2,'2024-04-30'),(3,'Lầu 20, Tòa nhà Fusion, 456 Đường Lập Trình, Quận 3, TP. Hà Nội','2024-04-11','<p><strong>Mục tiêu:</strong> Tìm kiếm kỹ sư mạng và hệ thống có kinh nghiệm để quản lý và duy trì hạ tầng mạng của công ty.</p><p><strong>Mô tả công việc:</strong></p><ul><li>Thiết lập và duy trì các mạng máy tính, bao gồm cài đặt, cấu hình và giám sát.</li><li>Xử lý các vấn đề về mạng và hệ thống, bảo đảm tính ổn định và an toàn của hệ thống.</li><li>Hỗ trợ tìm kiếm và triển khai giải pháp mới cho hệ thống mạng.</li></ul>','Ít nhất 3 năm kinh nghiệm làm việc trong lĩnh vực mạng và hệ thống. Kiến thức sâu về các giao thức mạng như TCP/IP, DNS, DHCP. Kinh nghiệm làm việc với các thiết bị mạng và hệ điều hành như Cisco, Juniper, Windows Server.',1,NULL,0,'20000000','Kỹ sư mạng và hệ thống','Full time',0,2,3,'2024-04-27'),(4,'Khu Công Nghệ Cao, Lô 789, Phố Mạng, Quận 7, TP. Đà Nẵng','2024-04-11','<p><strong>Mục tiêu:</strong> Tìm kiếm nhà phát triển back-end có kỹ năng mạnh mẽ để tham gia vào việc phát triển hệ thống và API của công ty.</p><p><strong>Mô tả công việc:</strong></p><ul><li>Thiết kế, xây dựng và duy trì hệ thống back-end cho các ứng dụng web và di động.</li><li>Phát triển và triển khai các API để tương tác với các ứng dụng khác.</li><li>Tối ưu hóa hiệu suất và mở rộng tính khả dụng của hệ thống.</li></ul>','Kinh nghiệm:  Ít nhất 3 năm kinh nghiệm làm việc trong phát triển back-end. Sử dụng thành thạo các ngôn ngữ và framework back-end như Node.js, Python (Django/Flask), hoặc Ruby on Rails.',2,NULL,0,'Thỏa thuận','Nhà phát triển Back-end','Full time',0,1,4,'2024-04-30'),(5,'Bến Tre','2024-04-11','<p><strong>Mục tiêu:</strong> Công ty chúng tôi đang tìm kiếm chuyên viên Python để tham gia vào việc phát triển và duy trì các dự án phần mềm.</p><p><strong>Mô tả công việc:</strong></p><ul><li>Phát triển và duy trì các ứng dụng và dịch vụ sử dụng Python.</li><li>Tham gia vào việc thiết kế, lập trình, và kiểm thử.</li><li>Tối ưu hóa hiệu suất và đảm bảo tính ổn định của hệ thống.</li></ul>','Ít nhất 2 năm kinh nghiệm làm việc trong phát triển phần mềm sử dụng Python. Hiểu biết vững về các framework và thư viện phổ biến như Django, Flask. Kỹ năng tốt trong việc làm việc với cơ sở dữ liệu như MySQL, PostgreSQL.Kỹ năng tốt trong việc làm việc với HTML, CSS, và JavaScript.',2,NULL,0,'13000000','Chuyên viên Python','Full time',0,1,1,'2024-05-10'),(6,'Tầng 5, Tòa nhà Sphere, 789 Đường Dữ Liệu, Quận 5, TP. Cần Thơ','2024-04-12','<p><strong>Mục tiêu:</strong> Công ty chúng tôi đang tìm kiếm nhà phát triển Node.js có kinh nghiệm để tham gia vào việc phát triển ứng dụng web và các dịch vụ liên quan.</p><p><strong>Mô tả công việc:</strong></p><ul><li>Phát triển và duy trì các ứng dụng web sử dụng Node.js.</li><li>Thiết kế và triển khai các API để tương tác với các ứng dụng khác.</li><li>Tối ưu hóa hiệu suất và mở rộng tính khả dụng của hệ thống.</li></ul>','Ít nhất 3 năm kinh nghiệm làm việc trong phát triển ứng dụng sử dụng Node.js. Kiến thức vững về Express.js, MongoDB, hoặc MySQL. Kỹ năng tốt trong việc làm việc với HTML, CSS, và JavaScript',2,NULL,0,'Thỏa thuận','Nhà phát triển Node.js','Full time',0,6,5,'2024-05-11'),(7,'Tòa nhà Matrix, 321 Đường Thông Tin, Quận 10, TP. Biên Hòa','2024-04-12','<p><strong>Mục tiêu:</strong> Công ty chúng tôi đang tìm kiếm nhà phát triển Java có kỹ năng sâu về lập trình Java để tham gia vào việc phát triển các ứng dụng và hệ thống.</p><p><strong>Mô tả công việc:</strong></p><ul><li>Phát triển và duy trì các ứng dụng Java.</li><li>Tham gia vào quy trình thiết kế, lập trình, và kiểm thử.</li><li>Tối ưu hóa hiệu suất và đảm bảo tính ổn định của ứng dụng.</li></ul>','Ít nhất 2 năm kinh nghiệm làm việc trong phát triển ứng dụng Java. Kiến thức sâu về các framework và thư viện Java như Spring, Hibernate. Kinh nghiệm làm việc với các công cụ phát triển như Eclipse, IntelliJ IDEA.',2,NULL,0,'30000000','Nhà phát triển Java','Full time',0,4,6,'2024-05-11');
/*!40000 ALTER TABLE `recruitment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role` (
  `id` int NOT NULL AUTO_INCREMENT,
  `role_name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (1,'ROLE_USER'),(2,'ROLE_ADMIN');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `save_job`
--

DROP TABLE IF EXISTS `save_job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `save_job` (
  `id` int NOT NULL AUTO_INCREMENT,
  `recruitment_id` int NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `recruitment_id` (`recruitment_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `save_job_ibfk_1` FOREIGN KEY (`recruitment_id`) REFERENCES `recruitment` (`id`) ON DELETE CASCADE,
  CONSTRAINT `save_job_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `save_job`
--

LOCK TABLES `save_job` WRITE;
/*!40000 ALTER TABLE `save_job` DISABLE KEYS */;
/*!40000 ALTER TABLE `save_job` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `address` varchar(255) DEFAULT NULL,
  `description` text,
  `email` varchar(255) NOT NULL,
  `full_name` varchar(255) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `password` varchar(128) NOT NULL,
  `phone_number` varchar(255) DEFAULT NULL,
  `status_id` int DEFAULT NULL,
  `role_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_role` (`role_id`),
  KEY `status_id` (`status_id`),
  CONSTRAINT `fk_role` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`),
  CONSTRAINT `user_ibfk_1` FOREIGN KEY (`status_id`) REFERENCES `user_status` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'Số nhà 155, ấp Bình Phú, xã Cẩm Sơn','<p>Xin chào, tôi là một nhà tuyển dụng có kinh nghiệm trong việc tìm kiếm và tuyển dụng nhân viên tài năng cho các vị trí khác nhau trong tổ chức của mình. Với hơn năm kinh nghiệm làm việc trong lĩnh vực quản lý nhân sự, tôi đã có cơ hội làm việc với nhiều ứng viên ưu tú và xây dựng một đội ngũ nhân viên đa dạng và đầy đủ kỹ năng.</p><p>Tôi có kiến thức sâu về quy trình tuyển dụng, từ việc xác định nhu cầu tuyển dụng đến việc đánh giá và chọn lọc ứng viên phù hợp nhất. Tôi luôn đặt mục tiêu đưa vào đội ngũ là những ứng viên có sự phù hợp với văn hóa tổ chức, kỹ năng chuyên môn và tiềm năng phát triển.</p><p>Ngoài ra, tôi cũng là người luôn tìm kiếm cơ hội để cải thiện quy trình tuyển dụng và tạo ra một môi trường làm việc tích cực và động viên cho nhân viên. Tôi tin rằng sự đa dạng trong lực lượng lao động là yếu tố quan trọng để thúc đẩy sự sáng tạo và hiệu suất làm việc.</p><p>Với tinh thần cầu tiến và cam kết với việc xây dựng đội ngũ nhân sự mạnh mẽ và đa dạng, tôi luôn sẵn lòng tiếp nhận và thách thức mới trong công việc tuyển dụng.</p>','triennt97@gmail.com','Ngô Tiến Triển','https://storage.googleapis.com/download/storage/v1/b/workcv-data/o/user%2Ftriennt97@gmail.com%2Favatar%2Favatar.jpg?generation=1712718395659964&alt=media','$2a$10$wQ6yxWa1JqYasMP5Y.pxP.VdAbmtm0WdqMLGS13lzDAfIzsGcN5pG','0971563392',1,2),(4,NULL,NULL,'supergau897@gmail.com','Tien Trien','https://storage.googleapis.com/workcv-data/resources/assets/images/default_avatar.jpg','$2a$10$giY0bPpJUXeEoE3SrnLWmu6fb6UfCewWhLbbP9LsxMmeN8f4ogjQu',NULL,4,2),(5,NULL,NULL,'user2@gmail.com','user2','https://storage.googleapis.com/download/storage/v1/b/workcv-data/o/user%2Fuser2@gmail.com%2Favatar%2FtechNOVA-logo.jfif?generation=1712719097935155&alt=media','$2a$10$M4RYGADdVNxWCzl.RmYkXe69JCe8fg4NPRLb9SGqTBa9gxwxuHoCe',NULL,5,1),(6,NULL,NULL,'user1@gmail.com','user1','https://storage.googleapis.com/download/storage/v1/b/workcv-data/o/user%2Fuser1@gmail.com%2Favatar%2FsuperTech-lgo.jfif?generation=1712798673950423&alt=media','$2a$10$cksu2S5vEKVBdD1mqjTiHeeb7bIymsLyg1NNo4axIHQuhn5TVZYGu',NULL,6,1),(7,'Số nhà 155, ấp Bình Phú, xã Cẩm Sơn','<p>fsfrq</p>','trienntfx21143@funix.edu.vn','trienntfx','https://storage.googleapis.com/download/storage/v1/b/workcv-data/o/user%2Ftrienntfx21143@funix.edu.vn%2Favatar%2Fbg_2.png?generation=1712799345852044&alt=media','$2a$10$vdPxbUs4d1JF719DcbuLt.NF6CXwYodVWH0tyHmW7dOxIbdhxKp7C','0971563392',7,2),(8,'123','<p>no</p>','admin1@gmail.com','Admin1','https://storage.googleapis.com/download/storage/v1/b/workcv-data/o/user%2Fadmin1@gmail.com%2Favatar%2F1.jfif?generation=1712802543471849&alt=media','$2a$10$WA8C12v6RqFviBRvY5Ixq.wbLEJ8sEaflwHwFsYpu8EWJOPLK5ZcO','0123456456',8,2),(9,'abc','<p>adg</p>','admin2@gmail.com','Admin2','https://storage.googleapis.com/download/storage/v1/b/workcv-data/o/user%2Fadmin2@gmail.com%2Favatar%2F4.jfif?generation=1712803380235176&alt=media','$2a$10$1KmhfrKJ1PXK1h6FPCxAa.Cyxab6Sc0NaVPDJWF7yTemX5vz670dm','02123123123',9,2),(10,'gd','<p>sãb</p>','admin3@gmail.com','Admin3','https://storage.googleapis.com/download/storage/v1/b/workcv-data/o/user%2Fadmin3@gmail.com%2Favatar%2F5.jfif?generation=1712884292983743&alt=media','$2a$10$I4XcXg13DM9LRPbrKU9.TOIvGZ8lJntJUeBmY3rJbIfLAijSAkjn2','0123456789',10,2),(11,'fa,adfs','<p>af</p><p>,</p><p>fsd</p>','admin4@gmail.com','Admin4','https://storage.googleapis.com/download/storage/v1/b/workcv-data/o/user%2Fadmin4@gmail.com%2Favatar%2F6.jfif?generation=1712888197729029&alt=media','$2a$10$1cyVGkW54JTjMxiVZgJBL.nn8QulYmRXyAXmBOPej03/UmUYmYnPO','0124567890',11,2);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_status`
--

DROP TABLE IF EXISTS `user_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_status` (
  `id` int NOT NULL AUTO_INCREMENT,
  `verified` tinyint(1) DEFAULT '0',
  `updated` tinyint(1) DEFAULT '0',
  `created_company` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_status`
--

LOCK TABLES `user_status` WRITE;
/*!40000 ALTER TABLE `user_status` DISABLE KEYS */;
INSERT INTO `user_status` VALUES (1,1,1,1),(2,0,0,0),(3,0,0,0),(4,0,0,0),(5,0,0,0),(6,0,0,0),(7,1,1,1),(8,1,1,1),(9,1,1,1),(10,1,1,1),(11,1,1,1);
/*!40000 ALTER TABLE `user_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `verification`
--

DROP TABLE IF EXISTS `verification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `verification` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `verify_code` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `verification`
--

LOCK TABLES `verification` WRITE;
/*!40000 ALTER TABLE `verification` DISABLE KEYS */;
INSERT INTO `verification` VALUES (1,'triennt97@gmail.com','870643'),(2,'trienntfx21143@funix.edu.vn','112868');
/*!40000 ALTER TABLE `verification` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;


