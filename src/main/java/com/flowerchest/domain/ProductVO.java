package com.flowerchest.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class ProductVO {
	private Long pid;
	private String pname;
	private String pexplain;
	private Long price;
	private String manufacturer;
	private String country;
	private Date regdate;
	private Long psize;
	private Long weight;
	private Long strck;

	private ProductAttachVO attachImage;
	
	
}
