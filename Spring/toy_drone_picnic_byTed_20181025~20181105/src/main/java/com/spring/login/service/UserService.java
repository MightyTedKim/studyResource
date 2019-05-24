package com.spring.login.service;

import java.util.Date; 

import com.spring.login.LoginDTO;
import com.spring.login.UserVO;

public interface UserService {

  public UserVO login(LoginDTO dto) throws Exception;
  public void keepLogin(String uid, String sessionId, Date next) throws Exception;
  public UserVO checkLoginBefore(String value) throws Exception;
  
  public void register(UserVO userVO) throws Exception;
  public int idCheck(String userid) throws Exception;
  public int nickCheck(String username) throws Exception;
  
}