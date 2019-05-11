package com.spring.test;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.spring.login.LoginDTO;
import com.spring.login.persistence.UserDAO;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:spring/root-context.xml"})

public class LoginDAOTest {
	private static final Logger logger = LoggerFactory.getLogger(LoginDAOTest.class);
	
	@Inject
	private UserDAO dao;
//read
	@Test
	public void login() throws Exception{
		LoginDTO dto = new LoginDTO();
		dto.setUid("user01");
		dto.setUpw("user01");
		dto.setUseCookie(true);
		logger.info("--login-start----------------");
		logger.info(dao.login(dto).toString());
		logger.info("--login-end------------------");
	}
//check id, nick
	@Test
	public void Check() throws Exception{
		logger.info("--Check-start----------------");
		logger.info("id =" + String.valueOf(dao.idCheck("user01")));
		logger.info("nick =" + String.valueOf(dao.nickCheck("tedkim")));
		logger.info("--Check-end------------------");
	}
}
