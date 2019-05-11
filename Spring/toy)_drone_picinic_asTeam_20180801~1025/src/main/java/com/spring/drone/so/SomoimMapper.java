package com.spring.drone.so;

import java.util.ArrayList;
import java.util.List;

public interface SomoimMapper {
	public void insertSo(SomoimVO somoinVO);
	public int getSoNumByFounder(String founder);
	public int getSoNum();
	public SomoimVO getSo(int num);
	public int getMaxNum(int somoim_num);
	public void updateStepAndLevel(SomoimPostVO somoimPostVO);
	public int insertSomoimPost(SomoimPostVO somoimPostVO);
	public List<SomoimPostVO> getOnlyOnePost(SomoimPostVO somoimPostVO);
	public ArrayList<SomoimPostVO> getSomoimPostList(int num);
	public ArrayList<SomoimVO> getSoList();
	public List<SomoimPostVO> getSoPostAfter(SomoimPostVO somoimPostVO);
	public ArrayList<SomoimVO> getSixSoList();
	public SomoimVO verifyFounder(SomoimVO somoimVO);
	public int getPostCount();
	public int getPostRefCount(SomoimPostVO somoimPostVO);
	public int insertPost(SomoimPostVO somoimPostVO);
	public int deletePost(SomoimPostVO somoimPostVO);
	public ArrayList<SomoimPostVO> getPostList(SomoimPostVO somoimPostVO);
	public int modifyPost(SomoimPostVO somoimPostVO);
	public int joinSo(SomoimVO somoimVO);
	public ArrayList<SMVO> getSMVOList(SomoimVO somoimVO);
}
