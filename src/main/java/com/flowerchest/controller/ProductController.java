package com.flowerchest.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.flowerchest.domain.Criteria;
import com.flowerchest.domain.PageDTO;
import com.flowerchest.domain.ProductVO;
import com.flowerchest.service.ProductService;

import lombok.AllArgsConstructor;

@Controller
@AllArgsConstructor
@RequestMapping("/products/*")
public class ProductController {
	
	private ProductService pservice;
	
	//product list
	@GetMapping("/list")
	public void list(@RequestParam("category") String category,Model model,Criteria cri) {
		//when category was all, show all product
		if(category.equals("all")) {
			
			model.addAttribute("list",pservice.getList(cri));
		
			int total = pservice.getTotal(cri);
				
			model.addAttribute("pageMaker", new PageDTO(cri,total));
		}else{			
			cri.setCategory(category);
			
			int total = pservice.getToalWithCategory(cri);
						
			model.addAttribute("pageMaker", new PageDTO(cri,total));
			
			model.addAttribute("list",pservice.getListWithCategory(cri));
		}
	}
	
	@GetMapping("/register")
	public void getRegsiter() {
		
	}
	
	@PostMapping("/register")
	public String postRegist(ProductVO product,RedirectAttributes rttr) {
			
		if(product.getAttachImage()==null) {
			
		}
		pservice.register(product);
		
		rttr.addAttribute("result",product.getPid());
		
		return "redirect:/products/list?category=all";
	}
	
	
	@GetMapping({"/modify","/get"})
	public void get() {
		
	}
	

}
