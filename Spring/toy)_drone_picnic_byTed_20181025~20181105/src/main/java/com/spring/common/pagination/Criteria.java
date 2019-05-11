package com.spring.common.pagination;

public class Criteria{
	private int page;
	private int perPageNum;

	//constructor	
	public Criteria() {
		this.page = 1;
		this.perPageNum = 10;
	}
	
	public String toString() {
		return "<Criteria>["
				+ "page=" + page + ","
				+ "perPageNum=" + perPageNum + 
				"]";
	}

	//page
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
	
	//perPageNum	
	public void setPerPageNum(int perPageNum) {
		if(perPageNum <= 0 || perPageNum > 100) {
			this.perPageNum = 10;
			return;
		}
		this.perPageNum = perPageNum;
	}
	
	public int getPerPageNum() {
		return this.perPageNum;
	}
	
	//+ method for Mybatis SQL Mapper
	public int getPageStart() {
		System.out.println("pageStart");
		return(this.page -1) * perPageNum;
	}	


}
