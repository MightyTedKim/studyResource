package com.spring.drone.so;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.spring.drone.co.AlbumReplyVO;
import com.spring.drone.co.AlbumVO;
import com.spring.drone.me.MemberVO;
import com.spring.drone.news.NewsVO;
import com.spring.drone.news.ReplyVO;



@Controller
public class SomoController {
	
	@Autowired
	private SomoimDAOService somoimDAOService;

	
	@RequestMapping("/make_so.somo")
	public String make_so(){
		
		
		return "so/make_so";
	}
	
	@RequestMapping("/insertSo.somo")
	public ModelAndView fileUpload1(HttpServletRequest request, SomoimVO somoimVO, HttpSession session, HttpServletResponse response) throws Exception{
		String founder_nickname = somoimVO.getNickname();
		ModelAndView result = new ModelAndView();
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter writer = response.getWriter();
		
		int numByFounder = somoimDAOService.getSoNumByFounder(somoimVO.getFounder());
		System.out.println("numByFounder=" + numByFounder);
		if (numByFounder > 5) {
			writer.write("<script> alert('소모임은 5개 이상 창설하실 수 없습니다.'); location.href='template.templ?page=make_so.somo';</script>");
		}
		int num = somoimDAOService.getSoNum() + 1;
		somoimVO.setNum(num);
		
		MultipartFile mf = somoimVO.getFile();
		System.out.println("mf : " + mf);
		long size = mf.getSize();
        if(size >= 10485760) {
        	writer.write("<script> alert('10메가 이상의 파일은 올리실 수 없습니다.');location.href='template.templ?page=make_so.somo';</script>");
        }
		
		String uploadPath = "C:\\BigDeep\\upload\\somo_logo\\";
		String originalName = mf.getOriginalFilename();
		System.out.println("originalName : " + originalName);
		String originalFileExtension = mf.getOriginalFilename().substring(mf.getOriginalFilename().lastIndexOf("."));
		String storedFileName = UUID.randomUUID().toString().replaceAll("-", "") +
				originalFileExtension;

		if(mf.getSize() != 0) {
			System.out.println("사진메시지");
			mf.transferTo(new File(uploadPath+storedFileName));
		}
		somoimVO.setUploadPath(uploadPath);
		somoimVO.setStoredFileName(storedFileName);
		somoimVO.setOriginalName(originalName);
		somoimVO.setFilesize(String.valueOf(size));
		somoimDAOService.insertSo(somoimVO);

		somoimVO = somoimDAOService.getSo(num);
		ArrayList<SomoimPostVO> somoimPostList = somoimDAOService.getSomoimPostList(num);
		somoimVO.setId(somoimVO.getFounder());
		somoimVO.setNickname(founder_nickname);
		int res = somoimDAOService.joinSo(somoimVO);
		
		/*else {
			writer.write("<script> alert('소모임 창설 실패');location.href='./template.templ?page=make_so.somo';</script>");
		}*/
		result.addObject("somoimPostList", somoimPostList);
		result.addObject("somoimVO", somoimVO);
		
		ArrayList<SMVO> smVOList = new ArrayList<SMVO>();
		smVOList = somoimDAOService.getSMVOList(somoimVO);
		result.addObject("smVOList", smVOList);
		
		result.setViewName("so/detail");
		return result;
	}
	
	
	@RequestMapping("/joinSo.somo")
	public void joinSo(SomoimVO somoimVO, HttpServletResponse response){
		System.out.println("somoimVO.getNickname() = " + somoimVO.getNickname());
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter writer = null;
		try {
			writer = response.getWriter();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		int res = somoimDAOService.joinSo(somoimVO);
		if (res != 0) {
			writer.write("<script> alert('소모임 가입 완료');location.href='template.templ?page=somoim_detail.somo?num=" + somoimVO.getNum() + "';</script>");
		}
		else{
			writer.write("<script> alert('소모임 가입 실패');location.href='template.templ?page=somoim_detail.somo?num=" + somoimVO.getNum() + "';</script>");
		}
	}
	
	
	@RequestMapping(value = "/insertPost.somo", method = RequestMethod.POST, produces = "application/json; charset=UTF-8")
	@ResponseBody
	public Map<String, Object> insertPost(SomoimPostVO somoimPostVO) {
		Map<String, Object> retVal = new HashMap<String, Object>();
		int re_step = somoimPostVO.getRe_step();
		int re_level = somoimPostVO.getRe_level();
		int ref = somoimPostVO.getRef();
		int num = somoimPostVO.getNum();
		int count = somoimDAOService.getPostCount() + 1;
		somoimPostVO.setNum(count);
		if (ref == 0) {
			somoimPostVO.setRef(count);
			somoimPostVO.setRe_step(0);
			somoimPostVO.setRe_level(0);
		}
		else {
			System.out.println("ref : " + ref);
			somoimPostVO.setRef(ref);
			
			int ref_count = somoimDAOService.getPostRefCount(somoimPostVO);
			
			System.out.println("ref_count + 1 : " + (ref_count));

			somoimPostVO.setRe_step(ref_count + 1);
			somoimPostVO.setRe_level(re_level + 1);
		}
		
		try {
		int res = somoimDAOService.insertPost(somoimPostVO);
		System.out.println("insert res: " + res);
		retVal.put("res", "OK");
			
			
		} catch (Exception e) {
			retVal.put("res", "FAIL");
			retVal.put("message", "Failure");
		}
		return retVal;
	}
	
	@RequestMapping(value = "/deletePost.somo", method = RequestMethod.GET, produces = "application/json; charset=UTF-8")
	@ResponseBody
	public Map<String, Object> deletePost(SomoimPostVO somoimPostVO) {
		Map<String, Object> retVal = new HashMap<String, Object>();
		System.out.println("somoimPostVO.getNum() : " + somoimPostVO.getNum());
		try {
			int res = somoimDAOService.deletePost(somoimPostVO);
			if (res != 0) {
				System.out.println("insert res: " + res);
				retVal.put("res", "OK");
			}
			else {
				retVal.put("res", "FAIL");
			}
			
		} catch (Exception e) {
			retVal.put("res", "FAIL");
			retVal.put("message", "Failure");
		}
		return retVal;
	}
	
	
	@RequestMapping(value = "/modifyPost.somo", method = RequestMethod.POST, produces = "application/json; charset=UTF-8")
	@ResponseBody
	public Map<String, Object> modifyPost(SomoimPostVO somoimPostVO) {
		Map<String, Object> retVal = new HashMap<String, Object>();
		System.out.println("somoimPostVO.getRenum() : " + somoimPostVO.getNum());
		try {
			int res = somoimDAOService.modifyPost(somoimPostVO);
			if (res != 0) {
				System.out.println("insert res: " + res);
				retVal.put("res", "OK");
			}
			else {
				retVal.put("res", "FAIL");
			}
			
		} catch (Exception e) {
			retVal.put("res", "FAIL");
			retVal.put("message", "Failure");
		}
		return retVal;
	}
	
	@RequestMapping(value = "/getPostList.somo", method = RequestMethod.GET, produces = "application/json; charset=UTF-8")
	@ResponseBody
	public String getPostList(SomoimPostVO somoimPostVO) {
		System.out.println(somoimPostVO.getSomoim_num());
		ArrayList<SomoimPostVO> list = somoimDAOService.getPostList(somoimPostVO);
		
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
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	@RequestMapping(value = "/insertSomoimPost.somo", method = RequestMethod.POST, produces = "application/json; charset=UTF-8")
	@ResponseBody
	public Map<String, Object> insertSomoimPost(SomoimPostVO somoimPostVO) {
		System.out.println("�떆�뿕");
		Map<String, Object> retVal = new HashMap<String, Object>();
			
		int somoim_num = somoimPostVO.getSomoim_num();
		System.out.println(somoim_num);
		int num = 0;
		int ref = somoimPostVO.getRef();
		int re_level = somoimPostVO.getRe_level();
		int re_step = somoimPostVO.getRe_step();
		//int getReNum = 0;
		String id = somoimPostVO.getId();
		String body = somoimPostVO.getBody();
		
		try {
			//getReNum = newsDAOService.getReNum(news_ref_num);
			num = somoimDAOService.getMaxNum(somoim_num);
			if (num != 0) {
				
				somoimPostVO.setNum(num + 1);
				somoimPostVO.setSomoim_num(somoim_num);
				somoimPostVO.setRef(ref);
				somoimPostVO.setRe_level(re_level);
				somoimPostVO.setRe_step(re_step);
				
				somoimDAOService.updateStepAndLevel(somoimPostVO);
				somoimPostVO.setId(id);
				somoimPostVO.setBody(body);
				somoimPostVO.setRe_level(re_level + 1);
				somoimPostVO.setRe_step(re_step + 1);
				retVal.put("num", num + 1);
				retVal.put("somoim_num", somoim_num);
			}
			else {
				somoimPostVO.setNum(1);
				somoimPostVO.setSomoim_num(somoim_num);
				somoimPostVO.setRef(ref);
				somoimPostVO.setRe_level(re_level);
				somoimPostVO.setRe_step(re_step);
				somoimPostVO.setId(id);
				somoimPostVO.setBody(body);
				retVal.put("num", 1);
				retVal.put("somoim_num", somoim_num);
			}
			
			int res = somoimDAOService.insertSomoimPost(somoimPostVO);
			System.out.println("insert res: " + res);
			retVal.put("res", "OK");
			
			
		} catch (Exception e) {
			retVal.put("res", "FAIL");
			retVal.put("message", "Failure");
		}
		return retVal;
	}
	
	
	
	@RequestMapping(value = "/getOnlyOnePost.somo", method = RequestMethod.GET, produces = "application/json; charset=UTF-8")
	@ResponseBody
	public String getOnlyOnePost(SomoimPostVO somoimPostVO) {
		 
		List<SomoimPostVO> list = somoimDAOService.getOnlyOnePost(somoimPostVO);
	
		
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
	

	@RequestMapping("/somoim_detail.somo")
	public ModelAndView somoim_detail(SomoimVO somoimVO, SomoimPostVO somoimPostVO, SMVO sMVO, HttpServletResponse response){
		ModelAndView result = new ModelAndView();
		int num = somoimVO.getNum();
		ArrayList<SomoimPostVO> somoimPostList = somoimDAOService.getSomoimPostList(num);
		somoimVO = somoimDAOService.getSo(num);
		ArrayList<SMVO> smVOList = new ArrayList<SMVO>();
		smVOList = somoimDAOService.getSMVOList(somoimVO);
		result.addObject("somoimPostList", somoimPostList);
		result.addObject("somoimVO", somoimVO);
		result.addObject("smVOList", smVOList);
		result.setViewName("so/detail");
		
		return result;
	}

	
	@RequestMapping(value = "/getSoPostAfter.somo", method = RequestMethod.GET, produces = "application/json; charset=UTF-8")
	@ResponseBody
	public String getSoPostAfter(SomoimPostVO somoimPostVO) {
/*		System.out.println(somoimPostVO.getSomoim_num());
		System.out.println(somoimPostVO.getStartNum());
		System.out.println(somoimPostVO.getEndNum());
		System.out.println("�뀕�뀕");*/
		String str = "";
		List<SomoimPostVO> list = somoimDAOService.getSoPostAfter(somoimPostVO);

		if (list.size() == 0) {
			str = "";
		}
		
		ObjectMapper mapper = new ObjectMapper(); 
		try {
			str = mapper.writeValueAsString(list);
		}
		catch (Exception e) {
			System.out.println("first() mapper : " + e.getMessage());
		}
		return str;
	}
	
}
