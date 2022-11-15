package project.board.event;

import java.util.Date;

public class EventboardCommentVO {

	private int evc_idx;
	private int evc_gup;
	private String evc_content;
	private Date evc_date;
	
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
	
	@Override
	public String toString() {
		return "EventboardCommentVO [evc_idx=" + evc_idx + ", evc_gup=" + evc_gup + ", evc_content=" + evc_content
				+ ", evc_date=" + evc_date + "]";
	}
	
	
}
