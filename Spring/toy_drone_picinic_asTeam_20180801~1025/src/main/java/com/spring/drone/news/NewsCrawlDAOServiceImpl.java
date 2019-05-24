package com.spring.drone.news;

import java.io.IOException;
import java.util.ArrayList;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

public class NewsCrawlDAOServiceImpl implements NewsCrawlDAOService{

	@Override
	public ArrayList<CrawlNewsVO> crawlNews() {
		String BASE_URL_F = "https://search.naver.com/search.naver?&where=news&query=%EB%93%9C%EB%A1%A0&sm=tab_pge&sort=1&photo=0&field=1&reporter_article=&pd=0&ds=&de=&docid=&nso=so:dd,p:all,a:t&mynews=0&start=";
		int BASE_URL_PAGE = 1;
		String BASE_URL_B = "&refresh_start=0";
		String COMPLETE_URL = BASE_URL_F + BASE_URL_PAGE + BASE_URL_B;
		CrawlNewsVO crawlNewsVO = null;
		ArrayList<CrawlNewsVO> list = new ArrayList<CrawlNewsVO>();
		
		int page = 1;
		while (page <= 500) {
		Document naver_news;
		try {
			naver_news = Jsoup.connect(COMPLETE_URL)
			.header("Accept", "text/html, application/xhtml+xml, image/jxr, */*")
			.header("User-Agent", "Mozilla/5.0 (Windows NT 10.0; WOW64; Trident/7.0; rv:11.0) like Gecko")
			.header("Accept-Encoding", "gzip, deflate").header("Accept-Language", "ko-KR")
			.header("Connection", "Keep-Alive").get();
		
		
		for (int i = page;i < page + 10;i++) {
			crawlNewsVO = new CrawlNewsVO();
			Elements news_div1 = naver_news.select("li#sp_nws" + i + " dl dt a[href]");
			
			String url = news_div1.attr("href");
			
			System.out.println(url);
			crawlNewsVO.urlVO = url;
			System.out.println(crawlNewsVO.urlVO);
			String title = news_div1.attr("title");
			crawlNewsVO.titleVO = title;
			System.out.println(title);
			System.out.println(crawlNewsVO.titleVO);
			Elements news_div2 = naver_news.select("li#sp_nws" + i + " dl dd:eq(1) span._sp_each_source");
			String source = news_div2.text();
			crawlNewsVO.sourceVO = source;
			Elements news_div3 = naver_news.select("li#sp_nws" + i + " dl dd:eq(2)");
			String body = news_div3.text();
			crawlNewsVO.bodyVO = body;
			list.add(crawlNewsVO);
		}
		
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		System.out.println("占쏙옙占쏙옙占쏙옙 : " + page + "=====================");
		page = page + 10;
		BASE_URL_PAGE = page;
		COMPLETE_URL = BASE_URL_F + BASE_URL_PAGE + BASE_URL_B;
		}
		//System.out.println(list);
		for (int i =0;i<list.size();i++) {
			System.out.println("�겕濡ㅼ꽌鍮꾩뒪�뿉�꽌 �떞�� 怨쇱젙 = " + list.get(i).titleVO);
		}
		
		return list;
	}
}
