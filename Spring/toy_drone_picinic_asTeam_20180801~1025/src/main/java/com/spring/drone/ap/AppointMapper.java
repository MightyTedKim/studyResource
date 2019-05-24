package com.spring.drone.ap;

import java.util.ArrayList;

public interface AppointMapper {
	ArrayList<AppointVO> getAppointList();
	int appointRegister(AppointVO appointVO);
}
