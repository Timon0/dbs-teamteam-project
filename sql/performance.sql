create index date_index on weatherdailymeasurement(date);

create index date_sbbregion_index on sbbdelay(sbbregion_isocode, date);

create index weatherstation_canton_isocode_index on weatherstation(canton_isocode, isocode);
