package com.spring.drone.pl;

import java.util.ArrayList;
import java.util.List;

import com.spring.drone.pl.PlaceVO;

public interface PlaceDAOService {
	ArrayList<PlaceVO> getPlaceList();
	int placeRegister(PlaceVO vo);
	List<PlaceVO> getPlaceJSON();
}
