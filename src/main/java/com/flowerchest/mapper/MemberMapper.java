package com.flowerchest.mapper;

import com.flowerchest.domain.MemberVO;

public interface MemberMapper {

	public MemberVO read(String userid);
	
	public void insert(MemberVO vo);
	
}
