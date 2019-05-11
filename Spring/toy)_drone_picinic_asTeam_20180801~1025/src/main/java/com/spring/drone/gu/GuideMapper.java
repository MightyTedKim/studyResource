package com.spring.drone.gu;

import java.util.ArrayList;
import java.util.List;


public interface GuideMapper {
	public ArrayList<GuideVO> getGuideList();
	public List<GuideVO> getGuide(int num);
	public GuideVO getOneGuide(GuideVO guideVO);
	public void insertGuide(GuideVO guideVO);
	public void updateGuide(GuideVO guideVO);
	public int countPost();
}
