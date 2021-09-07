package com.flowerchest.controller;

import java.io.Serial;
import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.flowerchest.domain.Criteria;
import com.flowerchest.domain.MemberVO;
import com.flowerchest.domain.PageDTO;
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
	public void showMemberPage() {

	}

	@PostMapping("/register")
	public String memberReg(MemberVO vo, RedirectAttributes rttr) {

		service.register(vo);

		rttr.addAttribute("msg", "success");
		return "redirect:/member/registComplete";
	}

	// get account information
	@PreAuthorize("isAuthenticated() and (principal.username == #userid)")
	@GetMapping({"/myPage","/modify","/emailAuth","/passwordChange"})
	public void memberInfo(@RequestParam("userid")String userid, Model model) {
		
		model.addAttribute("member",service.get(userid));
		
	}
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@GetMapping("/getAllUser")
	public void allMemberGet(Model model, RedirectAttributes rttr,Criteria cri) {
		
		model.addAttribute("members",service.getAll(cri));
		int total = service.getTotal(cri);
		model.addAttribute("pageMaker", new PageDTO(cri,total));
	}
	//account modify 
	@PreAuthorize("isAuthenticated() and (principal.username == #member.userid)")
	@PostMapping("/modify")
	public String modify(MemberVO member,RedirectAttributes rttr) {
		service.modify(member);
		
		rttr.addAttribute("msg","success");
		return "redirect:/member/myPage?userid="+ member.getUserid();
	}
	
	//have not password modfiy module 
	@PreAuthorize("isAuthenticated() and (principal.username == #member.userid)")
	@PostMapping("/modifyWithNotPassword")
	public String modifyWithNotPassword(MemberVO member,RedirectAttributes rttr) {
		service.modifyWithNotPassword(member);
		
		rttr.addAttribute("msg","success");
		return "redirect:/member/myPage?userid="+ member.getUserid();
	}
	
	//only password change
	@PreAuthorize("isAuthenticated() and (principal.username == #member.userid)")
	@PostMapping("/passwordChange")
	public void modifyUserPassword(MemberVO member,RedirectAttributes rttr) {
		service.modifyOnlyPassword(member);
		
		rttr.addAttribute("msg","success");		
	}
	
	//get user History
	@PreAuthorize("isAuthenticated() and (principal.username == #userid)")
	@GetMapping("/userHistory")
	public void getUserHistory(@RequestParam("userid")String userid,Model model) {
		
		model.addAttribute("userHistory",service.getWithHistory(service.get(userid)));		
	}
	//delete Account
	@PreAuthorize("isAuthenticated() and (principal.username == #userid)")
	@PostMapping("/remove")
	public String deleteAccout(@RequestParam("userid")String userid,RedirectAttributes rttr,HttpServletRequest request) {
		service.delete(userid);
		//delete login session 
		HttpSession session = request.getSession();
		session.invalidate();
		
		return "redirect:/";
	}
	
	
	// Check Id with ajax
		@GetMapping(value = "/checkId/{userid}", produces = { MediaType.APPLICATION_XML_VALUE,
				MediaType.APPLICATION_JSON_UTF8_VALUE })
		public ResponseEntity<MemberVO> chkId(@PathVariable("userid") String userId) {

			return new ResponseEntity<>(service.get(userId), HttpStatus.OK);
		}
	// email Authicate
	@RequestMapping(value = "/emailChk",method = RequestMethod.GET)
	@ResponseBody
	public String mailChkGet(String email) {
		Random random = new Random();
		int chkNum = random.nextInt(888888) + 111111;

		String setFrom = "be7884@gmail.com";
		String toMail = email;
		String title = "Sample Page Authication Email.";
		String content = "Thank you for visit Our WebSite." + "<br><br>" + "Authication number is :  " + chkNum  + "<br>"
				+ "Please Input this Authication Number.";
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
