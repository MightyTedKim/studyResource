package com.spring.drone.news;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

public interface NewsMapper { 
	ArrayList<NewsVO> getNewsList(@Param("startRow") int startRow, @Param("endRow") int endRow);
	NewsVO getNews(int num);
	int insertNews(NewsVO news);
	int insertReply(ReplyVO replyVO);
	List<ReplyVO> getReplyList(int num);
	void updateNews(NewsVO news);
	void deleteNews(int num);
	int getCount();
	void addReadcount(@Param("num") int num, @Param("readcount") int readcount);
	int getMaxReplyNum(int news_ref_num);
	void updateStepAndLevel(ReplyVO rvo);
	int getReNum(int news_ref_num);
	ArrayList<NewsVO> getEduNewsList(EduNewsPaginationVO newsPaginationVO);
	int getEduCount();
	int getComCount();
	ArrayList<NewsVO> getComNewsList(ComNewsPaginationVO comNewsPaginationVO);
	int getLeisureCount();
	ArrayList<NewsVO> getLeisureNewsList(LeisureNewsPaginationVO leisureNewsPaginationVO);
	int getJobCount();
	ArrayList<NewsVO> getJobNewsList(JobNewsPaginationVO jobNewsPaginationVO);
	int insertKeyword(KeywordVO keywordVO);
	ArrayList<KeywordVO> getKeywordList(KeywordVO keywordVO);
	ArrayList<NewsVO> getKeyNewsList(KeywordVO keywordVO);
}
