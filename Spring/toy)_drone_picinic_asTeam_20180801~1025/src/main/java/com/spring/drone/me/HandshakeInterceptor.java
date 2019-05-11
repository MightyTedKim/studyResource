package com.spring.drone.me;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.http.server.ServletServerHttpRequest;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.server.support.HttpSessionHandshakeInterceptor;

/* �����Ͽ��� HttpSession ��ü�� */ 
public class HandshakeInterceptor extends HttpSessionHandshakeInterceptor{

	@Override
	public boolean beforeHandshake(ServerHttpRequest request, ServerHttpResponse response, 
			WebSocketHandler wsHandler, Map<String, Object> map) throws Exception {
		
		//���� �Ķ���� ��, attribute �� ���� �����ϸ� ������ �ڵ鷯 Ŭ������ WebSocketSession�� ���޵ȴ�
		System.out.println("Before Handshake");
		ServletServerHttpRequest ssreq = (ServletServerHttpRequest) request;
		System.out.println("URI:" + request.getURI());
		HttpServletRequest req = ssreq.getServletRequest();
		String nickname = (String)req.getParameter("nickname");
		//HttpSession �� ����� �̿����� ���̵� �����ϴ� ���
		//String id = (String)req.getSession().getAttribute("id");
		//String id = "admin";
		map.put("userNickname", nickname);
		System.out.println("HttpSession�� ����� �г���:"+nickname);
		
		return super.beforeHandshake(request, response, wsHandler, map);
	}
	
	@Override
	public void afterHandshake(ServerHttpRequest request, ServerHttpResponse response, 
			WebSocketHandler wsHandler, Exception ex) {
		System.out.println("After Handshake");
		
		super.afterHandshake(request, response, wsHandler, ex);
	}
}