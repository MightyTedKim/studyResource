package com.spring.drone.news;

import java.util.Date;

import org.springframework.stereotype.Component;

import com.fasterxml.jackson.annotation.JsonFormat;

@Component
public class ReplyVO {
	
	private int news_ref_num;
	private int renum;
	private int ref;
	private int re_level;
	private int re_step;
	private String replyid;
	private String replybody;
	private Date pdate;
	
	public int getNews_ref_num() {
		return news_ref_num;
	}
	public void setNews_ref_num(int news_ref_num) {
		this.news_ref_num = news_ref_num;
	}
	public int getRenum() {
		return renum;
	}
	public void setRenum(int renum) {
		this.renum = renum;
	}
	public int getRef() {
		return ref;
	}
	public void setRef(int ref) {
		this.ref = ref;
	}
	public int getRe_level() {
		return re_level;
	}
	public void setRe_level(int re_level) {
		this.re_level = re_level;
	}
	public int getRe_step() {
		return re_step;
	}
	public void setRe_step(int re_step) {
		this.re_step = re_step;
	}
	public String getReplyid() {
		return replyid;
	}
	public void setReplyid(String replyid) {
		this.replyid = replyid;
	}
	public String getReplybody() {
		return replybody;
	}
	public void setReplybody(String replybody) {
		this.replybody = replybody;
	}
	public Date getPdate() {
		return pdate;
	}
	public void setPdate(Date pdate) {
		this.pdate = pdate;
	}


}
