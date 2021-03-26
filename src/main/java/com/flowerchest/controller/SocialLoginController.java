package com.flowerchest.controller;



import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import jdk.internal.org.jline.utils.Log;
import lombok.extern.log4j.Log4j;

//commons login
@Controller
@Log4j
@RequestMapping("/Logins/*")
public class SocialLoginController {
	

	//login page
	@GetMapping("/login")
	public void loginInput(String error,String logout,Model model) {
		
		if(error != null) {
			model.addAttribute("error",true);
		}
		if(logout != null) {
			
			model.addAttribute("logout",true);
		}
	}
	@GetMapping("/Logout")
	public void logoutGet() {
		
		log.info("Logout!");
	}

}
