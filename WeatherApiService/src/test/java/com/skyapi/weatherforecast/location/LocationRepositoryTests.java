
package com.skyapi.weatherforecast.location;

import static org.assertj.core.api.Assertions.assertThat;

import java.util.Date;
import java.util.List;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase.Replace;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.test.annotation.Rollback;

import com.skyapi.weatherforecast.common.HourlyWeather;
import com.skyapi.weatherforecast.common.Location;
import com.skyapi.weatherforecast.common.RealtimeWeather;

@DataJpaTest
@AutoConfigureTestDatabase(replace = Replace.NONE)
@Rollback(false)
public class LocationRepositoryTests {
	
	@Autowired
	private LocationRepository repository;
	
	@Test
	public void testAddSuccess() {
		Location location = new Location();
		location.setCode("DELHI_IN");
		location.setCityName("DELHI");
		location.setRegionName("DELHI");
		location.setCountryCode("IN");
		location.setCountryName("India");
		location.setEnabled(true);
		
		Location savedLocation = repository.save(location);
		
		assertThat(savedLocation).isNotNull();
		assertThat(savedLocation.getCode()).isEqualTo("DELHI_IN");
		
	}
	
	
	
	@Test
	public void testGetNotFound() {
		String code = "America";
		Location location = repository.findByCode(code);
		
		assertThat(location).isNotNull();
		assertThat(location.getCode()).isEqualTo(code);
	}
	
	@Test
	public void testAddRealtimeWeatherData() {
	    String code = "NYC_USA";

	    Location location = repository.findByCode(code);
	    RealtimeWeather realtimeWeather = location.getRealtimeWeather();

	    if (realtimeWeather == null) {
	        realtimeWeather = new RealtimeWeather();
	        realtimeWeather.setLocation(location);
	        location.setRealtimeWeather(realtimeWeather);
	    }

	    realtimeWeather.setTemperature(10);
	    realtimeWeather.setHumidity(60);
	    realtimeWeather.setPrecipitation(70);
	    realtimeWeather.setStatus("Sunny");
	    realtimeWeather.setWindSpeed(10);
	    realtimeWeather.setLastUpdated(new Date());

	    Location updatedLocation = repository.save(location);

	    assertThat(updatedLocation.getRealtimeWeather().getLocationCode()).isEqualTo(code);
	}

	@Test
	public void testAddHourlyWeatherData() {
		Location location = repository.findById("NYC_USA").get();
		
		List<HourlyWeather> listHourlyWeather = location.getListHourlyWeather();
		
		HourlyWeather forecast1 = new HourlyWeather()
				.id(location, 10)
				.temperature(15)
				.precipitation(40)
				.status("Sunny");
		
		HourlyWeather forecast2 = new HourlyWeather()
				.location(location)
				.hourOfDay(11)
				.temperature(16)
				.precipitation(50)
				.status("Cloudy");

		listHourlyWeather.add(forecast1);
		listHourlyWeather.add(forecast2);
		
		Location updatedLocation = repository.save(location);
		
		assertThat(updatedLocation.getListHourlyWeather()).isNotEmpty();
	}
	
	@Test
	public void testFindByCountryCodeAndCityNotFound() {
		String countryCode = "US";
		String cityName = "New York City";
		
		Location location = repository.findByCountryCodeAndCityName(countryCode, cityName);
		
		assertThat(location).isNull();
	}
	
	@Test
	public void testFindByCountryCodeAndCityFound() {
		String countryCode = "IN";
		String cityName = "Mumbai";
		
		Location location = repository.findByCountryCodeAndCityName(countryCode, cityName);
		
		assertThat(location).isNotNull();
		assertThat(location.getCountryCode()).isEqualTo(countryCode);
		assertThat(location.getCityName()).isEqualTo(cityName);
	}
	
}
