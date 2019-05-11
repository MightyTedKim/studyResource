package com.spring.login.persistence;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.spring.login.LoginDTO;
import com.spring.login.UserVO;

@Repository
public class UserDAOImpl implements UserDAO{
	@Inject
	private SqlSession session;
	
	@Override
	public UserVO login(LoginDTO dto) throws Exception {
		return session.selectOne("UserMapper.login", dto);
	}

	@Override
	public void keepLogin(String uid, String sessionId, Date next) {	
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("uid", uid);
		paramMap.put("sessionId", sessionId);
		paramMap.put("next", next);
		session.update("UserMapper.keepLogin", paramMap);
	  }

	@Override
	public UserVO checkUserWithSessionKey(String value) {
		return session.selectOne("UserMapper.checkUserWithSessionKey", value);
	}

	@Override
	public void register(UserVO userVO) throws Exception {
		session.insert("UserMapper.register", userVO);		
	}
	
	@Override
	public int idCheck(String uid) throws Exception {
		return session.selectOne("UserMapper.idCheck", uid);	
	}	
	@Override
	public int nickCheck(String uname) throws Exception {
		return session.selectOne("UserMapper.nickCheck", uname);	
	}	
	
}
