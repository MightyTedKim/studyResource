package com.spring.login.controller;

import java.util.Date;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.util.WebUtils;

import com.spring.login.LoginDTO;
import com.spring.login.UserVO;
import com.spring.login.service.UserService;

@Controller
@RequestMapping("/user")
public class UserController {
	private static final Logger logger = LoggerFactory.getLogger(UserController.class);

	@Inject
	private UserService service;

	@Inject
	private BCryptPasswordEncoder passwordEncoder;
//check
	@RequestMapping("/idCheck")
	@ResponseBody
	public int idCheck(@RequestBody String userid) throws Exception {  
        return service.idCheck(userid);
    }
//check
	@RequestMapping("/nickCheck")
	@ResponseBody
	public int nickCheck(@RequestBody String username) throws Exception {
		return service.nickCheck(username);
	}
 
	
//Create	
	@RequestMapping(value = "/page_loginRegister", method = RequestMethod.GET)
	public void loginRegister() {
		logger.info("regist get---------");	
	}
	
	@RequestMapping(value = "/post_loginRegister", method = RequestMethod.POST)
	public String loginRegister(UserVO userVO, RedirectAttributes ra) throws Exception{
		logger.info("regist POST---------");
		
		String encodePwd = passwordEncoder.encode(userVO.getUpw());
		userVO.setUpw(encodePwd);
		
		service.register(userVO);
		ra.addFlashAttribute("msg", "ȸ�����Կ� �����ϼ̽��ϴ�.");
		return "redirect:/user/page_login";
	}
	
//Read
	@RequestMapping(value = "/page_login", method = RequestMethod.GET)
	public void loginGET(@ModelAttribute("dto") LoginDTO dto) {
		logger.info("login get---------");	
	}
		
	@RequestMapping(value = "/post_login", method = RequestMethod.POST)
	public String loginPOST(LoginDTO dto, HttpSession session, Model model,
			RedirectAttributes ra) throws Exception{
		logger.info("login POST---------");
		UserVO vo = service.login(dto);
		System.out.println("passwordEncoder.matches(dto.getUpw(), vo.getUpw())= " + 
					passwordEncoder.matches(dto.getUpw(), vo.getUpw()));

		if (vo == null) {
			//1 failure
			ra.addFlashAttribute("msg", "로그인에 실패하셨습니다.");
			return "redirect:/user/page_login";			
		}else if(passwordEncoder.matches(dto.getUpw(), vo.getUpw())){
			//success
			if(dto.isUseCookie()) {//2 cookie save in DB
				int amount = 60* 60 * 24 * 7;
				Date sessionLimit = new Date(System.currentTimeMillis() + (1000*amount));
				service.keepLogin(vo.getUid(), session.getId(), sessionLimit);
			}
			model.addAttribute("userVO", vo); //for post interceptor
		}
		return null;//if success post loginInterceptors performs response.sendRedirect
	}
//logout
	@RequestMapping(value="/temp_logout", method=RequestMethod.GET)
	public String logout(HttpServletRequest request, HttpServletResponse response,HttpSession session,
			RedirectAttributes ra) throws Exception{
		Object obj = session.getAttribute("login");
		if (obj != null) {
			UserVO vo = (UserVO) obj;
			session.removeAttribute("login");
			session.invalidate();
			Cookie loginCookie = WebUtils.getCookie(request,  "loginCookie");
			
			if(loginCookie != null) {
				loginCookie.setPath("/");
				loginCookie.setMaxAge(0);
				response.addCookie(loginCookie);
				service.keepLogin(vo.getUid(), session.getId(), new Date());		
			}
		}		 
		ra.addFlashAttribute("msg", "로그아웃에 성공하셨습니다.");
		return "redirect:/index";
	}
	
	
	
}
