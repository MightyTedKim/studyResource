package com.spring.place.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.common.pagination.Criteria;
import com.spring.common.pagination.PageMaker;
import com.spring.common.search.SearchCriteria;
import com.spring.place.PlaceVO;
import com.spring.place.persistence.PlaceDAO;
import com.spring.place.service.PlaceService;

@Controller
@RequestMapping("/place/*")
public class PlaceController {
	
	private static final Logger logger = LoggerFactory.getLogger(PlaceController.class);
	
	@Inject
	private PlaceDAO dao;
	
	@Inject
	private PlaceService service;
	
  	//json
    @RequestMapping(value = "/place_json", method = {RequestMethod.GET})
	public ResponseEntity<List< Map<String, Object> >> readJSON(){
		logger.info("readAll========");
		ResponseEntity< List< Map<String, Object> >> entity = null;
		try {
			entity = new ResponseEntity<List< Map<String, Object> >>(service.readJSON(), HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<List< Map<String, Object> >>(HttpStatus.BAD_REQUEST);
		};
		return entity;
	}
    
    
    
    //CR on /place, UD on /place_list
    //c
	@RequestMapping(value = "/create.pl", method = RequestMethod.POST)
	public String createPOST(PlaceVO vo, RedirectAttributes rttr) throws Exception {	
		logger.info("createPOST ...........");
		logger.info(vo.toString());
		
		dao.create(vo);
		rttr.addFlashAttribute("msg", "등록 완료");
		return "redirect:/place/main.pl";
	}
	
	//r - main
	@RequestMapping(value = "/main.pl", method = RequestMethod.GET)
	public String main(
			@ModelAttribute("cri") SearchCriteria cri,
			Model model
			) throws Exception{
		model.addAttribute("placeList", service.listSearchCriteria(cri));
		logger.info("service.listSearchCriteria(cri)= " + service.listSearchCriteria(cri));
		cri.setPerPageNum(4);// change from 10
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri); 
		pageMaker.setTotalCount(service.listSearchCount(cri));
		model.addAttribute("pageMaker", pageMaker);		
		
		return "/place/main";
	}
	
  // r - pagination
  @RequestMapping(value = "place_list/{pno}/{page}", method = {RequestMethod.GET})
  public ResponseEntity<Map<String, Object>> listPage(
		  @PathVariable("pno") int pno, 
		  @PathVariable("page") int page){
	  logger.info("listPage===/{pno}/{page}=============");
	  ResponseEntity<Map<String, Object>> entity = null;	  
	  try {
		  Criteria cri = new Criteria();
		  logger.info("cri.toString()=" + cri.toString());
		  cri.setPage(page);//page 초기화
  
		  PageMaker pageMaker = new PageMaker();
		  pageMaker.setCri(cri); //page, perPageNum
		  
		  Map<String, Object> map = new HashMap<String, Object>();
		  List<PlaceVO> list = service.listPlacePage(pno, cri);
		  map.put("list", list);
  
		  int placeCount = service.count(pno);
		  pageMaker.setTotalCount(placeCount);
		  map.put("pageMaker",  pageMaker);
				  
		  entity = new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);
	  } catch (Exception e) {
		  e.printStackTrace();
		  entity = new ResponseEntity<Map<String, Object>>(HttpStatus.BAD_REQUEST);
	  };
	  return entity;
  }

 
}
