package project.board.free;

import java.util.Date;

public class FreeboardCommentVO {

	private int fbc_idx;
	private int fbc_gup;
	private String fbc_content;
	private Date fbc_date;
	private String id;
	private String nickname;
	
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
	
	@Override
	public String toString() {
		return "FreeboardCommentVO [fbc_idx=" + fbc_idx + ", fbc_gup=" + fbc_gup + ", fbc_content=" + fbc_content
				+ ", fbc_date=" + fbc_date + ", id=" + id + ", nickname=" + nickname + "]";
	}
	
	
}
