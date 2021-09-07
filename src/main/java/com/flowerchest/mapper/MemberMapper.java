package com.flowerchest.mapper;

import java.util.List;

import com.flowerchest.domain.Criteria;
import com.flowerchest.domain.MemberVO;

public interface MemberMapper {

	public MemberVO read(String userid);
	
	public void insert(MemberVO vo);

	public void update(MemberVO vo);
	
	public void updateWithNotPassword(MemberVO vo);

	public void updateOnlyPassword(MemberVO vo);

	public void remove(String userid);

	public MemberVO readMemberHistroy(MemberVO vo);

	public int getTotalCount(Criteria cri);

	public List<MemberVO> getAllMember(Criteria cri);
	
}
