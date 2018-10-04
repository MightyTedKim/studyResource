package com.spring.persistence;

import java.util.List;
import java.util.Map;

import com.spring.domain.BoardVO;

public interface BoardDAO {
	public void create(BoardVO vo) throws Exception;
	public BoardVO read(int bno) throws Exception;
	public void update(Map map) throws Exception;
	public void delete(Map map) throws Exception;
	public List<BoardVO> listAll() throws Exception;
}
