CREATE DATABASE  IF NOT EXISTS `09_universidad_natural` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `09_universidad_natural`;
-- MySQL dump 10.13  Distrib 8.0.27, for Win64 (x86_64)
--
-- Host: localhost    Database: 06_universidad
-- ------------------------------------------------------
-- Server version	8.0.27

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


--
-- Table structure for table `alumnos`
--

DROP TABLE IF EXISTS `alumnos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alumnos` (
  `id_alumno` int unsigned NOT NULL AUTO_INCREMENT,
  `dni` varchar(9) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `apellido1` varchar(45) NOT NULL,
  `apellido2` varchar(45) NOT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `telefono` varchar(15) DEFAULT NULL,
  `direccion` varchar(100) DEFAULT NULL,
  `ciudad` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id_alumno`),
  UNIQUE KEY `id_alumno` (`id_alumno`),
  UNIQUE KEY `dni` (`dni`)
) ENGINE=InnoDB AUTO_INCREMENT=256 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alumnos`
--

LOCK TABLES `alumnos` WRITE;
/*!40000 ALTER TABLE `alumnos` DISABLE KEYS */;
INSERT INTO `alumnos` VALUES (1,'13967823S','María Isabel','Ruiz','Marques','2000-01-05','807986539','Madrid','Madrid'),(2,'37536605F','Josefa','Aparicio','Martínez','1996-09-22','691410653','Vigo','Pontevedra'),(3,'55289661F','Encarnación','Rovira','Ruano','1996-01-01','864923827','Adeje','S.C. de Tenerife'),(4,'55630078R','Amparo','García','Álvarez','1998-09-30','210857116','Villarreal','Castellón'),(5,'67278926Q','José','Abad','Valle','1996-01-28','221971051','Oleiros','La Coruña'),(6,'29143434L','Juan Carlos','Campillo','Ramos','1999-06-19','319736195','Santa Coloma de Gramanet','Barcelona'),(7,'56040749F','Alejandro','López','Villalobos','2000-04-19','77248524','Salamanca','Salamanca'),(8,'01792340L','Antonio','Ramírez','García','1998-09-25','590096477','Amposta','Tarragona'),(9,'10883513M','José','Sancho','Gutiérrez','1996-07-29','516596624','Vitoria','Álava'),(10,'03399466C','Albert','Ibáñez','Silva','2000-04-13','504467842','Madrid','Madrid'),(11,'18331564N','Dolores','López','Villaescusa','1998-03-08','935519669','Tomelloso','Ciudad Real'),(12,'96729463L','Francisco','Jaime','Oliver','1999-06-01','234663406','Murcia','Murcia'),(13,'51358931T','Juan','Arias','Guzmán','1997-12-05','38927979','Barcelona','Barcelona'),(14,'77510445P','José Antonio','González','Rueda','1997-12-04','627661233','Rubí','Barcelona'),(15,'03907044B','Alberto','Orellana','López','1998-03-05','575211893','Marín','Pontevedra'),(16,'93107230X','María Dolores','Martínez','Fernández','1998-07-28','280075149','Fuenlabrada','Madrid'),(17,'56034423Y','Julio','Rubio','Castellano','1999-06-19','144521083','Las Palmas de G. C.','Las Palmas'),(18,'96141475A','Fernando','Aguilar','Montero','1999-10-02','225224520','Burriana','Castellón'),(19,'99959236V','Roberto','Pérez','Corbacho','1997-02-16','978576407','Benalmádena','Málaga'),(20,'03209615B','María Rosario','López','Soriano','1997-04-06','565931341','Barcelona','Barcelona'),(21,'13410797A','José','Suarez','García','1997-02-20','945508089','Martorell','Barcelona'),(22,'30186195Y','Juan Francisco','Espinosa','Matilla','1997-12-16','871271911','Madrid','Madrid'),(23,'25007239Y','Alejandro','Zapata','Huerta','1997-02-15','44593794','Manises','Valencia'),(24,'40867786Y','Josefa','Burgos','Nieto','2000-03-17','5835161','Adeje','S.C. de Tenerife'),(25,'81268932L','Ana Belén','López','García','1996-03-10','709524197','Madrid','Madrid'),(26,'19312675N','José','Domingo','Plana','1997-03-19','428443570','Molina de Segura','Murcia'),(27,'04957665S','Jorge','Díaz','Martin','2000-04-18','754710333','Cornellá de Llobregat','Barcelona'),(28,'91063204V','Francisco','Rodríguez','Hussain','1997-01-17','483504476','Sevilla','Sevilla'),(29,'98142504D','María Carmen','Gracia','Muñoz','1999-08-03','394192330','Rincón de la Victoria','Málaga'),(30,'02868742K','David','Quiroga','Sarmiento','1998-04-18','138114275','Alicante','Alicante'),(31,'78527165J','Bárbara','Sosa','Tudela','1999-01-08','76440533','Almería','Almería'),(32,'38627285G','Ángel','Cruz','Sarabia','1998-03-11','209341936','Amposta','Tarragona'),(33,'47458585V','Mercedes','Luis','Rodríguez','1997-10-10','289532275','Madrid','Madrid'),(34,'64700088F','Ángeles','Rodríguez','Gómez','1997-04-11','617036073','Bilbao','Vizcaya'),(35,'41506797P','José','Carrera','Sánchez','1995-12-22','117895188','San Roque','Cádiz'),(36,'88837886H','Paula','Martin','Jorda','1997-09-01','686684206','Moguer','Huelva'),(37,'01100479K','Isabel','Martos','Muñoz','1997-08-30','985943505','Benidorm','Alicante'),(38,'35562931D','José','García','Pérez','1999-11-18','552769020','Bilbao','Vizcaya'),(39,'99158635T','Antonio','Folch','Velázquez','1998-04-29','629120120','Zarauz','Guipúzcoa'),(40,'27216801G','María Carmen','Perdomo','Sánchez','1996-12-10','978361378','Pozuelo de Alarcón','Madrid'),(41,'57805645K','Carmen','Manzanares','Díaz','1997-10-28','926785382','Granada','Granada'),(42,'03057394G','Antonia','López','Ocaña','1996-04-25','803670136','Parla','Madrid'),(43,'37137990M','María Carmen','Navarro','Muñoz','1999-02-26','928664420','Málaga','Málaga'),(44,'84552412L','Ana María','Torres','Reyes','1996-08-26','411593044','Marrachí','Islas Baleares'),(45,'04782415W','Raúl','González','Grande','1997-12-19','462288337','Málaga','Málaga'),(46,'34549931K','Sonia','Díaz','Valero','1997-04-17','79141283','Madrid','Madrid'),(47,'17578110S','José','Sanchís','Aguilera','1998-12-11','343089627','Marrachí','Islas Baleares'),(48,'99262647Y','Francisco','González','Del Rey','1996-12-20','806431646','Puente Genil','Córdoba'),(49,'86748384C','Jorge','Bazán','López','1997-02-16','234394909','Vic','Barcelona'),(50,'77322495Z','Alicia','Rey','Moya','1996-01-14','195618733','Valladolid','Valladolid'),(51,'41992625F','Ramón','Mira','Fabra','2000-02-27','607202021','Sevilla','Sevilla'),(52,'17859427L','Fernando','Díaz','Roig','1996-04-20','776270096','Sabadell','Barcelona'),(53,'53249915Q','Ginés','Ortega','Gutiérrez','1999-10-16','284313920','Badalona','Barcelona'),(54,'88906599F','Cristina','Arroyo','Valencia','2000-02-04','415533888','Salamanca','Salamanca'),(55,'28640465Z','Carmen','Domínguez','Cano','1996-04-25','336318876','Hospitalet de Llobregat','Barcelona'),(56,'83094267M','Miguel','Fernández','Fernández','1996-04-01','650253940','Barcelona','Barcelona'),(57,'32367703X','María','Gamiz','Barrero','1998-05-01','327955263','Oviedo','Asturias'),(58,'86662787Y','Miguel','Silva','González','1999-02-18','378864805','Sant Cugat del Vallés','Barcelona'),(59,'26270475J','Salvador','Osuna','Monge','1999-12-29','246834215','Zaragoza','Zaragoza'),(60,'71568595R','Manuela','Álvarez','Buendía','2000-04-24','280067111','Las Palmas de G. C.','Las Palmas'),(61,'49359539K','Pilar','Giráldez','Torre','1998-08-18','99767462','Madrid','Madrid'),(62,'52913655Q','Concepción','Ribes','Mendoza','1998-11-11','374978058','Madrid','Madrid'),(63,'54425879J','María José','Oliver','Rodríguez','1996-07-08','226676224','Albacete','Albacete'),(64,'36100596A','Francisco','Navarro','Rodríguez','1998-01-16','932046007','Elche','Alicante'),(65,'57173076K','Sergio','Rojas','Gutiérrez','1999-12-03','668788399','La Rinconada','Sevilla'),(66,'77909892Z','Antonio','Hernández','Mendoza','2000-01-17','318565796','Madrid','Madrid'),(67,'21397324X','María Mar','Delgado','Velasco','1998-08-02','33654815','León','León'),(68,'89561128W','José','Torres','Muñoz','1996-01-22','772349604','Santa Cruz de Tenerife','S.C. de Tenerife'),(69,'22110623X','Rosario','Carmona','Sola','1996-03-22','371749416','Roquetas de Mar','Almería'),(70,'91759077W','Laura','Calvo','Gallego','2000-02-17','112092749','Parla','Madrid'),(71,'38654754B','Margarita','López','Carmona','1998-06-21','784017766','La Coruña','La Coruña'),(72,'23193051N','Joaquín','Herreros','Felipe','1997-06-29','887503098','Alicante','Alicante'),(73,'58717680Z','Luis','Martínez','Fernández','1998-03-01','806399250','Barcelona','Barcelona'),(74,'64309430G','Vicente','Diez','Martínez','1997-12-01','334058143','Madrid','Madrid'),(75,'41253197Y','Silvia','Sáenz','Soler','2000-04-01','89511751','Ribeira','La Coruña'),(76,'80316988E','María Carmen','Lara','Fernández','1998-08-10','694200259','Valencia','Valencia'),(77,'23115061S','Carmen','Ferro','Da Silva','1999-01-16','384199442','Madrid','Madrid'),(78,'67247370Q','Francisco','Martínez','Rodríguez','2000-02-24','51987353','León','León'),(79,'67315169B','María','Martínez','López','1999-09-23','529965013','Estepona','Málaga'),(80,'13525176A','Irene','López','Palomo','1999-04-14','601449354','Cornellá de Llobregat','Barcelona'),(81,'79114983C','María','Soler','Martínez','1999-01-18','657852882','Madrid','Madrid'),(82,'70793791K','Antonio','Escalera','Conde','1998-07-10','86160850','Valencia','Valencia'),(83,'73911095C','Ana María','Alcaraz','González','1999-06-23','716380501','Soria','Soria'),(84,'91166850W','Mónica','Romera','Martínez','1995-12-17','835782154','Cartagena','Murcia'),(85,'62468425B','Ramón','López','Roselló','1999-07-04','432436691','Barcelona','Barcelona'),(86,'56452073E','Juan Carlos','Abella','Hernández','1997-09-16','694258035','Irun','Guipúzcoa'),(87,'28882974B','Ángel','López','Galván','1997-05-14','298972728','Avilés','Asturias'),(88,'99451653K','Mohamed','Bautista','Rodrigo','1998-04-15','432159804','Tarrasa','Barcelona'),(89,'12263241D','Juan José','Peral','Mariño','1996-12-26','520281996','Albacete','Albacete'),(90,'66236482R','Manuel','Rus','Campo','1998-12-18','995919965','Esparreguera','Barcelona'),(91,'21527341P','Joaquín','Iglesias','Navarro','2000-02-17','239941650','Collado Villalba','Madrid'),(92,'46116898N','Alberto','Cobo','López','2000-01-20','595611945','Burjasot','Valencia'),(93,'88851072W','Teresa','Carrillo','Álvarez','1996-11-15','157152385','Hospitalet de Llobregat','Barcelona'),(94,'38015437W','Laura','Grande','Medina','1998-06-29','625388094','Marrachí','Islas Baleares'),(95,'30328443E','Emilio','Postigo','Marcos','1996-07-10','468002607','Pamplona','Navarra'),(96,'66218042F','Francisca','Fraga','González','1997-02-12','263556966','Moncada y Reixach','Barcelona'),(97,'68045128L','Gerard','Matos','Martin','1999-10-25','795559177','Barcelona','Barcelona'),(98,'95784793M','José Antonio','Sánchez','Gracia','1997-08-03','743611955','Madrid','Madrid'),(99,'93282732E','José Manuel','Martínez','Palma','1996-08-26','968594835','Crevillente','Alicante'),(100,'89206628R','Juan José','Romo','Fernández','1988-11-29','710794541','Burjasot','Valencia'),(101,'34458528C','Sergi','Pardo','Diez','1987-10-09','787743053','Écija','Sevilla'),(102,'99864750S','María Carmen','Castro','Rosales','1989-07-06','569967411','Granada','Granada'),(103,'79479350K','Concepción','Torrejón','Vega','1989-01-22','739693625','Valencia','Valencia'),(104,'34486715D','Fernando','Segovia','Pons','1986-09-13','924472454','Valencia','Valencia'),(105,'19368954X','Manuel','Correa','Vera','1989-09-25','907734288','Elche','Alicante'),(106,'82278210B','María Carmen','Vives','Velasco','1989-10-05','926699669','Lugo','Lugo'),(107,'82329436Q','María Begoña','Díaz','Álvarez','1989-04-06','437685389','Huelva','Huelva'),(108,'65084966A','Juan José','Arnal','Álvarez','1988-04-28','975725655','Madrid','Madrid'),(109,'22589934R','Manuela','Martínez','León','1988-02-12','599619224','Santa Pola','Alicante'),(110,'18732591B','María','Sánchez','Cabrera','1988-03-20','611234639','Leganés','Madrid'),(111,'93981506X','María José','Martin','Muñoz','1987-08-28','216885406','Algemesí','Valencia'),(112,'59155626V','Juan Francisco','Sandoval','Menéndez','1989-03-20','619711249','Puertollano','Ciudad Real'),(113,'72734240Y','Ana María','Huertas','Carmona','1988-11-08','822545360','Vigo','Pontevedra'),(114,'72642325E','Joaquín','Rodríguez','Lillo','1989-11-16','50960880','Lorca','Murcia'),(115,'91216134C','María','Galán','Murcia','1986-03-13','565348765','Huesca','Huesca'),(116,'06039454E','Francisco','Crespo','Martos','1985-12-19','282978892','Sevilla','Sevilla'),(117,'02885664S','Ana','Crespo','Soler','1988-06-16','288460347','Sevilla','Sevilla'),(118,'60905020P','Miguel Ángel','Córdoba','Simón','1989-08-18','933936838','Albacete','Albacete'),(119,'15386820G','Josefa','Muriel','Hernando','1989-06-30','148657092','Marbella','Málaga'),(120,'75703138H','María Pilar','García','Mellado','1989-07-28','419053474','Castellón de la Plana','Castellón'),(121,'25165921B','Antonia','Martínez','López','1987-10-21','624102470','Gijón','Asturias'),(122,'41741583X','Laura','Granados','Rodríguez','1988-08-12','86465935','Ceuta','Ceuta'),(123,'57473444D','María Amparo','Pérez','Herrera','1989-03-15','25930816','Granada','Granada'),(124,'10481533L','Montserrat','Morato','Fuentes','1988-10-04','714492369','San Fernando','Cádiz'),(125,'28024659X','Julio','Gómez','Quintas','1988-02-25','341977943','Oviedo','Asturias'),(126,'03437498X','Montserrat','Núñez','Barroso','1989-05-16','67149889','Fuenlabrada','Madrid'),(127,'53263416Q','Diego','Cano','Molina','1987-05-09','198046685','Madrid','Madrid'),(128,'63325249Q','Josefa','Jaén','Álvarez','1986-03-02','158538291','Madrid','Madrid'),(129,'71867132K','Raúl','Valencia','Pérez','1986-03-17','229807644','Castro-Urdiales','Cantabria'),(130,'18812003G','Francisco','Gómez','Casado','1988-11-25','939500897','Valencia','Valencia'),(131,'76348899P','María Luisa','Aragón','Lozano','1987-03-05','782248522','Torrente','Valencia'),(132,'59914865A','Fernando','Juárez','Cobos','1987-01-15','407214137','Valencia','Valencia'),(133,'93900352T','Isabel','Palacios','Aguilar','1986-11-24','696832176','Gavá','Barcelona'),(134,'70519672Q','Francisca','Álvarez','Sarmiento','1989-09-30','574884404','Arona','S.C. de Tenerife'),(135,'45782618Z','Jorge','Martínez','Romero','1988-03-31','651314360','Sevilla','Sevilla'),(136,'51758048K','Fernando','Pérez','Fernández','1986-09-09','201013493','Alcira','Valencia'),(137,'19392226Y','José María','Díaz','Gallart','1988-02-01','957427407','Gijón','Asturias'),(138,'34921754A','Antonia','Hernández','Jiménez','1989-03-25','381999578','Sevilla','Sevilla'),(139,'97015975C','Xabier','Canosa','Sánchez','1989-08-22','641145603','Vigo','Pontevedra'),(140,'15750865M','Fernando','Fariña','Morales','1987-02-12','743770533','San Sebastián de los Reyes','Madrid'),(141,'94401971N','Dolores','Villegas','Sánchez','1988-01-22','361329973','Pozuelo de Alarcón','Madrid'),(142,'15119782L','Francisco Javier','Lago','Hernández','1989-03-25','171334968','Ibiza','Islas Baleares'),(143,'69837222E','Yolanda','Gil','García','1989-11-16','3394912','Granada','Granada'),(144,'32631418F','María Rocío','Conde','Rusu','1987-03-27','522488909','Murcia','Murcia'),(145,'56423011D','Manuela','Carazo','Jiménez','1988-03-03','896735337','Alicante','Alicante'),(146,'72731132A','Patricia','Verde','Vargas','1990-04-22','335571504','Getafe','Madrid'),(147,'47197983M','Alberto','Sánchez','Giménez','1987-06-06','305240825','Aranjuez','Madrid'),(148,'19143561V','Montserrat','Pérez','Martin','1987-12-20','779432412','Getafe','Madrid'),(149,'22191140G','Javier','Guerrero','Rodríguez','1989-02-06','62048696','Granada','Granada'),(150,'13481388F','Isabel','Morales','Fernández','1988-04-08','164033802','Hospitalet de Llobregat','Barcelona'),(151,'07164391Y','Vicente','Luque','Pérez','1988-07-13','558204249','Jerez de la Frontera','Cádiz'),(152,'61813675W','Antonio','Lozano','Illescas','1987-11-15','129576787','Arrecife','Las Palmas'),(153,'62773100M','María Pilar','Méndez','Varona','1986-02-06','438120996','Murcia','Murcia'),(154,'13541082Q','David','Jaramillo','González','1989-01-14','158108132','Zaragoza','Zaragoza'),(155,'99218686K','Raúl','Mesa','Fernández','1986-05-10','60965813','Bilbao','Vizcaya'),(156,'94697392K','Cristina','Martínez','Salgado','1987-10-10','735377548','Sevilla','Sevilla'),(157,'74053510L','Carmen','García','Ortega','1986-04-10','423481382','Madrid','Madrid'),(158,'04268480W','Jesús','Muñoz','Morales','1988-11-03','427748609','San Sebastián de los Reyes','Madrid'),(159,'60852617E','Joaquín','Jiménez','González','1989-10-21','315891416','Móstoles','Madrid'),(160,'36796011J','María Teresa','Reyes','Muñoz','1989-05-14','152199695','Olesa de Montserrat','Barcelona'),(161,'01845532N','Laura','Vázquez','Salvador','1989-11-20','48771737','Las Palmas de G. C.','Las Palmas'),(162,'28383084A','José Luis','Bosch','Lázaro','1986-03-17','556866027','Rentería','Guipúzcoa'),(163,'90618502C','Manuel','Martin','Ruiz','1986-02-11','141509172','Alcorcón','Madrid'),(164,'64466684F','Antonio','Amat','Martínez','1986-09-26','676880305','Palma de Mallorca','Islas Baleares'),(165,'70566061Z','María Jesús','Rivas','Gutiérrez','1986-04-14','587143524','Onteniente','Valencia'),(166,'97840785G','José','Iglesias','Gamero','1989-08-09','63804487','Zamora','Zamora'),(167,'81776035H','María Carmen','Navarro','Vidal','1986-09-20','927993826','Algemesí','Valencia'),(168,'39788862N','Miguel','Font','Hidalgo','1989-08-04','57642590','Calviá','Islas Baleares'),(169,'73893659H','Concepción','Rodríguez','García','1986-11-24','743265053','San Pedro del Pinatar','Murcia'),(170,'94587281B','María Carmen','Nogueira','Fernández','1988-09-21','603252988','Gerona','Gerona'),(171,'91651106Q','María Dolores','Fernández','Sánchez','1986-04-25','772421579','Bilbao','Vizcaya'),(172,'89965383D','Pedro','Martínez','Rodríguez','1989-11-01','246733389','Molina de Segura','Murcia'),(173,'38427559X','Francisco','Perdomo','Mendes','1986-05-29','736140453','Paterna','Valencia'),(174,'57141312C','María Teresa','Romero','Barreto','1985-12-21','766068381','Reus','Tarragona'),(175,'15653779W','José Manuel','Soto','Martin','1986-08-16','930035456','Sevilla','Sevilla'),(176,'94560296M','Juan','López','Gómez','1989-10-31','776058520','Getafe','Madrid'),(177,'46465058K','Miguel','Catalá','Carrascosa','1987-12-18','374793061','Los Palacios y Villafranca','Sevilla'),(178,'70900156B','María Rosario','Ruiz','Muñoz','1989-03-23','136541755','Gáldar','Las Palmas'),(179,'81902776Y','Juan Antonio','Álvarez','Esteban','1986-04-10','221156070','Barcelona','Barcelona'),(180,'62622016P','Antonio','Martínez','Mateo','1988-11-23','973089815','Fuengirola','Málaga'),(181,'01864143Q','Rafaela','Zorrilla','Navas','1986-06-17','498302131','Pinto','Madrid'),(182,'92032724H','Rocío','Marín','Mena','1986-08-24','709932437','Oviedo','Asturias'),(183,'82225055D','Jesús','Toledo','Bautista','1990-03-19','3997412','Sevilla','Sevilla'),(184,'70690972N','Miguel','Martínez','Mohamed','1986-03-19','686559173','San Felíu de Guixols','Gerona'),(185,'31165333B','Víctor','Ruiz','Quintana','1987-08-23','8647868','San Sebastián','Guipúzcoa'),(186,'66779313D','Montserrat','Muñoz','Souto','1989-06-11','985277211','Alcalá de Henares','Madrid'),(187,'70548151K','Francisco','Santos','Miranda','1988-12-05','642436475','Madrid','Madrid'),(188,'51092109R','Laura','Linares','Dios','1989-03-21','338798403','Pamplona','Navarra'),(189,'12479881N','María Jesús','Martin','Pérez','1986-03-28','655241659','Marbella','Málaga'),(190,'52359074B','Juan','Dorado','Marco','1988-04-03','400406179','Barcelona','Barcelona'),(191,'93584067B','Antonio','Piña','Mera','1987-10-12','710542749','Onda','Castellón'),(192,'44456436N','Tomas','Márquez','Miranda','1986-10-19','896656899','Gerona','Gerona'),(193,'82898682N','Eduardo','Ruiz','Martínez','1990-01-14','641596625','Caravaca de la Cruz','Murcia'),(194,'22125289W','Pilar','Carpintero','Pérez','1990-04-16','120424059','Madrid','Madrid'),(195,'10087957L','Antonio','Jiménez','López','1987-10-24','513687776','Fuenlabrada','Madrid'),(196,'76359593F','Alberto','Sanmartín','Pla','1986-08-20','676251503','Tarragona','Tarragona'),(197,'55259493S','María Jesús','Canales','González','1986-08-08','225588848','Las Palmas de G. C.','Las Palmas'),(198,'09297312E','María','Cutillas','Pérez','1987-10-23','199924860','Madrid','Madrid'),(199,'74176555Z','Javier','Cubillo','Aguirre','1989-02-17','768272990','Burgos','Burgos'),(200,'02191436L','Rafael','García','Fernández','1990-03-29','797863346','Alcalá la Real','Jaén');
/*!40000 ALTER TABLE `alumnos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `asignaturas`
--

DROP TABLE IF EXISTS `asignaturas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `asignaturas` (
  `id_asignatura` int unsigned NOT NULL AUTO_INCREMENT,
  `asignatura` varchar(45) NOT NULL,
  `creditos` int unsigned NOT NULL,
  `facultad` varchar(45) DEFAULT NULL,
  `id_profesor` int unsigned DEFAULT NULL,
  PRIMARY KEY (`id_asignatura`),
  UNIQUE KEY `id_asignatura` (`id_asignatura`),
  KEY `asignaturas_profesores_idx` (`id_profesor`),
  CONSTRAINT `asignaturas_profesores` FOREIGN KEY (`id_profesor`) REFERENCES `profesores` (`id_profesor`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asignaturas`
--

LOCK TABLES `asignaturas` WRITE;
/*!40000 ALTER TABLE `asignaturas` DISABLE KEYS */;
INSERT INTO `asignaturas` VALUES (1,'Programación I',6,'Informatica',5),(2,'Matematica Discreta',6,'Matematica',10),(3,'Programacion II',6,'Informatica',5),(4,'Fisica I',6,'Lic Fisica',20),(5,'Calculo',6,'Matematica',10),(6,'Algebra',6,'Matematica',11),(7,'Base de Datos',6,'Informatica',5),(8,'Estructura de Datos',6,'Informatica',7),(9,'Metodologias Agiles',6,'Informatica',7),(10,'Probabilidad y Estadistica',6,'Matematica',11),(11,'Logica',6,'Informatica',4),(12,'Sistemas Digitales',6,'Informatica',8),(13,'Arquitectura de Computadores',6,'Informatica',8),(14,'Redes',6,'Informatica',8),(15,'Ingenieria del Software I',6,'Informatica',7);
/*!40000 ALTER TABLE `asignaturas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notas`
--

DROP TABLE IF EXISTS `notas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notas` (
  `id_alumno` int unsigned NOT NULL,
  `id_asignatura` int unsigned NOT NULL,
  `nota` decimal(6,2) DEFAULT NULL,
  PRIMARY KEY (`id_alumno`,`id_asignatura`),
  KEY `notas_asignaturas_idx` (`id_asignatura`),
  CONSTRAINT `notas_alumnos` FOREIGN KEY (`id_alumno`) REFERENCES `alumnos` (`id_alumno`),
  CONSTRAINT `notas_asignaturas` FOREIGN KEY (`id_asignatura`) REFERENCES `asignaturas` (`id_asignatura`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notas`
--

LOCK TABLES `notas` WRITE;
/*!40000 ALTER TABLE `notas` DISABLE KEYS */;
INSERT INTO `notas` VALUES (1,1,5.00),(1,2,7.00),(1,3,5.00),(1,4,9.00),(2,1,9.00),(2,2,6.00),(2,3,5.00),(3,1,7.50),(3,2,5.20),(3,4,9.50),(4,2,5.50),(11,1,NULL),(11,2,9.00),(12,1,NULL),(13,1,NULL),(13,2,NULL),(14,1,NULL),(14,2,8.50),(15,1,NULL),(15,2,NULL),(15,3,NULL),(16,1,NULL),(16,2,NULL),(16,3,NULL),(17,2,NULL),(17,3,NULL),(19,2,NULL),(19,3,NULL),(20,2,NULL),(20,3,NULL),(21,2,8.00),(21,3,6.50),(22,3,NULL);
/*!40000 ALTER TABLE `notas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profesores`
--

DROP TABLE IF EXISTS `profesores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `profesores` (
  `id_profesor` int unsigned NOT NULL AUTO_INCREMENT,
  `dni` varchar(9) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `apellido1` varchar(50) NOT NULL,
  `apellido2` varchar(50) NOT NULL,
  `nro_cuenta` varchar(20) DEFAULT NULL,
  `telefono` varchar(9) DEFAULT NULL,
  `especialidad` varchar(20) DEFAULT NULL,
  `direccion` varchar(100) DEFAULT NULL,
  `ciudad` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id_profesor`),
  UNIQUE KEY `id_profesor` (`id_profesor`),
  UNIQUE KEY `dni` (`dni`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profesores`
--

LOCK TABLES `profesores` WRITE;
/*!40000 ALTER TABLE `profesores` DISABLE KEYS */;
INSERT INTO `profesores` VALUES (1,'01546907L','María','Ortiz','Reyes','19277','244946945','sin especialidad','Loja','Granada'),(2,'01311645R','José','Morgado','Pulido','14416','473222127','sin especialidad','Barcelona','Barcelona'),(3,'71332011H','Alba','Aguilar','Martínez','10412','786698190','sin especialidad','Pilar de la Horadada','Alicante'),(4,'97604762F','José','Moreno','Casanova','18096','688266743','sin especialidad','Los Barrios','Cádiz'),(5,'53076299G','María José','Ruiz','Barba','10123','996784692','sin especialidad','Benalmádena','Málaga'),(6,'69893542S','Luis','Sánchez','García','19469','744508743','sin especialidad','San Cristóbal de la Laguna','S.C. de Tenerife'),(7,'48739723D','Lucia','Estepa','Chinchilla','18816','174604178','sin especialidad','Madrid','Madrid'),(8,'67505622R','Alicia','Rodríguez','Ramón','12281','616900973','sin especialidad','Puertollano','Ciudad Real'),(9,'68516112D','Rosa','Jurado','Guirado','14000','149681167','sin especialidad','Madrid','Madrid'),(10,'33443900Z','María Ángeles','Roque','Pérez','15481','291833702','sin especialidad','Estepona','Málaga'),(11,'68200457Y','José Antonio','Mariño','Arrieta','18146','197710118','sin especialidad','Córdoba','Córdoba'),(12,'52844410R','Dolores','García','González','15446','129989202','sin especialidad','Gijón','Asturias'),(13,'16509078T','María Mar','Fariña','Pérez','10160','690404053','sin especialidad','Almería','Almería'),(14,'21329062N','Javier','González','Guerra','14037','947774472','sin especialidad','El Prat de Llobregat','Barcelona'),(15,'15114429W','Cristina','Cruz','Silva','15274','794078774','sin especialidad','Ciempozuelos','Madrid'),(16,'99542660V','Ignacio','Freire','López','13879','557526739','sin especialidad','Alicante','Alicante'),(17,'40543755E','Juan Manuel','López','Martínez','16237','446299362','sin especialidad','Paterna','Valencia'),(18,'35259960V','Rafael','García','Manso','13601','461947503','sin especialidad','Madrid','Madrid'),(19,'54133376R','María Antonia','Pérez','Requena','12292','760308589','sin especialidad','Leganés','Madrid'),(20,'01023843K','Marta','Velasco','Freire','11138','288335942','sin especialidad','Martos','Jaén'),(21,'90457539B','Dolores','López','Aguilar','11001','635605886','sin especialidad','Sitges','Barcelona'),(22,'49199403B','David','Conejero','Solís','18776','481488628','sin especialidad','Esplugas de Llobregat','Barcelona'),(23,'32722044J','Laura','Simón','Lorenzo','17744','427831246','sin especialidad','Leganés','Madrid'),(24,'28911991W','María','Rico','Domingo','18157','795396309','sin especialidad','Madrid','Madrid'),(25,'44731269H','María Isabel','Luque','Beltrán','15296','262048928','sin especialidad','Alcobendas','Madrid'),(26,'07255463K','Elena','Sobrino','Sánchez','17213','820363132','sin especialidad','Barcelona','Barcelona'),(27,'54732007B','María','Escribano','Chica','19379','228459432','sin especialidad','Salou','Tarragona'),(28,'20033976X','Dolores','Verdú','López','13285','957461295','sin especialidad','Madrid','Madrid'),(29,'31205937C','Josefa','Aparicio','Navarro','18016','135630005','sin especialidad','Santa Pola','Alicante'),(30,'24685230C','Alicia','Frías','Calero','12733','959818714','sin especialidad','Barcelona','Barcelona'),(31,'56295592X','Encarnación','Escobar','Sánchez','19790','15885801','sin especialidad','Andújar','Jaén'),(32,'92265945L','Rafael','García','Navas','11422','663462068','sin especialidad','Madrid','Madrid'),(33,'41340781Y','Antonio','Rojas','Calvo','18906','462807369','sin especialidad','Basauri','Vizcaya'),(34,'00385233Y','Antonio','Gómez','Hernández','16421','822181686','sin especialidad','El Puerto de Santa María','Cádiz'),(35,'55017261L','Sara','Lozano','Domínguez','11845','456185993','sin especialidad','Murcia','Murcia'),(36,'77593555L','Jesús','Roselló','Díaz','17272','267898968','sin especialidad','Burgos','Burgos'),(37,'56729562Q','Pedro','Martin','Barrio','11576','984406742','sin especialidad','Badalona','Barcelona'),(38,'81636736F','Teresa','Gómez','Ibáñez','14491','292637661','sin especialidad','Fuengirola','Málaga'),(39,'74179463R','Félix','Rodríguez','López','11156','700455162','sin especialidad','Sant Cugat del Vallés','Barcelona'),(40,'88161654D','María Carmen','Lago','Leal','11552','674909409','sin especialidad','Sevilla','Sevilla'),(41,'33763449R','Miguel','Cerro','Piñero','19087','519182600','sin especialidad','Madrid','Madrid'),(42,'43897049P','Ángel','Martínez','Peiro','18695','790284999','sin especialidad','Parla','Madrid'),(43,'02496401G','Beatriz','Linares','Cueto','13427','342771861','sin especialidad','Granada','Granada'),(44,'68096098K','Juan Manuel','Alonso','Moreno','16856','400100642','sin especialidad','Madrid','Madrid'),(45,'95649519V','Teresa','Cortes','Corpas','19434','516965729','sin especialidad','Tarrasa','Barcelona'),(46,'60061426P','José Luis','Escudero','Diez','17544','221443359','sin especialidad','Barcelona','Barcelona'),(47,'73720906H','Montserrat','Ortega','López','18438','554732548','sin especialidad','Elche','Alicante'),(48,'40213406E','José','Duran','Gómez','12422','546928460','sin especialidad','Arrecife','Las Palmas'),(49,'91769718V','María Pilar','Muñoz','Álvarez','10079','399048084','sin especialidad','Móstoles','Madrid'),(50,'71318131F','Ana Belén','Soares','Mateos','19713','659557744','sin especialidad','Moncada y Reixach','Barcelona');
/*!40000 ALTER TABLE `profesores` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

