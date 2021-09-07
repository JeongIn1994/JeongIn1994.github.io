package com.flowerchest.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.flowerchest.domain.AttachFileDTO;
import com.flowerchest.domain.BoardAttachVO;
import com.flowerchest.domain.BoardVO;
import com.flowerchest.domain.Criteria;
import com.flowerchest.domain.PageDTO;
import com.flowerchest.domain.ProductAttachVO;
import com.flowerchest.domain.ProductVO;
import com.flowerchest.service.ProductService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import oracle.jdbc.proxy.annotation.Post;

@Controller
@AllArgsConstructor
@Log4j
@RequestMapping("/products/*")
public class ProductController {
	
	private ProductService pservice;
	
	//product list
	@GetMapping("/list")
	public void list(@RequestParam("category") String category,Model model,Criteria cri) {
		//when category was all, show all product
		int total = pservice.getTotal(cri);
		
		if(category.equals("all")) {
			
			model.addAttribute("list",pservice.getList(cri));		
				
			model.addAttribute("pageMaker", new PageDTO(cri,total));
		}else{			
			cri.setCategory(category);
						
			model.addAttribute("pageMaker", new PageDTO(cri,total));
			
			model.addAttribute("list",pservice.getListWithCategory(cri));
		}
	}
	
	@GetMapping("/register")
	public void getRegsiter() {
		
	}
	
	@PostMapping("/register")
	public String postRegist(ProductVO product,RedirectAttributes rttr) {
			
		if(product.getAttachImage()!=null) {
			log.info(product.getAttachImage());
		}
		pservice.register(product);
		
		rttr.addAttribute("result",product.getPid());
		
		return "redirect:/products/list?category=all";
	}
	
	
	@GetMapping({"/modify","/get"})
	public void get(@RequestParam("pid")Long pid,Model model,@ModelAttribute("cri")Criteria cri) {
		
		model.addAttribute("product",pservice.get(pid));
	}	
	@PostMapping("/modify")
	public String modify(ProductVO product,RedirectAttributes rttr) {
		
		log.info("====Modify Board====");
	
		if(pservice.modify(product)) {
			rttr.addAttribute("result","success");
		}
		

		return "redirect:/products/list?category=all";
	}
	@PostMapping("/remove")
	public String remove(@RequestParam("pid")Long pid,RedirectAttributes rttr) {
		log.info("====Delete Board====");
		
		ProductAttachVO vo = pservice.get(pid).getAttachImage();
		if(pservice.remove(pid)) {
			rttr.addAttribute("result","success");
			deleteFiles(vo);
		}

		return "redirect:/products/list?category=all'";
	}
	//delete AttachFile Function
	private void deleteFiles(ProductAttachVO vo) {
		//when attachList was empty
		if(vo == null) {
			return;
		}
		
		try {
			Path file = Paths.get("C:\\upload\\"+vo.getUploadPath()+"\\"+vo.getUuid()+"_"+vo.getFileName());
			
			Files.deleteIfExists(file);
			
			if(Files.probeContentType(file).startsWith("image")) {
				Path thumbNail = Paths.get("C:\\upload\\"+vo.getUploadPath()+"\\"+vo.getUuid()+"_"+vo.getFileName());
				
				Files.delete(thumbNail);
			}
		}catch (Exception e) {
			// TODO: handle exception
			log.error(e.getMessage());
		}

	}

}
