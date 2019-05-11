package com.spring.chat;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.http.server.ServletServerHttpRequest;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.server.support.HttpSessionHandshakeInterceptor;

import com.spring.login.UserVO;
import com.spring.login.interceptor.AuthInterceptor;

public class HandshakeInterceptor extends HttpSessionHandshakeInterceptor{
	private static final Logger logger = LoggerFactory.getLogger(HandshakeInterceptor.class);

	public boolean beforeHandshake(ServerHttpRequest request, ServerHttpResponse response,
			WebSocketHandler wshandler, Map<String, Object> map) throws Exception{
		logger.info("Before Handshake");
		ServletServerHttpRequest ssreq = (ServletServerHttpRequest) request;
		
		HttpServletRequest req = ssreq.getServletRequest();
		String region = (String)req.getParameter("region");
		UserVO vo = (UserVO) req.getSession().getAttribute("login");
		String uname = vo.getUname();

		map.put("uname", uname);
		map.put("region", region);

		logger.info("URI : " + request.getURI());
		logger.info("region:" + region);
		logger.info("vo:" + vo);
		logger.info("uname:" + uname);

		return super.beforeHandshake(request, response, wshandler, map);
	}
	
	public void afterHandshake(ServerHttpRequest request, ServerHttpResponse response,
			WebSocketHandler wshandler, Exception ex) {
		logger.info("After Handshake");
		
		super.afterHandshake(request, response, wshandler, ex);
	}

}
