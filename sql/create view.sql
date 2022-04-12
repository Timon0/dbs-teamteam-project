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
    
create view weatherdailysnowdelay (sbbregion_isocode, date, rainfall, snowdepth, temp, zugpuenktlichkeit)
as
select canton.sbbregion_isocode,
		weather.date,
        avg(weather.rainfall) as rainfall,
		avg(weather.snowdepth) as snowdepth,
        avg(weather.airtemp_mean) as temp,
        delay.zugpuenktlichkeit 
	from weatherdailymeasurement as weather
	inner join weatherstation as station on weather.weatherstation_isocode = station.isocode
    inner join canton as canton on canton.isocode = station.canton_isocode
    inner join sbbdelay as delay on delay.date = weather.date and delay.sbbregion_isocode = canton.sbbregion_isocode
    where weather.date >= '2021-01-01'
    group by canton.sbbregion_isocode, weather.date
    order by weather.date;  
    
        
create view weatherdailydelay_groupedbysnowfall (sbbregion_isocode, date, rainfall, temp, zugpuenktlichkeit, range_step)
as
select canton.sbbregion_isocode,
		weather.date,
        avg(weather.rainfall) as rainfall,
        avg(weather.airtemp_mean) as temp,
        delay.zugpuenktlichkeit,
        (select max(subselect.rainfall) from weatherdailydelay as subselect where subselect.sbbregion_isocode = canton.sbbregion_isocode and temp < 0) / 5 as range_step
	from weatherdailymeasurement as weather
	inner join weatherstation as station on weather.weatherstation_isocode = station.isocode
    inner join canton as canton on canton.isocode = station.canton_isocode
    inner join sbbdelay as delay on delay.date = weather.date and delay.sbbregion_isocode = canton.sbbregion_isocode
    where weather.date >= '2021-01-01'
    group by canton.sbbregion_isocode, weather.date
    order by weather.date;
