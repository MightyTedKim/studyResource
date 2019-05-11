package com.spring.login.interceptor;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.util.WebUtils;

import com.spring.login.UserVO;
import com.spring.login.service.UserService;

public class AuthInterceptor extends HandlerInterceptorAdapter{
	private static final Logger logger = LoggerFactory.getLogger(AuthInterceptor.class);
	private static final String LOGIN = "login";

	@Inject
	private UserService service;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response,
			Object handler) throws Exception {
		logger.info("preHandle handle---auth---------------===");
		HttpSession session = request.getSession();
		
		if(session.getAttribute(LOGIN) == null) {
			logger.info("current user is not logined");
			saveDest(request);
			//cookie
			Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");
			logger.info("loginCookie= " + loginCookie);

			if(loginCookie != null) {
				logger.info("loginCookie has value, logined in past week");
				UserVO userVO = service.checkLoginBefore(loginCookie.getValue());
				
				logger.info("userVO= " + userVO);
				if(userVO != null) {
					logger.info("extracted userVO info from cookie, will put in session");
					session.setAttribute("login",  userVO);
					return true;
				}
			}
			response.sendRedirect("/user/page_login");
			return false;
		}
		return true;
	}
	
	private void saveDest(HttpServletRequest req) {
		String uri = req.getRequestURI();
		String query = req.getQueryString();
		logger.info("saveDest in, uri=" + uri);
		logger.info("saveDest in, query=" + query);
		
		if (query == null || query.equals("null")) {
			query = "";
		}else {
			query = "?" + query;
		}
		if (req.getMethod().equals("GET")) {
			req.getSession().setAttribute("dest", uri + query);
		}
		logger.info("saveDest, dest= " + (uri + query));
	}
}
