package com.spring.board.service;

import java.util.List;

import com.spring.board.ReplyVO;
import com.spring.common.pagination.Criteria;

public interface ReplyService {

//CRUD
  public void addReply(ReplyVO vo) throws Exception;
  public List<ReplyVO> listReply(int bno) throws Exception;
  public void modifyReply(ReplyVO vo) throws Exception;
  public void removeReply(int rno) throws Exception;

//pagination
  public List<ReplyVO> listReplyPage(int bno, Criteria cri) throws Exception;
  public int count(int bno) throws Exception;
  
}