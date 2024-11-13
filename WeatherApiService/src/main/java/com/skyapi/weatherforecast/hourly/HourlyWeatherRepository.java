package com.skyapi.weatherforecast.hourly;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.skyapi.weatherforecast.common.HourlyWeather;
import com.skyapi.weatherforecast.common.HourlyWeatherId;

public interface HourlyWeatherRepository extends JpaRepository<HourlyWeather, HourlyWeatherId>{
	
	@Query("""
			SELECT u FROM HourlyWeather u WHERE
			u.id.location.code = ?1 AND u.id.hourOfDay > ?2
			AND u.id.location.trashed = false
			""")
	public List<HourlyWeather> findByLocationCode(String locationCode, int currentHour);
}
