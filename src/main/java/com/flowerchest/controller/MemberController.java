package com.flowerchest.controller;

import java.util.Random;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.flowerchest.domain.MemberVO;
import com.flowerchest.service.MemberService;

import lombok.AllArgsConstructor;

@Controller
@RequestMapping("/member/*")
@AllArgsConstructor
public class MemberController {

	@Autowired
	private MemberService service;

	@Autowired
	private JavaMailSender mailSender;

	// new account page
	@GetMapping({ "/register", "/conditionsOfUse", "/registComplete" })
	public void memberReg() {

	}

	@PostMapping("/register")
	public String memberReg(MemberVO vo, RedirectAttributes rttr) {

		service.register(vo);

		rttr.addAttribute("msg", "success");
		return "redirect:/member/registComplete";
	}

	// account modify
	@GetMapping("/modify")
	public void membermodify() {

	}

	// get account information
	@GetMapping("/get")
	public void memberInfo() {

	}

	// Check Id with ajax
	@GetMapping(value = "/checkId/{userid}", produces = { MediaType.APPLICATION_XML_VALUE,
			MediaType.APPLICATION_JSON_UTF8_VALUE })
	public ResponseEntity<MemberVO> chkId(@PathVariable("userid") String userId) {

		return new ResponseEntity<>(service.get(userId), HttpStatus.OK);
	}

	// email
	@RequestMapping(value = "/emailChk",method = RequestMethod.GET)
	@ResponseBody
	public String mailChkGet(String email) {
		Random random = new Random();
		int chkNum = random.nextInt(888888) + 111111;

		String setFrom = "be7884@gmail.com";
		String toMail = email;
		String title = "회원가입 인증 이메일 입니다.";
		String content = "홈페이지를 방문해주셔서 감사합니다." + "<br><br>" + "인증 번호는 " + chkNum + "입니다." + "<br>"
				+ "해당 인증번호를 인증번호 확인란에 기입하여 주세요.";
		try {

			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
			helper.setFrom(setFrom);
			helper.setTo(toMail);
			helper.setSubject(title);
			helper.setText(content, true);
			mailSender.send(message);

		} catch (Exception e) {
			e.printStackTrace();
		}
		String num = Integer.toString(chkNum);
		
		return num;
	}

}
