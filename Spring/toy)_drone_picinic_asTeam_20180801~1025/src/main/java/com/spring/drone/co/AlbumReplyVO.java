package com.spring.drone.co;

import java.util.Date;

import org.springframework.stereotype.Component;

@Component
public class AlbumReplyVO {
	private int ref_num;
	private int renum;
	private int ref;
	private int re_level;
	private int re_step;
	private String reid;
	private String renickname;
	private String rebody;
	private Date pdate;
	
	public int getRef_num() {
		return ref_num;
	}
	public void setRef_num(int ref_num) {
		this.ref_num = ref_num;
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

	public Date getPdate() {
		return pdate;
	}
	public void setPdate(Date pdate) {
		this.pdate = pdate;
	}
	public String getReid() {
		return reid;
	}
	public void setReid(String reid) {
		this.reid = reid;
	}
	public String getRenickname() {
		return renickname;
	}
	public void setRenickname(String renickname) {
		this.renickname = renickname;
	}
	public String getRebody() {
		return rebody;
	}
	public void setRebody(String rebody) {
		this.rebody = rebody;
	}
}
