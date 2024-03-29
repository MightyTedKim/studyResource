package com.spring.drone.me;

import java.util.ArrayList;
import java.util.HashMap;

import com.spring.drone.so.SomoimVO;

public interface MemberDAOService {
	public ArrayList<MemberVO> getMemberlist();
	public int userCheck(MemberVO memberVO);
//	public int idCheck(MemberVO memberVO);
	public int insertMember(MemberVO memberVO);
	public int insertSocialMember(MemberVO memberVO);
	
	public MemberVO selectMember(MemberVO memberVO);
	public void updateMember(MemberVO memberVO);
	public void deleteMember(String id);
	}
