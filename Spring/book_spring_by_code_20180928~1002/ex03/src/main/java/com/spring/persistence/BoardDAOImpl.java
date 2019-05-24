package com.spring.persistence;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.spring.domain.BoardVO;
import com.spring.domain.SearchCriteria;

@Repository
public class BoardDAOImpl implements BoardDAO {
	@Inject
	private SqlSession session;

	//crud
	@Override
	public void create(BoardVO vo) throws Exception{
		session.insert("BoardMapper.create", vo);
	}
	
	@Override
	public BoardVO read(int bno) throws Exception{
		return session.selectOne("BoardMapper.read", bno);
	}
	
	@Override
	public void update(Map map) throws Exception{
		session.update("BoardMapper.update", map);
	}
	
	@Override
	public void delete(Map map) throws Exception{
		session.delete("BoardMapper.delete", map);
	}
	
// pagination
	@Override
	public List<BoardVO> listPage(int page) throws Exception {
		if(page <= 0) {
			page = 1;
		}		
		page = (page - 1) * 10;
		return session.selectList("BoardMapper.listPage", page);
	}

// search
	@Override
	public List<BoardVO> listSearch(SearchCriteria cri) throws Exception {
		return session.selectList("BoardMapper.listSearch", cri);
	}

	@Override
	public int listSearchCount(SearchCriteria cri) throws Exception {
		return session.selectOne("BoardMapper.listSearchCount", cri);
	}
}
