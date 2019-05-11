package com.spring.drone.ap;

import java.io.IOException;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class AppointController {
	
	@Autowired
	private AppointDAOService appointDAOService;

	@RequestMapping(value = "/appointRegister.ap", headers = {"Accept=text/xml, application/json"}, method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json; charset=UTF-8")
	@ResponseBody
	public Object AppointRegister(AppointVO vo) throws IOException {
		System.out.println(">AppointController, AppointRegister(AppointVO vo), vo.getUser_Id : " + vo.getUser_Id());
		Map<String, Object> retVal = new HashMap<String, Object>();//return value
		appointDAOService.appointRegister(vo);
		retVal.put("res", "OK");
		System.out.println("<AppointController, 	(AppointVO vo), retval : " + retVal);
		return retVal;
	}
	
	@RequestMapping(value = "/getAppointJSON.ap", method = RequestMethod.POST, produces = "application/json; charset=UTF-8")
	@ResponseBody
	public String getAppointJSON(AppointVO vo) {
		List<AppointVO> list = appointDAOService.getAppointJSON();
		String str = "";
		ObjectMapper mapper = new ObjectMapper();
		try {
			str = mapper.writeValueAsString(list);
		}
		catch (Exception e) {
			System.out.println("getAppointJSON: " + e.getMessage());
		}
		return str;
	}
	
}
