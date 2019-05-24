package com.spring.domain;

public class SearchCriteria{
	private int page;
	private int perPageNum;
	//================	
	private String searchType;
	private String keyword;

//==criteria==============	
	public SearchCriteria() {
		this.page = 1;
		this.perPageNum = 10;
	}
	
	public void setPage(int page) {
		if(page <= 0) {
			this.page =1;
			return;
		}
		this.page = page;
	}

	public int getPage() {
		return page;
	}
	
	public void setPerPageNum(int perPageNum) {
		if(perPageNum <= 0 || perPageNum > 100) {
			this.perPageNum = 10;
			return;
		}
		this.perPageNum = perPageNum;
	}

	//method for Mybatis SQL Mapper
	public int getPageStart() {
		return(this.page -1) * perPageNum;
	}	
	//method for Mybatis SQL Mapper
	public int getPerPageNum() {
		return this.perPageNum;
	}

//==search================================

	
	public String getSearchType() {
		return searchType;
	}
	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	
	@Override
	public String toString() {
		return super.toString() + " SearchCriteria "
				+ "[page=" + page  
				+ "perPageNum=" + perPageNum  
				+ "searchType=" + searchType  
				+ ", [keyword=" + keyword + "]";
	}

}
