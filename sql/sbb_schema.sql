CREATE DATABASE sbbdelay;

USE sbbdelay;

CREATE TABLE `sbbregion` (
  `key` varchar(4) NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `canton` (
  `isocode` varchar(2) NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `sbbregion_key` varchar(4) NOT NULL,
  PRIMARY KEY (`isocode`),
  KEY `fk_canton_sbbregion1_idx` (`sbbregion_key`),
  CONSTRAINT `fk_canton_sbbregion1` FOREIGN KEY (`sbbregion_key`) REFERENCES `sbbregion` (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `delay` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date` date DEFAULT NULL,
  `zugpuenktlichkeit` decimal(10,0) NOT NULL,
  `zugpuenktlichkeit_fv` decimal(10,0) NOT NULL,
  `zugpuenktlichkeit_rv` decimal(10,0) NOT NULL,
  `sbbregion_key` varchar(4) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_delay_sbbregion1_idx` (`sbbregion_key`),
  CONSTRAINT `fk_delay_sbbregion1` FOREIGN KEY (`sbbregion_key`) REFERENCES `sbbregion` (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `weatherstation` (
  `key` varchar(3) NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `altitude` decimal(10,0) DEFAULT NULL,
  `canton_isocode` varchar(2) NOT NULL,
  PRIMARY KEY (`key`),
  KEY `fk_weatherstation_canton` (`canton_isocode`),
  CONSTRAINT `fk_weatherstation_canton` FOREIGN KEY (`canton_isocode`) REFERENCES `canton` (`isocode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `weatherentry` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date` date DEFAULT NULL,
  `globalradiation` varchar(45) DEFAULT NULL,
  `snowdepth` int DEFAULT NULL,
  `cloudcover` decimal(10,0) DEFAULT NULL,
  `airpressure` decimal(10,0) DEFAULT NULL,
  `rainfall` decimal(10,0) DEFAULT NULL,
  `sunshineduration` int DEFAULT NULL,
  `airtemp_mean` decimal(10,0) DEFAULT NULL,
  `airtemp_min` decimal(10,0) DEFAULT NULL,
  `airtemp_max` decimal(10,0) DEFAULT NULL,
  `airhumidity` decimal(10,0) DEFAULT NULL,
  `weatherstation_key` varchar(3) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_weatherentry_weatherstation1` (`weatherstation_key`),
  CONSTRAINT `fk_weatherentry_weatherstation1` FOREIGN KEY (`weatherstation_key`) REFERENCES `weatherstation` (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


