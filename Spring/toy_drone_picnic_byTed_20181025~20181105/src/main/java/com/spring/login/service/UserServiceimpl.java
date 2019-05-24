package com.spring.login.service;

import java.util.Date;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.spring.login.LoginDTO;
import com.spring.login.UserVO;
import com.spring.login.controller.UserController;
import com.spring.login.persistence.UserDAO;

@Service
public class UserServiceimpl implements UserService {
	private static final Logger logger = LoggerFactory.getLogger(UserServiceimpl.class);

	@Inject
	private UserDAO dao;
	
	@Override	
	public UserVO login(LoginDTO dto) throws Exception{
		return dao.login(dto);
	}
	@Override
	public void keepLogin(String uid, String sessionId, Date next) throws Exception {
		dao.keepLogin(uid, sessionId, next);
	}	
	@Override
	public UserVO checkLoginBefore(String value) throws Exception{
		return dao.checkUserWithSessionKey(value);
	}
	@Override
	public void register(UserVO userVO) throws Exception {

		dao.register(userVO);
	}
	@Override
	public int idCheck(String uid) throws Exception {
		return dao.idCheck(uid);
	}
	@Override
	public int nickCheck(String uname) throws Exception {
		return dao.nickCheck(uname);
	}
}