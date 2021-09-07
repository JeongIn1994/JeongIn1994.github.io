package com.flowerchest.service;

import java.util.List;

import com.flowerchest.domain.Criteria;
import com.flowerchest.domain.MemberVO;

public interface MemberService {
	
	public void register(MemberVO vo);
	
	public MemberVO get(String userId);
	
	public MemberVO getWithHistory(MemberVO userid);

	public void modify(MemberVO vo);
	
	public void modifyWithNotPassword(MemberVO vo);
	
	public void modifyOnlyPassword(MemberVO vo);

	public void delete(String userid);

	public int getTotal(Criteria cri);

	public List<MemberVO> getAll(Criteria cri);

}
