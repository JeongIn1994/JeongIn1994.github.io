package com.flowerchest;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;

import com.flowerchest.domain.MemberVO;
import com.flowerchest.mapper.MemberMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
@Log4j
public class MemberTests {

	@Setter(onMethod_ = @Autowired)
	private MemberMapper mapper;

	@Test
	public void testRead() {

		MemberVO vo = mapper.read("user02");

		log.info(vo);

		vo.getAuthList().forEach(authVO -> log.info(authVO));
	}
	
	public void testReg() {
		
		MemberVO vo = new MemberVO();
		vo.setAddress("test");
		vo.setPhoneNumber("1234");
		vo.setUserid("test");
		vo.setUserpw("1234");
		vo.setUserName("test");
		
		mapper.insert(vo);
	}
}
