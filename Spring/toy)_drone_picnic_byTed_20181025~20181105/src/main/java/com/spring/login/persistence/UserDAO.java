package com.spring.login.persistence;


import java.util.Date;

import com.spring.login.LoginDTO;
import com.spring.login.UserVO;

public interface UserDAO {
	public UserVO login(LoginDTO dto) throws Exception;
	public void keepLogin(String uid, String sessionId, Date next);
	public UserVO checkUserWithSessionKey(String value);
	
	public void register(UserVO userVO) throws Exception;
	
	public int idCheck(String uid) throws Exception;
	public int nickCheck(String uname) throws Exception;
	
}
