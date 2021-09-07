package com.flowerchest.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class ProductVO {
	private Long pid;
	private String category;
	private String pname;
	private String pexplain;
	private Long price;
	private String manufacturer;
	private String country;
	private Date regdate;
	private String psize;
	private Long weight;
	private Long stock;
	
	private String uuid;
	private String uploadPath;
	private String fileName;
	private String encodePath;
	
	private ProductAttachVO attachImage;
	
	
}
