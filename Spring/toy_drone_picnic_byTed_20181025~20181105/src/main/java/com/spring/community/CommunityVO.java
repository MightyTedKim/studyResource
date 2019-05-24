package com.spring.community;

import java.util.Arrays;
import java.util.Date;


public class CommunityVO {

	private int cno;
	private String cname;
	private String cdesc;
	private String uid;
	
	private String padd;
	private String pco_x;
	private String pco_y;	
	
	private Date regdate;
	private int viewcnt;
	private int replycnt;

	private String[] members;	
	private String[] files;
	
	@Override
	public String toString() {
		return "CommunityVO [cno=" + cno + ", cname=" + cname + ", cdesc=" + cdesc + ", uid=" + uid + ", padd=" + padd
				+ ", pco_x=" + pco_x + ", pco_y=" + pco_y + ", regdate=" + regdate + ", viewcnt=" + viewcnt
				+ ", replycnt=" + replycnt + ", members=" + Arrays.toString(members) + ", files="
				+ Arrays.toString(files) + "]";
	}

	public int getCno() {
		return cno;
	}

	public void setCno(int cno) {
		this.cno = cno;
	}

	public String getCname() {
		return cname;
	}

	public void setCname(String cname) {
		this.cname = cname;
	}

	public String getCdesc() {
		return cdesc;
	}

	public void setCdesc(String cdesc) {
		this.cdesc = cdesc;
	}

	public String getUid() {
		return uid;
	}

	public void setUid(String uid) {
		this.uid = uid;
	}

	public String getPadd() {
		return padd;
	}

	public void setPadd(String padd) {
		this.padd = padd;
	}

	public String getPco_x() {
		return pco_x;
	}

	public void setPco_x(String pco_x) {
		this.pco_x = pco_x;
	}

	public String getPco_y() {
		return pco_y;
	}

	public void setPco_y(String pco_y) {
		this.pco_y = pco_y;
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

	public String[] getMembers() {
		return members;
	}

	public void setMembers(String[] members) {
		this.members = members;
	}

	public String[] getFiles() {
		return files;
	}

	public void setFiles(String[] files) {
		this.files = files;
	}
	
}
