package com.spring.domain;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

public class PageMaker {
	private int totalCount;
	private int startPage;
	private int endPage;
	private boolean prev;
	private boolean next;
	private int displayPageNum = 10;
	private Criteria cri;

	public void setCri(Criteria cri) {
		this.cri = cri;
	}
	// total count 시행되는 시점에서, calcData 실행
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		calcData();
	}
	
	private void calcData() {
		endPage = (int) (Math.ceil(cri.getPage() / (double) displayPageNum) * displayPageNum);
		startPage = (endPage - displayPageNum) + 1;
		int tempEndPage = (int) (Math.ceil(totalCount / (double) cri.getPerPageNum() ));
		
		if(endPage > tempEndPage) {
			endPage = tempEndPage;
		}
		prev = startPage == 1 ? false : true;
		next = endPage * cri.getPerPageNum() >= totalCount ? false : true;
		}
	
		//
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
	
		public int getTotalCount() {
			return totalCount;
		}
	
		public Criteria getCri() {
			return cri;
		}
		
		@Override
		public String toString() {
			return "PageMaker ["
					+ "totalCount=" + totalCount + "," 
					+ "startPage=" + startPage + "," 
					+ "endPage=" + endPage + "," 
					+ "prev=" + prev + "," 
					+ "next=" + next + "]";
		}
		
		public String makeQuery(int page) {
			System.out.println(">makeQuery");
			UriComponents uriComponents =   
					UriComponentsBuilder.newInstance()
					.queryParam("page", page)
					.queryParam("perPageNum", cri.getPerPageNum())
					.build();
			return uriComponents.toUriString();
		}
		
		public String makeSearch(int page) {
			System.out.println(">makeSearch");
			UriComponents uriComponents =   
				UriComponentsBuilder.newInstance()
				.queryParam("page", page)
				.queryParam("perPageNum", cri.getPerPageNum())
				.queryParam("searchType", ( (SearchCriteria) cri).getSearchType())
				.queryParam("keyword", encoding( ((SearchCriteria) cri) .getKeyword() )  )
				.build();
			System.out.println("makeSearch, uriComponents.toUriString() = " + uriComponents.toUriString());

			return uriComponents.toUriString();
		}
		
		public String encoding(String keyword) {
			System.out.println("인코딩");
			if(keyword == null || keyword.trim().length() == 0) {
				return "";
			}
			try {
				return URLEncoder.encode(keyword,  "utf-8");
			} catch(UnsupportedEncodingException e) {
				return "";
			}
		}
}

