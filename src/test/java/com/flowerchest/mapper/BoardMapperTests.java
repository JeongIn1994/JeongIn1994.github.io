package com.flowerchest.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.flowerchest.domain.BoardAttachVO;
import com.flowerchest.domain.BoardVO;
import com.flowerchest.domain.Criteria;
import com.flowerchest.service.BoardService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardMapperTests {
	@Setter(onMethod_= @Autowired )
	private BoardMapper mapper;
	
	@Setter(onMethod_= @Autowired )
	private BoardAttachMapper attachMapper;
	@Test
	public void test11() {
		
		BoardAttachVO vo = new BoardAttachVO();
		vo.setBno(4785L);
		vo.setFileName("11");
		vo.setUploadPath("22");
		vo.setUuid("33");
		
		attachMapper.insert(vo);
		
	}
	public void testPaging() {
		Criteria cri = new Criteria();
		
		cri.setPageNum(3);
		cri.setAmount(10);
		List<BoardVO>list = mapper.getListWithPaging(cri);
		
		list.forEach(board ->log.info(board));
	}
	public void updateTest() {
		BoardVO board = new BoardVO();
		board.setBno(5L);
		board.setTitle("Updated Title");
		board.setContent("Updated Content");
		board.setWriter("user00");
		
		int count = mapper.update(board);
		log.info("update count :" + count);
	}
	public void deleteTest() {
		log.info("delete count :" + mapper.delete(3L));
	}
	public void testRead() {
		BoardVO board = mapper.read(5L);
		
		log.info(board);
	}
	public void testInsert() {
		BoardVO board = new BoardVO();
		board.setTitle("New Writed Board Title");
		board.setContent("New Writed Board Content");
		board.setWriter("Newbie");
		
		mapper.insert(board);
		
		log.info(board);
	}
	public void testGetList() {
		mapper.getList().forEach(board->log.info(board));
	}
}
