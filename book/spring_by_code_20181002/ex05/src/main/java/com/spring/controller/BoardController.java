package com.spring.controller;

import java.util.List;
import java.util.Map;

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

import com.spring.domain.BoardVO;
import com.spring.domain.PageMaker;
import com.spring.domain.SearchCriteria;
import com.spring.service.BoardService;

@Controller
@RequestMapping("/board/*")
public class BoardController {
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	@Inject
	private BoardService service;
	
  	
//registerGET - create
	@RequestMapping(value = "/registerPage", method = RequestMethod.GET)
		public String registerGET(BoardVO board, Model model) throws Exception {
		logger.info("register get ...........");
		return "board/registerPage";
	}
	
	@RequestMapping(value = "/registerPage", method = RequestMethod.POST)
	public String registPOST(BoardVO board, RedirectAttributes rttr) throws Exception {	
		logger.info("regist post ...........");
		logger.info(board.toString());
		
		service.regist(board);
		rttr.addFlashAttribute("msg", "success");
		return "redirect:/board/listPage";
	}
//readPage - read
  	@RequestMapping(value = "/readPage", method = RequestMethod.GET)
  	public void readPage(@RequestParam("bno") int bno, 
  			Model model,
  			@ModelAttribute("cri") SearchCriteria cri) throws Exception{
  		logger.info("readPage ...............GET");
  		model.addAttribute(service.read(bno));
  	}
//listPage - read_list
  	@RequestMapping(value = "/listPage", method = RequestMethod.GET)
  	public String listPage(@ModelAttribute("cri") SearchCriteria cri, Model model) throws Exception{
  		logger.info("listSearchCriteria(cri) = " + service.listSearchCriteria(cri));
  		model.addAttribute("list", service.listSearchCriteria(cri));
  		logger.info("service.listSearchCriteria(cri) = " + service.listSearchCriteria(cri));
  		
  		PageMaker pageMaker = new PageMaker();
  		pageMaker.setCri(cri); 
  		logger.info("service.listSearchCount(cri) = " + service.listSearchCount(cri));
  		pageMaker.setTotalCount(service.listSearchCount(cri));
  		model.addAttribute("pageMaker", pageMaker);		
  		logger.info("pageMaker = " + pageMaker);
  		
  		return "board/listPage";
  	}
  	
  	
//removePage - delete
  	@RequestMapping(value = "/removePage", method = RequestMethod.POST)
  	public String removePage(@RequestParam int bno, 
  			SearchCriteria cri,
  			RedirectAttributes ra) throws Exception{
  		logger.info("removePage ...............POST");
  		service.remove(bno);
  		ra.addAttribute("page", cri.getPage());
  		ra.addAttribute("perPageNum", cri.getPerPageNum());
  		ra.addFlashAttribute("msg", "SUCCESS");
  		System.out.println("삭제 완료!, listPage로 이동");
		return "redirect:/board/listPage";
  	}
  	
//modifyPage - update
  	@RequestMapping(value = "/modifyPage", method = RequestMethod.GET)
  	public String modifyPage(@RequestParam int bno,
  			@ModelAttribute("cri") SearchCriteria cri,
  			Model model) throws Exception{
  		model.addAttribute(service.read(bno));
  		//model.addAttribute(service.read((Integer.parseInt((String) map.get("bno")))));
  		return "board/modifyPage";
  	}
  	
  	@RequestMapping(value = "/modifyPage", method = RequestMethod.POST)
  	public String modifyPagePost(BoardVO board, 
  			SearchCriteria cri,
  			RedirectAttributes ra) throws Exception{
  		logger.info("board/modifyPage, board=" + board);
  		service.modify(board);
  		ra.addAttribute("page", cri.getPage());
  		ra.addAttribute("perPageNum", cri.getPerPageNum());
  		
  		ra.addFlashAttribute("msg", "SUCCESS");
  		return "redirect:/board/listPage";
  	}  
  	
// -
  	@RequestMapping(value = "/getAttach/{bno}")
  	@ResponseBody
  	public List<String> getAttach(@PathVariable("bno") int bno) throws Exception{
  		return service.getAttach(bno);
  	}
}