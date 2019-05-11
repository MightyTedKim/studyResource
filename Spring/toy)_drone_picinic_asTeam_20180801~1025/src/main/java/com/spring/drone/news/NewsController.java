package com.spring.drone.news;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.codehaus.jackson.map.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.drone.co.AlbumReplyVO;
import com.spring.drone.co.AlbumVO;

@Controller
public class NewsController {

	@Autowired
	private NewsDAOService newsDAOService;
	
	

	@RequestMapping("/getNews.news")
	public ModelAndView getNews(Model model, NewsVO newsVO, NewsPaginationVO newsPaginationVO) {
		ModelAndView result = new ModelAndView();
		
		int num = newsVO.getNum();
		int readcount = newsVO.getReadcount() + 1;
		int pageNum = newsPaginationVO.getPageNum();
		int number = newsPaginationVO.getNumber();

		newsDAOService.addReadcount(num, readcount);
		newsVO = newsDAOService.getNews(num);
		
		newsPaginationVO.setPageNum(pageNum);
		newsPaginationVO.setNumber(number);

		result.addObject("newsVO", newsVO);
		result.addObject("newsPaginationVO", newsPaginationVO);
		
		result.setViewName("news/news_general_content");

		return result;

	}

	@RequestMapping("/news_main.news")
	public ModelAndView newsMain(Locale locale, Model model, HttpServletRequest request) {
		
		NewsPaginationVO newsPaginationVO = new NewsPaginationVO();
		ArrayList<NewsVO> newsList = new ArrayList<NewsVO>();

		ModelAndView result = new ModelAndView();

		int pageSize = 10;
		newsPaginationVO.setPageSize(pageSize);

		String pageNum1 = request.getParameter("pageNum");

		if (pageNum1 == null)
			pageNum1 = "1";

		int pageNum = Integer.parseInt(pageNum1);
		newsPaginationVO.setPageNum(pageNum);

		int currentPage = pageNum;
		newsPaginationVO.setCurrentPage(currentPage);

		int startRow = (currentPage - 1) * pageSize + 1;
		newsPaginationVO.setStartRow(startRow);

		int endRow = startRow + pageSize - 1;
		newsPaginationVO.setEndRow(endRow);

		int count = newsDAOService.getCount();
		newsPaginationVO.setCount(count);

		int number = count - (currentPage - 1) * pageSize;
		;
		newsPaginationVO.setNumber(number);

		if (count < startRow) {
			currentPage = currentPage - 1;
			startRow = (currentPage - 1) * pageSize + 1;
			endRow = startRow + pageSize - 1;
		}
		if (count > 0) {
			newsList = newsDAOService.getNewsList(startRow, endRow);
		}

		newsList = newsDAOService.getNewsList(startRow, endRow);

		result.addObject("newsPaginationVO", newsPaginationVO);
		result.addObject("newsList", newsList);
		result.setViewName("news/news_main");
		return result;
	}

	@RequestMapping(value = "/list.news")
	public ModelAndView count(Locale locale, Model model, HttpServletRequest request) {
		
		NewsPaginationVO newsPaginationVO = new NewsPaginationVO();
		ArrayList<NewsVO> newsList = new ArrayList<NewsVO>();
		ModelAndView result = new ModelAndView();

		int pageSize = 10;
		newsPaginationVO.setPageSize(pageSize);

		String pageNum1 = request.getParameter("pageNum");

		if (pageNum1 == null)
			pageNum1 = "1";

		int pageNum = Integer.parseInt(pageNum1);
		newsPaginationVO.setPageNum(pageNum);

		int currentPage = pageNum;
		newsPaginationVO.setCurrentPage(currentPage);

		int startRow = (currentPage - 1) * pageSize + 1;
		newsPaginationVO.setStartRow(startRow);

		int endRow = startRow + pageSize - 1;
		newsPaginationVO.setEndRow(endRow);

		int count = newsDAOService.getCount();
		newsPaginationVO.setCount(count);

		int number = count - (currentPage - 1) * pageSize;
		;
		newsPaginationVO.setNumber(number);

		if (count < startRow) {
			currentPage = currentPage - 1;
			startRow = (currentPage - 1) * pageSize + 1;
			endRow = startRow + pageSize - 1;
		}
		if (count > 0) {
			newsList = newsDAOService.getNewsList(startRow, endRow);
		}

		newsList = newsDAOService.getNewsList(startRow, endRow);

		result.addObject("newsPaginationVO", newsPaginationVO);
		result.addObject("newsList", newsList);
		result.setViewName("news/news_general_list");
		return result;

	}
	
	
	
