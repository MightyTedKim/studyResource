package com.spring.drone.news;

import java.io.IOException;
import java.util.ArrayList;

public interface NewsCrawlDAOService {
	ArrayList<CrawlNewsVO> crawlNews() throws IOException;
	
}
