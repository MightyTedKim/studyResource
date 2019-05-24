package com.spring.board.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.spring.board.BoardVO;
import com.spring.common.search.SearchCriteria;

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
	public void update(BoardVO vo) throws Exception{
		session.update("BoardMapper.update", vo);
	}
	
	@Override
	public void delete(int bno) throws Exception{
		session.delete("BoardMapper.delete", bno);
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

	
//update
	@Override
	public void updateReplyCnt(int bno, int amount) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		
		paramMap.put("bno", bno);
		paramMap.put("amount", amount);
		
		session.update("BoardMapper.updateReplyCnt", paramMap);
	}

	@Override
	public void updateViewCnt(int bno) throws Exception {
		session.update("BoardMapper.updateViewCnt", bno);		
	}
	
//Attach
	@Override
	public void addAttach(String fullName) throws Exception {
		session.insert("BoardMapper.addAttach", fullName);	
	}

	@Override
	public List<String> getAttach(int bno) throws Exception {		
		return session.selectList("BoardMapper.getAttach",bno);
	}

	@Override
	public void deleteAttach(int bno) throws Exception {
		session.delete("BoardMapper.deleteAttach", bno);
	}

	@Override
	public void replaceAttach(String fullName, int bno) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("bno", bno);
		paramMap.put("fullName", fullName);
		session.insert("BoardMapper.replaceAttach", paramMap);		
	}
	
}
