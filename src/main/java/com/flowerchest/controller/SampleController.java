package com.flowerchest.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/sample/*")
public class SampleController {
	
	@GetMapping("/all")
	public void doAll() {
		log.info("All Page Access");
	}
	
	@GetMapping("/member")
	public void doMember() {
		log.info("Member Page Access");
	}
	@GetMapping("/admin")
	public void doAdmin() {
		log.info("Admin Page Access");
	}
	
	
}
