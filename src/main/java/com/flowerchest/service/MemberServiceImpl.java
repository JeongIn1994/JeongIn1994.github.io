package com.flowerchest.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.flowerchest.domain.Criteria;
import com.flowerchest.domain.MemberVO;
import com.flowerchest.mapper.MemberMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;

@Service
@AllArgsConstructor
public class MemberServiceImpl implements MemberService {

	@Setter(onMethod_ = @Autowired)
	private MemberMapper mapper;
	
	@Setter(onMethod_ = @Autowired)
	private PasswordEncoder pwencoder;
	
	//insert 
	@Transactional
	@Override
	public void register(MemberVO vo) {
		// TODO Auto-generated method stub
		
		//
		vo.setUserpw(pwencoder.encode(vo.getUserpw()));
		
		mapper.insert(vo);
	}

	@Override
	public MemberVO get(String userId) {
		// TODO Auto-generated method stub
		return mapper.read(userId);
	}

	@Override
	public void modify(MemberVO vo) {
		// TODO Auto-generated method stub
		vo.setUserpw(pwencoder.encode(vo.getUserpw()));
		
		mapper.update(vo);
	}

	@Override
	public void modifyWithNotPassword(MemberVO vo) {
		
		mapper.updateWithNotPassword(vo);
		
	}

	@Override
	public void modifyOnlyPassword(MemberVO vo) {
		// TODO Auto-generated method stub
		vo.setUserpw(pwencoder.encode(vo.getUserpw()));
		
		mapper.updateOnlyPassword(vo);
	}

	@Override
	public void delete(String userid) {
		// TODO Auto-generated method stub
		mapper.remove(userid);
	}

	@Override
	public MemberVO getWithHistory(MemberVO vo) {
		// TODO Auto-generated method stub
		return mapper.readMemberHistroy(vo);
	}

	@Override
	public List<MemberVO> getAll(Criteria cri) {
		// TODO Auto-generated method stub
		return mapper.getAllMember(cri);
	}

	@Override
	public int getTotal(Criteria cri) {
		// TODO Auto-generated method stub
		return mapper.getTotalCount(cri);
	}


}
