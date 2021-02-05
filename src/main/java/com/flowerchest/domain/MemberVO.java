package com.flowerchest.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class MemberVO {
	
	private String userid;
	private String userpw;
	private String userName;
	private String address;
	private String phoneNumber;	
	private boolean enable;
	
	private Date regDate;
	private Date updateDate;
	private List<AuthVO> authList;
}
