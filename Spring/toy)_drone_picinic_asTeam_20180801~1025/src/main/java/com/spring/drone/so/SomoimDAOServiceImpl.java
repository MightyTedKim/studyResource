package com.spring.drone.so;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.drone.co.CommMapper;
import com.spring.drone.news.ReplyVO;

@Service
public class SomoimDAOServiceImpl implements SomoimDAOService{
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insertSo(SomoimVO somoimVO) {
		SomoimMapper somoimMapper = sqlSession.getMapper(SomoimMapper.class);
		somoimMapper.insertSo(somoimVO);
	}

	@Override
	public int getSoNumByFounder(String founder) {
		SomoimMapper somoimMapper = sqlSession.getMapper(SomoimMapper.class);
		int result = somoimMapper.getSoNumByFounder(founder);
		return result;
	}

	@Override
	public int getSoNum() {
		SomoimMapper somoimMapper = sqlSession.getMapper(SomoimMapper.class);
		int result = somoimMapper.getSoNum();
		return result;
	}
	@Override
	public SomoimVO getSo(int num) {
		SomoimVO somoimVO = new SomoimVO();
		SomoimMapper somoimMapper = sqlSession.getMapper(SomoimMapper.class);
		somoimVO = somoimMapper.getSo(num);
		return somoimVO;
	}
	@Override
	public int getMaxNum(int somoim_num) {
		SomoimMapper somoimMapper = sqlSession.getMapper(SomoimMapper.class);
		int maxnum = somoimMapper.getMaxNum(somoim_num);
		return maxnum;
	}

	@Override
	public void updateStepAndLevel(SomoimPostVO somoimPostVO) {
		SomoimMapper somoimMapper = sqlSession.getMapper(SomoimMapper.class);
		somoimMapper.updateStepAndLevel(somoimPostVO);
	}

	@Override
	public int insertSomoimPost(SomoimPostVO somoimPostVO) {
		SomoimMapper somoimMapper = sqlSession.getMapper(SomoimMapper.class);
		int res = somoimMapper.insertSomoimPost(somoimPostVO);
		return res;
	}

	@Override
	public List<SomoimPostVO> getOnlyOnePost(SomoimPostVO somoimPostVO) {
		List<SomoimPostVO> somoimPostList = null;
		SomoimMapper somoimMapper = sqlSession.getMapper(SomoimMapper.class);
		somoimPostList = somoimMapper.getOnlyOnePost(somoimPostVO);
		return somoimPostList;
	}

	@Override
	public ArrayList<SomoimPostVO> getSomoimPostList(int num) {
		ArrayList<SomoimPostVO> somoimPostList = new ArrayList<SomoimPostVO>();
		SomoimMapper somoimMapper = sqlSession.getMapper(SomoimMapper.class);
		somoimPostList = somoimMapper.getSomoimPostList(num);
		return somoimPostList;
	}

	@Override
	public ArrayList<SomoimVO> getSoList() {
		ArrayList<SomoimVO> soList = new ArrayList<SomoimVO>();
		SomoimMapper somoimMapper = sqlSession.getMapper(SomoimMapper.class);
		soList = somoimMapper.getSoList();
		return soList;
	}

	@Override
	public List<SomoimPostVO> getSoPostAfter(SomoimPostVO somoimPostVO) {
		List<SomoimPostVO> soListAfter = null;
		SomoimMapper somoimMapper = sqlSession.getMapper(SomoimMapper.class);
		soListAfter = somoimMapper.getSoPostAfter(somoimPostVO);
		return soListAfter;
	}

	@Override
	public ArrayList<SomoimVO> getSixSoList() {
		ArrayList<SomoimVO> sixSoList = new ArrayList<SomoimVO>();
		SomoimMapper somoimMapper = sqlSession.getMapper(SomoimMapper.class);
		sixSoList = somoimMapper.getSixSoList();
		return sixSoList;
	}

	@Override
	public SomoimVO verifyFounder(SomoimVO somoimVO) {
		SomoimMapper somoimMapper = sqlSession.getMapper(SomoimMapper.class);
		somoimVO = somoimMapper.verifyFounder(somoimVO);
		return somoimVO;
	}

	@Override
	public int getPostCount() {
		SomoimMapper somoimMapper = sqlSession.getMapper(SomoimMapper.class);
		int count = somoimMapper.getPostCount();
		return count;
	}

	@Override
	public int getPostRefCount(SomoimPostVO somoimPostVO) {
		SomoimMapper somoimMapper = sqlSession.getMapper(SomoimMapper.class);
		int ref_count = somoimMapper.getPostRefCount(somoimPostVO);
		return ref_count;
	}

	@Override
	public int insertPost(SomoimPostVO somoimPostVO) {
		SomoimMapper somoimMapper = sqlSession.getMapper(SomoimMapper.class);
		int res = somoimMapper.insertPost(somoimPostVO);
		return res;
	}

	@Override
	public int deletePost(SomoimPostVO somoimPostVO) {
		SomoimMapper somoimMapper = sqlSession.getMapper(SomoimMapper.class);
		int res = somoimMapper.deletePost(somoimPostVO);
		return res;
	}

	@Override
	public ArrayList<SomoimPostVO> getPostList(SomoimPostVO somoimPostVO) {
		ArrayList<SomoimPostVO> somoimPostList = new ArrayList<SomoimPostVO>();
		SomoimMapper somoimMapper = sqlSession.getMapper(SomoimMapper.class);
		somoimPostList = somoimMapper.getPostList(somoimPostVO);
		return somoimPostList;
	}

	@Override
	public int modifyPost(SomoimPostVO somoimPostVO) {
		SomoimMapper somoimMapper = sqlSession.getMapper(SomoimMapper.class);
		int res = somoimMapper.modifyPost(somoimPostVO);
		return res;
	}

	@Override
	public int joinSo(SomoimVO somoimVO) {
		SomoimMapper somoimMapper = sqlSession.getMapper(SomoimMapper.class);
		int res = somoimMapper.joinSo(somoimVO);
		return res;
	}

	@Override
	public ArrayList<SMVO> getSMVOList(SomoimVO somoimVO) {
		SomoimMapper somoimMapper = sqlSession.getMapper(SomoimMapper.class);
		ArrayList<SMVO> smVOList = new ArrayList<SMVO>();
		smVOList = somoimMapper.getSMVOList(somoimVO);
		return smVOList;
	}
}
