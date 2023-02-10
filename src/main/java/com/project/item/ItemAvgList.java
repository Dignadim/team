package com.project.item;

import java.util.ArrayList;

public class ItemAvgList {

	private ArrayList<ItemAvgVO> list = new ArrayList<ItemAvgVO>();

	public ArrayList<ItemAvgVO> getList() {
		return list;
	}

	public void setList(ArrayList<ItemAvgVO> list) {
		this.list = list;
	}

	@Override
	public String toString() {
		return "ItemAvgList [list=" + list + "]";
	}
	
	
	
}
