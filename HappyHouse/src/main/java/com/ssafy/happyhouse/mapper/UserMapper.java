package com.ssafy.happyhouse.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.ssafy.happyhouse.dto.UserDto;

@Mapper
public interface UserMapper {

	public int update(UserDto dto);
	public int insert(UserDto dto);
	public UserDto userinfo(String id);
	public int delete(String id);
	
}
