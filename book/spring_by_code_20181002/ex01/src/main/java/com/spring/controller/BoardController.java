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

import com.spring.domain.BoardVO;
import com.spring.service.BoardService;

@Controller
@RequestMapping("/board/*")
public class BoardController {
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	@Inject
	private BoardService service;

	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public void registerGET(BoardVO board, Model model) throws Exception {
	  logger.info("register get ...........");
	  System.out.println("register get ...........");
	}

  	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public String registPOST(BoardVO board, Model model, RedirectAttributes ra) throws Exception {
		logger.info("regist post ...........");
		logger.info(board.toString());
		service.regist(board); 
		
		//model.addAttribute("result", "success!!");
		ra.addFlashAttribute("msg", "SUCCESS");
		System.out.println("register post ...........");
		
		return "redirect:/board/listAll";
	}
  	
  	@RequestMapping(value = "/listAll", method = RequestMethod.GET)
  	public void listAll(Model model) throws Exception {
  		logger.info("show all list...............GET");
  		model.addAttribute("list", service.listAll());
  	}
 
  	@RequestMapping(value = "/read", method = RequestMethod.GET)
  	public void read(@RequestParam("bno") int bno, Model model) throws Exception{
  		logger.info("read ...............GET");
  		model.addAttribute(service.read(bno));
  	}
  	
  	@RequestMapping(value = "/remove", method = RequestMethod.POST)
  	public String remove(@RequestParam Map map, RedirectAttributes ra) throws Exception{
  		logger.info("remove ...............POST map");
  		service.remove(map);
  		ra.addFlashAttribute("msg", "SUCCESS");
  		System.out.println("삭제 완료!, listall로 이동");
		return "redirect:/board/listAll";
  	}
  	
  	@RequestMapping(value = "/modify", method = RequestMethod.GET)
  	public String modify(@RequestParam Map map, Model model) throws Exception{
  		model.addAttribute(service.read((Integer.parseInt((String) map.get("bno")))));
  		return "board/modify";
  	}
  	
  	@RequestMapping(value = "/modify", method = RequestMethod.POST)
  	public String modifyPOST(@RequestParam Map map, RedirectAttributes ra) throws Exception{
  		service.modify(map);
  		ra.addFlashAttribute("msg", "SUCCESS");
  		return "redirect:/board/listAll";
  	}
  	
}
