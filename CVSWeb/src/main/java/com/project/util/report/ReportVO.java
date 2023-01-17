package com.project.util.report;

import java.util.Date;

public class ReportVO {
	
	private int report_idx; // 신고할 게시글, 혹은 댓글의 idx
	private String report_reason; // 신고 사유
	private String report_comment; // 구체적인 내용 (필수 x)
	private Date report_date; // 신고 날짜
	private String report_id; // 신고자 아이디
	private String report_subject; // 신고 글 제목
	private String report_location;
	
	public int getReport_idx() {
		return report_idx;
	}
	public void setReport_idx(int report_idx) {
		this.report_idx = report_idx;
	}
	public String getReport_reason() {
		return report_reason;
	}
	public void setReport_reason(String report_reason) {
		this.report_reason = report_reason;
	}
	public String getReport_comment() {
		return report_comment;
	}
	public void setReport_comment(String report_comment) {
		this.report_comment = report_comment;
	}
	public Date getReport_date() {
		return report_date;
	}
	public void setReport_date(Date report_date) {
		this.report_date = report_date;
	}
	public String getReport_id() {
		return report_id;
	}
	public void setReport_id(String report_id) {
		this.report_id = report_id;
	}
	public String getReport_subject() {
		return report_subject;
	}
	public void setReport_subject(String report_subject) {
		this.report_subject = report_subject;
	}
	public String getReport_location() {
		return report_location;
	}
	public void setReport_location(String report_location) {
		this.report_location = report_location;
	}
	
	@Override
	public String toString() {
		return "ReportVO [report_idx=" + report_idx + ", report_reason=" + report_reason + ", report_comment="
				+ report_comment + ", report_date=" + report_date + ", report_id=" + report_id + ", report_subject="
				+ report_subject + ", report_location=" + report_location + "]";
	}
	

}
