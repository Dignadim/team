package com.project.member;

import java.util.ArrayList;

public class MsgList {

	private ArrayList<MsgVO> list = new ArrayList<MsgVO>();

	public ArrayList<MsgVO> getList() {
		return list;
	}

	public void setList(ArrayList<MsgVO> list) {
		this.list = list;
	}

	@Override
	public String toString() {
		return "MsgList [list=" + list + "]";
	}

}
