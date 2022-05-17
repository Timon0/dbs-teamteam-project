create index date_index on weatherdailymeasurement(date);

create index date_sbbregion_index on sbbdelay(sbbregion_isocode, date);
