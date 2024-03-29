package com.spring.ex00;

import javax.inject.Inject;

import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;

import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.spring.domain.MemberVO;
import com.spring.persistence.MemberDAO;
 
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})

public class MemberDAOTest {
	
	@Inject
	private MemberDAO dao;

	@Test
	public void testTime() throws Exception {
		System.out.println(">MemberDAOTest, testTime, dao.getTime() = " + dao.getTime());
	}
	
	@Test
	public void testInsertMember() throws Exception {
		System.out.println(">MemberDAOTest, testInsertMember ");
		
		MemberVO vo = new MemberVO();
		vo.setUserid("user01");
		vo.setUserpw("user01");
		vo.setUsername("USER01");
		vo.setEmail("user01@aaa.com");	
		
		dao.insertMember(vo);
	}
	
	@Test @Ignore
	public void testReadMember() throws Exception {
		System.out.println(">MemberDAOTest, testReadMember ");		
		MemberVO vo = dao.readMember("user02");
		System.out.println("###Result_testReadMember###" + vo.toString());
	}
	
	@Test @Ignore
	public void testReadWithPW() throws Exception {
		System.out.println(">MemberDAOTest, testReadMember ");
		MemberVO vo = dao.readWithPW("user02", "user02");
		System.out.println("###Result_testReadWithPW###" + vo.toString());
	}
}
