package com.ssafy.happyhouse.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.ssafy.happyhouse.dto.UserDto;

@Mapper
public interface LoginMapper {

	public UserDto login(@Param("id") String id, @Param("pw") String pw);
	
}
