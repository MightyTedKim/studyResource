package com.spring.persistence;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.spring.domain.BoardVO;

@Repository
public class BoardDAOImpl implements BoardDAO {
	@Inject
	private SqlSession session;
	
	private static String namespace = "mapper";
	
		@Override
		public void create(BoardVO vo) throws Exception{
			session.insert(namespace + ".create", vo);
		}
		
		@Override
		public BoardVO read(int bno) throws Exception{
			return session.selectOne(namespace + ".read", bno);
		}
		
		@Override
		public void update(Map map) throws Exception{
			session.update(namespace + ".update", map);
		}
		
		@Override
		public void delete(Map map) throws Exception{
			session.delete(namespace + ".delete", map);
		}
		
		@Override
		public List<BoardVO> listAll() throws Exception{
			return session.selectList(namespace + ".listAll");
		}
}