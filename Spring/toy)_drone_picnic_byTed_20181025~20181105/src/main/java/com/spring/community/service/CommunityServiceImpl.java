package com.spring.community.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import com.spring.common.search.SearchCriteria;
import com.spring.community.CommunityVO;
import com.spring.community.persistence.CommunityDAO;

@Service
public class CommunityServiceImpl implements CommunityService {
	
	@Inject
	private CommunityDAO dao;
 
//C_basic + file
	@Transactional
	@Override
	public void create(CommunityVO vo) throws Exception {
		dao.create(vo);// basic
		String[] files = vo.getFiles();

		if(files == null) {return;}		
		for(String fileName : files) {
			dao.addAttach(fileName); //file
		}
	}

//R_basic + file
	@Transactional(isolation=Isolation.READ_COMMITTED)
	@Override
	public Map<String, Object> read(int no) throws Exception{
		dao.updateViewCnt(no);// view
		return dao.read(no); // basic
	}
	
//U_basic + file
	@Transactional
	@Override
	public void modify(CommunityVO vo) throws Exception {
		dao.update(vo); // basic
		int no = vo.getCno();
		System.out.println("serviceImpl,cno " + no);
		
		dao.deleteAttach(no); //file
		String[] files = vo.getFiles();
		if(files == null) {return; }
		
		for (String fileName : files) {
			dao.replaceAttach(fileName, no); //file
		}
	}
	
//D_basic + file
	@Transactional
	@Override
	public void remove(int no) throws Exception {
		dao.delete(no); // basic
		dao.deleteAttach(no); // file
	}
	
//list_search_R
	@Override
	public List<Map<String, Object>> listSearchCriteria(SearchCriteria cri) throws Exception {
		return dao.listSearch(cri); //list
	}
//list_search_R_count
	@Override
	public int listSearchCount(SearchCriteria cri) throws Exception {
		return dao.listSearchCount(cri); //list
	}	

//File_read
	@Override
	public List<String> getAttach(int no) throws Exception {
		return dao.getAttach(no);
	}
		
}
