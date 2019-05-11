package com.spring.drone.pl;

import java.util.ArrayList;
import com.spring.drone.pl.PlaceVO;

public interface PlaceMapper {
	ArrayList<PlaceVO> getPlaceList();
	int placeRegister(PlaceVO placeVO);
}
