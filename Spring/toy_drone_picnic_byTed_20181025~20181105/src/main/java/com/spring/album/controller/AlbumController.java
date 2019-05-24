package com.spring.album.controller;

import java.util.List; 

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.album.AlbumVO;
import com.spring.album.service.AlbumService;
import com.spring.common.pagination.PageMaker;
import com.spring.common.search.SearchCriteria;

@Controller
@RequestMapping("/album/*")
public class AlbumController {
	private static final Logger logger = LoggerFactory.getLogger(AlbumController.class);
	
	@Inject
	private AlbumService service;
  	
//C
	@RequestMapping(value = "/registerPage.al", method = RequestMethod.GET)
		public String registerGET(AlbumVO album, Model model) throws Exception {
		logger.info("register get ...........");
		return "album/registerPage";
	}
//C	
	@RequestMapping(value = "/registerPage.al", method = RequestMethod.POST)
	public String registPOST(AlbumVO album, RedirectAttributes rttr) throws Exception {	
		logger.info("regist post ...........");		
		service.create(album);
		rttr.addFlashAttribute("msg", "사진 업로드에 성공했습니다. 목록 페이지로 돌아갑니다.");
		return "redirect:/album/listPage.al";
	}
	
//R
  	@RequestMapping(value = "/readPage.al", method = RequestMethod.GET)
  	public void readPage(@RequestParam("ano") int ano, Model model,
  			@ModelAttribute("cri") SearchCriteria cri) throws Exception{
  		logger.info("readPage ...............GET");
  		logger.info("service.read(ano)=" + service.read(ano).toString());
  		model.addAttribute("vo", service.read(ano));
  		model.addAttribute("attach", service.getAttach(ano));
  	}
//R
  	@RequestMapping(value = "/listPage.al", method = RequestMethod.GET)
  	public String listPage(@ModelAttribute("cri") SearchCriteria cri,Model model) throws Exception{  		
  		PageMaker pageMaker = new PageMaker();
  		pageMaker.setCri(cri); 
  		pageMaker.setTotalCount(service.listSearchCount(cri));  	
  		
  		model.addAttribute("list", service.listSearchCriteria(cri));
  		model.addAttribute("pageMaker", pageMaker);
  		
  		logger.info("==list==" + service.listSearchCriteria(cri).toString());
  		return "album/listPage";
  	}
  	
//U
  	@RequestMapping(value = "/modifyPage.al", method = RequestMethod.GET)
  	public String modifyPage(@RequestParam int ano,
  			@ModelAttribute("cri") SearchCriteria cri,Model model) throws Exception{
  		model.addAttribute("vo", service.read(ano));
  		logger.info("modifyPage-----------get");
  		return "album/modifyPage";
  	}
//U  	
  	@RequestMapping(value = "/modifyPage.al", method = RequestMethod.POST)
  	public String modifyPagePost(AlbumVO album, 
  			SearchCriteria cri,	RedirectAttributes ra) throws Exception{
  		logger.info("modifyPage-----------POST");
  		service.modify(album);
  		ra.addAttribute("page", cri.getPage());
  		ra.addAttribute("perPageNum", cri.getPerPageNum()); 		
  		ra.addFlashAttribute("msg", "수정에 성공하셨습니다. 목록으로 이동합니다.");
  		return "redirect:/album/listPage.al";
  	}    	 	
//D
  	@RequestMapping(value = "/removePage.al", method = RequestMethod.POST)
  	public String removePage(
  			@RequestParam int ano, 
  			SearchCriteria cri,
  			RedirectAttributes ra) throws Exception{
  		logger.info("removePage ...............POST");
  		service.remove(ano);
  		ra.addAttribute("page", cri.getPage());
  		ra.addAttribute("perPageNum", cri.getPerPageNum());
  		ra.addFlashAttribute("msg", "삭제가 완료되었습니다. 목록으로 이동합니다.");
		return "redirect:/album/listPage.al";
  	}

//File_Read
  	@RequestMapping(value = "/getAttach.al/{ano}")
  	@ResponseBody
  	public List<String> getAttach(@PathVariable("ano") int ano) throws Exception{
  		logger.info("service.getAttach(ano)= " + service.getAttach(ano));
  		return service.getAttach(ano);
  	}  	
};