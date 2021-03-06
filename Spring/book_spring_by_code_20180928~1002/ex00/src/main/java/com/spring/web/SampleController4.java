package com.spring.web;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.bind.annotation.ModelAttribute;

@Controller
public class SampleController4 {
	private static final Logger logger =
		LoggerFactory.getLogger(SampleController4.class);
		 
	@RequestMapping("/doE")
	public String doD(RedirectAttributes rttr) { 
		logger.info("doE called but rediredct to /doF-----------");
		rttr.addFlashAttribute("msg", "This is the Message, with redirected");
		return "redirect:/doF";
	}
	
	@RequestMapping("/doF")
	public void doF(@ModelAttribute String msg) {
		logger.info("dof called --------" + msg);
	}
}
