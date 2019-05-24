package com.spring.drone.df;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
public class DroneController {
	
	@Autowired
	private DroneDAOService droneDAOService;
	
	@RequestMapping("/finder_main.df")
	public ModelAndView finder_main(DroneVO droneVO) {
		//ModelMap jsonResult = new ModelMap();
		ModelAndView result = new ModelAndView();
		ArrayList<DroneVO> droneList = new ArrayList<DroneVO>();
		droneList =	droneDAOService.getDroneList();
		ModelMap jsonResult = result.getModelMap();
		
		String jsonDroneList = null;
		try {
			jsonDroneList = new ObjectMapper().writeValueAsString(droneList);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		jsonResult.addAttribute("jsonDroneList", jsonDroneList); //data 전달 
		return new ModelAndView("df/finder_main", jsonResult); //VIEW PAGE 설정

	}	
}
	