	@RequestMapping(value = "/edu_news_list.news")
	public ModelAndView getEduNewsList(EduNewsPaginationVO eduNewsPaginationVO, Model model, HttpServletRequest request) {
		
		ArrayList<NewsVO> eduNewsList = new ArrayList<NewsVO>();
		ModelAndView result = new ModelAndView();

		int pageSize = 10;
		eduNewsPaginationVO.setPageSize(pageSize);

		String pageNum1 = request.getParameter("pageNum");

		if (pageNum1 == null)
			pageNum1 = "1";

		int pageNum = Integer.parseInt(pageNum1);
		eduNewsPaginationVO.setPageNum(pageNum);

		int currentPage = pageNum;
		eduNewsPaginationVO.setCurrentPage(currentPage);

		int startRow = (currentPage - 1) * pageSize + 1;
		eduNewsPaginationVO.setStartRow(startRow);

		int endRow = startRow + pageSize - 1;
		eduNewsPaginationVO.setEndRow(endRow);

		int count = newsDAOService.getEduCount();
		eduNewsPaginationVO.setCount(count);

		int number = count - (currentPage - 1) * pageSize;
		eduNewsPaginationVO.setNumber(number);

		if (count < startRow) {
			currentPage = currentPage - 1;
			startRow = (currentPage - 1) * pageSize + 1;
			endRow = startRow + pageSize - 1;
		}
		if (count > 0) {
			eduNewsList = newsDAOService.getEduNewsList(eduNewsPaginationVO);
		}
		eduNewsList = newsDAOService.getEduNewsList(eduNewsPaginationVO);
		result.addObject("newsPaginationVO", eduNewsPaginationVO);
		result.addObject("eduNewsList", eduNewsList);
		result.setViewName("news/edu_news_list");
		return result;
	}
	
