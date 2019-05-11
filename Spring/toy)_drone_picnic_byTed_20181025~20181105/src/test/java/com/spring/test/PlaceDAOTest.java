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

import com.spring.place.PlaceVO;
import com.spring.place.persistence.PlaceDAO;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:spring/root-context.xml"})

public class PlaceDAOTest {
	private static final Logger logger = LoggerFactory.getLogger(PlaceDAOTest.class);
	
	@Inject
	private PlaceDAO dao;

//read 
	//pagination
	@Test
	public void place_json() throws Exception{	
		for (PlaceVO vo : dao.readJSON()) {
			logger.info(vo.getPno() + ":" + vo.getPname());
		}
	}


}
