package com.spring.drone.templ;

import java.util.ArrayList;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.spring.drone.me.MemberDAOService;
import com.spring.drone.me.MemberVO;
import com.spring.drone.news.NewsDAOService;
import com.spring.drone.news.NewsPaginationVO;
import com.spring.drone.news.NewsVO;

@Controller
public class TemplateController {
	
	@Autowired
	private NewsDAOService newsDAOService;
	
	@Autowired
	private MemberDAOService memberDAOService;
	
	@RequestMapping("/intro.templ")
	public String fromIntroToTemplate(Locale locale, Model model) {

		return "intro";
	}
	
	@RequestMapping("/main.templ")
	public ModelAndView main(Locale locale, Model model, HttpSession session, HttpServletRequest request, HttpServletResponse response, MemberVO memberVO) {
		System.out.println(">TemplateController, main.templ");
		NewsPaginationVO newsPaginationVO = new NewsPaginationVO();
		ArrayList<NewsVO> newsList = new ArrayList<NewsVO>();

		ModelAndView result = new ModelAndView();

		int pageSize = 10;
		newsPaginationVO.setPageSize(pageSize);

		String pageNum1 = request.getParameter("pageNum");

		if (pageNum1 == null)
			pageNum1 = "1";
		System.out.println(">TemplateController, pageNum1: " + pageNum1);
		int pageNum = Integer.parseInt(pageNum1);
		newsPaginationVO.setPageNum(pageNum);

		int currentPage = pageNum;
		newsPaginationVO.setCurrentPage(currentPage);

		int startRow = (currentPage - 1) * pageSize + 1;
		newsPaginationVO.setStartRow(startRow);

		int endRow = startRow + pageSize - 1;
		newsPaginationVO.setEndRow(endRow);
		System.out.println(">TemplateController, endRow: " + endRow);

		int count = newsDAOService.getCount();
		newsPaginationVO.setCount(count);
		System.out.println(">TemplateController, count: " + count);

		int number = count - (currentPage - 1) * pageSize;
		
		newsPaginationVO.setNumber(number);

		if (count < startRow) {
			currentPage = currentPage - 1;
			startRow = (currentPage - 1) * pageSize + 1;
			endRow = startRow + pageSize - 1;
		}
		if (count > 0) { 
			newsList = newsDAOService.getNewsList(startRow, endRow);
		}
		System.out.println(">TemplateController, newsList, before");
		newsList = newsDAOService.getNewsList(startRow, endRow);
		System.out.println(">TemplateController, newsList: " + newsList);

		result.addObject("newsPaginationVO", newsPaginationVO);
		result.addObject("newsList", newsList);
		result.setViewName("template/main");
		
		int res = memberDAOService.userCheck(memberVO);
		System.out.println(memberVO.getNickname());
		System.out.println("<TemplateController, main.temp, res : " + res);
		
		if (res == 1) {
			System.out.println(memberVO.getNickname());
			session.setAttribute("nickname", memberVO.getNickname());
			result.addObject("newsPaginationVO", newsPaginationVO);
			result.addObject("newsList", newsList);
			result.addObject("nickName", memberVO.getNickname());
			result.setViewName("template/main");
			
			return result;
		}
		return result;
		
	
	}
	
	@RequestMapping("/template.templ")
	public ModelAndView template(Locale locale, Model model, HttpServletRequest request) {
		ModelAndView result = new ModelAndView();
		String pagefile = request.getParameter("page");

		if (pagefile == null){
			pagefile = "template/main.jsp";
		}
		
		result.addObject("pagefile", pagefile);
		result.setViewName("template/template");
		return result;
	}
	

}
