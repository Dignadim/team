package project.board.admin;

import java.util.Date;

public class AdminboardVO {

	private int idx;
	private String subject;
	private String nickname;
	private Date writedate;
	
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public Date getWritedate() {
		return writedate;
	}
	public void setWritedate(Date writedate) {
		this.writedate = writedate;
	}
	@Override
	public String toString() {
		return "AdminboardVO [idx=" + idx + ", subject=" + subject + ", nickname=" + nickname + ", writedate="
				+ writedate + "]";
	}
	
	
	
}
