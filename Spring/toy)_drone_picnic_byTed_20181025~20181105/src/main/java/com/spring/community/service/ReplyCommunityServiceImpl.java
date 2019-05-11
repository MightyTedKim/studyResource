package com.spring.community.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.common.pagination.Criteria;
import com.spring.community.ReplyCommunityVO;
import com.spring.community.persistence.CommunityDAO;
import com.spring.community.persistence.ReplyCommunityDAO;
 
@Service
public class ReplyCommunityServiceImpl implements ReplyCommunityService {

  @Inject
  private ReplyCommunityDAO replyDAO;
  
  @Inject
  private CommunityDAO communityDAO;
  
  
  // crud
  	@Transactional
	@Override
	public void addReply(ReplyCommunityVO vo) throws Exception {
  		replyDAO.create(vo);
  		communityDAO.updateReplyCnt(vo.getCno(), 1); // transaction
	}
	@Override
	public List<ReplyCommunityVO> listReply(int bno) throws Exception {
		return replyDAO.list(bno);
	}
	@Override
	public void modifyReply(ReplyCommunityVO vo) throws Exception {
		replyDAO.update(vo);
	}
	
	@Transactional
	@Override
	public void removeReply(int rno) throws Exception {
		int cno = replyDAO.getCno(rno);// transaction
		replyDAO.delete(rno);
		communityDAO.updateReplyCnt(cno, -1); // transaction
  	}
	
//pagination
	@Override
	public List<ReplyCommunityVO> listReplyPage(int cno, Criteria cri) throws Exception {
		return replyDAO.listPage(cno, cri);
	}
	@Override
	public int count(int cno) throws Exception {
		return replyDAO.count(cno);
	}


}