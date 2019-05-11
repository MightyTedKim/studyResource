package com.spring.board.persistence;

import java.util.List;

import com.spring.board.ReplyVO;
import com.spring.common.pagination.Criteria;


public interface ReplyDAO {

//CRUD
  public void create(ReplyVO vo) throws Exception;
  public List<ReplyVO> list(int bno) throws Exception;
  public void update(ReplyVO vo) throws Exception;
  public void delete(int rno) throws Exception;

  //pagination
  public List<ReplyVO> listPage(
      int bno, Criteria cri) throws Exception;
  public int count(int bno) throws Exception;

  //
  public int getBno(int rno) throws Exception;
}
