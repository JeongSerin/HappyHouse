package com.ssafy.happyhouse.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ssafy.happyhouse.dto.UserDto;
import com.ssafy.happyhouse.service.LoginService;

@Controller
public class LoginController {

	@Autowired
	LoginService loginService;

	@PostMapping(value="/login")
	public String login(String id, String pw, HttpSession session) {
		
		UserDto userDto = loginService.login(id, pw);
		System.out.println(userDto);
		
		if( userDto == null ) {
			return "redirect:login?result=fail";
		}else {
			session.setAttribute("userinfo", userDto);
			session.setAttribute("userid", userDto.getId());
			return "index";
		}
	}
	
	// 로그아웃 시 세션 무효화 처리
	@RequestMapping(value="/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "index";
	}
	
}