package com.ssafy.happyhouse.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.happyhouse.dto.HouseDealDto;
import com.ssafy.happyhouse.service.HouseService;

@RestController
public class HouseController {

	@Autowired
	HouseService houseService;
	
	@PostMapping(value="/housedealList")
	public List<HouseDealDto> housedealList() {
		return houseService.housedealList();
	}

	@GetMapping(value="/housedealDetail/{no}")
	public HouseDealDto housedealDetail(@PathVariable int no) {
		System.out.println(houseService.housedealDetail(no));
		return houseService.housedealDetail(no);
	}
	
}
