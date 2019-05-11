package com.spring.drone.ap;

import java.util.ArrayList;
import java.util.List;

import com.spring.drone.ap.AppointVO;

public interface AppointDAOService {
	ArrayList<AppointVO> getAppointList();
	int appointRegister(AppointVO vo);
	List<AppointVO> getAppointJSON();
}
