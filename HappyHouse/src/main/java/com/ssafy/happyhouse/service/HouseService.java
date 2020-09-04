package com.ssafy.happyhouse.service;

import java.util.List;

import com.ssafy.happyhouse.dto.HouseDealDto;

public interface HouseService {
	
	public List<HouseDealDto> housedealList();
	public List<HouseDealDto> houseSearchAptName(String aptName);
	public List<HouseDealDto> houseSearchDong(String dong);
	public HouseDealDto housedealDetail(int no);
	
}
