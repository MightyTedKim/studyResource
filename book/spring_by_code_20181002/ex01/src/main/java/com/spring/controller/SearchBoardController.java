package com.spring.controller;

import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.domain.Criteria;
import com.spring.domain.PageMaker;
import com.spring.domain.SearchCriteria;
import com.spring.service.BoardService;

@Controller
@RequestMapping("/sboard/*")
public class SearchBoardController {
	private static final Logger logger = LoggerFactory.getLogger(SearchBoardController.class);
	
	@Inject
	private BoardService service;
	
	@RequestMapping(value = "list", method = RequestMethod.GET)
	public String listPage(@ModelAttribute("cri") SearchCriteria cri,
			Model model) throws Exception {
		logger.info(cri.toString());
		
		//model.addAttribute("list", service.listCriteria(cri));
		model.addAttribute("list", service.listSearchCriteria(cri));
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		//pageMaker.setTotalCount(service.listCountCriteria(cri));
		pageMaker.setTotalCount(service.listSearchCount(cri));
		
		model.addAttribute("pageMaker", pageMaker);
		return "sboard/list";
	}
	
  	@RequestMapping(value = "/listPage", method = RequestMethod.GET)
  	public String listPage(@ModelAttribute("cri")Criteria cri, Model model) throws Exception{
  		System.out.println("cri = " + cri);
  		logger.info("cri.toString() = " + cri.toString());
  		model.addAttribute("list", service.listCriteria(cri));
  		System.out.println("service.listCriteria(cri) = " + service.listCriteria(cri));
  		PageMaker pageMaker = new PageMaker();
  		pageMaker.setCri(cri); 
  		pageMaker.setTotalCount(service.listCountCriteria(cri));
  		System.out.println("pageMaker = " + pageMaker);

  		model.addAttribute("pageMaker", pageMaker);

  		return "board/listPage";
  	}
  	
  	@RequestMapping(value = "/readPage", method = RequestMethod.GET)
  	public void readPage(@RequestParam("bno") int bno, 
  			Model model,
  			@ModelAttribute("cri") Criteria cri) throws Exception{
  		logger.info("readPage ...............GET");
  		model.addAttribute(service.read(bno));
  	}
  	
  	@RequestMapping(value = "/removePage", method = RequestMethod.POST)
  	public String removePage(@RequestParam Map map, 
  			Criteria cri,
  			RedirectAttributes ra) throws Exception{
  		logger.info("removePage ...............POST map");
  		service.remove(map);
  		ra.addAttribute("page", cri.getPage());
  		ra.addAttribute("perPageNum", cri.getPerPageNum());
  		ra.addFlashAttribute("msg", "SUCCESS");
  		System.out.println("삭제 완료!, listPage로 이동");
		return "redirect:/board/listPage";
  	}
  	

  	@RequestMapping(value = "/modifyPage", method = RequestMethod.GET)
  	public String modifyPage(@RequestParam Map map,
  			@ModelAttribute("cri") Criteria cri,
  			Model model) throws Exception{
  		model.addAttribute(service.read((Integer.parseInt((String) map.get("bno")))));
  		return "board/modify";
  	}
  	
  	@RequestMapping(value = "/modifyPage", method = RequestMethod.POST)
  	public String modifyPagePost(@RequestParam Map map, 
  			Criteria cri,
  			RedirectAttributes ra) throws Exception{
  		service.modify(map);
  		ra.addAttribute("page", cri.getPage());
  		ra.addAttribute("perPageNum", cri.getPerPageNum());
  		
  		ra.addFlashAttribute("msg", "SUCCESS");
  		return "redirect:/board/listAll";
  	}   
}
