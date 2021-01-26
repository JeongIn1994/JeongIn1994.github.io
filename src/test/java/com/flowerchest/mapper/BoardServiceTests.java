package com.flowerchest.mapper;

import static org.junit.Assert.assertNotNull;

import javax.sql.rowset.serial.SerialArray;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.flowerchest.domain.BoardVO;
import com.flowerchest.domain.Criteria;
import com.flowerchest.service.BoardService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardServiceTests {

	@Setter(onMethod_ = @Autowired )
	private BoardService service;
	
	@Test
	public void testGet() {
		log.info(service.get(5L));
	}
	public void testGetList(Criteria cri) {
		
		service.getList(cri).forEach(board->log.info(board));
	}
	public void testRegist() {
		BoardVO board = new BoardVO();
		
		board.setTitle("New Board Title");
		board.setContent("New Board Content");
		board.setWriter("Newbie");
		
		service.register(board);
		
		log.info("Created Board No : " + board.getBno());
	}
	public void testExist() {
		log.info(service);
		assertNotNull(service);
	}
}
