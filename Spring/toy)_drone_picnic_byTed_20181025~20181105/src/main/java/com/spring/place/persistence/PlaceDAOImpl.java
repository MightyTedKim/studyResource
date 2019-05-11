package com.spring.place.persistence;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.spring.board.ReplyVO;
import com.spring.common.pagination.Criteria;
import com.spring.common.search.SearchCriteria;
import com.spring.place.PlaceVO;

@Repository
public class PlaceDAOImpl implements PlaceDAO{
	private static final Logger logger = LoggerFactory.getLogger(PlaceDAOImpl.class);

	@Inject
	private SqlSession session;
	
	//JSON
	@Override
	public List< Map<String, Object> > readJSON() throws Exception{
		return session.selectList("PlaceMapper.readJSON");
	}

	//crud
	@Override
	public void create(PlaceVO vo) throws Exception {
		session.insert("PlaceMapper.create", vo);
		
	} 
	
	@Override
	public PlaceVO read(int pno) throws Exception{
		return session.selectOne("PlaceMapper.read", pno);
	}
	
	@Override
	public void update(PlaceVO vo) throws Exception{
		session.update("PlaceMapper.update", vo);
	}
	
	@Override
	public void delete(int pno) throws Exception{
		session.delete("PlaceMapper.delete", pno);
	}
	
// pagination_specific_map
	@Override
	public List<PlaceVO> listPage(int page) throws Exception {
		if(page <= 0) {
			page = 1;
		}		
		page = (page - 1) * 10;
		return session.selectList("PlaceMapper.listPage", page);
	}
	
	// search
	@Override
	public List<PlaceVO> listSearch(SearchCriteria cri) throws Exception {
		return session.selectList("PlaceMapper.listSearch", cri);//error
	}
	
	@Override
	public int listSearchCount(SearchCriteria cri) throws Exception {
		return session.selectOne("PlaceMapper.listSearchCount", cri);
	}
	
	

//pagination_thumbnail_map
	  @Override
	  public List<PlaceVO> listPage(int pno, Criteria cri) throws Exception {
		  Map<String, Object> paramMap = new HashMap<String, Object>();
		  paramMap.put("pno", pno);
		  paramMap.put("cri", cri);
		  return session.selectList("PlaceMapper.listPage", paramMap);
	  }

	  @Override
	  public int count(int pno) throws Exception {
		  return session.selectOne("PlaceMapper.count", pno);
	  }


}
