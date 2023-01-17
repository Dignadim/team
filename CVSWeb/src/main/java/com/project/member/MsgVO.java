package com.project.member;

import java.util.Date;
import java.util.List;

public class MsgVO {

	private int msgIdx;
	private String mid;
	private String fid;
	private String msg;
	private Date msgDate;
	private String trash;
	private List<String> list;
	
	public int getMsgIdx() {
		return msgIdx;
	}
	public void setMsgIdx(int msgIdx) {
		this.msgIdx = msgIdx;
	}
	public String getMid() {
		return mid;
	}
	public void setMid(String mid) {
		this.mid = mid;
	}
	public String getFid() {
		return fid;
	}
	public void setFid(String fid) {
		this.fid = fid;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public Date getMsgDate() {
		return msgDate;
	}
	public void setMsgDate(Date msgDate) {
		this.msgDate = msgDate;
	}
	public String getTrash() {
		return trash;
	}
	public void setTrash(String trash) {
		this.trash = trash;
	}
	public List<String> getList() {
		return list;
	}
	public void setList(List<String> list) {
		this.list = list;
	}
	
	@Override
	public String toString() {
		return "MsgVO [msgIdx=" + msgIdx + ", mid=" + mid + ", fid=" + fid + ", msg=" + msg + ", msgDate=" + msgDate
				+ ", trash=" + trash + ", list=" + list + "]";
	}
	
	
}
