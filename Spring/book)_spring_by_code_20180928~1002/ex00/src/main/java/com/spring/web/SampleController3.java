package com.spring.web;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import com.spring.domain.ProductVO;

@Controller
public class SampleController3 {
	private static final Logger logger =
		LoggerFactory.getLogger(SampleController3.class);
		 
	@RequestMapping("/doD")
	public String doD(Model model) {
		//make sample data
		ProductVO product = new ProductVO("Sample Product", 100000);
			
		logger.info("doD");
		
		model.addAttribute(product);
		return "productDetail";
	}
}
