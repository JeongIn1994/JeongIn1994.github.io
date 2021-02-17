package com.flowerchest.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.flowerchest.domain.MemberVO;
import com.flowerchest.service.MemberService;

import lombok.AllArgsConstructor;

@Controller
@RequestMapping("/member/*")
@AllArgsConstructor
public class MemberController {
	
	private MemberService service;
	
	//new account page
	@GetMapping({"/register","/conditionsOfUse","/registComplete"})
	public void memberReg() {
		
	}
	@PostMapping("/register")
	public String memberReg(MemberVO vo,RedirectAttributes rttr) {
		
		service.register(vo);
		
		rttr.addAttribute("msg","success");
		return "redirect:/member/registComplete";
	}
	
	//account modify
	@GetMapping("/modify")
	public void membermodify(){
		
	}
	
	//get account information
	@GetMapping("/get")
	public void memberInfo() {
		
	}
	
	
	//Check Id with ajax
	@GetMapping(value = "/checkId/{userid}",produces = {MediaType.APPLICATION_XML_VALUE,MediaType.APPLICATION_JSON_UTF8_VALUE} )
	public ResponseEntity<MemberVO> chkId(@PathVariable("userid")String userId){
		
		return new ResponseEntity<>(service.get(userId),HttpStatus.OK);		
	}
	
	
}
