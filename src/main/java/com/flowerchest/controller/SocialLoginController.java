package com.flowerchest.controller;



import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/Logins/*")
public class SocialLoginController {
	

	//login page
	@GetMapping("/")
	public void loginInput(String error,String logout,Model model) {
		
		if(error != null) {
			model.addAttribute("error",true);
		}
		if(logout != null) {
			
			model.addAttribute("logout",true);
		}
	}

}
