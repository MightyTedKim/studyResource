package com.spring.drone.ap;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.drone.ap.AppointMapper;
import com.spring.drone.ap.AppointVO;

@Service
public class AppointDAOServiceImpl implements AppointDAOService{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public ArrayList<AppointVO> getAppointList() {
		System.out.println(">AppointDAOServiceImpl, getAppointList(), ù��°" );
		ArrayList<AppointVO> appointList = new ArrayList<AppointVO>();
		AppointMapper appointMapper = sqlSession.getMapper(AppointMapper.class);
		
		appointList = appointMapper.getAppointList();
		System.out.println("<AppointDAOServiceImpl, getAppointList(), �ι�°, appointList:" + appointList );
		return appointList;
	}
	

	@Override
	public int appointRegister(AppointVO vo) {
		System.out.println(">AppointDAOServiceImpl, appointRegister(AppointVO vo), ù��°, vo: " + vo);
		System.out.println(">AppointDAOServiceImpl, appointRegister(AppointVO vo), ù��°, vo.getAppoint_Title(): " + vo.getAppoint_Title());		
		System.out.println(">AppointDAOServiceImpl, appointRegister(AppointVO vo), ù��°, vo.getgetUser_Id(): " + vo.getUser_Id());		
		AppointMapper appointMapper = sqlSession.getMapper(AppointMapper.class);
		
		int res = appointMapper.appointRegister(vo);
		
		System.out.println("<AppointDAOServiceImpl, appointRegister(AppointVO vo), �ι�°, res: " + res);
		return res;
	}
	
	@Override
	public List<AppointVO> getAppointJSON() {
		AppointMapper appointMapper = sqlSession.getMapper(AppointMapper.class);
		List<AppointVO> appointList = appointMapper.getAppointList();
		return appointList;
	}
}