	@RequestMapping(value = "/com_news_list.news")
	public ModelAndView getComNewsList(ComNewsPaginationVO comNewsPaginationVO, Model model, HttpServletRequest request) {
		
		ArrayList<NewsVO> comNewsList = new ArrayList<NewsVO>();
		ModelAndView result = new ModelAndView();

		int pageSize = 10;
		comNewsPaginationVO.setPageSize(pageSize);

		String pageNum1 = request.getParameter("pageNum");

		if (pageNum1 == null)
			pageNum1 = "1";

		int pageNum = Integer.parseInt(pageNum1);
		comNewsPaginationVO.setPageNum(pageNum);

		int currentPage = pageNum;
		comNewsPaginationVO.setCurrentPage(currentPage);

		int startRow = (currentPage - 1) * pageSize + 1;
		comNewsPaginationVO.setStartRow(startRow);

		int endRow = startRow + pageSize - 1;
		comNewsPaginationVO.setEndRow(endRow);

		int count = newsDAOService.getComCount();
		comNewsPaginationVO.setCount(count);

		int number = count - (currentPage - 1) * pageSize;
		comNewsPaginationVO.setNumber(number);

		if (count < startRow) {
			currentPage = currentPage - 1;
			startRow = (currentPage - 1) * pageSize + 1;
			endRow = startRow + pageSize - 1;
		}
		if (count > 0) {
			comNewsList = newsDAOService.getComNewsList(comNewsPaginationVO);
		}
		comNewsList = newsDAOService.getComNewsList(comNewsPaginationVO);
		result.addObject("comNewsPaginationVO", comNewsPaginationVO);
		result.addObject("comNewsList", comNewsList);
		result.setViewName("news/com_news_list");
		return result;
	}
	
	
	@RequestMapping(value = "/leisure_news_list.news")
	public ModelAndView getLeisureNewsList(LeisureNewsPaginationVO leisureNewsPaginationVO, Model model, HttpServletRequest request) {
		
		ArrayList<NewsVO> leisureNewsList = new ArrayList<NewsVO>();
		ModelAndView result = new ModelAndView();

		int pageSize = 10;
		leisureNewsPaginationVO.setPageSize(pageSize);

		String pageNum1 = request.getParameter("pageNum");

		if (pageNum1 == null)
			pageNum1 = "1";

		int pageNum = Integer.parseInt(pageNum1);
		leisureNewsPaginationVO.setPageNum(pageNum);

		int currentPage = pageNum;
		leisureNewsPaginationVO.setCurrentPage(currentPage);

		int startRow = (currentPage - 1) * pageSize + 1;
		leisureNewsPaginationVO.setStartRow(startRow);

		int endRow = startRow + pageSize - 1;
		leisureNewsPaginationVO.setEndRow(endRow);

		int count = newsDAOService.getLeisureCount();
		leisureNewsPaginationVO.setCount(count);

		int number = count - (currentPage - 1) * pageSize;
		leisureNewsPaginationVO.setNumber(number);

		if (count < startRow) {
			currentPage = currentPage - 1;
			startRow = (currentPage - 1) * pageSize + 1;
			endRow = startRow + pageSize - 1;
		}
		if (count > 0) {
			leisureNewsList = newsDAOService.getLeisureNewsList(leisureNewsPaginationVO);
		}
		leisureNewsList = newsDAOService.getLeisureNewsList(leisureNewsPaginationVO);
		result.addObject("leisureNewsPaginationVO", leisureNewsPaginationVO);
		result.addObject("leisureNewsList", leisureNewsList);
		result.setViewName("news/leisure_news_list");
		return result;
	}
	
	
	@RequestMapping(value = "/job_news_list.news")
	public ModelAndView getJobNewsList(JobNewsPaginationVO jobNewsPaginationVO, Model model, HttpServletRequest request) {
		
		ArrayList<NewsVO> jobNewsList = new ArrayList<NewsVO>();
		ModelAndView result = new ModelAndView();

		int pageSize = 10;
		jobNewsPaginationVO.setPageSize(pageSize);

		String pageNum1 = request.getParameter("pageNum");

		if (pageNum1 == null)
			pageNum1 = "1";

		int pageNum = Integer.parseInt(pageNum1);
		jobNewsPaginationVO.setPageNum(pageNum);

		int currentPage = pageNum;
		jobNewsPaginationVO.setCurrentPage(currentPage);

		int startRow = (currentPage - 1) * pageSize + 1;
		jobNewsPaginationVO.setStartRow(startRow);

		int endRow = startRow + pageSize - 1;
		jobNewsPaginationVO.setEndRow(endRow);

		int count = newsDAOService.getJobCount();
		jobNewsPaginationVO.setCount(count);

		int number = count - (currentPage - 1) * pageSize;
		jobNewsPaginationVO.setNumber(number);

		if (count < startRow) {
			currentPage = currentPage - 1;
			startRow = (currentPage - 1) * pageSize + 1;
			endRow = startRow + pageSize - 1;
		}
		if (count > 0) {
			jobNewsList = newsDAOService.getJobNewsList(jobNewsPaginationVO);
		}
		jobNewsList = newsDAOService.getJobNewsList(jobNewsPaginationVO);
		result.addObject("jobNewsPaginationVO", jobNewsPaginationVO);
		result.addObject("jobNewsList", jobNewsList);
		result.setViewName("news/job_news_list");
		return result;
	}
	
	
	@RequestMapping("/insert.news")
	public ModelAndView insert(NewsVO newsVO) throws IOException {
		NewsCrawlDAOServiceImpl newsCrawlDAOService = new NewsCrawlDAOServiceImpl();
		ArrayList<CrawlNewsVO> list = newsCrawlDAOService.crawlNews();
		
		for (int i =0;i<list.size();i++) {
			System.out.println(list.get(i).titleVO);
		}
		
		// news = newsCrawlDAOService.newVOListDecompose(newsVOList);

		newsDAOService.insertNews(list, newsVO);

		ModelAndView result = new ModelAndView();
		// List<NewsVO> newsList = newsDAOService.getNewsList();
		int countnumber = newsDAOService.getCount();
		// result.addObject("newsList", newsList);
		result.addObject("countnumber", countnumber);
		result.setViewName("news/news_result");
		return result;

	}

