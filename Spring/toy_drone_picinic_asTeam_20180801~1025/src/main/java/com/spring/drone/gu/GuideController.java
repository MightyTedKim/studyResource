package com.spring.drone.gu;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.drone.news.NewsVO;
import com.spring.drone.news.ReplyVO;


@Controller
public class GuideController {
	
	@Autowired
	private GuideDAOService guideDAOService;
	
	@RequestMapping("/guide.gu")
	public ModelAndView news_main(Locale locale, Model model) {
		System.out.println(">GuideController, guide.gu");  
		ModelAndView result = new ModelAndView();
		//ArrayList<GuideVO> guideList = new ArrayList<GuideVO>();
		//guideList = guideDAOService.getGuideList();
		
		//result.addObject("guideList", guideList);
		result.setViewName("gu/guide");
		System.out.println("<GuideController, guide.gu");  		
		return result;
	}
	
	@RequestMapping("/guide_write.gu")
	public ModelAndView guide_write(GuideVO guideVO, Locale locale, Model model) {
		ModelAndView result = new ModelAndView();
		int count = guideDAOService.countPost();
		
		guideVO.setNum(count + 1);
		guideDAOService.insertGuide(guideVO);
		ArrayList<GuideVO> guideList = new ArrayList<GuideVO>();
		guideList = guideDAOService.getGuideList();
		result.addObject("guideList", guideList);
		//result.addObject("guideVO", guideVO);
		result.setViewName("gu/guide");
		
		return result;
	}
	
	@RequestMapping("/guide_write_form.gu")
	public ModelAndView guide_write_form(GuideVO guideVO, Locale locale, Model model) {
		ModelAndView result = new ModelAndView();

		result.setViewName("gu/guide_write_form");
		
		return result;
	}
	
	@RequestMapping("/guide_update_form.gu")
	public ModelAndView guide_update_form(GuideVO guideVO, Locale locale, Model model) {
		ModelAndView result = new ModelAndView();
		guideVO = guideDAOService.getOneGuide(guideVO);
	
		result.addObject("guideVO", guideVO);
		result.setViewName("gu/guide_update_form");
		
		return result;
	}
	
	@RequestMapping("/guide_modify.gu")
	public ModelAndView guide_modify(GuideVO guideVO, Locale locale, Model model) {
		ModelAndView result = new ModelAndView();
		guideDAOService.updateGuide(guideVO);
	
		
		result.setViewName("gu/guide");
		
		return result;
	}
	
	@RequestMapping(value = "/getGuideJSON.gu", method = RequestMethod.GET, produces = "application/json; charset=UTF-8")
	@ResponseBody
	public String getGuideJSON(GuideVO guideVO) {

		List<GuideVO> guideList = guideDAOService.getGuide(guideVO);
		
		String str = "";
		ObjectMapper mapper = new ObjectMapper();
		try {
			str = mapper.writeValueAsString(guideList);

		}

		catch (Exception e) {
			System.out.println("first() mapper : " + e.getMessage());
		}

		return str;
	}
}
