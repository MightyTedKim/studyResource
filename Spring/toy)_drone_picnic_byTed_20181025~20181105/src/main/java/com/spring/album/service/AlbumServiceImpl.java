package com.spring.album.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import com.spring.album.AlbumVO;
import com.spring.album.persistence.AlbumDAO;
import com.spring.common.search.SearchCriteria;

@Service
public class AlbumServiceImpl implements AlbumService {
	
	@Inject
	private AlbumDAO dao;
 
//C_basic + file
	@Transactional
	@Override
	public void create(AlbumVO album) throws Exception {
		dao.create(album);// basic
		String[] files = album.getFiles();

		if(files == null) {return;}		
		for(String fileName : files) {
			dao.addAttach(fileName); //file
		}
	}

//R_basic + file
	@Transactional(isolation=Isolation.READ_COMMITTED)
	@Override
	public Map<String, Object> read(int ano) throws Exception{
		dao.updateViewCnt(ano);// view
		return dao.read(ano); // basic
	}
	
//U_basic + file
	@Transactional
	@Override
	public void modify(AlbumVO album) throws Exception {
		dao.update(album); // basic
		int ano = album.getAno();
		System.out.println("serviceImpl,ano " + ano);
		
		dao.deleteAttach(ano); //file
		String[] files = album.getFiles();
		if(files == null) {return; }
		
		for (String fileName : files) {
			dao.replaceAttach(fileName, ano); //file
		}
	}
	
//D_basic + file
	@Transactional
	@Override
	public void remove(int ano) throws Exception {
		dao.delete(ano); // basic
		dao.deleteAttach(ano); // file
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
	public List<String> getAttach(int ano) throws Exception {
		return dao.getAttach(ano);
	}
}
