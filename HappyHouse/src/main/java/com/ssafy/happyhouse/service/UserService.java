package com.ssafy.happyhouse.service;

import com.ssafy.happyhouse.dto.UserDto;

public interface UserService {

	public int update(UserDto dto);
	public int insert(UserDto dto);
	public UserDto userinfo(String id);
	public int delete(String id);
	
}
