package com.spring.drone.me;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.drone.me.MemberMapper;
import com.spring.drone.so.SomoimVO;

@Service
public class MemberDAOServiceImpl implements MemberDAOService{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public ArrayList<MemberVO> getMemberlist() {
		System.out.println(">getMemberlist ");

		ArrayList<MemberVO> member_list = new ArrayList<MemberVO>();
		MemberMapper memberMapper = sqlSession.getMapper(MemberMapper.class);
		member_list = memberMapper.getMemberlist();
		return member_list;
	}
	
	@Override
	public int insertMember(MemberVO memberVO) {
		System.out.println(">insertMember, memberVO.getId(): " + memberVO.getId());
		MemberMapper memberMapper = sqlSession.getMapper(MemberMapper.class);
		int res = memberMapper.insertMember(memberVO);
		return res;
	}
	
	@Override
	public int userCheck(MemberVO memberVO) {
		MemberMapper memberMapper = sqlSession.getMapper(MemberMapper.class);

		System.out.println(">userCheck, memberVO.getId(): " + memberVO.getId());
		int res = memberMapper.userCheck(memberVO);
		System.out.println(">res, memberVO.getId(): " + res);
		return res;
	}
	
/*	@Override
	public int idCheck(String id) {
		MemberMapper memberMapper = sqlSession.getMapper(MemberMapper.class);
		int res = memberMapper.idCheck(id);
		return res;
	}
	*/
	@Override
	public MemberVO selectMember(MemberVO memberVO) {
		System.out.println(">selectMember, memberVO.getId(): " + memberVO.getId());
		MemberMapper memberMapper = sqlSession.getMapper(MemberMapper.class);
		memberVO = memberMapper.selectMember(memberVO);
		return memberVO;
	}

	@Override
	public int insertSocialMember(MemberVO memberVO) {
		System.out.println(">insertSocialMember, memberVO.getId(): " + memberVO.getId());
		MemberMapper memberMapper = sqlSession.getMapper(MemberMapper.class);
		int res = memberMapper.insertSocialMember(memberVO);
		return res;
	}
	
	

	 @Override
	   public void deleteMember(String id) {
	      MemberMapper memberMapper = sqlSession.getMapper(MemberMapper.class);
	      memberMapper.deleteMember(id);
	   }

	   @Override
	   public void updateMember(MemberVO memberVO) {
	      MemberMapper memberMapper = sqlSession.getMapper(MemberMapper.class);
	      memberMapper.updateMember(memberVO);
	   }
	
}
