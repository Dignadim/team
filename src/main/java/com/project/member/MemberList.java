package com.project.member;

import java.util.ArrayList;

public class MemberList {

	private ArrayList<MemberVO> list = new ArrayList<MemberVO>();
	private String msg;
	
	public ArrayList<MemberVO> getList() {
		return list;
	}

	public void setList(ArrayList<MemberVO> list) {
		this.list = list;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}
	
	@Override
	public String toString() {
		return "MemberList [list=" + list + ", msg=" + msg + "]";
	}
	
	
}
