package com.project.item;

import java.util.ArrayList;

public class MyItemList {
	
	ArrayList<MyItemVO> list = new ArrayList<MyItemVO>();

	public MyItemList() {
		// TODO Auto-generated constructor stub
	}

	public MyItemList(ArrayList<MyItemVO> list) {
		super();
		this.list = list;
	}

	public ArrayList<MyItemVO> getList() {
		return list;
	}

	public void setList(ArrayList<MyItemVO> list) {
		this.list = list;
	}

	@Override
	public String toString() {
		return "MyItemList [list=" + list + "]";
	}
	
}
