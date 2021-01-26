package com.flowerchest.mapper;

import java.util.List;
import java.util.stream.IntStream;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.flowerchest.domain.Criteria;
import com.flowerchest.domain.ReplyVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ReplyMapperTest {
	
	private Long[] bnoArr = {4876L,4875L,4874L,4873L,4872L};
	@Setter(onMethod_ = {@Autowired})
	private ReplyMapper mapper;
	
	@Test
	public void testList2() {
		Criteria cri = new Criteria(3,10);
		List<ReplyVO> replies = mapper.getListWithPaging(cri, 4876L);
		
		replies.forEach(reply->log.info(reply));
	}
	public void testList() {
		Criteria cri = new Criteria();
		
		List<ReplyVO>list = mapper.getListWithPaging(cri, bnoArr[0]);
		
		list.forEach(reply->log.info(reply));
	}
	public void testCreate() {
		IntStream.rangeClosed(1, 10).forEach(i -> {
			
			ReplyVO vo = new ReplyVO();
			
			vo.setBno(bnoArr[i%5]);
			vo.setReply("Reply Test" + i);
			vo.setReplyer("replyer" + i);
			
			mapper.insert(vo);
		});
	}
	public void testMapper() {
		log.info(mapper);
	}
}
