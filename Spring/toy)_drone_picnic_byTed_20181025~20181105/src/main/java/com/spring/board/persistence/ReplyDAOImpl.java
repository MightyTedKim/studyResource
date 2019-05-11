package com.spring.board.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.spring.board.ReplyVO;
import com.spring.common.pagination.Criteria;

@Repository
public class ReplyDAOImpl implements ReplyDAO {

  @Inject
  private SqlSession session;

// CRUD
  @Override
  public List<ReplyVO> list(int bno) throws Exception {
    return session.selectList("ReplyMapper.list", bno);
  }
  @Override
  public void create(ReplyVO vo) throws Exception {
    session.insert("ReplyMapper.create", vo);
  }
  @Override
  public void update(ReplyVO vo) throws Exception {
    session.update("ReplyMapper.update", vo);
  }  
  @Override
  public void delete(int rno) throws Exception {
    session.update("ReplyMapper.delete", rno);
  }

//pagination
  @Override
  public List<ReplyVO> listPage(int bno, Criteria cri)
      throws Exception {
	  Map<String, Object> paramMap = new HashMap<String, Object>();
	  paramMap.put("bno", bno);
	  paramMap.put("cri", cri);
	  return session.selectList("ReplyMapper.listPage", paramMap);
  }

  @Override
  public int count(int bno) throws Exception {
	  return session.selectOne("ReplyMapper.count", bno);
  }
  
  //
	@Override
	public int getBno(int rno) throws Exception {
		System.out.println("getBno, rno = " + rno);
		return session.selectOne("ReplyMapper.getBno", rno);
	}

}

