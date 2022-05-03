create view weatherdailydelay (sbbregion_isocode, date, rainfall, snowfall, max_rainfall, max_snowfall, temp, zugpuenktlichkeit)
as
select delay.sbbregion_isocode,
		weather.date,
        case when (avg(weather.airtemp_mean) > 0 ) then avg(weather.rainfall) else 0 end as rainfall,
        case when (avg(weather.airtemp_mean) < 0 ) then avg(weather.rainfall) else 0 end as snowfall,
        case when (avg(weather.airtemp_mean) > 0 ) then max(weather.rainfall) else 0 end as max_rainfall,
        case when (avg(weather.airtemp_mean) < 0 ) then max(weather.rainfall) else 0 end as max_snowfall,
        avg(weather.airtemp_mean) as temp,
        delay.zugpuenktlichkeit 
	from weatherdailymeasurement as weather
	inner join weatherstation as station on weather.weatherstation_isocode = station.isocode
    inner join canton as canton on canton.isocode = station.canton_isocode
    inner join sbbdelay as delay on delay.date = weather.date and delay.sbbregion_isocode = canton.sbbregion_isocode
    where delay.`date` >= '2021-01-01'
    group by sbbregion_isocode, `date`
union
select delay2.sbbregion_isocode,
		weather2.date,
        case when (avg(weather2.airtemp_mean) > 0 ) then avg(weather2.rainfall) else 0 end as rainfall,
        case when (avg(weather2.airtemp_mean) < 0 ) then avg(weather2.rainfall) else 0 end as snowfall,
        case when (avg(weather2.airtemp_mean) > 0 ) then max(weather2.rainfall) else 0 end as max_rainfall,
        case when (avg(weather2.airtemp_mean) < 0 ) then max(weather2.rainfall) else 0 end as max_snowfall,
        avg(weather2.airtemp_mean) as temp,
        delay2.zugpuenktlichkeit
	from weatherdailymeasurement as weather2
    inner join sbbdelay as delay2 on delay2.date = weather2.date and delay2.sbbregion_isocode = 'NETZ'
    where delay2.`date` >= '2021-01-01'
    group by `date`
    order by `date`;
    
create view weatherdailydelay_withrangesteps (sbbregion_isocode, date, rainfall, snowfall, max_rainfall, max_snowfall, temp, zugpuenktlichkeit, avg_delay, rainfall_range_step, snowfall_range_step)
as
select *,
		avg(100 - zugpuenktlichkeit) as avg_delay,
        (select max(subselect.rainfall) from weatherdailydelay as subselect where subselect.sbbregion_isocode = weather.sbbregion_isocode and subselect.temp > 0) / 4 as rainfall_range_step,
        (select max(subselect.snowfall) from weatherdailydelay as subselect where subselect.sbbregion_isocode = weather.sbbregion_isocode and subselect.temp < 0) / 4 as snowfall_range_step
        from weatherdailydelay as weather
        group by weather.sbbregion_isocode, weather.date
    order by weather.date;
    
create view weatherdailydelay_snowfallinranges (sbbregion_isocode, date, rainfall, snowfall, max_rainfall, max_snowfall, temp, zugpuenktlichkeit, avg_delay, rainfall_range_step, snowfall_range_step, `range`)
as
select 	*,
        concat(snowfall_range_step * floor(snowfall / snowfall_range_step), ' mm - ', snowfall_range_step * floor(snowfall / snowfall_range_step) + snowfall_range_step, ' mm') as `range`
	from weatherdailydelay_withrangesteps
	where snowfall > 0
    group by sbbregion_isocode, `range`
    order by sbbregion_isocode, `range`;
    
create view weatherdailydelay_rainfallinranges(sbbregion_isocode, date, rainfall, snowfall, max_rainfall, max_snowfall, temp, zugpuenktlichkeit, avg_delay, rainfall_range_step, snowfall_range_step, `range`)
as
select 	*,
        concat(rainfall_range_step * floor(rainfall / rainfall_range_step), ' mm - ', rainfall_range_step * floor(rainfall / rainfall_range_step) + rainfall_range_step, ' mm') as `range`
	from weatherdailydelay_withrangesteps
	where rainfall > 0
    group by sbbregion_isocode, `range`
    order by sbbregion_isocode, `range`;
