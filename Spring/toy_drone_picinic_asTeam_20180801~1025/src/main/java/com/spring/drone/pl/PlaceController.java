
package com.spring.drone.pl;

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

import com.spring.drone.pl.PlaceVO;

@Controller
public class PlaceController {
	
	@Autowired
	private PlaceDAOService placeDAOService;
	
	@RequestMapping("/place.pl")
	public ModelAndView place_main(Locale locale, Model model) {
		System.out.println(">PlaceController, place_main(Locale locale, Model model), 筌ｃ꺂苡뀐쭪占�?");
		ModelAndView result = new ModelAndView();
		ArrayList<PlaceVO> placeList = new ArrayList<PlaceVO>();
		placeList = placeDAOService.getPlaceList(); //placeDAOService 占쎌뵠占쎈짗
		result.addObject("placeList", placeList);
		result.setViewName("pl/place");

		System.out.println("<PlaceController, place_main(Locale locale, Model model), 占쎈あ甕곕뜆?占쏙옙, result: " + result);
		return result;
	}

	@RequestMapping("/place_list_specific.pl")
	public ModelAndView place_list_specific(Locale locale, Model model) {
		System.out.println(">PlaceController, place_list_specific");
		ModelAndView result = new ModelAndView();
		ArrayList<PlaceVO> placeList = new ArrayList<PlaceVO>();
		placeList = placeDAOService.getPlaceList(); //placeDAOService 占쎌뵠占쎈짗
		result.addObject("placeList", placeList);
		result.setViewName("pl/place_list_specific");

		System.out.println("<PlaceController, place_list_specific, result: " + result);
		return result;
	}
	
	@RequestMapping(value = "/placeRegister.pl", headers = {"Accept=text/xml, application/json"}, method = {RequestMethod.GET, RequestMethod.POST}, produces = "application/json; charset=UTF-8")
	@ResponseBody
	public Object placeRegister(PlaceVO vo) throws IOException {
		System.out.println(">PlaceController, placeRegister(PlaceVO vo), vo: " + vo);

		Map<String, Object> retVal = new HashMap<String, Object>();
		placeDAOService.placeRegister(vo);//placeDAOService
		retVal.put("res", "OK");
		
		System.out.println("<PlaceController, placeRegister(PlaceVO vo), 占쎈あ甕곕뜆?占쏙옙: " + retVal);
		return retVal;
	}
	
	@RequestMapping(value = "/getPlaceJSON.pl", method = RequestMethod.POST, produces = "application/json; charset=UTF-8")
	@ResponseBody
	public String getPlaceJSON(PlaceVO vo) {
		List<PlaceVO> list = placeDAOService.getPlaceJSON();
		
		String str = "";
		ObjectMapper mapper = new ObjectMapper();
		try {
			str = mapper.writeValueAsString(list);
		}
		catch (Exception e) {
			System.out.println("getPlaceJSON: " + e.getMessage());
		}
		return str;
	}
	
	
}
