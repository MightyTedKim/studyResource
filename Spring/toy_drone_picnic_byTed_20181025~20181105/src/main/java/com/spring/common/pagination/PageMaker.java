package com.spring.common.pagination;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

import com.spring.common.search.SearchCriteria;

public class PageMaker {
	private int totalCount;
	private int startPage;
	private int endPage;
	private boolean prev;
	private boolean next;
	private int displayPageNum = 10;

	private Criteria cri;

	@Override
	public String toString() {
		return "<PageMaker>["
				+ "totalCount=" + totalCount + "," 
				+ "startPage=" + startPage + "," 
				+ "endPage=" + endPage + "," 
				+ "prev=" + prev + "," 
				+ "next=" + next + ","
				+ "displayPageNum=" + displayPageNum + ","
				+ "cri=" + cri + 
				"]";
	}
	//query making for normal list
	public String makeQuery(int page) {
		UriComponents uriComponents =   
				UriComponentsBuilder.newInstance()
				.queryParam("page", page)
				.queryParam("perPageNum", cri.getPerPageNum())
				.build();
		return uriComponents.toUriString();
	}
	//query making for normal list + search value
	public String makeSearch(int page) {
		UriComponents uriComponents =   
			UriComponentsBuilder.newInstance()
			.queryParam("page", page)
			.queryParam("perPageNum", cri.getPerPageNum())
			.queryParam("searchType", ( (SearchCriteria) cri).getSearchType())
			.queryParam("keyword", encoding( ((SearchCriteria) cri) .getKeyword() )  )
			.build();
		return uriComponents.toUriString();
	}
	//encoding for keyword
	public String encoding(String keyword) {
		if(keyword == null || keyword.trim().length() == 0) {
			return "";
		}
		try {
			return URLEncoder.encode(keyword,  "utf-8");
		} catch(UnsupportedEncodingException e) {
			return "";
		}
	}
	// total count 시행되는 시점에서, calcData 실행
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		calcData();
	}
	
	private void calcData() {
		//start, end
		endPage = (int) (Math.ceil(cri.getPage() / (double) displayPageNum) * displayPageNum);
		startPage = (endPage - displayPageNum) + 1;

		//endPage redefine for 'next' value
		int tempEndPage = (int) (Math.ceil(totalCount / (double) cri.getPerPageNum() ));		
		if(endPage > tempEndPage) {
			endPage = tempEndPage;
		}

		// < >
		prev = startPage == 1 ? false : true;
		next = endPage * cri.getPerPageNum() >= totalCount ? false : true;
	}

	
	//getter, setter auto
	public int getStartPage() {
		return startPage;
	}


	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}


	public int getEndPage() {
		return endPage;
	}


	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}


	public boolean isPrev() {
		return prev;
	}


	public void setPrev(boolean prev) {
		this.prev = prev;
	}


	public boolean isNext() {
		return next;
	}


	public void setNext(boolean next) {
		this.next = next;
	}


	public int getDisplayPageNum() {
		return displayPageNum;
	}


	public void setDisplayPageNum(int displayPageNum) {
		this.displayPageNum = displayPageNum;
	}


	public Criteria getCri() {
		return cri;
	}


	public void setCri(Criteria cri) {
		this.cri = cri;
	}


	public int getTotalCount() {
		return totalCount;
	}

	
}

