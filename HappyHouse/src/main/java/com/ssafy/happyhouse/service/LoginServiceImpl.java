package com.ssafy.happyhouse.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.dto.UserDto;
import com.ssafy.happyhouse.mapper.LoginMapper;

@Service
public class LoginServiceImpl implements LoginService {

	@Autowired
	LoginMapper loginMapper;
	
	@Override
	public UserDto login(String id, String pw) {
		return loginMapper.login(id, pw);
	}
	
}
