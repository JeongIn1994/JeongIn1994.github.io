package com.flowerchest.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.flowerchest.domain.Criteria;

import lombok.AllArgsConstructor;

@Controller
@AllArgsConstructor
@RequestMapping("/products/*")
public class ProductController {
	
	//product list
	@GetMapping("/list")
	public void list(@RequestParam("category")Long category,Model model,Criteria cri) {
		
	}
	
	@GetMapping("/register")
	public void regsiter() {
		
	}
	
	@GetMapping({"/modify","/get"})
	public void get() {
		
	}
	

}
