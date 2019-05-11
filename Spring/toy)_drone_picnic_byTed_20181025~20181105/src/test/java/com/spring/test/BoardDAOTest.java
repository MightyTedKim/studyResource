package com.spring.test;

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

import com.spring.board.BoardVO;
import com.spring.board.persistence.BoardDAO;
import com.spring.common.search.SearchCriteria;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:spring/root-context.xml"})

public class BoardDAOTest {
	private static final Logger logger = LoggerFactory.getLogger(BoardDAOTest.class);
	
	@Inject
	private BoardDAO dao;
/*------------*/
/*    CRUD    */
/*------------*/
//C
	@Test @Ignore
	public void testCreate() throws Exception {
		logger.info("testCreate===========");
		BoardVO board = new BoardVO();
		board.setTitle("학건");
		board.setContent("학건");
		board.setWriter("user00");
		dao.create(board);
	}
//R
	@Test @Ignore
	public void testRead() throws Exception{
		logger.info("testRead===========");
		logger.info(dao.read(3079).toString());
	}
//u
	@Test
	public void testUpdate() throws Exception{
		BoardVO board = new BoardVO();
		board.setBno(3079);
		board.setTitle("수정 제목");
		board.setContent("수정 글");
		dao.update(board);
	}
//d
	@Test @Ignore
	public void testDelete() throws Exception{
		dao.delete(3079);
	}
	
/*------------------*/
/*    pagination    */
/*------------------*/
	@Test @Ignore
	public void testListPage() throws Exception{
		int page = 10;
		List<BoardVO> list = dao.listPage(page);		
		for (BoardVO boardVO : list) {
			logger.info(boardVO.getBno() + ":" + boardVO.getTitle());
		}
	}
	
	@Test
	public void testListCriteria() throws Exception{
		SearchCriteria cri = new SearchCriteria();
		cri.setPage(2);
		cri.setPerPageNum(10);
		
		List<BoardVO> list = dao.listSearch(cri);	
		logger.info("list=" + list);
		for (BoardVO boardVO : list) {
			logger.info("boardVO list =" + boardVO.getBno() + ":" + boardVO.getTitle());
		}
		
		int listCount = dao.listSearchCount(cri);
		logger.info("listCount= " + listCount);
	} 

/*-----------*/	
/*  URI test */
/*-----------*/
	@Test @Ignore
	public void testURIFormat() throws Exception{
		UriComponents uriComponents = 
				UriComponentsBuilder.newInstance()
				.path("/{module}/{page}")
				.queryParam("bno", 12)
				.queryParam("perPageNum", 20)
				.build()
				.expand("band", "read")
				.encode();
		///band/read?bno=12&perPageNum=20	
		logger.info(uriComponents.toString());
	} 
	
	@Test @Ignore
	public void testURI() throws Exception{
		UriComponents uriComponents = 
				UriComponentsBuilder.newInstance()
				.path("/board/read")
				.queryParam("bno", 12)
				.queryParam("perPageNum", 20)
				.build();
		///board/read?bno=12&perPageNum=20
		logger.info(uriComponents.toString());
		
	}
	
	@Test
	public void testDynamic1() throws Exception{
		SearchCriteria cri = new SearchCriteria();
		cri.setPage(1);
		cri.setKeyword("학건"); // keyword
		cri.setSearchType("t"); // t for title
		List<BoardVO> list = dao.listSearch(cri);
		for(BoardVO boardVO : list) {
			logger.info(boardVO.getBno() + ": " + boardVO.getTitle());
		}
		logger.info("Count = "+ dao.listSearchCount(cri));	
	} 
	
}
