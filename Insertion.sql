Delete from weather_data0 


SELECT 'country_names0' AS table_name, COUNT(*) AS total_rows FROM country_names0
UNION ALL
SELECT 'location_names0' AS table_name, COUNT(*) AS total_rows FROM location_names0
UNION ALL
SELECT 'weather_condition_names0' AS table_name, COUNT(*) AS total_rows FROM weather_condition_names0
UNION ALL
SELECT 'air_quality_measurements0' AS table_name, COUNT(*) AS total_rows FROM air_quality_measurements0
UNION ALL
SELECT 'weather_data0' AS table_name, COUNT(*) AS total_rows FROM weather_data0;



INSERT INTO weather_data0 (
    location_id, 
    condition_id, 
    air_quality_id,
    last_updated_epoch, 
    last_updated, 
    temperature_celsius, 
    temperature_fahrenheit, 
    wind_mph, 
    wind_kph, 
    wind_degree, 
    wind_direction, 
    pressure_mb, 
    pressure_in, 
    precip_mm, 
    precip_in, 
    humidity, 
    cloud, 
    feels_like_celsius, 
    feels_like_fahrenheit, 
    visibility_km, 
    visibility_miles, 
    uv_index, 
    gust_mph, 
    gust_kph, 
    sunrise, 
    sunset, 
    moonrise, 
    moonset, 
    moon_phase, 
    moon_illumination, 
    date_only, 
    date, 
    year, 
    month, 
    day
)
SELECT 
    loc.location_id,
    cond.condition_id,
    aq.air_quality_id,
    w.last_updated_epoch, 
    w.last_updated, 
    w.temperature_celsius, 
    w.temperature_fahrenheit, 
    w.wind_mph, 
    w.wind_kph, 
    w.wind_degree, 
    w.wind_direction, 
    w.pressure_mb, 
    w.pressure_in, 
    w.precip_mm, 
    w.precip_in, 
    w.humidity, 
    w.cloud, 
    w.feels_like_celsius, 
    w.feels_like_fahrenheit, 
    w.visibility_km, 
    w.visibility_miles, 
    w.uv_index, 
    w.gust_mph, 
    w.gust_kph, 
    w.sunrise, 
    w.sunset, 
    w.moonrise, 
    w.moonset, 
    w.moon_phase, 
    w.moon_illumination, 
    w.date_only, 
    w.date, 
    w.year, 
    w.month, 
    w.day
FROM 
    weather_data1 w
JOIN 
    location_names0 loc ON w.location_name = loc.location_name  -- Direct match for location_name
JOIN 
    weather_condition_names0 cond ON w.condition_text = cond.condition_text  -- Direct match for condition_text
JOIN 
    air_quality_measurements0 aq 
    ON w.air_quality_carbon_monoxide = aq.carbon_monoxide
    AND w.air_quality_ozone = aq.ozone
    AND w.air_quality_nitrogen_dioxide = aq.nitrogen_dioxide
    AND w.air_quality_sulphur_dioxide = aq.sulphur_dioxide
    AND w.air_quality_pm25 = aq.pm25
    AND w.air_quality_pm10 = aq.pm10
    AND w.air_quality_us_epa_index = aq.us_epa_index
    AND w.air_quality_gb_defra_index = aq.gb_defra_index;

