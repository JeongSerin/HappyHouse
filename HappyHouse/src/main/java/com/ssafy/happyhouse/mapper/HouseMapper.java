package com.ssafy.happyhouse.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ssafy.happyhouse.dto.HouseDealDto;

@Mapper
public interface HouseMapper {

	public List<HouseDealDto> housedealList();
	public List<HouseDealDto> houseSearchDong(String dong);
	public List<HouseDealDto> houseSearchAptName(String aptName);
	public HouseDealDto housedealDetail(int no);
	
}
