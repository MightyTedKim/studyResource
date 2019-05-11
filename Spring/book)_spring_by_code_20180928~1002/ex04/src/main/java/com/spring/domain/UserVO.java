package com.spring.domain;

public class UserVO {

	private String uid;
	private String upw;
	private String uname;
	
	@Override
	public String toString() {
		return "UserVO [uid=" + uid 
				+ ", upw=" + upw 
				+ ", uname=" + uname 
				+ "]";
	}

	public String getUid() {
		return uid;
	}

	public void setUid(String uid) {
		this.uid = uid;
	}

	public String getUpw() {
		return upw;
	}

	public void setUpw(String upw) {
		this.upw = upw;
	}

	public String getUname() {
		return uname;
	}

	public void setUname(String uname) {
		this.uname = uname;
	}

	
}
