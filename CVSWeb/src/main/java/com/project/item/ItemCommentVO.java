package com.project.item;

import java.util.Date;

public class ItemCommentVO {

	private int idx;
	private int gup;
	private String ID;
	private String nickname;
	private String content;
	private Date writeDate;
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public int getGup() {
		return gup;
	}
	public void setGup(int gup) {
		this.gup = gup;
	}
	public String getID() {
		return ID;
	}
	public void setID(String iD) {
		ID = iD;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getWriteDate() {
		return writeDate;
	}
	public void setWriteDate(Date writeDate) {
		this.writeDate = writeDate;
	}
	
	@Override
	public String toString() {
		return "ItemCommentVO [idx=" + idx + ", gup=" + gup + ", ID=" + ID + ", nickname=" + nickname + ", content=" + content + ", writeDate=" + writeDate + "]";
	}	
	
}
