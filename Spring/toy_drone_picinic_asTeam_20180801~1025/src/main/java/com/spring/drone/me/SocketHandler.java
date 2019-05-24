package com.spring.drone.me;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

//�������� SocketHandler ����
//Websocket���� �������� ���μ����� ������ �� �ִ�.
public class SocketHandler extends TextWebSocketHandler{

	private final Logger logger = LogManager.getLogger(getClass());
	HttpServletRequest request;
	
	//�����ϴ� ����ڿ� ���� ������ �����ϱ� ���� ����
	private Set<WebSocketSession> sessionSet = new HashSet<WebSocketSession>();
	private Map<WebSocketSession, String> NicknameMap = new HashMap<WebSocketSession, String>();
	
	public SocketHandler (){
		super();
		this.logger.info("create SocketHandler instance");
	}
	
	//Ŭ���̾�Ʈ���� ������ ������ ��� �߻��ϴ� �̺�Ʈ
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception{
		super.afterConnectionClosed(session, status);
		
		sessionSet.remove(session);
		this.logger.info("remove session");
	}
	
	//Ŭ���̾�Ʈ���� ������ �Ͽ� ������ ��� �߻��ϴ� �̺�Ʈ
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception{
		super.afterConnectionEstablished(session);
		
		sessionSet.add(session);
		this.logger.info("add session");
		
		Map<String, Object> map = session.getAttributes();
		String userNickname = (String)map.get("userNickname");
		System.out.println("afterConnection userNickname : " + userNickname);
		NicknameMap.put(session, userNickname);
		String nicknameList="";
		for(WebSocketSession client_session : sessionSet) {
			String nickname = NicknameMap.get(client_session);
			nicknameList += nickname + "/";
		}
		System.out.println(nicknameList);
		
		for(WebSocketSession client_session : sessionSet) {
			try {
			client_session.sendMessage(new TextMessage("nicknameList/"+ nicknameList));
			}catch(Exception ignored) {
				this.logger.error("fail to send message!", ignored);
			}
		}
	}
	
	//Ŭ���̾�Ʈ���� send�� �̿��ؼ� �޽��� �߼��� �� ��� �̺�Ʈ �ڵ鸵
	@Override
	public void handleMessage(WebSocketSession session, WebSocketMessage<?> message) throws Exception{
		super.handleMessage(session, message);
		
		//session.getAttributes() : HandshakeInterceptor�� beforeHandshake()�޼ҵ忡�� ������ map�� �����´�.
		Map<String, Object> map = session.getAttributes();
		String userNickname = (String)map.get("userNickname");
		System.out.println("������ �г���:" + userNickname);
		
		for(WebSocketSession client_session : sessionSet) {
			try {
			client_session.sendMessage(new TextMessage("message/"+(String)message.getPayload()));
			}catch(Exception ignored) {
				this.logger.error("fail to send message!", ignored);
			}
		}
		
		for (WebSocketSession client_session: this.sessionSet) {
			if (client_session.isOpen()) {
				try {
					client_session.sendMessage(message);
				}catch(Exception ignored) {
					this.logger.error("fail to send message", ignored);
				}
			}
		}
	}
	
	//���� ���� �߻��� �� ȣ��
	@Override
	public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
		this.logger.error("web socket error", exception);
	}
	
	//�޽����� �� ��� �����ؼ� ���� �� �ִ��� ���θ� �����ϴ� �޼ҵ�
	@Override
	public boolean supportsPartialMessages() {
		this.logger.info("call method");
		
		return false;
	}
}