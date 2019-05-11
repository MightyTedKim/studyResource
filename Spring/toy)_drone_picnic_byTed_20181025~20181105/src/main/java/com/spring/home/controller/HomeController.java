package com.spring.home.controller;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@RequestMapping(value = "/", method = RequestMethod.GET )
	public String start(RedirectAttributes rttr) throws Exception {	
		logger.info("start ...........");
		return "index";
	}

	@RequestMapping(value = "/index", method = RequestMethod.GET)
	public String index() throws Exception {	
		logger.info("index ...........");
		return "index";
	}
	@RequestMapping(value = "/about", method = RequestMethod.GET)
	public String about() throws Exception {	
		logger.info("about ...........");
		return "about";
	}

	@RequestMapping(value = "/board", method = RequestMethod.GET)
	public String board() throws Exception {	
		logger.info("board ...........");
		return "board/listPage";
	}
	
	@RequestMapping(value = "/contact", method = RequestMethod.GET)
	public String contact() throws Exception {	
		logger.info("contact ...........");
		return "contact";
	}
}
