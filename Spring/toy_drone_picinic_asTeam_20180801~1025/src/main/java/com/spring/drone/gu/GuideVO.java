package com.spring.drone.gu;

import java.util.Date;

import org.springframework.stereotype.Component;

@Component
public class GuideVO {
	
	private int num;
	private String id;
	private String nickname;
	private String title;
	private String body;
	private String photourlpath;
	private String photofilename;
	private String photoname;
	private String photosize;
	private Date pdate;
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getBody() {
		return body;
	}
	public void setBody(String body) {
		this.body = body;
	}
	public String getPhotourlpath() {
		return photourlpath;
	}
	public void setPhotourlpath(String photourlpath) {
		this.photourlpath = photourlpath;
	}
	public String getPhotofilename() {
		return photofilename;
	}
	public void setPhotofilename(String photofilename) {
		this.photofilename = photofilename;
	}
	public String getPhotoname() {
		return photoname;
	}
	public void setPhotoname(String photoname) {
		this.photoname = photoname;
	}
	public String getPhotosize() {
		return photosize;
	}
	public void setPhotosize(String photosize) {
		this.photosize = photosize;
	}
	public Date getPdate() {
		return pdate;
	}
	public void setPdate(Date pdate) {
		this.pdate = pdate;
	}


	
	
}
