CREATE DATABASE  IF NOT EXISTS `encuesta` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `encuesta`;
-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: localhost    Database: encuesta
-- ------------------------------------------------------
-- Server version	8.0.36

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
-- Table structure for table `iii_sexo`
--

DROP TABLE IF EXISTS `iii_sexo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `iii_sexo` (
  `clave` int NOT NULL,
  `valor` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  KEY `clave` (`clave`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `iii_sexo`
--

LOCK TABLES `iii_sexo` WRITE;
/*!40000 ALTER TABLE `iii_sexo` DISABLE KEYS */;
INSERT INTO `iii_sexo` VALUES (0,'Masculino'),(1,'Femenino');
/*!40000 ALTER TABLE `iii_sexo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permiso`
--

DROP TABLE IF EXISTS `permiso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `permiso` (
  `idpermiso` int NOT NULL AUTO_INCREMENT,
  `accion` varchar(50) NOT NULL,
  PRIMARY KEY (`idpermiso`),
  UNIQUE KEY `accion_UNIQUE` (`accion`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permiso`
--

LOCK TABLES `permiso` WRITE;
/*!40000 ALTER TABLE `permiso` DISABLE KEYS */;
INSERT INTO `permiso` VALUES (2,'actualizar_encuesta'),(3,'borrar_encuesta'),(5,'exportar_excel'),(6,'exportar_pdf'),(1,'registrar_encuesta'),(4,'ver_encuesta');
/*!40000 ALTER TABLE `permiso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `respuestas`
--

DROP TABLE IF EXISTS `respuestas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `respuestas` (
  `numero` int NOT NULL AUTO_INCREMENT,
  `I` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `II` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `III` int NOT NULL,
  `IV` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `V` int NOT NULL,
  `VI` int NOT NULL,
  `VII` int NOT NULL,
  `VIII` int NOT NULL,
  `IX` int NOT NULL,
  `X` int NOT NULL,
  `XI` int NOT NULL,
  `XII` int NOT NULL,
  `XIII` int NOT NULL,
  `XIV` int NOT NULL,
  `XV` int NOT NULL,
  `XVI` int NOT NULL,
  `XVII` int NOT NULL,
  PRIMARY KEY (`numero`) USING BTREE,
  KEY `III` (`III`) USING BTREE,
  KEY `V` (`V`) USING BTREE,
  KEY `VI` (`VI`) USING BTREE,
  KEY `VII` (`VII`) USING BTREE,
  KEY `VIII` (`VIII`) USING BTREE,
  KEY `X` (`X`) USING BTREE,
  KEY `XI` (`XI`) USING BTREE,
  KEY `XII` (`XII`) USING BTREE,
  KEY `XIII` (`XIII`) USING BTREE,
  KEY `XIV` (`XIV`) USING BTREE,
  KEY `XV` (`XV`) USING BTREE,
  KEY `XVII` (`XVII`) USING BTREE,
  KEY `respuestas_ibfk_13` (`XVI`),
  CONSTRAINT `respuestas_ibfk_1` FOREIGN KEY (`III`) REFERENCES `iii_sexo` (`clave`),
  CONSTRAINT `respuestas_ibfk_10` FOREIGN KEY (`XIV`) REFERENCES `xiv` (`clave`),
  CONSTRAINT `respuestas_ibfk_11` FOREIGN KEY (`XV`) REFERENCES `xv` (`clave`),
  CONSTRAINT `respuestas_ibfk_12` FOREIGN KEY (`XVII`) REFERENCES `xvii` (`clave`),
  CONSTRAINT `respuestas_ibfk_13` FOREIGN KEY (`XVI`) REFERENCES `xvi` (`clave`),
  CONSTRAINT `respuestas_ibfk_2` FOREIGN KEY (`V`) REFERENCES `v_departamento` (`clave`),
  CONSTRAINT `respuestas_ibfk_3` FOREIGN KEY (`VI`) REFERENCES `vi_ciudad` (`clave`),
  CONSTRAINT `respuestas_ibfk_4` FOREIGN KEY (`VII`) REFERENCES `vii_facultad` (`clave`),
  CONSTRAINT `respuestas_ibfk_5` FOREIGN KEY (`VIII`) REFERENCES `viii_carrera` (`clave`),
  CONSTRAINT `respuestas_ibfk_6` FOREIGN KEY (`X`) REFERENCES `x_matricula` (`clave`),
  CONSTRAINT `respuestas_ibfk_7` FOREIGN KEY (`XI`) REFERENCES `xi_becado` (`clave`),
  CONSTRAINT `respuestas_ibfk_8` FOREIGN KEY (`XII`) REFERENCES `xii` (`clave`),
  CONSTRAINT `respuestas_ibfk_9` FOREIGN KEY (`XIII`) REFERENCES `xiii` (`clave`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `respuestas`
--

LOCK TABLES `respuestas` WRITE;
/*!40000 ALTER TABLE `respuestas` DISABLE KEYS */;
INSERT INTO `respuestas` VALUES (1,'Benita Emelina','Avendaño Arauz',1,'2811505021015U',7,7,4,15,5,1,0,1,2,3,1,0,3);
/*!40000 ALTER TABLE `respuestas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rol`
--

DROP TABLE IF EXISTS `rol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rol` (
  `idrol` int NOT NULL AUTO_INCREMENT,
  `nombre_rol` varchar(45) NOT NULL,
  PRIMARY KEY (`idrol`),
  UNIQUE KEY `nombre_UNIQUE` (`nombre_rol`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rol`
--

LOCK TABLES `rol` WRITE;
/*!40000 ALTER TABLE `rol` DISABLE KEYS */;
INSERT INTO `rol` VALUES (1,'admin'),(2,'estudiante'),(3,'profesor');
/*!40000 ALTER TABLE `rol` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rol_permiso`
--

DROP TABLE IF EXISTS `rol_permiso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rol_permiso` (
  `idrol` int NOT NULL,
  `idpermiso` int NOT NULL,
  PRIMARY KEY (`idrol`,`idpermiso`),
  KEY `idpermiso` (`idpermiso`),
  CONSTRAINT `rol_permiso_ibfk_1` FOREIGN KEY (`idrol`) REFERENCES `rol` (`idrol`),
  CONSTRAINT `rol_permiso_ibfk_2` FOREIGN KEY (`idpermiso`) REFERENCES `permiso` (`idpermiso`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rol_permiso`
--

LOCK TABLES `rol_permiso` WRITE;
/*!40000 ALTER TABLE `rol_permiso` DISABLE KEYS */;
INSERT INTO `rol_permiso` VALUES (1,1),(2,1),(1,2),(2,2),(3,2),(1,3),(1,4),(3,4),(1,5),(3,5),(1,6),(3,6);
/*!40000 ALTER TABLE `rol_permiso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `idusuario` int NOT NULL AUTO_INCREMENT,
  `login` varchar(45) NOT NULL,
  `clave` varchar(45) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `idrol` int NOT NULL,
  PRIMARY KEY (`idusuario`),
  UNIQUE KEY `login_UNIQUE` (`login`),
  KEY `usuario_ibfk_rol` (`idrol`),
  CONSTRAINT `usuario_ibfk_rol` FOREIGN KEY (`idrol`) REFERENCES `rol` (`idrol`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (1,'Isma123','toor','Ismael Martinez',1),(2,'user123','toor','Usuario Normal',2);
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `v_departamento`
--

DROP TABLE IF EXISTS `v_departamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `v_departamento` (
  `clave` int NOT NULL,
  `valor` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  KEY `clave` (`clave`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `v_departamento`
--

LOCK TABLES `v_departamento` WRITE;
/*!40000 ALTER TABLE `v_departamento` DISABLE KEYS */;
INSERT INTO `v_departamento` VALUES (0,'Rivas'),(1,'Rio San Juan'),(2,'Nueva Segovia'),(3,'Matagalpa'),(4,'Masaya'),(5,'Managua'),(6,'Madriz'),(7,'Leon'),(8,'Jinotega'),(9,'Granada'),(10,'Esteli'),(11,'Chontales'),(12,'Chinandega'),(13,'Carazo'),(14,'Boaco'),(15,'Atlantico Sur (RAAS)'),(16,'Atlantico Norte (RAAN)');
/*!40000 ALTER TABLE `v_departamento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vi_ciudad`
--

DROP TABLE IF EXISTS `vi_ciudad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vi_ciudad` (
  `clave` int NOT NULL,
  `valor` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  KEY `clave` (`clave`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vi_ciudad`
--

LOCK TABLES `vi_ciudad` WRITE;
/*!40000 ALTER TABLE `vi_ciudad` DISABLE KEYS */;
INSERT INTO `vi_ciudad` VALUES (0,'Rivas'),(1,'Rio San Juan'),(2,'Nueva Segovia'),(3,'Matagalpa'),(4,'Masaya'),(5,'Managua'),(6,'Madriz'),(7,'Leon'),(8,'Jinotega'),(9,'Granada'),(10,'Esteli'),(11,'Chontales'),(12,'Chinandega'),(13,'Carazo'),(14,'Boaco'),(15,'Atlantico Sur (RAAS)'),(16,'Atlantico Norte (RAAN)');
/*!40000 ALTER TABLE `vi_ciudad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vii_facultad`
--

DROP TABLE IF EXISTS `vii_facultad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vii_facultad` (
  `clave` int NOT NULL,
  `valor` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  KEY `clave` (`clave`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vii_facultad`
--

LOCK TABLES `vii_facultad` WRITE;
/*!40000 ALTER TABLE `vii_facultad` DISABLE KEYS */;
INSERT INTO `vii_facultad` VALUES (0,'Ciencias Medicas'),(1,'Ciencias de la Educacion y Humanidades'),(2,'Facultad de Odontología'),(3,'Facultad de Ciencias Jurídicas y Sociales'),(4,'Facultad de Ciencia y Tecnología'),(5,'Facultad de Ciencias Ecónomicas Empresariales y Turísmo'),(6,'Facultad de Ciencias Químicas'),(7,'Escuela Ciencias Agrarías y Veterinarias');
/*!40000 ALTER TABLE `vii_facultad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `viii_carrera`
--

DROP TABLE IF EXISTS `viii_carrera`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `viii_carrera` (
  `clave` int NOT NULL,
  `valor` varchar(60) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  KEY `clave` (`clave`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `viii_carrera`
--

LOCK TABLES `viii_carrera` WRITE;
/*!40000 ALTER TABLE `viii_carrera` DISABLE KEYS */;
INSERT INTO `viii_carrera` VALUES (0,'Inglés'),(1,'Trabajo Social'),(2,'Medicina'),(3,'Psicología'),(4,'Bioanálisis Clínico'),(5,'Enfermería Profesional'),(6,'Cirujano Dentista.'),(7,'Técnico Superior en Asistente Dental.'),(8,'Ciencias Naturales'),(9,'Matemática Educativa y Computación'),(10,'Comunicación Social'),(11,'Biología'),(12,'Química'),(13,'Matemática'),(14,'Estadstica'),(15,'Ingeniería en Sistemas de Información'),(16,'Ingeniería Telemática'),(17,'Actuariales y Financieras'),(18,'Derecho'),(19,'Farmacia'),(20,'Ingeniería de Alimentos'),(21,'Economía'),(22,'Administración de Empresas'),(23,'Contaduría Pública y Finanzas'),(24,'Mercadotecnia'),(25,'Gestión de Empresas Turísticas'),(26,'Ingeniería Agroecología Tropical'),(27,'Medicina Veterinaria'),(28,'Ingeniería Acuicola');
/*!40000 ALTER TABLE `viii_carrera` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `x_matricula`
--

DROP TABLE IF EXISTS `x_matricula`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `x_matricula` (
  `clave` int NOT NULL,
  `valor` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  KEY `clave` (`clave`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `x_matricula`
--

LOCK TABLES `x_matricula` WRITE;
/*!40000 ALTER TABLE `x_matricula` DISABLE KEYS */;
INSERT INTO `x_matricula` VALUES (0,'Nuevo Ingreso'),(1,'Reingreso'),(2,'Repitente');
/*!40000 ALTER TABLE `x_matricula` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xi_becado`
--

DROP TABLE IF EXISTS `xi_becado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `xi_becado` (
  `clave` int NOT NULL,
  `valor` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  KEY `clave` (`clave`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xi_becado`
--

LOCK TABLES `xi_becado` WRITE;
/*!40000 ALTER TABLE `xi_becado` DISABLE KEYS */;
INSERT INTO `xi_becado` VALUES (0,'Externo'),(1,'Interno'),(2,'Residencia'),(3,'Sin beca');
/*!40000 ALTER TABLE `xi_becado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xii`
--

DROP TABLE IF EXISTS `xii`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `xii` (
  `clave` int NOT NULL,
  `valor` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  KEY `clave` (`clave`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xii`
--

LOCK TABLES `xii` WRITE;
/*!40000 ALTER TABLE `xii` DISABLE KEYS */;
INSERT INTO `xii` VALUES (0,'Siempre'),(1,'Algunas veces'),(2,'Casi Nunca'),(3,'Nunca');
/*!40000 ALTER TABLE `xii` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xiii`
--

DROP TABLE IF EXISTS `xiii`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `xiii` (
  `clave` int NOT NULL,
  `valor` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  KEY `clave` (`clave`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xiii`
--

LOCK TABLES `xiii` WRITE;
/*!40000 ALTER TABLE `xiii` DISABLE KEYS */;
INSERT INTO `xiii` VALUES (0,'Excelente '),(1,'Muy Bueno'),(2,'Bueno'),(3,'Regular'),(4,'Malo');
/*!40000 ALTER TABLE `xiii` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xiv`
--

DROP TABLE IF EXISTS `xiv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `xiv` (
  `clave` int NOT NULL,
  `valor` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  KEY `clave` (`clave`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xiv`
--

LOCK TABLES `xiv` WRITE;
/*!40000 ALTER TABLE `xiv` DISABLE KEYS */;
INSERT INTO `xiv` VALUES (0,'Siempre'),(1,'Casi Siempre'),(2,'Raras Veces'),(3,'Nunca');
/*!40000 ALTER TABLE `xiv` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xv`
--

DROP TABLE IF EXISTS `xv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `xv` (
  `clave` int NOT NULL,
  `valor` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  KEY `clave` (`clave`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xv`
--

LOCK TABLES `xv` WRITE;
/*!40000 ALTER TABLE `xv` DISABLE KEYS */;
INSERT INTO `xv` VALUES (0,'Mayor Comodidad'),(1,'Mayor Facilidad para Matricularse'),(2,'Ahorrar Tiempo');
/*!40000 ALTER TABLE `xv` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xvi`
--

DROP TABLE IF EXISTS `xvi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `xvi` (
  `clave` int NOT NULL,
  `valor` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  KEY `clave` (`clave`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xvi`
--

LOCK TABLES `xvi` WRITE;
/*!40000 ALTER TABLE `xvi` DISABLE KEYS */;
INSERT INTO `xvi` VALUES (0,'0 - 100 C$'),(1,'101 - 500 C$'),(2,'501 - 1000 C$'),(3,'Más de 1000 C$');
/*!40000 ALTER TABLE `xvi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xvii`
--

DROP TABLE IF EXISTS `xvii`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `xvii` (
  `clave` int NOT NULL,
  `valor` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  KEY `clave` (`clave`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xvii`
--

LOCK TABLES `xvii` WRITE;
/*!40000 ALTER TABLE `xvii` DISABLE KEYS */;
INSERT INTO `xvii` VALUES (0,'Que esté mas disponible'),(1,'Que sea mas moderno'),(2,'Que funcione con mayor Facilidad y Rapidez'),(3,'Que de mas informacion');
/*!40000 ALTER TABLE `xvii` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-08-26 16:34:03
