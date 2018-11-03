package com.spring.ex01;  


import java.sql.Connection;

import javax.sql.DataSource;
import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;

import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})

public class DataSourceTest { 
	
	@Inject
	private DataSource ds;
	
	@Test
	public void test() throws Exception{
		try {
			Connection con = ds.getConnection();
			System.out.println("con = " + con);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
}
