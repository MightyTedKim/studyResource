package com.spring.drone.news;

import org.springframework.stereotype.Component;

@Component
public class KeywordVO {
	private String searchId;
	private String searchInput;
	
	public String getSearchId() {
		return searchId;
	}
	public void setSearchId(String searchId) {
		this.searchId = searchId;
	}
	public String getSearchInput() {
		return searchInput;
	}
	public void setSearchInput(String searchInput) {
		this.searchInput = searchInput;
	}
}
