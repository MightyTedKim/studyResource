package com.spring.community.persistence;

import java.util.List;

import com.spring.common.pagination.Criteria;
import com.spring.community.ReplyCommunityVO;


public interface ReplyCommunityDAO {

//CRUD
  public void create(ReplyCommunityVO vo) throws Exception;
  public List<ReplyCommunityVO> list(int no) throws Exception;
  public void update(ReplyCommunityVO vo) throws Exception;
  public void delete(int rno) throws Exception;

  //pagination
  public List<ReplyCommunityVO> listPage(
      int no, Criteria cri) throws Exception;
  public int count(int no) throws Exception;

  //
  public int getCno(int rno) throws Exception;
}
