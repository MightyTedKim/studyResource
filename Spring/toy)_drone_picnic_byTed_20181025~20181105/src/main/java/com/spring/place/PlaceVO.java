package com.spring.place;

import java.util.Date;

import org.springframework.stereotype.Component;

@Component
public class PlaceVO {
	
	private int pno;
	private String pname;
	private String pcate;
	private String padd;
	private String pco_x;
	private String pco_y;
	private String pdesc;
	private String uid;
	
	private Date regdate;
	private int viewcnt;
	private int replycnt;
	@Override
	public String toString() {
		return "PlaceVO [pno=" + pno + ", pname=" + pname + ", pcate=" + pcate + ", padd=" + padd + ", pco_x=" + pco_x
				+ ", pco_y=" + pco_y + ", pdesc=" + pdesc + ", uid=" + uid + ", regdate=" + regdate + ", viewcnt="
				+ viewcnt + ", replycnt=" + replycnt + "]";
	}
	public int getPno() {
		return pno;
	}
	public void setPno(int pno) {
		this.pno = pno;
	}
	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	public String getPcate() {
		return pcate;
	}
	public void setPcate(String pcate) {
		this.pcate = pcate;
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
	public String getPdesc() {
		return pdesc;
	}
	public void setPdesc(String pdesc) {
		this.pdesc = pdesc;
	}
	public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
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
