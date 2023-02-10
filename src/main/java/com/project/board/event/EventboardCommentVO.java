package com.project.board.event;

import java.util.Date;

public class EventboardCommentVO {

	private int evc_idx;
	private int evc_gup;
	private String evc_content;
	private Date evc_date;
	private String id;
	private String nickname;
	private String del;
	private int reGup;
	private int replyCount;
	private String userImage;
	
	public int getEvc_idx() {
		return evc_idx;
	}
	public void setEvc_idx(int evc_idx) {
		this.evc_idx = evc_idx;
	}
	public int getEvc_gup() {
		return evc_gup;
	}
	public void setEvc_gup(int evc_gup) {
		this.evc_gup = evc_gup;
	}
	public String getEvc_content() {
		return evc_content;
	}
	public void setEvc_content(String evc_content) {
		this.evc_content = evc_content;
	}
	public Date getEvc_date() {
		return evc_date;
	}
	public void setEvc_date(Date evc_date) {
		this.evc_date = evc_date;
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
	public String getDel() {
		return del;
	}
	public void setDel(String del) {
		this.del = del;
	}
	public int getReGup() {
		return reGup;
	}
	public void setReGup(int reGup) {
		this.reGup = reGup;
	}
	public int getReplyCount() {
		return replyCount;
	}
	public void setReplyCount(int replyCount) {
		this.replyCount = replyCount;
	}
	public String getUserImage() {
		return userImage;
	}
	public void setUserImage(String userImage) {
		this.userImage = userImage;
	}
	
	@Override
	public String toString() {
		return "EventboardCommentVO [evc_idx=" + evc_idx + ", evc_gup=" + evc_gup + ", evc_content=" + evc_content
				+ ", evc_date=" + evc_date + ", id=" + id + ", nickname=" + nickname + ", del=" + del + ", reGup="
				+ reGup + ", replyCount=" + replyCount + ", userImage=" + userImage + "]";
	}
	
	
}
