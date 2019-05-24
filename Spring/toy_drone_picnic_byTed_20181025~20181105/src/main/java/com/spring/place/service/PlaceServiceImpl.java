package com.spring.place.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.spring.board.ReplyVO;
import com.spring.common.pagination.Criteria;
import com.spring.common.search.SearchCriteria;
import com.spring.place.PlaceVO;
import com.spring.place.persistence.PlaceDAO;


@Service
public class PlaceServiceImpl implements PlaceService {

	@Inject
	private PlaceDAO dao;
	
	//JSON
	@Override
	public List< Map<String, Object> > readJSON() throws Exception {
		return dao.readJSON();
	}
	
	//CRUD
	@Override
	public PlaceVO read(int pno) throws Exception{
		return dao.read(pno);
	}

	@Override
	public void modify(PlaceVO vo) throws Exception {
		dao.update(vo);
	}
	
	@Override
	public void remove(int pno) throws Exception {
		dao.delete(pno);
	}

//search
	@Override
	public List<PlaceVO> listSearchCriteria(SearchCriteria cri) throws Exception {
		return dao.listSearch(cri);
	}

	@Override
	public int listSearchCount(SearchCriteria cri) throws Exception {
		return dao.listSearchCount(cri);
	}

	
//pagination
	@Override
	public List<PlaceVO> listPlacePage(int pno, Criteria cri) throws Exception {
		return dao.listPage(pno, cri);
	}
	@Override
	public int count(int pno) throws Exception {
		return dao.count(pno);
	}

	
	
}
