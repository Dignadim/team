package com.project.item;

import java.util.ArrayList;

public class ItemCommentList {

	private ArrayList<ItemVO> list = new ArrayList<>();

	public ArrayList<ItemVO> getList() {
		return list;
	}
	public void setList(ArrayList<ItemVO> list) {
		this.list = list;
	}
	
	@Override
	public String toString() {
		return "ItemCommentList [list=" + list + "]";
	}
		
}
