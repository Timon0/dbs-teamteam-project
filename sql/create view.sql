create view weatherdailydelay (sbbregion_isocode, date, rainfall, temp, zugpuenktlichkeit)
as
select canton.sbbregion_isocode,
		weather.date,
        avg(weather.rainfall) as rainfall,
        avg(weather.airtemp_mean) as temp,
        delay.zugpuenktlichkeit 
	from weatherdailymeasurement as weather
	inner join weatherstation as station on weather.weatherstation_isocode = station.isocode
    inner join canton as canton on canton.isocode = station.canton_isocode
    inner join sbbdelay as delay on delay.date = weather.date and delay.sbbregion_isocode = canton.sbbregion_isocode
    where weather.date >= '2021-01-01'
    group by canton.sbbregion_isocode, weather.date
    order by weather.date;