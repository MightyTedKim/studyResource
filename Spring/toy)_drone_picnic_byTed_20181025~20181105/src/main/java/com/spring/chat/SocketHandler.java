package com.spring.chat;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

public class SocketHandler extends TextWebSocketHandler{
		
	private static final Logger logger = LoggerFactory.getLogger(SocketHandler.class);

	HttpServletRequest request;
	
	private Set<WebSocketSession> sessionSet = new HashSet<WebSocketSession>();
	private Map<WebSocketSession, String> nameMap = new HashMap<WebSocketSession, String>();
	private Map<WebSocketSession, String> regionMap = new HashMap<WebSocketSession, String>();
	private ArrayList<WebSocketSession> keys;
	
	public SocketHandler() {
		super();
		this.logger.info("create SocketHandler instance!");
	}

	//after connection Established
	public void afterConnectionEstablished(WebSocketSession session) throws Exception{
		super.afterConnectionEstablished(session);
			
		sessionSet.add(session);
		this.logger.info("afterConnectionEstablished, add session!");
		
		Map<String, Object> map = session.getAttributes();
		String uname = (String)map.get("uname");
		String region = (String)map.get("region");
		logger.info("afterConnection uname : " + uname);
		logger.info("afterConnection region : " + region);
		nameMap.put(session, uname);
		regionMap.put(session, region);		
		
		if(regionMap.containsValue(region)) {
			keys = getKey(regionMap, region);
		}
		
		String nameList="";
		for(WebSocketSession client_session : keys) {
			String name = nameMap.get(client_session);
			nameList += name + "/";
		}
		logger.info(nameList);
		
		for(WebSocketSession client_session : keys) {
			try {
			client_session.sendMessage(new TextMessage("nameList/"+ nameList));
			}catch(Exception ignored) {
				this.logger.error("fail to send message!", ignored);
			}
		}
	}
	
	//after connection closed
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) 
			throws Exception{
		this.logger.info("afterConnectionClosed, add session!");

		nameMap.remove(session);
		regionMap.remove(session);
		
		Map<String, Object> map = session.getAttributes();
		String region = (String)map.get("region");
		if(regionMap.containsValue(region)) {
			keys = getKey(regionMap, region);
		}		
		String nameList="";
		for(WebSocketSession client_session : keys) {
			String name = nameMap.get(client_session);
			nameList += name + "/";
		}		
		for(WebSocketSession client_session : keys) {
			try {
			client_session.sendMessage(new TextMessage("remove/"+ nameList));
			}catch(Exception ignored) {
				this.logger.error("fail to send message!", ignored);
			}
		}				
		super.afterConnectionClosed(session, status);
		logger.info(nameList);
	}
	
	public void handleMessage(WebSocketSession session, WebSocketMessage<?> message) throws Exception{
		super.handleMessage(session, message);
		logger.info("handleMessgge sendUser "); 
		Map<String, Object> map = session.getAttributes();
		String userName = (String)nameMap.get(session);
		String region = (String)map.get("region");

		if(regionMap.containsValue(region)) {
			keys = getKey(regionMap, region);
		}		
		for(WebSocketSession client_session : keys) {
			try {
			client_session.sendMessage(new TextMessage("message/"+userName+(String)message.getPayload()));
			}catch(Exception ignored) {
				this.logger.error("fail to send message!", ignored);
			}
		}
		logger.info("handleMessage: " + userName);		
	}
	
	public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception{
		this.logger.error("web socket error!", exception);
	}
	
	public boolean supportsPartialMessage() {
		this.logger.info("call method!");
		
		return false;
	}
	
	public ArrayList<WebSocketSession> getKey(Map<WebSocketSession, String> m, String value) { 
		ArrayList<WebSocketSession> keys = new ArrayList<WebSocketSession>();
		for(WebSocketSession o: m.keySet()) { 
			if(m.get(o).equals(value)) 
				keys.add(o); 
		} 
		return keys; 
	}

}