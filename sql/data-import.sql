LOAD DATA LOCAL INFILE "C:/path/to/dbs-teamteam-project/data/sbb/sbb_region_data.csv"
INTO TABLE sbbdelay.sbbregion
FIELDS TERMINATED BY ","
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(isocode,name);

LOAD DATA LOCAL INFILE "C:/path/to/dbs-teamteam-project/data/canton/canton.csv"
INTO TABLE sbbdelay.canton
FIELDS TERMINATED BY ","
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(isocode,name,sbbregion_isocode);

LOAD DATA LOCAL INFILE "C:/path/to/dbs-teamteam-project/data/weather/weather_stations_data.csv"
INTO TABLE sbbdelay.weatherstation
FIELDS TERMINATED BY ","
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(name,isocode,altitude,canton_isocode);

LOAD DATA LOCAL INFILE "C:/path/to/dbs-teamteam-project/data/sbb/sbb_kundenpunktlichkeit_data.csv"
INTO TABLE sbbdelay.sbbdelay
FIELDS TERMINATED BY ","
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(date,sbbregion_isocode,zugpuenktlichkeit,zugpuenktlichkeit_fv,zugpuenktlichkeit_rv);

LOAD DATA LOCAL INFILE "C:/path/to/dbs-teamteam-project/data/weather/weather_stations_measurement_data.csv"
INTO TABLE sbbdelay.weatherdailymeasurement
FIELDS TERMINATED BY ","
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(weatherstation_isocode,date,globalradiation,snowdepth,cloudcover,airpressure,rainfall,sunshineduration,airtemp_mean,airtemp_min,airtemp_max,airhumidity);
