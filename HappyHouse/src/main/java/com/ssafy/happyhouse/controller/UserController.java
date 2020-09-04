package com.ssafy.happyhouse.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ssafy.happyhouse.dto.NoticeDto;
import com.ssafy.happyhouse.dto.UserDto;
import com.ssafy.happyhouse.service.LoginService;
import com.ssafy.happyhouse.service.UserService;

@Controller
public class UserController {

	@Autowired
	UserService userService;
	LoginService loginService;
	
	@GetMapping(value="/")
	public String mainPage() {
		return "index";
	}
	
	// 회원가입 페이지 가져오기
	@GetMapping(value="/mvjoin")
	public String mvJoin() {
		return "user/join";
	}
	
	// 회원가입
	@ResponseBody
	@PostMapping(value="/join")
	public int insert(@RequestBody UserDto dto) {
		System.out.println(dto);
		return userService.insert(dto);
	}
	
	// 비밀번호 찾기 페이지 가져오기
	@GetMapping(value="/findpwd")
	public String findPwd() {
		return "user/findpwd";
	}
	
	// 마이페이지 가져오기
	@GetMapping(value="/mypage")
	public String mvMypage() {
		return "user/mypage";
	}
	
	// 개인정보 가져오기
	@ResponseBody
	@GetMapping(value="/userinfo/{id}")
	public UserDto userInfo(@PathVariable String id) {
		return userService.userinfo(id);
	}

	// 개인정보 수정 페이지 가져오기
	@GetMapping(value="/edit")
	public String mvMypageEdit() {
		return "user/mypageEdit";
	}
	
	// 개인정보 수정
	@ResponseBody
	@PutMapping(value="/useredit/{id}")
	public int update(@PathVariable String id, @RequestBody UserDto dto, HttpSession session) {
		System.out.println(dto);
		int result = userService.update(dto);
		UserDto newUserDto = loginService.login(dto.getId(), dto.getPw());
		session.setAttribute("userinfo", newUserDto);
		return result;
	}
	// 수정
//	@ResponseBody
//	@PutMapping(value="/useredit/{id}")
//	public ResponseEntity<Integer> update(@PathVariable String id, @RequestBody UserDto dto, HttpSession session) {
//		System.out.println(dto);
//		int result = userService.update(dto);
//		return new ResponseEntity<Integer>(result, HttpStatus.OK);
//	}
//	
	
	
	// 회원 탈퇴
	@ResponseBody
	@DeleteMapping(value="/removeuser/{id}")
	public int delete(@PathVariable String id) {
		System.out.println(id);
		int result = userService.delete(id);
		return result;
	}
}
