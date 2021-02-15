package com.flowerchest.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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

}
