package com.spring.test;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.spring.album.persistence.AlbumDAO;
import com.spring.album.service.AlbumService;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:spring/root-context.xml"})

public class AlbumDAOTest {
	private static final Logger logger = LoggerFactory.getLogger(AlbumDAOTest.class);
	
	@Inject
	private AlbumDAO dao;
	@Inject
	private AlbumService service;

	@Test
	public void test() throws Exception{
		Map<String, Object> vo = service.read(5);
		
		logger.info("test vo0= " + vo.toString());
		logger.info("test vo0= " + vo.get("uid"));
		
		List<String> attach = service.getAttach(5);		
		logger.info("test at0= " + attach.toString());
		logger.info("test at1= " + attach.get(0));
		logger.info("test at2= " + attach.get(1));
		
	}

}
