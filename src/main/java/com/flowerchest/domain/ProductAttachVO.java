package com.flowerchest.domain;

import java.util.Date;
import lombok.Data;

@Data
public class ProductAttachVO {
	private String uuid;
	private String uploadPath;
	private String fileName;
	private String encodePath;
	
	private Long pid;

	
}
