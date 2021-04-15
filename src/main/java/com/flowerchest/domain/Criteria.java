package com.flowerchest.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class Criteria {

	private int pageNum;
	private int amount;
	
	private String type;
	private String keyword;
	private String category;
	
	public Criteria() {
		this(1,10);
	}

	public Criteria(int pageNum, int amount) {
		// TODO Auto-generated constructor stub
		this.pageNum = pageNum;
		this.amount = amount;
	}
	//Make ArrayList Search Conditon 
	public String[] getTypeArr() {
		
		return type == null? new String[] {}: type.split("");
	}
	public String getListLink() {
		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
				.queryParam("category", this.getCategory())				
				.queryParam("amount", this.getAmount())
				.queryParam("pageNum", this.getPageNum())
				.queryParam("type", this.getType())				
				.queryParam("keyword", this.getKeyword());
		
		return builder.toUriString();
	}
}
