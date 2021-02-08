package com.flowerchest.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.flowerchest.domain.MemberVO;
import com.flowerchest.mapper.MemberMapper;
import com.flowerchest.security.domain.CustomUser;

import jdk.internal.org.jline.utils.Log;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
public class CustomUserDetailsService implements UserDetailsService {

	@Setter(onMethod_ = @Autowired)
	private MemberMapper memberMapper;
	
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		// TODO Auto-generated method stub

		log.info("Load user By userName : "+ username);
		
		MemberVO vo = memberMapper.read(username);
		
		
		return vo == null ? null : new CustomUser(vo);
	}

}
