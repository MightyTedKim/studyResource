package com.spring.common.search;

import com.spring.common.pagination.Criteria;

public class SearchCriteria extends Criteria{

	private String searchType;
	private String keyword;
	
	@Override
	public String toString() {
		return super.toString() 
				+ " <SearchCriteria>["
				+ "searchType = " + searchType + "," 
				+ "keyword = " + keyword + "]";
	}
	
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
	
}


