package com.spring.album.persistence;

import java.util.List;

import com.spring.album.ReplyAlbumVO;
import com.spring.common.pagination.Criteria;


public interface ReplyAlbumDAO {

//CRUD
  public void create(ReplyAlbumVO vo) throws Exception;
  public List<ReplyAlbumVO> list(int bno) throws Exception;
  public void update(ReplyAlbumVO vo) throws Exception;
  public void delete(int rno) throws Exception;

  //pagination
  public List<ReplyAlbumVO> listPage(
      int bno, Criteria cri) throws Exception;
  public int count(int bno) throws Exception;

  //
  public int getBno(int rno) throws Exception;
}
