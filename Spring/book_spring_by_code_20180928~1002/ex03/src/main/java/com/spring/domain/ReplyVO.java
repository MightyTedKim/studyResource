package com.spring.domain;

import java.util.Date;

public class ReplyVO {
	private int rno;
	private int bno;
	private String replytext;
	private String replyer;
	
	private Date regDate;
	private Date updateDate;
	

	
	public int getRno() {
		return rno;
	}



	public void setRno(int rno) {
		this.rno = rno;
	}



	public int getBno() {
		return bno;
	}



	public void setBno(int bno) {
		this.bno = bno;
	}


	public String getReplytext() {
		return replytext;
	}

	public void setReplytext(String replytext) {
		this.replytext = replytext;
	}


	public String getReplyer() {
		return replyer;
	}



	public void setReplyer(String replyer) {
		this.replyer = replyer;
	}



	public Date getRegDate() {
		return regDate;
	}



	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}



	public Date getUpdateDate() {
		return updateDate;
	}



	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}



	@Override
	public String toString() {
		return "BoardVO [rno=" + rno 
				+ ", bno=" + bno 
				+ ", replyText=" + replytext 
				+ ", replyer=" + replyer 
				+ ", regDate=" + regDate 
				+ ", updateDate=" + updateDate
				+ "]";
	}
	
}
