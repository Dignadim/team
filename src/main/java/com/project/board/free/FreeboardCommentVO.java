package com.project.board.free;

import java.util.Date;

public class FreeboardCommentVO {

	private int fbc_idx;
	private int fbc_gup;
	private String fbc_content;
	private Date fbc_date;
	private String id;
	private String nickname;
	private int reGup; // 리플을 달 댓글의 번호
	private String del; // 댓글 삭제 시 y, 삭제한 댓글이 아니면 n
	private int replyCount; // 대댓글 개수
	private String userImage;
	
	public int getFbc_idx() {
		return fbc_idx;
	}
	public void setFbc_idx(int fbc_idx) {
		this.fbc_idx = fbc_idx;
	}
	public int getFbc_gup() {
		return fbc_gup;
	}
	public void setFbc_gup(int fbc_gup) {
		this.fbc_gup = fbc_gup;
	}
	public String getFbc_content() {
		return fbc_content;
	}
	public void setFbc_content(String fbc_content) {
		this.fbc_content = fbc_content;
	}
	public Date getFbc_date() {
		return fbc_date;
	}
	public void setFbc_date(Date fbc_date) {
		this.fbc_date = fbc_date;
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
	public int getReGup() {
		return reGup;
	}
	public void setReGup(int reGup) {
		this.reGup = reGup;
	}
	public String getDel() {
		return del;
	}
	public void setDel(String del) {
		this.del = del;
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
		return "FreeboardCommentVO [fbc_idx=" + fbc_idx + ", fbc_gup=" + fbc_gup + ", fbc_content=" + fbc_content
				+ ", fbc_date=" + fbc_date + ", id=" + id + ", nickname=" + nickname + ", reGup=" + reGup + ", del="
				+ del + ", replyCount=" + replyCount + ", userImage=" + userImage + "]";
	}
	
	
}
