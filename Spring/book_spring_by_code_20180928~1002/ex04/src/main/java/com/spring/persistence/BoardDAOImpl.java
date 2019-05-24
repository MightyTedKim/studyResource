package com.spring.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.spring.domain.BoardVO;
import com.spring.domain.SearchCriteria;
import com.sun.media.jfxmedia.logging.Logger;

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
		System.out.println("List<BoardVO> listPage(int page)");
		System.out.println("session.selectList(\"BoardMapper.listPage\", page);" + session.selectList("BoardMapper.listPage", page));
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
	
}
