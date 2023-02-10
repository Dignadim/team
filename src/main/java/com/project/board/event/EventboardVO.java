package com.project.board.event;

import java.util.Date;

public class EventboardVO {

	private int ev_idx;
	private String ev_sellcvs;
	private String ev_subject;
	private String ev_content;
	private int ev_hit;
	private Date ev_date;
	private String ev_notice;
	private String ev_filename;
	private int ev_commentCount;
	private String id;
	private String nickname;
	
	public int getEv_idx() {
		return ev_idx;
	}
	public void setEv_idx(int ev_idx) {
		this.ev_idx = ev_idx;
	}
	public String getEv_sellcvs() {
		return ev_sellcvs;
	}
	public void setEv_sellcvs(String ev_sellcvs) {
		this.ev_sellcvs = ev_sellcvs;
	}
	public String getEv_subject() {
		return ev_subject;
	}
	public void setEv_subject(String ev_subject) {
		this.ev_subject = ev_subject;
	}
	public String getEv_content() {
		return ev_content;
	}
	public void setEv_content(String ev_content) {
		this.ev_content = ev_content;
	}
	public int getEv_hit() {
		return ev_hit;
	}
	public void setEv_hit(int ev_hit) {
		this.ev_hit = ev_hit;
	}
	public Date getEv_date() {
		return ev_date;
	}
	public void setEv_date(Date ev_date) {
		this.ev_date = ev_date;
	}
	public String getEv_notice() {
		return ev_notice;
	}
	public void setEv_notice(String ev_notice) {
		this.ev_notice = ev_notice;
	}
	public String getEv_filename() {
		return ev_filename;
	}
	public void setEv_filename(String ev_filename) {
		this.ev_filename = ev_filename;
	}
	public int getEv_commentCount() {
		return ev_commentCount;
	}
	public void setEv_commentCount(int ev_commentCount) {
		this.ev_commentCount = ev_commentCount;
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
		return "EventboardVO [ev_idx=" + ev_idx + ", ev_sellcvs=" + ev_sellcvs + ", ev_subject=" + ev_subject
				+ ", ev_content=" + ev_content + ", ev_hit=" + ev_hit + ", ev_date=" + ev_date + ", ev_notice="
				+ ev_notice + ", ev_filename=" + ev_filename + ", ev_commentCount=" + ev_commentCount + ", id=" + id
				+ ", nickname=" + nickname + "]";
	}
	
}
