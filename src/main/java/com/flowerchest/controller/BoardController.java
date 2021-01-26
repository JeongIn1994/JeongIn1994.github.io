package com.flowerchest.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.flowerchest.domain.BoardAttachVO;
import com.flowerchest.domain.BoardVO;
import com.flowerchest.domain.Criteria;
import com.flowerchest.domain.PageDTO;
import com.flowerchest.service.BoardService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import oracle.jdbc.proxy.annotation.Post;

@Log4j
@Controller
@RequestMapping("/board/*")
@AllArgsConstructor
public class BoardController {
	
	private BoardService service;
	
	//loading post list
	@GetMapping("/list")
	public void list(Model model,Criteria cri) {
		log.info("====Board List Loading====");
		model.addAttribute("list",service.getList(cri));
		
		int total = service.getTotal(cri);
		
		
		model.addAttribute("pageMaker", new PageDTO(cri,total));
	}
	@GetMapping("/register")
	public void register() {
		
	}
	//resist post
	@PostMapping("/register")
	public String register(BoardVO board,RedirectAttributes rttr) {
		log.info("register : " + board);
		
		if(board.getAttachList()!=null) {
			board.getAttachList().forEach(attach->log.info(attach));
		}
		service.register(board);
		
		rttr.addFlashAttribute("result",board.getBno());
		
		return "redirect:/board/list";
	}
	
	//read post
	@GetMapping({"/get","/modify"})
	public void get(@RequestParam("bno")Long bno, Model model,@ModelAttribute("cri") Criteria cri) {
		log.info("====Get Board====");
		model.addAttribute("board",service.get(bno));
	}
	
	//modify post
	@PostMapping("/modify")
	public String modify(BoardVO board,RedirectAttributes rttr,@ModelAttribute("cri")Criteria cri) {
		
		log.info("====Modify Board====");
	
		if(service.modify(board)) {
			rttr.addAttribute("result","success");
		}
		

		return "redirect:/board/list" + cri.getListLink();
	}
	
	//delete post
	@PostMapping("/remove")
	public String remove(@RequestParam("bno")Long bno,RedirectAttributes rttr,@ModelAttribute("cri")Criteria cri) {
		log.info("====Delete Board====");
		
		
		List<BoardAttachVO> attachList = service.getAttachList(bno);
		if(service.remove(bno)) {
			rttr.addAttribute("result","success");
			deleteFiles(attachList);
		}

		return "redirect:/board/list" + cri.getListLink();
	}
	
	//loading attachfile
	@GetMapping(value = "/getAttachList",produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<BoardAttachVO>> getAttachList(Long bno){
		log.info("Get AttachList : " + bno );
		
		return new ResponseEntity<>(service.getAttachList(bno),HttpStatus.OK);
	}
	//delete AttachFile Function
	private void deleteFiles(List<BoardAttachVO> attachList) {
		//when attachList was empty
		if(attachList == null || attachList.size() <= 0) {
			return;
		}
		
		attachList.forEach(attach ->{
			
			try {
				Path file = Paths.get("C:\\upload\\"+attach.getUploadPath()+"\\"+attach.getUuid()+"_"+attach.getFileName());
				
				Files.deleteIfExists(file);
				//when file's type was image, delete this file of thumbnail
				if(Files.probeContentType(file).startsWith("image")) {
					Path thumbNail = Paths.get("C:\\upload\\"+attach.getUploadPath()+"\\"+attach.getUuid()+"_"+attach.getFileName());
					
					Files.delete(thumbNail);
				}
			}catch (Exception e) {
				// TODO: handle exception
				log.error(e.getMessage());
			}
		});
	}
}
