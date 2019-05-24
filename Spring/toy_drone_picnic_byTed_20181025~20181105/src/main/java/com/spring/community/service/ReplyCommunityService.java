package com.spring.community.service;

import java.util.List;

import com.spring.common.pagination.Criteria;
import com.spring.community.ReplyCommunityVO;

public interface ReplyCommunityService {

//CRUD
  public void addReply(ReplyCommunityVO vo) throws Exception;
  public List<ReplyCommunityVO> listReply(int no) throws Exception;
  public void modifyReply(ReplyCommunityVO vo) throws Exception;
  public void removeReply(int rno) throws Exception;

//pagination
  public List<ReplyCommunityVO> listReplyPage(int no, Criteria cri) throws Exception;
  public int count(int no) throws Exception;
  
}