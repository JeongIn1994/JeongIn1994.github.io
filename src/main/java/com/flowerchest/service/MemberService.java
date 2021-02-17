package com.flowerchest.service;

import com.flowerchest.domain.MemberVO;

public interface MemberService {
	
	public void register(MemberVO vo);
	
	public MemberVO get(String userId);
}
