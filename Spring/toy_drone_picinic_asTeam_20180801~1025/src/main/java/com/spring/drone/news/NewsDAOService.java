package com.spring.drone.news;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class NewsDAOService implements NewsDAO {
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public ArrayList<NewsVO> getNewsList(int startRow, int endRow) {
		System.out.println(">NewsDAOService, getNewsList, startRow: " + startRow); 
//@RequestParam(value = "startRow", required = false) Integer startRow, @RequestParam(value = "endRow", required = false) Integer endRow
		ArrayList<NewsVO> newsList = new ArrayList<NewsVO>();
		NewsMapper newsMapper = sqlSession.getMapper(NewsMapper.class);
		//占식띰옙占쏙옙庫占� 占쏙옙占쏙옙占쏙옙占쏙옙占신э옙占쏙옙占�..
		//MemberMapper.class占쏙옙 MemberMapper.java(占쏙옙占쏙옙占쏙옙占싱쏙옙)占쏙옙 占쏙옙占쏙옙킨占쏙옙.
		//MemberMapper.java占쏙옙 占쌍댐옙 占쌨소듸옙占쏙옙 MemberMapper.xml占쏙옙 占쌍댐옙 占쌨소듸옙占쏙옙 占쏙옙占쏙옙占쌔억옙
		//占쏙옙 占쌨소듸옙占쏙옙占� 호占쏙옙占쌔쇽옙 占쏙옙占쏙옙構占� 占싫댐옙.
		//getMembers()占쏙옙 占쌨소듸옙占쏙옙 mapper.xml占쏙옙 id占쏙옙 占쏙옙占쏙옙占쌔억옙 占싼댐옙.
		newsList = newsMapper.getNewsList(startRow, endRow);
	
		//memberList = memberMapper.getMembers("tab_mybatis");
		//MemberMapper.xml占쏙옙 占쏙옙占쏙옙占쏙옙占쌔댐옙.
		return newsList;
	}


	@Override
	public void insertNews(ArrayList<CrawlNewsVO> list, NewsVO newsVO) {
		NewsMapper newsMapper = sqlSession.getMapper(NewsMapper.class);
		int res;
		int count = 0;
		
		//비슷한 단어가 4개인 경우 인서트 생략
		//ArrayList<String[]> splitedTitle = new ArrayList<String[]>();
		/*//splitedTitle = null;
		for (int i = 0;i < list.size();i++) {
			splitedTitle.add(list.get(i).titleVO.split("\\s+"));
		}*/
		for (int i = 0;i <list.size();i++) {
			String[] x = list.get(i).titleVO.split("\\s+");
			
			for (int y = 0;y<list.size();y++) {
				if (i >= list.size())
					break;
				if(i == y)  
					continue;
				else {
					/*System.out.println(" list.size() = " + list.size());
					System.out.println(" i = " + i);
					System.out.println(" y = " + y);*/
					String[] x2 = list.get(y).titleVO.split("\\s+");
					if (x.length <= 1 | x2.length <= 1) {
						continue;
					}
					else {
						if (x[0].equals(x2[0]) & x[1].equals(x2[1])) {
							list.remove(y);
						}
					}
				}
			}
		}
		for (int x = 0;x < list.size();x++) {
			System.out.println(list.get(x).urlVO);
			System.out.println(list.get(x).titleVO);
			
			newsVO.setUrl(list.get(x).urlVO);
			newsVO.setTitle(list.get(x).titleVO);
			newsVO.setSource(list.get(x).sourceVO);
			newsVO.setBody(list.get(x).bodyVO);
			newsMapper.insertNews(newsVO);
		}
		
		
		
		/*	if (i == splitedTitle.size()) {
				break;
			}
			else {
				String[] x2 = splitedTitle.get(i+1);
				if (x[0].equals(x2[0]) & x[1].equals(x2[1])) {
					splitedTitle.remove(i);
				}
				else {
					
				}
			}*/
		//}
		
		//res = newsMapper.insertNews(newsVO);	
			
			
			/*y = i;
			System.out.println("y = i; === " + y);
			while (true) {
				String[] x2 = splitedTitle.get(y+1);
				System.out.println("x[0] === " + x[0]);
				System.out.println("x[1] === " + x[1]);
				System.out.println("x2[0] === " + x2[0]);
				System.out.println("x2[1] === " + x2[1]);
				if (x[0].equals(x2[0]) && x[1].equals(x2[1])) {
					y++;
					
				}
				else {
					break;
				}
			}
			newsVO.setUrl(list.get(i).urlVO);
			newsVO.setTitle(list.get(i).titleVO);
			newsVO.setSource(list.get(i).sourceVO);
			newsVO.setBody(list.get(i).bodyVO);
			res = newsMapper.insertNews(newsVO);
			i = y;*/
			
		//}
		
		//int res = newsMapper.insertNews(newsVOList);
		//System.out.println("inserted articles count =" + count);
	}


	
	@Override
	public NewsVO getNews(int num) {
		NewsVO news = new NewsVO();
		NewsMapper newsMapper = sqlSession.getMapper(NewsMapper.class);
		news = newsMapper.getNews(num);
		return news;
	}
	
	@Override
	public int getCount() {
		System.out.println(">NewsDAOService, getCount");
		NewsMapper newsMapper = sqlSession.getMapper(NewsMapper.class);
		System.out.println(">NewsDAOService, newsMapper: " + newsMapper);
		int count = newsMapper.getCount();
		System.out.println("<NewsDAOService, count: " + count);
		return count;
	}

	@Override
	public void updateNews(NewsVO news) {
		NewsMapper newsMapper = sqlSession.getMapper(NewsMapper.class);
		newsMapper.updateNews(news);
	}

	@Override
	public void deleteNews(int num) {
		NewsMapper newsMapper = sqlSession.getMapper(NewsMapper.class);
		newsMapper.deleteNews(num);
	}

	@Override
	public void addReadcount(int num, int readcount) {
		NewsMapper newsMapper = sqlSession.getMapper(NewsMapper.class);
		newsMapper.addReadcount(num, readcount);
		
	}


	@Override
	public int insertReply(ReplyVO replyVO) {
		NewsMapper newsMapper = sqlSession.getMapper(NewsMapper.class);
		int res = newsMapper.insertReply(replyVO);
		return res;
		
	}
	
	@Override
	public List<ReplyVO> getReplyJSON(int num) {
		List<ReplyVO> newsReplyList = null;
		NewsMapper newsMapper = sqlSession.getMapper(NewsMapper.class);
		newsReplyList = newsMapper.getReplyList(num);
		return newsReplyList;
	}

	@Override
	public int getMaxReplyNum(int news_ref_num) {
		int maxReplyNum = 0;
		NewsMapper newsMapper = sqlSession.getMapper(NewsMapper.class);
		maxReplyNum = newsMapper.getMaxReplyNum(news_ref_num);
		return maxReplyNum;
	}

	@Override
	public void updateStepAndLevel(ReplyVO rvo) {
		NewsMapper newsMapper = sqlSession.getMapper(NewsMapper.class);
		newsMapper.updateStepAndLevel(rvo);
		
	}

	@Override
	public int getReNum(int news_ref_num) {
		int getReNum = 0;
		NewsMapper newsMapper = sqlSession.getMapper(NewsMapper.class);
		getReNum = newsMapper.getReNum(news_ref_num);
		return getReNum;
	}


	@Override
	public ArrayList<NewsVO> getEduNewsList(EduNewsPaginationVO newsPaginationVO) {
		ArrayList<NewsVO> eduNewsList = new ArrayList<NewsVO>();
		NewsMapper newsMapper = sqlSession.getMapper(NewsMapper.class);
		eduNewsList = newsMapper.getEduNewsList(newsPaginationVO);

		return eduNewsList;
	}


	public int getEduCount() {
		NewsMapper newsMapper = sqlSession.getMapper(NewsMapper.class);
		int count = newsMapper.getEduCount();
		return count;
	}


	public int getComCount() {
		NewsMapper newsMapper = sqlSession.getMapper(NewsMapper.class);
		int count = newsMapper.getComCount();
		return count;
	}


	public ArrayList<NewsVO> getComNewsList(ComNewsPaginationVO comNewsPaginationVO) {
		ArrayList<NewsVO> comNewsList = new ArrayList<NewsVO>();
		NewsMapper newsMapper = sqlSession.getMapper(NewsMapper.class);
		comNewsList = newsMapper.getComNewsList(comNewsPaginationVO);

		return comNewsList;
	}


	public int getLeisureCount() {
		NewsMapper newsMapper = sqlSession.getMapper(NewsMapper.class);
		int count = newsMapper.getLeisureCount();
		return count;
	}


	public ArrayList<NewsVO> getLeisureNewsList(LeisureNewsPaginationVO leisureNewsPaginationVO) {
		ArrayList<NewsVO> leisureNewsList = new ArrayList<NewsVO>();
		NewsMapper newsMapper = sqlSession.getMapper(NewsMapper.class);
		leisureNewsList = newsMapper.getLeisureNewsList(leisureNewsPaginationVO);

		return leisureNewsList;
	}


	public int getJobCount() {
		NewsMapper newsMapper = sqlSession.getMapper(NewsMapper.class);
		int count = newsMapper.getJobCount();
		return count;
	}


	public ArrayList<NewsVO> getJobNewsList(JobNewsPaginationVO jobNewsPaginationVO) {
		ArrayList<NewsVO> jobNewsList = new ArrayList<NewsVO>();
		NewsMapper newsMapper = sqlSession.getMapper(NewsMapper.class);
		jobNewsList = newsMapper.getJobNewsList(jobNewsPaginationVO);

		return jobNewsList;
	}


	public int insertKeyword(KeywordVO keywordVO) {
		NewsMapper newsMapper = sqlSession.getMapper(NewsMapper.class);
		int res = newsMapper.insertKeyword(keywordVO);
		return res;
	}


	public List<KeywordVO> getKeywordList(KeywordVO keywordVO) {
		ArrayList<KeywordVO> keywordList = new ArrayList<KeywordVO>();
		NewsMapper newsMapper = sqlSession.getMapper(NewsMapper.class);
		keywordList = newsMapper.getKeywordList(keywordVO);

		return keywordList;
	}


	public ArrayList<NewsVO> getKeyNewsList(KeywordVO keywordVO) {
		ArrayList<NewsVO> keyNewsList = new ArrayList<NewsVO>();
		NewsMapper newsMapper = sqlSession.getMapper(NewsMapper.class);
		keyNewsList = newsMapper.getKeyNewsList(keywordVO);

		return keyNewsList;
	}




}
