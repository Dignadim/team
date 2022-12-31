package com.project.board.free;

import java.util.Date;

public class FreeboardVO {

	private int fb_idx;
	private String fb_subject;
	private String fb_content;
	private Date fb_date;
	private int fb_hit;
	private String fb_notice="no";
	private int fb_commentCount;
	private String id;
	private String nickname;
	
	public int getFb_idx() {
		return fb_idx;
	}
	public void setFb_idx(int fb_idx) {
		this.fb_idx = fb_idx;
	}
	public String getFb_subject() {
		return fb_subject;
	}
	public void setFb_subject(String fb_subject) {
		this.fb_subject = fb_subject;
	}
	public String getFb_content() {
		return fb_content;
	}
	public void setFb_content(String fb_content) {
		this.fb_content = fb_content;
	}
	public Date getFb_date() {
		return fb_date;
	}
	public void setFb_date(Date fb_date) {
		this.fb_date = fb_date;
	}
	public int getFb_hit() {
		return fb_hit;
	}
	public void setFb_hit(int fb_hit) {
		this.fb_hit = fb_hit;
	}
	public String getFb_notice() {
		return fb_notice;
	}
	public void setFb_notice(String fb_notice) {
		this.fb_notice = fb_notice;
	}
	public int getFb_commentCount() {
		return fb_commentCount;
	}
	public void setFb_commentCount(int fb_commentCount) {
		this.fb_commentCount = fb_commentCount;
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
	
	@Override
	public String toString() {
		return "FreeboardVO [fb_idx=" + fb_idx + ", fb_subject=" + fb_subject + ", fb_content=" + fb_content
				+ ", fb_date=" + fb_date + ", fb_hit=" + fb_hit + ", fb_notice=" + fb_notice + ", fb_commentCount="
				+ fb_commentCount + ", id=" + id + ", nickname=" + nickname + "]";
	}
	
	
	
}
