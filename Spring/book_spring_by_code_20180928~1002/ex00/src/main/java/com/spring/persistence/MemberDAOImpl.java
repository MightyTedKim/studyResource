package com.spring.persistence;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.spring.domain.MemberVO;

@Repository
public class MemberDAOImpl implements MemberDAO{
	
	@Inject
	private SqlSession sqlSession;
	private static final String namespace ="com.spring.mapper.MemberMapper";
	
	@Override
	public String getTime() {
		System.out.println(">MemberDAOImpl, getTime");
		return sqlSession.selectOne(namespace + ".getTime");
	}
	
	@Override
	public void insertMember(MemberVO vo) {
		System.out.println(">MemberDAOImpl, insertMember, vo = " + vo);
		sqlSession.insert(namespace + ".insertMember", vo);
	}

	@Override
	public MemberVO readMember(String userid) throws Exception {
		System.out.println(">MemberDAOImpl, readMember, userid = " + userid);
		return sqlSession.selectOne(namespace + ".selectMember", userid);
	
	}	

	@Override
	public MemberVO readWithPW(String userid, String userpw) throws Exception {
		System.out.println(">MemberDAOImpl, readWithPW");
		Map<String, String> paramMap = new HashMap<String, String>();
		
		paramMap.put("userid",  userid);
		paramMap.put("userpw",  userpw);

		return sqlSession.selectOne(namespace +".readWithPW", paramMap);
	}
}