package com.flowerchest.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.AllArgsConstructor;

@Controller
@RequestMapping("/member/*")
@AllArgsConstructor
public class MemberController {
	
	//new account page
	@GetMapping("/register")
	public void memberReg() {
		
	}
	//account modify
	@GetMapping("/modify")
	public void membermodify(){
		
	}
	
	//get account information
	@GetMapping("/get")
	public void memberInfo() {
		
	}
	
	//
	@GetMapping("/conditionsOfUse")
	public void conChk() {
		
	}
	
}
