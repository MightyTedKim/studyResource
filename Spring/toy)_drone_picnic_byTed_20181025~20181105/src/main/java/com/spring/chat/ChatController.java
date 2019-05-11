package com.spring.chat;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.album.controller.AlbumController;

@Controller
public class ChatController {
	private static final Logger logger = LoggerFactory.getLogger(ChatController.class);

	@RequestMapping(value ="/chat_team.ch")
	public String chat_team(HttpServletRequest request, Model model) {
		String region = request.getParameter("region");
		model.addAttribute("region", region);
		logger.info("region : " + region);
		return "./chat/chat_team";
	}

}
