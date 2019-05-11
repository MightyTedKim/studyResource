package com.spring.board.controller;

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

import com.spring.board.BoardVO;
import com.spring.board.service.BoardService;
import com.spring.common.pagination.PageMaker;
import com.spring.common.search.SearchCriteria;

@Controller
@RequestMapping("/board/*")
public class BoardController {
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	@Inject
	private BoardService service;
  	
//registerGET - create
	@RequestMapping(value = "/registerPage.bo", method = RequestMethod.GET)
		public String registerGET(BoardVO board, Model model) throws Exception {
		logger.info("register get ...........");
		return "board/registerPage";
	}
	
	@RequestMapping(value = "/registerPage.bo", method = RequestMethod.POST)
	public String registPOST(BoardVO board, RedirectAttributes rttr) throws Exception {	
		logger.info("regist post ...........");		
		service.regist(board);
		rttr.addFlashAttribute("msg", "업로드에 성공하였습니다. 목록ㄱ으로 이동합니다.");
		return "redirect:/board/listPage.bo";
	}
	
//readPage - read
  	@RequestMapping(value = "/readPage.bo", method = RequestMethod.GET)
  	public void readPage(@RequestParam("bno") int bno, 
  			Model model,
  			@ModelAttribute("cri") SearchCriteria cri) throws Exception{
  		logger.info("readPage ...............GET");
  		model.addAttribute(service.read(bno));
  	}
  	
//listPage - read_list
  	@RequestMapping(value = "/listPage.bo", method = RequestMethod.GET)
  	public String listPage(
  			@ModelAttribute("cri") SearchCriteria cri,
  			Model model
  			) throws Exception{
  		logger.info("listSearchCriteria(cri) = " + service.listSearchCriteria(cri));
  		model.addAttribute("list", service.listSearchCriteria(cri));
  		
  		PageMaker pageMaker = new PageMaker();
  		pageMaker.setCri(cri); 
  		pageMaker.setTotalCount(service.listSearchCount(cri));
  		model.addAttribute("pageMaker", pageMaker);		
  		logger.info("pageMaker = " + pageMaker);
  		
  		return "/board/listPage";
  	}
  	
  	
//removePage - delete
  	@RequestMapping(value = "/removePage.bo", method = RequestMethod.POST)
  	public String removePage(
  			@RequestParam int bno, 
  			SearchCriteria cri,
  			RedirectAttributes ra) throws Exception{
  		logger.info("removePage ...............POST");
  		service.remove(bno);
  		ra.addAttribute("page", cri.getPage());
  		ra.addAttribute("perPageNum", cri.getPerPageNum());
  		ra.addFlashAttribute("msg", "SUCCESS");
  		logger.info("삭제 완료!, listPage로 이동");
		return "redirect:/board/listPage.bo";
  	}
  	
//modifyPage - update
  	@RequestMapping(value = "/modifyPage.bo", method = RequestMethod.GET)
  	public String modifyPage(@RequestParam int bno,
  			@ModelAttribute("cri") SearchCriteria cri,
  			Model model) throws Exception{
  		model.addAttribute(service.read(bno));
  		logger.info("modifyPage-----------");
  		//model.addAttribute(service.read((Integer.parseInt((String) map.get("bno")))));
  		return "/board/modifyPage";
  	}
  	
  	@RequestMapping(value = "/modifyPage.bo", method = RequestMethod.POST)
  	public String modifyPagePost(BoardVO board, 
  			SearchCriteria cri,
  			RedirectAttributes ra) throws Exception{
  		logger.info("board/modifyPage, board=" + board);
  		service.modify(board);
  		ra.addAttribute("page", cri.getPage());
  		ra.addAttribute("perPageNum", cri.getPerPageNum()); 		
  		ra.addFlashAttribute("msg", "SUCCESS");
  		return "redirect:/board/listPage.bo";
  	}  
  	
 // Read uploadFile
   	@RequestMapping(value = "/getAttach.bo/{bno}")
   	@ResponseBody
   	public List<String> getAttach(@PathVariable("bno") int bno) throws Exception{
   		return service.getAttach(bno);
   	} 
};