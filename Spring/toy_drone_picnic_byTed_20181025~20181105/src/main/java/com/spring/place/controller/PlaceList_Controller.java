package com.spring.place.controller;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.common.pagination.PageMaker;
import com.spring.common.search.SearchCriteria;
import com.spring.place.PlaceVO;
import com.spring.place.service.PlaceService;

@Controller
@RequestMapping("/place_list/*")
public class PlaceList_Controller {
	private static final Logger logger = LoggerFactory.getLogger(PlaceList_Controller.class);
	@Inject
	private PlaceService service;

    //r
	@RequestMapping(value = "/listPage.pl", method = RequestMethod.GET)
	public String listPage(
			@ModelAttribute("cri") SearchCriteria cri,
			Model model
			) throws Exception{
		logger.info("place_list/listPage.pl, cri=" + cri);
		model.addAttribute("placeList", service.listSearchCriteria(cri));
		cri.setPerPageNum(4);// change from 10
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri); 
		pageMaker.setTotalCount(service.listSearchCount(cri));
		model.addAttribute("pageMaker", pageMaker);		
		
		return "/place_list/listPage";
	}
	
    //CR on /place, UD on /place_list
	//u	
	@RequestMapping(value = "/modifyPage.pl", method = RequestMethod.POST)
	public String modifyPagePost(PlaceVO vo, 
			SearchCriteria cri,
			RedirectAttributes ra) throws Exception{
	logger.info("place_list/modifyPage.pl, vo=" + vo);
	service.modify(vo);
	ra.addAttribute("page", cri.getPage());
	ra.addAttribute("perPageNum", cri.getPerPageNum()); 		
	ra.addFlashAttribute("msg", "수정이 완료되었습니다.");
	return "redirect:/place_list/listPage.pl";
	}  

	//d
	@RequestMapping(value = "/removePage.pl", method = RequestMethod.POST)
	public String removePage(
			@RequestParam int pno, 
			SearchCriteria cri,
			RedirectAttributes ra) throws Exception{
		logger.info("place_list/removePage ...............POST");
		service.remove(pno);
		ra.addAttribute("page", cri.getPage());
		ra.addAttribute("perPageNum", cri.getPerPageNum());
		ra.addFlashAttribute("msg", "삭제에 성공하셨습니다.");
		logger.info("삭제 완료!, listPage로 이동");
	return "redirect:/place_list/listPage.pl";
	}
	
    
}
