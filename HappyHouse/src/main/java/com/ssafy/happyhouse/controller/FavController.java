package com.ssafy.happyhouse.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

@Controller
public class FavController {
	
	@GetMapping("/fav/regist")
	public String favRegist() {
		return "user/favRegist"; 
	}

}