	@RequestMapping("/updateForm.news")
	public ModelAndView updateForm(NewsVO news) {
		int num = news.getNum();
		news = newsDAOService.getNews(num);
		System.out.println("updateForm complete");

		ModelAndView result = new ModelAndView();
		result.addObject("news", news);
		result.setViewName("updateForm");
		return result;
	}

	@RequestMapping("/update.news")
	public ModelAndView update(NewsVO news) {
		newsDAOService.updateNews(news);
		System.out.println("update Complete");

		ModelAndView result = new ModelAndView();
		// List<NewsVO> newsList = newsDAOService.getNewsList();
		int countnumber = newsDAOService.getCount();
		// result.addObject("newsList", newsList);
		result.addObject("countnumber", countnumber);
		result.setViewName("list");
		return result;
	}

	@RequestMapping("/delete.news")
	public ModelAndView delete(NewsVO news) {
		int num = news.getNum();
		newsDAOService.deleteNews(num);
		System.out.println("delete Complete");

		ModelAndView result = new ModelAndView();
		// List<NewsVO> newsList = newsDAOService.getNewsList();
		int countnumber = newsDAOService.getCount();
		// result.addObject("newsList", newsList);
		result.addObject("countnumber", countnumber);
		result.setViewName("list");
		return result;
	}

	@RequestMapping(value = "/getReplyJSON.news", method = RequestMethod.POST, produces = "application/json; charset=UTF-8")
	@ResponseBody
	public String getReplyJSON(NewsVO news) {
		int num = news.getNum();
		List<ReplyVO> list = newsDAOService.getReplyJSON(num);
		
		String str = "";
		ObjectMapper mapper = new ObjectMapper(); // JSON�삎�떇�쑝濡� �뜲�씠�꽣瑜� 諛섑솚�븯湲� �쐞�빐 �궗�슜(pom.xml �렪吏�)
		try {
			str = mapper.writeValueAsString(list);
			// 由ъ뒪�듃�쓽 �엳�뒗 �뜲�씠�꽣瑜� JSON�삎�떇�쑝濡� 蹂��솚�떆�궓�떎.
			// list List<PeopleVO>�뿉 �젙�쓽�맂 �븘�뱶紐낆씠 json�뿉�꽌�뒗 key媛믪씠 �릺怨� �븘�뱶媛믪� value媛믪쑝濡� 蹂��솚�맂�떎.
		}

		catch (Exception e) {
			System.out.println("first() mapper : " + e.getMessage());
		}
		// @ResponseBody�뿉 �씠 �젙蹂닿� ���옣�맂�떎.
		return str;
	}

