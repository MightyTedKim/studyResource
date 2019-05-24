package com.spring.test;  


import java.sql.Connection;

import javax.sql.DataSource;
import javax.inject.Inject;

import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:spring/root-context.xml"})

public class DataSourceTest { 
	private static final Logger logger = LoggerFactory.getLogger(DataSourceTest.class);

	@Inject
	private DataSource ds;
	
	@Test
	public void test() throws Exception{
		logger.info("ds="+ ds);
		try {
			Connection con = ds.getConnection();
			logger.info("con="+ con);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
}
