package com.ssafy.happyhouse.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.dto.HouseDealDto;
import com.ssafy.happyhouse.mapper.HouseMapper;

@Service
public class HouseServiceImpl implements HouseService {
	
	@Autowired
	HouseMapper houseMapper;
	
	@Override
	public List<HouseDealDto> housedealList() {
		return houseMapper.housedealList();
	};
	
	@Override
	public HouseDealDto housedealDetail(int no) {
		return houseMapper.housedealDetail(no);
	}

	@Override
	public List<HouseDealDto> houseSearchAptName(String aptName) {
		return houseMapper.houseSearchAptName(aptName);
	}

	@Override
	public List<HouseDealDto> houseSearchDong(String dong) {
		return houseMapper.houseSearchDong(dong);
	};
}
