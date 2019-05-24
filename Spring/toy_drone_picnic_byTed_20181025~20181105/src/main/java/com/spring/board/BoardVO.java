package com.spring.board;

import java.util.Date;

public class BoardVO {

	private int bno;
	private String title;
	private String content;
	private String writer;
	private Date regdate;
	private int viewcnt;
	private int replycnt;

	private String[] files;
	
	@Override
	public String toString() {
		return "BoardVO [bno=" + bno 
				+ ", title=" + title
				+ ", content=" + content 
				+ ", writer=" + writer
				+ ", regdate=" + regdate 
				+ ", viewcnt=" + viewcnt
				+ ", replycnt=" + replycnt
				+ ", files=" + files
				+ "]";
	}

	public String[] getFiles() {
		return files;
	}
	public void setFiles(String[] files) {
		this.files = files;
	}
	public int getBno() {
		return bno;
	}


	public void setBno(int bno) {
		this.bno = bno;
	}


	public String getTitle() {
		return title;
	}


	public void setTitle(String title) {
		this.title = title;
	}


	public String getContent() {
		return content;
	}


	public void setContent(String content) {
		this.content = content;
	}


	public String getWriter() {
		return writer;
	}


	public void setWriter(String writer) {
		this.writer = writer;
	}


	public Date getRegdate() {
		return regdate;
	}


	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}


	public int getViewcnt() {
		return viewcnt;
	}


	public void setViewcnt(int viewcnt) {
		this.viewcnt = viewcnt;
	}


	public int getReplycnt() {
		return replycnt;
	}


	public void setReplycnt(int replycnt) {
		this.replycnt = replycnt;
	}

	

}
