package com.skyapi.weatherforecast.hourly;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import org.springframework.stereotype.Service;

import com.skyapi.weatherforecast.common.HourlyWeather;
import com.skyapi.weatherforecast.common.Location;
import com.skyapi.weatherforecast.location.LocationNotFoundException;
import com.skyapi.weatherforecast.location.LocationRepository;

@Service
public class HourlyWeatherService {

	private HourlyWeatherRepository hourlyWeatherRepo;
	private LocationRepository locationRepo;
	
	public HourlyWeatherService(HourlyWeatherRepository hourlyWeatherRepo, LocationRepository locationRepo) {
		super();
		this.hourlyWeatherRepo = hourlyWeatherRepo;
		this.locationRepo = locationRepo;
	}
	
	public List<HourlyWeather> getByLocation(Location location, int currentHour) {
		String countryCode = location.getCountryCode();
		String cityName = location.getCityName();
		
		Location locationInDB = locationRepo.findByCountryCodeAndCityName(countryCode, cityName);
		
		if (locationInDB == null) {
			throw new LocationNotFoundException(countryCode, cityName);
		}
		
		return hourlyWeatherRepo.findByLocationCode(locationInDB.getCode(), currentHour);
	}
	
	public List<HourlyWeather> getByLocationCode(String locationCode, int currentHour) {
		
		Location locationInDB = locationRepo.findByCode(locationCode);
		
		if (locationInDB == null) {
			throw new LocationNotFoundException(locationCode);
		}
		
		return hourlyWeatherRepo.findByLocationCode(locationCode, currentHour);
	}	

	public List<HourlyWeather> updateByLocationCode(String locationCode, List<HourlyWeather> hourlyWeatherInRequest){
		Location location = locationRepo.findByCode(locationCode);
		
		if (location == null) {
			throw new LocationNotFoundException(locationCode);
		}
		
//		Set location cho danh sách dự báo thời tiết dc yêu cầu
		for (HourlyWeather item : hourlyWeatherInRequest) {
			item.getId().setLocation(location);
		}
		
		List<HourlyWeather> hourlyWeatherInDB = location.getListHourlyWeather();
		List<HourlyWeather> hourlyWeatherToBeRemoved = new ArrayList<>();
		
//		shallow copy items trong ds đang lưu ở DB nếu có trong ds dự báo thời tiết đc yêu cầu thì lưu vào một ds tạm
		for (HourlyWeather item : hourlyWeatherInDB) {
			if (!hourlyWeatherInRequest.contains(item)) {
				hourlyWeatherToBeRemoved.add(item.getShallowCopy());
			}
		}
		
//		xoá items trong ds db trùng với ds tạm
		for (HourlyWeather item : hourlyWeatherToBeRemoved) {
			hourlyWeatherInDB.remove(item);
		}
		
//		sau dó lưu tất cả ds dc yêu cầu vào db
		return (List<HourlyWeather>) hourlyWeatherRepo.saveAll(hourlyWeatherInRequest);
	}
}
