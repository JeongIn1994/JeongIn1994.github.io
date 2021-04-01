package com.flowerchest;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;

import com.flowerchest.domain.MemberVO;
import com.flowerchest.domain.ProductVO;
import com.flowerchest.mapper.MemberMapper;
import com.flowerchest.mapper.ProductMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
@Log4j
public class ProductTests {

	@Setter(onMethod_ = @Autowired)
	private ProductMapper mapper;

	@Test
	public void testReg() {

		ProductVO vo = new ProductVO();
		
		vo.setPname("test");
		vo.setCountry("test");
		vo.setManufacturer("test");
		vo.setPexplain("test");
		vo.setPrice(1000L);
		vo.setPsize(10L);
		vo.setStrck(100L);
		vo.setWeight(20L);
		


		mapper.insertSelectKey(vo);
	}
	
}
