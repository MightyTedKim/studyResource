package com.spring.login;

public class LoginDTO {
	private String uid;
	private String upw;
	private Boolean useCookie;
	
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
	public Boolean isUseCookie() {
		return useCookie;
	}
	public void setUseCookie(Boolean useCookie) {
		this.useCookie = useCookie;
	}
	@Override
	public String toString() {
		return "LoginDTO [uid=" + uid + ", upw=" + upw + ", useCookie=" + useCookie + "]";
	}
	
	
	
}
