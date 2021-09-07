package com.flowerchest.domain;

import java.util.Date;
import java.util.List;


import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class MemberVO {
	
	private String userid;
	private String userpw;
	private String userName;
	private String address;
	private String phoneNumber;	
	private String email;
	private boolean enable;
	
	private Date regDate;
	private Date updateDate;
	private List<AuthVO> authList;
	private List<BoardVO> boardList;
	
}
