package com.spring.drone.pl;
import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.drone.pl.PlaceMapper;
import com.spring.drone.pl.PlaceVO;

@Service
public class PlaceDAOServiceImpl implements PlaceDAOService{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public ArrayList<PlaceVO> getPlaceList() {
		System.out.println(">PlaceDAOServiceImpl, getPlaceList(), ù��°" );
		ArrayList<PlaceVO> placeList = new ArrayList<PlaceVO>();
		System.out.println("getPlaceList:sqlSession=" + sqlSession);

		PlaceMapper placeMapper = sqlSession.getMapper(PlaceMapper.class);
		placeList = placeMapper.getPlaceList();
		System.out.println("<PlaceDAOServiceImpl, getPlaceList(), �ι�°, placeList:" + placeList );
		return placeList;
	}
	

	@Override
	public int placeRegister(PlaceVO vo) {
		System.out.println(">PlaceDAOServiceImpl, placeRegister(PlaceVO vo), ù��°, vo: " + vo);
		System.out.println("PlaceDAOServiceImpl, placeRegister(PlaceVO vo), ù��°, vo.getUser_Id(): " + vo.getUser_Id());		
		System.out.println("PlaceDAOServiceImpl, placeRegister(PlaceVO vo), ù��°, vo.getPlace_Coord(): " + vo.getPlace_Coord());
		System.out.println("PlaceDAOServiceImpl, placeRegister(PlaceVO vo), ù��°, vo.getPlace_Add(): " + vo.getPlace_Add());
		System.out.println("PlaceDAOServiceImpl, placeRegister(PlaceVO vo), ù��°, vo.getPlace_Name(): " + vo.getPlace_Name());
		System.out.println("PlaceDAOServiceImpl, placeRegister(PlaceVO vo), ù��°, vo.getPlace_Desc(): " + vo.getPlace_Desc());
		System.out.println("PlaceDAOServiceImpl, placeRegister(PlaceVO vo), ù��°, vo.getPlace_Cate(): " + vo.getPlace_Cate());

		System.out.println("placeRegister:sqlSession=" + sqlSession);
		PlaceMapper placeMapper = sqlSession.getMapper(PlaceMapper.class);
		System.out.println("BBBB");
		System.out.println("PlaceDAOServiceImpl, placeRegister(PlaceVO vo), ù��°,placeMapper: " + placeMapper);
		int res = placeMapper.placeRegister(vo);
		System.out.println("<PlaceDAOServiceImpl, placeRegister(PlaceVO vo), �ι�°, res: " + res);
		return res;
	}
	
	@Override
	public List<PlaceVO> getPlaceJSON() {
		PlaceMapper placeMapper = sqlSession.getMapper(PlaceMapper.class);
		List<PlaceVO> placeList = placeMapper.getPlaceList();
		return placeList;
	}
}
