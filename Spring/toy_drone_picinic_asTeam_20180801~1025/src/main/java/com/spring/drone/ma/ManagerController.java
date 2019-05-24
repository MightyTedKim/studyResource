package com.spring.drone.ma;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.spring.drone.so.SomoimDAOService;
import com.spring.drone.so.SomoimVO;

@Controller
public class ManagerController {
	
	@Autowired
	private SomoimDAOService somoimDAOService;
	
	@RequestMapping("/manager_main.ma")
	public ModelAndView manager_main(SomoimVO somoimVO) {
		ModelAndView result = new ModelAndView();
		ArrayList<SomoimVO> soList = somoimDAOService.getSoList();
		result.addObject("soList", soList);
		result.setViewName("manager/manager_admin_main");
		return result;
	}
}
