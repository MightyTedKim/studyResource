package com.spring.persistence;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.spring.domain.MessageVO;

@Repository
public class MessageDAOImpl implements MessageDAO{

	@Inject
	private SqlSession session;
	
	@Override
	public void create(MessageVO vo) throws Exception {
		session.insert("MessageMapper.create", vo);
	}
	
	@Override
	public MessageVO readMessage(int mno) throws Exception {
		return session.selectOne("MessageMapper.readMessge", mno);
	}
	
	@Override
	public void updateState(int mno) throws Exception {
		session.update("MessageMapper.updateMessge", mno);
	}
	
	
}
