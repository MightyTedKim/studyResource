package com.spring.drone.gu;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class GuideDAOServiceImpl implements GuideDAOService {

	@Autowired
	private SqlSession sqlSession;

	@Override
	public ArrayList<GuideVO> getGuideList() {
		ArrayList<GuideVO> guideList = new ArrayList<GuideVO>();
		GuideMapper guideMapper = sqlSession.getMapper(GuideMapper.class);
		guideList = guideMapper.getGuideList();
		System.out.println(guideList);
		return guideList;
	}
	
	@Override
	public List<GuideVO> getGuide(GuideVO guideVO) {
		int num = guideVO.getNum();
		GuideMapper guideMapper = sqlSession.getMapper(GuideMapper.class);
		List<GuideVO> guideList = new ArrayList<GuideVO>();
		guideList = guideMapper.getGuide(num);
		return guideList;
	}

	@Override
	public GuideVO getOneGuide(GuideVO guideVO) {
		GuideMapper guideMapper = sqlSession.getMapper(GuideMapper.class);
		guideVO = guideMapper.getOneGuide(guideVO); 
		return guideVO;
	}

	@Override
	public void insertGuide(GuideVO guideVO) {
		GuideMapper guideMapper = sqlSession.getMapper(GuideMapper.class);
		guideMapper.insertGuide(guideVO);
	}

	@Override
	public void updateGuide(GuideVO guideVO) {
		GuideMapper guideMapper = sqlSession.getMapper(GuideMapper.class);
		guideMapper.updateGuide(guideVO);
		
	}

	@Override
	public int countPost() {
		GuideMapper guideMapper = sqlSession.getMapper(GuideMapper.class);
		int count = guideMapper.countPost();
		return count;
	}

}
