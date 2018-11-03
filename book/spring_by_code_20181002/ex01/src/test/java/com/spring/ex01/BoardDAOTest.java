package com.spring.ex01;

import java.util.List;

import javax.inject.Inject;

import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

import com.spring.domain.BoardVO;
import com.spring.domain.Criteria;
import com.spring.domain.SearchCriteria;
import com.spring.persistence.BoardDAO;
 
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})

public class BoardDAOTest {
	private static final Logger logger = LoggerFactory.getLogger(BoardDAOTest.class);
	
	@Inject
	private BoardDAO dao;

	@Test @Ignore
	public void testCreate() throws Exception {
		System.out.println(">BoardDAOTest, testCreate");
		BoardVO board = new BoardVO();
		board.setTitle("새로운 제목");
		board.setContent("새로운 내용");
		board.setWriter("user00");
		//dao.create(board);
	}

	@Test @Ignore
	public void testRead() throws Exception{
		logger.info(dao.read(2).toString());
	}
	
	@Test @Ignore
	public void testUpdate() throws Exception{
		BoardVO board = new BoardVO();
		board.setBno(1);
		board.setTitle("수정 제목");
		board.setContent("수정 글");
		//dao.update(board);
	}
	
	@Test @Ignore
	public void testDelete() throws Exception{
		//dao.delete(1);
	}
	
	@Test @Ignore
	public void testListPage() throws Exception{
		int page = 10;
		List<BoardVO> list = dao.listPage(page);
		
		for (BoardVO boardVO : list) {
			logger.info("로거 = " + boardVO.getBno() + ":" + boardVO.getTitle());
		}
	}
	
	@Test @Ignore
	public void testListCriteria() throws Exception{
		Criteria cri = new Criteria();
		cri.setPage(2);
		cri.setPerPageNum(10);
		
		List<BoardVO> list = dao.listCriteria(cri);
		
		for (BoardVO boardVO : list) {
			logger.info("로거 = " + boardVO.getBno() + ":" + boardVO.getTitle());
		}
	} 
	
	@Test @Ignore
	public void testURI() throws Exception{
		UriComponents uriComponents = 
				UriComponentsBuilder.newInstance()
				.path("/board/read")
				.queryParam("bno", 12)
				.queryParam("perPageNum", 20)
				.build();
		
		logger.info("텍스트 = board/read?bno=12&perPageNum=20");
		logger.info(uriComponents.toString());
		
	} 
	
	@Test @Ignore
	public void testURI2() throws Exception{
		UriComponents uriComponents = 
				UriComponentsBuilder.newInstance()
				.path("/{module}/{page}")
				.queryParam("bno", 12)
				.queryParam("perPageNum", 20)
				.build()
				.expand("band", "read")
				.encode();
		
		logger.info("텍스트2 = board/read?bno=12&perPageNum=20");
		logger.info(uriComponents.toString());
		
	} 
	
	
	@Test
	public void testDynamic1() throws Exception{
		SearchCriteria cri = new SearchCriteria();
		cri.setPage(1);
		cri.setKeyword("글");
		cri.setSearchType("t");
		logger.info("===============");
		List<BoardVO> list = dao.listSearch(cri);
		
		for(BoardVO boardVO : list) {
			logger.info(boardVO.getBno() + ": " + boardVO.getTitle());
		}
		logger.info("===============");
		logger.info("Count = "+ dao.listSearchCount(cri));
		
	} 
	
}
