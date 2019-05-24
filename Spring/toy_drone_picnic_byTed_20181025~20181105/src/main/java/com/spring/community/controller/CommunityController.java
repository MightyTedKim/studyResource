package com.spring.community.controller;

import java.util.List;

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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.common.tedMethod;
import com.spring.common.pagination.PageMaker;
import com.spring.common.search.SearchCriteria;
import com.spring.community.CommunityVO;
import com.spring.community.persistence.CommunityDAO;
import com.spring.community.service.CommunityService;

@Controller
@RequestMapping("/community/*")
public class CommunityController {
	private static final Logger logger = LoggerFactory.getLogger(CommunityController.class);
	
	@Inject
	private CommunityService service;
	
	@Inject
	private CommunityDAO dao;
  	
//C
	@RequestMapping(value = "/registerPage.co", method = RequestMethod.GET)
		public String registerGET(Model model) throws Exception {
		logger.info("register get ...........");
		return "community/registerPage";
	}
//C	
	@RequestMapping(value = "/registerPage.co", method = RequestMethod.POST)
	public String registPOST(CommunityVO vo, RedirectAttributes rttr) throws Exception {	
		logger.info("regist post ...........");		
		try {
			Boolean validationCheck = tedMethod.hasValues(
					vo.getPco_x() ,	vo.getPco_y() ,	vo.getPadd() ,
					vo.getCname(), vo.getCdesc()
					);
			logger.info("validation, boolean= " + Boolean.toString(validationCheck));			
  			if (validationCheck) { //hasValues = true
  				service.create(vo);
  	  			rttr.addFlashAttribute("msg", "소모임 만들기에 성공했습니다. 목록 페이지로 돌아갑니다.");
  	  			return "redirect:/community/listPage.co";
  			}else { //hasValues = false
  				rttr.addFlashAttribute("msg", "소모임 만들기에 실패했습니다. 정보 입력과 사진 첨부를 진행해주세요");
  				return "redirect:/community/registerPage.co";
  			}  			
  		} catch (Exception e) {
  			e.printStackTrace();
  			rttr.addFlashAttribute("msg", e);
  			return "redirect:/community/registerPage.co";
  		}		
	}
	
//R
  	@RequestMapping(value = "/readPage.co", method = RequestMethod.GET)
  	public void readPage(@RequestParam("cno") int no, Model model,
  			@ModelAttribute("cri") SearchCriteria cri) throws Exception{
  		logger.info("readPage ...............GET");
  		logger.info("service.read(cno)=" + service.read(no).toString());
  		model.addAttribute("vo", service.read(no));
  		model.addAttribute("attach", service.getAttach(no));
  	}
//R
  	@RequestMapping(value = "/listPage.co", method = RequestMethod.GET)
  	public String listPage(@ModelAttribute("cri") SearchCriteria cri, Model model) throws Exception{  		
  		PageMaker pageMaker = new PageMaker();
  		pageMaker.setCri(cri); 
  		pageMaker.setTotalCount(service.listSearchCount(cri));  	
  		
  		model.addAttribute("list", service.listSearchCriteria(cri));
  		model.addAttribute("pageMaker", pageMaker);
  		
  		logger.info("==list==" + service.listSearchCriteria(cri).toString());
  		return "community/listPage";
  	}
  	
//U
  	@RequestMapping(value = "/modifyPage.co", method = RequestMethod.GET)
  	public String modifyPage(@RequestParam int cno,
  			@ModelAttribute("cri") SearchCriteria cri,Model model) throws Exception{
  		model.addAttribute("vo", service.read(cno));
  		logger.info("modifyPage-----------get");
  		return "community/modifyPage";
  	}
//U  	
  	@RequestMapping(value = "/modifyPage.co", method = RequestMethod.POST)
  	public String modifyPagePost(CommunityVO vo, 
  			SearchCriteria cri,	RedirectAttributes ra) throws Exception{
  		logger.info("modifyPage-----------POST");
  		service.modify(vo);
  		ra.addAttribute("page", cri.getPage());
  		ra.addAttribute("perPageNum", cri.getPerPageNum()); 		
  		ra.addFlashAttribute("msg", "수정에 성공하셨습니다. 목록으로 이동합니다.");
  		return "redirect:/community/listPage.co";
  	}    	 	
//D
  	@RequestMapping(value = "/removePage.co", method = RequestMethod.POST)
  	public String removePage(
  			@RequestParam int cno, 
  			SearchCriteria cri,
  			RedirectAttributes ra) throws Exception{
  		logger.info("removePage ...............POST");
  		service.remove(cno);
  		ra.addAttribute("page", cri.getPage());
  		ra.addAttribute("perPageNum", cri.getPerPageNum());
  		ra.addFlashAttribute("msg", "삭제가 완료되었습니다. 목록으로 이동합니다.");
		return "redirect:/community/listPage.co";
  	}

//File_Read
  	@RequestMapping(value = "/getAttach.co/{cno}")
  	@ResponseBody
  	public List<String> getAttach(@PathVariable("cno") int cno) throws Exception{
  		logger.info("service.getAttach(cno)= " + service.getAttach(cno));
  		return service.getAttach(cno);
  	}  	
//SignIn  	
  	@RequestMapping(value = "/joinCommunity.co/{cname}", method = RequestMethod.POST)
  	@ResponseBody
  	public void joinCommunity(
  			@PathVariable("cname") String cname,
  			@PathVariable("uid") String uid
  			) throws Exception{
  		logger.info("cname" + cname);
  		logger.info("uid" + uid);
  		dao.joinCommunity(cname, uid);
  	}  	
  	
};