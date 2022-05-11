CREATE DATABASE sbbdelay;

USE sbbdelay;

CREATE TABLE `sbbregion` (
  `isocode` varchar(4) NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`isocode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `canton` (
  `isocode` varchar(2) NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `sbbregion_isocode` varchar(4) NOT NULL,
  PRIMARY KEY (`isocode`),
  KEY `fk_canton_sbbregion1_idx` (`sbbregion_isocode`),
  CONSTRAINT `fk_canton_sbbregion1` FOREIGN KEY (`sbbregion_isocode`) REFERENCES `sbbregion` (`isocode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `sbbdelay` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date` date DEFAULT NULL,
  `zugpuenktlichkeit` decimal(14,10) NOT NULL,
  `zugpuenktlichkeit_fv` decimal(14,10) NOT NULL,
  `zugpuenktlichkeit_rv` decimal(14,10) NOT NULL,
  `sbbregion_isocode` varchar(4) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_sbbdelay_sbbregion1_idx` (`sbbregion_isocode`),
  CONSTRAINT `fk_sbbdelay_sbbregion1` FOREIGN KEY (`sbbregion_isocode`) REFERENCES `sbbregion` (`isocode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `weatherstation` (
  `isocode` varchar(3) NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `altitude` decimal(10,0) DEFAULT NULL,
  `canton_isocode` varchar(2) NOT NULL,
  PRIMARY KEY (`isocode`),
  KEY `fk_weatherstation_canton_idx` (`canton_isocode`),
  CONSTRAINT `fk_weatherstation_canton1` FOREIGN KEY (`canton_isocode`) REFERENCES `canton` (`isocode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `weatherdailymeasurement` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date` date DEFAULT NULL,
  `globalradiation` varchar(45) DEFAULT NULL,
  `snowdepth` int DEFAULT NULL,
  `cloudcover` decimal(10,4) DEFAULT NULL,
  `airpressure` decimal(10,4) DEFAULT NULL,
  `rainfall` decimal(10,4) DEFAULT NULL,
  `sunshineduration` int DEFAULT NULL,
  `airtemp_mean` decimal(10,4) DEFAULT NULL,
  `airtemp_min` decimal(10,4) DEFAULT NULL,
  `airtemp_max` decimal(10,4) DEFAULT NULL,
  `airhumidity` decimal(10,4) DEFAULT NULL,
  `weatherstation_isocode` varchar(3) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_weatherdailymeasurement_weatherstation_idx` (`weatherstation_isocode`),
  CONSTRAINT `fk_weatherdailymeasurement_weatherstation1` FOREIGN KEY (`weatherstation_isocode`) REFERENCES `weatherstation` (`isocode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