	@RequestMapping(value = "/insertReply.news", headers = {"Accept=text/xml, application/json"}, method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json; charset=UTF-8")
	@ResponseBody
	public Object insertReply(NewsVO vo, ReplyVO rvo) {
		Map<String, Object> retVal = new HashMap<String, Object>(); // 由ы꽩媛� ���옣
		
		int news_ref_num = vo.getNum();
		
		int maxrenum = 0;
		int ref = rvo.getRef();
		int re_level = rvo.getRe_level();
		int re_step = rvo.getRe_step();
		
		String replyid = rvo.getReplyid();
		String replybody = rvo.getReplybody();
		
		try {
			
			maxrenum = newsDAOService.getMaxReplyNum(news_ref_num);
			if (maxrenum != 0) {
				
				rvo.setRenum(maxrenum + 1);
				rvo.setNews_ref_num(news_ref_num);
				rvo.setRef(ref);
				rvo.setRe_level(re_level);
				rvo.setRe_step(re_step);
				
				newsDAOService.updateStepAndLevel(rvo);
				rvo.setReplyid(replyid);
				rvo.setReplybody(replybody);
				rvo.setRe_level(re_level + 1);
				rvo.setRe_step(re_step + 1);
			}
			else {
				rvo.setRenum(1);
				rvo.setNews_ref_num(news_ref_num);
				rvo.setRef(ref);
				rvo.setRe_level(re_level);
				rvo.setRe_step(re_step);
				rvo.setReplyid(replyid);
				rvo.setReplybody(replybody);
			}
			
			
			int res = newsDAOService.insertReply(rvo);
			System.out.println("insert res: " + res);
			retVal.put("res", "OK");
		} catch (Exception e) {
			retVal.put("res", "FAIL");
			retVal.put("message", "Failure");
		}
		return retVal;
		// return retVal;�뿉�꽌 �쟾�빐二쇰뒗 媛믪씠 view�씤吏� �븘�땶吏�瑜� @ResponseBody媛� 寃곗젙�빐以��떎
		// �뿬湲곗꽌�뒗 Model�씠�굹 ModelAndView瑜� 蹂대궡�뒗 寃껋씠 �븘�땲�씪 �뜲�씠�꽣�젙蹂대�� �쟾�떖�븯湲� �븣臾몄뿉
		// �씠 硫붿냼�뱶媛� 諛섑솚�떆�궎�뒗 媛믪씠 Model�씠�굹 ModelAndView媛� �븘�떂�쓣 紐낆떆�븯湲� �쐞�빐�꽌
		// @ResponseBody瑜� 瑗� 紐낆떆�빐以��떎..
		// �쓳�떟媛앹껜�뿉 body�뿉 �떞�븘�꽌 蹂대궡二쇰뒗 寃껋씠 �맂�떎.
	}
	
	
	@RequestMapping(value = "/insertKeyword.news", method = RequestMethod.POST, produces = "application/json; charset=UTF-8")
	@ResponseBody
	public Map<String, Object> insertKeyword(KeywordVO keywordVO) {
		Map<String, Object> retVal = new HashMap<String, Object>();
		int res = 0;
		
		
		try {
		res = newsDAOService.insertKeyword(keywordVO);
		System.out.println("insert res: " + res);
		retVal.put("res", "OK");
			
			
		} catch (Exception e) {
			retVal.put("res", "FAIL");
			retVal.put("message", "Failure");
		}
		return retVal;
	}
	
	@RequestMapping(value = "/getKeywordList.news", method = RequestMethod.GET, produces = "application/json; charset=UTF-8")
	@ResponseBody
	public String getKeywordList(KeywordVO keywordVO) {
		List<KeywordVO> list = newsDAOService.getKeywordList(keywordVO);
		
		String str = "";
		ObjectMapper mapper = new ObjectMapper(); 
		try {
			str = mapper.writeValueAsString(list);
		}

		catch (Exception e) {
			System.out.println("first() mapper : " + e.getMessage());
		}
		
		return str;
	}
	
	
	@RequestMapping(value = "/key_news_list.news")
	public ModelAndView getKeyNewsList(KeywordVO keywordVO, Model model, HttpServletRequest request) {
		System.out.println("keywordVO.getSearchInput = " + keywordVO.getSearchInput());
		ArrayList<NewsVO> keyNewsList = new ArrayList<NewsVO>();
		ModelAndView result = new ModelAndView();
		
		keyNewsList = newsDAOService.getKeyNewsList(keywordVO);
		result.addObject("keyNewsList", keyNewsList);
		result.setViewName("news/key_news_list");
		return result;
	}
}
