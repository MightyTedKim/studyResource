package com.spring.drone.df;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class DroneDAOServiceImpl implements DroneDAOService {
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public ArrayList<DroneVO> getDroneList() {
		DroneMapper droneMapper = sqlSession.getMapper(DroneMapper.class);
		ArrayList<DroneVO> droneList = droneMapper.getDroneList();
		return droneList;
	}

}
