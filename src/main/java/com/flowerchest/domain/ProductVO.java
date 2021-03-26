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
	private int psize;
	private int weight;
	private int strck;

	
}
