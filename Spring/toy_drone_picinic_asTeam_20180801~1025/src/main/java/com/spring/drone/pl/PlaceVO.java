package com.spring.drone.pl;

import org.springframework.stereotype.Component;

@Component
public class PlaceVO {
	/*	
	CREATE TABLE Place (
		Place_Coord VARCHAR2(40 BYTE), 
		Place_Add VARCHAR2(40 BYTE) NOT NULL,
		Place_Name VARCHAR2(40 BYTE),
		Place_Desc VARCHAR2(40 BYTE),
		Place_Cate VARCHAR2(40 BYTE),
		User_Id VARCHAR2(40 BYTE) 
	);
	 */
	private String Place_Coord;
	private String Place_Add;
	private String Place_Name;
	private String Place_Desc;
	private String Place_Cate;
	private String User_Id;
	
	
	public String getPlace_Coord() {
		return Place_Coord;
	}
	public void setPlace_Coord(String place_Coord) {
		Place_Coord = place_Coord;
	}
	public String getPlace_Add() {
		return Place_Add;
	}
	public void setPlace_Add(String place_Add) {
		Place_Add = place_Add;
	}
	public String getPlace_Name() {
		return Place_Name;
	}
	public void setPlace_Name(String place_Name) {
		Place_Name = place_Name;
	}
	public String getPlace_Desc() {
		return Place_Desc;
	}
	public void setPlace_Desc(String place_Desc) {
		Place_Desc = place_Desc;
	}
	public String getPlace_Cate() {
		return Place_Cate;
	}
	public void setPlace_Cate(String place_Cate) {
		Place_Cate = place_Cate;
	}
	public String getUser_Id() {
		return User_Id;
	}
	public void setUser_Id(String user_Id) {
		User_Id = user_Id;
	}

	
	
}
