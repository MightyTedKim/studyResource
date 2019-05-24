package com.spring.drone.df;

import org.springframework.stereotype.Component;

@Component
public class DroneVO {
	private String pnum;
	private String elevel;
	private String rc;
	private int speed;
	private int weight;
	private String power;
	private String battery;
	private int capacity;
	private int runningtime;
	private String remocon;
	private int frequency;
	private int distance;
	private int camera;
	private String volume;
	
	public String getElevel() {
		return elevel;
	}
	public void setElevel(String elevel) {
		this.elevel = elevel;
	}
	public String getRc() {
		return rc;
	}
	public void setRc(String rc) {
		this.rc = rc;
	}
	public int getSpeed() {
		return speed;
	}
	public void setSpeed(int speed) {
		this.speed = speed;
	}
	public int getWeight() {
		return weight;
	}
	public void setWeight(int weight) {
		this.weight = weight;
	}
	public String getPower() {
		return power;
	}
	public void setPower(String power) {
		this.power = power;
	}
	public String getBattery() {
		return battery;
	}
	public void setBattery(String battery) {
		this.battery = battery;
	}
	public int getCapacity() {
		return capacity;
	}
	public void setCapacity(int capacity) {
		this.capacity = capacity;
	}
	public int getRunningtime() {
		return runningtime;
	}
	public void setRunningtime(int runningtime) {
		this.runningtime = runningtime;
	}
	public String getRemocon() {
		return remocon;
	}
	public void setRemocon(String remocon) {
		this.remocon = remocon;
	}
	public int getFrequency() {
		return frequency;
	}
	public void setFrequency(int frequency) {
		this.frequency = frequency;
	}
	public int getDistance() {
		return distance;
	}
	public void setDistance(int distance) {
		this.distance = distance;
	}
	public int getCamera() {
		return camera;
	}
	public void setCamera(int camera) {
		this.camera = camera;
	}
	public String getVolume() {
		return volume;
	}
	public void setVolume(String volume) {
		this.volume = volume;
	}
	public String getPnum() {
		return pnum;
	}
	public void setPnum(String pnum) {
		this.pnum = pnum;
	}
	
}
