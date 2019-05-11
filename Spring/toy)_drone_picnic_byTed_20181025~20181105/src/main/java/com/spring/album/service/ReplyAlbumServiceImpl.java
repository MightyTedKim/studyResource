package com.spring.album.service;

import java.util.List; 

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.album.ReplyAlbumVO;
import com.spring.album.persistence.AlbumDAO;
import com.spring.album.persistence.ReplyAlbumDAO;
import com.spring.common.pagination.Criteria;
 
@Service
public class ReplyAlbumServiceImpl implements ReplyAlbumService {

  @Inject
  private ReplyAlbumDAO replyDAO;
  
  @Inject
  private AlbumDAO albumDAO;
  
  
  // crud
  	@Transactional
	@Override
	public void addReply(ReplyAlbumVO vo) throws Exception {
  		replyDAO.create(vo);
  		albumDAO.updateReplyCnt(vo.getBno(), 1); // transaction
	}
	@Override
	public List<ReplyAlbumVO> listReply(int bno) throws Exception {
		return replyDAO.list(bno);
	}
	@Override
	public void modifyReply(ReplyAlbumVO vo) throws Exception {
		replyDAO.update(vo);
	}
	
	@Transactional
	@Override
	public void removeReply(int rno) throws Exception {
		int bno = replyDAO.getBno(rno);// transaction
		replyDAO.delete(rno);
  		albumDAO.updateReplyCnt(bno, -1); // transaction
  	}
	
//pagination
	@Override
	public List<ReplyAlbumVO> listReplyPage(int bno, Criteria cri) throws Exception {
		return replyDAO.listPage(bno, cri);
	}
	@Override
	public int count(int bno) throws Exception {
		return replyDAO.count(bno);
	}


}