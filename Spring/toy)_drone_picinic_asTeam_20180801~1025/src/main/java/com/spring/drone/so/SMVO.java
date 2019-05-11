package com.spring.drone.so;

import org.springframework.stereotype.Component;

@Component
public class SMVO {
	private String sm_num;
	private String sm_id;
	private String sm_nickname;
	
	public String getSm_num() {
		return sm_num;
	}
	public void setSm_num(String sm_num) {
		this.sm_num = sm_num;
	}
	public String getSm_id() {
		return sm_id;
	}
	public void setSm_id(String sm_id) {
		this.sm_id = sm_id;
	}
	public String getSm_nickname() {
		return sm_nickname;
	}
	public void setSm_nickname(String sm_nickname) {
		this.sm_nickname = sm_nickname;
	}
}
