package com.spring.community.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.spring.common.pagination.Criteria;
import com.spring.community.ReplyCommunityVO;

@Repository
public class ReplyCommunityDAOImpl implements ReplyCommunityDAO {

  @Inject
  private SqlSession session;

// CRUD
  @Override
  public List<ReplyCommunityVO> list(int no) throws Exception {
    return session.selectList("ReplyMapper.list", no);
  }
  @Override
  public void create(ReplyCommunityVO vo) throws Exception {
    session.insert("ReplyMapper.create", vo);
  }
  @Override
  public void update(ReplyCommunityVO vo) throws Exception {
    session.update("ReplyMapper.update", vo);
  }  
  @Override
  public void delete(int rno) throws Exception {
    session.update("ReplyMapper.delete", rno);
  }

//pagination
  @Override
  public List<ReplyCommunityVO> listPage(int no, Criteria cri)
      throws Exception {
	  Map<String, Object> paramMap = new HashMap<String, Object>();
	  paramMap.put("cno", no);
	  paramMap.put("cri", cri);
	  return session.selectList("ReplyMapper.listPage", paramMap);
  }

  @Override
  public int count(int no) throws Exception {
	  return session.selectOne("ReplyMapper.count", no);
  }
  
  //
	@Override
	public int getCno(int cno) throws Exception {
		return session.selectOne("ReplyMapper.getBno", cno);
	}

}

