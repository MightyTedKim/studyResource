package com.spring.album.service;

import java.util.List; 

import com.spring.album.ReplyAlbumVO;
import com.spring.common.pagination.Criteria;

public interface ReplyAlbumService {

//CRUD
  public void addReply(ReplyAlbumVO vo) throws Exception;
  public List<ReplyAlbumVO> listReply(int no) throws Exception;
  public void modifyReply(ReplyAlbumVO vo) throws Exception;
  public void removeReply(int rno) throws Exception;

//pagination
  public List<ReplyAlbumVO> listReplyPage(int no, Criteria cri) throws Exception;
  public int count(int bno) throws Exception;
  
}