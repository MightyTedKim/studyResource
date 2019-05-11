package com.spring.board.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.board.ReplyVO;
import com.spring.board.persistence.BoardDAO;
import com.spring.board.persistence.ReplyDAO;
import com.spring.common.pagination.Criteria;

@Service
public class ReplyServiceImpl implements ReplyService {

  @Inject
  private ReplyDAO replyDAO;
  
  @Inject
  private BoardDAO boardDAO;
  
  
  // crud
  	@Transactional
	@Override
	public void addReply(ReplyVO vo) throws Exception {
  		replyDAO.create(vo);
  		boardDAO.updateReplyCnt(vo.getBno(), 1); // transaction
	}
	@Override
	public List<ReplyVO> listReply(int bno) throws Exception {
		return replyDAO.list(bno);
	}
	@Override
	public void modifyReply(ReplyVO vo) throws Exception {
		replyDAO.update(vo);
	}
	
	@Transactional
	@Override
	public void removeReply(int rno) throws Exception {
		int bno = replyDAO.getBno(rno);// transaction
		replyDAO.delete(rno);
  		boardDAO.updateReplyCnt(bno, -1); // transaction
  	}
	
//pagination
	@Override
	public List<ReplyVO> listReplyPage(int bno, Criteria cri) throws Exception {
		return replyDAO.listPage(bno, cri);
	}
	@Override
	public int count(int bno) throws Exception {
		return replyDAO.count(bno);
	}


}