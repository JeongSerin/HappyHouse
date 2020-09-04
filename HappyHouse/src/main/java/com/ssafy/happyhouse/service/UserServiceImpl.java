package com.ssafy.happyhouse.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.dto.UserDto;
import com.ssafy.happyhouse.mapper.UserMapper;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	UserMapper userMapper;
	
	@Override
	public int update(UserDto dto) {
		return userMapper.update(dto);
	};
	
	@Override
	public int insert(UserDto dto) {
		return userMapper.insert(dto);
	}
	
	@Override
	public UserDto userinfo(String id) {
		return userMapper.userinfo(id);
	}
	
	@Override
	public int delete(String id) {
		return userMapper.delete(id);
	}
}
